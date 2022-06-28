Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8055F1BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 01:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiF1XDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 19:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiF1XDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 19:03:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023543AA73;
        Tue, 28 Jun 2022 16:03:02 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57F226601606;
        Wed, 29 Jun 2022 00:03:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656457380;
        bh=Xx8ffEFVOiMAvlbG4WQ8kQdSHI8x62r0e8FnRe66H5A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cUrbQi2u+NfJZa7ovUFgPSvOjrAoMv6bSVz6vbwC/0GSNUfD1OxCCQ4NnEdXIBw09
         uMChh34MoyvSSxfXgZ4ac6jNb9TcAKGK5nrW3jMlq1i59UvRTFzAhoOxZF4CAsce+s
         1FKpqUL3qgvIqGvGS+gjpjfXUh+ft7dxrDfwllbCUxHU5cXXJFjF/3Zjd1qk9ilmWr
         8nISzsCFt6oY9N42kSImjqK2lVcWb1C64h/F64fZbMJvEibL21Slig+w87nU2X+dO7
         w2mAo+7/gBiN03zyuXcDtyVDdnN00XqDb7Zd5CAOlUzAv9UkUbUWtPAk29GaTwpeq+
         6k5DRs8dMdnig==
Message-ID: <53794ec1-c9b9-67df-ccd2-5ce46f264b5a@collabora.com>
Date:   Wed, 29 Jun 2022 02:02:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next] soc/tegra: fuse: Add missing DMADEVICES dependency
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220628121039.21640-1-yuehaibing@huawei.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220628121039.21640-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 15:10, YueHaibing wrote:
> WARNING: unmet direct dependencies detected for TEGRA20_APB_DMA
>   Depends on [n]: DMADEVICES [=n] && (ARCH_TEGRA [=y] || COMPILE_TEST [=n])
>   Selected by [y]:
>   - SOC_TEGRA_FUSE [=y] && ARCH_TEGRA [=y] && ARCH_TEGRA_2x_SOC [=y]
> 
> TEGRA20_APB_DMA depends on DMADEVICES, so SOC_TEGRA_FUSE also should depends on it
> before select it.
> 
> Fixes: 19d41e5e9c68 ("soc/tegra: fuse: Add APB DMA dependency for Tegra20")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/soc/tegra/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
> index 5725c8ef0406..2b6ba0f798fa 100644
> --- a/drivers/soc/tegra/Kconfig
> +++ b/drivers/soc/tegra/Kconfig
> @@ -135,6 +135,7 @@ endif
>  config SOC_TEGRA_FUSE
>  	def_bool y
>  	depends on ARCH_TEGRA
> +	depends on DMADEVICES
>  	select SOC_BUS
>  	select TEGRA20_APB_DMA if ARCH_TEGRA_2x_SOC
>  

Since it's a problem only for the Tegra20 config, shouldn't it be:

-  select TEGRA20_APB_DMA if ARCH_TEGRA_2x_SOC
+  select TEGRA20_APB_DMA if (ARCH_TEGRA_2x_SOC && DMADEVICES)

?

-- 
Best regards,
Dmitry
