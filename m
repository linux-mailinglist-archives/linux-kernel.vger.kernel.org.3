Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260D5587B31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiHBLAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiHBLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28B4013E37
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 04:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659438026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJ6goYLsX5C+yTaCJPNre3d6qfx4iGoRBFFTCYqO9mg=;
        b=TOjngPX3m82/AgOWtf2YL54DLHHOXlKXtBs6rJ4ShpWHmc+b9pG+DFPHs4zCTCOy6FSLjs
        quxm8UwHW6AJCJkrXGjNMZb29z4cZBAwCPnnXJCczjsAcQIxSjckjwoaTaGGA/3bdelGf0
        n0+B4EE6EtrqcXK1WKflAuXUi8vR77U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-033l12qZOCqYpH8K4bmkKw-1; Tue, 02 Aug 2022 07:00:25 -0400
X-MC-Unique: 033l12qZOCqYpH8K4bmkKw-1
Received: by mail-ed1-f71.google.com with SMTP id j19-20020a05640211d300b0043ddce5c23aso1956701edw.14
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 04:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xJ6goYLsX5C+yTaCJPNre3d6qfx4iGoRBFFTCYqO9mg=;
        b=w6N57K+My+eClgkyz00GZL+dlMRz5jKH6v6wWRNXnxzmcEatmNh0FODGdkl0/x55qi
         hLY1BI4TXoIgYQzEmLT3hoeipms3yn1WSqJZW57E54joE4vZsc1I/vYwTiL6sIKXB+81
         9YmwVxDKbmEYWZVdtoi/T8bVhku0a1KHCX29MLcEZeiW9P1IPEQ7fjIDHOUR3kxlEmDB
         2tkfTVGK1jmoVK6Gjr3CQGKIKDq7SEcs+whmBVWv1pJFcG41xqecCP7zahEqIlFPJh2L
         yi0KvCQqwEGYeC/SGSIEiUTJWakVOUTqbvWe2wZdbmXbzTnTJSJaYQhbtFR+u0tBhsuh
         kpEw==
X-Gm-Message-State: ACgBeo39IcP8qkQKWZd9Vt+TiHazfrbtMaCfBAbjl15qzioIok74jT5l
        gh7icFdwfdlhDpZuByhuIMy0PwI29DjYQpCATdbQP0tbAyhDIfx1TJ6T3vNsHBAyEFrCXmX5HXZ
        ljVSGaxWjuq0d1GawSyb/qmYC
X-Received: by 2002:a05:6402:2755:b0:43d:7568:c78e with SMTP id z21-20020a056402275500b0043d7568c78emr12185420edd.104.1659438024024;
        Tue, 02 Aug 2022 04:00:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7wenvZ6H4t+/xkk0JBUWMSDv2NZrtbupC0xYJYdLYkbUs+HEkLnUxumivyHZaRuNQ1ouWezA==
X-Received: by 2002:a05:6402:2755:b0:43d:7568:c78e with SMTP id z21-20020a056402275500b0043d7568c78emr12185409edd.104.1659438023864;
        Tue, 02 Aug 2022 04:00:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u25-20020a17090617d900b0072f4f4dc038sm6116478eje.42.2022.08.02.04.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 04:00:23 -0700 (PDT)
Message-ID: <6820bd94-1476-b1dc-e325-22b958aea696@redhat.com>
Date:   Tue, 2 Aug 2022 13:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] platform/x86: pmc_atom: Fix SLP_TYPx bitfield mask
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
References: <20220801113734.36131-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220801113734.36131-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/1/22 13:37, Andy Shevchenko wrote:
> On Intel hardware the SLP_TYPx bitfield occupies bits 10-12 as per ACPI
> specification (see Table 4.13 "PM1 Control Registers Fixed Hardware
> Feature Control Bits" for the details).
> 
> Fix the mask and other related definitions accordingly.
> 
> Fixes: 93e5eadd1f6e ("x86/platform: New Intel Atom SOC power management controller driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch-series, I've applied this series to my
review-hans branch:
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
> v2: addressed compilation error
>  drivers/platform/x86/pmc_atom.c            | 2 +-
>  include/linux/platform_data/x86/pmc_atom.h | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
> index b8b1ed1406de..c220172fefbb 100644
> --- a/drivers/platform/x86/pmc_atom.c
> +++ b/drivers/platform/x86/pmc_atom.c
> @@ -232,7 +232,7 @@ static void pmc_power_off(void)
>  	pm1_cnt_port = acpi_base_addr + PM1_CNT;
>  
>  	pm1_cnt_value = inl(pm1_cnt_port);
> -	pm1_cnt_value &= SLEEP_TYPE_MASK;
> +	pm1_cnt_value &= ~SLEEP_TYPE_MASK;
>  	pm1_cnt_value |= SLEEP_TYPE_S5;
>  	pm1_cnt_value |= SLEEP_ENABLE;
>  
> diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
> index 6807839c718b..ea01dd80153b 100644
> --- a/include/linux/platform_data/x86/pmc_atom.h
> +++ b/include/linux/platform_data/x86/pmc_atom.h
> @@ -7,6 +7,8 @@
>  #ifndef PMC_ATOM_H
>  #define PMC_ATOM_H
>  
> +#include <linux/bits.h>
> +
>  /* ValleyView Power Control Unit PCI Device ID */
>  #define	PCI_DEVICE_ID_VLV_PMC	0x0F1C
>  /* CherryTrail Power Control Unit PCI Device ID */
> @@ -139,9 +141,9 @@
>  #define	ACPI_MMIO_REG_LEN	0x100
>  
>  #define	PM1_CNT			0x4
> -#define	SLEEP_TYPE_MASK		0xFFFFECFF
> +#define	SLEEP_TYPE_MASK		GENMASK(12, 10)
>  #define	SLEEP_TYPE_S5		0x1C00
> -#define	SLEEP_ENABLE		0x2000
> +#define	SLEEP_ENABLE		BIT(13)
>  
>  extern int pmc_atom_read(int offset, u32 *value);
>  

