Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A137C56AF45
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiGHAHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 20:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiGHAHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:07:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD736EE92;
        Thu,  7 Jul 2022 17:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI213Wz/ajEfnLTIzjtg5QPqT5US97352mNhpB57fCiE+A4lcpJ/4htfENeRnBwFVdgAZuKRmkhQgafNSBuFrkCKDQ/gZX49fTF6WthuCG7ExVoQwpxo8FOcWQBdxehO1MCsmNd4I4bu1l1IJbWGJsjW8rCtp+MutjGjY/YphpUoIv8JoHs+/AldzFWH7dgV4+RvOIjC8//lQUcEFXMAr5mizlY+IRbIuu9CWAmTQP8KWmTB0H5yu10H7DROxT9LcQ+b9RCQXi+Zg8BglJ/e1eADxqrjX51sQBpFqj0bzs4ihV85ILKtLmmoNozY6uZsjfZgBNUYbY1bYIgIRXLHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqU+lZhWQnwXIxhgEhzz40nmIDc4TmLyRtYfcVB7xa0=;
 b=WhA48ZY8Hom28WLqnMWrndzPSEnk2obg6DD8MMoCh4bDZmoCtbWKbguTIYOs8n7dQQKMlnOXuhFvZjZ4ToxqaHJI8rzHiJnGloBguR6jmznLPsUMfejzcodKJXIDhLpDZ5xIGJDvB7W4z+gqiTdBJn506JyZn/XOaJVY4jdVEQf6oxhuQm0T95moCQyjEsh4B8JdVKRikZV2hLkZXcdaCWpWJwUQu1m0YxuTg1VplVk6ml538lkHCRYzMe64iUaC+OpLAvCuvHQo5ltQv2IoJUeK2qKUPm1wLZSoZ53MsXWhcMdRiQ7daXW30K78IsX77X1aPQRZIqSKyrwR6norOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqU+lZhWQnwXIxhgEhzz40nmIDc4TmLyRtYfcVB7xa0=;
 b=OnTR6dnXnpG8Eoz7hAg2rvN/MK4XNmJ/oedHxWE2Kx92S4uQgN+1r4YhfCoy5fJBGMRapYFk01FF4OgS31PaL3k2SqFWxlEYeBMlo1jTBPTExW2kPR/pn5hchTA/tBAD3r0Vrf9sL6fwaA3bg0uswmwoLu2QpDlIAHMYqjLV1iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 00:07:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 00:07:12 +0000
Message-ID: <48cb64bd-fc0c-a385-f1b0-765ca17cfbbb@oss.nxp.com>
Date:   Fri, 8 Jul 2022 08:06:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V3 6/7] arm64: dts: imx8mp: add interconnects for media
 blk ctrl
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
 <20220703091451.1416264-7-peng.fan@oss.nxp.com>
 <20220707113851.khi42m7pgx23d26u@pengutronix.de>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20220707113851.khi42m7pgx23d26u@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:300:5a::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2ee46af-337f-4fcd-2268-08da6075ce40
