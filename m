Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8535757C7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiGUJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiGUJim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:38:42 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50059.outbound.protection.outlook.com [40.107.5.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4EC81484;
        Thu, 21 Jul 2022 02:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJlQiFSn9ksb7OWhEnDYPozRCK8UeeKN1GvO2Hyhpqo2xJr2aLaWNHdw9OI9cTgFc3ys5P5ih++4pqG63Tfkyl6sUPSt3Mue2NMb84751pCwk1NbZVolXGX0MpsRJth9BVUkOOwBnL4jy1Gro+ak75cJBXti/p6aDTh6d3nDsnAoN+xmPaa9rHhVivEYlaQ8XlnfzFgC/jxf4rv62LyIbfP2RtjgvxnPPbFZMqNye6kte7s+mmDv4n9FAmYU7tCo+9nCtdQHxuhQ3vPYvF6w5NYXBac6ED6JFfuOXb/Dy9cshIjCFpYa5Dz76bRNhqgPqht7mpVe+3qhvRUfGKAVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwWeXZPIK8mAFd8gHS6YNrbZi1Wkh7SFTqER8vFCPV8=;
 b=NHZVuEGIs63GXZPJzhAyG/JZx9WBeTOOW0iqD5yCOem7YHDhgg7ItnX/zp2Du7n+ckMkDF/Gx7uKxhKpt73+wERPAzcMJXiaCoZZxLfFtt2q9ZbqQgvpbEk8LBeKheP5EmfZtT3dFL59eePd0h8JTJJBq7TAbNonIeHLhUMoZHJbagzN2XUuMy2hKMs5WV1z9Qub+wF8QgA6EGegZJmhZdE1F5+huVCY0QKSYWDtCNMXlPvWK8oNKNSCcYizXfqiOOPWfubz7ghobRj9f+QZLRkFmAo6CGMvXhwRRIkQliSiRf1mYsn+Gi7qtGOZefE4ICcxiVnZhdAsRBSjVHknFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwWeXZPIK8mAFd8gHS6YNrbZi1Wkh7SFTqER8vFCPV8=;
 b=CsBJ2DFqyIFJju4qq5iUOHdPBgpGvYHU/Lx21d7QQCr07mr182kRUmEpbRMj2HB4jqOJASh/cO0iL6yc0IC11YdzVBDcjGfPqQ3kRB4rXIdvWa6YBLpRV3AKHEm8TxLWuMttiy9TzKdquo67c/+FvPkBwMbZEDXGoUUZAxzCYOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VI1PR0801MB2030.eurprd08.prod.outlook.com
 (2603:10a6:800:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 21 Jul
 2022 09:38:37 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5458.018; Thu, 21 Jul 2022
 09:38:37 +0000
Message-ID: <4acf184d-3ebf-1b14-e921-0b0d5151b310@wolfvision.net>
Date:   Thu, 21 Jul 2022 11:38:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] Add support for the RK356x variant of the Inno CSI
 DPHY
Content-Language: en-US
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
References: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0190.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::17) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad74ae6f-84a0-4ae5-f76d-08da6afcc993
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2030:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZsentFGZXA3sgcmRXuL8Nok7By9rjyyh7hcv+tvDwxUtImzKy0odLCua7bTfqr3Tspfwcni4/wSd2wD+Le/hXB0Vmdx4FYRVAvElLENsGEvtO2I4wiXbmYOgCSqzfgvKtwnWPtStCndpFPT7zCnPdeF0oC0PDnIThj8UuI6g+ERAct1iRT3vih+3unRxadelcVbBx7hzkfhebVbWHaonjqZ4bPC4AYeyNOf0VrWeolQRu7rXPein7T9AMrsTBHlGdB8QW5bOBgOieWNSA3Zd78/FefGDJeb2EieqtxyHRnq4DffRxnXP5Byw2ErQZz5F65tW8sbLECCKnQOn7pqq1nEvFq8KRg1392nlJ7xMKk/tdd4Yt0t+G2slVb1eHzFHJLlkcWH0VJgzDoVJzRsH3eEoMWeN4Rlsu1knOky+XKNsqTy/ib0uyKKN4puR6pezZ7uoJpGHOk7vSHbP7rEpbWjflQsMdEnp7I0CqLLhI1WRWu4nr8kYSQy6cr6z8XuZPmACVpge17hjBC2/A68k2U4Cc84xD6R5G3r0+V6x1OUwd87BR+Vyb/NMGOrKVwwNRMlZ24V0wb6L9dmVW8egiHQCwOztjlr4ybgs7TNxjtvxqFpXIP6t4aOLPuhGeGZQTlMHhnB9TPrNpYS49HmIU4HcYOlTOfieTk1zFuKgGNZbJ2a94BOZhzDUuk1LO+8fewl2iHAIcjBl+wklOl/Xai+3LTrZXsA75hUW83vNjyiq2WRLA4eQuM4z55HzLA3izKP0LTEMASozCwCRHlewnTgSJvtLtI1ncbpXaOPVwlRf9dt3ZwaeB1oyGo8ud+YaxrN0GNGouHJtNxwk3TQHnx8sPllsHPy5oK5dleLfXLg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(396003)(376002)(366004)(346002)(136003)(6666004)(52116002)(2906002)(6506007)(6512007)(186003)(53546011)(38100700002)(31696002)(2616005)(86362001)(41300700001)(478600001)(8676002)(31686004)(5660300002)(54906003)(316002)(7416002)(4326008)(8936002)(66946007)(36756003)(66476007)(66556008)(966005)(6486002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXFpc2RoQjUreE9JNVRJaEpQdWZZNGZOemdJRzFZbDk1enJaWlJyQjBFR0VC?=
 =?utf-8?B?K2lGQ0pPczBiOGh0VlV1aHVXbVVqWWw0Z0dhMDBwWnl6UTdCNllYY084QkF0?=
 =?utf-8?B?NUZnOS9FaktRMFRrZ0VIQk84ZS9FdUZBeWNGN05DN285cUhtWEhtVGNEQUJn?=
 =?utf-8?B?SWYvbDdIVTQ0dVBpSGhvT2xtOVozY0JKOXV3TWNsQWdrdTZtVWVlWnFRUFBJ?=
 =?utf-8?B?OTRYTmY4QXpsWEZpeHJtaFE3Ni9UME1sdzhvcm9EK1Ewcm1PMFB3WFRncGdO?=
 =?utf-8?B?b3NCb2crTG9aQ3p5VHFVTnNhMkFRZEtWeHVjRFludzhZVURXZVNjNFo4NGU1?=
 =?utf-8?B?MWxhVnRENTNnbDFyTE5udm5QeVJNMTF6K3VvY0NZSy9rVDU4NGlrU2hKUk5p?=
 =?utf-8?B?Z3FVM01PTk5rdUJjcjZrWGs0U1BkMDdvaWY1eGVFZjdiQ1FvckU1VzNFVWtP?=
 =?utf-8?B?c2l0TGdyRDA4ZnBlZUdyc0R5b2lJd2RoVmsyWlAwZ3A3N2dpbVRadllqWW05?=
 =?utf-8?B?SHIxWkYwUTE5TGMyOG1DU0FzajdZQVIzc0Q2UkZzVWJDTnVjSWZTbVIxOWhp?=
 =?utf-8?B?S2NiYXNzRE5vSmRpTHBIS3JZOXJnZ1JTMHhUL0dRN3BMTGZmRnowdk0xdUg2?=
 =?utf-8?B?c1N1YXZwN0Z2anlmRlZ4b0xWWlRZRTdZQWlKWnZybk5ZM0YySHV6VWFzSzhJ?=
 =?utf-8?B?TGtQdkZ2Wno4WTdRZk5wSEdzMUZFQm1ETlNLMkpKRCs3NHJobllkRThUNWVn?=
 =?utf-8?B?RXpYNUp4a3hBUWpQYTVZWUV4akhNWjdFbGdxcVV0elQxYnZuQndNSXh6aWVS?=
 =?utf-8?B?d21oQVpEUWYzL2JRaW1KVzVJM0xtTGNTVWdvbGREbkVsUGJUNTAzNzM5L2dJ?=
 =?utf-8?B?NVMwTEtxR2FyaU9MQmJKVHZhMWlOZkRiQkY2ajNlc0JiLzluY2tlNGNIYkVo?=
 =?utf-8?B?M2tkaHBHejJUb3V4V0MxdFZQZHNKV1Z6NktaYUFralh2Nm9GcmJGcEsrcTRw?=
 =?utf-8?B?dWk0eGFWRzVVcjZ3M01NVmVMSkJRK05GWDFDRWZLMlFQZDMxcXZiMUl0aFIz?=
 =?utf-8?B?R2c3d1FWQldndUFuYXN6SmNpdlJ6ZEU4TzM2SW1kVjBsVjJteG1jWU9JbHJZ?=
 =?utf-8?B?THF2TmZudkN6S1pkTkxaUnk5WjVEWmNjTHJLa1RKYm00U01oUDNCMTZsbUZt?=
 =?utf-8?B?OEFDNXpIWGZJUUl6b2pLb01nN0RpdkdjbVFseDU5NUtqM0hZaDh4azRqSXhO?=
 =?utf-8?B?VktwOHBNMGExSHhzUVBvVFZHY0ZJVE1Kb25TYlIzNE1rYVd3L0ZQTXVua3g3?=
 =?utf-8?B?WlVBNEpYOUlwaTRITnBZd2RWRTlBd2JodTZTQThVQWkveUt5SXZiZFdlUjNH?=
 =?utf-8?B?d1JYeEhVVHFpeWhCQi83Kzg1elFEL3F1UzdaZzZOc0NKTGEvVEFaQ05yUWhz?=
 =?utf-8?B?aXF2dWNIUnhjaURwdW5pL1hHWG5SaHFJT3djYVZ5VnlCcnpqanplbVBWdTZL?=
 =?utf-8?B?Nk1Wa2NuOFR3NzFmYTJOMStiZkx2UUd1NC9rQi9pSlJkc0ltS1hMV3JyMXhr?=
 =?utf-8?B?Z0pkR0lta3lsaElFVCtBQUREQWJ1KzRld05LWFpBRTJhbVlCcVJ5c2xGZm1I?=
 =?utf-8?B?NXdCV05CTXRjV0pVeUVJbWtQSXVRNWlVM1ZyVkVhTDduN3p5NjFPVWRQZTAy?=
 =?utf-8?B?TUhFN0xBL1lRd2VjVFBhU2hrY0VSTjl5TUxJVkdFZ2l1SUxERTBkS2ZjSzNO?=
 =?utf-8?B?WlFLL1dPeDdKRTlyYm9PMjE0ZWc5dGlvd3UyT1kxTGhiYkxmZTV5cDByV1E0?=
 =?utf-8?B?Rmo1Vk1UMXVzUzluQVBRdUZReXh2VnMyUlBGbzNRWmZKNmlsMHhnSGdFT2dI?=
 =?utf-8?B?NUo2d3psdUp1aTZoY3NFZ09HcXJPNXFTMDZaRldjU203U2RHT0l3Q1BxMWdk?=
 =?utf-8?B?UTYrOUVpd1RZNUNsd1JlczZTcGFZbndzcWpuU3hvc3pSK0xNNlRpSkhNbUkz?=
 =?utf-8?B?QTRuUlJaUmlCQUtjVHVHbzZtYllDa1JMRDEyYitSNGJiVllzQ09Ubko4aHhC?=
 =?utf-8?B?ZEVDNUdvK2MvaHNxQm5SeGx6c0w3b0Q5Z29HWkduenhzSkRwaUFXL2hacVZ5?=
 =?utf-8?B?cEJHeE82ZEFCUnloOC9GZmczTmw4TThQNW5zbHRGZU11WFg5ZExuRkRWTXNq?=
 =?utf-8?B?SUVhRkJLdURodHpmOHRvaXlxSWpiRFlzWnJQNjIwZWd5RExxT2pNejM3ckJB?=
 =?utf-8?B?bDBtbVNaMXNGOXZRalFFSFJZNTZnPT0=?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ad74ae6f-84a0-4ae5-f76d-08da6afcc993
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 09:38:37.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +piiyKQE1BNJwmvZo/OavtW/u0aiHoYHeFIKZ+pPBkt56zXJl2XFd1BAtDLk4sqtcpU4nNhKmlbWIc3fEbmKUOqIOUFOrq+DZYb0eTQ7zQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 7/20/22 11:15, Michael Riesch wrote:
> Hi all,
> 
> This series adds support for the variant of the Innosilicon MIPI CSI DPHY that
> can be found in Rockchip RK356x SoCs.
> 
> Please note that only the basic operating mode is supported, in which all four
> CSI lanes are controlled by the Rockchip ISP. Split lane operation (e.g., two
> lanes to ISP and two lanes to VICAP) is not supported.
> 
> This has been tested on a Radxa ROCK3 Model A board together with an IMX219
> camera sensor and a patched version of the rkisp1 driver (with support for the
> RK356x variant V2.1 added in a very crude way).

If someone would like to test the patches, I pushed the hacks required
to bring up the RK3568 ISP to

    https://github.com/mriesch-wv/linux/commits/feature/isp2

The following commands are required to set up streaming for my IMX219
module (Raspberry Pi Camera V2.1):

media-ctl -d "platform:rkisp1" --set-v4l2 '"rkisp1_isp":0
[fmt:SRGGB10_1X10/3280x2464 crop: (0,0)/3200x2400]'

media-ctl -d "platform:rkisp1" --set-v4l2 '"rkisp1_isp":2
[fmt:YUYV8_2X8/3200x2400 crop: (0,0)/3200x2400]'

media-ctl -d "platform:rkisp1" --set-v4l2 '"rkisp1_resizer_mainpath":0
[fmt:YUYV8_2X8/3200x2400 crop: (0,0)/3200x2400]'

media-ctl -d "platform:rkisp1" --set-v4l2 '"rkisp1_resizer_mainpath":1
[fmt:YUYV8_2X8/3200x2400]'

media-ctl -d "platform:rkisp1" --set-v4l2 '"rkisp1_resizer_selfpath":0
[fmt:YUYV8_2X8/3200x2400]'

media-ctl -d "platform:rkisp1" --set-v4l2 '"rkisp1_resizer_selfpath":1
[fmt:YUYV8_2X8/800x600]'

v4l2-ctl -z "platform:rkisp1" -d "rkisp1_mainpath" -v
"width=3200,height=2400"

(adjust to your camera module as required). After that, I can stream
with, e.g.,

gst-launch-1.0 v4l2src ! video/x-raw,width=3200,height=2400 ! waylandsink

The image quality is horrid, of course (I think the ISP is not even
debayering the sensor data), but one can recognize the objects before
the camera and it can be proved that the CSI DPHY works.

Best regards,
Michael

> 
> Looking forward to your comments!
> 
> Best regards,
> Michael
> 
> Michael Riesch (3):
>   dt-bindings: phy: add compatible for rk356x to rockchip-inno-csi-dphy
>   phy: rockchip: add support for the rk356x variant to
>     rockchip-inno-csidphy
>   arm64: dts: rockchip: add csi dphy node to rk356x
> 
>  .../bindings/phy/rockchip-inno-csi-dphy.yaml  |  1 +
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 12 ++++++++++
>  .../phy/rockchip/phy-rockchip-inno-csidphy.c  | 24 +++++++++++++++++++
>  3 files changed, 37 insertions(+)
> 
