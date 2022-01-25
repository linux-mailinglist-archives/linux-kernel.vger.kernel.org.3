Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC949AC84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354024AbiAYGlC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 01:41:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45513 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354099AbiAYGhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:37:53 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20P6bSwY5011973, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20P6bSwY5011973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Jan 2022 14:37:28 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 14:37:27 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 22:37:27 -0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::472:6d76:b35d:421e]) by
 RTEXMBS01.realtek.com.tw ([fe80::472:6d76:b35d:421e%5]) with mapi id
 15.01.2308.020; Tue, 25 Jan 2022 14:37:27 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle runtime PM
Thread-Topic: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle
 runtime PM
Thread-Index: AQHYEa903hqeGpf0tUOwpFCX1CCXxKxzRdPQ
Date:   Tue, 25 Jan 2022 06:37:27 +0000
Message-ID: <e17921f54f3640bdba3212803b020ae0@realtek.com>
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220125055010.1866563-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220125055010.1866563-1-kai.heng.feng@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.97]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/1/25_=3F=3F_03:54:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Tuesday, January 25, 2022 1:50 PM
> To: arnd@arndb.de; gregkh@linuxfoundation.org; ulf.hansson@linaro.org
> Cc: linux-pm@vger.kernel.org; Kai-Heng Feng <kai.heng.feng@canonical.com>;
> Ricky WU <ricky_wu@realtek.com>; Thomas Hebb <tommyhebb@gmail.com>;
> linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v6 1/4] mmc: rtsx: Use pm_runtime_{get,put}() to handle
> runtime PM
> 
> Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") doesn't use
> pm_runtime_{get,put}() helpers when it should, so the RPM refcount keeps at
> zero, hence its parent driver, rtsx_pci, has to do lots of weird tricks to keep it
> from runtime suspending.
> 
> So use those helpers at right places to properly manage runtime PM.
> 
> Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> Cc: Ricky WU <ricky_wu@realtek.com>
Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v6:
>  - Change the auto suspend delay to 200ms as Realtek suggested.
> 
> v5:
>  - Revert back to v3 as Realtek suggested.
> 
> v4:
>  - Decrease the autosuspend delay to 200ms for more power saving.
> 
> v3:
> v2:
>  - No change.
> 
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 44 +++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 58cfaffa3c2d8..2a3f14afe9f83 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -806,6 +806,7 @@ static void sd_request(struct work_struct *work)
>  	struct mmc_request *mrq = host->mrq;
>  	struct mmc_command *cmd = mrq->cmd;
>  	struct mmc_data *data = mrq->data;
> +	struct device *dev = &host->pdev->dev;
> 
>  	unsigned int data_size = 0;
>  	int err;
> @@ -822,6 +823,7 @@ static void sd_request(struct work_struct *work)
>  	}
> 
>  	mutex_lock(&pcr->pcr_mutex);
> +	pm_runtime_get_sync(dev);
> 
>  	rtsx_pci_start_run(pcr);
> 
> @@ -858,6 +860,8 @@ static void sd_request(struct work_struct *work)
>  			data->bytes_xfered = data->blocks * data->blksz;
>  	}
> 
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	mutex_unlock(&pcr->pcr_mutex);
> 
>  finish:
> @@ -1080,6 +1084,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios)  {
>  	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>  	struct rtsx_pcr *pcr = host->pcr;
> +	struct device *dev = &host->pdev->dev;
> 
>  	if (host->eject)
>  		return;
> @@ -1088,6 +1093,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios)
>  		return;
> 
>  	mutex_lock(&pcr->pcr_mutex);
> +	pm_runtime_get_sync(dev);
> 
>  	rtsx_pci_start_run(pcr);
> 
> @@ -1121,6 +1127,8 @@ static void sdmmc_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios)
>  	rtsx_pci_switch_clock(pcr, ios->clock, host->ssc_depth,
>  			host->initial_mode, host->double_clk, host->vpclk);
> 
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	mutex_unlock(&pcr->pcr_mutex);
>  }
> 
> @@ -1128,6 +1136,7 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
> {
>  	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>  	struct rtsx_pcr *pcr = host->pcr;
> +	struct device *dev = &host->pdev->dev;
>  	int ro = 0;
>  	u32 val;
> 
> @@ -1135,6 +1144,7 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
>  		return -ENOMEDIUM;
> 
>  	mutex_lock(&pcr->pcr_mutex);
> +	pm_runtime_get_sync(dev);
> 
>  	rtsx_pci_start_run(pcr);
> 
> @@ -1144,6 +1154,8 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
>  	if (val & SD_WRITE_PROTECT)
>  		ro = 1;
> 
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	mutex_unlock(&pcr->pcr_mutex);
> 
>  	return ro;
> @@ -1153,6 +1165,7 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
> {
>  	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>  	struct rtsx_pcr *pcr = host->pcr;
> +	struct device *dev = &host->pdev->dev;
>  	int cd = 0;
>  	u32 val;
> 
> @@ -1160,6 +1173,7 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>  		return cd;
> 
>  	mutex_lock(&pcr->pcr_mutex);
> +	pm_runtime_get_sync(dev);
> 
>  	rtsx_pci_start_run(pcr);
> 
> @@ -1169,6 +1183,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>  	if (val & SD_EXIST)
>  		cd = 1;
> 
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	mutex_unlock(&pcr->pcr_mutex);
> 
>  	return cd;
> @@ -1251,6 +1267,7 @@ static int sdmmc_switch_voltage(struct mmc_host
> *mmc, struct mmc_ios *ios)  {
>  	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>  	struct rtsx_pcr *pcr = host->pcr;
> +	struct device *dev = &host->pdev->dev;
>  	int err = 0;
>  	u8 voltage;
> 
> @@ -1265,6 +1282,7 @@ static int sdmmc_switch_voltage(struct mmc_host
> *mmc, struct mmc_ios *ios)
>  		return err;
> 
>  	mutex_lock(&pcr->pcr_mutex);
> +	pm_runtime_get_sync(dev);
> 
>  	rtsx_pci_start_run(pcr);
> 
> @@ -1294,6 +1312,8 @@ static int sdmmc_switch_voltage(struct mmc_host
> *mmc, struct mmc_ios *ios)
>  	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
>  			SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
> 
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	mutex_unlock(&pcr->pcr_mutex);
> 
>  	return err;
> @@ -1303,6 +1323,7 @@ static int sdmmc_execute_tuning(struct mmc_host
> *mmc, u32 opcode)  {
>  	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>  	struct rtsx_pcr *pcr = host->pcr;
> +	struct device *dev = &host->pdev->dev;
>  	int err = 0;
> 
>  	if (host->eject)
> @@ -1313,6 +1334,7 @@ static int sdmmc_execute_tuning(struct mmc_host
> *mmc, u32 opcode)
>  		return err;
> 
>  	mutex_lock(&pcr->pcr_mutex);
> +	pm_runtime_get_sync(dev);
> 
>  	rtsx_pci_start_run(pcr);
> 
> @@ -1345,6 +1367,8 @@ static int sdmmc_execute_tuning(struct mmc_host
> *mmc, u32 opcode)
>  		err = sd_change_phase(host, DDR50_RX_PHASE(pcr), true);
> 
>  out:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	mutex_unlock(&pcr->pcr_mutex);
> 
>  	return err;
> @@ -1495,12 +1519,12 @@ static int rtsx_pci_sdmmc_drv_probe(struct
> platform_device *pdev)
> 
>  	realtek_init_host(host);
> 
> -	if (pcr->rtd3_en) {
> -		pm_runtime_set_autosuspend_delay(&pdev->dev, 5000);
> -		pm_runtime_use_autosuspend(&pdev->dev);
> -		pm_runtime_enable(&pdev->dev);
> -	}
> -
> +	pm_runtime_no_callbacks(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 200);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> 
>  	mmc_add_host(mmc);
> 
> @@ -1521,11 +1545,6 @@ static int rtsx_pci_sdmmc_drv_remove(struct
> platform_device *pdev)
>  	pcr->slots[RTSX_SD_CARD].card_event = NULL;
>  	mmc = host->mmc;
> 
> -	if (pcr->rtd3_en) {
> -		pm_runtime_dont_use_autosuspend(&pdev->dev);
> -		pm_runtime_disable(&pdev->dev);
> -	}
> -
>  	cancel_work_sync(&host->work);
> 
>  	mutex_lock(&host->host_mutex);
> @@ -1548,6 +1567,9 @@ static int rtsx_pci_sdmmc_drv_remove(struct
> platform_device *pdev)
> 
>  	flush_work(&host->work);
> 
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>  	mmc_free_host(mmc);
> 
>  	dev_dbg(&(pdev->dev),
> --
> 2.33.1

