Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E14BE4CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379817AbiBUQDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:03:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiBUQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:03:31 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3D415A0C;
        Mon, 21 Feb 2022 08:03:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbgjA8hsQBBooulqMurBgOYRL6hykBtsLtzwnCUD+fVz/mb+aaxKtUmGWzuY+mc9O6OWQq4BshWxKGH7E8DGiomDssn0CKA6R/2ZgH9OZy527cESteYUxIfZZ12gOVGviB3k+KxutsSlevjStLGc1RK361X4mtsw7gKNCMtx/IhuY9cR+mnqMVkLjRuJ1LzhTuzcfywTxxHfuMrv13rhmdv/IUEItCb4R9fo1F1gAiR7FhDcuYYp4zMkm/qkkZgl0m/ok/5vGYzsIU0pVDqJpponUKRD4agPgX5EyI6iteUBHzk2mPoNSB0+AYs0m+L4PPhTw4ExoP4EdhYpqmTyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MazBB7qOZU5QnEzPzIFHF8a/NDC9l2Cm5XqAZNv0vc=;
 b=Uef9M2o+20DG7D4K2X2+sJPkT5wPqj9jod40AKGYIAS26zPFHMBB5FBGeqK+3Qx+VhjvkgVlO6uK/PNCmgpB9GG2oavbCW39pjQBs8Yq6zEY8xWzSJz68BKkqeL0QbmvF+h7b8rHapXYnVKeubSQNILIFyJ2wkRaIKJy3oXfqIGTuWf7H9qZAP4ZkvWLGgjkAtNcqGECMDl732R5wbD94jS607eE4MiNfON5wZaKbA51IPj7dLzQqOQzJfteCeboVqwfi1151hsk8BjuPQv0u9mEIVTpW6e0/Ey4gfBOaoSgV7VXqLG6aHufFKuojhnEdpdCMcRjFirx/5PUgeVCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=ti.com smtp.mailfrom=siemens.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=siemens.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MazBB7qOZU5QnEzPzIFHF8a/NDC9l2Cm5XqAZNv0vc=;
 b=eP4y61N3xIT8WTZOd0HmomhKQHhqJ5RaTeSQFzBhMF0C7a66dHBD6W8rV4E8A8eASZt8VtxTUicDxyy0AQQN7ghYwuPme/lWMsFG+TI/ecUR2ZV/NSgvfFNhWXNik4k+KXGS9MwXiIcfPyxamQptuVOP8GTTs2pls3AokD1rHKQQthnvxiNCrp+grLutGPZaN259IdgfSd6mtqNzpmGivl+zfVKGM6wqeEQJmwNDSUepAmo++20k/5TMSctJ2EaGSSVRi83gINpvAGINhhwKdyW3juD1Um8P8mp5+zSPObBP09F2fUm02XbLwW35QLI7mUB14VhIaK47j/+1uT4Naw==
Received: from AS8PR04CA0058.eurprd04.prod.outlook.com (2603:10a6:20b:312::33)
 by VE1PR10MB3838.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 16:03:04 +0000
