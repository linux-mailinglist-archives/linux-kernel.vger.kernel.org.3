Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5058D1C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiHIBfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHIBfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:35:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB09110E;
        Mon,  8 Aug 2022 18:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0MI9CvCARjedyRLFkqsA2b58lnfQCF5Tg/Vp/Obx/bjnwg+TpCzf6dadPQ+/qFkLdIRcoDl8L4X7kyUmM1p7tRgwF5eT3czVMpOiJHHywe/k3rpBsau4plpkngfKkquzZSCWeLe6rNmrfEbUB5oTmSQxV5sNw+hyj3lFzU0prSTW63BkmMGUK1rgnHzj24GMA+y5YvLAmkxjLZ8bILBtGRwXg5UkH0+iuH8KOMYSkA2GcLCMwuv40uZW0Fkg/n3vfj+QKqF2Zgh/mYnXY9oUPuhf6IW4tnv8gUgJb5TFV9Ae+zZgRPJXJdVdk61ejEIyJSqaeoUVy50Ih8upmFi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoY4TypQrRkuUx78muZFuQI4VoaESjh2h8CMcnUZXH0=;
 b=CRSFbNNXKI19PVFi/x3NrTmE6NCwaC1LdS5vVnJR2gicz5p1TqdE7JnJMLpcXKV+3xW4+LLbYehJODToXB7heAX7hYuOLxRYZILO8B9OthOAa5LGtfFa6RnrLs8RhabmjqSaI0QcqL991PSIVLE8tsXn8Iu7HSSr3MlspR6y+g65U9e+Nhqx/BWu0P87tXK9JNh5Qz8NkZlsfsEHpKITE54f1SvVlAhvW0r6miCEC6e6HW+lWUonfBwcAXIZa6mj9Avt/otz10hRsABsbdovHC4YWS73DEF343xVxjZKtabmqTY2frtqMIv0phBL08K4tcmug79ZMjiktkRy+Ofz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoY4TypQrRkuUx78muZFuQI4VoaESjh2h8CMcnUZXH0=;
 b=RNfUlYyLlvx8ASMdGcHav9eJ4in2YGdnBu6zeoIpBCrPOWhktjgimsQQCXBK9wh3YOCceSKAiI3XH3xDplXiHdksSyDpQIu/ZsB6IPWqQOgRQ993DOjnHZrt6NAT+2d2R024qVP+Rvrf58CUlqfnmV535SBycI/07zINFbxFZvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6273.eurprd04.prod.outlook.com (2603:10a6:208:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 01:35:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 01:35:28 +0000
Message-ID: <b8b01610-ba76-913d-d195-b11ab8925fd9@oss.nxp.com>
Date:   Tue, 9 Aug 2022 09:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V4 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu
 blk ctrl
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 916400ac-de7e-4c66-301b-08da79a7705b
X-MS-TrafficTypeDiagnostic: AM0PR04MB6273:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2eryUUBblUZ2HOqAag+XaDql5zU94B5xrsz628hgyWu5sALBfbp5JlLiG6lqbhL5Gk6WTQRfdWnYZDoBaHmnRFH6Euua50d+Lo4clVcseIcf7WEhbgu41TPodKn+6qLZRxnDy3e0YqhlxRLAMS2B2hacUOML6vr/w42L3yImtZWyQzC0CvyO8o6pdrfWGyVbSIYLtfIQkC6EbaP2qOnf8QomSedFzDJiap34ceMEfB51l8JFcfcnEfYtZB3x6i82e4kAwjp8lxcDB1zNVJU9lbe8AQ4gRoKsld9h+AMfqaE0/wIdNy0KanuSUi+MplK8dylIK5LvJFBdoDPx34td89S3Zn96dFwokY3Z3zY3u3F5iibCZHhwLzrxj8gWxSQAWLU0SQH+DdI1DqK5LvgTJ8PXaTN4mOAa19pWpbziQYFOeWfWiEHkX007Ce8Hpu1Qrg+cqD7ZcxZ4kTLkUifZFxnTDQzFzXxMv5/y6iYBAzWQSeNLHLengIk56E/sYx4vagBSXPe4rPvvTLajVy+ZBjuOHpBATZenHR5B4vMYsh33c0v8b/h5JUacGG4TxXu4tbEPvobWivINAMOYiVkdcKlj0M6z/OMtMvMWrjWs/2zg37rypO825VSHc7jT/bPYQo4e/L7lDhMYQhbmlDjlm7jWBcCYQZVZO3Qo/mtPH0v/lyVogYbaFvdrLIAPUkWgNLno6F/7fPU79n0Fm91V4nmHFUHpygtShysuFJcKCg9WS/QeaGuT2mRfW4b9lNZz5J6BqdUF4L1ZXEcAyNw30ghiXh3lUM1U28/YzeJK8SgF6TRasKXJqIMvspvSnIfaup30BPB3JTijsBGsbfezwHNOsqXLSWhER6Artd6Gpce3LJa3E+GXl5sqbGU+Ml+0P2TLdq7XUOmClnxCliK8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(52116002)(53546011)(2906002)(26005)(316002)(186003)(83380400001)(6512007)(41300700001)(6506007)(6666004)(86362001)(31686004)(2616005)(31696002)(6486002)(966005)(7416002)(44832011)(8936002)(66946007)(66476007)(66556008)(478600001)(5660300002)(4326008)(8676002)(38350700002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V055SW1QelRVR1JmSUZkZnNwYTZ4aU5TZjRXcUZqbFZZNGcvY21Iayt4cjdO?=
 =?utf-8?B?dzRuQzVOZlpJSXBrSDc1V04zdm9USTdFN1RaREI3MFRLbis0N1dDOC9BWDI3?=
 =?utf-8?B?VGFJQnpENE84WCtCcGlycFQ1ZWJ6alBMZW1QZ21JREF6WUhPTm5pcCt6WVV5?=
 =?utf-8?B?aEU2L3hPUFBDTWhJd1Mwc2ZGVk9TSE5lLzlJQ0ZKS3cyYm1JTlh6c3Z5eXIv?=
 =?utf-8?B?SzN1VHRsUy9BZjJuNnE4SThSSlkvV0FhR0E1M2cvR1ZRRG1hY2hCVm1NeENG?=
 =?utf-8?B?am8wQVc5OGtQbGlSQXhENS9xc0N5RXRYa0p0aDVqNDVmeHUwMmpLM3NjcWRC?=
 =?utf-8?B?S2dvcVhpcFNHN2c5VXFnczVwbGxPbEo5M0V4SExhYjUxbnFKRUtOWndRT29P?=
 =?utf-8?B?MjRyZXVVcnE0VzRaSmNIV2oxQlRaUkVvZENiT0l0dXZQcng3RVhiaWZDSlhH?=
 =?utf-8?B?RlJKZVJ0RGttNDl4bmlXbDBRdGd1WWpDTzhRQWpkaWxBb1NnS2ZxZW9TMGJU?=
 =?utf-8?B?OTBPcHFkVVMxcXBmekVsVytvYWJMMTFKand4NlVRWFI3Z041OGE1S1J6WFBj?=
 =?utf-8?B?TlcySVp3SzdQdzdKa1liSlJDelZ0L3REaWVtVkRWMTFLeE5HQUJSNUtvMFpw?=
 =?utf-8?B?R0J5emZhOEkxZ3hYREJLWXp2OHJCNmc5TDJaNXBLbnlEMlhaVEF2K09BWWRW?=
 =?utf-8?B?QXFnbHlSVzBxRFZ6OVBQbU12SG00VkRNQ1JNb1FUNEhTekE0UXZ6WHhKV3py?=
 =?utf-8?B?aFZuUDdqWGRJcmtQY0l6VnlSQS9CVm9NZkpwRngrdFlQeXJ5OEpZZitRVE5M?=
 =?utf-8?B?cUk0NXIxOVhvTFhzVVBQR01Ia1pXYmdLY3lQbXVnZGYvNHFMZ25vd1ZDL1M5?=
 =?utf-8?B?bW5lQWExQk5nYWw3RnAyV0s3YVNEZXVMYmpkUVVDRkNzaGpLN25YQWhWK1VO?=
 =?utf-8?B?Zk0wQlB3bSs2ekVlNlpHeDBiZU9yUTBIM1RGZW9vTFBNaWJ1dXdTVklYUVNE?=
 =?utf-8?B?elF5eEZWRjN2RTZNOGdWaEpmOWdJZjZOa0MwZUIyZ2RLYS9Oc0lRdWNrTlRM?=
 =?utf-8?B?UlNkbkV1UUM0ekxkQzZsam9yZloxaU9naC85b1RSTFd1dW15SE53M0t1NDlr?=
 =?utf-8?B?dFEwTFVpRkY0QWpPdVplTEkrdHU3dVpSbFZ5M2NpQklTU2hkR1UxUW1tL1BP?=
 =?utf-8?B?Uy9nWENkVER2U2gwQXdOSXBadjhiQ1VWVmkwSzR1RWRwYkptLzVXd1Fra1po?=
 =?utf-8?B?L3JBM3ZNanVqamppQVBJOGE3akFDWGtSUVByR1owNmZNbUhJUDB4WnM3aFpq?=
 =?utf-8?B?TVdUaWl3RHF3VVhoYzdqYUdFZjFHT24zSGlqaUVnbWhpa3dDTEpja2VZRXBi?=
 =?utf-8?B?MnVNRkI0VUtlcGY4WXlBQ0FhdTdYNklvQjJqYkFvK2diWUk3cCs3WnNpUld0?=
 =?utf-8?B?eHhHVjg4M3R6QmhLZU1CMVhjY3BCOFJvR3NjK2lVMCtYaUIzZ29oeGZ2S1FP?=
 =?utf-8?B?WlJCWlg1NTBvUkUvQ1I3eW81NWI4WEQ4YmYvaTZmd0FDQTdhM05lcmFWckdv?=
 =?utf-8?B?akZmdTZMV0wxM2JqQmp6MTJ1KzJvUmord0VZUXFlMll3MzIzTXVFT21aNEh2?=
 =?utf-8?B?VUFFT254Wi96bHJ1TFJnbTlVNEM3eWdBY1FkVmFLbDVOY3Z3RUlQaDlaWExw?=
 =?utf-8?B?RDZjVHdYWGUzZXcrcm9CRTJpVERUZDV0TGZOVmNYaC96YWlaOWpIZGZzaXVP?=
 =?utf-8?B?eDdRdXdGYzlqMnBjT0orRFZ3TVRjTlVTTXFQNEI5QXViV2U2WEFaQXpyVmsw?=
 =?utf-8?B?aXJ1K1hvSHRwdDJQSEpIUG54NmxTa2h3dmNGYUs3OXd2M3lsQmUyejJoZU9F?=
 =?utf-8?B?amZoVWZKdlc3RytOUzM4RnJad1NpRDRQOGdnQnBjckRac1lKSnZoeXNWaEMw?=
 =?utf-8?B?M0hHZ1NmRXRzMjMxVlBOZFZIN1dSZ3lWMS8rSlptUVVUbkNSMXVYa2tmNjRQ?=
 =?utf-8?B?VXgwK0MzM3N2TDNZK1JmM1lOckpYeVdrN1g3ZkRJbk1BcHgzbnJHeENDdGM1?=
 =?utf-8?B?RGo5eFJHc1hTb05CUWxOR0huOWtjaVRGMk9sak0vRnV4dzFnK3AwL2Q0cFNv?=
 =?utf-8?Q?hLCkFIQTsTpcXjrqnXwcpA6EV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916400ac-de7e-4c66-301b-08da79a7705b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 01:35:28.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTIkYIt7giNdEPdYeMFl48pdNzDDXlGV81FxsuRIDc1OCItjEO/B4pcSY2HWnEXZeTbsMDJ2Qj17y25QAmGlYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6273
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Ping..

Thanks,
Peng.

On 7/22/2022 8:57 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>   Add R-b for patch 2
>   Add a new patch 3 to introduce interconnect property for i.MX8MM VPU blk ctrl,
>   same to other properties, i.MX8MM/P could use their own names in patch 4
> 
> V3:
>   Per DT maitainer, add a new patch to clean up minItems, see patch 2
> 
> V2:
>   - Add A-b from DT maintainer for patch 1
>   - Per DT maintainer, I added description for items. To
>   make it consistent, I also added description to i.MX8MM.
>   - Per Adam, change VPU H1/h1 to VC8000E/vc8000e in the patchset.
> 
> This patchset is to add more blk ctrl support for i.MX8MP
>   - Add HDMI HDCP/HRV BLK CTRL support
>   - Add VPU BLK CTRL support
>   - Add PGC VPU node which supplies power domain for VPU BLK
> This patchset is based on:
> https://lore.kernel.org/all/20220708085632.1918323-1-peng.fan@oss.nxp.com/
> 
> repo: https://github.com/MrVan/linux/tree/imx8mp-blk-ctrl
> 
> Peng Fan (8):
>    dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
>    dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
>    dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu blk
>      ctrl
>    dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
>    soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
>    soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
>    arm64: dts: imx8mp: add vpu pgc nodes
>    arm64: dts: imx8mp: add VPU blk ctrl node
> 
>   .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 110 ++++++++++++++++--
>   arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  45 +++++++
>   drivers/soc/imx/imx8m-blk-ctrl.c              |  43 +++++++
>   drivers/soc/imx/imx8mp-blk-ctrl.c             |  30 +++++
>   include/dt-bindings/power/imx8mp-power.h      |   6 +
>   5 files changed, 223 insertions(+), 11 deletions(-)
> 
