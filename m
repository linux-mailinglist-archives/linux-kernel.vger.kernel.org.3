Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19354BDF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355150AbiBUKhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:37:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354984AbiBUKha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:37:30 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AE338D9C;
        Mon, 21 Feb 2022 01:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=To7FWiheBd/kzXznayqX9ROXITQy94YS7Py5VINT2HR3Z+G9iNpZ7iLA1wVQ05dumINI3gLow1V6OP0PRG0b6gyUaZeiBvnPAh3IIDWRVprz+zCAWe/PqlaF94VMCgKp4BcJo9XwEUBnU6GrotaV3iYgQtvIiC6/AKFmJR75nETAh0di3RUrn8Sz0cdkHcNFAitYO6AfFqRTUYT0SXkDgNTG7yV9yKD9qagVDIGi8N+uhXt7B2WMKO3KB5cvTiy6h5I10Bj48ny+Qs1r2SMhu+ODMRxy3qoptSyjaAGYD6pgxy84cGhQzJh3C6guFRtCX74rxrhH2yE77Rj0x+al5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIQnhSjjFF2b9m2I1v7Di3zlASRbBr5XMkvi1x/ei/w=;
 b=I6ys6CTaZG+cuehwucp6vUGQK+HXONWq+FUHiRCHxgXrNYgCSgoyQPB6NyffZoCJE1QiOSpeJdcySaJ5nMslXCoiM4ffoUBC5Ici1ZG1+fgCpNv6gRw8vWCkYkkL6bIt2Uq6svTfUEaMQxg5zuPW6bMlw71JJkjQUKhZKVfpwM9N2elMRWqolMEnoDp8DvY1mt/ctTFU5TUZPn4K814rNWE7b8zFE0SKkoQNe+5DEvELyN6yqyJqa0m5Gxlk4d2sSt8HuMUgZGqadQni+8wbpP+Awcv8frVpTyFLFELcSm1JE2m3LhlLsiF92ya34ipZ+xMf72rFTOA24eUUGQFxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIQnhSjjFF2b9m2I1v7Di3zlASRbBr5XMkvi1x/ei/w=;
 b=mHkY3ygPUXi1Ut03O66lR2gZhJtNcp31DdJ2Pgu+KzOYIGbvkX/qtre7fOOdlgpycAXigYMWzeabD9ihyXnG3dXaG8H9tix/v6n64rNcAZtyO8PyShokgQqT/Fgop57aMov81pP7FbZ4P19ubcOJKm7KnaC5zspBqXKKnesA4ol6tupDdVWwNFQP9rRRtZ20FywWVkM5JaeKLsHW6yp6KwgJKhw+U5I+DScW4R7bZh1J9Rd8XJUQ0giXbdO80ElU8ykkcbam+U8jtkAiL46kf1R00NcFSRRReXFVy0faNNQB31tVWqZ7iClf4RiYthbLKf2rdPEdXtUfk0RIKisGqw==
Received: from AS8PR04CA0091.eurprd04.prod.outlook.com (2603:10a6:20b:31e::6)
 by PR3PR10MB4318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 09:59:22 +0000
