Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A404635CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241727AbhK3Nw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:52:57 -0500
Received: from cpanel.siel.si ([46.19.9.99]:40168 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240008AbhK3Nw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:Subject:Sender:Reply-To:To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=UUkiGbBHuD3eoYdG87cPn3KIRvGU68JXHLpxrL5OQnA=; b=WarnI8/lds1InnXOVfZIELG5iC
        O/avmgMNYpz41a5i//VEf3U/fQwgciuiunGT99nwUmKSxoSK73VXihYsveJroy5+uDP+Qe5oMjW5I
        E+lllwkkgfoCRb+U757HjUN4BEgtrI9HsuMIq2b9wnv52bzQ9JCSg3+cudIA6GmZ+5rknHSuKqUnC
        QrQaZqD6Ta30XUcCCg06d8BMS39kqhAudcr/6Zrp5WkiEp3Q4/T8N5HpPGGTjUIZzqgt3XlfUOfgy
        YZmORsYGSiq7/l8SOt+toJXPeaKKR8ri286dZ2vffRhyrcb5KWuKHPNPPMnqA/orWqlzMa9AQkP4U
        hcz6eYBQ==;
Received: from [89.212.21.243] (port=49774 helo=[192.168.69.215])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1ms3Vj-003AE3-EG; Tue, 30 Nov 2021 14:49:31 +0100
Subject: Re: [PATCH v2 1/4] mfd: da9062: make register CONFIG_I writable
Cc:     support.opensource@diasemi.com, wim@linux-watchdog.org,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
References: <20211130134242.3516619-1-andrej.picej@norik.com>
From:   Andrej Picej <andrej.picej@norik.com>
Message-ID: <b62b026d-3f89-6638-d2b9-c8ddd002458b@norik.com>
Date:   Tue, 30 Nov 2021 14:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130134242.3516619-1-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30. 11. 21 14:42, Andrej Picej wrote:
> From: Stefan Christ <s.christ@phytec.de>
> 
> Make the config register CONFIG_I writable to change the watchdog mode.
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>   drivers/mfd/da9062-core.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> index 01f8e10dfa55..7041ba53efb4 100644
> --- a/drivers/mfd/da9062-core.c
> +++ b/drivers/mfd/da9062-core.c
> @@ -556,6 +556,7 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
>   	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
>   	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
>   	regmap_reg_range(DA9062AA_BBAT_CONT, DA9062AA_BBAT_CONT),
> +	regmap_reg_range(DA9062AA_CONFIG_I, DA9062AA_CONFIG_I),
>   	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
>   };
>   
> 

Changes in v2:
- no changes

sorry, just noticed I forgot to add what I changed for v2 patch series.
Should I resend the patches with that fixed/added? Should that be v3 
then or still v2?

Thanks.
