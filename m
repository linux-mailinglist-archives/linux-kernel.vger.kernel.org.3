Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA052F650
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbiETXnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiETXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:43:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6D91A35A9
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:43:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so9038923pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9xGh+0nUKZTlYCnx1t+/gNqJD29FnGxAgofH8LwvP5E=;
        b=npLfugbnU+k1hLqxC75p0GsmrLZ092hERF5MucocTBkDfml6rheihyvWkQ/fw+A0RO
         lPkVMJDCe4oCt9Fugc2ieAxzLwyqq2H5YbeGEeJMYnzMUL+980ZxS0xrC5HVfWD65ZQc
         4M8dJ22njs9P47xVFhSJbvm6zzt8v++vfzIlkwLK/pWdWigCtP69Tl1nct+8Fay+/tcu
         bmwkZWCnawuysBMbhIqsJAelXDlOQVng4wgnGTZjcw1HvCfxF9VCKoai1ywDwDkcQtiG
         DHQqCMD5+Yq42s9o/ed65iJjg3VDYwGw7Ha0oe9kZeeIfXqKtwKkKF/0o5PfQADIyTMj
         t52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=9xGh+0nUKZTlYCnx1t+/gNqJD29FnGxAgofH8LwvP5E=;
        b=I86vb9VOp5UR2dUeNqSVIED2IhDzZRYm32RNQb9++xiZDwfGb+Gr+wgwPVZfr4+q5x
         PFhtI+THxajdSattLVeEkDUD0GUcciboLpk8b9UrFy9//dMUjNSlNYxYR8n0WTQzBn7e
         V0YIOBuC0CBb7CDGsR7vbVn5Fu8tuRv4kGK7R0hvpcpuWeOp8VtiN1yEndzYxo2InjNv
         5TqiGfWRy8G771aJ23Jxa+uW1mrInDBvX/Si/na8eR6JtjLwn35ChocT3/hMqmup1FSx
         qbYIOZQSSS52pVFQ5N0Z0ShGLH2IGkNzy3pzr9di2bFgKgrnXb+X3vwAzJWyii4LF9A2
         IT4A==
X-Gm-Message-State: AOAM533oyCYNkPepUyI6y9u0VThAgy/1DeiPV2aoCYxpmJCPg9ABTSau
        wvt5gU7t8LEYJExZMql+75Q=
X-Google-Smtp-Source: ABdhPJzasJ3EDlhCCx5LZuepE1qsJZ4EZ4EXif5ffl94joHQy59k71M13xwj23PKkkZlOQ2o+fmJ8A==
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id s11-20020a17090302cb00b0014f4fb62fb0mr11927028plk.172.1653090200058;
        Fri, 20 May 2022 16:43:20 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:828d:ad52:eebc:6659])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902b7c100b0015e8d4eb1f8sm291074plz.66.2022.05.20.16.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:43:19 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 20 May 2022 16:43:17 -0700
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
Message-ID: <YognlSdHAKgnkPPY@google.com>
References: <a7fd0c3f-921e-19b3-2f67-a231dede28f9@oracle.com>
 <20220513161910.d1b73583cdb2e33562aa86e5@linux-foundation.org>
 <Yn7vnpXwX50J3K+7@google.com>
 <4809b134-a37a-50b8-4c25-44548bc1048f@nvidia.com>
 <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
 <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
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

On Fri, May 20, 2022 at 04:31:31PM -0700, Mike Kravetz wrote:
> On 5/20/22 15:56, John Hubbard wrote:
> > On 5/20/22 15:19, Minchan Kim wrote:
> >> The memory offline would be an issue so we shouldn't allow pinning of any
> >> pages in *movable zone*.
> >>
> >> Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
> >> problem to allow pinning on those area. The matter is what target range
> >> on alloc_contig_range is backed by CMA or movable zone and usecases.
> >>
> >> IOW, movable zone should be never allowed. But CMA case, if pages
> >> are used by normal process memory instead of hugeTLB, we shouldn't
> >> allow longterm pinning since someone can claim those memory suddenly.
> >> However, we are fine to allow longterm pinning if the CMA memory
> >> already claimed and mapped at userspace(hugeTLB case IIUC).
> >>
> > 
> > From Mike's comments and yours, plus a rather quick reading of some
> > CMA-related code in mm/hugetlb.c (free_gigantic_page(), alloc_gigantic_pages()), the following seems true:
> > 
> > a) hugetlbfs can allocate pages *from* CMA, via cma_alloc()
> > 
> > b) while hugetlbfs is using those CMA-allocated pages, it is debatable
> > whether those pages should be allowed to be long term pinned. That's
> > because there are two cases:
> > 
> >     Case 1: pages are longterm pinned, then released, all while
> >             owned by hugetlbfs. No problem.
> > 
> >     Case 2: pages are longterm pinned, but then hugetlbfs releases the
> >             pages entirely (via unmounting hugetlbfs, I presume). In
> >             this case, we now have CMA page that are long-term pinned,
> >             and that's the state we want to avoid.
> 
> I do not think case 2 can happen.  A hugetlb page can only be changed back
> to 'normal' (buddy) pages when ref count goes to zero.
> 
> It should also be noted that hugetlb code sets up the CMA area from which
> hugetlb pages can be allocated.  This area is never unreserved/freed.
> 
> I do not think there is a reason to disallow long term pinning of hugetlb
> pages allocated from THE hugetlb CMA area.
> 
> But, I wonder if it is possible for hugetlb pages to be allocated from
> another (non-hugetlb) area.  For example if someone sets up a huge CMA area
> and hugetlb allocations spill over into that area.  If this is possible
> (still need to research), then we would not want to long term pin such
> hugetlb pages.  We can check this in the hugetlb code to determine if
> long term pinning is allowed.  

I don't think it's possible because cma_alloc needs "struct cma" just
like handle and VM doesn't maintain any fallback list of cma chains
so unless someone could steal the handle somehow, there is no way to
claim memory others reserved for the CMA purpose.
