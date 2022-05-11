Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05993522FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiEKJqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbiEKJqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:46:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EE522BC7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:46:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j14so1373670plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tnyhr9C4u86T0lqYrI8D0t2XdDrJ442Ns675Ildd+iQ=;
        b=Q+hGr50U5r7y+ABZgbwRjKwIrlkCY4Fbmk4XJC20JBI59bDP2DTmf3GXcrwElHQTdP
         8dFrnWkgRJX+KOeHLnOOUashuYoweNIwoeoBsVsKcC1ZuhumaOcwkCUv+PydchpWyna8
         pNAkYUmRtIMl4ClHqMh8GvcSuPH9Bx3N+1wa34t9/ouIgrmesgxIJMAg5dKob1eN7k6L
         2haHAncIlPJyJwBWsOS3r3k3CcqkZqaxRUZ40hsI9ObrC3Lz4iIM7IyTFrDIoMU7L4uC
         JkInJYvKlzK4lv0LfAuUxRC+E61wXdP6LStW3Ckr9oB3aPKV4ukrtiCuM839GCUpc6vV
         kyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnyhr9C4u86T0lqYrI8D0t2XdDrJ442Ns675Ildd+iQ=;
        b=7bmLw1Urb0771+SbxgVk/BEXx5tlLDfmBm0FvPi3P1XbGrhHMuJV+YZw86pcCMQKPv
         t98WDLyptXKYdoIkck9/WSBOosccqWn0ifnaY2fJoj9XQfWEJ0YtyVmOdzk6yaaMfe8A
         2A+iba8Go9MHhsOzqnYgvZQ0Hg1iGKDYu7ycxntSfrp8ocLBBqgNQZ6ouAGXNTgP71/z
         49LahRTpshbfoW4nCupQ6TSuQeYryZ9vzRhRhsOhkJ/U0VfxKwq05hTuLVOzQl0NYGOy
         I4hZBxzUiun3tR+1RRe2/u3ACY6YtBLBt0qtmeRs1ETCINuFpi2q06hCZy3XewsAAbUd
         pY6g==
X-Gm-Message-State: AOAM533c6/SqYjnDHSWf4E15aNcJs8ANyQD1OgO3U00MhMO1nOO0qqXJ
        zfQFOQn8j8DI9wy844h9SUftoQ==
X-Google-Smtp-Source: ABdhPJxIRZ1iBB/Hr0rz7Sunm9OPwb9CrQztMG9WxDcqkhIyyubwVwhbRR3ejI7COeCc5NEHiLzc7A==
X-Received: by 2002:a17:902:bb90:b0:156:2c05:b34f with SMTP id m16-20020a170902bb9000b001562c05b34fmr25156995pls.53.1652262369846;
        Wed, 11 May 2022 02:46:09 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902869700b0015ec44d25dasm1297219plo.235.2022.05.11.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:46:09 -0700 (PDT)
Date:   Wed, 11 May 2022 17:45:57 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v10 4/4] mm: hugetlb_vmemmap: add
 hugetlb_optimize_vmemmap sysctl
Message-ID: <YnuF1c5fMOzJnNfD@FVFYT0MHHV2J.usts.net>
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-5-songmuchun@bytedance.com>
 <970166e0-f70e-dd2a-c764-af23a8425f87@oracle.com>
 <9d64809f-db8c-0a3e-1ae9-d4a8ab79041e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d64809f-db8c-0a3e-1ae9-d4a8ab79041e@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 05:39:40PM -0700, Mike Kravetz wrote:
> On 5/10/22 14:30, Mike Kravetz wrote:
> > On 5/8/22 23:27, Muchun Song wrote:
> >> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> >> index 029fb7e26504..917112661b5c 100644
> >> --- a/include/linux/memory_hotplug.h
> >> +++ b/include/linux/memory_hotplug.h
> >> @@ -351,4 +351,13 @@ void arch_remove_linear_mapping(u64 start, u64 size);
> >>  extern bool mhp_supports_memmap_on_memory(unsigned long size);
> >>  #endif /* CONFIG_MEMORY_HOTPLUG */
> >>  
> >> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> >> +bool mhp_memmap_on_memory(void);
> >> +#else
> >> +static inline bool mhp_memmap_on_memory(void)
> >> +{
> >> +	return false;
> >> +}
> >> +#endif
> >> +
> >>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index 8605d7eb7f5c..86158eb9da70 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -1617,6 +1617,9 @@ static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> >>  
> >>  static inline void flush_free_hpage_work(struct hstate *h)
> >>  {
> >> +	if (!hugetlb_optimize_vmemmap_enabled())
> >> +		return;
> >> +
> > 
> > Hi Muchun,
> > 
> > In v9 I was suggesting that we may be able to eliminate the static_branch_inc/dec from the vmemmap free/alloc paths.  With this patch
> > I believe hugetlb_optimize_vmemmap_enabled() is really checking
> > 'has hugetlb vmemmap optimization been enabled' OR 'are there still vmemmap
> > optimized hugetlb pages in the system'.  That may be confusing.
> > 
> 
> Sorry, I forgot about the use of hugetlb_optimize_vmemmap_enabled in
> page_fixed_fake_head.  We need to know if there are any vmemmap optimized
> hugetlb pages in the system in this performance sensitive path.  So,
> static_branch_inc/dec is indeed a good idea.
>

Agree.

> Please disregard my attempt below at removing static_branch_inc/dec.
> 
> I still find the name hugetlb_optimize_vmemmap_enabled a bit confusing as
> it tests two conditions (enabled and pages in use).
>

Right. It tests two conditions.

> You have already 'open coded' just the check for enabled in the routine
> hugetlb_vmemmap_free with:
> 
> 	READ_ONCE(vmemmap_optimize_mode) == VMEMMAP_OPTIMIZE_OFF
> 
> How about having hugetlb_optimize_vmemmap_enabled() just check
> vmemmap_optimize_mode in a manner like above?  Then rename

I'm wondering is it necessary to do this? vmemmap_optimize_mode
is a internal state in hugetlb_vmemmap.c, at leaset now there is
no outside users who care about this.  Open-coding may be not
an issue (I guess)?  If one day someone cares it, maybe it it
the time to do this and rename hugetlb_optimize_vmemmap_enabled()?
I'm not against doing this, just expressing some of my thoughts.
What do you think, Mike?

> hugetlb_optimize_vmemmap_enabled to something like:
> hugetlb_optimized_vmemmap_possible().  Sorry, I can think if a great name.
> 

At least I cannot come up with an appropriate name.
hugetlb_optimize_vmemmap_may_enabled()? It's not easy to come
up with a good name.

Thanks.

