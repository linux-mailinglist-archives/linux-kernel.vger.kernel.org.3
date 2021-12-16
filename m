Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E3B476D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhLPJNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:13:34 -0500
Received: from phobos.denx.de ([85.214.62.61]:48518 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbhLPJNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:13:32 -0500
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CE52981184;
        Thu, 16 Dec 2021 10:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1639646009;
        bh=dICm1q4PWYye78j3bTjDPHLcvcI6iZNmCbGLRnoLBGI=;
        h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
        b=qincm+ciIW5GL38TqrKgtHeLGDv6xlSWqOjbkvZviXLgi/dJ4iTcaNzvrC7A5mqnD
         deLxZeqGFZOI/arnRK3JbI4F/wQETJfeJMTkYwvYM/fUYdJOdrWG1SUPYQ+Xfs7cj4
         S0zAErG2PhgFO/h05MjWZA9BDe4X0Ie/1xNmYNjytpWNWbsvBDfTevAM6YDXEWSkIh
         Yk0KcMuM3mMHuC07Q5szz5lCdkgWkGzQbzt6EKw3Z+RpLBmaNqB20U/qXSOxJd4jv1
         dsJm/eyrr8BpV8oXhYvqwWFXJxUFJuGq92ThekbNaZrEkcH+bT3C9h4coviinqwG1V
         0txiIUDgORTxQ==
Message-ID: <05ab7b52-190e-048f-3803-7bed51e2b09c@denx.de>
Date:   Thu, 16 Dec 2021 10:13:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] mmc: mmci: stm32: clear DLYB_CR after sending tuning
 command
Content-Language: en-US
To:     Yann Gautier <yann.gautier@foss.st.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
 <20211215141727.4901-4-yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        u.kleine-koenig@pengutronix.de,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20211215141727.4901-4-yann.gautier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/21 15:17, Yann Gautier wrote:
> During test campaign, and especially after several unbind/bind sequences,
> it has been seen that the SD-card on SDMMC1 thread could freeze.
> The freeze always appear on a CMD23 following a CMD19.
> Checking SDMMC internal registers shows that the tuning command (CMD19)
> has failed.
> The freeze is then due to the delay block involved in the tuning sequence.
> To correct this, clear the delay block register DLYB_CR register after
> the tuning commands.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
>   drivers/mmc/host/mmci_stm32_sdmmc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index fdaa11f92fe6..a75d3dd34d18 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -441,6 +441,8 @@ static int sdmmc_dlyb_phase_tuning(struct mmci_host *host, u32 opcode)
>   		return -EINVAL;
>   	}
>   
> +	writel_relaxed(0, dlyb->base + DLYB_CR);
> +
>   	phase = end_of_len - max_len / 2;
>   	sdmmc_dlyb_set_cfgr(dlyb, dlyb->unit, phase, false);

Shouldn't this have a Fixes: tag and be CC stable ?
This seems like a bugfix, no ?
