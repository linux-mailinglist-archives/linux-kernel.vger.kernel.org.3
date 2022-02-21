Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07714BDF39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358240AbiBUMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:44:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358194AbiBUMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:44:46 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46407DE88;
        Mon, 21 Feb 2022 04:44:22 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21LCi6qZ069230;
        Mon, 21 Feb 2022 06:44:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645447446;
        bh=qA7WPvJviY9DO6Op6TM/emjhKfwxUvbHjFWufU/07Pw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Oy9Bmns6giMgYmRq4YRrh84jtWW9zi9EgS9JToEG7lLKWfg1WuX44kskoTAlwGc/Y
         XAGD//5Gf+KProIEg01s8hrCTKndLysYMKe7j3LbTRPJ/WNYzW6tl73cZR3gK17+Mk
         rTy7HZ7KjrJ708rakghNDIvmTvzg2nxd/lFdD1sk=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21LCi6do058852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Feb 2022 06:44:06 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 21
 Feb 2022 06:44:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 21 Feb 2022 06:44:05 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21LCi5e5021242;
        Mon, 21 Feb 2022 06:44:05 -0600
Date:   Mon, 21 Feb 2022 06:44:05 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>, Hari Nagalla <hnagalla@ti.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 3/4] watchdog: rti-wdt: attach to running watchdog
 during probe
Message-ID: <20220221124405.o7vda3zaswi6ycrh@favored>
References: <20200717132958.14304-1-t-kristo@ti.com>
 <20200717132958.14304-4-t-kristo@ti.com>
 <a80b83c6-cca5-f95c-6930-a6f3e79c6f15@siemens.com>
 <bdecc38d-2b1a-9605-0978-5ad1e8b39e6b@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdecc38d-2b1a-9605-0978-5ad1e8b39e6b@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:59-20220221, Jan Kiszka wrote:
