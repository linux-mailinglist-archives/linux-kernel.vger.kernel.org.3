Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999385645E5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiGCIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiGCInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:43:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F1E39;
        Sun,  3 Jul 2022 01:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX1v80O+cS+iLy4xTTl3IX2pdooN9jnBmC7rbcd24Ds5tLImCoT6V5eZjEcATHiBX0ixtCe8dx14ZklJEFI/9scaXk/P/qZNe1eLY/SujMAJ96aLKWExwwsQ3zh9k+JjOiP/NOjRRUfDj+ynaFMsxla5znrp3qrjUYnVpVRSDx5FNF7o8dzbw43SJTEpzvT80M2+rKvUKev06xlAloUuxxhabNWXFzPif4BNKHjXzXB9OOYg3KJhIZCdyMC3I+XGbMLok9Q8ytEKPZ11UN5XaSTtA9OWwsN6uZIElRhZJQQWAeP8xKQrgsDsC7RkD5EAAKCNzN0jzw/uPrigjgXJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UL0+41wi2oJhbuLc6lb7B120yzM1jqmSdv2TZL6orA=;
 b=cF5nGko9d6GNdR077UJq9ESABc0EIiC6PQRD5YYr1AfW5OL6ZND6VWMnxoR2EDH4cCAdGaFcCKbEYMFoDZ1owxe04jd7BdB3bvUfYRht3g6AGU2gQFHH98gHgdtmJABFeVArAXTWFIqystiiBkdvveDRMAncDHa5J64yHxqV9woAp/eIWuwdJVe3bG/TlwW5EecV7NSgoSBt6mo3BOFqIdHjvTsLEFEp4Alhal/m3VKC+v1qer+V1qD3DW0w6An/IPlXZO5y2WpxNpwM/iqy7byjO5qbUvvZqAlJcmrjlPgO+VlZYVoQ8e+cqmExhLOoKM8PBYaJd29BYmThoSmCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UL0+41wi2oJhbuLc6lb7B120yzM1jqmSdv2TZL6orA=;
 b=UBLJBRkpIB3LxSU9Jdj+QE9py0gkesa1Xc4GkZQgxHATJOCj/o2VCLyQ151OZdFdriBzfCNvBYsv+5L8aRVv0Q5FmtwjnsfccD81w3WlYRFY29xQfSFuJyhpdXpJLNGgVaORXvADJ9tjM9BNRH1LR3OzSPSGwzmohNsLyQx/9qI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB4020.eurprd04.prod.outlook.com (2603:10a6:208:56::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 08:43:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 08:43:16 +0000
Message-ID: <68d8fc46-e875-7f4d-ef73-d2177eddc0f1@oss.nxp.com>
Date:   Sun, 3 Jul 2022 16:43:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V2 7/9] interconnect: imx: set of_node for interconnect
 provider
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, marex@denx.de, paul.elder@ideasonboard.com,
        Markus.Niebel@ew.tq-group.com, aford173@gmail.com,
        kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20220616073320.2203000-1-peng.fan@oss.nxp.com>
 <20220616073320.2203000-8-peng.fan@oss.nxp.com>
 <3c773637f626877832041d3065f387261ba70816.camel@pengutronix.de>
 <YryMt4CfQNkIHwiV@pendragon.ideasonboard.com>
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
In-Reply-To: <YryMt4CfQNkIHwiV@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 111df6c8-442a-4883-7eb4-08da5cd01261
X-MS-TrafficTypeDiagnostic: AM0PR04MB4020:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKfRHIWgKaR6cFejMXfKGxd1T+2+88N7W3XERcmyJDOhfyzuaJRuVQziz6n3whc4B6iYUfZBGIl1PPN7j07iGURqbfENxaSLZpZyUW3kUoUYVVsNe7FzID9dMcM5tk1lTrQ6+pRc0D+5GD4JvoAJv5YEHrk3MgFwXVbl2/Jnk9AuEhoR886UzBV1MDAfAcKm26FqPxBrsHGRwKIZb9xlfVa2hfmMI1ey+EEW/MQWyRUZBEAOlUeTs4t/a64zVNLgHcMlCsUp/QLANXM4CY0S+UcPS/H7bbQNoHuKene91kbnLXSrAOHYfNBZm3RcksCqBydResvVab6Eqg9sjYyh0UrOrD5OdESmxb7GHsUDMYFWSq6j+YuOpgZHdhDzmidtccdo8Y72+etoa5kPTGDEQndIeTHSDAiOJNx2/Jt1sPW2XOq8GJdVy7jpLSIwNPNINkJHyCLGvwrPazgW25Cv2oWYE0xiIAc/2GTevGW86Ognnw/GSj4SPkRhXGESt/OTO+xtNKu2V9KaEP1qICpEIVkkonP4Eh0w+KAe5PhbaEiYFDzcQwjIMebwcJU5jD3eluVrcSy++0uiTsEQxsTBOws0VQngCVhm9+mgkJOABc4fI5MvzXHhGevY7/irK2FIH2bBEMfZ4kcvc1rUNz27H9LqxsT0GK68wbXE4NvCAUWSbHO4jYPs/+LH8pqGPinLH6Q5/a3Sg15lU74zjj28XvMo4d8BsquT1q2Xqg9Bl/xaCw9oyvsyJMcuuvUKJDXo9gvJtKo76cQU1KYXhbpctEglLDdXBNJ9MbeAZgbE0zpXuYgqylFi0wv/IBGbb1IoYL87+kq97nWpHnZF0WrNRLLkB0S8uAcD1ezRwdAMBU9t0YxQhLpKkkK6CftvoAnn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(31696002)(6486002)(86362001)(478600001)(4326008)(26005)(6512007)(6666004)(41300700001)(52116002)(6506007)(316002)(66476007)(66556008)(66946007)(8676002)(110136005)(186003)(38350700002)(38100700002)(2616005)(5660300002)(7416002)(8936002)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjFNelZRYTVabU02YitGSE9vMzhJemRVL3ZzbXRtd3ExUnVVeVNRRDRvNkpo?=
 =?utf-8?B?UjVOU1pvMlNKbndHMnlRaVk5Q2NyS2RRZmtDRDlmU3BHR3FpZHdFdk9YZGl1?=
 =?utf-8?B?NE1QK1J1MGpYRmJVL25iQmx6eFVQbTFmL0YxY3hEamNIbEdQbWRnaWpLZG9R?=
 =?utf-8?B?WXlnaXdUclNOa1FPZTR1K3pYNG9mRHJkMVV0djE0L3pyeGI0QVd4NXRrUkxr?=
 =?utf-8?B?WGtFYVVqMFh6d1lxZW5BS0xSZEI4cVQ4dC9YdzNxYTQ3UDY0UU5sVGdaSlFQ?=
 =?utf-8?B?YXBTaTYvZld5MFlKZi9Vb2VTVk11OWVDRTB1N3dyV0UxNFBvQUZBRTdNLzBM?=
 =?utf-8?B?bTZnTVg5bXhQdTJjOUdIeng0czZlUXl2QVZUOW5FRUIyZDlCQ256SUdBOG1z?=
 =?utf-8?B?UU9ERkNuejNzVitOeGU0Q2w2U3hDZEFaQXl5VC9FeXdjekNVM1NnZ2FZaTlo?=
 =?utf-8?B?QlY0MWZQUjN0N0N0Nkc2OS83Zy8zTnNhNENYSXd4TXc3TThJKy9zMHFIS1ox?=
 =?utf-8?B?V095TUJUSHJ1R2lQK09PVytVd3FWY2wvK1JCbUhzNUJsUkovemFnRkhUYWVE?=
 =?utf-8?B?czlQL04venNGVUQ4elp2THdheXhBUUp2RGdCQVNtUUpiUmNBWVV1S0RwTFI0?=
 =?utf-8?B?WGExenZkRUFjeEJDTmdYK0FES1Exc1V5emtRWkhlTmFMb1hCcDdkR1FZeThR?=
 =?utf-8?B?am9HcmZYTGd5YWVEdHRmZFB5UTY2ZUo0eG80KzdtMUthZzVNMWZUU2hZcTBh?=
 =?utf-8?B?eTV5YjNneHBtdnhzcDV4cytGbGRCUkl0bllvbkxjdFhpdjBuZWVsSmhwangx?=
 =?utf-8?B?OGovVndrNzRqNWZReDJBak1kazE2WnF5c0IySTlQN2x1YkVhVFBuTUZjR3Ru?=
 =?utf-8?B?TU5VeDZPa0hFeGhqNko3dmw1aGFac245MU9mZkRDUk00d0NrbkVzcG5xZmVN?=
 =?utf-8?B?MWczUFNoRndVYytOUXZhdFp4djBDYTZUWGlBYlAzS1JIY1l5SWp3MUNnMHFD?=
 =?utf-8?B?K0N4dzV1VTYramlYM0wyOVV3OHlMeVowQVZVbHRvQ1h3RFBndkVabHNic0xt?=
 =?utf-8?B?bmcxMGJCVjZRKzlHdVF6SEVZcTdyU2ZhUmlKS2FFa2F1TFhvU3h2aXN2WWYy?=
 =?utf-8?B?RldkTnYybHFqYWhoc25mZkxVbll6TjVNTTJrbGk4akRBNFZqNFUxNThsbnVa?=
 =?utf-8?B?S1BqN1RpbitEckYya0NJbmxRT0dWREp4bGtIQ0FRVnprVnBqWHlKT3ZUU3pY?=
 =?utf-8?B?OEVMVStXelFGZHphYWUvd1daM01sZ1d2a3IxbTdPc3c3dzZKUEFYUGxhelZL?=
 =?utf-8?B?ZDV3NW1DT2MyR0pIamgyOGJsOHVXVjdVK1BkdDNWc3VrVUdNTDM0bEZpQkZ2?=
 =?utf-8?B?Y1IySEJsWDVtN1FxN25WejEwSW1OcGJ3UythVE9tU2tZdktPWXloS0Q5bWNL?=
 =?utf-8?B?Sm5NODdWQUpaWFpkR0FMbXJpWXFpNGJWMGVkM042dk05NllWTk9hc2xLd25C?=
 =?utf-8?B?R2FPZzI0c255L0huSzg5RkZDOXNQUVVLVTRmMGRkcHcxRko1eU9ITW9ERGtF?=
 =?utf-8?B?SnErb083RUpmUG0xQUIwUUVFV2pnVERBVXU2MFlLbGlMeEhPcHJkWCtkcEhV?=
 =?utf-8?B?UzlLamtFNnlHQ0tGTUJrZm9PcVFkdzV3TUp6TStHbThHaEVOdVRnT2EyZEUr?=
 =?utf-8?B?eCtuZFZLcmtwTnJpYi9wRmdnM2ZCWVFZOS9vRHBoeE1mQWpheDlhY0t4RnM4?=
 =?utf-8?B?d0p1Um9kK281UlBLRXQ1aUxRZEdySDJlYWpJYnZkWEVqMFdZdE9rR2JCVFdk?=
 =?utf-8?B?VkFqUWdGbU55Uy9nQllPcDJuT1QrOVBZU1ZQOUQwb25Qck1WVTh3dEFBLzh4?=
 =?utf-8?B?WE9KNEY4MlBVQkxvTG5uNm82M0VFbVFXZXpuQVhzajFyOXdGa21FdHg4TWQ4?=
 =?utf-8?B?UTlyTk5jZFJ2NkVUV0RGcDBFNDdVL21EdnZjcFh5WitzY2czRytKTE1EWllQ?=
 =?utf-8?B?ZTJFM29aZS92SlFpZ3lEUGdYaENpYWJFMDJKSU1LZ3pkYWRWWUxxZktsa1lH?=
 =?utf-8?B?M0QyUDQ5TzY0TERVTUgzUHZ5K21WVlUzSEJmZ2FtemFhelFZaTFTN3BLVXBv?=
 =?utf-8?Q?WbBySYzhUlsGNTdbL64g3yb0I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111df6c8-442a-4883-7eb4-08da5cd01261
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 08:43:16.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxw5CxzGj2cwnMiSA6Kc6U/3z9WJwFWKogZs+G+qxq9W6dKSe4Lln8crElGKl2MVvVZElZe8aofYZ+euOJ5Nhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/30 1:32, Laurent Pinchart 写道:
> On Wed, Jun 29, 2022 at 05:08:58PM +0200, Lucas Stach wrote:
>> Am Donnerstag, dem 16.06.2022 um 15:33 +0800 schrieb Peng Fan (OSS):
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> The provider device is created using platform_device_register_data in
>>> imx-bus driver, which not has of_node. With of_node set, it will be
>>> easy to support QoS settings.
>>>
>> That's a bit dangerous, as sharing a of_node between two devices can
>> lead to some reference counting issues IIRC, but then I also don't see
>> a good way to do this any differently.
>>
>> Regards,
>> Lucas
>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>   drivers/interconnect/imx/imx.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
>>> index 1f16eedea21c..78557fe6da2c 100644
>>> --- a/drivers/interconnect/imx/imx.c
>>> +++ b/drivers/interconnect/imx/imx.c
>>> @@ -264,6 +264,7 @@ int imx_icc_register(struct platform_device *pdev,
>>>   	provider->xlate = of_icc_xlate_onecell;
>>>   	provider->data = data;
>>>   	provider->dev = dev->parent;
>>> +	provider->dev->of_node = dev->parent->of_node;
> Due to the previous line, provider->dev is equal to dev->parent, so
> doesn't this essentially do
>
> 	dev->parent->of_node = dev->parent->of_node;
>
> which is a no-op ?

hmm. Indeed, I just not able to recall the issue I met before. I'll drop 
this patch in V3.

Thanks,
Peng.

>
>>>   	platform_set_drvdata(pdev, imx_provider);
>>>   
>>>   	ret = icc_provider_add(provider);

