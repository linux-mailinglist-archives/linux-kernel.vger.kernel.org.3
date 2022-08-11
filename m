Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77D05906C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiHKSwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbiHKSwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 241779E10F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660243960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNyZEMFVFrFa8kgVwgLPqAYNcLyvy1ZrbXPv11GN+Lc=;
        b=fRjb3h4ZRxzD7SF24HAd+Q/IpazD8g3tsb5sanEXr/mREG6izyCQQkFNzXYmQEKiZtKEx6
        S43+yrZaWkEu4SrpSaTMZXZbbOUaTqZlFV/TuyuW8iaNB+STdP/yd8XdQTDb31HX/KZunh
        8K2hkifT8mRh7ryZbCfwHlF/EejDFP0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-flTzqUUuM4ec4ZiypNciiQ-1; Thu, 11 Aug 2022 14:52:38 -0400
X-MC-Unique: flTzqUUuM4ec4ZiypNciiQ-1
Received: by mail-ed1-f70.google.com with SMTP id r12-20020a05640251cc00b00440647ec649so9122503edd.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JNyZEMFVFrFa8kgVwgLPqAYNcLyvy1ZrbXPv11GN+Lc=;
        b=6KfyG4kijtzLbNJMczyApMC+Ibsv3jsXe9VH4P8qRsbO3ll9K43VMv+d7i07zbTjb7
         EalbEX7m34xWQD57ygnKKZsq/HNDqkP0FAXGsxdtXf43eyt46HKanddWMiv3lDSMzcKE
         ArUOt0JCTfvrJ0ki2g0wJFcDiRuhJ1NYlA9twVQ6SJsuFjxupLV/3vMofOLZV4gjxSc8
         d5cxx9VBFFaCRZPGKUoc0gDAKmeg2oPyZd6rNzB1NJhlB0R06N7V1q7Hyp/enjGHDG7x
         Xz6Sqc1hFRoLmy4UnwcH9NhkFVtGhDPW6v2SF9f+fDK8w7WlOIYhdKC48ja5Ko0T5rQX
         j3qg==
X-Gm-Message-State: ACgBeo0j0taMeA3o53MU/EAoz2nZJ5e5OnKSEiiuCyspKP6xOm8aJLH+
        lyBQRHo0INfnLDKI8qNMHnn5Lue23ej31dKMygrn8+jdyOnwPKBna01M9cm503W+FzECLGc2yNX
        7fRAQkfq69k/U3w/i/NvtIY1m
X-Received: by 2002:a17:906:58c9:b0:730:bc01:fd5f with SMTP id e9-20020a17090658c900b00730bc01fd5fmr285312ejs.504.1660243957646;
        Thu, 11 Aug 2022 11:52:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5QYwkiMxkhhAF6jyTpAT0xoUswSga2mCJmeC6MtRkrn/UJ/PwLYSmER42bg7a8X/iW83cwiA==
X-Received: by 2002:a17:906:58c9:b0:730:bc01:fd5f with SMTP id e9-20020a17090658c900b00730bc01fd5fmr285297ejs.504.1660243957406;
        Thu, 11 Aug 2022 11:52:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ck26-20020a0564021c1a00b0043d7b19abd0sm119740edb.39.2022.08.11.11.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 11:52:37 -0700 (PDT)
Message-ID: <a019bd66-e53b-0993-77a0-c31c687c5f6f@redhat.com>
Date:   Thu, 11 Aug 2022 20:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] platform/surface: aggregator_registry: Add support for
 Surface Laptop Go 2
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220810140133.99087-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220810140133.99087-1-luzmaximilian@gmail.com>
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

Hi,

On 8/10/22 16:01, Maximilian Luz wrote:
> The Surface Laptop Go 2 seems to have the same SAM client devices as the
> Surface Laptop Go 1, so re-use its node group.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Patches which are added to review-hans now are intended for
the next rc1. This branch will get rebased to the next rc1 when
it is out and after the rebasing the contents of review-hans
will be pushed to the platform-drivers-x86/for-next branch.

Regards,

Hans


> ---
>  drivers/platform/surface/surface_aggregator_registry.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
> index ce2bd88feeaa..08019c6ccc9c 100644
> --- a/drivers/platform/surface/surface_aggregator_registry.c
> +++ b/drivers/platform/surface/surface_aggregator_registry.c
> @@ -556,6 +556,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
>  	/* Surface Laptop Go 1 */
>  	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
>  
> +	/* Surface Laptop Go 2 */
> +	{ "MSHW0290", (unsigned long)ssam_node_group_slg1 },
> +
>  	/* Surface Laptop Studio */
>  	{ "MSHW0123", (unsigned long)ssam_node_group_sls },
>  