> On 21.02.22 10:10, Jan Kiszka wrote:
> > On 17.07.20 15:29, Tero Kristo wrote:
> >> If the RTI watchdog is running already during probe, the driver must
> >> configure itself to match the HW. Window size and timeout is probed from
> >> hardware, and the last keepalive ping is adjusted to match it also.
> >>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> ---
> >>  drivers/watchdog/rti_wdt.c | 112 +++++++++++++++++++++++++++++++++----
> >>  1 file changed, 102 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> >> index d456dd72d99a..7cbdc178ffe8 100644
> >> --- a/drivers/watchdog/rti_wdt.c
> >> +++ b/drivers/watchdog/rti_wdt.c
> >> @@ -35,7 +35,11 @@
> >>  
> >>  #define RTIWWDRX_NMI	0xa
> >>  
> >> -#define RTIWWDSIZE_50P	0x50
> >> +#define RTIWWDSIZE_50P		0x50
> >> +#define RTIWWDSIZE_25P		0x500
> >> +#define RTIWWDSIZE_12P5		0x5000
> >> +#define RTIWWDSIZE_6P25		0x50000
> >> +#define RTIWWDSIZE_3P125	0x500000
> >>  
> >>  #define WDENABLE_KEY	0xa98559da
> >>  
> >> @@ -48,7 +52,7 @@
> >>  
> >>  #define DWDST			BIT(1)
> >>  
> >> -static int heartbeat;
> >> +static int heartbeat = DEFAULT_HEARTBEAT;
> >>  
> >>  /*
> >>   * struct to hold data for each WDT device
> >> @@ -79,11 +83,9 @@ static int rti_wdt_start(struct watchdog_device *wdd)
> >>  	 * be petted during the open window; not too early or not too late.
> >>  	 * The HW configuration options only allow for the open window size
> >>  	 * to be 50% or less than that; we obviouly want to configure the open
> >> -	 * window as large as possible so we select the 50% option. To avoid
> >> -	 * any glitches, we accommodate 5% safety margin also, so we setup
> >> -	 * the min_hw_hearbeat at 55% of the timeout period.
> >> +	 * window as large as possible so we select the 50% option.
> >>  	 */
> >> -	wdd->min_hw_heartbeat_ms = 11 * wdd->timeout * 1000 / 20;
> >> +	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
> >>  
> >>  	/* Generate NMI when wdt expires */
> >>  	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
> >> @@ -110,7 +112,48 @@ static int rti_wdt_ping(struct watchdog_device *wdd)
> >>  	return 0;
> >>  }
> >>  
> >> -static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
> >> +static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
> >> +{
> >> +	/*
> >> +	 * RTI only supports a windowed mode, where the watchdog can only
> >> +	 * be petted during the open window; not too early or not too late.
> >> +	 * The HW configuration options only allow for the open window size
> >> +	 * to be 50% or less than that.
> >> +	 */
> >> +	switch (wsize) {
> >> +	case RTIWWDSIZE_50P:
> >> +		/* 50% open window => 50% min heartbeat */
> >> +		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
> >> +		break;
> >> +
> >> +	case RTIWWDSIZE_25P:
> >> +		/* 25% open window => 75% min heartbeat */
> >> +		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
> >> +		break;
> >> +
> >> +	case RTIWWDSIZE_12P5:
> >> +		/* 12.5% open window => 87.5% min heartbeat */
> >> +		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
> >> +		break;
> >> +
> >> +	case RTIWWDSIZE_6P25:
> >> +		/* 6.5% open window => 93.5% min heartbeat */
> >> +		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
> >> +		break;
> >> +
> >> +	case RTIWWDSIZE_3P125:
> >> +		/* 3.125% open window => 96.9% min heartbeat */
> >> +		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
> >> +		break;
> >> +
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static unsigned int rti_wdt_get_timeleft_ms(struct watchdog_device *wdd)
> >>  {
> >>  	u64 timer_counter;
> >>  	u32 val;
> >> @@ -123,11 +166,18 @@ static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
> >>  
> >>  	timer_counter = readl_relaxed(wdt->base + RTIDWDCNTR);
> >>  
> >> +	timer_counter *= 1000;
> >> +
> >>  	do_div(timer_counter, wdt->freq);
> >>  
> >>  	return timer_counter;
> >>  }
> >>  
> >> +static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
> >> +{
> >> +	return rti_wdt_get_timeleft_ms(wdd) / 1000;
> >> +}
> >> +
> >>  static const struct watchdog_info rti_wdt_info = {
> >>  	.options = WDIOF_KEEPALIVEPING,
> >>  	.identity = "K3 RTI Watchdog",
> >> @@ -148,6 +198,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
> >>  	struct watchdog_device *wdd;
> >>  	struct rti_wdt_device *wdt;
> >>  	struct clk *clk;
> >> +	u32 last_ping = 0;
> >>  
> >>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> >>  	if (!wdt)
> >> @@ -169,6 +220,14 @@ static int rti_wdt_probe(struct platform_device *pdev)
> >>  		return -EINVAL;
> >>  	}
> >>  
> >> +	/*
> >> +	 * If watchdog is running at 32k clock, it is not accurate.
> >> +	 * Adjust frequency down in this case so that we don't pet
> >> +	 * the watchdog too often.
> >> +	 */
> >> +	if (wdt->freq < 32768)
> >> +		wdt->freq = wdt->freq * 9 / 10;
> >> +
> > 
> > This seems broken: You are only adjusting the frequency value used by
> > the driver. What has been programmed into the hardware already is still
> > based on real frequency. Moreover, this path is not only taken when the
> > watchdog is already running - but the latter case is what the subject
> > and commit message suggests. I've noticed this by comparing
> > bootloader-programmed values with those the driver assumes to see - 10%
> > off, obviously.
> > 
> > So, what is actually supposed to happen here?



This assumes that the clk is coming in from RC_OSC_32k - which is in the
range of accuracy of 10-20% off clock. also one more variable to keep in
mind is that the 32k divided clk from hfosc will not be exact.

Hari: Thoughts?

> > 
> > Jan
> > 
> >>  	pm_runtime_enable(dev);
> >>  	ret = pm_runtime_get_sync(dev);
> >>  	if (ret) {
> >> @@ -185,11 +244,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
> >>  	wdd->min_timeout = 1;
> >>  	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
> >>  		wdt->freq * 1000;
> >> -	wdd->timeout = DEFAULT_HEARTBEAT;
> >>  	wdd->parent = dev;
> >>  
> >> -	watchdog_init_timeout(wdd, heartbeat, dev);
> >> -
> >>  	watchdog_set_drvdata(wdd, wdt);
> >>  	watchdog_set_nowayout(wdd, 1);
> >>  	watchdog_set_restart_priority(wdd, 128);
> >> @@ -201,12 +257,48 @@ static int rti_wdt_probe(struct platform_device *pdev)
> >>  		goto err_iomap;
> >>  	}
> >>  
> >> +	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
> >> +		u32 time_left_ms;
> >> +		u64 heartbeat_ms;
> >> +		u32 wsize;
> >> +
> >> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> >> +		time_left_ms = rti_wdt_get_timeleft_ms(wdd);
> >> +		heartbeat_ms = readl(wdt->base + RTIDWDPRLD);
> >> +		heartbeat_ms <<= WDT_PRELOAD_SHIFT;
> >> +		heartbeat_ms *= 1000;
> >> +		do_div(heartbeat_ms, wdt->freq);
> >> +		if (heartbeat_ms != heartbeat * 1000)
> >> +			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
> >> +
> >> +		heartbeat = heartbeat_ms;
> >> +		heartbeat /= 1000;
> >> +
> >> +		wsize = readl(wdt->base + RTIWWDSIZECTRL);
> >> +		ret = rti_wdt_setup_hw_hb(wdd, wsize);
> >> +		if (ret) {
> >> +			dev_err(dev, "bad window size.\n");
> >> +			goto err_iomap;
> >> +		}
> >> +
> >> +		last_ping = heartbeat_ms - time_left_ms;
> >> +		if (time_left_ms > heartbeat_ms) {
> >> +			dev_warn(dev, "time_left > heartbeat? Assuming last ping just before now.\n");
> >> +			last_ping = 0;
> >> +		}
> >> +	}
> >> +
> >> +	watchdog_init_timeout(wdd, heartbeat, dev);
> >> +
> >>  	ret = watchdog_register_device(wdd);
> >>  	if (ret) {
> >>  		dev_err(dev, "cannot register watchdog device\n");
> >>  		goto err_iomap;
> >>  	}
> >>  
> >> +	if (last_ping)
> >> +		watchdog_set_last_hw_keepalive(wdd, last_ping);
> >> +
> >>  	return 0;
> >>  
> >>  err_iomap:
> > 
> 
> There is actually more "inaccurate". For now, I would try to address it 
> like this:
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 88815419ad1a..1b6629fa5bfc 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -231,14 +231,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	/*
> -	 * If watchdog is running at 32k clock, it is not accurate.
> -	 * Adjust frequency down in this case so that we don't pet
> -	 * the watchdog too often.
> -	 */
> -	if (wdt->freq < 32768)
> -		wdt->freq = wdt->freq * 9 / 10;
> -
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret) {
> @@ -252,8 +244,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  	wdd->info = &rti_wdt_info;
>  	wdd->ops = &rti_wdt_ops;
>  	wdd->min_timeout = 1;
> -	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
> -		wdt->freq * 1000;
>  	wdd->parent = dev;
>  
>  	watchdog_set_drvdata(wdd, wdt);
> @@ -280,7 +270,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  		if (heartbeat_ms != heartbeat * 1000)
>  			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
>  
> -		heartbeat = heartbeat_ms;
> +		heartbeat = heartbeat_ms + 500;
>  		heartbeat /= 1000;
>  
>  		wsize = readl(wdt->base + RTIWWDSIZECTRL);
> @@ -297,6 +287,17 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * If watchdog is running at 32k clock, it is not accurate.
> +	 * Adjust frequency down in this case so that we don't pet
> +	 * the watchdog too often.
> +	 */
> +	if (wdt->freq < 32768)
> +		wdt->freq = wdt->freq * 9 / 10;
> +
> +	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
> +		wdt->freq * 1000;
> +
>  	watchdog_init_timeout(wdd, heartbeat, dev);
>  
>  	ret = watchdog_register_device(wdd);
> 
> 
> This moves the virtual frequency tweaking after reading back the 
> programmed timeout. It also properly rounds that up to full seconds so 
> that, e.g., bootloader-programmed programmed 60s will become 59s in the 
> driver. That could have led to too short min_hw_heartbeat_ms.
> 
> I can send this out as real patch, but I'd still like to understand the 
> freq fiddling first. Is that addressing a real hardware issue? Or was it 
> actually papering over that round-up problem?
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Competence Center Embedded Linux

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
