Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB049AC86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352940AbiAYGlL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jan 2022 01:41:11 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45615 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346594AbiAYGi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:38:57 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20P6cdDG3012171, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20P6cdDG3012171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 Jan 2022 14:38:39 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 25 Jan 2022 14:38:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 14:38:39 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::472:6d76:b35d:421e]) by
 RTEXMBS01.realtek.com.tw ([fe80::472:6d76:b35d:421e%5]) with mapi id
 15.01.2308.020; Tue, 25 Jan 2022 14:38:39 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 3/4] misc: rtsx: Cleanup power management ops
Thread-Topic: [PATCH v6 3/4] misc: rtsx: Cleanup power management ops
Thread-Index: AQHYEa96l4fyUR0Nj0O7ZZs8mnu6NqxzSPEA
Date:   Tue, 25 Jan 2022 06:38:39 +0000
Message-ID: <74fc71ca144e47799c461085d19a9deb@realtek.com>
References: <20220121014039.1693208-1-kai.heng.feng@canonical.com>
 <20220125055010.1866563-1-kai.heng.feng@canonical.com>
 <20220125055010.1866563-3-kai.heng.feng@canonical.com>
In-Reply-To: <20220125055010.1866563-3-kai.heng.feng@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.97]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2022/1/25_=3F=3F_03:54:00?=
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
> Sent: Tuesday, January 25, 2022 1:50 PM
> To: arnd@arndb.de; gregkh@linuxfoundation.org; ulf.hansson@linaro.org
> Cc: linux-pm@vger.kernel.org; Kai-Heng Feng <kai.heng.feng@canonical.com>;
> Ricky WU <ricky_wu@realtek.com>; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; Yang Li <yang.lee@linux.alibaba.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v6 3/4] misc: rtsx: Cleanup power management ops
> 
> - Use cancel_delayed_work_sync to ensure there's no race with
>   carddet_work.
> 
> - Remove device_wakeup_disable to save some CPU cycles. If the device
>   really has ACPI _DSW then the wakeup should be disabled in probe
>   routine.
> 
> - Remove fetch_vendor_settings from runtime resume routine, since they
>   are already saved in "struct rtsx_pcr".
> 
> - Move variable assignments to the top of the functions.
> 
> Cc: Ricky WU <ricky_wu@realtek.com>
Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v6:
> v5:
>  - No change.
> 
> v4:
>  - Move variable assignments to the top of the functions.
> 
> v3:
> v2:
>  - No change.
> 
>  drivers/misc/cardreader/rtsx_pcr.c | 34 ++++++++----------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c
> b/drivers/misc/cardreader/rtsx_pcr.c
> index 8aba47a7d9736..3c97d3b50456e 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1660,22 +1660,17 @@ static void rtsx_pci_remove(struct pci_dev
> *pcidev)  static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
> {
>  	struct pci_dev *pcidev = to_pci_dev(dev_d);
> -	struct pcr_handle *handle;
> -	struct rtsx_pcr *pcr;
> +	struct pcr_handle *handle = pci_get_drvdata(pcidev);
> +	struct rtsx_pcr *pcr = handle->pcr;
> 
>  	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> 
> -	handle = pci_get_drvdata(pcidev);
> -	pcr = handle->pcr;
> -
> -	cancel_delayed_work(&pcr->carddet_work);
> +	cancel_delayed_work_sync(&pcr->carddet_work);
> 
>  	mutex_lock(&pcr->pcr_mutex);
> 
>  	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
> 
> -	device_wakeup_disable(dev_d);
> -
>  	mutex_unlock(&pcr->pcr_mutex);
>  	return 0;
>  }
> @@ -1683,15 +1678,12 @@ static int __maybe_unused
> rtsx_pci_suspend(struct device *dev_d)  static int __maybe_unused
> rtsx_pci_resume(struct device *dev_d)  {
>  	struct pci_dev *pcidev = to_pci_dev(dev_d);
> -	struct pcr_handle *handle;
> -	struct rtsx_pcr *pcr;
> +	struct pcr_handle *handle = pci_get_drvdata(pcidev);
> +	struct rtsx_pcr *pcr = handle->pcr;
>  	int ret = 0;
> 
>  	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> 
> -	handle = pci_get_drvdata(pcidev);
> -	pcr = handle->pcr;
> -
>  	mutex_lock(&pcr->pcr_mutex);
> 
>  	ret = rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00); @@
> -1711,13 +1703,11 @@ static int __maybe_unused rtsx_pci_resume(struct
> device *dev_d)
> 
>  static void rtsx_pci_shutdown(struct pci_dev *pcidev)  {
> -	struct pcr_handle *handle;
> -	struct rtsx_pcr *pcr;
> +	struct pcr_handle *handle = pci_get_drvdata(pcidev);
> +	struct rtsx_pcr *pcr = handle->pcr;
> 
>  	dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
> 
> -	handle = pci_get_drvdata(pcidev);
> -	pcr = handle->pcr;
>  	rtsx_pci_power_off(pcr, HOST_ENTER_S1);
> 
>  	pci_disable_device(pcidev);
> @@ -1756,11 +1746,8 @@ static int rtsx_pci_runtime_idle(struct device
> *device)  static int rtsx_pci_runtime_suspend(struct device *device)  {
>  	struct pci_dev *pcidev = to_pci_dev(device);
> -	struct pcr_handle *handle;
> -	struct rtsx_pcr *pcr;
> -
> -	handle = pci_get_drvdata(pcidev);
> -	pcr = handle->pcr;
> +	struct pcr_handle *handle = pci_get_drvdata(pcidev);
> +	struct rtsx_pcr *pcr = handle->pcr;
> 
>  	dev_dbg(device, "--> %s\n", __func__);
> 
> @@ -1786,9 +1773,6 @@ static int rtsx_pci_runtime_resume(struct device
> *device)
> 
>  	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
> 
> -	if (pcr->ops->fetch_vendor_settings)
> -		pcr->ops->fetch_vendor_settings(pcr);
> -
>  	rtsx_pci_init_hw(pcr);
> 
>  	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
> --
> 2.33.1

