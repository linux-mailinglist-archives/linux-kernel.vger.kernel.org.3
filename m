Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE647C586
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbhLURyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236858AbhLURyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640109275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGS1oJla6QGUKhGeKaKyvYjrz9cePxqx4mClWlQtFrU=;
        b=RuWPw0w/igftuv+xptIdn5DyN7RHWeOGd90mhmwNfbEfM4xJ/Bju6qJP6hbxeNyiqWCnqx
        OUcWeQisr4tTl359I3uySJTiLV1rkcrMK2gYLhiHQYnYIFuZjB0F0Q9j6iGdGw81bF0lzL
        K3HCFvOo25k96z2FCmNXr0Pd2qJf8Gg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-Oxj0TaF9PXO1js14tuDH1g-1; Tue, 21 Dec 2021 12:54:33 -0500
X-MC-Unique: Oxj0TaF9PXO1js14tuDH1g-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b003f81d896346so10143421eda.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DGS1oJla6QGUKhGeKaKyvYjrz9cePxqx4mClWlQtFrU=;
        b=csoYrGPO3A0fvmbGMGuX7beVBO0Q+Eg+TrbiewKheLWY2p19qxBUB7MmyZhmvSxt7S
         WGl2wVSn9sNP87hfwh+be/alGBFsWCzvOh/sNcz42idxsBRvJaugucc1rtcwPYEbNmey
         dn5akcjxLgooq2TUd1f/0xW7NqB9/QCHi64b4/i4pX1KTzoVJuhJZoMr1kTUWjLnyY2g
         ZgXSAZ+uQQ713ky9MECyXvrnl83qNea3MZFd/2G47zW0l4/yrrm9329EpEW4oS1cbVJS
         HgcfmRkFDJLL7fMA5vJLwNaROrT4/c/oHQu0kGujKhHRRy+NvroU4KLUMUDD8QGhEWoN
         WK1g==
X-Gm-Message-State: AOAM532B6p2yeV7NzlyfNoybB0d7EgkPo2Yy2z7AzGQOJFgENzQtEDIV
        oGjztiiQJsb5MoMAcQOEHWdz0kWYX/k6AktT01QvRVq79rutKW2Uym7Xr9oPSIWKP8hWfGFpFQz
        k0woQKRWjE7Z98pJWmPhaL1PT
X-Received: by 2002:a05:6402:1e90:: with SMTP id f16mr4305212edf.112.1640109272785;
        Tue, 21 Dec 2021 09:54:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYSUID+ibg78YBB4JBE/3CZdeGHfvi7Wq9NfEJXnjQEi9w+DxYprGDBY/4MTfmqmWjjVL9Tw==
X-Received: by 2002:a05:6402:1e90:: with SMTP id f16mr4305190edf.112.1640109272583;
        Tue, 21 Dec 2021 09:54:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id mq7sm4907027ejc.172.2021.12.21.09.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:54:32 -0800 (PST)
Message-ID: <4cedccf8-2ff3-b89f-d6e8-13bad17a86bd@redhat.com>
Date:   Tue, 21 Dec 2021 18:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] platform/mellanox: mlxbf-pmc: Fix an IS_ERR() vs NULL bug
 in mlxbf_pmc_map_counters
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211210070753.10761-1-linmq006@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211210070753.10761-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/10/21 08:07, Miaoqian Lin wrote:
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers. Also according to doc of device_property_read_u64_array,
> values in info array are properties of device or NULL.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/mellanox/mlxbf-pmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
> index 04bc3b50aa7a..65b4a819f1bd 100644
> --- a/drivers/platform/mellanox/mlxbf-pmc.c
> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
> @@ -1374,8 +1374,8 @@ static int mlxbf_pmc_map_counters(struct device *dev)
>  		pmc->block[i].counters = info[2];
>  		pmc->block[i].type = info[3];
>  
> -		if (IS_ERR(pmc->block[i].mmio_base))
> -			return PTR_ERR(pmc->block[i].mmio_base);
> +		if (!pmc->block[i].mmio_base)
> +			return -ENOMEM;
>  
>  		ret = mlxbf_pmc_create_groups(dev, i);
>  		if (ret)
> 

