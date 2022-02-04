Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069AB4A9C9B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376332AbiBDQAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:00:34 -0500
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:56428
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233618AbiBDQAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:00:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7uU6ijw4H3IsRbCjxHDAmGVZgVDqfpHBgpw2v2KbRWkf36aZW7fmRaoxtSftW7eo4cxjIL461zzv3hJiexhTHKjq9QQM/JgyCQFwsNIRuGPBCHTrDr4nNMvVlO4QBdmIxAIFrYNCmTZ79UR6QlmpP2eANFq3O68VaPz0aHvz7IEuRN+C4zdL9HDjn+TAcO5h0iEBOxfnq/YvX1qpxWZ3axkmnrt8Gl90OJd04TgfucqCKr6xjbmVOnys9JKqEsJLp0h2dI7v6ueMzllAQ+2KQNQ1NBU7Ih+UCWJxOPO80brNMr+E/b4Clctq7SrU+l6wYWqSev+4/tPlRrM8agMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzP8zTEzyG0PGjPlWtLeQB4Kkoa0RLKliBdkfbZbA9g=;
 b=nMRGxsxfls0t9ttvSDm8a8ZjgDqvPIGXOxFOjgoWCoBegM0ETQeXREI9MxCxYqoKdhU2HlQj3uGkh3eb1aSSzmwlzjLwMjU+TZ9XAxxd/Geu/IhdBN3NlC+LVKZZMqCX5kRlojWdqNTP6jH4CW3Qq/EI1Db/PMuE7DEB7uj9hCcyevj02LISmMYcBh8qpEVxc+5NzrIRIcYL6Bq/YLiCRHQQpXI9ozuT04tYe/5UZP5zNiu9qj3ojPKCdniDam+qZ6t/HkvWQPIosdsS5EJ2dEBVSi18e2cCN/uNYOkwXd6CtASPgNZYEf5WRuDt6OtGI45gyZD7g0C4YokPDVmwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzP8zTEzyG0PGjPlWtLeQB4Kkoa0RLKliBdkfbZbA9g=;
 b=VSd6zh9CDcRNcAsnr+uH0Ytnu9VxPAM4Kq3hI6OtaiAjFOvTlIOwuBxxwe06yQi5uM6HBeW1hskwxoY3cnycRM6ik01JL5SxNNA/k44UdwqCxM/ZbkuzhhKq2rjE1n4LhjXSY6KnB/SA1Y/MudDd/JnnPhPTLupQBRA6iEwgz9m/ovJfca42AsRKEtiWL9vxfAXzLcfuWwJtImKEIfQmok6EgQD7MFGw3VFZEmqhyjauf1rA57PKdJxPm1ak55fxurRw+/4oIp1r4BDOF6RzDW+fix/bMsofqLRoLV4WvhYILHkSWutW1b4ye16F+Z8MLgSqpxPlGtiHQ/97aeoEUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AS8PR03MB6711.eurprd03.prod.outlook.com (2603:10a6:20b:297::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 16:00:30 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 16:00:30 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v3 5/7] usb: dwc3: Add snps,ref-clock-frequency-hz
 property for ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>
References: <20220127200636.1456175-1-sean.anderson@seco.com>
 <20220127200636.1456175-6-sean.anderson@seco.com>
 <CAHp75Vc--RYW7P0wLA8Jcr53xKSkphJV=wTeZiPC-AYu4sGYFA@mail.gmail.com>