X-MS-TrafficTypeDiagnostic: PAXPR04MB8670:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMxx4qiobEVMvsiW8ShYnCzk86Ja7M9efnyDTIcaOudWbVIVifVrHuvTkKFgn/fVMDUYwXge7Gw06MLNnVJZTYr9zJTP0/KpzrVOOymBMbLrbJd81K8FxyP9ibm6OM4e4m5MZp9yKdAcuFsz8U3O5nHzs+LolSd5mvPgsEqzqWxcsz7IBILXdh7L4XPYAANrDeNO8D1XmIx2K0/7TtMcAYOzaTqODwp58pecSlPgeU385nTUKZT+cpwYSEMuu+PURCSadPLiT7nx2q1IIJT/s266CbK8L24/2u+MwWMpT/9cWdQj+SNS2eWrZ+E/n0YU6w8uca+JgxoPgmCsS0l0+EDMzjVIofnMMpjJbSCNXyPwGrbWj/xHiVGQZMoGDlPWeBYtmRy6vFK310cCEBjHT10FZUw8rdl7hcF1mWOJQyozs4vsj7NYdYJ3NC65SBLWVKfUQBRGPJTaGZhj7iyeNH80AA7Qm3h5AxufsclwAQe+dE7WjR5SkicWo+s4jd9EXHTdFoY+ND0UNkFCUOIogzRTB9F2ZJ9x43v7928ZxoUerar/6q5Rzc0eGP1L1F8MreVb5PRt6/yfk6CdtDR0ha+xMLqnLI57YDi6gWpT5dH5xdtMyI7nXtQV4NmICPENwtY5S24Hqg5KvSWBUUeL4r7B6FfT0qDur5jZXWMZBGqRbHw+WDbiOtr4AMI76oOjXDabCkM4B4WdiwiKzf7HLu8lE7TAx9m2zagvUS0ng4NlPzbjXEr1Zkm31cShylrWp01GSPsD2cG3/nG3Vr5/ZFPYG1/Nv75RDF4rEwnge/1fY6CgFgvjk3+NoEGOl7TKBAqYujFGHZ0WAPID3Z56NvD7QamimDXHgBAFmimnydevOT4fNnW8Pqqj5XdyKANUbPE3b/fvyFCeR84LRNOOjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(5660300002)(44832011)(7416002)(53546011)(2906002)(8936002)(4326008)(8676002)(83380400001)(41300700001)(86362001)(66946007)(66476007)(38350700002)(31696002)(6486002)(6916009)(186003)(6512007)(38100700002)(316002)(2616005)(6666004)(52116002)(478600001)(31686004)(26005)(6506007)(66556008)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmJKY1N6dGhnT3Y4THNUbXh4aDNaSEl5SzVrRVd0bWNEczJKYk92V1BJS3NJ?=
 =?utf-8?B?SWZibnNPcjJHd2VCd0FPWk91R0FTQVV0M2tPa0Zmb05sTjlSM2RvdUJCSXpI?=
 =?utf-8?B?cnhkWUYwYkpDcHZiY1ZrdmxFY2JNS1V1Qitrd3BoVVNGb0ZHNGtkbk5JejNm?=
 =?utf-8?B?TFNYTHdZWTJCQllJUE5MT2piV014a3NET1cvdldsLzZMam0vcmdJWGxQL0hp?=
 =?utf-8?B?MEpqb0JGKzU1S3o2eGtrdTBzWG9tUmN6Rm5LOWtjNlk5aEZCemJYRTNyalJO?=
 =?utf-8?B?U0ZHSVlWdzNDNmRPODRRZWY3ZGk4MnJ0bmQzdHIzUlllcXg2azRHTEpsbldu?=
 =?utf-8?B?LzRCc3cvdmJ4ZlpsNXVNZjdQUE1sSm5tb1lTMHFXOUtFRlFQdVk2VXc0cGNO?=
 =?utf-8?B?UnQ4YmZUZkE5RTBya1lLTHRacW9wcUdhMFBQK3ZHdkNvKzBCSGtRbXkyVG5a?=
 =?utf-8?B?NWpUTEc2Zk1SSzkvZkFEUmpkWXFiWXgrUmhPSkNTTTY4Z2dMcnF6MlI1ZGph?=
 =?utf-8?B?THdPMloxUUt2d0U4WEdGTkQ0UktlQUJrT3IwSTNzMU40NGxQMm9TUnJ2UEhY?=
 =?utf-8?B?MUlYWGNib2NYR2RFK0JkSmp3KzNEN1ZBZjlrTEQ0ZWJWVlgvUktnTTd1a0hF?=
 =?utf-8?B?bm9kQzkvRFdENGFqa1RTNHcrZ0ExWHBGc1JwRTU3N1lQVWZQUVd5Z2pzN0do?=
 =?utf-8?B?QmZWYkxMNER4NWUyOTQyVm94OUZieGhOWEl3V2NSeHUrakkzQmVUME5XQStx?=
 =?utf-8?B?dS84UURqWTN3VlBTRGppamdqTnF0VTNPSXNrT1ZwY2tLZWZnNWw3QXRzUU0v?=
 =?utf-8?B?NGZPeSs4UDhXNVI4YzVqS1BJR3NSREM3VTJZWWg1dVd0c0hQNENyaWZOcE5r?=
 =?utf-8?B?cDFHTm5RNnVFc2VQNjBZMncxY2t1Q2FzMGxxZEw5a21KYWVDbFp0TzQyc1VD?=
 =?utf-8?B?NDZhY1ZpaDMvRUVjRXo4VWwzZHBnbmtVUjg0SVhlNFFFeWliYkFmaU5vaGhJ?=
 =?utf-8?B?NkRzamNqQW04ZGpyVlVkK1VIM00xRGVQWmJqZitxcFBNN0krQW0ydW5CVGNt?=
 =?utf-8?B?bUtsUUk5WGhLRUFtZHNYdlZsZHRIRGQyVldxZnFVMFoxVjN3OXpLSnA2MEdW?=
 =?utf-8?B?REdZMlJOQkIrSGxhaWVpc1VtWjBjVUlMZlEydWRWSVFIWndqY3JOWmxrcnBI?=
 =?utf-8?B?RjEyYTg2SnZpQmd0cXoycHE1akNXOUI3eUoxcUlTVTBoUlNrbk9RaG1oRkNw?=
 =?utf-8?B?R0M4OTFodWcwN1pMWHQzNFBpLytZdXY3dnN0WVdFWUdhcFc0RXBLbWVRUDVY?=
 =?utf-8?B?SG9OTDliTVZHcFo4K004NVBXOFRkN1JldmR6Slp0bzZjNFVrWUtlTDFBeHBa?=
 =?utf-8?B?NVY1TEJqaUU4bFdSNEtaWldYelp1REkySjJKV0I4MlI3UHgrZWx4ZkVoTVV1?=
 =?utf-8?B?RTRaWlJObWNISjFRNVUxSEN2eUZUU3FVVUlJVlNrck1HUlZXSzUvbjQwUU9q?=
 =?utf-8?B?SFFaUXIreUNQZGRsVmUrcjhlS3IxTExycHRkMG1IdnEzNEFsTUluZDBWbVBM?=
 =?utf-8?B?QnU4cWt5TFZCSytEajc1L04rNnp0L0h4ejVJaUFlRXhtemMxYUpDRHlDeWVk?=
 =?utf-8?B?TWZtdWh6d0RiTG9sMkt5WnAzZU1CK051RzdoazFRWTFMRFJWQlcyMUxzbjZx?=
 =?utf-8?B?V3c1eEh0dHU2Ky9kNHMxMjVQR1dZcnE2MkpYK2xrUEJST1JwOFpHdFNoRTlp?=
 =?utf-8?B?cy9mUFU1ZHF3cDRCUWR6UFRVZlo5NDVCWGZTMXJWeGUxUTNWVVl5VTJkWFV1?=
 =?utf-8?B?ZFE5UG9zWUJmVW5LUCtOMU5jK2h6MVB3bm9DY1lHaVJpWHN5aGZIalBvVnZZ?=
 =?utf-8?B?c0w2a0xZM2JYZHBTVlhqa0R6T0NjSysyN1FWTDg2a2t1SVc1UVZiTDRSU2Jl?=
 =?utf-8?B?UEZpb2V1dWxEV3o4SUZNMU1XQzU0cFlqZW92aEZVVEdQeXRQZm9rSlp6b2tH?=
 =?utf-8?B?aXY2czhqS3lTSkhLeU5pSDRacXRnUWxaODZVUGJxbWx5L2JkRHViRng3RW95?=
 =?utf-8?B?eEdTalZqRDBEVzRtS1lWTmRWV3RkcnVjaGR4RGNlajVBWW5rRmRTYUdjakVx?=
 =?utf-8?Q?yx2ZsBgsk2m3x/4YAl6QngivS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ee46af-337f-4fcd-2268-08da6075ce40
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 00:07:12.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcOjUQFEpXefCv47vNAw1rn5yrJjSRk0ysWcI5fr1X6vgmu/inWdWi0EKd9JWRkL8EmW+H26WolhhiaFcsKMog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/2022 7:38 PM, Marco Felsch wrote:
> Hi,
> 
> thanks for your patch and the work on this.
> 
> On 22-07-03, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> Add interconnect property for media blk ctrl
>>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> index 13a2ee77d3c6..08bd57742294 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> 
> Can you please add:
> 
> #include <dt-bindings/interconnect/fsl,imx8mp.h>
> 
> else this won't compile.

