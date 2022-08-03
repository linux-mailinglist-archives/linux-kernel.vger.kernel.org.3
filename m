Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F32588A18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiHCKDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiHCKDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D38D1838C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659520994;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHAatqq7WLX8aAM5p4x5ULy+iYVYaT/OkqKn6lCeb3U=;
        b=d94ZPjRUde9GSHRt3EQhGfiGWnxSZf5+pVp/2Nezj5+oJsLQldFQTfCcKq/o/mOwxGQFMj
        WGWX3UyZhAZxE7FrcRcXhztVzYxVkMYJrTv0+/e78O0ylFin2h2HCQb8jj+hiwuaQYXetl
        ZFwkPreQeYiH7Zf+Pn8SF0PG91U9usw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-wkUo5wziMbWs62sQIZhjZQ-1; Wed, 03 Aug 2022 06:03:13 -0400
X-MC-Unique: wkUo5wziMbWs62sQIZhjZQ-1
Received: by mail-qt1-f198.google.com with SMTP id k3-20020ac86043000000b0033cab47c483so1723922qtm.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 03:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=SHAatqq7WLX8aAM5p4x5ULy+iYVYaT/OkqKn6lCeb3U=;
        b=r0zOuNbehYmBSMf0LJcu+FyT+3OkDMHJy3/o36/yzW4jl/B1ueID3AyyIxoYkCT6b+
         UTBysRKA88ZR5jOqmxHItV9h0G1bC2cKgfKavfy3C96IPhz8OX1B9Pq86fkBmlaLVcyo
         2I7ttoaIwuPw/RwTzekrUboROww5ioW9HwdD0bxKOAKDUYfVa1D6T4C4GjFvV++EvySF
         JxelFwT3IMhLnGxQ/6gazwJA0Y5sN9PP0dy3bi0qJ9ZGYMTc4Suc8i2xCmXAbgFzfEu4
         jozlDBTpHXPT7W7eGSJFo1zoGeHwZpAq3/SCEF9pezDAmqeyHmQFbqg+n76d0hBU+dFn
         Gh4A==
X-Gm-Message-State: AJIora9/V1kw6KL6goBAquuOilOm32/aWMQhL6Qu+u8+C/i/inAS3yT6
        jxf/s4Llgo2PdlBLnEfSeOsTYdhlOifnf7JMinObNPsK+zyzakd4iImnSjDNb2eFnSXinCiaA6T
        lf/630ivDn9jpt9AdZmLzk9mm
X-Received: by 2002:ac8:5803:0:b0:31e:f49b:ed3a with SMTP id g3-20020ac85803000000b0031ef49bed3amr21430004qtg.46.1659520993059;
        Wed, 03 Aug 2022 03:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPTcMMZKqqwMRVSbno7QUDjIZ2Pu+sY7zLYFAUCeY3W3tdw5redRG5JkrQAtRAnIpbQqJwbg==
X-Received: by 2002:ac8:5803:0:b0:31e:f49b:ed3a with SMTP id g3-20020ac85803000000b0031ef49bed3amr21429989qtg.46.1659520992829;
        Wed, 03 Aug 2022 03:03:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a440200b006b5e50057basm12487432qkp.95.2022.08.03.03.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 03:03:11 -0700 (PDT)
Message-ID: <f2685007-0331-aaea-bfbe-074a3680fc29@redhat.com>
Date:   Wed, 3 Aug 2022 12:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Do not dereference fwnode in struct
 device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 8/2/22 21:35, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific dev_fwnode() and device_match_fwnode()
> APIs for that.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/acpi/viot.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index 647f11cf165d..6132092dab2a 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -88,7 +88,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
>  		return -ENODEV;
>  	}
>  
> -	fwnode = pdev->dev.fwnode;
> +	fwnode = dev_fwnode(&pdev->dev);
>  	if (!fwnode) {
>  		/*
>  		 * PCI devices aren't necessarily described by ACPI. Create a
> @@ -101,7 +101,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
>  		}
>  		set_primary_fwnode(&pdev->dev, fwnode);
>  	}
> -	viommu->fwnode = pdev->dev.fwnode;
> +	viommu->fwnode = dev_fwnode(&pdev->dev);
>  	pci_dev_put(pdev);
>  	return 0;
>  }
> @@ -314,7 +314,7 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
>  		return -ENODEV;
>  
>  	/* We're not translating ourself */
> -	if (viommu->fwnode == dev->fwnode)
> +	if (device_match_fwnode(dev, viommu->fwnode))
>  		return -EINVAL;
>  
>  	ops = iommu_ops_from_fwnode(viommu->fwnode);