Message-ID: <2c1832a5-1e13-1423-2be8-e31b5ec5195a@seco.com>
Date:   Fri, 4 Feb 2022 11:00:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAHp75Vc--RYW7P0wLA8Jcr53xKSkphJV=wTeZiPC-AYu4sGYFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:208:e8::47) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e065d057-4c2f-48ff-90ee-08d9e7f777c8
X-MS-TrafficTypeDiagnostic: AS8PR03MB6711:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB6711A443A55CF8126230488196299@AS8PR03MB6711.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mluVN/nFOfRoxNf/hEHcsmtKm+qR9vekuQcekFfxV+NW0VC/b2QSIWwa8JlEFCYR+59zuCLdT80ykq5BuKedbMOGuFvz3NcH9sJqg0AvarJi1+vAaXsFaEZafYWLnWTYFKb95zYzqiINcjfZJFr6pOAbL4QCbFeYGl9SujXXAs4p4JRaIQaCWdut30Aw1xgvNoCbl/NRdc5DRkG3c5318JIPy86bHSholxep51e7ywfnaEkjR3p96vFkh9dEkBPcuLa4njknHxy2bKwJh37bZgozAsT2mVNIclNJQe4vgIxCtNWEyN81ck4E+1JSQ9uDYxDJnG4xVJsfwvco7DtR9gz3sjuoimZDuNN7H+ZugcbLs7INxpbr4m5cztGrSH+kKRZ3ZHsesZNLnBcVGmI8YHuy4k2gtLjyJ+75/4x44ZJ3ZQKZ+VO0tL+fNqSU+8xQEPLyIiRysnAsCf4F5jHeMO1NsjO5lnSN9722UooWtls0pdPeabunnLqOgjm1iblHKpqHT76DgadzLX5+V+0nts8DGiau+iGwK35evoaaUBupgXVSDIEcQMG7gZwM0WWEXaOnKmDYdt1M7EjwbJuE7yrzmEZWILpoRV1drehY6jFxnLizG5AED8OF+a6RUV0I3QFDOzz4JXwDlQi2XTkJQiiKMownoIgBx5jUfofkvO44QHoAKwkfbuGVWzfxLPGbi0qasYM6ubGH4b72n8EC/3bGrTnDM3AxoN3aKz2JpCN4YN3nG+wlvyK47AtIZokaQGmRGYRmp1XabQZAL8NY+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(8936002)(31696002)(44832011)(66556008)(8676002)(66476007)(66946007)(6916009)(6506007)(36756003)(6512007)(4326008)(31686004)(83380400001)(6486002)(5660300002)(53546011)(52116002)(2616005)(316002)(86362001)(2906002)(508600001)(38350700002)(26005)(38100700002)(186003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnM0SnNkcDR5Yk1YK0I1NTF4WTM5RURKRTBUc0svdGJnMG9pS1h5aGNKRy9O?=
 =?utf-8?B?TnJ0KzV1VmlzUnFJMFprWStTY2VNRmhuTEk2cHZWa2NqYlJDYWpBOEFYMkRm?=
 =?utf-8?B?elZCTFhsYzI0WnpEMmFyRk1YMzRkVkkvTHNOTHdxZ1BPaEIyblRKN2s0Rmxt?=
 =?utf-8?B?cHN0NGVGK3pJRTFKdmp5V25vay9mSk96QldjTDRyOGIzTlpTbVg1VUtzaGI1?=
 =?utf-8?B?aWV0TDBNajJGd2JtNWdFR1J5OWp2NjNIYlcrNU5ISHFWd1JVMDJZendaenN6?=
 =?utf-8?B?NE5nN1ZLcWRYMDlSSklZTU85eU9idVZqcnFUcnkvSXJMNW5XaGZXT0F4K3lG?=
 =?utf-8?B?eWdTdi9BblNiS2hRczd1cCtlaW81Y2o3S3MxQ0lQeExuckNnYlBXaGFraC93?=
 =?utf-8?B?RmxWWlhpcm1HcmxTMGpCR1pmUGNyOWRtVVR0bFd3cHk2S2VTK0lMWVVndXpw?=
 =?utf-8?B?T0hRdmJtRVBvdzBtcGd4RzcwVTBFalRRYlRQd2pDc1llQ3BHZnNPM0pLbXJn?=
 =?utf-8?B?c3l5Z2ZyMWxNbzhQNjBMQUlMckpTOVpidFdNYlFaaFN0Y01JdVpUQTJDVnIr?=
 =?utf-8?B?L0g2K1ZvTndDYk5paER3Umh5Rm15NE9GeEZvUEM2MFV4anpyd2tIQkl6Mlcw?=
 =?utf-8?B?Y0RQTnhzUWVDYjBLeS9ZMXNleTc5RTdKR1AyejA2MERHbnhkTkhYcXpveDFW?=
 =?utf-8?B?SFdOdnNWVWlHVzZQNWpUdVM3Um5OWE5ydG5nZ3VreEdhNXBhVXdldXdQQTQw?=
 =?utf-8?B?eWhxUGhBYVZqbHdXV3NBQkoySjVUVmhWT0ZUQ2xhY2IrMVJLK05vYW1iZ3d1?=
 =?utf-8?B?S2tWalRUVkx0cVBKejEvT3dOSFdGUHZBcEZldlhaTUludmJYdmVlK0JSaTJT?=
 =?utf-8?B?d3kyclA1Y3lhYlI4WHpidnlOdlpZY2dGUGtoeHFXdWZsSkFTM1dscldXQ0lL?=
 =?utf-8?B?RUxsUUpud0piMktTeTdTRjg2eWR0RW5Wc1RlOGFWajBxanU0dHp0UVB5L3lG?=
 =?utf-8?B?SWhxZG5tUXlQcXhjdE5YTVRKeTJ0N2JzVjBRY0lzR1k0RmVrS0ZSWXQyVUY4?=
 =?utf-8?B?bUJoTWdBYm1SYWRiMnpsOVhqS3pWSTgwNVJnR0xJWksxUDRKd2tYYkFzbkh3?=
 =?utf-8?B?Zm1zSUd1RW9kNzJ1R1pyUjA2RXl6TjU4WUZ1QzdVZ0l5bHlEMGFVNEd0MVZP?=
 =?utf-8?B?S1o1ckU3cTlPTTNXTDJhQkFNZks0Z2hjcEZqYllEUENCQlM5Znp0UkZ0czha?=
 =?utf-8?B?RFBGeVN4K1VKT1NkSXpNU0M5VWc0RzBzMnppNVJGVXNiU2dEUmVvNUMyTUhN?=
 =?utf-8?B?MXloUjVFMDlsYktIcUw2dmxnNlBXT2ZxZjJaczIySWY0WWRMUXY1RnE3SzMz?=
 =?utf-8?B?SGl1emVBZVZ3TytJKzQ1TGZUNE9ZRTlWTzJUN3pxbHU5NkxhK0pGS1VYYVVs?=
 =?utf-8?B?ZVNkVU1RUWhiREx1MjB6eG5oWnpGNENPM3dzMEp5MmRBREppdEg0SnJsTFBK?=
 =?utf-8?B?U3hycEtvRUp6TVVLaVJKWU9oSkNxY0tiY0gvTVdNSjZJT1I5N0pyNXlPajZo?=
 =?utf-8?B?VzRGeVlXMWk1UytPODQ3WWVHK0w5bHNZbDdsbDRMUkxwMzJPQUxPdzQrU2Zp?=
 =?utf-8?B?TmE5ejlQMWEwU2RZT3lvaDVWSStYc2NocVpOK1R3SXlxWStyRUFoazl1aHdx?=
 =?utf-8?B?UFpBRmhSVzZVV1JjTFhVdExUaWZJckFUalh1eEZqTTVsSFJyeUh0UENCY0p1?=
 =?utf-8?B?Ykd2N1dudWpxLzkrczlvL1YyWUNaMkdIckpValhwSkVFSTlBaFNGUXlGRTFn?=
 =?utf-8?B?OHZ5V2N0MlVUbjFMMUg0QjRBV0ZCT1NCQ3h4SHB3VnNPSDB1SVIxQzU2Unh3?=
 =?utf-8?B?R09PSWgrM2p2MG5jOEsvY1hsSnZNUWpCTEZyM3JVVXZFVWpDVUFWR1pGdTI2?=
 =?utf-8?B?Nmc3Y1IxOVhYTTNpbjlGZkYrcU83ZU1tcERZYWVPWkkwcEt1UHhiVjBNY2M0?=
 =?utf-8?B?dm5jSFdyUVdlODh5b0FlZEI3UHdTK2dNdWtqbm9MMTNDUk9pNGNkeUtnTHQy?=
 =?utf-8?B?SW5pYlp3Wnc1eEIwSUpPUFhJZ0pkOG9NYVhrU0tFY1p6b0RoNzFJQTI5K0th?=
 =?utf-8?B?czMyOGRBZWMvdXZWa3M2eU9xQVY5SHlUK3VpR1RtOGRuUHpJbWorMExCekVj?=
 =?utf-8?Q?a4S7k5mYRbHnV327HHOKnFw=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e065d057-4c2f-48ff-90ee-08d9e7f777c8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 16:00:30.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AoJVeH7skftdT3t/ymimlPGPbAOCvk3YWdR9sf1smY9Cg9qjENVuaWLxJRojzFhlcv7afWALLYKUDXG+GX9rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6711
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2/4/22 7:54 AM, Andy Shevchenko wrote:
> 
> 
> On Thursday, January 27, 2022, Sean Anderson <sean.anderson@seco.com <mailto:sean.anderson@seco.com>> wrote:
> 
>     This property allows setting the reference clock frequency properly for
>     ACPI-based systems. It is not documented under dt-bindings, since it is
>     not intended for use on DT-based systems. DT-based systems should use
>     the clocks property instead.
> 
>     Frequency is preferred over period since it has greater precision when
>     used in 
> 
> Is it function or interface clock? 
> 
> We have standard property for the functional clock rate, I.e. “clock-frequency” (in Hz), can it be used here?

I believe this is a "functional" clock. It it is a reference for the USB
signals. I'm not sure exactly what the purpose of this clock is, since I
do not have access to the databook for this IP. I considered using
"clock-frequency", but I am concerned about ambiguity because there is a
second "suspend" clock which is also a "functional" clock. The latter
clock appears to be used when the PHY is shut down (and not necessarily
corresponding to Linux's notion of a suspended device). If it is
necessary in the future to configure that clock on ACPI platforms (e.g.
to set GCTL.PWRDNSCALE) I think it is clear what the property name would
be (snps,susp-clock-frequency-hz).

--Sean

>     Signed-off-by: Sean Anderson <sean.anderson@seco.com <mailto:sean.anderson@seco.com>>
>     ---
> 
>     (no changes since v2)
> 
>     Changes in v2:
>     - New
> 
>      drivers/usb/dwc3/core.c | 6 ++++--
>      drivers/usb/dwc3/core.h | 4 +++-
>      2 files changed, 7 insertions(+), 3 deletions(-)
> 
>     diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>     index 18adddfba3da..c1b045121672 100644
>     --- a/drivers/usb/dwc3/core.c
>     +++ b/drivers/usb/dwc3/core.c
>     @@ -353,8 +353,8 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
>             unsigned long rate;
>             u32 reg;
> 
>     -       if (dwc->ref_clk) {
>     -               rate = clk_get_rate(dwc->ref_clk);
>     +       if (dwc->ref_clk || dwc->ref_clk_freq) {
>     +               rate = clk_get_rate(dwc->ref_clk) ?: dwc->ref_clk_freq;
>                     if (!rate)
>                             return;
>                     period = NSEC_PER_SEC / rate;
>     @@ -1497,6 +1497,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>                                      &dwc->fladj);
>             device_property_read_u32(dev, "snps,ref-clock-period-ns",
>                                      &dwc->ref_clk_per);
>     +       device_property_read_u32(dev, "snps,ref-clock-frequency-hz",
>     +                                &dwc->ref_clk_freq);
> 
>             dwc->dis_metastability_quirk = device_property_read_bool(dev,
>                                     "snps,dis_metastability_quirk");
>     diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>     index eb9c1efced05..00a792459fec 100644
>     --- a/drivers/usb/dwc3/core.h
>     +++ b/drivers/usb/dwc3/core.h
>     @@ -988,7 +988,8 @@ struct dwc3_scratchpad_array {
>       * @regs: base address for our registers
>       * @regs_size: address space size
>       * @fladj: frame length adjustment
>     - * @ref_clk_per: reference clock period configuration
>     + * @ref_clk_per: reference clock period; deprecated in favor of @ref_clk_freq
>     + * @ref_clk_freq: reference clock frequency to use if @ref_clk is missing
>       * @irq_gadget: peripheral controller's IRQ number
>       * @otg_irq: IRQ number for OTG IRQs
>       * @current_otg_role: current role of operation while using the OTG block
>     @@ -1171,6 +1172,7 @@ struct dwc3 {
> 
>             u32                     fladj;
>             u32                     ref_clk_per;
>     +       u32                     ref_clk_freq;
>             u32                     irq_gadget;
>             u32                     otg_irq;
>             u32                     current_otg_role;
>     -- 
>     2.25.1
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
