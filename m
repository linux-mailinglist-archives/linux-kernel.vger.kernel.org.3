Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98750BC42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379064AbiDVQAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359761AbiDVQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:00:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2024.outbound.protection.outlook.com [40.92.18.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB75DA6C;
        Fri, 22 Apr 2022 08:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTnVXgwJnCZO6LV9hmy8FA0+MxO8zSS5sR09UXzQqIrlDXyWSa/DWN+SbdOVjRbHACOMhUG9EP1NKNUebS2kCJNs8NcJqq0jGO7GbT2TTaK8mZ/hNGl0cfWZA9uoGTp+BIDSAV9qJCZ2McT029YYaIV4O/4wcmceNBnrRIvbqkp270Y33LodLaVieW+e3al17eDKIpZSrsdf8ts/b3YN7Np4I6XTuZcOCbrwi38bE68TCZqLgFA5Ff2rZdhvn73ZPbqoOBNR6+3aqhw/EKO49Lvh5h5ewvRBT+pFPdPiTZF6U+R8JTn4v5+J60cq8T+SBmncrlUENqlXCdsnElYs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKpEmtp9RMayqqwy73qUY48gl+N3dypvzSujzRpJz8U=;
 b=Os1seaIQBQsHPd61LkjK+8QVzOq9FKGZUK+GR82RbhQvdzcInyILOHF+q6aNsXw1y/d6HiiGOM8dXxbxIIDl75BQus8PISe5kf4T/ulgJa0hLTG0IF9nZ9p0kfvik9EmJuucIADPmQPiiPUQtRFl+95QhRwuNlWi9tyd8dbF6jFzTiMzwjr6sKJNL6oNgjMM8UfBeGTvX36dPUktx1hkVVVKI7I9yRhQBXdAW/ybtZLqUjl2OcB7xz38FN7ubq3Z7LqN/TSOj7/mWOp6yLXoXjqbMUqeukjw1iucgEhYoNYaS87g5Wd/Xf/FKmkADtAEZl4D9+w90cOH1R2h5wwlIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKpEmtp9RMayqqwy73qUY48gl+N3dypvzSujzRpJz8U=;
 b=liflq5B8261Ba9M8rZR+XQ8/E586LZkgrL1lpvXANTY2Exa7nJBjR8i6arTxACLAdtsqSEOEvqZqz/PNyMqLnuENhuEt6CS704jFN9mS1yfc458qLKTJsTeG0M7a8qBq7ODj5A0ZloXz+egrQYWkutdyLb+BhPrNlgPVXmyxhS0M/2KbduNQqGub7XW3UEtosiN/wkHY+Oo6OVi2ZvqUXY2ylGLWGDVF9enHQW+Zu/783SLfvg5FqO6UiTc21nADk7HUiFFoYujNReTNzCZJ76ovbNvsjQdxYy9yfIf9m/R1FerbcdEgUPPi6Y1mc4cMViMkpmMAxvEKzUj5RSO4FA==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by CY4PR2001MB0917.namprd20.prod.outlook.com (2603:10b6:903:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:57:08 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:57:08 +0000
From:   icenowy@outlook.com
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/4] dt-bindings: spi: sun6i: add DT bindings for Allwinner R329 SPI
Date:   Fri, 22 Apr 2022 23:56:36 +0800
Message-ID: <BYAPR20MB2472E8B10BFEF75E7950BBC0BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422155639.1071645-1-icenowy@outlook.com>
References: <20220422155639.1071645-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Pf4conUMeUNmiC+SRjRWR2vj3UHdPxhV]
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422155639.1071645-2-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5146ba69-61fd-4c65-f479-08da2478c0fc
X-MS-TrafficTypeDiagnostic: CY4PR2001MB0917:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AeatGBENgIKCRLI7sZT6dB3vgZRkYF0H5DKW7csjehaKxfqWJu+vAkds2zGLPxXK5PKWdaMcxVrs8YSThib22heOd/Q/V0SvVWfGjuZvgoh/JOM7f3fMM7BEmMbfQzADhmZeaSFqltZeKCKfhjj1gAkq8veL/PcRT8EXNjKC5vqNz/FTN9hIlme84mFhAZO10m1+Kzo7RvyyeL0uvcHKGCVi8mhyKyTzD/kHCPqa2aINFJj6qjEudzUOQirMaYVJC96dXbxSE3JICfrC/RTR/KallrSYQUjwafnJi4wav/Qwb7KdkB03TUdkrSnHpVyUiEGPdv4RfF/JObOd60BLgu9Z5iTnwgnGG9JOf9Ro+ItQW3gnF4Y+x8IpQc/eHLO6KkjGnvJlFoBPr3S4Q+lhqo9zxT/OMP06LaQl00+LCKj+5pL0yjY9bgLbFFATFevlsnK4i0FZ6tOx6BpxHpKzwWTgE/KVxb0N0RdgRxqh3p9IagfU3Etxi/5T0jwqQ8K+TB32P+w9013ZtTMJhX3VzHxIh0/+2gkyUFDXVKQF41ld399OuRnA5YKT5iZ69dvNyOYBpupfk4kFRm4Za3qiNQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgsqG0p3WWRcrbbCOvo+H78JiKw4LW9evUp5QVZfGvoPlg/nIauYGiBF13H3?=
 =?us-ascii?Q?TJDb1SeF+vl9kRO97Ddb1TNFQgUoaZ/NxBpEvWoRNtb421YSajsyhkw6sNtS?=
 =?us-ascii?Q?VjpjnHVoDfRayHgtaNnQ/qXILkRFh8wHOGjbbNqCQ3gsCDrQuytAnoUBkB/v?=
 =?us-ascii?Q?U9fyRj/ILRC9ZjF2fleza/3HuxRHXgX6GL1aZvYeWYyXS8GuV2x4VO6CQGR4?=
 =?us-ascii?Q?9e0aa/G7R/V+FdVOd5PDMTLTlB4gPNXvP0WrVuZ99mp3x42CZ2/Q5gEAvBKx?=
 =?us-ascii?Q?7+FDHeAHapJ+eN+zHp5WDS/ltHhUr/8BHh9B0SyriZfyqljleLsIiYjrEKX2?=
 =?us-ascii?Q?i7Xm5OfTAcbcesdBWOuxJxjxcjfsjfjS1QlCxL06zGX/hWMPl2MIvvhJ8R3w?=
 =?us-ascii?Q?cknhpsXwQltQ8aCEmJR6mw9CIsrKI2JR7CWdiy+PtuS7y6pW4DPNzLfNUaJF?=
 =?us-ascii?Q?svXu2fpS7g4cr6jBLaV41XLq1PXC46T7GMYqZKS/q1K0a28veMrAkGGIuZql?=
 =?us-ascii?Q?Ely8B38L2p6xaj4Tra1FCNfZXjr1D+AJgHFTGvNQ88zcy1UyVuo7f8UNkZJG?=
 =?us-ascii?Q?yLFqeNTNd8SiHYTj6X6d4U9WA/Oeo5KCTv7N5XMop7Ka2LQyQO8smf54tX0Y?=
 =?us-ascii?Q?pfX2Mae4tKgLCI/EI2ONx694WW7UgHaZGX1JoN1BF2Jm0bzIQQpPq/URBqQ9?=
 =?us-ascii?Q?bWTNJD84AyqCBhzTy7+m2N4o6dQLNfGuc1hM0eEj6fJbEJElyxXBeu8k+gjp?=
 =?us-ascii?Q?McvMVhjuA14gR/0WWlo+3G+oQBLKCfN98SfHiimBg934Rn35OFYJ5mrpBj+z?=
 =?us-ascii?Q?oVmE9gbSD2qr4sHRLX6qN75nIxCP5KTlx/w+SGdbPkPDo6F6afh8ghYkiXHT?=
 =?us-ascii?Q?uebiBnl15vDT3bKY8DddQO1atf5pBLEOht7XTZCEl+TcfkD5PxY00fudAY0Z?=
 =?us-ascii?Q?NwZwywBksJ+lDkScxQHF1l03TM8kDiYc+VNZxbPK/X5Ubh26nHiem+ePkdoj?=
 =?us-ascii?Q?XQpSP0n+qgDVQje6P/9cIeR9uFlKT+swxBfrTtayIJNvR6raTCLQMGXEiEz8?=
 =?us-ascii?Q?0Q3WkFyhkyShF/UuPjPH0PE3m9OX858Qp9IOPzPtnx+B1mCXRmc6c6JTVEI5?=
 =?us-ascii?Q?sAevJkROMUIRIpqSk/bBvo0qm3ikWBtaEG86ZF1c9CfKA9mCwQL3AvbTX+Q1?=
 =?us-ascii?Q?AdzrDKN+vfnMyR4Xjuq2qtaUMAivxm9YBL7rw9dOW+gadpxTJVExnbCYCzP8?=
 =?us-ascii?Q?XimY+yHK4iWYkmd5XEhDLRsqplGqpjp8ynDUGjGLdDKKOV1YDDumYbOxR57K?=
 =?us-ascii?Q?faEruFsANg5K8J0LVd4SGEbDEAd6PA2FPZJGEVnntktEZI91Gp1L0e5788pr?=
 =?us-ascii?Q?QG/GHTDeUlR9OXYhli5XkJTEdhSI7L6JdF2M5ES8O8AhP7cm4Q39PoOdnytf?=
 =?us-ascii?Q?7ROAXlqZSu4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5146ba69-61fd-4c65-f479-08da2478c0fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:57:08.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2001MB0917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner R329 SPI has two controllers, and the second one has helper
functions for MIPI-DBI Type C.

Add compatible strings for these controllers

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index ca4c95345a49..6354635241fc 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -21,6 +21,8 @@ properties:
     oneOf:
       - const: allwinner,sun6i-a31-spi
       - const: allwinner,sun8i-h3-spi
+      - const: allwinner,sun50i-r329-spi
+      - const: allwinner,sun50i-r329-spi-dbi
       - items:
           - enum:
               - allwinner,sun8i-r40-spi
-- 
2.35.1

