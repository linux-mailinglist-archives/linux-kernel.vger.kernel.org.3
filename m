Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56B84BE2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358358AbiBUMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:53:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358348AbiBUMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:53:50 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A7D1C10F;
        Mon, 21 Feb 2022 04:53:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuRx4GS2935aIuu8dGHN9AKJWmT3Y68JNJlu+jJ9rz4fGjO+eEVfJKMMsc620kqlNOCtMRO/r6E3zZUNVEAy6d9O/bWcj5ULwFmFMB+aQ0mWfFSi/Qjaw7cgV9KSX5b+jMfcOgDjX7xbAWsP5soTbDO9yoVk0D36iKY3XesHT5n3irDAUqjizWGCY8XQ3vHpptVf07xhHyLlnhePlSul10LV+oEjg4gML44mOQ5w3Uf4noT1UAWRaVKBr69KodCjjus1XgOSibBJkQ3sJAITzoPjA61RC2mVCAfqOdjDWN9DdXJwFxE0ZIhfHNnrIe/lk5M4+jEzHwHwbDxVsTGOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jWGvmsAY89om/jNrJ4DHV+1WDfIseiXhGg79dbT4RI=;
 b=PhJtmT78pG5Hw3d+O6s1VxpHNxA9XgXVLKqGIavjv8Ov5kURSaOjNnYXk20H53WyDEncp78NfGwOUrZ1fNg3QHjNOuw308yEkfwB8qSpJhxjTOqID8nroBuIqp2GYic6lpaWZHkx3FJYt/5Abe1h6/9iDz7PArsDMAFUwrTTtP9ZmBreeDgw0aTMJrElFExIsqh6UAuB901cD9S5RrSUPBGhCfaf+3wf3atuvHY+6a5l1pKAyRUTOlNoNHQyB3AoXamfHk7fb8bNNTez2i9Fn0Y2oLndeuMbiJ6jZ8+puL2l+qE0cWk/MRD98DUBQJOtQVV+9wOYF3zhpndY3NQ4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=ti.com smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jWGvmsAY89om/jNrJ4DHV+1WDfIseiXhGg79dbT4RI=;
 b=dTDOLYzFZ2d2nSFYmx3USwer7u5Mn2rH/ZRofeSWT8p60BuOKQqAeRuFVBQdMGuWbKycd7PpHffxJZs/arO+MOobzhyu9Cr8cMt3DlafTXCIo9dWtbEi6xUpD2oASSNZDOZwWVpuBcTHy+KzWDlZhBYSHGg1BE6kor1WchErgAW6KRtjUI8j/8tB9GzN/0COrTSABHHE35DZl33LHRUcbUd6D1a4AAVqTg5PxqDa8cUknOpvWsVsO8ZYODUOghkZhQMuh3/YfKIzyze7lsrgpR5l9WiMdhfRV5wPyfvhhGz70EKlzDSLJA3UJb188hzdQ9HzaOBhRmnTtK6+EtCBew==
Received: from DU2PR04CA0077.eurprd04.prod.outlook.com (2603:10a6:10:232::22)
 by AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:35::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Mon, 21 Feb
 2022 12:53:24 +0000
Received: from DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::34) by DU2PR04CA0077.outlook.office365.com
 (2603:10a6:10:232::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 12:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT013.mail.protection.outlook.com (10.152.4.239) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Mon, 21 Feb 2022 12:53:24 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 13:53:24 +0100
Received: from [139.22.139.231] (139.22.139.231) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 13:53:23 +0100
Message-ID: <8a3f83be-172b-a0c8-d4ba-befa531e52f6@siemens.com>
Date:   Mon, 21 Feb 2022 13:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 3/4] watchdog: rti-wdt: attach to running watchdog
 during probe
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Hari Nagalla <hnagalla@ti.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200717132958.14304-1-t-kristo@ti.com>
 <20200717132958.14304-4-t-kristo@ti.com>
 <a80b83c6-cca5-f95c-6930-a6f3e79c6f15@siemens.com>
 <bdecc38d-2b1a-9605-0978-5ad1e8b39e6b@siemens.com>
 <20220221124405.o7vda3zaswi6ycrh@favored>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220221124405.o7vda3zaswi6ycrh@favored>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.139.231]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ad4a1dd-971c-4475-a350-08d9f53925c8
