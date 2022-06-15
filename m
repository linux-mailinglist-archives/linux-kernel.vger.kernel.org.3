Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F254C963
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347273AbiFONCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346507AbiFONCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:02:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA7220ED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:02:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 123so11312558pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ihd5+hUtvMSLtuKfDaBmqf+iFGL/F4FFdcsqC/XAKrg=;
        b=zKf5WOiOffG3FL22AFbalEIXBXG/f5mpymPpP3V7+AvI9Z0Yw+5U39mzeGwOKMi80A
         cqvH6NeTrZD/HwUZJAnDNWcedJz2btUmxZzE12K77R9qyQBHM9dnjqsIoBVoXUXWlFVB
         GsjiMoO9xOpPXQVskNfqBq/CnRGUwowE0h3a2CHfBTrdMS0Qn2n8A4c3eEAo2ROmgx2B
         BaGxQIsdmgVCLNhwzdyaJ6iCgp6y8kY8gJzZo+fWfs0OiG5Bdqb94VM51WYeI9iudR4j
         TmnfuKIYC1MZfkM5wp8QlcAC05hI33+FIyHqK0bGPERbIXrH/qULlrNylTX1E10Gr8fK
         tZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ihd5+hUtvMSLtuKfDaBmqf+iFGL/F4FFdcsqC/XAKrg=;
        b=yXe8Xhc6MZMdJ9YG7gjZny2ZZQVkZgiMjn9hTPxPfyrlXZETCLl8hXep+8KQvH8Wba
         rPuCDaep8ish4tWNqoj3K2UxiAx3ZC2oiH8dspq0M3bceEfV55OyV9SzYcD9aUXOjNNN
         JvH9a5aIdM7SZqQcYbv0BM+dP+U+LteTXn4pwXsDPwaTe/HutrcrA0jkyJNkRr/AjKVm
         Dz0nn5Ny9J1CN4w+P6XJikdpAx2xrJXzOKIpcSlmZhqXc6FhBw14rfU/4hjlhVRVmFtR
         HxxT6GiZL08r8U6vS/fRKm3NOjPt+ZVJwlbJUH+PGxq0cVepdRV1XPvP+WHeKFn3VQup
         yDiQ==
X-Gm-Message-State: AJIora8B4s7+rlZsnIg+OuZDVwg9e/hnVYBeF25xvLYeF6rBGabLGoaP
        gUYYN/zEPUpDAfKfRvxiEB7fXg==
X-Google-Smtp-Source: AGRyM1sld9ZspHUBSDSjpTYavqq/+/cl7SS9nh2jH2uUJ9kiojPH+vhlg710WLM7IDzDL7NfkG4EXg==
X-Received: by 2002:a63:9043:0:b0:408:a759:2234 with SMTP id a64-20020a639043000000b00408a7592234mr7191498pge.304.1655298164667;
        Wed, 15 Jun 2022 06:02:44 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s3-20020a170903200300b001678e9670d8sm9178088pla.2.2022.06.15.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:02:44 -0700 (PDT)
Date:   Wed, 15 Jun 2022 21:02:37 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 1/2] mm: memory_hotplug: enumerate all supported
 section flags
Message-ID: <YqnYbcvenPs5Xqa5@FVFYT0MHHV2J.usts.net>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-2-songmuchun@bytedance.com>
 <62aef8a9-aa21-37ec-83b5-9dd9fc729890@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62aef8a9-aa21-37ec-83b5-9dd9fc729890@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:35:09AM +0200, David Hildenbrand wrote:
> On 20.05.22 04:55, Muchun Song wrote:
> > We are almost running out of section flags, only one bit is available in
> > the worst case (powerpc with 256k pages).  However, there are still some
> > free bits (in ->section_mem_map) on other architectures (e.g. x86_64 has
> > 10 bits available, arm64 has 8 bits available with worst case of 64K
> > pages).  We have hard coded those numbers in code, it is inconvenient to
> > use those bits on other architectures except powerpc.  So transfer those
> > section flags to enumeration to make it easy to add new section flags in
> > the future.  Also, move SECTION_TAINT_ZONE_DEVICE into the scope of
> > CONFIG_ZONE_DEVICE to save a bit on non-zone-device case.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Sorry for the late reply. This looks overly complicated to me.
> 
> IOW, staring at that patch I don't quite like what I am seeing.
> 
> 
> Something like the following is *a lot* easier to read than some
> MAPPER macro magic. What speaks against it?
>

Thanks for taking a look.

Yeah, it is more readable. This question is also raised by Oscar.
I pasted the reply to here.

"
Yeah, it's a little complicated. All the magic aims to generate
two enumeration from one MAPPER(xxx, config), one is SECTION_xxx_SHIFT,
another is SECTION_xxx = BIT(SECTION_xxx_SHIFT) if the 'config' is
configured. If we want to add a new flag, like the follow patch, just
one line could do that.

  MAPPER(CANNOT_OPTIMIZE_VMEMMAP, CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP)

Without those magic, we have to add 4 lines like follows to do the
similar thing.

  #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
        SECTION_CANNOT_OPTIMIZE_VMEMMAP_SHIFT,
  #define SECTION_CANNOT_OPTIMIZE_VMEMMAP BIT(SECTION_CANNOT_OPTIMIZE_VMEMMAP_SHIFT)
  #endif

I admit it is more clear but not simplified as above approach.
"

Both two approaches are fine to me. I can switch to the following approach
seems you think the following one is better.

Thanks.

