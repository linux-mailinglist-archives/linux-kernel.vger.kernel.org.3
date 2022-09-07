Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D95AFB83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIGFES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIGFEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:04:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E11B9C1D5;
        Tue,  6 Sep 2022 22:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJQu1zxp0X33ODnNQ5zFAlx65CWfMQ/wdERDBQXFi/1SGncfBRJjcKM6JPo4IsVbYubsGBb70BOUeJVwhtkf+jahM0CZMflhy23zqM18mZIVCWVR++hjikhYDY2MuIlVK9b39LtDsfYQUaFlyd7H7qZnUj+r9FsUpyFytbzIVIelgZz+y+r5rVmgQAobi+ppf1xF/IPXpQaemFsjCCAWSKKXBZamKkOj3+RRo26ykPTlZIAi8gpmDnCyLrJ+14TMyXG32xbCdXGVI2S3K6ULBE1m3XknZAfii9CMUfbZwIw6I796vLUeuQlig6+/V1Ulaue62BC2LDt7g4MYP2Nn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5Ew8V0B9jrsStbdXxCu/YQAcE87XnnF6nSqywplqGU=;
 b=JoLIJdpTItgVd1GdSf/UsVnei7+zFn/YtjHBkM5c/qqL9Gmc5GrQh8gdvX5Jaahst7esNxs3lX5UadBtaxhPXQmw+kBNetqxuqMAZQIWMp6W4Bw9VqRJtwA1yw80iI2vU/sQlGHGc0FblRE/CQnnBOU+gC4hMv2QIuqVYOiGhUV2l7G1fz1hzxQJAX4zBn9Aor4pNujwArqVTe/+L5Lv0Tkyu858OU8G6aFYmgdLjv1ANa9tgLaRAS11VfvqPdAWnb3YMT/Fy1C3PcjeHgB+kT1hn1iuvV7qYjACz1gs91qavdnzmHohbwwwFh4gQeMHPlxwSR01EUK+qYFhyJYaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5Ew8V0B9jrsStbdXxCu/YQAcE87XnnF6nSqywplqGU=;
 b=AVjxeLW3nBJhnDBBX1v/mvCJeiKl75Z70yYdMYgU7L6CawVgPi4i0Abxpq+l9vOLDYvmzZCPZaLBz3YfF8HYcKOF8Q/J1GA1nnmc96uRmmVUzbB4pBVWYkT2qrNyU/g849vptv5SSY28582YPbWasVkff9AfLPBlZGfzUXEYoRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5284.eurprd04.prod.outlook.com (2603:10a6:208:cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 05:04:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 05:04:12 +0000
Message-ID: <5eab897d-c5db-8399-9476-92271d2e53e7@oss.nxp.com>
Date:   Wed, 7 Sep 2022 13:04:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] clk: imx: clk-gate-93: fix build error with x86_64
 allmodconfig
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220906024047.1840977-1-peng.fan@oss.nxp.com>
 <Yxc6VVXs98+HpovI@linaro.org>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <Yxc6VVXs98+HpovI@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c7c2c3d-940c-44d6-8339-08da908e672f
