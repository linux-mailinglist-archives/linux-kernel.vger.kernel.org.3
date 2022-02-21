Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F254BEC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiBUUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:55:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBUUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:55:57 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C90E237F1;
        Mon, 21 Feb 2022 12:55:33 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 80EBD10C8085;
        Tue, 22 Feb 2022 07:55:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nMFiT-00EobO-F8; Tue, 22 Feb 2022 07:55:29 +1100
Date:   Tue, 22 Feb 2022 07:55:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [mm/readahead]  a0b99df1aa: xfstests.xfs.421.fail
Message-ID: <20220221205529.GH59715@dread.disaster.area>
References: <20220221080217.GB835@xsang-OptiPlex-9020>
 <YhOaJ4cZU/1MiNI2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhOaJ4cZU/1MiNI2@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6213fc44
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=oGFeUVbbRNcA:10 a=7-415B0cAAAA:8
        a=Mg3Te0UgBqLNUB_3bJUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 01:56:55PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 21, 2022 at 04:02:18PM +0800, kernel test robot wrote:
> > commit: a0b99df1aa37d714eb80be5fb54efd56c88a3336 ("mm/readahead: Add large folio readahead")
> 
> > xfs/420	- output mismatch (see /lkp/benchmarks/xfstests/results//xfs/420.out.bad)
> >     --- tests/xfs/420.out	2022-02-17 11:55:00.000000000 +0000
> >     +++ /lkp/benchmarks/xfstests/results//xfs/420.out.bad	2022-02-20 20:34:22.430378506 +0000
> >     @@ -13,9 +13,7 @@
> >      Seek holes and data in file2
> >      Whence	Result
> >      DATA	0
> >     -HOLE	131072
> >     -DATA	196608
> >     -HOLE	262144
> >     +HOLE	524288
> 
> Confirm this test now fails.  I don't think it's actually a bug,
> though.  I think the test is now using larger pages to cache the
> file, and it fails to report that there's a hole in the file.
> Maybe there actually isn't a hole in the file any more; using
> larger pages to cache the file means we'll now write more data
> than we used to.
> 
> Adding XFS people for their thoughts.
> 
> Complete output:
> 
> $ diff -u ../ktest/tests/xfstests/tests/xfs/420.out ktest-out/xfstests/xfs/420.out.bad
> --- ../ktest/tests/xfstests/tests/xfs/420.out	2021-07-05 15:49:45.539887305 -0400
> +++ ktest-out/xfstests/xfs/420.out.bad	2022-02-21 08:14:40.000000000 -0500
> @@ -13,9 +13,7 @@
>  Seek holes and data in file2
>  Whence	Result
>  DATA	0
> -HOLE	131072
> -DATA	196608
> -HOLE	262144
> +HOLE	524288
>  Compare files
>  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
>  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> @@ -28,9 +26,7 @@
>  Seek holes and data in file2
>  Whence	Result
>  DATA	0
> -HOLE	131072
> -DATA	196608
> -HOLE	262144
> +HOLE	524288
>  Compare files
>  c2803804acc9936eef8aab42c119bfac  SCRATCH_MNT/test-420/file1
>  017c08a9320aad844ce86aa9631afb98  SCRATCH_MNT/test-420/file2
> 
> So the file checksums are right, which means I didn't break the COW
> functionality.  But we're no longer reporting a hole at 128k.

Can you post the contents of the 420.full output file so we can see
what the output of the various commands that are run are? e.g.
things like cowextsize that is configured, etc?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