Received: from VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::80) by AS8PR04CA0091.outlook.office365.com
 (2603:10a6:20b:31e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 09:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT055.mail.protection.outlook.com (10.152.3.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 09:59:22 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 10:59:21 +0100
Received: from [167.87.32.158] (167.87.32.158) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 10:59:21 +0100
Message-ID: <bdecc38d-2b1a-9605-0978-5ad1e8b39e6b@siemens.com>
Date:   Mon, 21 Feb 2022 10:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 3/4] watchdog: rti-wdt: attach to running watchdog
 during probe
Content-Language: en-US
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, Nishanth Menon <nm@ti.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20200717132958.14304-1-t-kristo@ti.com>
 <20200717132958.14304-4-t-kristo@ti.com>
 <a80b83c6-cca5-f95c-6930-a6f3e79c6f15@siemens.com>
In-Reply-To: <a80b83c6-cca5-f95c-6930-a6f3e79c6f15@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.158]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90ca5808-9bca-465b-5ab4-08d9f520d592
X-MS-TrafficTypeDiagnostic: PR3PR10MB4318:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB4318659CC1CF5FBD41FBBD4B953A9@PR3PR10MB4318.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1guPrb6nEJh0QbRATG9+0GT2a1d3U0NdNtLpiybSzjRvuPKv8NlnMU4CaaVlDk/EaMgmum3FXclgQuif3xYh7ehDV9A2MDGXxmHe48fAhvIr5W7LFz552oCqyrR1bijTdec+W9KQ3bdXnklvbUDrBOBCkAi39BH3UxHDhDOZhu3KDtK/gFqEZUUEJsH6RBpy62otZmIyGiQDXEvujMtzNFhMX6S4dyW+Mpjhhda0Spfful83iQrAVaiqCwKPDZOfpczM78ZOBYgBHR79fIWYDprcwm23k1YPqpP+zNlqqMYBlDkEJaSzum8xBLuSEfXrWJBOd4kGRkYZTvvWqI73Be2hJ45kXUEHG2mqR7MvU2FqbJFLPixLVdIbC7k6EcEP8Pz1/Rs4MlZd17MFMsCKY+MWgb5yN9lqp1l3IW4C6xrpRA0y9bzbM/8COUM2pgcJOTQryhTpVw85nIb8cR4jTx38J49pol/O20q5ilfkDm4//uTUgLLfT2awFqR7urFgi6Rku+LPRScfMD2fT3P4EbNvRah+fOuYNkrUIAWVlBP5UmNKoX+R4Cp5gpn0ZvBdzRIIIHWofxiGaYsLIcpPoxDpuNo8qhBrq20vyrOUrRt+XTAAGeIDJP3g23yZsb50ufOXDHW8H0w1Ezm1EU5S02QsWmp3t4+YLD4Y2ZTwPJXJJ/8vladNliAmP4IjmE1JTkoU1ZVFHDa8pu/CTdKqTdGk5iFL0zl+zPQ1SGvdLUwgSnTG1WWcYVovHBrRSWb5ktNKQSrL8Qzz/Jsn7rBzf5CzL1T6gInoZPqF/Mb256g=
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(508600001)(31686004)(53546011)(2616005)(47076005)(956004)(2906002)(36860700001)(16526019)(5660300002)(186003)(110136005)(6706004)(8936002)(26005)(16576012)(316002)(44832011)(356005)(31696002)(82310400004)(86362001)(82960400001)(81166007)(336012)(70586007)(70206006)(83380400001)(4326008)(8676002)(3940600001)(2101003)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 09:59:22.0013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ca5808-9bca-465b-5ab4-08d9f520d592
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4318
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.22 10:10, Jan Kiszka wrote:
> On 17.07.20 15:29, Tero Kristo wrote:
>> If the RTI watchdog is running already during probe, the driver must
>> configure itself to match the HW. Window size and timeout is probed from
>> hardware, and the last keepalive ping is adjusted to match it also.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>  drivers/watchdog/rti_wdt.c | 112 +++++++++++++++++++++++++++++++++----
>>  1 file changed, 102 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
>> index d456dd72d99a..7cbdc178ffe8 100644
>> --- a/drivers/watchdog/rti_wdt.c
>> +++ b/drivers/watchdog/rti_wdt.c
>> @@ -35,7 +35,11 @@
>>  
>>  #define RTIWWDRX_NMI	0xa
>>  
>> -#define RTIWWDSIZE_50P	0x50
>> +#define RTIWWDSIZE_50P		0x50
>> +#define RTIWWDSIZE_25P		0x500
>> +#define RTIWWDSIZE_12P5		0x5000
>> +#define RTIWWDSIZE_6P25		0x50000
>> +#define RTIWWDSIZE_3P125	0x500000
>>  
>>  #define WDENABLE_KEY	0xa98559da
>>  
>> @@ -48,7 +52,7 @@
>>  
>>  #define DWDST			BIT(1)
>>  
>> -static int heartbeat;
>> +static int heartbeat = DEFAULT_HEARTBEAT;
>>  
>>  /*
>>   * struct to hold data for each WDT device
>> @@ -79,11 +83,9 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>>  	 * be petted during the open window; not too early or not too late.
>>  	 * The HW configuration options only allow for the open window size
>>  	 * to be 50% or less than that; we obviouly want to configure the open
>> -	 * window as large as possible so we select the 50% option. To avoid
>> -	 * any glitches, we accommodate 5% safety margin also, so we setup
>> -	 * the min_hw_hearbeat at 55% of the timeout period.
>> +	 * window as large as possible so we select the 50% option.
>>  	 */
>> -	wdd->min_hw_heartbeat_ms = 11 * wdd->timeout * 1000 / 20;
>> +	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
>>  
>>  	/* Generate NMI when wdt expires */
>>  	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
>> @@ -110,7 +112,48 @@ static int rti_wdt_ping(struct watchdog_device *wdd)
>>  	return 0;
>>  }
>>  
>> -static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>> +static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
>> +{
>> +	/*
>> +	 * RTI only supports a windowed mode, where the watchdog can only
>> +	 * be petted during the open window; not too early or not too late.
>> +	 * The HW configuration options only allow for the open window size
>> +	 * to be 50% or less than that.
>> +	 */
>> +	switch (wsize) {
>> +	case RTIWWDSIZE_50P:
>> +		/* 50% open window => 50% min heartbeat */
>> +		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
>> +		break;
>> +
>> +	case RTIWWDSIZE_25P:
>> +		/* 25% open window => 75% min heartbeat */
>> +		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
>> +		break;
>> +
>> +	case RTIWWDSIZE_12P5:
>> +		/* 12.5% open window => 87.5% min heartbeat */
>> +		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
>> +		break;
>> +
>> +	case RTIWWDSIZE_6P25:
>> +		/* 6.5% open window => 93.5% min heartbeat */
>> +		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
>> +		break;
>> +
>> +	case RTIWWDSIZE_3P125:
>> +		/* 3.125% open window => 96.9% min heartbeat */
>> +		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
>> +		break;
>> +
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static unsigned int rti_wdt_get_timeleft_ms(struct watchdog_device *wdd)
>>  {
>>  	u64 timer_counter;
>>  	u32 val;
>> @@ -123,11 +166,18 @@ static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>>  
>>  	timer_counter = readl_relaxed(wdt->base + RTIDWDCNTR);
>>  
>> +	timer_counter *= 1000;
>> +
>>  	do_div(timer_counter, wdt->freq);
>>  
>>  	return timer_counter;
>>  }
>>  
>> +static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +	return rti_wdt_get_timeleft_ms(wdd) / 1000;
>> +}
>> +
>>  static const struct watchdog_info rti_wdt_info = {
>>  	.options = WDIOF_KEEPALIVEPING,
>>  	.identity = "K3 RTI Watchdog",
>> @@ -148,6 +198,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  	struct watchdog_device *wdd;
>>  	struct rti_wdt_device *wdt;
>>  	struct clk *clk;
>> +	u32 last_ping = 0;
>>  
>>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>  	if (!wdt)
>> @@ -169,6 +220,14 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  	}
>>  
>> +	/*
>> +	 * If watchdog is running at 32k clock, it is not accurate.
>> +	 * Adjust frequency down in this case so that we don't pet
>> +	 * the watchdog too often.
>> +	 */
>> +	if (wdt->freq < 32768)
>> +		wdt->freq = wdt->freq * 9 / 10;
>> +
> 
> This seems broken: You are only adjusting the frequency value used by
> the driver. What has been programmed into the hardware already is still
> based on real frequency. Moreover, this path is not only taken when the
> watchdog is already running - but the latter case is what the subject
> and commit message suggests. I've noticed this by comparing
> bootloader-programmed values with those the driver assumes to see - 10%
> off, obviously.
> 
> So, what is actually supposed to happen here?
> 
> Jan
> 
>>  	pm_runtime_enable(dev);
>>  	ret = pm_runtime_get_sync(dev);
>>  	if (ret) {
>> @@ -185,11 +244,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  	wdd->min_timeout = 1;
>>  	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>>  		wdt->freq * 1000;
>> -	wdd->timeout = DEFAULT_HEARTBEAT;
>>  	wdd->parent = dev;
>>  
>> -	watchdog_init_timeout(wdd, heartbeat, dev);
>> -
>>  	watchdog_set_drvdata(wdd, wdt);
>>  	watchdog_set_nowayout(wdd, 1);
>>  	watchdog_set_restart_priority(wdd, 128);
>> @@ -201,12 +257,48 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  		goto err_iomap;
>>  	}
>>  
>> +	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
>> +		u32 time_left_ms;
>> +		u64 heartbeat_ms;
>> +		u32 wsize;
>> +
>> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
>> +		time_left_ms = rti_wdt_get_timeleft_ms(wdd);
>> +		heartbeat_ms = readl(wdt->base + RTIDWDPRLD);
>> +		heartbeat_ms <<= WDT_PRELOAD_SHIFT;
>> +		heartbeat_ms *= 1000;
>> +		do_div(heartbeat_ms, wdt->freq);
>> +		if (heartbeat_ms != heartbeat * 1000)
>> +			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
>> +
>> +		heartbeat = heartbeat_ms;
>> +		heartbeat /= 1000;
>> +
>> +		wsize = readl(wdt->base + RTIWWDSIZECTRL);
>> +		ret = rti_wdt_setup_hw_hb(wdd, wsize);
>> +		if (ret) {
>> +			dev_err(dev, "bad window size.\n");
>> +			goto err_iomap;
>> +		}
>> +
>> +		last_ping = heartbeat_ms - time_left_ms;
>> +		if (time_left_ms > heartbeat_ms) {
>> +			dev_warn(dev, "time_left > heartbeat? Assuming last ping just before now.\n");
>> +			last_ping = 0;
>> +		}
>> +	}
>> +
>> +	watchdog_init_timeout(wdd, heartbeat, dev);
>> +
>>  	ret = watchdog_register_device(wdd);
>>  	if (ret) {
>>  		dev_err(dev, "cannot register watchdog device\n");
>>  		goto err_iomap;
>>  	}
>>  
>> +	if (last_ping)
>> +		watchdog_set_last_hw_keepalive(wdd, last_ping);
>> +
>>  	return 0;
>>  
>>  err_iomap:
> 

