Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F15681FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGFIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGFIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:44:24 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019A1707C;
        Wed,  6 Jul 2022 01:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXMUCc6S8iwBzIWr4xL76gUpjbhumC/Nj9wNWL3g4PHUwnBkvKlesMQhnj645RNAx0iPm4X0XzK4MEanXulSrmqliR4GykXk3kwZhaq9mga3BBCl0/P4/VQLEN1QUDQCdfo4OeZ2afzVdZGhmxTDArkhLvU52D1mijKTrEeLDwXovBmiuk7EudrEtKgyzfB7CpMfaAQfd0abySTgwrT9buFa5DHLUvcqohM/QjCnIEFMlOJ748P/iye7pR7pb7+5tbKlB3WA5n2/ll1qiV0zOO6Iiq5uWXW++hPCQAnDQiCfnoGNp7VUq9iFbitDNKGD7XwAwy7jwRXVbTRamAjwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAY4Ue8N425D+q4fohbjt1fY2cx5KEMaARzr3yFvefM=;
 b=JQ/7pPfZAIMhJ1lzKVvgrIuX3kkD2dOX0Lm0HWuSXKzaSIZ+GqpXOREITTJNtLBirCk5CUHtVZixxwyUS/PIJEw0LWuXlTty/+YKo0xxyh3f9DvchoI30zYGtRkwq8KlfllcrNYTnnV0TOPY2blyvqN6ChxJXm6oE9hHHOMyy7LN7cVSKRxVg95kx9fMtuLoMgoHmboBncXFBaGaNI+rn1YQatDmzYmdPG2/Tg66mrPyQ85Fb5OH+I8eOZDYn+oimss0uz4UMr3JNipkLoZ1ZQtNpHPnd2i5z1PxFoplZxQvcw/xRsq5dF3s/1AhaecSoz/oDJRmEzpGn0jZZqvhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAY4Ue8N425D+q4fohbjt1fY2cx5KEMaARzr3yFvefM=;
 b=ATJi8d0BV74BY5FKKbKQ0YC4YlaORV+ALKDw2ImcN2XAUsGyEQfl1nAqNqw/A0wjB5ye74IxPPclxH3IvOvTow83pl1OIkrvN389dPb1Iy8ubiF13/N77yrTOohTYcB9N6A5XP0BZ4QvvBZKIMA2OcKgPZ6T/2c4J4WePsSj2i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB4948.eurprd04.prod.outlook.com (2603:10a6:208:ca::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 6 Jul
 2022 08:44:17 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 08:44:17 +0000
Date:   Wed, 6 Jul 2022 11:44:03 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v7 01/15] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Message-ID: <20220706084403.46hsjhkrsss5n3i3@fsr-ub1664-116>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
 <20220704161541.943696-2-viorel.suman@oss.nxp.com>
 <e9917b17-49e2-6f0f-201c-8b2064c5efc6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9917b17-49e2-6f0f-201c-8b2064c5efc6@linaro.org>
