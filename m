Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476C7526E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiENBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 21:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiENBEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 21:04:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2281349108
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDB65B8324B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 00:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2731C385AA;
        Sat, 14 May 2022 00:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652487493;
        bh=kw3CRHi4r3zW24bJ9aMXizk9Hol6hDRCL5ptaAt/ldM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pYJQJ1zMoJadGRgSmqDeHSNHpimlTYl8VVS+moIM1ed2Y2BVr7ddCBr/x6nJPh1WF
         gnNRVqVi0H63lD3X6rthMOfaygHE2kk37joJ20Ti3ySjfeRQ/c6UcQPnHSPxwlEcjQ
         VZWoBVPghrfFIfz7lTuaElxlzaLLFzeXMKe5/djQ=
Date:   Fri, 13 May 2022 17:18:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Message-Id: <20220513171811.3604fb2da04615100c5ed160@linux-foundation.org>
In-Reply-To: <Yn7vnpXwX50J3K+7@google.com>
References: <000000000000ef451a05dee0f2b1@google.com>
        <00000000000077377c05dee75f63@google.com>
        <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
        <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
        <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
        <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
        <Yn7vnpXwX50J3K+7@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 16:54:06 -0700 Minchan Kim <minchan@kernel.org> wrote:

> > > >> has been there over a month so I guess it's something else.  Does
> > > >> someone have the time to bisect?
> > > > 
> > > > I can recreate in my 'easy to debug' environment, so I can bisect in
> > > > parallel with other things I need to do today.
> > > > 
> > > 
> > > I isolated this to Minchan Kim's "mm: fix is_pinnable_page against on cma
> > > page".  Yes, the fat finger fix is in next-20220513.
> > > 
> > > I don't have time to analyze right now, but can confirm that in the
> > > reproducer is_pinnable_page is returning false after this change when it
> > > previously returned true.
> > 
> > OK, thanks, I dropped mm-fix-is_pinnable_page-against-on-cma-page.patch
> 
> Seems like bug of the patch v5 due to change of this
> 
>     if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
> 
> The migration type is not bit type so it shold be 
> 
> if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> 

argh, I meant to check that change but the grey cell died.

I'll bring it back, with

--- a/include/linux/mm.h~mm-fix-is_pinnable_page-against-on-cma-page-fix
+++ a/include/linux/mm.h
@@ -1635,7 +1635,7 @@ static inline bool is_pinnable_page(stru
 	int __mt = get_pageblock_migratetype(page);
 	int mt = __READ_ONCE(__mt);
 
-	if (mt & (MIGRATE_CMA | MIGRATE_ISOLATE))
+	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
 
_

