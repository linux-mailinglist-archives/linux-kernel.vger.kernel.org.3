Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473734BDD42
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377142AbiBUN5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:57:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiBUN53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:57:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7B12AD2;
        Mon, 21 Feb 2022 05:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/vlaobnOU3Y8GOboBhNkbHOyX0LyfcK1Yn+Xny/caU=; b=JacIcYdjZ8Px8qAYVx2kmrmMmt
        B+WLwEgOpCYgSEVX9km+Xw3/f/yLlJch96SDmAig6bz9z03l2PL29wWkmrTA0GoQrwCv1izH4mtRa
        uhAjiu5Vg/x9HPxacefvG+qITJOMn41OPu/j3Otl+sJ7ohykfHCJuBrGwo8Dd7kfdcDfhUFOE8Sez
        HzvPei/pJOTlXUV+Uk4PlQHfdAHUmguYwd3RUUoC6l0TzRBd4Xz4UTKoTF9WnX0pmt6U1EjkqbPGb
        iNSRvRQx2AhuIrnrnVYuKwt8SZx7ZubxI9jjegE9gIXm6YCIkO2n2CMAAbuksfIFClqSK4NW2Hfd2
        2X/0FnrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nM9BP-001stF-Jr; Mon, 21 Feb 2022 13:56:55 +0000
Date:   Mon, 21 Feb 2022 13:56:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [mm/readahead]  a0b99df1aa: xfstests.xfs.421.fail
Message-ID: <YhOaJ4cZU/1MiNI2@casper.infradead.org>
References: <20220221080217.GB835@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221080217.GB835@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:02:18PM +0800, kernel test robot wrote:
> commit: a0b99df1aa37d714eb80be5fb54efd56c88a3336 ("mm/readahead: Add large folio readahead")

> xfs/420	- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/420.out.bad)
>     --- tests/xfs/420.out	2022-02-17 11:55:00.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/420.out.bad	2022-02-20 20:34:22.430378506 +0000
>     @@ -13,9 +13,7 @@
>      Seek holes and data in file2
>      Whence	Result
>      DATA	0
>     -HOLE	131072
>     -DATA	196608
>     -HOLE	262144
>     +HOLE	524288

Confirm this test now fails.  I don't think it's actually a bug,
though.  I think the test is now using larger pages to cache the
file, and it fails to report that there's a hole in the file.
Maybe there actually isn't a hole in the file any more; using
larger pages to cache the file means we'll now write more data
than we used to.

Adding XFS people for their thoughts.

Complete output:

$ diff -u ../ktest/tests/xfstests/tests/xfs/420.out ktest-out/xfstests/xfs/420.out.bad
--- ../ktest/tests/xfstests/tests/xfs/420.out	2021-07-05 15:49:45.539887305 -0400
+++ ktest-out/xfstests/xfs/420.out.bad	2022-02-21 08:14:40.000000000 -0500
@@ -13,9 +13,7 @@
 Seek holes and data in file2
 Whence	Result
 DATA	0
-HOLE	131072
-DATA	196608
-HOLE	262144
+HOLE	524288
 Compare files
 c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
 017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
@@ -28,9 +26,7 @@
 Seek holes and data in file2
 Whence	Result
 DATA	0
-HOLE	131072
-DATA	196608
-HOLE	262144
+HOLE	524288
 Compare files
 c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
 017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2

So the file checksums are right, which means I didn't break the COW
functionality.  But we're no longer reporting a hole at 128k.
