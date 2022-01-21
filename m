Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3A4958B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 04:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiAUD6D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jan 2022 22:58:03 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:50843 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbiAUD57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 22:57:59 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20L3vec07018453, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20L3vec07018453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 Jan 2022 11:57:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 11:57:40 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 21 Jan 2022 11:57:39 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::a5c6:3ded:8fd8:286a]) by
 RTEXMBS01.realtek.com.tw ([fe80::a5c6:3ded:8fd8:286a%5]) with mapi id
 15.01.2308.020; Fri, 21 Jan 2022 11:57:39 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] misc: rtsx: Rework runtime power management flow
Thread-Topic: [PATCH v2 2/4] misc: rtsx: Rework runtime power management flow
Thread-Index: AQHYDmfzNtApiNB7lEubVz/rcdVLiqxs1tFQ
Date:   Fri, 21 Jan 2022 03:57:39 +0000
Message-ID: <e757387774234b678f6a38e004179c99@realtek.com>
References: <20220120145006.1682014-2-kai.heng.feng@canonical.com>
 <20220121014039.1693208-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.97]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/1/20_=3F=3F_10:29:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Friday, January 21, 2022 9:41 AM
> To: arnd@arndb.de; gregkh@linuxfoundation.org; ulf.hansson@linaro.org
> Cc: linux-pm@vger.kernel.org; Kai-Heng Feng <kai.heng.feng@canonical.com>;
> Ricky WU <ricky_wu@realtek.com>; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; Yang Li <yang.lee@linux.alibaba.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v2 2/4] misc: rtsx: Rework runtime power management flow
> 
> Commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM") uses
> "rtd3_work" and "idle_work" to manage it's own runtime PM state machine.
> 
> When its child device, rtsx_pci_sdmmc, uses runtime PM refcount correctly, all
> the additional works can be managed by generic runtime PM helpers.
> 
> So consolidate "idle_work" and "rtd3_work" into generic runtime idle callback
> and runtime suspend callback, respectively.
> 

This idle_work is not runtime_idle, this is for aspm setting
Not only for support RPM, so this idle_work can not be remove....

Our original Idle_work is a power saveing function, It is a delay_work for 200 msec  ,
If no work comes in 200 msec than go to idle_work to set power saveing setting.....  

> Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
> Cc: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Remove unused idle_work and rtd3_work from rtsx_pcr.
> 
>  drivers/misc/cardreader/rtsx_pcr.c | 123 +++++++++++------------------
>  include/linux/rtsx_pci.h           |   3 -
>  2 files changed, 44 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> b/drivers/misc/cardreader/rtsx_pcr.c
> index 6ac509c1821c9..1dcf98b597569 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -152,20 +152,12 @@ void rtsx_pci_start_run(struct rtsx_pcr *pcr)
>  	if (pcr->remove_pci)
>  		return;
> 
> -	if (pcr->rtd3_en)
> -		if (pcr->is_runtime_suspended) {
> -			pm_runtime_get(&(pcr->pci->dev));
> -			pcr->is_runtime_suspended = false;
> -		}
> -
>  	if (pcr->state != PDEV_STAT_RUN) {
>  		pcr->state = PDEV_STAT_RUN;
>  		if (pcr->ops->enable_auto_blink)
>  			pcr->ops->enable_auto_blink(pcr);
>  		rtsx_pm_full_on(pcr);
>  	}
> -
> -	mod_delayed_work(system_wq, &pcr->idle_work, msecs_to_jiffies(200));
>  }
>  EXPORT_SYMBOL_GPL(rtsx_pci_start_run);
> 
> @@ -1094,40 +1086,6 @@ static void rtsx_pm_power_saving(struct rtsx_pcr
> *pcr)
>  	rtsx_comm_pm_power_saving(pcr);
>  }
> 
> -static void rtsx_pci_rtd3_work(struct work_struct *work) -{
> -	struct delayed_work *dwork = to_delayed_work(work);
> -	struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr, rtd3_work);
> -
> -	pcr_dbg(pcr, "--> %s\n", __func__);
> -	if (!pcr->is_runtime_suspended)
> -		pm_runtime_put(&(pcr->pci->dev));
> -}
> -
> -static void rtsx_pci_idle_work(struct work_struct *work) -{
> -	struct delayed_work *dwork = to_delayed_work(work);
> -	struct rtsx_pcr *pcr = container_of(dwork, struct rtsx_pcr, idle_work);
> -
> -	pcr_dbg(pcr, "--> %s\n", __func__);
> -
> -	mutex_lock(&pcr->pcr_mutex);
> -
> -	pcr->state = PDEV_STAT_IDLE;
> -
> -	if (pcr->ops->disable_auto_blink)
> -		pcr->ops->disable_auto_blink(pcr);
> -	if (pcr->ops->turn_off_led)
> -		pcr->ops->turn_off_led(pcr);
> -
> -	rtsx_pm_power_saving(pcr);
> -
> -	mutex_unlock(&pcr->pcr_mutex);
> -
> -	if (pcr->rtd3_en)
> -		mod_delayed_work(system_wq, &pcr->rtd3_work,
> msecs_to_jiffies(10000));
> -}
> -
>  static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
> {
>  	/* Set relink_time to 0 */
> @@ -1598,7 +1556,6 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
>  	pcr->card_inserted = 0;
>  	pcr->card_removed = 0;
>  	INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
> -	INIT_DELAYED_WORK(&pcr->idle_work, rtsx_pci_idle_work);
> 
>  	pcr->msi_en = msi_en;
>  	if (pcr->msi_en) {
> @@ -1623,20 +1580,16 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
>  		rtsx_pcr_cells[i].pdata_size = sizeof(*handle);
>  	}
> 
> -	if (pcr->rtd3_en) {
> -		INIT_DELAYED_WORK(&pcr->rtd3_work, rtsx_pci_rtd3_work);
> -		pm_runtime_allow(&pcidev->dev);
> -		pm_runtime_enable(&pcidev->dev);
> -		pcr->is_runtime_suspended = false;
> -	}
> -
> 
>  	ret = mfd_add_devices(&pcidev->dev, pcr->id, rtsx_pcr_cells,
>  			ARRAY_SIZE(rtsx_pcr_cells), NULL, 0, NULL);
>  	if (ret < 0)
>  		goto free_slots;
> 
> -	schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> +	if (pcr->rtd3_en) {
> +		pm_runtime_allow(&pcidev->dev);
> +		pm_runtime_put(&pcidev->dev);
> +	}
> 
>  	return 0;
> 
> @@ -1668,10 +1621,11 @@ static void rtsx_pci_remove(struct pci_dev
> *pcidev)
>  	struct pcr_handle *handle = pci_get_drvdata(pcidev);
>  	struct rtsx_pcr *pcr = handle->pcr;
> 
> -	if (pcr->rtd3_en)
> -		pm_runtime_get_noresume(&pcr->pci->dev);
> -
>  	pcr->remove_pci = true;
> +	if (pcr->rtd3_en) {
> +		pm_runtime_get_sync(&pcidev->dev);
> +		pm_runtime_forbid(&pcidev->dev);
> +	}
> 
>  	/* Disable interrupts at the pcr level */
>  	spin_lock_irq(&pcr->lock);
> @@ -1680,9 +1634,6 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
>  	spin_unlock_irq(&pcr->lock);
> 
>  	cancel_delayed_work_sync(&pcr->carddet_work);
> -	cancel_delayed_work_sync(&pcr->idle_work);
> -	if (pcr->rtd3_en)
> -		cancel_delayed_work_sync(&pcr->rtd3_work);
> 
>  	mfd_remove_devices(&pcidev->dev);
> 
> @@ -1700,11 +1651,6 @@ static void rtsx_pci_remove(struct pci_dev
> *pcidev)
>  	idr_remove(&rtsx_pci_idr, pcr->id);
>  	spin_unlock(&rtsx_pci_lock);
> 
> -	if (pcr->rtd3_en) {
> -		pm_runtime_disable(&pcr->pci->dev);
> -		pm_runtime_put_noidle(&pcr->pci->dev);
> -	}
> -
>  	kfree(pcr->slots);
>  	kfree(pcr);
>  	kfree(handle);
> @@ -1726,7 +1672,6 @@ static int __maybe_unused rtsx_pci_suspend(struct
> device *dev_d)
>  	pcr = handle->pcr;
> 
>  	cancel_delayed_work(&pcr->carddet_work);
> -	cancel_delayed_work(&pcr->idle_work);
> 
>  	mutex_lock(&pcr->pcr_mutex);
> 
> @@ -1760,8 +1705,6 @@ static int __maybe_unused rtsx_pci_resume(struct
> device *dev_d)
>  	if (ret)
>  		goto out;
> 
> -	schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> -
>  out:
>  	mutex_unlock(&pcr->pcr_mutex);
>  	return ret;
> @@ -1786,6 +1729,32 @@ static void rtsx_pci_shutdown(struct pci_dev
> *pcidev)
>  		pci_disable_msi(pcr->pci);
>  }
> 
> +static int rtsx_pci_runtime_idle(struct device *device) {
> +	struct pci_dev *pcidev = to_pci_dev(device);
> +	struct pcr_handle *handle = pci_get_drvdata(pcidev);
> +	struct rtsx_pcr *pcr = handle->pcr;
> +
> +	dev_dbg(device, "--> %s\n", __func__);
> +
> +	mutex_lock(&pcr->pcr_mutex);
> +
> +	pcr->state = PDEV_STAT_IDLE;
> +
> +	if (pcr->ops->disable_auto_blink)
> +		pcr->ops->disable_auto_blink(pcr);
> +	if (pcr->ops->turn_off_led)
> +		pcr->ops->turn_off_led(pcr);
> +
> +	rtsx_pm_power_saving(pcr);
> +
> +	mutex_unlock(&pcr->pcr_mutex);
> +
> +	pm_schedule_suspend(device, 5000);
> +
> +	return -EBUSY;
> +}
> +
>  static int rtsx_pci_runtime_suspend(struct device *device)  {
>  	struct pci_dev *pcidev = to_pci_dev(device); @@ -1794,31 +1763,29 @@
> static int rtsx_pci_runtime_suspend(struct device *device)
> 
>  	handle = pci_get_drvdata(pcidev);
>  	pcr = handle->pcr;
> -	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> 
> -	cancel_delayed_work(&pcr->carddet_work);
> -	cancel_delayed_work(&pcr->rtd3_work);
> -	cancel_delayed_work(&pcr->idle_work);
> +	if (!pcr->rtd3_en)
> +		return -EBUSY;
> +
> +	dev_dbg(device, "--> %s\n", __func__);
> +
> +	cancel_delayed_work_sync(&pcr->carddet_work);
> 
>  	mutex_lock(&pcr->pcr_mutex);
>  	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
> 
>  	mutex_unlock(&pcr->pcr_mutex);
> 
> -	pcr->is_runtime_suspended = true;
> -
>  	return 0;
>  }
> 
>  static int rtsx_pci_runtime_resume(struct device *device)  {
>  	struct pci_dev *pcidev = to_pci_dev(device);
> -	struct pcr_handle *handle;
> -	struct rtsx_pcr *pcr;
> +	struct pcr_handle *handle = pci_get_drvdata(pcidev);
> +	struct rtsx_pcr *pcr = handle->pcr;
> 
> -	handle = pci_get_drvdata(pcidev);
> -	pcr = handle->pcr;
> -	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> +	dev_dbg(device, "--> %s\n", __func__);
> 
>  	mutex_lock(&pcr->pcr_mutex);
> 
> @@ -1834,8 +1801,6 @@ static int rtsx_pci_runtime_resume(struct device
> *device)
>  				pcr->slots[RTSX_SD_CARD].p_dev);
>  	}
> 
> -	schedule_delayed_work(&pcr->idle_work, msecs_to_jiffies(200));
> -
>  	mutex_unlock(&pcr->pcr_mutex);
>  	return 0;
>  }
> @@ -1850,7 +1815,7 @@ static int rtsx_pci_runtime_resume(struct device
> *device)
> 
>  static const struct dev_pm_ops rtsx_pci_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(rtsx_pci_suspend, rtsx_pci_resume)
> -	SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> rtsx_pci_runtime_resume, NULL)
> +	SET_RUNTIME_PM_OPS(rtsx_pci_runtime_suspend,
> rtsx_pci_runtime_resume,
> +rtsx_pci_runtime_idle)
>  };
> 
>  static struct pci_driver rtsx_pci_driver = { diff --git a/include/linux/rtsx_pci.h
> b/include/linux/rtsx_pci.h index 4ab7bfc675f11..89b7d34e25b63 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -1201,8 +1201,6 @@ struct rtsx_pcr {
>  	unsigned int			card_exist;
> 
>  	struct delayed_work		carddet_work;
> -	struct delayed_work		idle_work;
> -	struct delayed_work		rtd3_work;
> 
>  	spinlock_t			lock;
>  	struct mutex			pcr_mutex;
> @@ -1212,7 +1210,6 @@ struct rtsx_pcr {
>  	unsigned int			cur_clock;
>  	bool				remove_pci;
>  	bool				msi_en;
> -	bool				is_runtime_suspended;
> 
>  #define EXTRA_CAPS_SD_SDR50		(1 << 0)
>  #define EXTRA_CAPS_SD_SDR104		(1 << 1)
> --
> 2.33.1

