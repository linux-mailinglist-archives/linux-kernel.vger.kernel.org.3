Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F314E52F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbiCWNWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCWNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:22:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEFB7A99B;
        Wed, 23 Mar 2022 06:21:00 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22ND6jYY009715;
        Wed, 23 Mar 2022 14:20:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ll1t8Ir3H0qz808D0MiUytqqfMAXZhxxOsdPSkfQBGA=;
 b=ur9kxkLqoBnbt7Gng+THHatMVZbGgUgMWxGs+joMLLKFxv0LP07QKpQOqkMXA/GZLtrI
 xgSCACXm6bqFKcKhIHCXev/qWgjnmJgbpCoecs5m2txUYOCsAEbXNOgNN6DHTMlV9HBy
 pH6Vt2M9JBoolyGJurua2RXbG0iZEfwpWVtzre87hM/iHLPzxaQ0kT7t3FSXDjWTi5Ge
 DGfKvve3CCAzM9ZrmUFo6Y5uScmPfXORifHBVVKCKnMlpYvjI6qS9rWRXEMBVwJoKDhC
 0BvKKD1eA9qZ+FCz0sfFvJwUMxCdxbNed7jo+jdlq7wAHycabeS5XmiaEQ7YxbhFqSAT Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ew5fpgnj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 14:20:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C141010002A;
        Wed, 23 Mar 2022 14:20:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4B7622FA51;
        Wed, 23 Mar 2022 14:20:37 +0100 (CET)
Received: from [10.211.9.79] (10.75.127.50) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 23 Mar
 2022 14:20:37 +0100
Message-ID: <51b4917b-823d-263a-2412-a4b17cb38420@foss.st.com>
Date:   Wed, 23 Mar 2022 14:20:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] brcmfmac: Avoid keeping power to SDIO card unless WOWL
 is used
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
CC:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        Christophe KERELLO - foss <christophe.kerello@foss.st.com>
References: <20220323083950.414783-1-ulf.hansson@linaro.org>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <20220323083950.414783-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_07,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 09:39, Ulf Hansson wrote:
> Keeping the power to the SDIO card during system wide suspend, consumes
> energy. Especially on battery driven embedded systems, this can be a
> problem. Therefore, let's change the behaviour into allowing the SDIO card
> to be powered off, unless WOWL is supported and enabled.
> 
> Note that, the downside from this change, is that during system resume the
> SDIO card needs to be re-initialized and the FW must be re-programmed. Even
> if this may take some time to complete, it should we worth it, rather than
> draining the battery.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- As pointed out by Yann, the changes for the resume path was missing,
> 	so I have added that too.
> 
> Again, please note that, I have only compile-tested this patch, so I am relying
> on help from Yann and others to run tests on real HW.
> 
> Kind regards
> Ulf Hansson
> 
> ---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 39 +++++++++++--------
>   1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ac02244a6fdf..9c598ea97499 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -1119,9 +1119,21 @@ void brcmf_sdio_wowl_config(struct device *dev, bool enabled)
>   {
>   	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
>   	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
> +	mmc_pm_flag_t pm_caps = sdio_get_host_pm_caps(sdiodev->func1);
>   
> -	brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
> -	sdiodev->wowl_enabled = enabled;
> +	/* Power must be preserved to be able to support WOWL. */
> +	if (!(pm_caps & MMC_PM_KEEP_POWER))
> +		goto notsup;
> +
> +	if (sdiodev->settings->bus.sdio.oob_irq_supported ||
> +	    pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
> +		sdiodev->wowl_enabled = enabled;
> +		brcmf_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
> +		return;
> +	}
> +
> +notsup:
> +	brcmf_dbg(SDIO, "WOWL not supported\n");
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> @@ -1130,7 +1142,7 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
>   	struct sdio_func *func;
>   	struct brcmf_bus *bus_if;
>   	struct brcmf_sdio_dev *sdiodev;
> -	mmc_pm_flag_t pm_caps, sdio_flags;
> +	mmc_pm_flag_t sdio_flags;
>   	int ret = 0;
>   
>   	func = container_of(dev, struct sdio_func, dev);
> @@ -1142,20 +1154,15 @@ static int brcmf_ops_sdio_suspend(struct device *dev)
>   	bus_if = dev_get_drvdata(dev);
>   	sdiodev = bus_if->bus_priv.sdio;
>   
> -	pm_caps = sdio_get_host_pm_caps(func);
> -
> -	if (pm_caps & MMC_PM_KEEP_POWER) {
> -		/* preserve card power during suspend */
> +	if (sdiodev->wowl_enabled) {
>   		brcmf_sdiod_freezer_on(sdiodev);
>   		brcmf_sdio_wd_timer(sdiodev->bus, 0);
>   
>   		sdio_flags = MMC_PM_KEEP_POWER;
> -		if (sdiodev->wowl_enabled) {
> -			if (sdiodev->settings->bus.sdio.oob_irq_supported)
> -				enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
> -			else
> -				sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
> -		}
> +		if (sdiodev->settings->bus.sdio.oob_irq_supported)
> +			enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
> +		else
> +			sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
>   
>   		if (sdio_set_host_pm_flags(sdiodev->func1, sdio_flags))
>   			brcmf_err("Failed to set pm_flags %x\n", sdio_flags);
> @@ -1176,21 +1183,19 @@ static int brcmf_ops_sdio_resume(struct device *dev)
>   	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
>   	struct brcmf_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
>   	struct sdio_func *func = container_of(dev, struct sdio_func, dev);
> -	mmc_pm_flag_t pm_caps = sdio_get_host_pm_caps(func);
>   	int ret = 0;
>   
>   	brcmf_dbg(SDIO, "Enter: F%d\n", func->num);
>   	if (func->num != 2)
>   		return 0;
>   
> -	if (!(pm_caps & MMC_PM_KEEP_POWER)) {
> +	if (!sdiodev->wowl_enabled) {
>   		/* bus was powered off and device removed, probe again */
>   		ret = brcmf_sdiod_probe(sdiodev);
>   		if (ret)
>   			brcmf_err("Failed to probe device on resume\n");
>   	} else {
> -		if (sdiodev->wowl_enabled &&
> -		    sdiodev->settings->bus.sdio.oob_irq_supported)
> +		if (sdiodev->settings->bus.sdio.oob_irq_supported)
>   			disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
>   
>   		brcmf_sdiod_freezer_off(sdiodev);

Hi Ulf,

Thanks for the patch, it is OK, and tested by Christophe (R.).
So you can add:
Tested-by: Christophe Roullier <christophe.roullier@foss.st.com>
Acked-by: Yann Gautier <yann.gautier@foss.st.com>


Best regards,
Yann