X-ClientProxiedBy: AM0PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:208:be::32) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0067dbcf-e2c0-495a-10c4-08da5f2bb636
X-MS-TrafficTypeDiagnostic: AM0PR04MB4948:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTC8onsN4yQvYfGlP1Np083G7dHj7+B2805Hii26EzzautPDyH5YAu4wSoUIHyAyayToK1pLcpztolQKLHg3j7Tkn+CtYHcZNZKY55DEtR3O+2XTwXT5NyK/64/QV4M6ab54PoJnaEtPhqEY+0LOMtoW7gWwJ/t4s5aoE95nNkj3WRiCJx4tt5yFEUUR+9OmdaiU4CZDMeLdH8lvU5YoZknp9Xs0MrU8GhctEokTBEVMgs72EgwKJgGBBD9F6qaKYlCOs76FGPE+VJn8dWYMnr0EzevWEJCZZ+eSXOy/TvWK4v+UOyzQqOMeBNJG09D4jK8VuXDLxpCLAjK2DxFdUoMDqcFM1FGHAc7rZsVn8m3Cj4X9FS+5St0nqbqv8Co/Fl2t50Hy71QSfbNQWuNzef7FYuINsTacUXyMT4GLNS38CVfkdkFs69gIFiOYdaUp29MaQeyGJ2qCs9XCE3i0S5bN4FqZWjfQwnSFFljJ4ZlEkZSAjzzBsIDfyNSS+G3m71FCttz3MI0/Q6fptiin8x0nBTKTi5MZiE4RhQdVH9dy4tSkGZzLQboAfjyLKO+A/FWKGOQ2rgl+eoa6t+K96+D5wFOSTJfMC4gbW8tdGw62QyOxXYsm4TkXdk83pX1HlwJ/dA8Uw8CAR6+Qp6jPtmTTDwZelMzSl/ftpQcdTrnU2M4o2I93IwccgPDd0y15JeEENl7pNaLPL8DGoHpTQHUatB602L/29TKUR0pZbPIrWsaKCIjbXoQJn5vjuZNhXZDVYRSRtaf3vsgEyS3bIr6Htb6Hq8uBDIsOv0SJxfT553UXtueXmQiXJ0wxZtR1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(1076003)(6512007)(6486002)(9686003)(38350700002)(54906003)(6916009)(316002)(186003)(38100700002)(66476007)(66556008)(4326008)(8676002)(44832011)(41300700001)(86362001)(66946007)(53546011)(52116002)(33716001)(8936002)(83380400001)(5660300002)(26005)(478600001)(7406005)(7416002)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2aWd0ev/FdpR2Jvc9R3sPEZC1qSgDTUCrs8sBzVJU0O35CY0yQKW4LpSNRM?=
 =?us-ascii?Q?WTubicyOv076GBBjwd3ck35DQaAmLu4u7GSQxS0R3wwsZLn2qJS//TCa/0ja?=
 =?us-ascii?Q?dcSra2AN35rUMTpHzxnZnKT/cKr3Mu4xXublS0ZtyhuSN4K9ezg8vkPrOt2Q?=
 =?us-ascii?Q?/zLckAUtFe+vgVVN5lrQOT7Op+ctt5Cljf8yzABq/9RPX7ISiXQodr+8vuHH?=
 =?us-ascii?Q?tdZN1WG585p5ymf2LtY2xM3vQxedn5pNkLCUSAcOmewIg0zD+2hAhKEknI4Z?=
 =?us-ascii?Q?PIksCdR+t4dbzIP9uSq0XHF9MHmQJVBhnEPgduaBM6HyBaYqQPVhAp1sA6sH?=
 =?us-ascii?Q?nixmFLANaQsPthCbJvGv8p4IfjP+EgPWXGCVI1bvhcB98VmfQPaChT0OzZrd?=
 =?us-ascii?Q?C4sF0QEMISek8rIAkjUzc7U0GdQMdGai0ltNjvsPlHWe4BdfZGa2RCmm2yji?=
 =?us-ascii?Q?sLPS4xAGPMZ7rKhrAJHFi75OvMvAg54HDgEFm9gqtIxo4ZUG7UGJqLYyBPX4?=
 =?us-ascii?Q?k0fI7Pf/Z5AYPjGNC37fYhZTWumgrNmc/5/ujzf8aCSYdOQ3saGe1yw8b9Nf?=
 =?us-ascii?Q?wyFd3T0bMLaWP82t/IHZM7muY6YAn4w5OvctkNJqPHWbBYcekCC+j7K8PPOP?=
 =?us-ascii?Q?iQeKrjV1LTcUMIe+1djiKA/BeI4HiYz1ELrgu4nz3XdFD9u0q9+2qDHZq3Pg?=
 =?us-ascii?Q?jtVCiWHNJK9uYMP46Se3dRY3xlIshZ2lCFf/SD0OVUfYkHr+W57P7aGeEhgi?=
 =?us-ascii?Q?wfvuozndL0RD01WIdDxUxywsM53GvhoCLSnhK4OtPhdErU3FpEAYaye8PF+D?=
 =?us-ascii?Q?TBkrf0QYebUdPGGQnbaUuWpIrLN3By8uk8k4tzrWHsASBoQxGc2I3iLDZunQ?=
 =?us-ascii?Q?tU/OaAQDCVZ5uYGc6JM00yFOnLpe+G5r7RAWp7Z3xSVMGhH9qIY/wehd0UEO?=
 =?us-ascii?Q?oVTZFJ5lBxl1G6nz7+vftfwg5IIR7QKerRJ3fr5Zzw576Vzq5J8ZyUFyB6u2?=
 =?us-ascii?Q?eqDBodLDOtL3yUD9X3YAwEY0zx5V1Gil9nCy8LxVIgVQKILht6C78sRFNEno?=
 =?us-ascii?Q?MjIDeffAWyWmhH3fUC8zOVxWSfcSC1DAlgjtQoTteNzfJ84x+blwRcFaDgEq?=
 =?us-ascii?Q?j7HEdSp2RsomWLBbOBPen1P+NEpnFW104ZpyYI8rX96u0AsGidFDwoN+Dbtx?=
 =?us-ascii?Q?ppMjbNskDAcivVyb4id6Kk3taOE+0vTzGFju72XraUlM1sM/KfUq0dQT52mh?=
 =?us-ascii?Q?eQpCcyQxYDs/mHz8MPoSTkPeSjmClum5ZGUKqvu/noG4AL0pSkN60mgBor6c?=
 =?us-ascii?Q?RD/ojbYtSwh5aRWt5XH0fI7kI7alL99Ge1Bj1JbmhKixojKbhKyHRUScy5OO?=
 =?us-ascii?Q?1zAJIIbqNrJS6q83Z/TBcRkPGKgqBfV6/kSbD1Ad4UyC/yjTzHD7QxwvWvXM?=
 =?us-ascii?Q?HrKw22F8U+9Opu1yEavFD4VWms4OzJeUbRLelpOw+YI96inNHJH5niG/Pxmo?=
 =?us-ascii?Q?jpN+NnIjQY2gLIQ8vQ6JNhtWYfEIrEmRHZGbiNOtR8jmiuZ9XhkyyErFaz2F?=
 =?us-ascii?Q?InN+Exw/tSvCSrH/xR7xTx7Y8A87a4AFKUc75TU7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0067dbcf-e2c0-495a-10c4-08da5f2bb636
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 08:44:17.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCbVi17vMhKq6zVF6ouvyO27T8HLu46/ItKY5KKfFW5wCrhiTVWEu6jbUXkg3TxbMSfLURYtZxrg8nLQWFOCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-06 10:27:57, Krzysztof Kozlowski wrote:
> On 04/07/2022 18:15, Viorel Suman (OSS) wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>
> > 
> > In order to replace the fsl,scu txt file from bindings/arm/freescale,
> > we need to split it between the right subsystems. This patch documents
> > separately the 'clock' child node of the SCU main node.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> Hm, you kept Stephen's ack, so why you did not keep my review? Sorry, I
> am not going to do the same review second time. Please add changelog to
> each patch instead describing what changed, which also will justify why
> my review was dropped.

Hi Krzysztof,

I thought it would be best to get your final "good to go" before adding
your "reviewed-by" given that the patches includes additional changes
and may not fit your expectations. No problem from my side, will
send one more version.

Regards,
Viorel
 

