Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C9D50E662
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243698AbiDYRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237115AbiDYREZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:04:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B631C10C;
        Mon, 25 Apr 2022 10:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh1xt2Kb7MjncdLq3OzkFQOijhX9rlpEEKx6zTD41940mV6DfigOjB7893bA2hRqnqjhZRsh8DdltWS/ZhrRUOXFFfiHd4xJozWcqtygiyvz8r7IGQCf3LcW1FGGvK9GFNX2xAHldVoMl/1MUmHjlt0EARenFUC/zcKJK3DTa6TesVn66NZge0+Ry6qs9RN5dSCs+TKc4opXRR+ewBfOE8EJbjHkmV0lfcPjuORB4BrdH+SCjnydrnMD2wsyLS+EWw1SSMBil6AFe7BG4bvJOiHbpYO0+c6rRC9MUsI9atgJev8B1WPNLLyO2wxViRyuSOUegAIkRjzCzX+L9QiTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1PaZGgbSNh6IiM/w+feFDfuVG0Jt24YD6DcmfzZxI8=;
 b=MPH8XbZI3NMg4aISUtfHMBaxJoVXhB2SB0UR0We9WyImrNsprIMlhWz5CrpUGrp/+HWdMGBj98/BXHHzV6owK4HaYw1DDIz/xAkC/7JZTDF3eekJ5bhfu6ryboJq7pdccAyarlJrS/DmKOdBjWHdNGmwwBnsukNPribOzV9tMQ34Y/noO1kuIS0GhMc+I8zQoFJhJZorLD9F23DzsYQGxtNE7UwoUvOLhlfIZB7W5SQ8fB5SynI80yowl7wgZPQLtWpHo+AmlcJjJcafDvS+7AA17VlPMNlNbqEqfsimVyGQcj1n+JAmjY448jKlkQOwXlC8dAMGu8f6L4xCtvNGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1PaZGgbSNh6IiM/w+feFDfuVG0Jt24YD6DcmfzZxI8=;
 b=P5bc2GtTT+xBdpNhY7wK1bNIl99N5fxuLqNfW/H5xo6MrrgK0GWcLrDBOghs2/i9uhoMRTCSo7jSSUjumwHIe9LkLMG2dB5NvbN8Y3ia49yT/RUK7wMvWX7bePPf6tOVJikjZQuv5afmxtk7Nl1Xlg7DO96d0bnQWNrgkCD/aHjqphY8O+ozGaCt17yAVpIe+9X9FG74HtFvPtlLPlfzOCOV5N0LdI0l/k1Ny1q5/hs7fvPR6uSQfdKMgGrW0TCuvy0FzmLjE5/t0q/+SKJf2bVwBGNs/WXNRXanU6GSwDwNCkEXdunYnXYh0uHGfSLU6INY35l3eAf+UaxC5Pj5fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AM6PR03MB4662.eurprd03.prod.outlook.com (2603:10a6:20b:1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 17:01:16 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 17:01:16 +0000
Subject: Re: [RFC PATCH] phy: Convert usb-nop-xceiv to the generic phy
 subsystem
To:     Jules Maselbas <jmaselbas@kalray.eu>, linux-usb@vger.kernel.org
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220421162158.31364-1-jmaselbas@kalray.eu>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <a2cae95d-1ec2-ef76-b505-81b9036a52af@seco.com>
Date:   Mon, 25 Apr 2022 13:01:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220421162158.31364-1-jmaselbas@kalray.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0037.prod.exchangelabs.com (2603:10b6:208:23f::6)
 To DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce7a2d9-9228-43dd-7c7e-08da26dd35bf
X-MS-TrafficTypeDiagnostic: AM6PR03MB4662:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB466200631DDD364A0657223B96F89@AM6PR03MB4662.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8v9IbHSRn0hKZXQuLiQNywLSw4x2FLwq012Yh6yI4tSkVCs1ldU0t8Chjn0sj/QMgkNEniHDO54G3vjavqt6OmVA9OLYTP6tIeYx3EYSpt45qMt8+rkHdBR1OSjlLQ4UI54m8Vq4P8sZxIIpdmb2BoX9iUR2+3Fa2an1AS3vhc/wNCoXJkTbEn2tmmIv3oLxrLt+7Dvlv5HQglXcEzlEamtbXLAl+FIDET64XZOxC4hiNCMXdz/eBIDojXd+i9jX7LVHcpVvrHbjJrZrl5PXMeFXsfnjuqPjobQNzmgg//JZcPV5nA5H/nWZ3b8LkzJ8DKttODBjiQ5yadQ+q2vwANdceKY25XDi+hwKnSVTUkACh5dDGPqjPhb2H+izU/rpkTHr48ilXpKe09i/puDaSa6xqaOAwqvcCJI5YA94jEQTcs81NMuyAb68yTCI4gWJFYgbi1Hv4WPXjdvtAonq+GZLUvay2Viq20bULKmsMf4BTRVP+wW9twoxWwxo5Lva3NBzX9t/bjwxLIEovRMQ7ruXiCJD9FroVraqc9OZxpsnKx7sPEVlfABDTDQihyDJhJ20C/EesHtGi4HRd/83sjK2ngOEN3mUu+wCyszCeR3KWIIcnqiGgKogeLkXVcFKJ6mYVU2VN0B34OVDO0V2asB6G/gPreJXagJIgeIs/H4BmX4f3i+UTmSMH2kjCPKH/ohU0JfRpt4IMbdE9fRNsg8rZJJb8o79NvvNQ5bbS3kgdbNznqwn6YKatOpRQP7d+5B4Y4jmaGPdu4yz0i4+8EcIXlHcvSKwCnUS5wqQfeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(54906003)(38350700002)(38100700002)(6666004)(186003)(30864003)(5660300002)(2616005)(26005)(31686004)(316002)(36756003)(44832011)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(52116002)(53546011)(86362001)(2906002)(6512007)(6506007)(508600001)(83380400001)(6486002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjFuWCtwMU5jU0ZrSFF6dVZ0dHhGT1F3bC9Fb3dNR2pOM3BmdlpPcnZCckNO?=
 =?utf-8?B?NmFnZmhlT0t6eUJVRjByZEFGcG16b3J0Mmo4UHEyc2YrU2o2ZU5OaWJjTUFy?=
 =?utf-8?B?TmxUUFpFRFJVVmFkTVJHenRlMEpLYWZPWlNYanhPOTNraFUrOWhpVmxnOFpH?=
 =?utf-8?B?M0sxQmx6dG5QbVdtWEVIR0NSY09jR2poeGtLYzA0OU5xcW5ud3ZFZlNKand0?=
 =?utf-8?B?UVdTQmpOYmRaaU1BUUY4VlJsK1dSZFhpd1R3Q05lMlU0S3hZUjhEU1JGZEpX?=
 =?utf-8?B?S2grUzBVRllabjJ6ZXdVSkNRaVhseU0ybk00cE9qTW1oU1VQcXc0Q2RRSFVh?=
 =?utf-8?B?WWdwNlNaL2pxTm5OdDJtMVlSTVZ5TzlIL1Y5U0ZNekU2U1NvRnZ2UkdsUldF?=
 =?utf-8?B?SG9zeVIyQlN0N2tkYzhDbkExK2VFaVJCbEQ3YWpNNW5FbjFXbjVwbWY4c3dS?=
 =?utf-8?B?dDBJcEZiVC85NFFXWHh0SXh6V0VSNDltZ3lVTnZkRUFHY20wR2dOSVM5bXpE?=
 =?utf-8?B?U1Z5MlVra0VVRW9WNnlHdEZRRk8rL25Hc0hsd2RKMm44czVlZndUTHdIMUNF?=
 =?utf-8?B?T2hib1A5ejIzbG4ybUxINTBxcWhIN2UyellxOTU5bjV2MGo1TDVWV3N3YmNw?=
 =?utf-8?B?RVRzeVZKTjZERE1sVEpvR1dzbFpSMEtzNkgvYXB5bUtMY3liaTVBODBFbGps?=
 =?utf-8?B?VVVqYVc4WTZQYkN2K2xMMUo0b3p2aUlOd2Z0a3VoZ3RGTlRyVzdiWFJFOXRG?=
 =?utf-8?B?MmRrYTcvT0ovYVhINHkzd2FWSG5LTUVDZ01kTnN6R3RMUzBtSGJocWpiS3FN?=
 =?utf-8?B?MDRUQis0OVJzaXZBVmxHTEtOQ29jWWZKeElmVUMySTRlMFpvNVJoUFZNWS9E?=
 =?utf-8?B?VVhUSmtOWmd5SWhreU11ekNzYmlGbUR3QjBiV1h1M0xucXFQbjFiMnhsc2k3?=
 =?utf-8?B?YUVmazNPSXlXelNsTnRyMGZHVnlLWXV4UmFWQk9za1ZURE5IU0tyL1ZlamxI?=
 =?utf-8?B?dDg5L3FpcVdjNjNwYS96T0l2SWhOZk4wZmhCNzZnSjJKaENvZlI5Z1M2QlRC?=
 =?utf-8?B?aXM4akpyMmNOejExTEw0RDRaWGE0TzA5SzhIQkNWdVl3NGE5eERicE05Q1FU?=
 =?utf-8?B?L2hhTHFod0FkOEhaeDJjWVVzVlJRTGZnQ3lHMDA3UUp2WWpnN091SkFmTG1V?=
 =?utf-8?B?dFI2VjRYMWIxVjJSOG5LV25OZkpmQU9mYlFncjN0UXMvZWwyclVVSFlqNFBy?=
 =?utf-8?B?ajNTc0c2K2hTTE43aDRyNDlpVVl0Zi8wRm1rZFVTWEtpakpoTnJSVFpRcUtu?=
 =?utf-8?B?cXJtOUdCUkVCcE91Rm1BUE4vZkNjWHl2Q1dIL1d2QytGK3B1eXhMeUQyKzVj?=
 =?utf-8?B?ZDNaS2pmZFlMbkJ3VDBLMHUxcWZ2bldmN0kreDdZV2RDYlZWVyt1UERYL3Yw?=
 =?utf-8?B?dEVEMmNtc3pEeEdYbU55SHdnME9HL1VWdFQzNXpFQzlrS09YVUZwQUU2eE5k?=
 =?utf-8?B?Wmh1QlhkMDRCUE5EcjZUSGs2Q0pRUlM2N011S1NvWDA0cldCOTVpa1JtN0JQ?=
 =?utf-8?B?a0tzbFY0RGhFM2lmSVBrcTBVSW1WU0lHZDdYRTd3TERkWFRWYTAzdVJ3eHlV?=
 =?utf-8?B?NWtVdE8yQnpRYnZIZ0podEN3YVFES1g2akl1Z0RLR3V3WUpFeFVQYzQ0ZzhK?=
 =?utf-8?B?bTlucmU4YzNkNW9KREZTRHY1Qm5KNzh4enRrK2w4QUFCNzE5d0J3ZWxiOXQ4?=
 =?utf-8?B?cktOMloyVGgrZHRZYTAzcytkU244RS9GMDVrSitvSEdwWEVwOUlNUlpOWDlp?=
 =?utf-8?B?WEdsSG51SHduMGtXd1NIRDNXQ2hPV1Jic3J2WFBoaHljMzVOYzVaWWRXdytx?=
 =?utf-8?B?L2VaZWErb1prb2FFMFlkTmpWelhNdk04VWNlZjdDTytxUHBWMWlja2lib2No?=
 =?utf-8?B?NTB1Y1o0ZVVkeE00WDNCS3cwN0pwVzhJTUk5bGM3ejRHREFJOVpoditLdW0w?=
 =?utf-8?B?T3dKRUNJNzY0dDZJTFRSMEVPUFpydmIzbVZlWnhybkFmLzZwUHNHc3FnZlBr?=
 =?utf-8?B?YjRaZWsyU2x3UzRZTUxRTVQvWmlwRzRUSEVnaXhaOW5yMVd6SjV4VnhSK1pp?=
 =?utf-8?B?TTBxdko0ZE1PeTlGYWdHK3l3SkQ5Q0Q5NnVaVWJubXI5aiszZ20zYmlyeURB?=
 =?utf-8?B?V0pSQTc2dHBmb2E0dVA0K0x5empVSDJ0UlNGT2NGV0dOZWFyaDFPS0Mzc1k2?=
 =?utf-8?B?QUgvTm5mSDVtUnFuVHk1OEVsNDlGMXVETGF2Y1NZQnYveFhsWHhrQzZnYmZH?=
 =?utf-8?B?ZmFjUE0vZTJ0bnBwdXNrVDlCTFMzZld6S3A1ZlM1U2c3a2FndXZKYzQ0TDlR?=
 =?utf-8?Q?2rVELAzZuCCtzsTk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce7a2d9-9228-43dd-7c7e-08da26dd35bf
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 17:01:15.9747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEQcFN8qcVoeFOBLpwri89V5FgiqG1xitZg5mLXGS4Pwc42/4fn1jFpHuslfm3JjVOBWRcKluMWk5BhfxIWAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4662
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jules,

On 4/21/22 12:21 PM, Jules Maselbas wrote:
> I recently encountered some limitations when using the usb-nop-xceiv
> driver using the usb-phy subsystem. The situation is: I have a board
> with two external usb phys (ULPI) that only needs to be reset by the
> USB controller. However both phys shares the same reset line, which
> will get toggled twice by the USB driver, once by controller.
> 
> This is what I observed with the current Linux usb-nop-xceiv driver:
>           _______                            ___      _________
>    RESET:        \__________________________/   \____/
>                 1^                         2^  3^   4^
>  1. and 2. first controller toggle the reset
>  3. and 4. second controller toggle the reset
> 
> After the second toggle the first driver didn't expected the reset and
> causing issues, but I don't recall what exactly, it is maybe a driver
> that simply fail to get probed.

Ah, a tale as old as GPIO resets... (c.f. MDIO)

> The following is what I observed when using the "usb-nop-xceiv"
> driver in Barebox, which is a bit different than the Linux one.
> 
>            _______                            _________________
>     RESET:        \__________________________/
>                  1^                         2^
> 
> In this case the reset is only toggled once, this is because the phy
> driver count the number of time it has called init and power_on, which
> is exactly what is done by the generic phy subsystem in Linux, but not
> by the "legacy" usb-nop-xceiv usb-phy driver.

Can you provide a snippet of your device tree? I am not quite sure how
you are describing your phys. Do you use the same device for multiple USBs?

> This difference in behavior is what motivated to "port" the existing
> usb-nop-xceiv driver to the generic phy subsystem. However this is far
> from being complete... I've only tested the reset function for this nop
> phy, and it lack a lot of features from the original driver to be a
> valid replacement for it.
> 
> I would like to know if there is an interest in converting the current
> usb-nop-xceiv driver to the generic phy subsystem?
> 
> I would like to keep the usb-nop-xceiv compatible as it used by Barebox
> and it works OK. If a new compatible is added then device-tree nodes
> shouldn't have both, the new and usb-nop-xceiv, compatible because of
> the specific check in phy-core.c which will always return ENODEV.
> 
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> ---
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/phy-core.c        |   4 -
>  drivers/phy/phy-usb-generic.c | 241 ++++++++++++++++++++++++++++++++++
>  3 files changed, 242 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/phy/phy-usb-generic.c

Since this is a conversion, I would expect that the old driver would be
deleted. In particular, the Kconfig will need to be adjusted so that
users of the old driver will have CONFIG_GENERIC_PHY enabled (and some
reimplementation of usb_phy_gen_create_phy). I think we would still need
to call usb_add_phy_dev in probe() as well.

Though I suppose this is why this patch is RFC?

> 
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 6eb2916773c5..8eeecf6d6f74 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
> +obj-$(CONFIG_GENERIC_PHY)		+= phy-usb-generic.o
>  obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
>  obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 71cb10826326..e09fd1cb4455 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -506,10 +506,6 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
>  	if (ret)
>  		return ERR_PTR(-ENODEV);
>  
> -	/* This phy type handled by the usb-phy subsystem for now */
> -	if (of_device_is_compatible(args.np, "usb-nop-xceiv"))
> -		return ERR_PTR(-ENODEV);
> -
>  	mutex_lock(&phy_provider_mutex);
>  	phy_provider = of_phy_provider_lookup(args.np);
>  	if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
> diff --git a/drivers/phy/phy-usb-generic.c b/drivers/phy/phy-usb-generic.c
> new file mode 100644
> index 000000000000..fdd05bbd98f2
> --- /dev/null
> +++ b/drivers/phy/phy-usb-generic.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * derived from driver/usb/phy/phy-generic.c
> + *
> + * Generic USB PHY driver for all USB "nop" transceiver which are mostly
> + * autonomous. This driver is derived from the usb-nop-xceiv driver, but
> + * this one use the new generic phy api.
> + *
> + * Copyright (c) 2022 Kalray Inc.
> + * Author(s): Jules Maselbas
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/delay.h>
> +#include <linux/usb/otg.h>
> +
> +struct phy_usb_generic {
> +	struct device *dev;
> +	struct clk *clk;
> +	struct regulator *vcc;
> +	struct gpio_desc *gpiod_reset;
> +	unsigned long mA;
> +	unsigned int vbus;

These are unused

> +	enum usb_dr_mode dr_mode;
> +};
> +
> +static int phy_usb_generic_init(struct phy *phy)
> +{
> +	struct phy_usb_generic *priv = phy_get_drvdata(phy);
> +
> +	if (priv->clk)
> +		clk_prepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int phy_usb_generic_exit(struct phy *phy)
> +{
> +	struct phy_usb_generic *priv = phy_get_drvdata(phy);
> +
> +	if (priv->clk)
> +		clk_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int phy_usb_generic_power_on(struct phy *phy)
> +{
> +	struct phy_usb_generic *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	if (priv->vcc) {
> +		ret = regulator_enable(priv->vcc);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to enable power\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (priv->clk) {
> +		ret = clk_enable(priv->clk);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to enable clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (priv->gpiod_reset) {
> +		dev_dbg(priv->dev, "Reset toggle\n");
> +		gpiod_set_value_cansleep(priv->gpiod_reset, 1);
> +		usleep_range(10000, 20000);
> +		gpiod_set_value_cansleep(priv->gpiod_reset, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static int phy_usb_generic_power_off(struct phy *phy)
> +{
> +	struct phy_usb_generic *priv = phy_get_drvdata(phy);
> +	int ret;
> +
> +	if (priv->gpiod_reset)
> +		gpiod_set_value_cansleep(priv->gpiod_reset, 1);
> +
> +	if (priv->clk)
> +		clk_disable_unprepare(priv->clk);
> +
> +	if (priv->vcc) {
> +		ret = regulator_disable(priv->vcc);
> +		if (ret) {
> +			dev_err(priv->dev, "Failed to disable power\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int phy_usb_generic_set_mode(struct phy *phy,
> +				    enum phy_mode mode, int submode)
> +{
> +	struct phy_usb_generic *priv = phy_get_drvdata(phy);
> +	enum usb_dr_mode new_mode;
> +	const char *s = "";
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_HOST_LS:
> +	case PHY_MODE_USB_HOST_HS:
> +	case PHY_MODE_USB_HOST_FS:
> +		new_mode = USB_DR_MODE_HOST;
> +		s = "host";
> +		break;
> +	case PHY_MODE_USB_DEVICE:
> +	case PHY_MODE_USB_DEVICE_LS:
> +	case PHY_MODE_USB_DEVICE_HS:
> +	case PHY_MODE_USB_DEVICE_FS:
> +		new_mode = USB_DR_MODE_PERIPHERAL;
> +		s = "peripheral";
> +		break;
> +	case PHY_MODE_USB_OTG:
> +		new_mode = USB_DR_MODE_OTG;
> +		s = "otg";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (new_mode != priv->dr_mode) {
> +		dev_info(priv->dev, "Changing dr_mode to %s\n", s);
> +		priv->dr_mode = new_mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops phy_usb_generic_ops = {
> +	.init = phy_usb_generic_init,
> +	.exit = phy_usb_generic_exit,
> +	.power_on = phy_usb_generic_power_on,
> +	.power_off = phy_usb_generic_power_off,
> +	.set_mode  = phy_usb_generic_set_mode,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int phy_usb_generic_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct phy_usb_generic *priv;
> +	struct phy_provider *provider;
> +	struct phy *phy;
> +	int err;
> +	u32 clk_rate = 0;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->gpiod_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(priv->gpiod_reset)) {
> +		err = PTR_ERR(priv->gpiod_reset);
> +		dev_err(dev, "Failed to get reset gpio: %d\n", err);

These should be dev_err_probe to avoid noise when we get -EPROBE_DEFER. Ditto
for the rest of the dev_errs.

> +		return err;
> +	}
> +
> +	if (np && of_property_read_u32(np, "clock-frequency", &clk_rate))
> +		clk_rate = 0;
> +
> +	priv->clk = devm_clk_get_optional(dev, "main_clk");
> +	if (IS_ERR(priv->clk)) {
> +		err = PTR_ERR(priv->clk);
> +		dev_err(dev, "Can't get phy clock: %d\n", err);
> +		return err;
> +	}
> +	if (priv->clk && clk_rate) {
> +		err = clk_set_rate(priv->clk, clk_rate);
> +		if (err) {
> +			dev_err(dev, "Error setting clock rate\n");
> +			return err;
> +		}
> +	}
> +
> +	priv->vcc = devm_regulator_get_optional(dev, "vcc");
> +	if (IS_ERR(priv->vcc)) {
> +		err = PTR_ERR(priv->vcc);
> +		if (err == -ENODEV || err == -ENOENT) {
> +			priv->vcc = NULL;
> +		} else {
> +			dev_err(dev, "Error getting vcc regulator: %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	phy = devm_phy_create(dev, NULL, &phy_usb_generic_ops);
> +	if (IS_ERR(phy)) {
> +		err = PTR_ERR(phy);
> +		dev_err(dev, "Failed to create PHY: %d\n", err);
> +		return err;
> +	}
> +	phy_set_drvdata(phy, priv);
> +
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider)) {
> +		err = PTR_ERR(provider);
> +		dev_err(dev, "Failed to register PHY provider: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id phy_usb_nop_dt_ids[] = {
> +	{ .compatible = "phy-usb-generic" },
> +	{ .compatible = "usb-nop-xceiv" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, phy_usb_nop_dt_ids);
> +
> +static struct platform_driver phy_usb_generic_driver = {
> +	.probe		= phy_usb_generic_probe,
> +	.driver		= {
> +		.name	= "phy_usb_generic",
> +		.of_match_table = phy_usb_nop_dt_ids,
> +	},
> +};
> +module_platform_driver(phy_usb_generic_driver);
> +
> +MODULE_AUTHOR("Kalray Inc");
> +MODULE_DESCRIPTION("Generic USB PHY driver");
> +MODULE_LICENSE("GPL");
> 

The rest looks good (modulo missing features).

--Sean