oh, ICC maintainer asked me to drop this header when adding
NoC node, and I need to add this header when there
is user. Here it is, I will add it and post a V4.

Thanks,
Peng.

> 
> Regards,
>    Marco
> 
>> @@ -1066,6 +1066,18 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
>>   						     "lcdif1", "isi", "mipi-csi2",
>>   						     "lcdif2", "isp", "dwe",
>>   						     "mipi-dsi2";
>> +				interconnects =
>> +					<&noc IMX8MP_ICM_LCDIF_RD &noc IMX8MP_ICN_MEDIA>,
>> +					<&noc IMX8MP_ICM_LCDIF_WR &noc IMX8MP_ICN_MEDIA>,
>> +					<&noc IMX8MP_ICM_ISI0 &noc IMX8MP_ICN_MEDIA>,
>> +					<&noc IMX8MP_ICM_ISI1 &noc IMX8MP_ICN_MEDIA>,
>> +					<&noc IMX8MP_ICM_ISI2 &noc IMX8MP_ICN_MEDIA>,
>> +					<&noc IMX8MP_ICM_ISP0 &noc IMX8MP_ICN_MEDIA>,
>> +					<&noc IMX8MP_ICM_ISP1 &noc IMX8MP_ICN_MEDIA>,
>> +					<&noc IMX8MP_ICM_DWE &noc IMX8MP_ICN_MEDIA>;
>> +				interconnect-names = "lcdif-rd", "lcdif-wr", "isi0",
>> +						     "isi1", "isi2", "isp0", "isp1",
>> +						     "dwe";
>>   				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
>>   					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
>>   					 <&clk IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT>,
>> -- 
>> 2.25.1
>>
>>
>>
