Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF7653A476
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351448AbiFAL4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242108AbiFAL4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:56:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E5B6B7C0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:56:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c14so1661773pgu.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pR6VzLoG/n8Hl9GbCmfWr6M9WLjiGWY3XL3BO0710dM=;
        b=w6WHPfiAa2BV+6s2Aq+bTPDlC3usBQQMUEzBNO9v68Ym/XmdcCTaiut0SFHNA5JtEs
         PeDc1Jch6hPTLaX+2tZxz9rxEFnVL3qAYPGJWp9krdPas0eTy+o+2BUe5cJaAAY24dU4
         3tSkFPc+dG9/uLbT+Of1zSZ+S/AQv6OP/H+1pKxQ7sJmXR80+gwIe1rabajINc9aRrly
         3eSpIw8dDhQvYURe8U06jgFjHGg1lC8nF8/RapYfjKXYKZkZH9kcLTVlP37U4L+qIw86
         D+pxNhJxwpgJlN9aNw/ZhFWcJwtMJSsz+B9I0kM0OfR4ywm9IYjUAb9Wrldo9qxs5qFh
         8SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pR6VzLoG/n8Hl9GbCmfWr6M9WLjiGWY3XL3BO0710dM=;
        b=TQ5HKMdZxtJr376D13dbL9FpVorLRaGZ2rdcL78gK3hN6m5lVAMMW+5+iGQPYH0eN+
         0x7toekz9Y9zf7tOPQAG1CM9EfK1hC/Y68wheDGwdxIwFqYXeAXQRblsTMeyq1FWQny1
         EZ9HEFmZPiApPO6r7VpG2R80avce/kGXUphsIF677Dvxp3imoXV1VKBgQkDPqgFfsGCW
         Eghg5n4rM0WmmAqj5d3VWIyjmTWhDScoJlICsXerRBy7ya1jgCI+tf7d9G74Br77cGda
         muRefhxHBB0KiF361vM+G5CxrIqSDVdKBa0xfnn9IehW5iHN5KIL8ebLP+rzUeyX7b9Y
         Qf5g==
X-Gm-Message-State: AOAM533hKaB021OCQqNiTc0yV9ABphPhP6o4lSm66vnLPse1PrqahIK6
        tIUW0bztawQpOmnxo3cu3kx3jA==
X-Google-Smtp-Source: ABdhPJwSk3VUFjJDwUrgUxbBIoYw9ZfLI5bPXe34CUD6GqwF15lJ0NA1xUR3OJNC13SbIdMmemLHEQ==
X-Received: by 2002:a05:6a00:994:b0:518:6f30:502d with SMTP id u20-20020a056a00099400b005186f30502dmr59379307pfg.68.1654084597086;
        Wed, 01 Jun 2022 04:56:37 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:f9bc:fb5f:5b66:a80e])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79ddd000000b0050dc762819esm1264305pfq.120.2022.06.01.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 04:56:36 -0700 (PDT)
Date:   Wed, 1 Jun 2022 19:56:31 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
Subject: Re: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Message-ID: <YpdT756zYIaMzsN3@FVFYT0MHHV2J.googleapis.com>
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-4-songmuchun@bytedance.com>
 <ba64cd1b-c8ee-a4eb-f0cd-e16c26777d46@redhat.com>
 <Ypc3OquA5MZUl5iw@FVFYT0MHHV2J.googleapis.com>
 <ecc076e6-562e-cb5d-6c92-295dde07f657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecc076e6-562e-cb5d-6c92-295dde07f657@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 12:10:29PM +0200, David Hildenbrand wrote:
> On 01.06.22 11:54, Muchun Song wrote:
> > On Wed, Jun 01, 2022 at 11:32:37AM +0200, David Hildenbrand wrote:
> >> On 04.04.22 09:46, Muchun Song wrote:
> >>> The word of "free" is not expressive enough to express the feature of optimizing
> >>> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> >>> In this patch , cheanup configs to make code more expressive.
> >>
> >> Nit: why not simply CONFIG_HUGETLB_OPTIMIZE_VMEMMAP if we're touching
> >> this already? At least I don't see value in the additional "PAGE" :)
> >>
> > 
> > I thought it keep consistent with CONFIG_HUGETLB_PAGE.  If you think
> > CONFIG_HUGETLB_OPTIMIZE_VMEMMAP is a better name, maybe we need to
> > another separate patch since this series is already on mm-stable branch.
> 
> I see, makes sense then.
> 
> >>>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  Documentation/admin-guide/kernel-parameters.txt |  4 ++--
> >>>  Documentation/admin-guide/mm/hugetlbpage.rst    |  2 +-
> >>>  arch/arm64/Kconfig                              |  2 +-
> >>>  arch/arm64/mm/flush.c                           |  2 +-
> >>>  arch/x86/Kconfig                                |  2 +-
> >>>  arch/x86/mm/init_64.c                           |  2 +-
> >>>  fs/Kconfig                                      | 16 ++++++++--------
> >>>  include/linux/hugetlb.h                         |  2 +-
> >>>  include/linux/mm.h                              |  2 +-
> >>>  include/linux/page-flags.h                      |  6 +++---
> >>>  mm/Makefile                                     |  2 +-
> >>>  mm/hugetlb_vmemmap.c                            |  4 ++--
> >>>  mm/hugetlb_vmemmap.h                            |  4 ++--
> >>>  mm/sparse-vmemmap.c                             |  4 ++--
> >>>  14 files changed, 27 insertions(+), 27 deletions(-)
> >>>
> >>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >>> index 56edbe3f458f..89a58ac49d5f 100644
> >>> --- a/Documentation/admin-guide/kernel-parameters.txt
> >>> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >>> @@ -1660,7 +1660,7 @@
> >>>  			Format: size[KMG]
> >>>  
> >>>  	hugetlb_free_vmemmap=
> >>
> >> We didn't change the parameter name in #2, correct?
> >>
> > 
> > I think this is a interface to users. Is it correct to
> > change it?
> 
> I guess so ... I was just wanted to confirm that this is still correct :)
>

Well, I think it is not correct to change it since it
could change behavior to users. :-)

Thanks.
