Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DB455F5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiF2FzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiF2FzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:55:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF8E140EE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:55:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m14so13122073plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=94SNj+bfUaqeA4+uNDnU29zDWORUfea9gHEDob5a9do=;
        b=q9JXdbLNWvzcTKItVrJEAKSJqXSdpJuMcVam/iQ19oILMIUql+ezlVs/Ba+iRVfZ1C
         UvdBtOdFUjOjf8D5JP4HcCZWynYHFhK2WnG1rMfMKN/gcNpp3HyPMOkayfhk0taORRpn
         Mw3Xe+AvOwjybK3xY9sJQt8/Mlnxp1uei//koBq0iiJlDJH20LhHIXIrzyjp8VrdtSgG
         8yVZu8aBRFZye3oUqp4ZTwtlfunYXsimPwhXxHHR+xP/oj06+ihqF2avPf+KSSLUqiDZ
         q/mGcI1e4jzCPlcASOr6mfmrPgWRJrw4ykN3P4C1gnKiQY5BSktUM2HKbNrdTU5xFMpP
         1YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=94SNj+bfUaqeA4+uNDnU29zDWORUfea9gHEDob5a9do=;
        b=SupdWxuMRLPf38epQZNt7Rjtv7EiudXGiYc+OZjVvulZnshVlym6KqhjrXIFWHl2Vb
         ovv4H0OM14sX9mml6B+iRKp4JG65fzsnbj+1/kuoVSE+V1qvyUNlK9XQJwTR/Gy7dKFl
         T4xe248CU/ff+NmWO5VDUxdVUWd5t+wyuajTKONIEo+Pmhm9PeLhNwV+xl+ih3kP1va4
         zXsW+6ps8pMN31KDqMhL6kOpvHqAjsRg2D8KXLdoOhbhqOgjtohz65PXDqie/3MIs18u
         DudJTLg5vrMW8FnSDa+OG6Hrul7Olrh8uRDrhq2BWtcRh7sPZxlYjyOhGuN4aTZ42SG6
         GzMQ==
X-Gm-Message-State: AJIora/Jr/L5WYA+EMOyuHGdIETeomG/hc7ZhZ3HsKtfmYPFTYuqA4fd
        sylTtaZmH96ybQDJcTMB9o4Lig==
X-Google-Smtp-Source: AGRyM1sA/8PT0iAe0wBxu1s9us+UTFRVCahSkFBCCP9Ke8ZrHP2Wudr+UDZH2uuxiNicrLlILN5qfw==
X-Received: by 2002:a17:902:f091:b0:16a:7e5:494f with SMTP id p17-20020a170902f09100b0016a07e5494fmr7332311pla.34.1656482111399;
        Tue, 28 Jun 2022 22:55:11 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g38-20020a635226000000b0040cb1f55391sm10267815pgb.2.2022.06.28.22.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 22:55:11 -0700 (PDT)
Date:   Wed, 29 Jun 2022 13:55:07 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 6/8] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <YrvpOxjHmLpH+LtM@FVFYT0MHHV2J.usts.net>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
 <20220628092235.91270-7-songmuchun@bytedance.com>
 <YrubeXg8tSxJeGxj@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrubeXg8tSxJeGxj@monkey>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 05:23:21PM -0700, Mike Kravetz wrote:
> On 06/28/22 17:22, Muchun Song wrote:
> > There is a discussion about the name of hugetlb_vmemmap_alloc/free in
> > thread [1].  The suggestion suggested by David is rename "alloc/free"
> > to "optimize/restore" to make functionalities clearer to users,
> > "optimize" means the function will optimize vmemmap pages, while
> > "restore" means restoring its vmemmap pages discared before. This
> > commit does this.
> > 
> > Another discussion is the confusion RESERVE_VMEMMAP_NR isn't used
> > explicitly for vmemmap_addr but implicitly for vmemmap_end in
> > hugetlb_vmemmap_alloc/free.  David suggested we can compute what
> > hugetlb_vmemmap_init() does now at runtime.  We do not need to worry
> > for the overhead of computing at runtime since the calculation is
> > simple enough and those functions are not in a hot path.  This commit
> > has the following improvements:
> > 
> >   1) The function suffixed name ("optimize/restore") is more expressive.
> >   2) The logic becomes less weird in hugetlb_vmemmap_optimize/restore().
> >   3) The hugetlb_vmemmap_init() does not need to be exported anymore.
> >   4) A ->optimize_vmemmap_pages field in struct hstate is killed.
> >   5) There is only one place where checks is_power_of_2(sizeof(struct
> >      page)) instead of two places.
> >   6) Add more comments for hugetlb_vmemmap_optimize/restore().
> >   7) For external users, hugetlb_optimize_vmemmap_pages() is used for
> >      detecting if the HugeTLB's vmemmap pages is optimizable originally.
> >      In this commit, it is killed and we introduce a new helper
> >      hugetlb_vmemmap_optimizable() to replace it.  The name is more
> >      expressive.
> > 
> > Link: https://lore.kernel.org/all/20220404074652.68024-2-songmuchun@bytedance.com/ [1]
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/hugetlb.h |   7 +--
> >  include/linux/sysctl.h  |   4 ++
> >  mm/hugetlb.c            |  15 ++---
> >  mm/hugetlb_vmemmap.c    | 143 ++++++++++++++++++++----------------------------
> >  mm/hugetlb_vmemmap.h    |  41 +++++++++-----
> >  5 files changed, 102 insertions(+), 108 deletions(-)
> 
> Thanks!  I like the removal of hugetlb_vmemmap_init and printing directly
> from report_hugepages.  Still need to look at your your command parsing
> patches.
>

Thanks Mike. I am also trying to think about if it is easy to split the
command parsing patch to some small patches for easily reviewing.
 
> > @@ -3191,8 +3191,10 @@ static void __init report_hugepages(void)
> >  		char buf[32];
> >  
> >  		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> > -		pr_info("HugeTLB registered %s page size, pre-allocated %ld pages\n",
> > +		pr_info("HugeTLB: registered %s page size, pre-allocated %ld pages\n",
> >  			buf, h->free_huge_pages);
> > +		pr_info("HugeTLB: %d KiB vmemmap can be freed for a %s page\n",
> > +			hugetlb_vmemmap_optimizable_size(h) / SZ_1K, buf);
> >  	}
> >  }
> 
> My first thought was "Why report vmemmap freed pages if not enabled?".
> However, since it can be enabled at runtime it is best always print.
>

That's what I thought.

> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>

Thanks.
 
> -- 
> Mike Kravetz
> 