There is actually more "inaccurate". For now, I would try to address it 
like this:

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 88815419ad1a..1b6629fa5bfc 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -231,14 +231,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/*
-	 * If watchdog is running at 32k clock, it is not accurate.
-	 * Adjust frequency down in this case so that we don't pet
-	 * the watchdog too often.
-	 */
-	if (wdt->freq < 32768)
-		wdt->freq = wdt->freq * 9 / 10;
-
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret) {
@@ -252,8 +244,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
 	wdd->info = &rti_wdt_info;
 	wdd->ops = &rti_wdt_ops;
 	wdd->min_timeout = 1;
-	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
-		wdt->freq * 1000;
 	wdd->parent = dev;
 
 	watchdog_set_drvdata(wdd, wdt);
@@ -280,7 +270,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		if (heartbeat_ms != heartbeat * 1000)
 			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
 
-		heartbeat = heartbeat_ms;
+		heartbeat = heartbeat_ms + 500;
 		heartbeat /= 1000;
 
 		wsize = readl(wdt->base + RTIWWDSIZECTRL);
@@ -297,6 +287,17 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
+	/*
+	 * If watchdog is running at 32k clock, it is not accurate.
+	 * Adjust frequency down in this case so that we don't pet
+	 * the watchdog too often.
+	 */
+	if (wdt->freq < 32768)
+		wdt->freq = wdt->freq * 9 / 10;
+
+	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
+		wdt->freq * 1000;
+
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
 	ret = watchdog_register_device(wdd);


This moves the virtual frequency tweaking after reading back the 
programmed timeout. It also properly rounds that up to full seconds so 
that, e.g., bootloader-programmed programmed 60s will become 59s in the 
driver. That could have led to too short min_hw_heartbeat_ms.

I can send this out as real patch, but I'd still like to understand the 
freq fiddling first. Is that addressing a real hardware issue? Or was it 
actually papering over that round-up problem?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
