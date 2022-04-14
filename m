Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2ED50175F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357218AbiDNP3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiDNOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:04:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11C43EA95
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6tf+LwPemmOPhdfRjQzMrewDOkYsf1gfraWQnrbTx2gh7t2aeygv5Vp07fnqF7dUn+LfVLTSMo8asdoH6ZIawEUlh8Pjh4q0RjZuJNlU5Bqu+21yFDQod+oapYyZ3P7CJzklAIYA5rVBQc5dZxQKEXdKSplyboSHRYt0+TjDzHmlctRxPLUGv7mpwMfIQ6ErznmN+R4RoANAZ8KAH/mLDsKiGxPFJhrJFWZjKQ1jbO4o/oFubFzfDQSepXkPpxup2KynB6wWiZ/7B9SNiECrAcwoC52d/D0Q7mlONEL3qxZVbnWly6gUlE55SRyhQo5acsUTVyxVGVvsEOxjlNAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6WJG3z7+A6PkqIESPLap30LmEklT7FiyKydSqU2cVw=;
 b=eXZkyZSMZR1pEeqcz3CqdiiZx0VQXc+NkTRZyBIljodoD6axUWXOnvPG2NHS+qccTr68FUMP3uwExo581SDRbWILIroIs/1E9T1lINaJVFC2Q1eezuOpZv53MCu2crC1ilhtWSooDNoEiH79yg+dhTWkoQMhylOa5S9kJesr+QExUEQCTtIoq+3aNeB203G/5268wyjLK+CWtdvVHCJWeVhCG+vX8pzbgv/R0bp3NQb0IjDATFtfJWRCkAeCZMH4TyFYbRvauMioSUl2ddHbKuKpzRqv8YfWKwlgGrurE7/V2onhGAnkiwQ2tubgAfKKhLr4jJ63T6CVShZqIAoLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6WJG3z7+A6PkqIESPLap30LmEklT7FiyKydSqU2cVw=;
 b=Zr5BOiKnbhvUI2noTgYFMj1nqJqfeyFt9ZIi8VVPrK+m84nYT8w8Vv2KQPnan24Qovm12JdvKquu8yhn6cWHR4IyB9cx9nz0Xk+sgc1ggtsTaf9ASxIe8kS6DJpTG9EsYM1wNyjYsHyVDSf/XEjbwosK6aE4atMTEnUCdpGsZUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB9PR08MB7116.eurprd08.prod.outlook.com (2603:10a6:10:2c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 14:00:32 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::3de2:62a:3915:9d6d%7]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 14:00:31 +0000
