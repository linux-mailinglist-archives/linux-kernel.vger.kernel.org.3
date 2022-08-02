Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63608587792
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiHBHMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiHBHL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:11:57 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20052.outbound.protection.outlook.com [40.107.2.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78C2D13A;
        Tue,  2 Aug 2022 00:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewg9uj0k+gktMVx4mzVF/sHyOmAOjkHLvdku5P9ea+mnJdv0bzULfC4W53UruYNm4rr1k/aYMdmOWcgkU+pj2iW8UJL3MDejDhFNYQt0cfPZzCTJ9xqfsCzNQSfCCIy7GRdkIbrMBcocytkOsHbwyjxhVNP0MU1jX43ZThiinAOWPuM8yUKCictQsd1kmG97WkAfW+4pudXZRId24E0NXV/2xh1zECG1hpojnLk99EUvD5fP79EiVmPtEsI5jTuHUTX61FEh1nBj3vEJbBsg5gEFPUOdBCBTYxA2zquD5QYB2WA/nH0YPixLPPx0uR+At/cFpO7SVOuzvaEhxt87mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN22gQQ3jqk7gI1iOgtwhkjjwOCuznrl+jasBbEwSpQ=;
 b=kq1k0LSwJtq43omA+Zl7S9prVY9XDilwuTYqZTO2XmCYny2BJ7Mm1+UWNJzyH/tfYASRT+6NpPd9m4qMoDBIGec65kSVajAWcXbejemGcJqMIaZcooadIzSgiRFRrkzRzsAj04mnYjVapBx35ncMXeS/95GXjAuv9liHNqeESe50y29EReIgk9ubR6ZaDF5AB8zZtCy4tBfptkIQHydFaxzNvgjyoP5YN8AaaGILoTdhPE4jHWDmduDyECoeIHH4q0CQ+svnfieplQCJ9m/Jrmk9guAS/fLL/0hpM1JeT7xFzR/uhKApBNm24xmUBS6qnr7WEq5cz0iFLVIjrxtXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN22gQQ3jqk7gI1iOgtwhkjjwOCuznrl+jasBbEwSpQ=;
 b=PJqquuPOhDZVam/k6aWaPZVVMPnEtYjA3+EtmnoRee4sZcOf4GR0YqJaHPmK3U0BcprJ7/H99mSvZEikHbt58Mr9zkhpO7hsqcPJoS1DQjQKTaPl9Zu+P/c7poQ5iChxn2+BMwTA9ogX4wNpo2teSFClscHLgk+1FJLjuiFI1rc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB4719.eurprd04.prod.outlook.com (2603:10a6:803:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 07:11:53 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 07:11:52 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
Subject: [PATCH 0/3] drivers: bus: Add Freescale i.MX8qxp pixel link MSI bus support
Date:   Tue,  2 Aug 2022 15:13:07 +0800
Message-Id: <20220802071310.2650864-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 260ad5a3-e2dc-484a-0c9a-08da74564677
X-MS-TrafficTypeDiagnostic: VI1PR04MB4719:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VttkYmGXPk4TWFo9GBSsXQH7NjBhdQojXyExn4yPNW+YpHpH5b3K5mGaQQc16M2WO11psLzdr2i4lGyE+2MLuSqkPC30pfQhb6UeEOm7LPaaIJyI+9OBExy74Kd1RQv3iVa9hxDgHg/JlL3g4WUuNPpJHY8Y13jEf9vTUmJT+Tt8kSaLF4wTMrpuqAzIBWG90kdyXvfHHrO+cGhDBGdNGFVN7sigF6nWv4VWUYjPvKeAuWJytBvHiuVIKIIOOSw8lp+/54RvKby+k7zkhpJ2QMIXKudBLz9P29wxphjvS5CGjb+8/rMfmIlCOFu4j86ENkEi00OowIlX7E5RTEhEpKZ8fMosvhHAdeZEF9O916b82EpzKsMECrbYSrL7hk103cemiInUQvb8Sa5LZ3lajx6yE6XrDgvgCjNSx8HemakoL/QAXwZ3Oz+9sJGMin7FF8+ZekFuBVi4D6UK2iXBzlXqL8z2noHwKnF6XKthCzeT0GWzijKJaGqW4fQ++CDfz1FMljDe6vARqb9E4mRWCuRfxtJ8weEZHABQXsV3skgNxAEy9XVyIN0zMlilQBv/Gp/VFIOqMY5d2joOM2CE+jcnREuCHJ4yoK+EBLqHI5lpgSOZlrDFo3xv7veNykuG3K89IK3LG6eoN/eAbQbUS1kGS2C9kE/vqxYgQyfAJCFmx2WKqTEGc0hy7z5eMlSJYt+UkbvG6CsGi8CSdDTuIXUVo7uh3qnDZURBHgJeXcW6tApYiJexbuVQp/lp+FaXtPitVV9uAe8DCF3Nd8Z8CpMwm2lTZp72S6rNj7Vxwfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(2616005)(66476007)(6512007)(8676002)(66556008)(4326008)(5660300002)(1076003)(6506007)(6486002)(7416002)(86362001)(66946007)(478600001)(36756003)(52116002)(186003)(38350700002)(83380400001)(316002)(38100700002)(26005)(6666004)(2906002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KI+BuBtA2SGOPxR94bqcmsRJDSjZJWHGKtfJKic9an9cxeqw+3uFaVs3rKfS?=
 =?us-ascii?Q?u0ets3dIc9pfDeilR9AIukhpG8zXIPu1/EYcjW78dcULQ7inuYfYzejMOt5q?=
 =?us-ascii?Q?icx0zbXYt9K+/fc4XgHx1cQhadmPKa4S/oYnnxLI4NiXcgoytZqS9iJYkCyj?=
 =?us-ascii?Q?+Ht8XQSbOG1/9KLtFTgkE28+Ip4DZw55rFP731zFcSjBEg4/OpRWZd5pRNBl?=
 =?us-ascii?Q?/2ZsaV9td7CkGINuEJy8CaKESottoUeVrbML71q34DIsx1XF8h/HtBGpzQ3l?=
 =?us-ascii?Q?WZzG6nra+URk3GWe/quPQ9jx0mySQHCSM7FHpiuTWp2rBtGIaR3QAqoCloPM?=
 =?us-ascii?Q?rr/MkQdbeeBRY7HtKIosOUQQSz44H1WJY/roxXDjUbWLV8laZyX9MDsBtVP9?=
 =?us-ascii?Q?bDfxtmkBi8+PKaB/KIyh7pVn13s+/oeFSvDGjkwblSaMHRGFFiOgv+naN3xV?=
 =?us-ascii?Q?PzvEWO8VvCiSNyBof0pRaBy7iQvm4JUJOC5QWYXC2nkBDCMDctny/sMRWEVs?=
 =?us-ascii?Q?p2ghMApO7uBPUnRtfw4PadWQ7RKknItZnMA6NUsUne/Q3oogYGl8Zm3SKJ3K?=
 =?us-ascii?Q?sdF6zKuZQuv2oFggf3nRvubp1Jc2+5TDxwSjs0wAG66o4z0ClkPPgnCBAEQ6?=
 =?us-ascii?Q?cfRZK7IiK3BKNBXUi4shL9mX6+HVWyXqGKO84a05W6OtNTZfXxXIjC/rf+eS?=
 =?us-ascii?Q?DqifK9yuLlrIXOG83o8WxSAXUMufmcMUVAVAPKHcXj07ZHK8uHBsbrWne+wZ?=
 =?us-ascii?Q?dU3ePdqi/eu7qnMGPij4bin0T660RthtZoXOOMMPFydp3B+eu0vbK2QdBp46?=
 =?us-ascii?Q?Oac2gzL1csuQ2BUBw5MVGJ7hpFJlSSZCNfmbnrkpZI1N2kWzBv8ue7lw+w1b?=
 =?us-ascii?Q?FMovY6Z5RSvezhLHrmO9q9cbWTfofjBagFS4KDmrnB3Sepev4oSJdG/LHp6Q?=
 =?us-ascii?Q?/xstDQCptWtV9Z9RneRUUXYZa8WQ82UzSOHB7rDFeqmFeygXLQvQappkPgmi?=
 =?us-ascii?Q?Vp9u22W9lJgxCh5aNBrw9Ywzg2jIZ6pmHSbVbKHi7rec4sXnr49kU8+gJE4D?=
 =?us-ascii?Q?/U5vSvkns2jINS2my2J0HRG8YLV/3oHj9YFrx55ENpuvCg6sPtw6+k3EjBtp?=
 =?us-ascii?Q?AKSrtpUWJSt3nn+u6Nm59jMh3iqVOfwSXh+VuZRZsN2EM7P/QdzpLa//Y7Hv?=
 =?us-ascii?Q?5mdmdzq2HrHogZfcwao3YVS3oZwVmDHhHlLIwWIjMgaT1mx2B6J0FOCPXMjo?=
 =?us-ascii?Q?nFsEFrA4BCkuw3DaOZaKW1Aw9FCJURW30f8vCfL6MZohw6/zXpphucbDcDVM?=
 =?us-ascii?Q?84nN7gdaDjVbKZHDsWQXttGg/ORYpKAuYHa5Pre1qFJ5SQfHkJe9nm20Rsj+?=
 =?us-ascii?Q?LnWn4GAbnPM1uj2ECX2bHJLQ5oVYqMhU5BrZcArDZRmWZM9ToyzEWgEvFdzy?=
 =?us-ascii?Q?/79kGG0gUQltAVyh03GSmZ6EikVrxuJ6anhvEUhSwBu02GmZJ8/lW/Iwip/I?=
 =?us-ascii?Q?V3hwGmgzIQNpuh8zPxlokDM54g0OdC+PF3XS+eJf0hwWtRkFwUG0RKupgePT?=
 =?us-ascii?Q?+ja4fTYBEP1x6QpMuFLYz59+ag5UvMPivvxYIgO0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260ad5a3-e2dc-484a-0c9a-08da74564677
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 07:11:52.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnD9WcF8b9RSTTWvGdDIeBo3BA/G5jmRcfkkOTSh+BRabQMc/BlgQ0osLnjdXx7SZNZhgdebGf8z9RJ8AdHAEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series aims to add Freescale i.MX8qxp pixel link MSI bus support
by using the existing simple-pm-bus driver. A power domain and two input
clocks need to be enabled before the MSI bus accesses it's child devices,
which matches what a simple power-managed bus is(See simple-pm-bus.yaml).

Patch 1 adds support to populate simple MFD child devices in the
simple-pm-bus driver, since the MSI bus may connect those devices.

Patch 2 enables/disables functional clock(s) as a bulk in the
simple-pm-bus driver when the simple-pm-bus is being power managed,
since the MSI bus takes the two input clocks as functional clocks.

Patch 3 adds dt-bindings for the MSI bus.

Liu Ying (3):
  drivers: bus: simple-pm-bus: Populate simple MFD child devices
  drivers: bus: simple-pm-bus: Use clocks
  dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 84 +++++++++++++++++++
 drivers/bus/simple-pm-bus.c                   | 61 +++++++++++++-
 2 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

-- 
2.25.1

