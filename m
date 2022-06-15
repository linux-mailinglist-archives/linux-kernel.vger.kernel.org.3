Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2054C4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbiFOJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347973AbiFOJfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C81A225E86
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655285713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDQf++O5Povpr9/MTkGUovRB/Hb0K7Xk0pSbUnRMSQo=;
        b=ekxx31zs3gNBFFQN5Upp8IWx35uH+HpArVTZXwyccOh7j7IclEHgBzl1fkNClRhzkGoK/D
        hf4Uacz5bzd/1wjXqt2FRrb+CQv0bvziYdKuAeXPLcLCtjKwdfop6VjrVJOl7oqQd+4C2r
        pGAS+T1MFC6aQwWvu9gDK2bonJnr9uo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-_I9q69K3MB-R9IGpyTaVXQ-1; Wed, 15 Jun 2022 05:35:12 -0400
X-MC-Unique: _I9q69K3MB-R9IGpyTaVXQ-1
Received: by mail-wm1-f69.google.com with SMTP id p6-20020a05600c358600b0039c873184b9so971452wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=GDQf++O5Povpr9/MTkGUovRB/Hb0K7Xk0pSbUnRMSQo=;
        b=ABuF04uXb2ewcwzDdKsly4VNbQ35iBA55ZmeFVnxKaR4DGoN9jLz4Hp7XSC8NIY91D
         1tk7Qcjxo7/Q9ZQ5hYoI+CuatBOuHPttbSqz56mP8wCKrRmEav/38X2dYch3OmLInkgl
         MUh4AfqKpY397YBnaHK55dGRchWu80jH68pMeesCqE/K6jw6mPSv+LXh9BYRpSkRZJQP
         OEtGo3FoD4FEcnpIIXu4lcF/1f0KDKh60pNB9FRGtXipSwwF0N/gLG1TIAt/ZW8NBU49
         JMtyt/edmekh3yxiVLgMmfS17PJ9aOxKDBct1xjYlgX8LTT1YbZeAJqU+KYBcf5vVTj7
         vV7w==
X-Gm-Message-State: AJIora+kMkfAgXaDa/12cUFOq4OdvUWIeegjQu57mD3qs8WBa47TzWiN
        NKstLkPTjLSGHAwz5f/Eg/BbQvr48MVg5fgYyn4uzZHjtJ2O7rPrJ6qbGIPQy5hJZLRjhYML2cg
        poZXj25Ln27AArcprPAGln9xY
X-Received: by 2002:a5d:44d1:0:b0:218:418a:3e8e with SMTP id z17-20020a5d44d1000000b00218418a3e8emr9093839wrr.112.1655285711148;
        Wed, 15 Jun 2022 02:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usrRKHDlRrMRggLDYWYnub1eXo3xJ7dJE30Bxlc74UafUJUr+6XV2sS6N/BEXdlP6jd9dMXA==
X-Received: by 2002:a5d:44d1:0:b0:218:418a:3e8e with SMTP id z17-20020a5d44d1000000b00218418a3e8emr9093812wrr.112.1655285710878;
        Wed, 15 Jun 2022 02:35:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:2700:1d28:26c3:b272:fcc6? (p200300cbc70a27001d2826c3b272fcc6.dip0.t-ipconnect.de. [2003:cb:c70a:2700:1d28:26c3:b272:fcc6])
        by smtp.gmail.com with ESMTPSA id c186-20020a1c35c3000000b0039c948dbb61sm1757510wma.26.2022.06.15.02.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:35:10 -0700 (PDT)
Message-ID: <62aef8a9-aa21-37ec-83b5-9dd9fc729890@redhat.com>
Date:   Wed, 15 Jun 2022 11:35:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, osalvador@suse.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/2] mm: memory_hotplug: enumerate all supported
 section flags
In-Reply-To: <20220520025538.21144-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.22 04:55, Muchun Song wrote:
> We are almost running out of section flags, only one bit is available in
> the worst case (powerpc with 256k pages).  However, there are still some
> free bits (in ->section_mem_map) on other architectures (e.g. x86_64 has
> 10 bits available, arm64 has 8 bits available with worst case of 64K
> pages).  We have hard coded those numbers in code, it is inconvenient to
> use those bits on other architectures except powerpc.  So transfer those
> section flags to enumeration to make it easy to add new section flags in
> the future.  Also, move SECTION_TAINT_ZONE_DEVICE into the scope of
> CONFIG_ZONE_DEVICE to save a bit on non-zone-device case.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Sorry for the late reply. This looks overly complicated to me.

IOW, staring at that patch I don't quite like what I am seeing.


Something like the following is *a lot* easier to read than some
MAPPER macro magic. What speaks against it?

/*
 * Section bits use the lower unused bits in the ->section_mem_map
 */
enum {
	SECTION_MARKED_PRESENT_BIT = 0,
	SECTION_HAS_MEM_MAP_BIT,
	...
#ifdef ZONE_DEVICE
	SECTION_TAINT_ZONE_DEVICE_BIT
#endif
}