X-MS-TrafficTypeDiagnostic: AM6PR10MB1926:EE_
X-Microsoft-Antispam-PRVS: <AM6PR10MB1926D7D9305A32F41DA3FA57953A9@AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPoJWnjMe1tEVe8/TU4Yg4AEm+WCZf5jqysnE312hYQis20bDsy4xFcAmNpBu6SqJYUi6HmZ+26jl1jMcRhQ51zyX8Um/m8g97wfowxlWeBjyt8nypriexQ4AJrTUnPNCPc1BphTO4SGEV1CTD9qu6RU+CYIS/uCMTBz7g6NFlocGek8RetBnMGeNM/fQygDAtAPgJRmgQa/moJ/lXMRzSUT6UsLSNIT6Z+zqAzzOcjj/UMvkp8ejbrnVdi3rdw5GryZ7Ef4p+fLwnI96Rp8wuQcX/9Sp2GXInII7t/raWtosLaNGUQ85LpxNrJhJ2c9GFO0cu8PxWUg1Gh6BTa8Hs3SE2IvAGk9ykqDd+DVdxidJaxJk+B2DY8ZLhcC5jqYYtK9dSHkBIuUin9Iw7g2YeETAp3VPsSF1HPvQLfjY0ZYRVoRQCo43LWaFtJhkGGh8hjg7dZuIdDTZWx3bx0qSogj7PNLwc9KU6wTViSPFf8VVrKwGkSzvsLH/k67/QL9cvdXAjjt3TztXHixh0702nzRNCyEpFs8IWi8i7LSy9xPpYXCy1o29pBHD+/uBZQSs8C/mrbK1hBgkZzl03fykz6jD1ubz+fZtw4vxUSnqUF7Y4eiaRvDzlDXk5kF59lJjPmpAk0Jp32p3hNhTnXVzVDMo02xyEWyj/Hn54IcBpmuojiWpRO6H6RqwJ2V+2MV8SqfG87QUO4MTpMajWUfvUROHcg4IusKRzFnPMew3eQvte506SI5qzmUsqZA6XwQ0mxlFgXmAzANDR9R3Pwiow==
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(16576012)(2616005)(356005)(186003)(16526019)(36860700001)(26005)(31686004)(2906002)(336012)(508600001)(54906003)(956004)(81166007)(316002)(36756003)(6706004)(31696002)(4326008)(5660300002)(8936002)(30864003)(53546011)(44832011)(70206006)(47076005)(86362001)(40460700003)(82960400001)(83380400001)(70586007)(8676002)(82310400004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 12:53:24.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad4a1dd-971c-4475-a350-08d9f53925c8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1926
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.22 13:44, Nishanth Menon wrote:
> On 10:59-20220221, Jan Kiszka wrote:
>> On 21.02.22 10:10, Jan Kiszka wrote:
>>> On 17.07.20 15:29, Tero Kristo wrote:
>>>> If the RTI watchdog is running already during probe, the driver must
>>>> configure itself to match the HW. Window size and timeout is probed from
>>>> hardware, and the last keepalive ping is adjusted to match it also.
>>>>
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> ---
>>>>  drivers/watchdog/rti_wdt.c | 112 +++++++++++++++++++++++++++++++++----
>>>>  1 file changed, 102 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
>>>> index d456dd72d99a..7cbdc178ffe8 100644
>>>> --- a/drivers/watchdog/rti_wdt.c
>>>> +++ b/drivers/watchdog/rti_wdt.c
>>>> @@ -35,7 +35,11 @@
>>>>  
>>>>  #define RTIWWDRX_NMI	0xa
>>>>  
>>>> -#define RTIWWDSIZE_50P	0x50
>>>> +#define RTIWWDSIZE_50P		0x50
>>>> +#define RTIWWDSIZE_25P		0x500
>>>> +#define RTIWWDSIZE_12P5		0x5000
>>>> +#define RTIWWDSIZE_6P25		0x50000
>>>> +#define RTIWWDSIZE_3P125	0x500000
>>>>  
>>>>  #define WDENABLE_KEY	0xa98559da
>>>>  
>>>> @@ -48,7 +52,7 @@
>>>>  
>>>>  #define DWDST			BIT(1)
>>>>  
>>>> -static int heartbeat;
>>>> +static int heartbeat = DEFAULT_HEARTBEAT;
>>>>  
>>>>  /*
>>>>   * struct to hold data for each WDT device
>>>> @@ -79,11 +83,9 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>>>>  	 * be petted during the open window; not too early or not too late.
>>>>  	 * The HW configuration options only allow for the open window size
>>>>  	 * to be 50% or less than that; we obviouly want to configure the open
>>>> -	 * window as large as possible so we select the 50% option. To avoid
>>>> -	 * any glitches, we accommodate 5% safety margin also, so we setup
>>>> -	 * the min_hw_hearbeat at 55% of the timeout period.
>>>> +	 * window as large as possible so we select the 50% option.
>>>>  	 */
>>>> -	wdd->min_hw_heartbeat_ms = 11 * wdd->timeout * 1000 / 20;
>>>> +	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
>>>>  
>>>>  	/* Generate NMI when wdt expires */
>>>>  	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
>>>> @@ -110,7 +112,48 @@ static int rti_wdt_ping(struct watchdog_device *wdd)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>>>> +static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
>>>> +{
>>>> +	/*
>>>> +	 * RTI only supports a windowed mode, where the watchdog can only
>>>> +	 * be petted during the open window; not too early or not too late.
>>>> +	 * The HW configuration options only allow for the open window size
>>>> +	 * to be 50% or less than that.
>>>> +	 */
>>>> +	switch (wsize) {
>>>> +	case RTIWWDSIZE_50P:
>>>> +		/* 50% open window => 50% min heartbeat */
>>>> +		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
>>>> +		break;
>>>> +
>>>> +	case RTIWWDSIZE_25P:
>>>> +		/* 25% open window => 75% min heartbeat */
>>>> +		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
>>>> +		break;
>>>> +
>>>> +	case RTIWWDSIZE_12P5:
>>>> +		/* 12.5% open window => 87.5% min heartbeat */
>>>> +		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
>>>> +		break;
>>>> +
>>>> +	case RTIWWDSIZE_6P25:
>>>> +		/* 6.5% open window => 93.5% min heartbeat */
>>>> +		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
>>>> +		break;
>>>> +
>>>> +	case RTIWWDSIZE_3P125:
>>>> +		/* 3.125% open window => 96.9% min heartbeat */
>>>> +		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
>>>> +		break;
>>>> +
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static unsigned int rti_wdt_get_timeleft_ms(struct watchdog_device *wdd)
>>>>  {
>>>>  	u64 timer_counter;
>>>>  	u32 val;
>>>> @@ -123,11 +166,18 @@ static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>>>>  
>>>>  	timer_counter = readl_relaxed(wdt->base + RTIDWDCNTR);
>>>>  
>>>> +	timer_counter *= 1000;
>>>> +
>>>>  	do_div(timer_counter, wdt->freq);
>>>>  
>>>>  	return timer_counter;
>>>>  }
>>>>  
>>>> +static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>>>> +{
>>>> +	return rti_wdt_get_timeleft_ms(wdd) / 1000;
>>>> +}
>>>> +
>>>>  static const struct watchdog_info rti_wdt_info = {
>>>>  	.options = WDIOF_KEEPALIVEPING,
>>>>  	.identity = "K3 RTI Watchdog",
>>>> @@ -148,6 +198,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>  	struct watchdog_device *wdd;
>>>>  	struct rti_wdt_device *wdt;
>>>>  	struct clk *clk;
>>>> +	u32 last_ping = 0;
>>>>  
>>>>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>>>  	if (!wdt)
>>>> @@ -169,6 +220,14 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> +	/*
>>>> +	 * If watchdog is running at 32k clock, it is not accurate.
>>>> +	 * Adjust frequency down in this case so that we don't pet
>>>> +	 * the watchdog too often.
>>>> +	 */
>>>> +	if (wdt->freq < 32768)
>>>> +		wdt->freq = wdt->freq * 9 / 10;
>>>> +
>>>
>>> This seems broken: You are only adjusting the frequency value used by
>>> the driver. What has been programmed into the hardware already is still
>>> based on real frequency. Moreover, this path is not only taken when the
>>> watchdog is already running - but the latter case is what the subject
>>> and commit message suggests. I've noticed this by comparing
>>> bootloader-programmed values with those the driver assumes to see - 10%
>>> off, obviously.
>>>
>>> So, what is actually supposed to happen here?
> 
> 
> 
> This assumes that the clk is coming in from RC_OSC_32k - which is in the
> range of accuracy of 10-20% off clock. also one more variable to keep in
> mind is that the 32k divided clk from hfosc will not be exact.
> 

OK, so we do want a safety margin for min_hw_heartbeat_ms, make it
larger. But I still don't think it is best achieved by bending the
frequency. That will also affect other values, e.g. returning a wrong
programmed timeout to userspace if that was programmed earlier, using
the original frequency.

> Hari: Thoughts?
> 
>>>
>>> Jan
>>>
>>>>  	pm_runtime_enable(dev);
>>>>  	ret = pm_runtime_get_sync(dev);
>>>>  	if (ret) {
>>>> @@ -185,11 +244,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>  	wdd->min_timeout = 1;
>>>>  	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>>>>  		wdt->freq * 1000;
>>>> -	wdd->timeout = DEFAULT_HEARTBEAT;
>>>>  	wdd->parent = dev;
>>>>  
>>>> -	watchdog_init_timeout(wdd, heartbeat, dev);
>>>> -
>>>>  	watchdog_set_drvdata(wdd, wdt);
>>>>  	watchdog_set_nowayout(wdd, 1);
>>>>  	watchdog_set_restart_priority(wdd, 128);
>>>> @@ -201,12 +257,48 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>  		goto err_iomap;
>>>>  	}
>>>>  
>>>> +	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
>>>> +		u32 time_left_ms;
>>>> +		u64 heartbeat_ms;
>>>> +		u32 wsize;
>>>> +
>>>> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
>>>> +		time_left_ms = rti_wdt_get_timeleft_ms(wdd);
>>>> +		heartbeat_ms = readl(wdt->base + RTIDWDPRLD);
>>>> +		heartbeat_ms <<= WDT_PRELOAD_SHIFT;
>>>> +		heartbeat_ms *= 1000;
>>>> +		do_div(heartbeat_ms, wdt->freq);
>>>> +		if (heartbeat_ms != heartbeat * 1000)
>>>> +			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
>>>> +
>>>> +		heartbeat = heartbeat_ms;
>>>> +		heartbeat /= 1000;
>>>> +
>>>> +		wsize = readl(wdt->base + RTIWWDSIZECTRL);
>>>> +		ret = rti_wdt_setup_hw_hb(wdd, wsize);
>>>> +		if (ret) {
>>>> +			dev_err(dev, "bad window size.\n");
>>>> +			goto err_iomap;
>>>> +		}
>>>> +
>>>> +		last_ping = heartbeat_ms - time_left_ms;
>>>> +		if (time_left_ms > heartbeat_ms) {
>>>> +			dev_warn(dev, "time_left > heartbeat? Assuming last ping just before now.\n");
>>>> +			last_ping = 0;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	watchdog_init_timeout(wdd, heartbeat, dev);
>>>> +
>>>>  	ret = watchdog_register_device(wdd);
>>>>  	if (ret) {
>>>>  		dev_err(dev, "cannot register watchdog device\n");
>>>>  		goto err_iomap;
>>>>  	}
>>>>  
>>>> +	if (last_ping)
>>>> +		watchdog_set_last_hw_keepalive(wdd, last_ping);
>>>> +
>>>>  	return 0;
>>>>  
>>>>  err_iomap:
>>>
>>
>> There is actually more "inaccurate". For now, I would try to address it 
>> like this:
>>
>> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
>> index 88815419ad1a..1b6629fa5bfc 100644
>> --- a/drivers/watchdog/rti_wdt.c
>> +++ b/drivers/watchdog/rti_wdt.c
>> @@ -231,14 +231,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  	}
>>  
>> -	/*
>> -	 * If watchdog is running at 32k clock, it is not accurate.
>> -	 * Adjust frequency down in this case so that we don't pet
>> -	 * the watchdog too often.
>> -	 */
>> -	if (wdt->freq < 32768)
>> -		wdt->freq = wdt->freq * 9 / 10;
>> -
>>  	pm_runtime_enable(dev);
>>  	ret = pm_runtime_get_sync(dev);
>>  	if (ret) {
>> @@ -252,8 +244,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  	wdd->info = &rti_wdt_info;
>>  	wdd->ops = &rti_wdt_ops;
>>  	wdd->min_timeout = 1;
>> -	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>> -		wdt->freq * 1000;
>>  	wdd->parent = dev;
>>  
>>  	watchdog_set_drvdata(wdd, wdt);
>> @@ -280,7 +270,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  		if (heartbeat_ms != heartbeat * 1000)
>>  			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
>>  
>> -		heartbeat = heartbeat_ms;
>> +		heartbeat = heartbeat_ms + 500;
>>  		heartbeat /= 1000;
>>  
>>  		wsize = readl(wdt->base + RTIWWDSIZECTRL);
>> @@ -297,6 +287,17 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>  		}
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
>> +	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>> +		wdt->freq * 1000;
>> +
>>  	watchdog_init_timeout(wdd, heartbeat, dev);
>>  
>>  	ret = watchdog_register_device(wdd);
>>
>>
>> This moves the virtual frequency tweaking after reading back the 
>> programmed timeout. It also properly rounds that up to full seconds so 
>> that, e.g., bootloader-programmed programmed 60s will become 59s in the 
>> driver. That could have led to too short min_hw_heartbeat_ms.
>>
>> I can send this out as real patch, but I'd still like to understand the 
>> freq fiddling first. Is that addressing a real hardware issue? Or was it 
>> actually papering over that round-up problem?
>>
>> Jan
>>
>> -- 
>> Siemens AG, Technology
>> Competence Center Embedded Linux
> 

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
