Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B761449E329
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbiA0NRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:17:13 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:54946 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241599AbiA0NRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:17:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5D54647488;
        Thu, 27 Jan 2022 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:mime-version:user-agent:content-type
        :content-type:organization:references:in-reply-to:date:date:from
        :from:subject:subject:message-id:received:received:received; s=
        mta-01; t=1643289429; x=1645103830; bh=yz721TDYQ962zWbABUm+tMaP3
        8DnE0T4+JBq6o/c3Jg=; b=AKXdj9m/jZvUnHRJ+oyWde3btXPVpbmO9tr7IhoSv
        +kaJpZHJlhA3sasIV980rpff7ZcPN6Z67SEM6+2B1FffxHCg7n6UisjFKT5duHE8
        j0dioJRLYNHYh9QNNlQ5N3Xf1zhIyLoqfdDl4iRGck/aV2BYgZ6Oi2a+ocoRRQRo
        Hg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yef_zfYPRlTr; Thu, 27 Jan 2022 16:17:09 +0300 (MSK)
Received: from T-EXCH-04.corp.yadro.com (t-exch-04.corp.yadro.com [172.17.100.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 70BD846B36;
        Thu, 27 Jan 2022 16:17:05 +0300 (MSK)
Received: from [10.199.0.85] (10.199.0.85) by T-EXCH-04.corp.yadro.com
 (172.17.100.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 27
 Jan 2022 16:17:04 +0300
Message-ID: <b5e8f3defc6715fbc0798a5c490d588e247335bc.camel@yadro.com>
Subject: Re: [PATCH] ARM: dts: aspeed: remove unhandled fttmr010,pwm-outputs
From:   Andrei Kartashev <a.kartashev@yadro.com>
To:     Corentin Labbe <clabbe@baylibre.com>, <andrew@aj.id.au>,
        <joel@jms.id.au>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Jan 2022 16:17:04 +0300
In-Reply-To: <20220127121952.3985981-1-clabbe@baylibre.com>
References: <20220127121952.3985981-1-clabbe@baylibre.com>
Organization: YADRO
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.0.85]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-04.corp.yadro.com (172.17.100.104)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Good catch! I miss this on porting DTS from local tree, based on
Intel's one. Since there is no such driver in upstream kernel
(https://github.com/Intel-BMC/linux/blob/dev-5.15-intel/drivers/pwm/pwm-fttmr010.c
), both this and beeper sections could be completely removed.

I will send another patch with cleanup.

Thank you.

On Thu, 2022-01-27 at 12:19 +0000, Corentin Labbe wrote:
> fttmr010,pwm-outputs is not handled by its timer driver, so this
> property is useless.
> Fixes: 67ac01d03862 ("ARM: dts: aspeed: add device tree for YADRO
> VEGMAN BMC")
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-vegman.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> index 1a5b25b2ea29..43af63910571 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> +++ b/arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
> @@ -166,7 +166,6 @@ &sdhci1 {
>  };
>  
>  &timer {
> -       fttmr010,pwm-outputs = <5>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_timer5_default>;
>         #pwm-cells = <3>;

-- 
Best regards,
Andrei Kartashev