Message-ID: <8b67b7e8-29f2-49e0-ff99-5a13e73f4b62@wolfvision.net>
Date:   Thu, 14 Apr 2022 16:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/6] phy: rockchip-inno-usb2: RK356x OTG fix and
 enhancements
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20220414032258.40984-1-samuel@sholland.org>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <20220414032258.40984-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0158.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::17) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ed427eb-ad00-4a74-17b0-08da1e1f2367
X-MS-TrafficTypeDiagnostic: DB9PR08MB7116:EE_
X-Microsoft-Antispam-PRVS: <DB9PR08MB71166DF27DF8E78132B120BCF2EF9@DB9PR08MB7116.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVTjAHpqRoRuCn0SYanS+8VViFr3hG6AKVY3llnUw2aaokZUkcu9jIKSCvwrgjcZ3DyQryVEjHK9VpknJfE5QYkJi6i2fpb6AbaDSjcANVizr8nPq5xkSprQxNLOAtP64OsEvC1LIj3qbA6/vdppfZVkplxeUayDwT028C3UzsPIJZswJd4LXuMF/m2wUeOK0+voiAby5tlF0qNHfLokUMqqEXeY7J3wcJEQR0DeIsF0IlIwvHgpCdVC83CQhGvGcNQufkv5tKGUggsMsa9ZRsJLOqSzOym5r/Y3IDpD5HFTzEUeImHAvpNFTM5xt6Ctlzz7RNRFHLjbBu0/g1PsyYPzzgDEO8MOJ5mrWzBwCcE3ptkpTbBSsNJXYvMtsWBjbDqlDRVa1jZzr62Gv7BnjcLa66Ry9ZSsg2ww1AQLNJNCEckS1EOwaY9yq0XAyX9v0JxOMtXBpWeo3iKuHffkKwMpMI1TAOx9SczOyrI2EAUAlsb0h6ozYiqyeD99QE46GmqPofOtHPZZi9L7HDuqq59J40tldElRzHV2Q1MLBqJa4XwW6BiUCYmMpzfVWSikQ2S5X+/DuaU1rC3gTpskH3Rsst+YEOk9mDAV8VcgUgENVtsvgwgTvowLVMkXOOPGiDAy7vFys/3gL2pifXwvnUG+BoCwsYaxr5vu3C8AGMqZaYsREQFH8ZX6hjw1cq9ibKItKsLB/bUduvU5xiM1ihYQUX4WnxwxNX53gaOz+SA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(346002)(396003)(376002)(366004)(136003)(44832011)(53546011)(186003)(8676002)(2616005)(83380400001)(2906002)(38100700002)(52116002)(6506007)(6512007)(86362001)(31696002)(316002)(110136005)(508600001)(5660300002)(36756003)(6486002)(8936002)(66476007)(66946007)(66556008)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUkweVBScVNPc1JTa1U1VDJZUUNHRWtSWVoyTWFpUzFDaWVtK0dNVVVMdXVu?=
 =?utf-8?B?em9OUXB2TXQ5UU9aYkQ0c3R6K01xWnp6RURtbEJ5NEFZZnBOVXlSTTZjN3l6?=
 =?utf-8?B?dStKZE9PR1k2K0RFRTFYb0w3ZXhzV1d0dlVNVzZkbTNxRzhDYW9JaHJ6TVBI?=
 =?utf-8?B?UlVlam1yOURSd2NRN0Q0S0E3c1ZkbXZtK3JKcXhwbjZhM2g1VEVuODE4a2hF?=
 =?utf-8?B?LzVpbFJCalhJNE1XQ1ozSmZHOVpxdTEvSDdHbXpLMytDenNFSk90b0dmTjNi?=
 =?utf-8?B?NzAzS0NCVU10d3Y0VHBSWXhSbis0SHVkQjJjVllqOTJkcG5vM1NSRXNNd2Nr?=
 =?utf-8?B?MVdTUVRGRENnV2FUZjNIZWlVUUdBQm9nZ3h0OHZWdmtESk4zeU5kRGFpODdm?=
 =?utf-8?B?VE9VU3dCaHpDV0d1Ykx3ckFoQitJeGxqVnhNSFVCclcweUN5SW9pM2tFdndl?=
 =?utf-8?B?TFFwRG1yeVd2WFhJc1Y0VWU5d0gyWHZNbC9VbXZEQzFDU3doTTJudE1pRC9M?=
 =?utf-8?B?OGQ5ZDRjd1ljUzUzdG5MRVFGS0VrWUtQdDFiYmNxYW0waVVTSGhDYUpkbExl?=
 =?utf-8?B?alVHcmVTU3BVSEdJWndoR2RRVjg1LzkzdHA2SDJWVHdDMUkrQTRtVEtBT2J3?=
 =?utf-8?B?M0NLYkwvbHJPRlhHOFRHcWV5dkg4WGlteVE3blJYbU50QnBtK2UwSFpvUDhr?=
 =?utf-8?B?MGZXWGVQYWwxRUFuc05ZdCszTm5xYUdtQWIvWlByL2RUZkFCV1F6d08yYlBE?=
 =?utf-8?B?bEFaWUIvQ0pqdGlxREM5QndWVUY2WEtZOEZybXFNMGFpb25NZE53eVJBczdQ?=
 =?utf-8?B?QW4rSThJUVUrTEhnUmk2dHBTdDVlYTFONndHdGVBa1R6TVF4dFpNZ1duTk9j?=
 =?utf-8?B?Tjl1bzZ3RHJHNC93cjBsUGI4Z3ArRkJkZ1dLdkd1blZ6RHNCeEYxdWZCN0dD?=
 =?utf-8?B?MHQya01YNGxIZ0ZzSnhCTTlQUU5VZnQ1Z1U4STZRcEZsc0lmSGZ6ZnF2K1Jk?=
 =?utf-8?B?V0pyc0R6aGxVOUNPSGpCdVQ0ekxoS0h6RDFSUzJ0SCs2RS9kalVid1RYTTlF?=
 =?utf-8?B?WHM2dW4wOWZGdlQyekJXN3FrbTFBYmlkSlhmdzJkSXkrK2hsbnBzVVgrVFk2?=
 =?utf-8?B?M1lSa2I5R2JVc0ZLQXNQZ055eTczNmFhQXBWVER6anNucXliNkR6dWZRc2FD?=
 =?utf-8?B?NjBBb0dUdUs2a2NQODZOTmtTbG1EM0ZJQWxUWDRjK1hhVnJxempKK3JYOXF0?=
 =?utf-8?B?Ky80dmh6ZHBRNWlrYWNZMXNzejFFZk1jZXVMSDlwZ0wwSGl3bFZSQ0ZNcmp1?=
 =?utf-8?B?K2k3dXYxWG5JWEdPYVF3ZWFsaHV3N1NVQkg4bCt0ZjJGNkNTWUQwTEVFZG9Z?=
 =?utf-8?B?WnFyamdkUmF0R1dyK0xnWmFXaWVZMk1tdFhMT2ZRVDFqVHFRRkd1d0o3MnhM?=
 =?utf-8?B?a2xBZ3FlaU5Ta1lzRTJCdXpCSUVvZ3lWTWhJb0pQUW90bFBaeGxocks1RG9o?=
 =?utf-8?B?WmU0eC9wQ29wb0FVRnc4Njh4eFlFbnNXKzFPOFBkbnVUMFNsSy9vdW9kUHBN?=
 =?utf-8?B?dFNJaTZrK1JOZW4vR2ZJVGkvQ0cwdzh4M1lycDI4alY5SU1sS3h4Y3FaTTZE?=
 =?utf-8?B?QlBmY0RkamV6QjRuRDJNc1hqdi9aVWhqdkVtYzJLWE5SdmFyM29iQmxoeGti?=
 =?utf-8?B?SVhhcnJKSExOOGtSTXFkOXp1ZTlCY1BCZ2xBZHdjN0o3dVRCN2w5SVlMWjly?=
 =?utf-8?B?ajhxeWZ3cWpWdU1vZ2tXMWZ0SDJQSGl6L056SnEwcjFjSE5wYUhCNDAzSUVz?=
 =?utf-8?B?VElpa0NYNWtxNkJNcTFIcWNnb2I5TEYwMzBjMFZaU0drYWd0OXl3QUlWSmw3?=
 =?utf-8?B?ZDFodUFja0FhMmVBK1RidDkwTkVuK3o2S1N4emR0eVBOdXNnWEZoSktRMTJZ?=
 =?utf-8?B?RnVteklWci9zOGV1eDdaUkFPbklHempIWWZDdlBRNS9KbXR3SVFkcllsUUFw?=
 =?utf-8?B?N3RUUHFHVWFWNU5pREx0c1VRcGo1TjZDQi9TTjI0alNHanZBS0p6a3ZjTUxN?=
 =?utf-8?B?Vk9acDFzbE9LaTlaaG5sREQ2aEw5SHVHTVlLWUZCSHNieWlaMVBnZkU5dURn?=
 =?utf-8?B?NHlVWU1zMzQzK0NYRXZwZG9tRng5N0pSdzlTWjIrVXZZNWRHSnRLeXliczlS?=
 =?utf-8?B?OENiQld0bGtLSklqNGpESW9RMUhoSnJtcE9ZOXkyZ1NxaHZDL3RjV1IycWx2?=
 =?utf-8?B?ZVZxVXpodmppYWs4Z296cXUyS2c0N3NOWjFXSXZWYkJldHE0a0tlRDNBSWJU?=
 =?utf-8?B?YzRmODhtMU42ckV1UWRrbUZ3dVd6T2lDVzFYRjBEck91K3UxQWN2dWdyaDZI?=
 =?utf-8?Q?P4RnW+KKylN/14Spme8YKOsonm/meECW8R7Bca62krd62?=
