Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB075730D0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiGMIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiGMIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:20:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083EEF78B9;
        Wed, 13 Jul 2022 01:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOkI88kRGBP9ayfY8iHx3jO92Rj13garfDi7ZBqpO2tpBheJvKPdvn7ZlMgsYB/fOjZCnXCoJgXF7919gVTIE7cXMWcGPrtDurZNv8rkE8i42/JWnt8vbRLzeMfOxASS5czu10PrgogvnIJBizpjEB2rliGU+P5gK8jjfAFjrHwT3n6ujLu8AwYgj4tZ2RxaF9ZtjGpSO5e7AkR41USMAOIR9B4n6l8ipv2x9xsNymvGiyZH9aClf8UZUqKTivtDGCd7FGDR8u3Eurq3Ku3oUyN7VzyFVUWuUCdgZNDs6RpabfiEKh7Zkm3R6Rqv/Lg8zr/7vKqp6q6iK88lFI8dHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puKU+HCVNdJsPRUgZb1jhx54TrxGdsjADfDst6ne/lM=;
 b=hVKBMmZF/R5rGtkxOsALku8Oso4gQwKtNkLpoEwag3TYHJw0eC6lvgB7dt0KFTTEdg+UyvZMqgAbhnKDaXJZqOd8+ZdaMQaubVx64fej9i/t0cktlrr8P2DPJOtCpHnQW1YQ2Tc2sYXE2+BHMnDBO2NtzsgM8OOSkw/gYj9wQJXJum8vDEDn+3WLTXWOcRPOt1RvJM8XeWuuBP/SeY28EiKSdSE6H1blq6aA5j02jnUZLk7HEfR0huhrlhZxr2DvgmlvLcDluZvQpktx81c9ceVAim+K2TCykt9F0KxvolKQHmkWTZPoKXkelxttltkV1puCTgTqYpM+oowMs8SmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puKU+HCVNdJsPRUgZb1jhx54TrxGdsjADfDst6ne/lM=;
 b=f/HF/zphoUgKtmiP4fzsrcAQH5SJ64nukqdfOWMkWaeVv9mN1LoS6czHT90o5fg6iG5Eg7i4JC4TTdB1AfbRPyJWfqEqwlujEdJaQjPXNzIbM1eHKwKhW2a/2uuWPJMcJ2hrKZRwJCFkFyrDcJh6rAy6Mp8bgEf1NVNCmGYdhSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM7PR10MB3255.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 08:16:01 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35e3:b154:10cd:4ebd]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::35e3:b154:10cd:4ebd%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 08:16:01 +0000
Message-ID: <02a9b4ca-baf8-9f06-12be-57853893fb50@kontron.de>
Date:   Wed, 13 Jul 2022 10:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/6] arm64: dts: imx8mm-kontron: Use upper case PMIC
 regulator names
Content-Language: en-US
To:     Heiko Thiery <heiko.thiery@gmail.com>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220713074118.14733-1-frieder@fris.de>
 <20220713074118.14733-5-frieder@fris.de>
 <CAEyMn7a7S6UZOTsubM3pY95diY0oR0WNvhQpTUSmedjG59Qn9g@mail.gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAEyMn7a7S6UZOTsubM3pY95diY0oR0WNvhQpTUSmedjG59Qn9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12602f7b-3aa2-4a9b-ef93-08da64a7ebe2
