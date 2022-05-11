Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0206E523111
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiEKK55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiEKK5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:57:46 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61184666A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:57:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c11so1489755plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZDRUrJcoddOI9LUx9R90auFEIMbtfXtE02emcq85vQ=;
        b=HzBNa9AB2P7wZpUPFsvLZ9f9YvBiLg8bA6EUO/OBrBxIMx/Bv4yQuojU1EpBcvijO3
         P9o2RA2brlait7uMo2aEzeFwI0xmcRkL/odlVQHvtctPmP9rD++t6c41SjbhdcLll+jZ
         Nta+CNL77iBe4TQEz21newKCgKl36svd5J9i+XS+2EhxeGvEyTakkPny1keUiEid6Ud/
         XadIJVSMbScKOe3xiU8j29nTzURvw9o/QiGqhLvjOfEwyrHRCKxMKhasCpLt1t/EIoQ7
         mPrJ4eOFfMZabag7NOvE6kwsK3fpovxR/sMiW3FlWjqi6oBr21GymliUDxm1gYDtC0F/
         jR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZDRUrJcoddOI9LUx9R90auFEIMbtfXtE02emcq85vQ=;
        b=7HnwmD+fnue0NiLQHK320trp6YYt52v/nGdkXy1IzZ97ylhbjFr2Hbh22m2uYHdP3h
         7QpnKPlRVC9ygxiZkK62ITw2e48Ii8ChchqeRu21G4d/c6Yh7OFSsIm6/DXoQWYffkGF
         WFqzwVIlEVJ3i8N8WxbYC9dAofUmVyN4CylmOdYRa62twLm2K0mhpg7JVKRPN5wuaAjU
         eEJKgDfAVyUMBa7OdFG4/FAlRy54yZJr/PkvBY4zXptWoij8X161a4suvsX1KjaXQb/l
         1eeTfZ8+834OOJrlegSgdmRQZq9LcUiGaYiptz5KedW0GeAmUCRfzIj3Tpmxcm2Ptfvy
         uGEA==
X-Gm-Message-State: AOAM53082sJSq8wVp5E4PrSGhllnpGO8t0253gRfI6LQNRXuw8pOxUD9
        rSFxK73IgxknQsIAh8MWDSymQw==
X-Google-Smtp-Source: ABdhPJwC3JvY0yyZZKqrx8zPPlaVt1UAUQt4RbPa3XOwHux0ofuAsp5Ax5zrWKm72QJgrbiYRp7Ncw==
X-Received: by 2002:a17:90b:4acb:b0:1dc:32dd:d51e with SMTP id mh11-20020a17090b4acb00b001dc32ddd51emr4653614pjb.5.1652266664222;
        Wed, 11 May 2022 03:57:44 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id y64-20020a623243000000b0050dc7628195sm1396596pfy.111.2022.05.11.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 03:57:43 -0700 (PDT)
Date:   Wed, 11 May 2022 18:57:32 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v10 4/4] mm: hugetlb_vmemmap: add
 hugetlb_optimize_vmemmap sysctl
Message-ID: <YnuWnFbb8xExKfdk@FVFYT0MHHV2J.usts.net>
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-5-songmuchun@bytedance.com>
 <970166e0-f70e-dd2a-c764-af23a8425f87@oracle.com>
 <9d64809f-db8c-0a3e-1ae9-d4a8ab79041e@oracle.com>
 <YnuF1c5fMOzJnNfD@FVFYT0MHHV2J.usts.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnuF1c5fMOzJnNfD@FVFYT0MHHV2J.usts.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 05:45:57PM +0800, Muchun Song wrote:
> On Tue, May 10, 2022 at 05:39:40PM -0700, Mike Kravetz wrote:
> > On 5/10/22 14:30, Mike Kravetz wrote:
> > > On 5/8/22 23:27, Muchun Song wrote:
> > >> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > >> index 029fb7e26504..917112661b5c 100644
> > >> --- a/include/linux/memory_hotplug.h
> > >> +++ b/include/linux/memory_hotplug.h
> > >> @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
> > >>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
> > >>  #endif /* CONFIG_MEMORY_HOTPLUG */
> > >>  
> > >> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> > >> +bool mhp_memmap_on_memory(void);
> > >> +#else
> > >> +static inline bool mhp_memmap_on_memory(void)
> > >> +{
> > >> +	return false;
> > >> +}
> > >> +#endif
> > >> +
> > >>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> > >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > >> index 8605d7eb7f5c..86158eb9da70 100644
> > >> --- a/mm/hugetlb.c
> > >> +++ b/mm/hugetlb.c
> > >> @@ -1617,6 +1617,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> > >>  
> > >>  static inline void flush_free_hpage_work(struct hstate *h)
> > >>  {
> > >> +	if (!hugetlb_optimize_vmemmap_enabled())
> > >> +		return;
> > >> +
> > > 
> > > Hi Muchun,
> > > 
> > > In v9 I was suggesting that we may be able to eliminate the static_branch_inc/dec from the vmemmap free/alloc paths.  With this patch
> > > I believe hugetlb_optimize_vmemmap_enabled() is really checking
> > > 'has hugetlb vmemmap optimization been enabled' OR 'are there still vmemmap
> > > optimized hugetlb pages in the system'.  That may be confusing.
> > > 
> > 
> > Sorry, I forgot about the use of hugetlb_optimize_vmemmap_enabled in
> > page_fixed_fake_head.  We need to know if there are any vmemmap optimized
> > hugetlb pages in the system in this performance sensitive path.  So,
> > static_branch_inc/dec is indeed a good idea.
> >
> 
> Agree.
> 
> > Please disregard my attempt below at removing static_branch_inc/dec.
> > 
> > I still find the name hugetlb_optimize_vmemmap_enabled a bit confusing as
> > it tests two conditions (enabled and pages in use).
> >
> 
> Right. It tests two conditions.
> 
> > You have already 'open coded' just the check for enabled in the routine
> > hugetlb_vmemmap_free with:
> > 
> > 	READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF
> > 
> > How about having hugetlb_optimize_vmemmap_enabled() just check
> > vmemmap_optimize_mode in a manner like above?  Then rename
> 
> I'm wondering is it necessary to do this? vmemmap_optimize_mode
> is a internal state in hugetlb_vmemmap.c, at leaset now there is
> no outside users who care about this.  Open-coding may be not
> an issue (I guess)?  If one day someone cares it, maybe it it
> the time to do this and rename hugetlb_optimize_vmemmap_enabled()?
> I'm not against doing this, just expressing some of my thoughts.
> What do you think, Mike?
> 
> > hugetlb_optimize_vmemmap_enabled to something like:
> > hugetlb_optimized_vmemmap_possible().  Sorry, I can think if a great name.
> > 
> 
> At least I cannot come up with an appropriate name.
> hugetlb_optimize_vmemmap_may_enabled()? It's not easy to come
> up with a good name.
>

Instead of renaming, how about remove hugetlb_optimize_vmemmap_enabled()
directly?  I found there are only two places (mm/memory_hotplug.c and
arch/arm64/mm/flush.c) except include/linux/page-flags.h where use this
helper.

In arch/arm64/mm/flush.c, we could replace it with

  if (PageHuge(page) && HPageVmemmapOptimized(compound_head(page)))

In mm/memory_hotplug.c, I have a plan to remove it as well (I'll
post them out after this patch merged).

Finally, there is no outside users of it, we could remove it and squash
it into page_fixed_fake_head(). What do you think this, Mike?