X-MS-Exchange-AntiSpam-MessageData-1: 5wOTIS7qCqknveexM++ERgNnNA/Xf3bUV7QOJDCWurHhfqO+4Qhjee9X
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed427eb-ad00-4a74-17b0-08da1e1f2367
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 14:00:31.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mobn5tfn3vPplffuV6ZJ1I9h14GX0l+jBGpS5da5yGT5PoTrKxV7JbO+QSbPUpER6RUKtGmQIid4OwLK7TkP77C68HbZ2ApA5cn7ZRsK/YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7116
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Samuel,

On 4/14/22 05:22, Samuel Holland wrote:
> This series gets USB OTG working on the RK356x SoCs, as used in the
> PineNote tablet.
> 
>  - Patch 1 fixes an interrupt storm issue specific to RK356x.
>  - Patches 2 and 3 are a couple of small optimizations.
>  - Patches 4 and 5 reduce the delay when unplugging from the OTG port.
>  - Patch 6 allows OTG ports to work in host mode without depending on
>    another driver to provide an extcon. The specific use case here is
>    a Type-C port controller that provides a hardware "ID pin" output.
> 
> 
> Samuel Holland (6):
>   phy: rockchip-inno-usb2: Fix muxed interrupt support
>   phy: rockchip-inno-usb2: Do not check bvalid twice
>   phy: rockchip-inno-usb2: Do not lock in bvalid IRQ handler
>   phy: rockchip-inno-usb2: Support multi-bit mask properties
>   phy: rockchip-inno-usb2: Handle bvalid falling
>   phy: rockchip-inno-usb2: Handle ID IRQ
> 
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 125 +++++++++++++++---
>  1 file changed, 105 insertions(+), 20 deletions(-)

Thanks a lot! This series fixes the USB gadget operation of my RK356x
boards.

With suitable DTS changes, the zero gadget module, and usbtest

Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

on a RK3568 EVB1 and a Rock 3 Model A.

Best regards,
Michael
