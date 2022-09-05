Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE55ACB39
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiIEGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbiIEGri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:47:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2A72C115;
        Sun,  4 Sep 2022 23:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5adlfzDHKZ1ByX5z4Oo/anf7KLHhN26k73sQGm8STR+YrCgOt9+XADdXZaVILfD5cUnyU0ojokFyX89sRcc8KZULg/k3VD2S7Uh5WVTco9SkluiT+g6ZmnrYfVRLIhKBORFNRq3uHPJ0DgsLAZ9NMI11eVw0XRkTg9ICazjWMt/+/RiVSyrKhY3JcAf8H5ut6IsqZC5zBiRn4zcNdHVxSa3lE54301XewPORf5xBgahi4pH61oUrkspoCFpdmmN6ejMGt2TA9zvL3pz0e8Txu8AA7Ln2206O3uxw4OMTEIUa+ITR6z1XKIm2r/UAX8Kj+AwVaDCjO7ObLPQ0t/gVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AumMjV544C7ivpRf0QLI+WrytEfGV83fX/8Dw0POqBM=;
 b=U+3nFLHHqSgbZsjF1V3GVFKgu7fCFztMLHj/s2kKuCnXEpuOAZosn505c+4aNbjxHfj54JNYZCK6t/3bb1k//hQJ2GWZ/l4bGuFHzYIg8kp8LTiLsbdHtS7/OJG6pfjraG+P2I3QUbaq8HMcqEM2yyQMHhUjKF3CxeYlqsXJ19RrahKETF8/QHUHokZam41mKVg/mmHfcxcvOBdj+dtSGuZSOyRMpxgJzS/iBl/5hsXEpDxeMbRzk386uyt3imBkmpOLYxAyZ/xc9pvCnC3/7HL844CyPDcxqjMvT0HUR593MQ2Kpou0zRIB8Jvm85uKByhmJ9J6b/3Jn6r1uL5YLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AumMjV544C7ivpRf0QLI+WrytEfGV83fX/8Dw0POqBM=;
 b=ajfxuOSgwdppWsBADtP3EM9ud5CbhiJcyfXQflqJ5J3nrvnzZ/PCWvJEJPzY2NNFAoZJgbOJbqpJrI47+NgtfwM4vfBpi3NBTvNA7TdH4opnRYUrjD/Vae2hmM0FQPJrSJS/uMgGcap4wNQpJI5/um2BwJ1CNcfJQYt0RyysNqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5985.eurprd04.prod.outlook.com (2603:10a6:208:11a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Mon, 5 Sep
 2022 06:47:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 06:47:29 +0000
Message-ID: <26552553-b598-3179-40f8-170e766e3809@oss.nxp.com>
Date:   Mon, 5 Sep 2022 14:47:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V8 4/6] soc: imx: add i.MX93 media blk ctrl driver
Content-Language: en-US
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        kernel test robot <lkp@intel.com>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
 <20220823055215.1139197-5-peng.fan@oss.nxp.com>
 <20220904104403.GJ1728671@dragon>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220904104403.GJ1728671@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d35bfb42-6b70-4e11-73cd-08da8f0a803c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5985:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WY+0e21rET2Vqsho2dAG8SdU8En5KLSOfL7gvTI+c9xBJEs4X4/8Upr4jTiyHGIhL0s7/luQxpneg2Ka5Fvk8BKxoT+sIlyOkhIKOX6BAUOvRMiDbaBlfDUGAh9sGfOkETSXgfnep0t6oJZ8wPJ8Mqp0/S2562OZtJBBrNmhxFY+61OAusEh3iHZVG+qAwq9BCeTgzG0hSjC1QDgh8FiYIrqNICfasway7nI/pmtB9DR7me6g+sSDwSBho28NuAUpQatjJcokMft1Ry4ecjzuTOsM5VgNKmgJOWk4dGIxmUr4OEeyqjLsiqmauMUPbyPpKCx4AG3I3THo36ksHGziVhWapdjHYjRlq4MXBSaNCRZZVtb6MZmALQxV7EYUpZPHd1Klku8yDcl2zioAmA2IjS2tvED8vQcxpEQ9cV6q4UHEua++lkxQnnlymxfaMHFJlEpMFvI/Nd1CSYgZtZ8yanVtc/AL9yddcobe2AUlL8TJFhKheMJ4xh656LNbFGLg2Zv2VNStqf6beGYldXoC1TjpuDIcMFZNSKOL2h4FmP6nIDrtYkBPDQEwQA8kIO8Du27m0CMmuZHT+iXZRM8nmesS+us99Q/wTzQ4cIjKB/bUAZfk6DV7okXMu8b8n8xbqxpJ7CBWF2u9LhHLe3nW+FEnE4NJ0xm4RvLDpbUCa9zX5yLq5nIJ4BTOwZQeyv7I4Ck5P5YmI13wtFfcyQ6EqR2qwmbt/ElGmFU4H+bg1fB9v/i88AnmiRzZFcGbxOM8S4LmLg9kzElvv3jAYNrQc5wZTGhZRDQNhO3KKpba0AundUkvKrw8qE/C0dWRz3ml6XMIRzLWZOSGzPW3+yikA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(8676002)(66476007)(66556008)(4326008)(66946007)(316002)(6916009)(6666004)(83380400001)(54906003)(2616005)(31696002)(86362001)(31686004)(6512007)(26005)(186003)(7416002)(8936002)(2906002)(5660300002)(30864003)(44832011)(38350700002)(38100700002)(52116002)(6506007)(53546011)(41300700001)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZNWGZrZEpENDRTWnMyT0hIWE5hV3hVck1JbGw4amgwSForbElRTlgwbHZH?=
 =?utf-8?B?NTRkeFg2a1h5ZGJwWjhVZURKcW4raTV3cXl0cTd4QUJiZkMzQ3lLTFhQdit5?=
 =?utf-8?B?TXNtRnBHbEdlaHRBVi9Ra3lsSThzbzJLTU02aUZ4cmM1UkFwSHcvL3BtdG4z?=
 =?utf-8?B?YnM1eFhxcmNmL3NJU05iNzdsZVJ1cnJlOThFNnZUd2UrU1c3a3MwTlBGSmx2?=
 =?utf-8?B?NlEwTno0czQ4N3lLMHQ4Zm9pN2gxbHJIcFdCaXpwSmRUdTh1dDJqN3YzdjR0?=
 =?utf-8?B?V3g0RFhEeFgwbEVIZ0J3dDNybFRZNmlaYUYxeGJlb2E3R1pYMWR5S0c3OUUv?=
 =?utf-8?B?cW80am10YTBhcWF0NWV1WHRwN0RqWHZPa1YwQ3ROTnFTUGF5SDRNR0RKVlNV?=
 =?utf-8?B?dFhIUkFMNVlvbC84N1NOUDQwWXpBWnJjYXZXN21vNHVzdUEyVTJ1M3RGVjUz?=
 =?utf-8?B?S09RdVZFMVlUc0g1ZnJpS0tUTFEzd3NUTXluaDZPaklFRWZWdTFOdHV6Rzdk?=
 =?utf-8?B?bHJvU2pjUDNvMGRUN1A3TEhaU1VBK0hkVGMzZFYyMHhYaERUTjdnS1BNcm9Y?=
 =?utf-8?B?ekRSRHRMMHJEM2gybkFrUU9QY3hxUFJNTjE5QktQMGdBZFNjK3hvc284V0RC?=
 =?utf-8?B?RDRscFNJWitkVWlFeTZHN05ad1JFVk0rVWRoU1pZdTgzS3l6ejUrdHloVzdI?=
 =?utf-8?B?d01FemVmcnhQZW1qY3RVRDlPZlUzcXNnSDlyOXlpY1lGckhqZnF4RVYzWERV?=
 =?utf-8?B?VGJLZU9YTzJ2TmwyWGJESjFOT0hMNk1vdW5jMm1rdDBhV0J2cmxrdGRVbnN5?=
 =?utf-8?B?T000NGpaYThBOWJVQ2JFdmVyNXpyMkhxWWw1Z3hpalVKRjZMMHptTHg4WHVH?=
 =?utf-8?B?THBEWThxVXcva1htMGZxclVBQ0h6VURtS3J2M1NNNFNOdlVWUDNNYVJ3Rms1?=
 =?utf-8?B?QVNDN2NYV2ZHQTIydnRVbDgzV1FlaktrYXFXVlp4c1M5bnlNbVJYTlhNcTVx?=
 =?utf-8?B?MVZHeElqK3hGQWR0SlArVE9JMVZreUZhaWJNRDdSUlJ1MUd2eXRQaWdKZmUx?=
 =?utf-8?B?bWp0ZWI3RStiTUFtT0V3Ui9NMzMzZ044WnNFR29jZzFyOCtaRElzVERFbXM5?=
 =?utf-8?B?dUJjZzNiRlBUTEhXOVJWY2Y0SXVZb1lzdGNkVWZDcmljNm95MzNTckNqMUxv?=
 =?utf-8?B?c2dPM0dBQjJlaEZWc3V3WDl6Z3NQOThnOVB3em9BMEVNZnFtRFFEZGUreWVP?=
 =?utf-8?B?bE5hcS8rZ2k4MDJ1TG4wQkdrOUtUdmpnelhlRE1IMjA2SldRVWhzbXIrOEcy?=
 =?utf-8?B?V1RMT0NFVjFBdTB2N0RXUE5GSW5TMlNUajBHZ1VuVW9ScGJHb251UWhZcS9Q?=
 =?utf-8?B?d05ubkZkWVZzT2JyZGNmanV2amdWQlZGT2ZaMi9FenRHYUJhSStjWU5GM0E2?=
 =?utf-8?B?SDlFeDcxOXo0Z3dZTWoxbjZNZUd4enJNUVNycFZuNmFDeElqUTZHOVcxdUl2?=
 =?utf-8?B?L2wrY2hhVzV6bURnR3dUMTRlSVl1NHNzSzNWeWRGRW5xOEEwNW4yaEpUbEJ2?=
 =?utf-8?B?ZUJvNnZmaXVEUlFyWW4wN2MwVmVMOGdXZlUvOElsNDhwM0RyUDJwNW5SZFFm?=
 =?utf-8?B?M1NYYWllQ1NHditrLzVjV3M0OURneE5rZHBDMTFPRVNIbzhrcGFCdlNYeFVk?=
 =?utf-8?B?aGpHcXdkZHVWZ0JxblhtN2lhak9JaFNBcVlkR2FWUVFZNjdwV3d0UGlLZUU2?=
 =?utf-8?B?Ky9GMTJZWjNuRHpvWHNaYnNabE1wQlNDVEYrZ0FrUzl1ZGNjN1N6SkRBSUxZ?=
 =?utf-8?B?dHJFdTFZZUVqalk2Sk1CeDBBZE5nYjFqRmgrZW9mWmdoaUQ4bElZTytEYlBM?=
 =?utf-8?B?ckJqYndZaEJldVZHRStmZUc3ZmlQY3N5MnN5OWQ1T01uZ3gzcnk2Sk5HK25R?=
 =?utf-8?B?Ky9Sa2gzaDlodGhmdXhmZHpONjR5N2dZY3hSY0Vua0VFcnVJMDNqTFdZSkdq?=
 =?utf-8?B?Y3lza3dBK3JYdThjQzFnYzRFVk1PVCtxODJEODMwbVArZWZzbFdSelFJYUpT?=
 =?utf-8?B?NURGYjQyamlyZVZ2MlJ1aUMrZnRleE1pU3ordnRkMnFDY2YrekdYWEZZazlL?=
 =?utf-8?Q?5KxSYzXI+hdbY6me6WlLnjXK9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bfb42-6b70-4e11-73cd-08da8f0a803c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 06:47:29.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6abg1HHiClGheAe6JGHYZFBxtVXEBbJE2EdX0K/cOsMZc4zdrQL6b5SHLg3UCqTaHkP/xhYUeh1CDPnSN7o+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5985
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 9/4/2022 6:44 PM, Shawn Guo wrote:
> On Tue, Aug 23, 2022 at 01:52:13PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Add i.MX93 mediamix blk ctrl support.
>>
>> i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
>> It support default QoS value and cfg QoS value. Set an initial
>> value from i.MX design team. If LCDIF/ISI/PXP wanna a different QoS
>> value in future, they could use interconnect to request bandwidth.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> This doesn't make too much sense for a new driver.  It's mostly
> meaningful for fixes.

