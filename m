Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81ED5511DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiFTHv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbiFTHvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0301A101F7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655711512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yjoa1DMFRC4sDiSMpzTkndxHuKmwJoDSdtI3MTSI+I4=;
        b=fpn1nCONECGLUMHDipaz12wP6RTh91u2GDHGTakgKiIZpmxqTWneauXtizAoaivgiYVHDc
        evj9Z2aHuJgM348udtkdGXORXwVG+VbFf5/Wzn54Buih1FkZBRdBlYVlBoWCG7TwOzQ1VW
        F6ti8weUUb/kRMyzCWUno3eFJvRJ+9Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-5MtJVZkXNUaG1U51D4At1g-1; Mon, 20 Jun 2022 03:51:45 -0400
X-MC-Unique: 5MtJVZkXNUaG1U51D4At1g-1
Received: by mail-wm1-f69.google.com with SMTP id be12-20020a05600c1e8c00b0039c506b52a4so5534917wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=yjoa1DMFRC4sDiSMpzTkndxHuKmwJoDSdtI3MTSI+I4=;
        b=ZuGxeSxfzQ3y+G3pDf9YPeg5u8O3gTnt81xdn+x2RVAnRbkCBWZQghlrhTVsfrAOec
         kpbXg10WwezvcAsgTLmuCVA07qoDaEFlQdS5f3YKECQqrFiCGycczDt4VBhXWstoHNcm
         qain5LYp5PwsGAM345t3QDk2NFllCidqkKEcY9wXKAqXL28fBibH16B6dXpr+vcn/bKY
         he2BFfiASb0X+1CzGYKquBqFHFc0qQhqjU1wwnaSKbSaUZ16b4DzxB8Qq01xBtLGKphp
         I+4vS9DJTykrZANlf/I7+OC61J8D7DKTLjvSiy5CK/HFtBZmhc/deMvE1Kw+Y+2G4mvg
         gp5w==
X-Gm-Message-State: AJIora/4gBU5vf4yiEY8l9xFnMhpYaKE6Sg/YdnYOGsJUnnpH/uO5kcv
        j5Rw+bMW6G68LV33gRMjVFMLrQDcFCSpiG1prd2lscpjXsM8RqoEpc01zojSF0T3AAH1itDjn1f
        B0OjXbrPJet5dx06cH7h02UVL
X-Received: by 2002:a1c:f20b:0:b0:39e:f4b9:24e3 with SMTP id s11-20020a1cf20b000000b0039ef4b924e3mr12724059wmc.51.1655711504575;
        Mon, 20 Jun 2022 00:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stvnVfC36AP5yjx+OVuzg3RFUKA1Vn0pstbCqQkPk8/+gvIZbX5tuF4RE5q9ZTq8HuH46hNg==
X-Received: by 2002:a1c:f20b:0:b0:39e:f4b9:24e3 with SMTP id s11-20020a1cf20b000000b0039ef4b924e3mr12724036wmc.51.1655711504283;
        Mon, 20 Jun 2022 00:51:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f04:2500:cdb0:9b78:d423:43f? (p200300d82f042500cdb09b78d423043f.dip0.t-ipconnect.de. [2003:d8:2f04:2500:cdb0:9b78:d423:43f])
        by smtp.gmail.com with ESMTPSA id v6-20020adfa1c6000000b0021b8905e797sm5510805wrv.69.2022.06.20.00.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 00:51:43 -0700 (PDT)
Message-ID: <b3226af2-5d19-5377-9072-179388cb2609@redhat.com>
Date:   Mon, 20 Jun 2022 09:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 1/2] mm: memory_hotplug: enumerate all supported
 section flags
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        corbet@lwn.net, mike.kravetz@oracle.com, osalvador@suse.de,
        paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220619133851.68184-1-songmuchun@bytedance.com>
 <20220619133851.68184-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220619133851.68184-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.22 15:38, Muchun Song wrote:
> We are almost running out of section flags, only one bit is available in
> the worst case (powerpc with 256k pages).  However, there are still some
> free bits (in ->section_mem_map) on other architectures (e.g. x86_64 has
> 10 bits available, arm64 has 8 bits available with worst case of 64K
> pages).  We have hard coded those numbers in code, it is inconvenient to
> use those bits on other architectures except powerpc.  So transfer those
> section flags to enumeration to make it easy to add new section flags in
> the future. Also, move SECTION_TAINT_ZONE_DEVICE into the scope of
> CONFIG_ZONE_DEVICE to save a bit on non-zone-device case.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/mmzone.h | 44 +++++++++++++++++++++++++++++++++++---------
>  mm/memory_hotplug.c    |  6 ++++++
>  mm/sparse.c            |  2 +-
>  3 files changed, 42 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aab70355d64f..932843c6459b 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1418,16 +1418,35 @@ extern size_t mem_section_usage_size(void);
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
> -#define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> -#define SECTION_NID_SHIFT		6
> +enum {
> +	SECTION_MARKED_PRESENT_BIT,
> +	SECTION_HAS_MEM_MAP_BIT,
> +	SECTION_IS_ONLINE_BIT,
> +	SECTION_IS_EARLY_BIT,
> +#ifdef CONFIG_ZONE_DEVICE
> +	SECTION_TAINT_ZONE_DEVICE_BIT,
> +#endif
> +	SECTION_MAP_LAST_BIT,
> +};
> +
> +enum {
> +	SECTION_MARKED_PRESENT		= BIT(SECTION_MARKED_PRESENT_BIT),
> +	SECTION_HAS_MEM_MAP		= BIT(SECTION_HAS_MEM_MAP_BIT),
> +	SECTION_IS_ONLINE		= BIT(SECTION_IS_ONLINE_BIT),
> +	SECTION_IS_EARLY		= BIT(SECTION_IS_EARLY_BIT),
> +#ifdef CONFIG_ZONE_DEVICE
> +	SECTION_TAINT_ZONE_DEVICE	= BIT(SECTION_TAINT_ZONE_DEVICE_BIT),
> +#endif
> +};

I can understand the reason for the other enum, to auto-assing numbers.
What's the underlying reason for the enum here? Personally, I'd just
stay with defines, so I'm curious :)

LGTM

-- 
Thanks,

David / dhildenb

