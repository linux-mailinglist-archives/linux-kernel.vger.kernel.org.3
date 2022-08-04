Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1E55897A1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiHDGKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiHDGKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:10:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC1C6110D;
        Wed,  3 Aug 2022 23:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWOKTPr+ue2AUepYs30ZCfZ83BSDqqyXGixkDo/dRG7mkS1Jqnht35/3qzHD6ytqLOoHGpGmAF8pQZQ2Pm1VmIhJHntA3bVvO/z34yoJwz8wXP0pBrZ2M4obdlUVuIhaNf+uC7QvrN0aCV/NKR8n7T+MhB/xYCgKl1XiS90gPTz9oGOyBbIRFuDnHFe1+/SWEj7TjqlNZN1O2J9c5vHb3CVout8sW4i4HhmLSn29XzMBD47FTjJelEiPfcYoGV91xQclBbRF8rIOId9K163L51Ru1WSL2yJWsIMatJZ9cpaUIgbDB8zTPKk9Z+5K+QROrReDFYQI3IW6WRH8jzS+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrTYwvvlNqzQygbT9FcPjuvNQWCPSVW2R5YbKDgQcCw=;
 b=UEpRe+l8KTvj8WMkweJUixg7BqW17rF9uAFPkzRBrmbgRtbjIaQCxuDgC3wElCEDSJTvIb3hiGnRWjZqx6K4Jxs1nkcdz7lF31JwjtfCQ8iZU1MrGsvYWhAdYuQsSjcMg+rQZZqDma5LFYfqh5RqO8SPbSv0Q5ziTAox5XrpG8JY7HdKt0F7luuuAbT7Hr1n2gyiqTgnKHch6iNgmCRGnkJ8DxTsn5lTkjLzukhmW5Q2a17hEKKw8d1hBfrBjXmG/++UEMvduhpmJwZ1bsv44YFjmYXHekVHmvzIy/UsPlXUu+kjmPOZuzOZ4lg7YW36HSEWfC8Ug61eyqtdfbF4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrTYwvvlNqzQygbT9FcPjuvNQWCPSVW2R5YbKDgQcCw=;
 b=DGarc/00kgeEU80w7+WLv7XfcnlPA5RiPE7PwHG0WDAG1JSfcMZssexjXXvgd/XkRsrvXlWsgWML4axO625Fganztb9ye0N9uCZfBRpb4evrjZUk4UK5UpdLg75F7fl1I3QHx3OV1qQgAKKks05bDUam2sQwpO6c1P2NZSvWYN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DBBPR04MB7721.eurprd04.prod.outlook.com (2603:10a6:10:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 06:09:57 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 06:09:57 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be,
        krzysztof.kozlowski@linaro.org, robh@kernel.org
Subject: [PATCH v3 0/3] drivers: bus: Add Freescale i.MX8qxp pixel link MSI bus support
Date:   Thu,  4 Aug 2022 14:11:30 +0800
Message-Id: <20220804061133.4110734-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c16623b-bf6b-4421-e5fd-08da75dff4ae
X-MS-TrafficTypeDiagnostic: DBBPR04MB7721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+cuDfixZrlrSJjUEx2xAL+Z1NBk0g0ysEg8n2jhrC6y0dh46IILuyb4uy0hunUqiRfl2kzsCGGyoUHLto4AZsDI1o+8HjJUMM/PuBVisewb8VlncZglPZdJONtzIuHRLh7GNN8m93y3ZKh86xqsyJLZmeWuuBEdmJ83K3m7FYYHjQ+Tq9wfOMuzCM+WQfC9Iy9PMgBUxuEUdinx7mmCMmYzehFv4OVklfz2V56JGPEDdbh25UC+YF7mFzNEwaXhPvO3Czdca3bWNrGNkMPPL66paYkBymquIY0DOO6iT+LQb7Lw2lWIT8PsxXTNN1SBXwk1Z83uZ2tPaGr/gLH3W2fiEEoARsQkKaqMpg7rSmPFLqaptgtTBlXvwhjAfQXU4CI1Pqt6eTQsZj+5hWKIH6WgaR+a9sSiTCP5ddPh5k4nhCzKxDq7CE6gcPfNK5NDyLwlolRo20ao3hr0CTi4krtHXantwiwPpeUcwMC5HfEEfTjLci5ldL3OEoTFCOsJ3njrh90tt5Kxiq5KCdR3JIfuGUsJA08FF+SFoMRb+zwH1wMV2rFm5M7ponWqWb5VVE1WNW7VRVcYVWvYeVIw+oOcY3/nfQd2rgpI1PJUsGcnjfoeV2+fNbUw0XW5+XEldN2Nsb27nv4dLTYZ9PaPMu/WbW4AzqYkoJio4gqHwp3aqJZYo56ILWoqzPwP0aaHwhJS8s8RwXZcno8h0vPcfkfrXYKWMRi5v1ZqSV8ZTGvwBkxBrQQwTrdbLZmsntLAqABKcDQGHAjegxuloRUMiZ+fteodSdu7QhWZSNWJ7kQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(52116002)(6506007)(41300700001)(2906002)(6666004)(2616005)(26005)(86362001)(6512007)(1076003)(38100700002)(186003)(83380400001)(38350700002)(36756003)(5660300002)(7416002)(66946007)(6486002)(478600001)(4326008)(66556008)(66476007)(8936002)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LvS/SPDfKpiDMsXg7uxDdF5DCwIWZHhqCWSXVBuqACEMAsgfi9pcdsQn1VPD?=
 =?us-ascii?Q?TyQRI5nhpRrmXb2ofSVLf7lPDiJGwqRcna0W6YHBWkurZLU4ljjlIynzzBVX?=
 =?us-ascii?Q?8NQwIhoUfpVAFwct4BjvRac15o5oMwnFeBTKd4X4A3kYTcJTeAGK+ss2z2cY?=
 =?us-ascii?Q?MqIS2NjtTSXa8prsoeuOHj9xCH/+XuN5MhRL4ZYntRqzIklaR+SqcDUhvqzH?=
 =?us-ascii?Q?MiPh/vDxCC+V+J8UmVErPmcpDktnq62aENcMQqmHwbRy+68t5dsbLDMcbQCZ?=
 =?us-ascii?Q?6aT7bnP15E2FCMc9Wbi6sWrJe9xKoz3a2ExBTLjckC0OnxJ6u0DDi/3NQcbx?=
 =?us-ascii?Q?A3OBDkQUgltToI+JcSqTMVBukxTCKXF4OljrZjKXTWZ7fnY8qhg1tPyG3caL?=
 =?us-ascii?Q?guKsIWcupUiiZc3BycDCU/aL3VRUCFLe0rb9w47t1ZRlRtvfeP+OxdTV7AxC?=
 =?us-ascii?Q?FScSTJ1eCRXpCSQx9bMStJxsOQe+mQ7GMndY4RQynYY84RWxEwq7KOPSUIrC?=
 =?us-ascii?Q?dHw5k3mExNzcqX9D+MDqiA9kFRBZb+d6TY2Un+T1nu8cUh98jpokPsXgPzjh?=
 =?us-ascii?Q?3sIEm7DL3kzM2XMwUEP5g1I9p6O+2qzrBgJmN87j3uLus6pZV+Zy0d+l2MPw?=
 =?us-ascii?Q?FCKDmY4Vv1nsg/aWc4fE5WQx3MsqvFCjW80OmyGJlSetsvrbObxfp4bLgrd5?=
 =?us-ascii?Q?VWGSWRBhLQs8AMlB0srAI5YCkhl8ZsnAznnu9Az8H0vxQJqtTmpvgPMpZzUB?=
 =?us-ascii?Q?M9OY06LdVvBgzE0gkZTvP930LMiAH6cla+2g5eig+wFboELXyro85Y7Foa6r?=
 =?us-ascii?Q?UtD+NHVVWdxIlVPiGDWg0tdrJlJ3FHBaw9lWrNcLvYpF+4UBgEJFr2BOzsPD?=
 =?us-ascii?Q?caJKUIuJGhDfIAUH06UEVJevsW5V+Xfm/gMLxBKdyxgqemlI++RBJ55DaGfR?=
 =?us-ascii?Q?3lJEwZ2fYo8DMj6YQu9b5XvVnKiIl4H9AjwiICwIzMtyjmptEg9NUapfFBQa?=
 =?us-ascii?Q?HqK1l6F9/Qag0Y2eW+fW//k4Fm18f9dIup/STw7F7dWnZfDW7bsG+kAYkXUo?=
 =?us-ascii?Q?auZl+cJugLBed88fZc+SLSdE9ZulMFMXLR5dFrycvXHO/13DbhL42P+wa1qs?=
 =?us-ascii?Q?6ulnSQDfme8BR4W0KBDSTD2Ieykxdff2L8/a6L0DP8UKuCiDv7IjcPll/A1K?=
 =?us-ascii?Q?YAUtSdlyMYl8xYdF2YtQJH2GxNdGBsOnJvP81BppAMShmtNbDes9NVUKESXd?=
 =?us-ascii?Q?z9mJ8cVsghm0UpOgh3AqziW6ZC8H91rpnQyfAhrSz0iuUPtuSIeSCe4B5FZV?=
 =?us-ascii?Q?vCKu5yP/pzfo6wBk4RVDIb/k1+YJ5cfpnIs8KDCkB81bqK02Ur4CogGdzHY4?=
 =?us-ascii?Q?oFVpKcHs7KI+RbaxKJvmr/Uj0hAtj/Ro/jRoCQ9hWY9wRn+9V5dDbNm+GXPx?=
 =?us-ascii?Q?Al6DEauWPB+Eb0Ex5VD3qTFgSqWEPVqtVNp7tKorGQMH2vuTlHlRdu10MPRC?=
 =?us-ascii?Q?ZjT4NScgLCRQRk7BSYwjZ20SBnTzua7yvhAf9Sr8SFtyDsg4Qpf4ifBQxIy9?=
 =?us-ascii?Q?xejH+XWLOH96Jh25MUQjeryxsFLNq95kVcR6jpgM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c16623b-bf6b-4421-e5fd-08da75dff4ae
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 06:09:57.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiPRuh4s8IrQzG+3oBHvkriIYyIvJ8qRLaJ5tUh6+fWpDrTIAaM8nRCqvoUkNjwd/ZWtMXanJr3CceDHgLQPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7721
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

v2->v3:
* Add a pattern property to allow child nodes in the MSI bus dt-binding. (Rob)

v1->v2:
Address Krzysztof's comments on patch 3:
* Add a select to explicitly select the MSI bus dt-binding.
* List 'simple-pm-bus' explicitly as one item of compatible strings.
* Require compatible and reg properties.
* Put reg property just after compatible property in example.

Liu Ying (3):
  drivers: bus: simple-pm-bus: Populate simple MFD child devices
  drivers: bus: simple-pm-bus: Use clocks
  dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding

 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 108 ++++++++++++++++++
 drivers/bus/simple-pm-bus.c                   |  61 +++++++++-
 2 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

-- 
2.25.1