> /*
>  * Section bits use the lower unused bits in the ->section_mem_map
>  */
> enum {
> 	SECTION_MARKED_PRESENT_BIT = 0,
> 	SECTION_HAS_MEM_MAP_BIT,
> 	...
> #ifdef ZONE_DEVICE
> 	SECTION_TAINT_ZONE_DEVICE_BIT
> #endif
> }
> 
> #define SECTION_MARKED_PRESENT	   (1ULL << SECTION_MARKED_PRESENT_BIT)
> ...
> #ifdef ZONE_DEVICE
> #define SECTION_TAINT_ZONE_DEVICE  (1ULL << SECTION_TAINT_ZONE_DEVICE_BIT)
> #endif /* ZONE_DEVICE */
> 
> 
> 
> > ---
> >  include/linux/kconfig.h |  1 +
> >  include/linux/mmzone.h  | 54 +++++++++++++++++++++++++++++++++++++++++--------
> >  mm/memory_hotplug.c     |  6 ++++++
> >  3 files changed, 53 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> > index 20d1079e92b4..7044032b9f42 100644
> > --- a/include/linux/kconfig.h
> > +++ b/include/linux/kconfig.h
> > @@ -10,6 +10,7 @@
> >  #define __LITTLE_ENDIAN 1234
> >  #endif
> >  
> > +#define __ARG_PLACEHOLDER_ 0,
> >  #define __ARG_PLACEHOLDER_1 0,
> >  #define __take_second_arg(__ignored, val, ...) val
> >  
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 299259cfe462..2cf2a76535ab 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1422,16 +1422,47 @@ extern size_t mem_section_usage_size(void);
> >   *      (equal SECTION_SIZE_BITS - PAGE_SHIFT), and the
> >   *      worst combination is powerpc with 256k pages,
> >   *      which results in PFN_SECTION_SHIFT equal 6.
> > - * To sum it up, at least 6 bits are available.
> > + * To sum it up, at least 6 bits are available on all architectures.
> > + * However, we can exceed 6 bits on some other architectures except
> > + * powerpc (e.g. 15 bits are available on x86_64, 13 bits are available
> > + * with the worst case of 64K pages on arm64) if we make sure the
> > + * exceeded bit is not applicable to powerpc.
> >   */
> > -#define SECTION_MARKED_PRESENT		(1UL<<0)
> > -#define SECTION_HAS_MEM_MAP		(1UL<<1)
> > -#define SECTION_IS_ONLINE		(1UL<<2)
> > -#define SECTION_IS_EARLY		(1UL<<3)
> > -#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
> > -#define SECTION_MAP_LAST_BIT		(1UL<<5)
> > +#define ENUM_SECTION_FLAG(MAPPER)						\
> > +	MAPPER(MARKED_PRESENT)							\
> > +	MAPPER(HAS_MEM_MAP)							\
> > +	MAPPER(IS_ONLINE)							\
> > +	MAPPER(IS_EARLY)							\
> > +	MAPPER(TAINT_ZONE_DEVICE, CONFIG_ZONE_DEVICE)				\
> > +	MAPPER(MAP_LAST_BIT)
> > +
> > +#define __SECTION_SHIFT_FLAG_MAPPER_0(x)
> > +#define __SECTION_SHIFT_FLAG_MAPPER_1(x)	SECTION_##x##_SHIFT,
> > +#define __SECTION_SHIFT_FLAG_MAPPER(x, ...)	\
> > +	__PASTE(__SECTION_SHIFT_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
> > +
> > +#define __SECTION_FLAG_MAPPER_0(x)
> > +#define __SECTION_FLAG_MAPPER_1(x)		SECTION_##x = BIT(SECTION_##x##_SHIFT),
> > +#define __SECTION_FLAG_MAPPER(x, ...)		\
> > +	__PASTE(__SECTION_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
> > +
> > +enum {
> > +	/*
> > +	 * Generate a series of enumeration flags like SECTION_$name_SHIFT.
> > +	 * Each entry in ENUM_SECTION_FLAG() macro will be generated to one
> > +	 * enumeration iff the 2nd parameter of MAPPER() is defined or absent.
> > +	 * The $name comes from the 1st parameter of MAPPER() macro.
> > +	 */
> > +	ENUM_SECTION_FLAG(__SECTION_SHIFT_FLAG_MAPPER)
> > +	/*
> > +	 * Generate a series of enumeration flags like:
> > +	 *   SECTION_$name = BIT(SECTION_$name_SHIFT)
> > +	 */
> > +	ENUM_SECTION_FLAG(__SECTION_FLAG_MAPPER)
> > +};
> > +
> >  #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> > -#define SECTION_NID_SHIFT		6
> > +#define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT_SHIFT
> >  
> >  static inline struct page *__section_mem_map_addr(struct mem_section *section)
> >  {
> > @@ -1470,12 +1501,19 @@ static inline int online_section(struct mem_section *section)
> >  	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
> >  }
> >  
> > +#ifdef CONFIG_ZONE_DEVICE
> >  static inline int online_device_section(struct mem_section *section)
> >  {
> >  	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
> >  
> >  	return section && ((section->section_mem_map & flags) == flags);
> >  }
> > +#else
> > +static inline int online_device_section(struct mem_section *section)
> > +{
> > +	return 0;
> > +}
> > +#endif
> >  
> >  static inline int online_section_nr(unsigned long nr)
> >  {
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 1213d0c67a53..3b360eda933f 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -672,12 +672,18 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
> >  
> >  }
> >  
> > +#ifdef CONFIG_ZONE_DEVICE
> >  static void section_taint_zone_device(unsigned long pfn)
> >  {
> >  	struct mem_section *ms = __pfn_to_section(pfn);
> >  
> >  	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
> >  }
> > +#else
> > +static inline void section_taint_zone_device(unsigned long pfn)
> > +{
> > +}
> > +#endif
> >  
> >  /*
> >   * Associate the pfn range with the given zone, initializing the memmaps
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
> 