#define SECTION_MARKED_PRESENT	   (1ULL << SECTION_MARKED_PRESENT_BIT)
...
#ifdef ZONE_DEVICE
#define SECTION_TAINT_ZONE_DEVICE  (1ULL << SECTION_TAINT_ZONE_DEVICE_BIT)
#endif /* ZONE_DEVICE */



> ---
>  include/linux/kconfig.h |  1 +
>  include/linux/mmzone.h  | 54 +++++++++++++++++++++++++++++++++++++++++--------
>  mm/memory_hotplug.c     |  6 ++++++
>  3 files changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index 20d1079e92b4..7044032b9f42 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -10,6 +10,7 @@
>  #define __LITTLE_ENDIAN 1234
>  #endif
>  
> +#define __ARG_PLACEHOLDER_ 0,
>  #define __ARG_PLACEHOLDER_1 0,
>  #define __take_second_arg(__ignored, val, ...) val
>  
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 299259cfe462..2cf2a76535ab 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1422,16 +1422,47 @@ extern size_t mem_section_usage_size(void);
>   *      (equal SECTION_SIZE_BITS - PAGE_SHIFT), and the
>   *      worst combination is powerpc with 256k pages,
>   *      which results in PFN_SECTION_SHIFT equal 6.
> - * To sum it up, at least 6 bits are available.
> + * To sum it up, at least 6 bits are available on all architectures.
> + * However, we can exceed 6 bits on some other architectures except
> + * powerpc (e.g. 15 bits are available on x86_64, 13 bits are available
> + * with the worst case of 64K pages on arm64) if we make sure the
> + * exceeded bit is not applicable to powerpc.
>   */
> -#define SECTION_MARKED_PRESENT		(1UL<<0)
> -#define SECTION_HAS_MEM_MAP		(1UL<<1)
> -#define SECTION_IS_ONLINE		(1UL<<2)
> -#define SECTION_IS_EARLY		(1UL<<3)
> -#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
> -#define SECTION_MAP_LAST_BIT		(1UL<<5)
> +#define ENUM_SECTION_FLAG(MAPPER)						\
> +	MAPPER(MARKED_PRESENT)							\
> +	MAPPER(HAS_MEM_MAP)							\
> +	MAPPER(IS_ONLINE)							\
> +	MAPPER(IS_EARLY)							\
> +	MAPPER(TAINT_ZONE_DEVICE, CONFIG_ZONE_DEVICE)				\
> +	MAPPER(MAP_LAST_BIT)
> +
> +#define __SECTION_SHIFT_FLAG_MAPPER_0(x)
> +#define __SECTION_SHIFT_FLAG_MAPPER_1(x)	SECTION_##x##_SHIFT,
> +#define __SECTION_SHIFT_FLAG_MAPPER(x, ...)	\
> +	__PASTE(__SECTION_SHIFT_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
> +
> +#define __SECTION_FLAG_MAPPER_0(x)
> +#define __SECTION_FLAG_MAPPER_1(x)		SECTION_##x = BIT(SECTION_##x##_SHIFT),
> +#define __SECTION_FLAG_MAPPER(x, ...)		\
> +	__PASTE(__SECTION_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
> +
> +enum {
> +	/*
> +	 * Generate a series of enumeration flags like SECTION_$name_SHIFT.
> +	 * Each entry in ENUM_SECTION_FLAG() macro will be generated to one
> +	 * enumeration iff the 2nd parameter of MAPPER() is defined or absent.
> +	 * The $name comes from the 1st parameter of MAPPER() macro.
> +	 */
> +	ENUM_SECTION_FLAG(__SECTION_SHIFT_FLAG_MAPPER)
> +	/*
> +	 * Generate a series of enumeration flags like:
> +	 *   SECTION_$name = BIT(SECTION_$name_SHIFT)
> +	 */
> +	ENUM_SECTION_FLAG(__SECTION_FLAG_MAPPER)
> +};
> +
>  #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> -#define SECTION_NID_SHIFT		6
> +#define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT_SHIFT
>  
>  static inline struct page *__section_mem_map_addr(struct mem_section *section)
>  {
> @@ -1470,12 +1501,19 @@ static inline int online_section(struct mem_section *section)
>  	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
>  }
>  
> +#ifdef CONFIG_ZONE_DEVICE
>  static inline int online_device_section(struct mem_section *section)
>  {
>  	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
>  
>  	return section && ((section->section_mem_map & flags) == flags);
>  }
> +#else
> +static inline int online_device_section(struct mem_section *section)
> +{
> +	return 0;
> +}
> +#endif
>  
>  static inline int online_section_nr(unsigned long nr)
>  {
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 1213d0c67a53..3b360eda933f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -672,12 +672,18 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>  
>  }
>  
> +#ifdef CONFIG_ZONE_DEVICE
>  static void section_taint_zone_device(unsigned long pfn)
>  {
>  	struct mem_section *ms = __pfn_to_section(pfn);
>  
>  	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
>  }
> +#else
> +static inline void section_taint_zone_device(unsigned long pfn)
> +{
> +}
> +#endif
>  
>  /*
>   * Associate the pfn range with the given zone, initializing the memmaps


-- 
Thanks,

David / dhildenb

