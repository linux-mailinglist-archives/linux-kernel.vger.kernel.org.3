Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6C4BE43D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbiBUJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:33:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349545AbiBUJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:26:14 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A91DA53;
        Mon, 21 Feb 2022 01:10:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfywg69aYpHmAqTXaDDzFh9E9U/wm/6gP9CyhoEIkwoRatQnJf6/4LPfW0Gzn2Q4Vsk53lGFnLigXxvrTb6LpEZpRLr4qCBlNQQlMAFtVURtXtSvy6dhtAkeCANY9FwI6W5V380g/qS9xwqVlvg1Y+mIBJqDqx6TZOz2o7pL1pVpCgLsLt1ZEL7xxgZYBjxrtmEr77Q7BkJYNUXqw48fjoeunVUXmKwXDP68v1m/NmSUj5TZHfrfmrFl5piVvMbymtdxc/Oqer3l1kEWSbOmR0HEid6EeVvqsmOj7rr8W6aOJ1gpaB8dV4Zu8+QcWphsi1CV+4TvCLtX2qYeCBNO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLykKgJpEIRiB/PiGIHMYLCcZYNd1Wf4IzA03nr/auw=;
 b=K/P01kuDLeYlK3zubnZvkEBWwA8rSr6jUwoTH/4QGvNyRy+tBok0As1I/l5SGRXdpxay8/DVamQIaFIPnmOVjWesCu/RxGZeZTct7a532SkrUPQIJwNwXoo5/crFSigwh9PpKItm5BkMi3V9rmAJa+iuP2sAjNm6l4lGR0Q0/f/V1Bc1kVQ92ZOYvzmn7XpNJjE7Q8qSw77J0v8LAcXsGlToyxn+fK/S/ZGy9c7rT9nMcsrKzTIWVUUagiNJ5cvAojD2c5rAiGaHEu0qemcu/JTuGQP4DKDWOFGayLuQyYz6egzrJI+rGzF3myh/jeVK5uKJcJO4TLT6GbeUmiocZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=ti.com smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLykKgJpEIRiB/PiGIHMYLCcZYNd1Wf4IzA03nr/auw=;
 b=eMgtJ5rzOpr/zbe5RLTjrHgWINv12Y1kvxJ/r1SGu3/LrzgsB04tpUNQNtXdDf9F4CewcIInRqPrGD4loDrAu6DOHwZu/sIOeSh+v5sm6JS+1YQ2DhKC2/ETfPSYakGGP0ivhHv6vp19qtzh6nxvAXYufiMGMH2qZePiVYsA3HzseiIo4S9O6w88Go4FLl5deJWdsX09Ktl045pbq/HtI2uBT15cLPdJI7DwDNBGuZ0iUiNxyz5cgAkG5aGz0rPe8s8JMZPkBfg/+XMUs8KQrtR6UDEylucv34V4j5AJwh3hZ501LaP8cITxeWtvzWXqPUXzltEVfsZdh11eDrmpsQ==
Received: from DB8PR04CA0025.eurprd04.prod.outlook.com (2603:10a6:10:110::35)
 by AM6PR10MB2885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ea::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Mon, 21 Feb
 2022 09:10:30 +0000
Received: from DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::72) by DB8PR04CA0025.outlook.office365.com
 (2603:10a6:10:110::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 09:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT054.mail.protection.outlook.com (10.152.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 09:10:30 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 10:10:30 +0100
Received: from [167.87.32.158] (167.87.32.158) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 10:10:29 +0100
Message-ID: <a80b83c6-cca5-f95c-6930-a6f3e79c6f15@siemens.com>
Date:   Mon, 21 Feb 2022 10:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 3/4] watchdog: rti-wdt: attach to running watchdog
 during probe
Content-Language: en-US
To:     Tero Kristo <t-kristo@ti.com>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20200717132958.14304-1-t-kristo@ti.com>
 <20200717132958.14304-4-t-kristo@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20200717132958.14304-4-t-kristo@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.158]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d4935b-7d93-4082-64db-08d9f51a0240