X-MS-TrafficTypeDiagnostic: AM0PR04MB5284:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ro6YqIYpalGjmbKMk66dV6CBJNkjvxM/FeMfOzPZU4yaff+bkNxa7qyGjOYksWwiKMfka+HSZnmFG60is/lQsffaqMzII7C4Dqonni1GT95c+kFclY2RgbgejL7gbM+CVhywDreRHdJovcEjkI5JdgLBJb4RqCcr23si47w8RQ8AzfI2ol/dIWhRran5kyIfoOcJkZ++oaYMd09H4sg2jMNouxnVoJS/mRaNfC0mQAk0xlQONjLl1UhbRUwQ1nHhHY/3usYhf0zBj5oMRYmFvOTkdhbDC+tMWXI3LwejcZlG9hTVD2VJ0nDgbqRhGjOBgAvVJou+V56v8taIoxr3NiZeyFsp/ZtNFBREV9WEf5u2t/dnpsCz6hRZPeqxqZ7ZN5icE1N0Geaigl7Q6r8cZ6VoSBb30DD7WwruRtu5OwRYRRNrEkNuHNzEAuNxFM+Rh5BNUJQCYWRGFYKZLogSqHNbj8ztEsPMEtMbdpMkA+AEYNcW5FV92fT25JVtgwi2IY0o0Anrw0o8/q+9sJYIcjT7a7SGK4saclM5CGCe3QmQ16MUoEMplfN5lczt8gyw8pq15TDYrt3NqfPakf+lGkGX8+QApk7TrOwdtyhUj9MCylOrwcHXhdLCHIZ4wteV3VTPB0L8zoOyJ4A+vOEyYlJU6aWhInYNqOGkXfqV5RUglQxN5YTuxkg3mULIknzJlnub8QqlTWgvJrl70MFtGKX0K59fY3nsvjy/Lff72tCPwbnGTWmGFdqxP4jsm17z58t7oVNTD8n80yxR0/B70hkKeqO9Xsf5l+GWYTLlIBlXLK8QX6NgYB/+mgWb40qiyTGd6NGlhzm5P49+QI/CEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(5660300002)(2906002)(86362001)(6506007)(8936002)(38100700002)(44832011)(41300700001)(7416002)(6666004)(6512007)(52116002)(53546011)(26005)(38350700002)(31696002)(186003)(2616005)(66946007)(83380400001)(6486002)(66476007)(316002)(478600001)(4326008)(66556008)(31686004)(8676002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXVBWlFXVlQ3c1ZRVzdqL25oWUdyR0dQcHRVVU5LTlk4NmcyRkpWcUpZVkVo?=
 =?utf-8?B?b0lBc3NpZGxCcFJVbUUybTNwaUJWUEZ4OGFZUm56b0JkRC9RS0Z2aThtSE1x?=
 =?utf-8?B?Q2JtL21SVWdFUUJWU1AxMG9tZkdSR05CZG9BdC9aVVc4OGRNN0hmWFp2V3Ez?=
 =?utf-8?B?YXJlRERFUHZaVXVNOXk2bFFHMHBtdnFVNS9EVk5OWnYzVU5GeCtDRW9FVFU0?=
 =?utf-8?B?YTVqLzdYVmtJc1gzVVpaVDE3ajIxVk1ZTEYxcjhKd1BDdllXMFNZMitCdGM1?=
 =?utf-8?B?SlJvL2U1b0tEcHJEOHlYeEtEdkpZaS9GMllDQWF2YVNZYVNRR0Q1SzE3RGlG?=
 =?utf-8?B?ZERGNWxSamRpb2dlOWlhdG9pbjBJc2RsSEIveXpuekFmSHZTSWF0T0VodkhP?=
 =?utf-8?B?YVl5SnYxZy9kbXA1TmtXaWp5UE00enh0bzNpRW10SWViQnRUdWI4MTkyMVI0?=
 =?utf-8?B?MlAvRGx2ZG51cFZ2YU9wajZpa1FIeVlGcjg1UUJ3eGhScC9DZ3dsbWtXdG9y?=
 =?utf-8?B?S0orV1VmNEhjWFNOVmhiY0dVSXJMMUtUdVdSQ2hxbFAxN0hURlpzdkNzcHZW?=
 =?utf-8?B?WGRSNjFhQkVBWlBva052R1VkNEVhNWtreG5lRFY2VjFXMHFsdHhRRnZHM3c1?=
 =?utf-8?B?TjVTTGtIYldzSDlvSm9Ib2ZKMGFnSUNUMFduVW43QTROZ09pMnNjQzkvTlE3?=
 =?utf-8?B?Y1NZVGFRV3dGZ3dCbmFXK3ZDVEJqbTZKTkR0K0JvMUcwaDZMWjUxL0NIVnpU?=
 =?utf-8?B?Mkw1ZlpQYW10a2VxcmZ6LzE5UnN1N3VmK0gySS9XeEtoWmZlak5DQVV5enNE?=
 =?utf-8?B?b1pZZm9hREtnZ3RGeEk4dFRVZUZoZkpFWGVPaXBaWXVWU0Y5NGJDcnZFUVBm?=
 =?utf-8?B?dHZUVUxCb0syZWpUblFvTzQ3ZGFQcS9hYkZBRzN1azErYW1GdmhhRC9hc1Ar?=
 =?utf-8?B?RGdHTXI2WlgydU1OOS9mdFlWMXdMOGxjdFhVL3h6Um9naDBaOURHLzU5SExJ?=
 =?utf-8?B?dEZSZzRuYklhZkJVQ2VmS3FyVGU3VWdQckFmZ08zcmhZaEEyZFdPNGVBZ0c3?=
 =?utf-8?B?REgvbk9tVTl4dVJWMFpGcVp5T0d2QzlJamkrcTBzcHUyTkhKMkVIZEo2WDlk?=
 =?utf-8?B?YTlWWmlVNEFaczJoMHBsSW5oaHhua1p6cTVtS3dYZ0NVb21kWDRONGJxbEZz?=
 =?utf-8?B?azNldWZnWWVZTWxCZmNFQVhOVUV0UDVKczFZZnNKV055eFVLNERBZ1BtRm9i?=
 =?utf-8?B?blpSV1Fzb1hWYVoyRWZDcTBBTWZaOEphRU5pVXJBZ3VwYUJCbm8ybENvaVpm?=
 =?utf-8?B?KzhxazFPbFRmNGVZRVdLN25uR1ZQeHVUL0pScWZTa2hxK2tZaiswcDdRL2x4?=
 =?utf-8?B?dkRNY3VJcThsRWZnbXgvUkxCdkdNcTFyTjdOeVc4ZktLSmUvbmZoSzVGeWZV?=
 =?utf-8?B?elQ5R3lBMkZpMWx6cGFrbjhxTk12OEo3YlVtc3ptOWhxSzZ3eW9VQytBZnJW?=
 =?utf-8?B?ZE15a2VGU0UyQklDSG8rcDM2QUN1QzdjMlRSWHd0M2FiRlNMTEZwVW42RDJE?=
 =?utf-8?B?ZENwRHRleTZzL1N6NzhTUDJ0NjBLMDFtL1BmU21iVHk1QTNLLzloVE5NbW91?=
 =?utf-8?B?Y3VzanV6RDM0U3VtZVlINmxLM2FvaTFIVTlpaHNPN3JwVnBtcTVKQVl3a1dC?=
 =?utf-8?B?YitWT3Z3cXBaMjBRY056Z2FDSXRwcVRhUGNWMUZ0dlNCNW5aNDFTZ2Y0Zjg5?=
 =?utf-8?B?NmlDNWI1MGJGS09kdzlkV3g3VXBvMThVZDlTUDJOaEVPaHl1RFNHY01OcWQ2?=
 =?utf-8?B?M2JnS2NtQzlMUWFJaTZEY2h4QVZURVpXWnB5YUJyMXpCYys4Z2dxLzZFUjJY?=
 =?utf-8?B?bmkvSENDRXV3KzU0bEVrKzJYbXdIYTBaR2l2VzQxNWxGbFpxemhibGZ5Slhu?=
 =?utf-8?B?VVp1VnlsN21qRlZuUVIwZGduZ3FqdHF0WHBsZDFSdW5JQyt6R3JOT05VY3E1?=
 =?utf-8?B?cXIwTzJRMnBMTE1GZEx3cjIreUd6dTdRcE5lQmg5TWRvT0pobGRSNVVJS1Fu?=
 =?utf-8?B?UnhESXZXSnBGcXZ6d2twSEtHSDBSYUlJYnRVNFdBYkdKVW11TlVRVGdFRHMy?=
 =?utf-8?Q?hWlFJ5OqaTZET4fY9yBuU3cz3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7c2c3d-940c-44d6-8339-08da908e672f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 05:04:12.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiNw4Mla5ALyK9QjTFG91WVNIdzGgDKK+8iPfmKangF5766cDlPxJmgsqlkw7+OWO3wDlHdqeoo2m7Lq6bxFlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5284
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abel,

On 9/6/2022 8:17 PM, Abel Vesa wrote:
> On 22-09-06 10:40:47, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> When building with x86_64 allmodconfig:
>> ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-gate-93.o
>>
>> Fix it with 'mxc-clk-objs += clk-gate-93.o'
>>
>> Fixes: 4e9331d4e2e0 ("clk: imx: add i.MX93 clk gate")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Hi Peng,
> 
> Since the commit this patch fixes is just in my tree for now,
> I squahed in the mentioned commit.
> 

Sure. Thanks for helping on it.

Thanks,
Peng.

> So, it is applied.
> 
> Thanks!
> 
>> ---
>>   drivers/clk/imx/Makefile | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
>> index 89fe72327788..e8aacb0ee6ac 100644
>> --- a/drivers/clk/imx/Makefile
>> +++ b/drivers/clk/imx/Makefile
>> @@ -12,6 +12,7 @@ mxc-clk-objs += clk-fixup-div.o
>>   mxc-clk-objs += clk-fixup-mux.o
>>   mxc-clk-objs += clk-frac-pll.o
>>   mxc-clk-objs += clk-gate2.o
>> +mxc-clk-objs += clk-gate-93.o
>>   mxc-clk-objs += clk-gate-exclusive.o
>>   mxc-clk-objs += clk-pfd.o
>>   mxc-clk-objs += clk-pfdv2.o
>> @@ -28,7 +29,7 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
>>   obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
>>   obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
>>   
>> -obj-$(CONFIG_CLK_IMX93) += clk-imx93.o clk-gate-93.o
>> +obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
>>   
>>   obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
>>   clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
>> -- 
>> 2.37.1
>>
