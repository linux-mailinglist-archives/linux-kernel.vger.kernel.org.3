Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05337510A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354582AbiDZU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354517AbiDZU0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:26:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2692919A49F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mwa7X/DoIUYu9hVhfOkZkhZH7rVCuWPYP5Vab781DGM=; b=MEERirgAFqgieTtSNaCHB/+ynL
        FaFpxb1rKiiD9IXT7ObhE+QIWSGL80BvDr5428oa9ASLDoTt9kGtRYJHQvsEPM2eoLWqnDnkbCLOl
        DuZoq/T4+UT0uENCCuzCO5X4/pAykTO2Dvdh7vCBfKDeiyn7hNK8x2kLub2ifegMlOFBDViVNWBi+
        NCbM7jmNDtuzVC6X7xyTwaZj5VvIZSA0/W3WTORuFn8kmoOc7fEWjxy76fEcvwbuXl6ousM4KiKI1
        26k/4wB4+gi0I9S3y8CN8h5Q7IpB0CTbNWfe+/b4XTWk+t3BdWNrmhZ1AYqgJ/fZHP3hDlq9oW8Xy
        dAJ3jGkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njRiL-009z23-0v; Tue, 26 Apr 2022 20:23:13 +0000
Date:   Tue, 26 Apr 2022 21:23:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Message-ID: <YmhUsDe+Omf2CNCS@casper.infradead.org>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 01:08:57PM -0700, Andrew Morton wrote:
> On Tue, 26 Apr 2022 15:06:19 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > The maple tree is an RCU-safe range based B-tree designed to use modern
> > processor cache efficiently.  There are a number of places in the kernel
> 
> I think it would be helpful to expand on "a number of places". 
> Specifically which places?

The page cache would be a good place to use it once it has a few more
features to bring it up to par with the radix tree.  I can go into more
detail if you want.

In general, anywhere that's using the IDR/Radix Tree/XArray would
benefit.  The radix tree has some pretty poor space consumption
properties, particularly for anyone using the cyclic variants.

Many users of the rbtree would have better performance if converted
to the maple tree.

Ultimately, it's going to be incumbent on people who know their own
chunk of the kernel to say "Oh, yes, I can use that data structure",
rather than on Liam to go around converting everybody's code for them.
