Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2CC4DD86A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiCRKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiCRKsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:48:43 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F022C578B;
        Fri, 18 Mar 2022 03:47:24 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22I9RPI1021851;
        Fri, 18 Mar 2022 11:47:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=6Ku1k8c5mnUx/vkTbFsPQT/PcBh9rZb+S/9UtJ5rdsI=;
 b=jiLWHkpq0EgQggNg+LSzY0O97/OaXQuKVN6I2v4+XF9G+2wfGf2lphz1dJgukkRMPxXB
 SF3PigoixvAjt73ecM69cFQ9ycr82qQ0X4igmCUyqeTn3j9CcCqutKbRGVIqK6ut/LT+
 8JfKwKfl+niqxe6eFvto0D22RCIyXx7EQWKX30kK/VynjYIR2rSTgofpvAzH6r9ddgaH
 gKUZ1rXjsFj2v4lhuCUIuFQa/OukIZLutZsQ5UB935kOCReLgpb35DSIFJ+MJFzE4Hdj
 u6ByEMheaLKp8DC0fPB3WAhpqt7slcsVejLnA1evpdbwdlL9barVTWq7LVvaUBvsjVWI rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3evges2pek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 11:47:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0B65510002A;
        Fri, 18 Mar 2022 11:47:07 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3C0321FE9A;
        Fri, 18 Mar 2022 11:47:06 +0100 (CET)
Received: from [10.211.8.64] (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 18 Mar
 2022 11:47:06 +0100
Message-ID: <98472721-7f3c-3f2b-42a6-d50b51c6191f@foss.st.com>
Date:   Fri, 18 Mar 2022 11:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] brcmfmac: Avoid keeping power to SDIO card unless WOWL is
 used
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        Christophe KERELLO - foss <christophe.kerello@foss.st.com>,
        Christophe ROULLIER-SCND-02 <christophe.roullier@foss.st.com>
References: <20220317152846.246281-1-ulf.hansson@linaro.org>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <20220317152846.246281-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_08,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 16:28, Ulf Hansson wrote:
> Keeping the power to the SDIO card during system wide suspend, consumes
> energy. Especially on battery driven embedded systems, this can be a
> problem. Therefore, let's change the behaviour into allowing the SDIO card
> to be powered off, unless WOWL is supported and enabled.
> 
> Note that, the downside from this change, is that at system resume the SDIO
> card needs to be re-initialized and the FW must re-programmed. Even it that
> may take some time to complete, it should we worth it, rather than draining
> a battery.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Please note that, I have only compile-tested this patch, so I am relying on help
> from Yann and others to run tests on real HW.
> 
> Kind regards
> Ulf Hansson
> 
> ---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 33 +++++++++++--------
>   1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ac02244a6fdf..351886c9d68e 100644
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

Hi Ulf,

You are missing the counter part in brcmf_ops_sdio_resume:

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
@@ -1190,14 +1190,13 @@ static int brcmf_ops_sdio_resume(struct device *dev)
         if (func->num != 2)
                 return 0;

-       if (!(pm_caps & MMC_PM_KEEP_POWER)) {
+       if (!sdiodev->wowl_enabled) {
                 /* bus was powered off and device removed, probe again */
                 ret = brcmf_sdiod_probe(sdiodev);
                 if (ret)
                         brcmf_err("Failed to probe device on resume\n");
         } else {
-               if (sdiodev->wowl_enabled &&
-                   sdiodev->settings->bus.sdio.oob_irq_supported)
+               if (sdiodev->settings->bus.sdio.oob_irq_supported)
 
disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);


Else, we get an oops when calling brcmf_sdio_sleep.


Best regards,
Yann