Received: from VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::fb) by AS8PR04CA0058.outlook.office365.com
 (2603:10a6:20b:312::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Mon, 21 Feb 2022 16:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT018.mail.protection.outlook.com (10.152.2.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 16:03:04 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 17:03:03 +0100
Received: from [139.22.139.231] (139.22.139.231) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Feb 2022 17:03:03 +0100
Message-ID: <dae15cec-5d05-a48d-8c3b-392559d8bfb7@siemens.com>
Date:   Mon, 21 Feb 2022 17:03:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 3/4] watchdog: rti-wdt: attach to running watchdog
 during probe
Content-Language: en-US
From:   Jan Kiszka <jan.kiszka@siemens.com>
To:     Nishanth Menon <nm@ti.com>, Hari Nagalla <hnagalla@ti.com>
CC:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200717132958.14304-1-t-kristo@ti.com>
 <20200717132958.14304-4-t-kristo@ti.com>
 <a80b83c6-cca5-f95c-6930-a6f3e79c6f15@siemens.com>
 <bdecc38d-2b1a-9605-0978-5ad1e8b39e6b@siemens.com>
 <20220221124405.o7vda3zaswi6ycrh@favored>
 <8a3f83be-172b-a0c8-d4ba-befa531e52f6@siemens.com>
In-Reply-To: <8a3f83be-172b-a0c8-d4ba-befa531e52f6@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.139.231]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709324f2-268a-4c58-9a31-08d9f553a4b0
X-MS-TrafficTypeDiagnostic: VE1PR10MB3838:EE_
X-Microsoft-Antispam-PRVS: <VE1PR10MB38385940EADF1F20EADF6DF2953A9@VE1PR10MB3838.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJgGwZ8PdIPA7JAxukIIzcAKEoRkVv9kM4h2OJMxcKvUuHhpCnfwFRF0A9P4BnIJCqw+tXaMvnZtBjJTWCU32IzZfHzsDx6aiMLDtl5dJrFKXxCvxEbfllUyV7Mjorlyi1zx8pilP7AppzKUH1GqjGoG4p3AtpoPKXZNpYbMcyAH5WBvsQz6jYtCgXU0m2h5T7TJjk8dbugOp5SejRLeJN3c9TcDJrXNtT+HgW7hAIUrvUoKn653eMWTP7q6ayHmaEsCynvaZKL3L4Xa8GqbKyThcgGMynfg0yupBcYh/pQjlI5UnA93Qy5H2BPs1Nuexqt6ZGCMExRYUb1XRR1IrPmiXExcwR8loHVua+1+ZXzHBI5jE2IkWZ//S+ZUfRYt0KuXSyqLyBWYfZlSIITBErPdbsC0LrPQmpbsi4Ya/UlhJ6Juuh+fJrFYxDiIPfW7rB2abHcgRZGtigD5vXVWTEZ5hGkl8ywNy0Se09piA7g6onHvRcvqs3H0DP7ma+PiH2jwkULfRA/huvn8Tp/ifKWxNbHnh/77t3lbTd+6eWcE0y5kIfWbvEdfNbBVCVZZ9o7WAGBa14JeK4iEOQjiN2RwLHidAgdIyBI8q008Y6P+GBYcDMWsyuX5sw06DyoDY/bWNlmrccOAqO+PgaXD+6rdbettuYxRXktl+Onuws/NWr3Nfze42TnbuRmNYBhDe2bNgP2aXYRA5LSsrh8GD+s2SvtpgNR5hyQmbiBEZYPArUXE89Y74vLCq4nISeHX2U6YmgIASu8cqoPJAHFiIA==
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(47076005)(508600001)(40460700003)(31686004)(36860700001)(2616005)(53546011)(956004)(2906002)(4326008)(30864003)(186003)(16526019)(5660300002)(110136005)(54906003)(6706004)(8936002)(26005)(316002)(44832011)(356005)(31696002)(82310400004)(16576012)(86362001)(336012)(82960400001)(81166007)(70206006)(83380400001)(70586007)(8676002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 16:03:04.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709324f2-268a-4c58-9a31-08d9f553a4b0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3838
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.22 13:53, Jan Kiszka wrote:
> On 21.02.22 13:44, Nishanth Menon wrote:
>> On 10:59-20220221, Jan Kiszka wrote:
>>> On 21.02.22 10:10, Jan Kiszka wrote:
>>>> On 17.07.20 15:29, Tero Kristo wrote:
>>>>> If the RTI watchdog is running already during probe, the driver must
>>>>> configure itself to match the HW. Window size and timeout is probed from
>>>>> hardware, and the last keepalive ping is adjusted to match it also.
>>>>>
>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>> ---
>>>>>  drivers/watchdog/rti_wdt.c | 112 +++++++++++++++++++++++++++++++++----
>>>>>  1 file changed, 102 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
>>>>> index d456dd72d99a..7cbdc178ffe8 100644
>>>>> --- a/drivers/watchdog/rti_wdt.c
>>>>> +++ b/drivers/watchdog/rti_wdt.c
>>>>> @@ -35,7 +35,11 @@
>>>>>  
>>>>>  #define RTIWWDRX_NMI	0xa
>>>>>  
>>>>> -#define RTIWWDSIZE_50P	0x50
>>>>> +#define RTIWWDSIZE_50P		0x50
>>>>> +#define RTIWWDSIZE_25P		0x500
>>>>> +#define RTIWWDSIZE_12P5		0x5000
>>>>> +#define RTIWWDSIZE_6P25		0x50000
>>>>> +#define RTIWWDSIZE_3P125	0x500000
>>>>>  
>>>>>  #define WDENABLE_KEY	0xa98559da
>>>>>  
>>>>> @@ -48,7 +52,7 @@
>>>>>  
>>>>>  #define DWDST			BIT(1)
>>>>>  
>>>>> -static int heartbeat;
>>>>> +static int heartbeat = DEFAULT_HEARTBEAT;
>>>>>  
>>>>>  /*
>>>>>   * struct to hold data for each WDT device
>>>>> @@ -79,11 +83,9 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>>>>>  	 * be petted during the open window; not too early or not too late.
>>>>>  	 * The HW configuration options only allow for the open window size
>>>>>  	 * to be 50% or less than that; we obviouly want to configure the open
>>>>> -	 * window as large as possible so we select the 50% option. To avoid
>>>>> -	 * any glitches, we accommodate 5% safety margin also, so we setup
>>>>> -	 * the min_hw_hearbeat at 55% of the timeout period.
>>>>> +	 * window as large as possible so we select the 50% option.
>>>>>  	 */
>>>>> -	wdd->min_hw_heartbeat_ms = 11 * wdd->timeout * 1000 / 20;
>>>>> +	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
>>>>>  
>>>>>  	/* Generate NMI when wdt expires */
>>>>>  	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
>>>>> @@ -110,7 +112,48 @@ static int rti_wdt_ping(struct watchdog_device *wdd)
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> -static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>>>>> +static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
>>>>> +{
>>>>> +	/*
>>>>> +	 * RTI only supports a windowed mode, where the watchdog can only
>>>>> +	 * be petted during the open window; not too early or not too late.
>>>>> +	 * The HW configuration options only allow for the open window size
>>>>> +	 * to be 50% or less than that.
>>>>> +	 */
>>>>> +	switch (wsize) {
>>>>> +	case RTIWWDSIZE_50P:
>>>>> +		/* 50% open window => 50% min heartbeat */
>>>>> +		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
>>>>> +		break;
>>>>> +
>>>>> +	case RTIWWDSIZE_25P:
>>>>> +		/* 25% open window => 75% min heartbeat */
>>>>> +		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
>>>>> +		break;
>>>>> +
>>>>> +	case RTIWWDSIZE_12P5:
>>>>> +		/* 12.5% open window => 87.5% min heartbeat */
>>>>> +		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
>>>>> +		break;
>>>>> +
>>>>> +	case RTIWWDSIZE_6P25:
>>>>> +		/* 6.5% open window => 93.5% min heartbeat */
>>>>> +		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
>>>>> +		break;
>>>>> +
>>>>> +	case RTIWWDSIZE_3P125:
>>>>> +		/* 3.125% open window => 96.9% min heartbeat */
>>>>> +		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
>>>>> +		break;
>>>>> +
>>>>> +	default:
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static unsigned int rti_wdt_get_timeleft_ms(struct watchdog_device *wdd)
>>>>>  {
>>>>>  	u64 timer_counter;
>>>>>  	u32 val;
>>>>> @@ -123,11 +166,18 @@ static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>>>>>  
>>>>>  	timer_counter = readl_relaxed(wdt->base + RTIDWDCNTR);
>>>>>  
>>>>> +	timer_counter *= 1000;
>>>>> +
>>>>>  	do_div(timer_counter, wdt->freq);
>>>>>  
>>>>>  	return timer_counter;
>>>>>  }
>>>>>  
>>>>> +static unsigned int rti_wdt_get_timeleft(struct watchdog_device *wdd)
>>>>> +{
>>>>> +	return rti_wdt_get_timeleft_ms(wdd) / 1000;
>>>>> +}
>>>>> +
>>>>>  static const struct watchdog_info rti_wdt_info = {
>>>>>  	.options = WDIOF_KEEPALIVEPING,
>>>>>  	.identity = "K3 RTI Watchdog",
>>>>> @@ -148,6 +198,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>>  	struct watchdog_device *wdd;
>>>>>  	struct rti_wdt_device *wdt;
>>>>>  	struct clk *clk;
>>>>> +	u32 last_ping = 0;
>>>>>  
>>>>>  	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>>>>>  	if (!wdt)
>>>>> @@ -169,6 +220,14 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>>  		return -EINVAL;
>>>>>  	}
>>>>>  
>>>>> +	/*
>>>>> +	 * If watchdog is running at 32k clock, it is not accurate.
>>>>> +	 * Adjust frequency down in this case so that we don't pet
>>>>> +	 * the watchdog too often.
>>>>> +	 */
>>>>> +	if (wdt->freq < 32768)
>>>>> +		wdt->freq = wdt->freq * 9 / 10;
>>>>> +
>>>>
>>>> This seems broken: You are only adjusting the frequency value used by
>>>> the driver. What has been programmed into the hardware already is still
>>>> based on real frequency. Moreover, this path is not only taken when the
>>>> watchdog is already running - but the latter case is what the subject
>>>> and commit message suggests. I've noticed this by comparing
>>>> bootloader-programmed values with those the driver assumes to see - 10%
>>>> off, obviously.
>>>>
>>>> So, what is actually supposed to happen here?
>>
>>
>>
>> This assumes that the clk is coming in from RC_OSC_32k - which is in the
>> range of accuracy of 10-20% off clock. also one more variable to keep in
>> mind is that the 32k divided clk from hfosc will not be exact.
>>
> 
> OK, so we do want a safety margin for min_hw_heartbeat_ms, make it
> larger. But I still don't think it is best achieved by bending the
> frequency. That will also affect other values, e.g. returning a wrong
> programmed timeout to userspace if that was programmed earlier, using
> the original frequency.
> 

I think I'm starting to get the original logic, and the result now works
here:

The clock driving the watchdog might be slower than thought, and then we
may time out later than intended - generally not an issue. But it may
also be faster, and then we will see an expiry earlier than what is
supposed to be configured via "heartbeat". For the latter case, we lower
the frequency virtually by 10%, crossing fingers that this is enough.

The problems are now:
 - U-Boot (as a known early watchdog starter) does not do that as well,
   and we will cause at least confusion on Linux side (60s will become
   66s from Linux POV e.g., and we may expire at 54s already)
    => U-Boot should add the same 10%, patch will be sent
 - even with U-Boot on the same page, the rounding issue will prevent
   accurate calculations of derived values, namely min_hw_heartbeat_ms.
    => patch to come
 - and ...

>> Hari: Thoughts?
>>
>>>>
>>>> Jan
>>>>
>>>>>  	pm_runtime_enable(dev);
>>>>>  	ret = pm_runtime_get_sync(dev);
>>>>>  	if (ret) {
>>>>> @@ -185,11 +244,8 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>>  	wdd->min_timeout = 1;
>>>>>  	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>>>>>  		wdt->freq * 1000;
>>>>> -	wdd->timeout = DEFAULT_HEARTBEAT;
>>>>>  	wdd->parent = dev;
>>>>>  
>>>>> -	watchdog_init_timeout(wdd, heartbeat, dev);
>>>>> -
>>>>>  	watchdog_set_drvdata(wdd, wdt);
>>>>>  	watchdog_set_nowayout(wdd, 1);
>>>>>  	watchdog_set_restart_priority(wdd, 128);
>>>>> @@ -201,12 +257,48 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>>>  		goto err_iomap;
>>>>>  	}
>>>>>  
>>>>> +	if (readl(wdt->base + RTIDWDCTRL) == WDENABLE_KEY) {
>>>>> +		u32 time_left_ms;
>>>>> +		u64 heartbeat_ms;
>>>>> +		u32 wsize;
>>>>> +
>>>>> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
>>>>> +		time_left_ms = rti_wdt_get_timeleft_ms(wdd);
>>>>> +		heartbeat_ms = readl(wdt->base + RTIDWDPRLD);
>>>>> +		heartbeat_ms <<= WDT_PRELOAD_SHIFT;
>>>>> +		heartbeat_ms *= 1000;
>>>>> +		do_div(heartbeat_ms, wdt->freq);
>>>>> +		if (heartbeat_ms != heartbeat * 1000)
>>>>> +			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");

...this comparison is not ok, leading to a practically impossible to
fulfill condition. Will fix that up while adding the round-up.

Jan

>>>>> +
>>>>> +		heartbeat = heartbeat_ms;
>>>>> +		heartbeat /= 1000;
>>>>> +
>>>>> +		wsize = readl(wdt->base + RTIWWDSIZECTRL);
>>>>> +		ret = rti_wdt_setup_hw_hb(wdd, wsize);
>>>>> +		if (ret) {
>>>>> +			dev_err(dev, "bad window size.\n");
>>>>> +			goto err_iomap;
>>>>> +		}
>>>>> +
>>>>> +		last_ping = heartbeat_ms - time_left_ms;
>>>>> +		if (time_left_ms > heartbeat_ms) {
>>>>> +			dev_warn(dev, "time_left > heartbeat? Assuming last ping just before now.\n");
>>>>> +			last_ping = 0;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	watchdog_init_timeout(wdd, heartbeat, dev);
>>>>> +
>>>>>  	ret = watchdog_register_device(wdd);
>>>>>  	if (ret) {
>>>>>  		dev_err(dev, "cannot register watchdog device\n");
>>>>>  		goto err_iomap;
>>>>>  	}
>>>>>  
>>>>> +	if (last_ping)
>>>>> +		watchdog_set_last_hw_keepalive(wdd, last_ping);
>>>>> +
>>>>>  	return 0;
>>>>>  
>>>>>  err_iomap:
>>>>
>>>
>>> There is actually more "inaccurate". For now, I would try to address it 
>>> like this:
>>>
>>> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
>>> index 88815419ad1a..1b6629fa5bfc 100644
>>> --- a/drivers/watchdog/rti_wdt.c
>>> +++ b/drivers/watchdog/rti_wdt.c
>>> @@ -231,14 +231,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	/*
>>> -	 * If watchdog is running at 32k clock, it is not accurate.
>>> -	 * Adjust frequency down in this case so that we don't pet
>>> -	 * the watchdog too often.
>>> -	 */
>>> -	if (wdt->freq < 32768)
>>> -		wdt->freq = wdt->freq * 9 / 10;
>>> -
>>>  	pm_runtime_enable(dev);
>>>  	ret = pm_runtime_get_sync(dev);
>>>  	if (ret) {
>>> @@ -252,8 +244,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>  	wdd->info = &rti_wdt_info;
>>>  	wdd->ops = &rti_wdt_ops;
>>>  	wdd->min_timeout = 1;
>>> -	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>>> -		wdt->freq * 1000;
>>>  	wdd->parent = dev;
>>>  
>>>  	watchdog_set_drvdata(wdd, wdt);
>>> @@ -280,7 +270,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>  		if (heartbeat_ms != heartbeat * 1000)
>>>  			dev_warn(dev, "watchdog already running, ignoring heartbeat config!\n");
>>>  
>>> -		heartbeat = heartbeat_ms;
>>> +		heartbeat = heartbeat_ms + 500;
>>>  		heartbeat /= 1000;
>>>  
>>>  		wsize = readl(wdt->base + RTIWWDSIZECTRL);
>>> @@ -297,6 +287,17 @@ static int rti_wdt_probe(struct platform_device *pdev)
>>>  		}
>>>  	}
>>>  
>>> +	/*
>>> +	 * If watchdog is running at 32k clock, it is not accurate.
>>> +	 * Adjust frequency down in this case so that we don't pet
>>> +	 * the watchdog too often.
>>> +	 */
>>> +	if (wdt->freq < 32768)
>>> +		wdt->freq = wdt->freq * 9 / 10;
>>> +
>>> +	wdd->max_hw_heartbeat_ms = (WDT_PRELOAD_MAX << WDT_PRELOAD_SHIFT) /
>>> +		wdt->freq * 1000;
>>> +
>>>  	watchdog_init_timeout(wdd, heartbeat, dev);
>>>  
>>>  	ret = watchdog_register_device(wdd);
>>>
>>>
>>> This moves the virtual frequency tweaking after reading back the 
>>> programmed timeout. It also properly rounds that up to full seconds so 
>>> that, e.g., bootloader-programmed programmed 60s will become 59s in the 
>>> driver. That could have led to too short min_hw_heartbeat_ms.
>>>
>>> I can send this out as real patch, but I'd still like to understand the 
>>> freq fiddling first. Is that addressing a real hardware issue? Or was it 
>>> actually papering over that round-up problem?
>>>
>>> Jan
>>>
>>> -- 
>>> Siemens AG, Technology
>>> Competence Center Embedded Linux
>>
> 
> Jan
> 

-- 
Siemens AG, Technology
Competence Center Embedded Linux
