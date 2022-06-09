Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00AA544E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245141AbiFIOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbiFIOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:06:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28F11A05D;
        Thu,  9 Jun 2022 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bKwrWAV5KQ2tI9xJynl5McLGgOGWmZ446v9ndOyiHw4=; b=S1WPS3Hod3YxqEWMXDiAfHYde0
        yKdU202j9aU6XClMQE7zireIh+deD1DmPr9+Zqohr8dITdzKoHcMl4FnUtzfTK5SQ6s15f7XpPYZ7
        6a4sPFGiE9K1JO2jiKRTJErvGrBXOQavUUPzuGHxeOxwJuGJ/YbL8s5o/06ePoK4G8TPdiRvBw/in
        6b1x2wzwiTn6qtDHJUXhFWxh7o0WrucQFbxqbX6GgacqtRyOobpHOgLJAMv1AbldvlDnVyT89DF+S
        jQJoyhgT8AXrmhvUYWb0U6UZKFqlH/Su8IxCse5A8cNAGnMz5aSs9Uw1fRaHlEydPk0fefStau+JM
        x2aFRlYQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzInj-006OEf-IL; Thu, 09 Jun 2022 14:06:20 +0000
Message-ID: <098e206c-8c52-747c-6261-e7ef96df2652@infradead.org>
Date:   Thu, 9 Jun 2022 07:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4 4/7] soc: imx: add i.MX93 SRC power domain driver
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-5-peng.fan@oss.nxp.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220609125100.3496633-5-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/22 05:50, Peng Fan (OSS) wrote:
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
> index a840494e849a..5bfc1dfea28b 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -20,4 +20,14 @@ config SOC_IMX8M
>  	  support, it will provide the SoC info like SoC family,
>  	  ID and revision etc.
>  
> +config SOC_IMX9
> +	tristate "i.MX9 SoC family support"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	default ARCH_MXC && ARM64
> +	select SOC_BUS
> +	select PM_GENERIC_DOMAINS
> +	help
> +	  If you say yes here you get support for the NXP i.MX9 family
> +	  support.

One too many "support". Maybe:

> +	help
> +	  If you say yes here you get support for the NXP i.MX9 SoC family.



-- 
~Randy