X-MS-TrafficTypeDiagnostic: AM6PR10MB2885:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB288587DE0D1E4528BBB6619B953A9@AM6PR10MB2885.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIiimBcULKymAifGAyPUdyA7/Xng9NUFOfe59WzU3YIzWsFNlQAY9qcGwLtx41d8gpG8TcTj5dhAuu0DF7ORBr+Oluyh+HvHJwjbolD6+kmti3k1o/0C/u7ULO9OopwkkkZmmYM080/UoTbhTDhpWabiZQ0ebEOqAYU37xzJXX1JQAIl7RVIMCyt92shmertPdL3EUz/0iYoevTbJoLRlfMQ7connsbLGBEZuq+EnlgDkwqVJDWA5UtG8K9FYviri6QDQkr2xPMxuiOzXMy5NH4mGho37uerUr4AXklD97J3HVZXsF+VWZUprlzwxiC/Lr6aBtzdkblW8XaJCQFvPnPCWzNLMjA4TBhHTCxaW8B5UsQ+MWca//REYVcNZDtWRWAssDVSUfZFgegG1Y0Io9nlQBXY1wXd3t0pzGZ2n3PH1ua8OCZFDKdf3hGYJEWIT0QZsPf/4JqEp7wp7ADEddo8VppYsKh0cxy/RcEWH9gVji8l7ndZasj+rTMIaa6a8P0K85miFCqWf04WNRNs3V30IgKb57YkTWGC1FBwk235NX0JUkOs/eg0uj/nThiWl0C917LHEj+s2hEGM79TSClTGOzbQZ2ptjySkY/6DznlZRhGeUZgpnHyJm/mvtzgAhMcuMRhvlLXNnxQd40JSGh6d1/mmGCScJO/4V5mbv4NCLDTDaPY3BQXb7qD0rOCMPMvWhMTLnJTejch/pWpqaQsqfUiQ4v0DWnKAHuVajvDMHsDoqpshAoOEFKB9AO/5H+uFubOnBeo5kXRIHBkRNc/oVvz6HNvsPTYxf+RM+A=
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(336012)(47076005)(40460700003)(83380400001)(36756003)(44832011)(5660300002)(2906002)(31686004)(8936002)(956004)(2616005)(6706004)(8676002)(110136005)(53546011)(16526019)(186003)(26005)(70206006)(70586007)(81166007)(356005)(82960400001)(16576012)(316002)(508600001)(31696002)(86362001)(36860700001)(82310400004)(3940600001)(36900700001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 09:10:30.4584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d4935b-7d93-4082-64db-08d9f51a0240
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT054.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.20 15:29, Tero Kristo wrote:
> If the RTI watchdog is running already during probe, the driver must
> configure itself to match the HW. Window size and timeout is probed from
> hardware, and the last keepalive ping is adjusted to match it also.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/watchdog/rti_wdt.c | 112 +++++++++++++++++++++++++++++++++----
>  1 file changed, 102 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index d456dd72d99a..7cbdc178ffe8 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -35,7 +35,11 @@
>  
>  #define RTIWWDRX_NMI	0xa
>  
> -#define RTIWWDSIZE_50P	0x50
> +#define RTIWWDSIZE_50P		0x50
> +#define RTIWWDSIZE_25P		0x500
> +#define RTIWWDSIZE_12P5		0x5000
> +#define RTIWWDSIZE_6P25		0x50000
> +#define RTIWWDSIZE_3P125	0x500000
>  
>  #define WDENABLE_KEY	0xa98559da
>  
> @@ -48,7 +52,7 @@
>  
>  #define DWDST			BIT(1)
>  
> -static int heartbeat;
> +static int heartbeat = DEFAULT_HEARTBEAT;
>  
>  /*
>   * struct to hold data for each WDT device
> @@ -79,11 +83,9 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>  	 * be petted during the open window; not too early or not too late.
>  	 * The HW configuration options only allow for the open window size
>  	 * to be 50% or less than that; we obviouly want to configure the open
> -	 * window as large as possible so we select the 50% option. To avoid
> -	 * any glitches, we accommodate 5% safety margin also, so we setup
> -	 * the min_hw_hearbeat at 55% of the timeout period.
> +	 * window as large as possible so we select the 50% option.
>  	 */
> -	wdd->min_hw_heartbeat_ms = 11 * wdd->timeout * 1000 / 20;
> +	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
>  
>  	/* Generate NMI when wdt expires */
>  	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
> @@ -110,7 +112,48 @@ static int rti_wdt_ping(struct watchdog_device *wdd)
>  	return 0;
>  }
>  
> -static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
> +static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
> +{
> +	/*
> +	 * RTI only supports a windowed mode, where the watchdog can only
> +	 * be petted during the open window; not too early or not too late.
> +	 * The HW configuration options only allow for the open window size
> +	 * to be 50% or less than that.
> +	 */
> +	switch (wsize) {
> +	case RTIWWDSIZE_50P:
> +		/* 50% open window => 50% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
> +		break;
> +
> +	case RTIWWDSIZE_25P:
> +		/* 25% open window => 75% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
> +		break;
> +
> +	case RTIWWDSIZE_12P5:
> +		/* 12.5% open window => 87.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
> +		break;
> +
> +	case RTIWWDSIZE_6P25:
> +		/* 6.5% open window => 93.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
> +		break;
> +
> +	case RTIWWDSIZE_3P125:
> +		/* 3.125% open window => 96.9% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static unsigned int rti_wdt_get_timeleft_ms(struct watchdog_device *wdd)
>  {
>  	u64 timer_counter;
>  	u32 val;
> @@ -123,11 +166,18 @@ static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>  
>  	timer_counter = readl_relaxed(wdt->base + RTIDWDCNTR);
>  
> +	timer_counter *= 1000;
> +
>  	do_div(timer_counter, wdt->freq);
>  
>  	return timer_counter;
>  }
>  
> +static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	return rti_wdt_get_timeleft_ms(wdd) / 1000;
> +}
> +
>  static const struct watchdog_info rti_wdt_info = {
>  	.options = WDIOF_KEEPALIVEPING,
>  	.identity = "K3 RTI Watchdog",
> @@ -148,6 +198,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  	struct watchdog_device *wdd;
>  	struct rti_wdt_device *wdt;
>  	struct clk *clk;
> +	u32 last_ping = 0;
>  
>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
> @@ -169,6 +220,14 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  		return -EINVAL;
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

This seems broken: You are only adjusting the frequency value used by
the driver. What has been programmed into the hardware already is still
based on real frequency. Moreover, this path is not only taken when the
watchdog is already running - but the latter case is what the subject
and commit message suggests. I've noticed this by comparing
bootloader-programmed values with those the driver assumes to see - 10%
off, obviously.

So, what is actually supposed to happen here?

Jan

>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret) {
> @@ -185,11 +244,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  	wdd->min_timeout = 1;
>  	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>  		wdt->freq * 1000;
> -	wdd->timeout = DEFAULT_HEARTBEAT;
>  	wdd->parent = dev;
>  
> -	watchdog_init_timeout(wdd, heartbeat, dev);
> -
>  	watchdog_set_drvdata(wdd, wdt);
>  	watchdog_set_nowayout(wdd, 1);
>  	watchdog_set_restart_priority(wdd, 128);
> @@ -201,12 +257,48 @@ static int rti_wdt_probe(struct platform_device *pdev)
>  		goto err_iomap;
>  	}
>  
> +	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
> +		u32 time_left_ms;
> +		u64 heartbeat_ms;
> +		u32 wsize;
> +
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		time_left_ms = rti_wdt_get_timeleft_ms(wdd);
> +		heartbeat_ms = readl(wdt->base + RTIDWDPRLD);
> +		heartbeat_ms <<= WDT_PRELOAD_SHIFT;
> +		heartbeat_ms *= 1000;
> +		do_div(heartbeat_ms, wdt->freq);
> +		if (heartbeat_ms != heartbeat * 1000)
> +			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
> +
> +		heartbeat = heartbeat_ms;
> +		heartbeat /= 1000;
> +
> +		wsize = readl(wdt->base + RTIWWDSIZECTRL);
> +		ret = rti_wdt_setup_hw_hb(wdd, wsize);
> +		if (ret) {
> +			dev_err(dev, "bad window size.\n");
> +			goto err_iomap;
> +		}
> +
> +		last_ping = heartbeat_ms - time_left_ms;
> +		if (time_left_ms > heartbeat_ms) {
> +			dev_warn(dev, "time_left > heartbeat? Assuming last ping just before now.\n");
> +			last_ping = 0;
> +		}
> +	}
> +
> +	watchdog_init_timeout(wdd, heartbeat, dev);
> +
>  	ret = watchdog_register_device(wdd);
>  	if (ret) {
>  		dev_err(dev, "cannot register watchdog device\n");
>  		goto err_iomap;
>  	}
>  
> +	if (last_ping)
> +		watchdog_set_last_hw_keepalive(wdd, last_ping);
> +
>  	return 0;
>  
>  err_iomap:

-- 
Siemens AG, Technology
Competence Center Embedded Linux