X-MS-TrafficTypeDiagnostic: AM7PR10MB3255:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmHzltu2Mu60+A8HrdOWyOmYN6dUjO13HxNZgljUrGB6zqgiNyku5wflhGxUywrrrRlmFZruJSaih9OtqC4vEt39qJSSTAfS7zdbJpEY/TWzxy40VaqF3fOQXP6hrl4BBBzFcaph8GeBo+5bfHkoJTm7FA0okzXjSTJ94l8wTvO2XiUDU+7CpJBUooddqDc4nNaKyfVQjec4PleaF4tcnylLHptx7sK44YiknsXaNvo5Bgf56BqDomUjmieblQ15bGmhF82+Z/fwAwPV3+22Ms3bD77xPj8ku/ncSHvHG/l05VsWf7+sxdYDB+r6EKiF7Wn7iUGRjYVndMHFcsEbjsrlDO842bJXKVhsK3ZBp4s7Y7ykHEX8V+AzWqdyt6llp0XhtRhL+Pt4hu2yHRNANQCt+QtGs4SCfd1sfr+9Itl9SXN5OKJqn47jyeXHWGUY3GKnlPLebveddpTRtlS+Rrejnhq30kjYuX3mEz3LUJ90nUkD/D7INwXpHMNzAV14A6YHRMCxS4u7TS176W9ziLHyjnpKCP1Ol996BWUWookJ3YpW+OCu/RoyI/+GKys8hiPvMggsPj8bQpPsSU/eh6I9UhonxMe1eeOTE0OJKaY+pM6RXcNYM+eR1LboOKBostNEwrxnVsPPco2Vks7NAvxSennbUDyJu8h3azE6p88tNxQZVySih8dVmQOZ2nga6Trp8F8C3eKwwotP9i8fOW0vkMsg+0ouk96lu0WdrxdVnKuh0cvwDMoVqZCmV4BxFusddokS73Kvg+sh1wjceA4npmf2UyzlHSbxizb+0deP56yzk86K2E+rgFTWDBffPNa9xSzr8JPUMM31OWd5uF03nR6KhpWGuzqjFjhHClQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(38100700002)(4326008)(31686004)(66556008)(66946007)(36756003)(66476007)(54906003)(316002)(110136005)(8676002)(2616005)(44832011)(86362001)(8936002)(5660300002)(31696002)(41300700001)(2906002)(186003)(6486002)(7416002)(6506007)(6666004)(83380400001)(478600001)(6512007)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhRMHgrd09ZTmMySGdVWkhNVVNDd1ZjTG5Pc2xxejJLMkVwS3M1TEpJbmE3?=
 =?utf-8?B?SjZJV3VBQTNCT0lRVzk4V29GYWZrYlBsUUVQZmdmazRVeFZWd0w1c1dLT1R0?=
 =?utf-8?B?ZnBoWUkzSDZHemcrOUJNV2JJSnNKbk9VWHIzeGtxM0FUQm5GcHJlNktUU2F3?=
 =?utf-8?B?ZWZtejdxSWV1ZWtoQUtHOHdQams3Q2hmTFMwbzRxRGtUbFpVcmpxT20rc2du?=
 =?utf-8?B?QmxnckR4VFkxYlJJdXRIems1djFndXhWTWhKSWg4MVV2Um9wdUxzMG12c1pE?=
 =?utf-8?B?K1FHUUt0VldUU1JSSUU0VW9sZkVudEUvMHg5Ly8rUjVkMUgrbzdVQnkrRVdv?=
 =?utf-8?B?ZWdLWDhEYm5mSE96Q3hBcndKVUVnK0d4c1hsOXZyaFZwVnFjMjRHTmpKVmY4?=
 =?utf-8?B?VVloTXNIbUxxelMxR2xHZXBwZXE3NmJ1T3lQNHBBNFlQSmdOLzhUSHFSdUIv?=
 =?utf-8?B?V3hiY2xjOVY2TE5Pd1FMaUtvOTFBMjNWT05XWjFtblRzaXJ6bkhZcHl3eDVG?=
 =?utf-8?B?QzVGbmJSeGpYVU02a21vTlltd2F2RXpwRitMMWZUMjByWDBPY0lzSDg0Ynps?=
 =?utf-8?B?N0IzWEdVdDIzeFB0ajZ3QTRsdFZKZVZCT3ZyZU84OEdXWnJqcnB2L3V4aGlh?=
 =?utf-8?B?MzVHOGpNMWEvR3FtMlV2b1UyYzN5RmpEazZpb3BkZGxvb0o0UGVsd0dZbFV5?=
 =?utf-8?B?a0JEbzJHNjExMm0vVkhTV1NzUm55ZXhaK2g5MWZZUFpMaE9idDhiMzBOcTRs?=
 =?utf-8?B?eENmWUtqdnBXckgwVFQra3JhSlVuNUdtUmx4VHB0azBjT0FlT1NkTElhaHpZ?=
 =?utf-8?B?VXo3amJMYk9PbldmQUt3bDBZNFEwZjNYaHJpN3hzNHg4QVRoMWZHMThSZW5u?=
 =?utf-8?B?K3VIWW03REpsSjNkUFRmNW1rM1ZkR2ZnQnNLdmRWdy8xMXFZYWhIVTE1YVFo?=
 =?utf-8?B?UXFpK0FRbnRoSVljZDJ3dytMOFZITXdsakhWUmF4RVllZW40eUE4SC9kUFJU?=
 =?utf-8?B?OXBHVjlKUVdqYWpGeDA1dnViU1BFOG5sZkVBN3hCVmZXN3BsaE53ZnFsS0Ni?=
 =?utf-8?B?NmxzUXZxNVJDdjRMdWhYVkJPSTc0NkpCOEZvQkZHcUp5Y1REUlZubk5vc1BT?=
 =?utf-8?B?K3VhNDhMendYQWcyTVFoRkdXblZON1c5Y1Q3NVpXaFBsUDUrOHQwUUhiVHZj?=
 =?utf-8?B?WHRwbzAvaWRLeEhLazFXWGNwcXJ3OUVxQmFhbktJYWRrcFBPbGVHbHBReW9n?=
 =?utf-8?B?Z1FOdVpqcTB3d1Vlc2ZvK2tmUjZKbURRVllwMERYdzdOQlU5ZTdQOGdhZ3lU?=
 =?utf-8?B?RkJDa0tVa08wQkFDMkpJOXZYTlBFOFZYWkpKSzQwWk9MT3dPWnZzS2xxNkRn?=
 =?utf-8?B?RXhVaEV2ZDVoR0hMeFVSc0hmNjExYm5JYkJETEloaCtCRHg1WHlvQXBCMUsv?=
 =?utf-8?B?eUlOeWRZWVNXSXh3R0k4aXE3R0ZOeERlazl2UFRheExwQ0cyQ0t2VXRPOFF0?=
 =?utf-8?B?MmIzWmVKQmhQUExReG42cU4xNWlKWkU2eFlRalVHOUc3b0tYc0R2QkJIWVNU?=
 =?utf-8?B?TG4vOGIrZmpoR1lpSmpFbEhXL1EvMWJtbWtCNzZQbnQ2ZmxvbDFjeGJNbllI?=
 =?utf-8?B?Y2NLQ092b1ZreGVaTHNXQW4zc01VK1ZQMFNpbTJiV3dJVWtnNEs3NHRXVXc4?=
 =?utf-8?B?MTNwKzhzTjZSL0xRZmN3SjlVbGhvNWRuTitaMzlvYklKZzlrdFhhc1BLNENx?=
 =?utf-8?B?bXlxcXNkaHlaUXlDRDRQcllzeVBsY1V4TkVzOGMzYmFMN3RMbmhUUWlaR1U0?=
 =?utf-8?B?UDBYKzJQU3JKQjVtK2cvTExXN1E4b1Y1NkxJVHgxcWhTQlNTclZrR0hNei9K?=
 =?utf-8?B?cWtVRmFKT256dFBta3ZrdnVTa1pWVVpaaVczVFEvbTVibGJyYlhOZ2VwN0Y2?=
 =?utf-8?B?TGo0TFJ6cHozaUpwTkVYdVpVeEZVZ093MkFXNDJpM3RtNldhSkcyczR3cFdo?=
 =?utf-8?B?MVhweEszQmdjU2FzdVZraHhQQ3dKRWFLZEt2Y21ZR3hzbjFONU9rbUlWdFFU?=
 =?utf-8?B?VnZSVXppc3pRWFFDdjJ3NStNTDU1dG0yaXYwOERZSTZGekUwVDF4aHVvaEVa?=
 =?utf-8?B?dDNMUHBLUm5lUGdLSnd5Z1NFdEJDbTRtdWhRYjNnMmVGQXRvNjY2YzA5ZGlI?=
 =?utf-8?Q?qLtVN3EaGkdBFqjonTcNBuESAhZu/0iUANJANHyBrnK9?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 12602f7b-3aa2-4a9b-ef93-08da64a7ebe2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 08:16:01.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QlKzSKgFHE6kXSBjdZTLcSMLA+gRRo9M2/ITXHM9tb70HEYVZ0qliVULc317yiID0OgbSIIjK8c5k9fxpa5WxJcnV4DXdQ6JRWoOj/kA0Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3255
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.07.22 um 09:52 schrieb Heiko Thiery:
> Hi Frieder,
> 
> Am Mi., 13. Juli 2022 um 09:41 Uhr schrieb Frieder Schrempf <frieder@fris.de>:
>>
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Use upper case PMIC regulator names to comply with the bindings.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  .../freescale/imx8mm-kontron-n801x-som.dtsi   | 22 +++++++++----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> index 2d0661cce89b..2e3d51bbf92e 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>> @@ -85,7 +85,7 @@ pca9450: pmic@25 {
>>
>>                 regulators {
>>                         reg_vdd_soc: BUCK1 {
>> -                               regulator-name = "buck1";
>> +                               regulator-name = "BUCK1";
> 
> Wouldn't it be better to use the real signal or voltage rail names
> used in the schematics?

Sounds like a good idea, thanks! I will try to include in the next
version of this patchset.