Drop it in V9.

> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   drivers/soc/imx/Makefile         |   2 +-
>>   drivers/soc/imx/imx93-blk-ctrl.c | 452 +++++++++++++++++++++++++++++++
>>   2 files changed, 453 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
>>
>> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
>> index a0baa2a01adb..754866e0a10d 100644
>> --- a/drivers/soc/imx/Makefile
>> +++ b/drivers/soc/imx/Makefile
>> @@ -7,4 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
>>   obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
>>   obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
>>   obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
>> -obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o
>> +obj-$(CONFIG_SOC_IMX9) += imx93-src.o imx93-pd.o imx93-blk-ctrl.o
> 
> Maybe have it on a separate line?

Sure.

> 
> +obj-$(CONFIG_SOC_IMX9) += imx93-blk-ctrl.o
> 
>> diff --git a/drivers/soc/imx/imx93-blk-ctrl.c b/drivers/soc/imx/imx93-blk-ctrl.c
>> new file mode 100644
>> index 000000000000..12f4e635b46d
>> --- /dev/null
>> +++ b/drivers/soc/imx/imx93-blk-ctrl.c
>> @@ -0,0 +1,452 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2022 NXP, Peng Fan <peng.fan@nxp.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +#include <linux/sizes.h>
>> +
>> +#include <dt-bindings/power/fsl,imx93-power.h>
>> +
>> +#define BLK_SFT_RSTN	0x0
>> +#define BLK_CLK_EN	0x4
>> +#define BLK_MAX_CLKS	4
>> +
>> +#define DOMAIN_MAX_CLKS 4
>> +
>> +#define LCDIF_QOS_REG		0xC
>> +#define LCDIF_DEFAULT_QOS_OFF	12
>> +#define LCDIF_CFG_QOS_OFF	8
>> +
>> +#define PXP_QOS_REG		0x10
>> +#define PXP_R_DEFAULT_QOS_OFF	28
>> +#define PXP_R_CFG_QOS_OFF	24
>> +#define PXP_W_DEFAULT_QOS_OFF	20
>> +#define PXP_W_CFG_QOS_OFF	16
>> +
>> +#define ISI_CACHE_REG		0x14
>> +
>> +#define ISI_QOS_REG		0x1C
>> +#define ISI_V_DEFAULT_QOS_OFF	28
>> +#define ISI_V_CFG_QOS_OFF	24
>> +#define ISI_U_DEFAULT_QOS_OFF	20
>> +#define ISI_U_CFG_QOS_OFF	16
>> +#define ISI_Y_R_DEFAULT_QOS_OFF	12
>> +#define ISI_Y_R_CFG_QOS_OFF	8
>> +#define ISI_Y_W_DEFAULT_QOS_OFF	4
>> +#define ISI_Y_W_CFG_QOS_OFF	0
>> +
>> +#define PRIO_MASK		0xF
>> +
>> +#define PRIO(X)			(X)
>> +
>> +struct imx93_blk_ctrl_domain;
>> +
>> +struct imx93_blk_ctrl {
>> +	struct device *dev;
>> +	struct regmap *regmap;
>> +	int num_clks;
>> +	struct clk_bulk_data clks[BLK_MAX_CLKS];
>> +	struct imx93_blk_ctrl_domain *domains;
>> +	struct genpd_onecell_data onecell_data;
>> +};
>> +
>> +#define DOMAIN_MAX_QOS 4
>> +
>> +struct imx93_blk_ctrl_qos {
>> +	u32 reg;
>> +	u32 cfg_off;
>> +	u32 default_prio;
>> +	u32 cfg_prio;
>> +};
>> +
>> +struct imx93_blk_ctrl_domain_data {
>> +	const char *name;
>> +	const char * const *clk_names;
>> +	int num_clks;
>> +	u32 rst_mask;
>> +	u32 clk_mask;
>> +	u32 num_qos;
>> +	struct imx93_blk_ctrl_qos qos[DOMAIN_MAX_QOS];
>> +	const struct regmap_access_table *reg_access_table;
> 
> It seems to me that reg_access_table is something specific to
> imx93_blk_ctrl rather than imx93_blk_ctrl_domain.

Right, I only set reg_access_table for bus, not for
child domain. But In this driver, bus and child domain share
the same data structure "struct imx93_blk_ctrl_domain_data"

> 
>> +};
>> +
>> +struct imx93_blk_ctrl_domain {
>> +	struct generic_pm_domain genpd;
>> +	const struct imx93_blk_ctrl_domain_data *data;
>> +	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
>> +	struct imx93_blk_ctrl *bc;
>> +};
>> +
>> +struct imx93_blk_ctrl_data {
>> +	const struct imx93_blk_ctrl_domain_data *domains;
>> +	const struct imx93_blk_ctrl_domain_data *bus;
> 
> It looks confusing to claim 'bus' as an imx93_blk_ctrl_domain_data.  I
> would suggest you have 'related' fields directly defined in
> imx93_blk_ctrl_data.

This would implies a bit large change to this driver.

Should I use a new V1 for the patchset or continue V9 for next version?

> 
>> +	int num_domains;
>> +};
>> +
>> +static inline struct imx93_blk_ctrl_domain *
>> +to_imx93_blk_ctrl_domain(struct generic_pm_domain *genpd)
>> +{
>> +	return container_of(genpd, struct imx93_blk_ctrl_domain, genpd);
>> +}
>> +
>> +static int imx93_blk_ctrl_set_qos(struct imx93_blk_ctrl_domain *domain)
>> +{
>> +	const struct imx93_blk_ctrl_domain_data *data = domain->data;
>> +	struct imx93_blk_ctrl *bc = domain->bc;
>> +	const struct imx93_blk_ctrl_qos *qos;
>> +	u32 val, mask;
>> +	int i;
>> +
>> +	for (i = 0; i < data->num_qos; i++) {
>> +		qos = &data->qos[i];
>> +
>> +		mask = PRIO_MASK << qos->cfg_off;
>> +		mask |= PRIO_MASK << (qos->cfg_off + 4);
>> +		val = qos->cfg_prio << qos->cfg_off;
>> +		val |= qos->default_prio << (qos->cfg_off + 4);
>> +
>> +		regmap_write_bits(bc->regmap, qos->reg, mask, val);
>> +
>> +		dev_dbg(bc->dev, "data->qos[i].reg 0x%x 0x%x\n", qos->reg, val);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int imx93_blk_ctrl_power_on(struct generic_pm_domain *genpd)
>> +{
>> +	struct imx93_blk_ctrl_domain *domain = to_imx93_blk_ctrl_domain(genpd);
>> +	const struct imx93_blk_ctrl_domain_data *data = domain->data;
>> +	struct imx93_blk_ctrl *bc = domain->bc;
>> +	int ret;
>> +
>> +	ret = clk_bulk_prepare_enable(bc->num_clks, bc->clks);
>> +	if (ret) {
>> +		dev_err(bc->dev, "failed to enable bus clocks\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_bulk_prepare_enable(data->num_clks, domain->clks);
>> +	if (ret) {
>> +		clk_bulk_disable_unprepare(bc->num_clks, bc->clks);
>> +		dev_err(bc->dev, "failed to enable clocks\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = pm_runtime_get_sync(bc->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(bc->dev);
>> +		dev_err(bc->dev, "failed to power up domain\n");
>> +		goto disable_clk;
>> +	}
>> +
>> +	/* ungate clk */
>> +	regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>> +
>> +	/* release reset */
>> +	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
>> +
>> +	dev_dbg(bc->dev, "pd_on: name: %s\n", genpd->name);
>> +
>> +	return imx93_blk_ctrl_set_qos(domain);
>> +
>> +disable_clk:
>> +	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
>> +
>> +	return ret;
>> +}
>> +
>> +static int imx93_blk_ctrl_power_off(struct generic_pm_domain *genpd)
>> +{
>> +	struct imx93_blk_ctrl_domain *domain = to_imx93_blk_ctrl_domain(genpd);
>> +	const struct imx93_blk_ctrl_domain_data *data = domain->data;
>> +	struct imx93_blk_ctrl *bc = domain->bc;
>> +
>> +	dev_info(bc->dev, "pd_off: name: %s\n", genpd->name);
>> +
>> +	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, data->rst_mask);
>> +	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
>> +
>> +	pm_runtime_put(bc->dev);
>> +
>> +	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
>> +
>> +	clk_bulk_disable_unprepare(bc->num_clks, bc->clks);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct generic_pm_domain *
>> +imx93_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
>> +{
>> +	struct genpd_onecell_data *onecell_data = data;
>> +	unsigned int index = args->args[0];
>> +
>> +	if (args->args_count != 1 ||
>> +	    index >= onecell_data->num_domains)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	return onecell_data->domains[index];
>> +}
> 
> Why don't we just use the genpd_xlate_onecell() defined by genpd core?

Thanks for tips, genpd_xlate_onecell is better,
I follow imx8m-blk-ctrl driver, that driver could also use
genpd_xlate_onecell.

> 
>> +
>> +static int imx93_blk_ctrl_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	const struct imx93_blk_ctrl_data *bc_data = of_device_get_match_data(dev);
>> +	const struct imx93_blk_ctrl_domain_data *bus = bc_data->bus;
>> +	struct imx93_blk_ctrl *bc;
>> +	void __iomem *base;
>> +	int i, ret;
>> +
>> +	struct regmap_config regmap_config = {
>> +		.reg_bits	= 32,
>> +		.val_bits	= 32,
>> +		.reg_stride	= 4,
>> +		.rd_table	= bus->reg_access_table,
>> +		.wr_table	= bus->reg_access_table,
>> +		.max_register   = SZ_4K,
>> +	};
>> +
>> +	bc = devm_kzalloc(dev, sizeof(*bc), GFP_KERNEL);
>> +	if (!bc)
>> +		return -ENOMEM;
>> +
>> +	bc->dev = dev;
>> +
>> +	base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	bc->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
>> +	if (IS_ERR(bc->regmap))
>> +		return dev_err_probe(dev, PTR_ERR(bc->regmap),
>> +				     "failed to init regmap\n");
>> +
>> +	bc->domains = devm_kcalloc(dev, bc_data->num_domains + 1,
> 
> Why do we need one more domain than what bc_data defines?

I could not recall, but seems the extra one could be dropped.

> 
>> +				   sizeof(struct imx93_blk_ctrl_domain),
>> +				   GFP_KERNEL);
>> +	if (!bc->domains)
>> +		return -ENOMEM;
>> +
>> +	bc->onecell_data.num_domains = bc_data->num_domains;
>> +	bc->onecell_data.xlate = imx93_blk_ctrl_xlate;
>> +	bc->onecell_data.domains =
>> +		devm_kcalloc(dev, bc_data->num_domains,
>> +			     sizeof(struct generic_pm_domain *), GFP_KERNEL);
>> +	if (!bc->onecell_data.domains)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < bus->num_clks; i++)
>> +		bc->clks[i].id = bus->clk_names[i];
>> +	bc->num_clks = bus->num_clks;
>> +
>> +	ret = devm_clk_bulk_get(dev, bc->num_clks, bc->clks);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "failed to get bus clock\n");
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < bc_data->num_domains; i++) {
>> +		const struct imx93_blk_ctrl_domain_data *data = &bc_data->domains[i];
>> +		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
>> +		int j;
>> +
>> +		domain->data = data;
>> +
>> +		for (j = 0; j < data->num_clks; j++)
>> +			domain->clks[j].id = data->clk_names[j];
>> +
>> +		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret, "failed to get clock\n");
>> +			goto cleanup_pds;
>> +		}
>> +
>> +		domain->genpd.name = data->name;
>> +		domain->genpd.power_on = imx93_blk_ctrl_power_on;
>> +		domain->genpd.power_off = imx93_blk_ctrl_power_off;
>> +		domain->bc = bc;
>> +
>> +		ret = pm_genpd_init(&domain->genpd, NULL, true);
>> +		if (ret) {
>> +			dev_err_probe(dev, ret, "failed to init power domain\n");
>> +			goto cleanup_pds;
>> +		}
>> +
>> +		bc->onecell_data.domains[i] = &domain->genpd;
>> +	}
>> +
>> +	pm_runtime_enable(dev);
>> +
>> +	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "failed to add power domain provider\n");
>> +		goto cleanup_pds;
>> +	}
>> +
>> +	dev_set_drvdata(dev, bc);
>> +
>> +	return 0;
>> +
>> +cleanup_pds:
>> +	for (i--; i >= 0; i--)
>> +		pm_genpd_remove(&bc->domains[i].genpd);
>> +
>> +	return ret;
>> +}
>> +
>> +static int imx93_blk_ctrl_remove(struct platform_device *pdev)
>> +{
>> +	struct imx93_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
>> +	int i;
>> +
>> +	of_genpd_del_provider(pdev->dev.of_node);
>> +
>> +	for (i = 0; bc->onecell_data.num_domains; i++) {
>> +		struct imx93_blk_ctrl_domain *domain = &bc->domains[i];
>> +
>> +		pm_genpd_remove(&domain->genpd);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_domain_data[] = {
>> +	[IMX93_MEDIABLK_PD_MIPI_DSI] = {
>> +		.name = "mediablk-mipi-dsi",
>> +		.clk_names = (const char *[]){ "dsi" },
>> +		.num_clks = 1,
>> +		.rst_mask = BIT(11) | BIT(12),
>> +		.clk_mask = BIT(11) | BIT(12),
>> +	},
>> +	[IMX93_MEDIABLK_PD_MIPI_CSI] = {
>> +		.name = "mediablk-mipi-csi",
>> +		.clk_names = (const char *[]){ "cam", "csi" },
>> +		.num_clks = 2,
>> +		.rst_mask = BIT(9) | BIT(10),
>> +		.clk_mask = BIT(9) | BIT(10),
>> +	},
>> +	[IMX93_MEDIABLK_PD_PXP] = {
>> +		.name = "mediablk-pxp",
>> +		.clk_names = (const char *[]){ "pxp" },
>> +		.num_clks = 1,
>> +		.rst_mask = BIT(7) | BIT(8),
>> +		.clk_mask = BIT(7) | BIT(8),
>> +		.num_qos = 2,
>> +		.qos = {
>> +			{
>> +				.reg = PXP_QOS_REG,
>> +				.cfg_off = PXP_R_CFG_QOS_OFF,
>> +				.default_prio = PRIO(3),
>> +				.cfg_prio = PRIO(6),
>> +			}, {
>> +				.reg = PXP_QOS_REG,
>> +				.cfg_off = PXP_W_CFG_QOS_OFF,
>> +				.default_prio = PRIO(3),
>> +				.cfg_prio = PRIO(6),
>> +			}
>> +		}
>> +	},
>> +	[IMX93_MEDIABLK_PD_LCDIF] = {
>> +		.name = "mediablk-lcdif",
>> +		.clk_names = (const char *[]){ "disp", "lcdif" },
>> +		.num_clks = 2,
>> +		.rst_mask = BIT(4) | BIT(5) | BIT(6),
>> +		.clk_mask = BIT(4) | BIT(5) | BIT(6),
>> +		.num_qos = 1,
>> +		.qos = {
>> +			{
>> +			.reg = LCDIF_QOS_REG,
>> +			.cfg_off = LCDIF_CFG_QOS_OFF,
>> +			.default_prio = PRIO(3),
>> +			.cfg_prio = PRIO(7),
>> +			}
>> +		}
>> +	},
>> +	[IMX93_MEDIABLK_PD_ISI] = {
>> +		.name = "mediablk-isi",
>> +		.clk_names = (const char *[]){ "isi" },
>> +		.num_clks = 1,
>> +		.rst_mask = BIT(2) | BIT(3),
>> +		.clk_mask = BIT(2) | BIT(3),
>> +		.num_qos = 4,
>> +		.qos = {
>> +			{
>> +				.reg = ISI_QOS_REG,
>> +				.cfg_off = ISI_Y_W_CFG_QOS_OFF,
>> +				.default_prio = PRIO(3),
>> +				.cfg_prio = PRIO(7),
>> +			}, {
>> +				.reg = ISI_QOS_REG,
>> +				.cfg_off = ISI_Y_R_CFG_QOS_OFF,
>> +				.default_prio = PRIO(3),
>> +				.cfg_prio = PRIO(7),
>> +			}, {
>> +				.reg = ISI_QOS_REG,
>> +				.cfg_off = ISI_U_CFG_QOS_OFF,
>> +				.default_prio = PRIO(3),
>> +				.cfg_prio = PRIO(7),
>> +			}, {
>> +				.reg = ISI_QOS_REG,
>> +				.cfg_off = ISI_V_CFG_QOS_OFF,
>> +				.default_prio = PRIO(3),
>> +				.cfg_prio = PRIO(7),
>> +			}
>> +		}
>> +	},
>> +};
>> +
>> +static const struct regmap_range imx93_media_blk_ctl_yes_ranges[] = {
>> +		regmap_reg_range(BLK_SFT_RSTN, BLK_CLK_EN),
>> +		regmap_reg_range(LCDIF_QOS_REG, ISI_CACHE_REG),
>> +		regmap_reg_range(ISI_QOS_REG, ISI_QOS_REG),
> 
> One level indent is enough.

Got it.

> 
>> +};
>> +
>> +static const struct regmap_access_table imx93_media_blk_ctl_access_table = {
>> +	.yes_ranges	= imx93_media_blk_ctl_yes_ranges,
>> +	.n_yes_ranges	= ARRAY_SIZE(imx93_media_blk_ctl_yes_ranges),
> 
> Inconsistent indent around '=' with imx93_media_blk_ctl_bus_data and
> imx93_media_blk_ctl_dev_data below.

Got it.

> 
>> +};
>> +
>> +static const struct imx93_blk_ctrl_domain_data imx93_media_blk_ctl_bus_data = {
>> +	.clk_names = (const char *[]){ "axi", "apb", "nic", },
>> +	.num_clks = 3,
>> +	.reg_access_table = &imx93_media_blk_ctl_access_table,
>> +};
>> +
>> +static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
>> +	.domains = imx93_media_blk_ctl_domain_data,
>> +	.bus = &imx93_media_blk_ctl_bus_data,
>> +	.num_domains = ARRAY_SIZE(imx93_media_blk_ctl_domain_data),
>> +};
>> +
>> +static const struct of_device_id imx93_blk_ctrl_of_match[] = {
>> +	{
>> +		.compatible = "fsl,imx93-media-blk-ctrl",
>> +		.data = &imx93_media_blk_ctl_dev_data
>> +	}, {
>> +		/* Sentinel */
>> +	}
>> +};
>> +MODULE_DEVICE_TABLE(of, imx93_blk_ctrl_of_match);
>> +
>> +static struct platform_driver imx93_blk_ctrl_driver = {
>> +	.probe = imx93_blk_ctrl_probe,
>> +	.remove = imx93_blk_ctrl_remove,
>> +	.driver = {
>> +		.name = "imx93-blk-ctrl",
>> +		.of_match_table = imx93_blk_ctrl_of_match,
>> +	},
>> +};
>> +module_platform_driver(imx93_blk_ctrl_driver);
>> +
>> +MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
>> +MODULE_DESCRIPTION("i.MX93 BLK CTRL driver");
>> +MODULE_LICENSE("GPL");
> 
> "GPL v2"

No. Per ./Documentation/process/license-rules.rst,
GPL should be used.

Thanks,
Peng.

> 
> Shawn
