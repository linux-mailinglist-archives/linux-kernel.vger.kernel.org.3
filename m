Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FBB4672FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379064AbhLCICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:02:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:34396 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350800AbhLCICj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:02:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="237158712"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="237158712"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 23:59:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="561582959"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2021 23:59:13 -0800
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: "mmc1: Internal clock never
 stabilised." seen on 72113
To:     Al Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
References: <20211202163050.46810-1-alcooperx@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <632d1979-261f-2486-6a25-bab89797616f@intel.com>
Date:   Fri, 3 Dec 2021 09:59:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202163050.46810-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2021 18:30, Al Cooper wrote:
> The problem is in the .shutdown callback that was added to the
> sdhci-iproc and sdhci-brcmstb drivers to save power in S5. The
> shutdown callback will just call the sdhci_pltfm_suspend() function
> to suspend the lower level driver and then stop the sdhci system
> clock. The problem is that in some cases there can be a worker
> thread in the "system_freezable_wq" work queue that is scanning
> for a device every second. In normal system suspend, this queue
> is suspended before the driver suspend is called. In shutdown the
> queue is not suspended and the thread my run after we stop the
> sdhci clock in the shutdown callback which will cause the "clock
> never stabilised" error. The solution will be to have the shutdown
> callback cancel the worker thread before calling suspend (and
> stopping the sdhci clock).
> 
> NOTE: This is only happening on systems with the Legacy RPi SDIO
> core because that's the only controller that doesn't have the
> presence signal and needs to use a worker thread to do a 1 second
> poll loop.
> 
> Fixes: 98b5ce4c08ca ("mmc: sdhci-iproc: Add support for the legacy sdhci controller on the BCM7211")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-iproc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 032bf852397f..05db768edcfc 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -428,6 +428,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>  
>  static void sdhci_iproc_shutdown(struct platform_device *pdev)
>  {
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	/* Cancel possible rescan worker thread */
> +	cancel_delayed_work_sync(&host->mmc->detect);
>  	sdhci_pltfm_suspend(&pdev->dev);
>  }
>  
> 
> base-commit: 58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
> 

I wonder if mmc core should handle this instead. e.g.

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 240c5af793dc..55c509442659 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2264,15 +2264,21 @@ void mmc_start_host(struct mmc_host *host)
 	_mmc_detect_change(host, 0, false);
 }
 
-void mmc_stop_host(struct mmc_host *host)
+void mmc_quiesce_host(struct mmc_host *host)
 {
-	if (host->slot.cd_irq >= 0) {
+	if (host->slot.cd_irq >= 0 && host->slot.irq_enabled) {
 		mmc_gpio_set_cd_wake(host, false);
 		disable_irq(host->slot.cd_irq);
+		host->slot.irq_enabled = false;
 	}
 
 	host->rescan_disable = 1;
 	cancel_delayed_work_sync(&host->detect);
+}
+
+void mmc_stop_host(struct mmc_host *host)
+{
+	mmc_quiesce_host(host);
 
 	/* clear pm flags now and let card drivers set them as needed */
 	host->pm_flags = 0;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 7931a4f0137d..dcee28eec9a6 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -71,6 +71,7 @@ static inline void mmc_delay(unsigned int ms)
 void mmc_rescan(struct work_struct *work);
 void mmc_start_host(struct mmc_host *host);
 void mmc_stop_host(struct mmc_host *host);
+void mmc_quiesce_host(struct mmc_host *host);
 
 void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
 			bool cd_irq);
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d4683b1d263f..5b272f938558 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -80,9 +80,18 @@ static void mmc_host_classdev_release(struct device *dev)
 	kfree(host);
 }
 
+static int mmc_host_shutdown_pre(struct device *dev)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	mmc_quiesce_host(host);
+	return 0;
+}
+
 static struct class mmc_host_class = {
 	.name		= "mmc_host",
 	.dev_release	= mmc_host_classdev_release,
+	.shutdown_pre	= mmc_host_shutdown_pre,
 	.pm		= MMC_HOST_CLASS_DEV_PM_OPS,
 };
 
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index dd2a4b6ab6ad..4967f0b15806 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -110,6 +110,8 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 			ctx->cd_label, host);
 		if (ret < 0)
 			irq = ret;
+		else
+			host->slot.irq_enabled = true;
 	}
 
 	host->slot.cd_irq = irq;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7afb57cab00b..d1fd9b05274b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -263,6 +263,7 @@ struct mmc_async_req {
 struct mmc_slot {
 	int cd_irq;
 	bool cd_wake_enabled;
+	bool irq_enabled;
 	void *handler_priv;
 };
 


