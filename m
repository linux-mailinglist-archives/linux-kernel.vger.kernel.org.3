Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6052F59E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353886AbiETWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 18:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353875AbiETWTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:19:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6BB1A0481
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:19:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so8795303pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FJNM+SC0IIR+V8IbK3b8r/wd9vAA7Bdywff6gYSjtWo=;
        b=IAMIx2qmVQETKVtS+eBPNuWm9U9fFHmsYSExLr6IDKzceYJaksMhXffQk2IE+D7NiL
         wmXbzFxZLiUuy9QVTOWQm9RG3+vPowUfkO9qbhQkYe1LFO7/i674voMBdNYzc21ydd9y
         VbiCumoURfE5ioRSP3xY/gRPs5tCVwCgx8zwwAXczAzxev5vsydhEms8X+dpn2BRvqM/
         nB23BMg4wyRlDNWhslbqYT0UF4PPu8Fj2YiPgxdXX+ywqOhhjIYg5msgduqq+0MkKevb
         5+t+n+gaaYno1lbeY08X7cOYSAlFJqtvx+aLNBc/LWV208pz0X9JKLYdd+9VtQi02Evx
         RwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FJNM+SC0IIR+V8IbK3b8r/wd9vAA7Bdywff6gYSjtWo=;
        b=M7jfy5RocrFh9KBnezriy4PsCyaCh8Odd++P79Tf2mLgyggRGSBl+IL3EOjiWKykBt
         sQitKFORmKBPHBk3DLD6lQYwJsPMzdpUI3ydrdwb/e89LwDA01PyxlSjK4l8zQE9cvDx
         NXTXEJjbEp9UcceIQB/KlBklzqVYVxPQUxsOoKheugUwbD1EZptOtGhxIpgwmWYiylT9
         zUDxsUTuMkQDIb4M0qhcqKITx8TSMIFPHBMcHPEhsVionBtxIsd/e5ooJqirFTFAuSkv
         btTA81JC2Qr5cKUzhOTs4no6RKoqRkIoJA97mM63i16Nn4ZzSLqDYS3F3mE4it6368cL
         0NLg==
X-Gm-Message-State: AOAM530zFmnqhhltqMa409A/0bb5D499D2imIbs1HdWHl9Ge3mPvhV6W
        8bSNgIukB5V8t4rIleudgCTbiv+XTEQ=
X-Google-Smtp-Source: ABdhPJzTA7NI8raUHUFL9b5veywXOFMcEpgKQYOTLQnyOSWCcy0yzWIrM0H3Vl3f6/l4yp2/RT5+MA==
X-Received: by 2002:a63:5c22:0:b0:3db:141c:6db2 with SMTP id q34-20020a635c22000000b003db141c6db2mr10186919pgb.198.1653085175156;
        Fri, 20 May 2022 15:19:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:828d:ad52:eebc:6659])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902edc700b0016168e90f37sm224221plk.152.2022.05.20.15.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:19:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 20 May 2022 15:19:32 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Message-ID: <YogT9AwVclxAnyvs@google.com>
References: <00000000000077377c05dee75f63@google.com>
 <20220513102617.c464c4f566052838e911a3ec@linux-foundation.org>
 <75f09063-d184-7d44-17a1-ed04be5eb953@oracle.com>
 <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:37:01PM -0700, Mike Kravetz wrote:

< snip >

> > I need to look at this a little more closely, it is making me wonder
> > whether the is_pinnable_page() check is a problem in this path. The
> > comment in try_grab_folio() indicates that the early return is a hack
> > (it assumes that the caller is in the gup fast path), and maybe the hack
> > is just wrong here--I think we're actually on the slow gup path. Not
> > good.
> > 
> > Mike, any thoughts here?
> > 
> 
> Do you know why try_grab_compound_page(now try_grab_folio) checks for
> pinnable when try_grab_page does not?
> 
> Then I guess the next question is 'Should we allow pinning of hugetlb pages
> in these areas?'.  My first thought would be no.  But, recall it was 'allowed'
> until that commit which changed try_grab_page to try_grab_compound_page.

The reason we don't allow longterm pinning in CMA area is to improve
big contigus memory allocation sccuess ratio when someone claim the memory
space. Thus, any pages mapped at userspace given the CMA area shouldn't be
pinned with longterm. Otherwise, the cma_alloc will fail due to migration
failure.

In hugetlb case(I might miss something..), the CMA memory was already
claimed by hugeTLB and the big contiguous memory was mapped at userspace
so there is no reason to prevent longterm pinning since HugeTLB will
never claim those CMA memory until user release the memory and HugeTLB
free the range using cma_release.

> In the 'common' case of compaction, we do not attempt to migrate/move hugetlb
> pages (last time I looked), so long term pinning should not be an issue.
> However, for things like memory offline or alloc_contig_range() we want to

The memory offline would be an issue so we shouldn't allow pinning of any
pages in *movable zone*.

Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
problem to allow pinning on those area. The matter is what target range
on alloc_contig_range is backed by CMA or movable zone and usecases.

IOW, movable zone should be never allowed. But CMA case, if pages
are used by normal process memory instead of hugeTLB, we shouldn't
allow longterm pinning since someone can claim those memory suddenly.
However, we are fine to allow longterm pinning if the CMA memory
already claimed and mapped at userspace(hugeTLB case IIUC).

Please correct me if I miss something.

Thanks.
