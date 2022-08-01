Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43405867E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiHALBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiHALBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:01:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD01F2B608
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKoNmswKQ4f3g8kyo6fl8KsF9PO0eUMvYQRSmiw3P+OVmZIRiFccqaGr06d/LD5HxRnAR7KIfVKgZxYdF114bOO7OkPdrrJG21iaFySURQKkdSNmJD1o+gQB4UC1T4AFNxBaZ2PkQQXEDaRMleSfu1BVsjA14u/3K2lVjZK48/gyVqeVHfW+ceyAvyt0MAW8XNjFjwubPVuWFMiZrO6I0X0jqut4Nj1wRqkYNO2wFL3HvVJ0g/ChMEVK/tLfulYQEW9i1KD96YLRRDCVP1l3xKUWz5DbHXqCu7XtdR1e6PHRGJxieKsne+B2bZ/muvXc5ganE23FDHtO/uktNlDxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfaWl8ED+UYhVYfWeL4Id0d7tMFHpc5j8rhhsHdd0pY=;
 b=bdL9C/bO1Vpq5tgxeliGCGMCFfLyp9r22YiXyLv4WPympFfC8PFPSk18Bgnlb2ST9KbBWYgzxKO4mKv63sjGWJULFd6f+DYe5dRu/swC+HoAEPigfO2JjqKSCAG+ZXyprvSJDtxt8+HFbzwqv7oNLme60+8NSYd/Uj4/7ONXjJVUJsZTsNa5pm2G7hrY9lbTyG34bGZTsU4VrbTjZUN3PCvB+sUJR4AXMa6BU0HPoDUkvYwukmTQNISnqZiZ5fl8XY8ax2f3zLbBoiMW2DPfcugnFcgzkLCDY4UkR+gewbzZ7v032TiZBqyNZ5ZNgwbbZh1QE1ykBhl2eyVb2HA/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=diasemi.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=dm.renesas.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfaWl8ED+UYhVYfWeL4Id0d7tMFHpc5j8rhhsHdd0pY=;
 b=rP+2JU2sJ8VeSmyjxMmooGm+lLiWgUSoFR5o6KT1zF4PZgWJ3vCVGorAeEnfXIPx+yIvDXKy/+AxNZQ+PIMl7LFVb7/rDeWYd82K1X6aInZbuEHL+MVkP/y6winfd38dnvYFd7SbuFL6iG3LQtc8gWnJJ7p2hD8qXu0irNO7fsM=
Received: from DB9PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:10:1da::22)
 by DB8PR10MB3193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Mon, 1 Aug
 2022 11:01:41 +0000
Received: from DB8EUR05FT035.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:1da:cafe::4a) by DB9PR05CA0017.outlook.office365.com
 (2603:10a6:10:1da::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Mon, 1 Aug 2022 11:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=dm.renesas.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 DB8EUR05FT035.mail.protection.outlook.com (10.233.238.241) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 11:01:41 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 1 Aug 2022 13:01:40 +0200
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 1 Aug 2022 13:01:40 +0200
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 22379)
        id 7DF6280007F; Mon,  1 Aug 2022 11:01:40 +0000 (UTC)
From:   Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
Date:   Mon, 1 Aug 2022 11:01:40 +0000
Subject: [PATCH] MAINTAINERS: Update Dialog Semiconductor mailing list,
 website
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
Message-ID: <20220801110140.7DF6280007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db090b2-b094-4443-addb-08da73ad36d1
X-MS-TrafficTypeDiagnostic: DB8PR10MB3193:EE_
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?keFEL9u1fpZ0b6rQmWxWoHXF2JY5UrWd+rSKY5rwx3yA3IekH4ynpLRAo9t+?=
 =?us-ascii?Q?VBliUQyePaqFOayBlW/aIG8Zs0oU7zj73Efj21ZteHsNzxw42SnJoVTJnGxh?=
 =?us-ascii?Q?kcMZtf4bzAue3b+EpieKBgZQvb/64uIqHBwAk2YuMGYzqQEAG8gx5fbLOQCY?=
 =?us-ascii?Q?XtfYcNAqnZebFaidxMsmrAOER3NF7y3oad64gl3kcTCenuuRdjboQm5CkK5G?=
 =?us-ascii?Q?dgClyH9T4goGnNvv+F+Pi1l8G650RLxrh2YNkr5eBZAvrsU+nIY4J8wp7YkA?=
 =?us-ascii?Q?AVUHlam63/95CVGQ9cNXg9eDCeEGkV/fP7jWGxvLAukVuvSJaWTazu2zPK7t?=
 =?us-ascii?Q?+WC6wJrywA5TM2qh2e0ZIEzc6fd3c1w99L1v10GD5y1QvFUz8uV7/JcpeO0Z?=
 =?us-ascii?Q?3GgjtNHplHsmC3ysnwo8UqpOf8P/1XG5/A5nmLfpb/m7U0WyjVn1h7LuIuEZ?=
 =?us-ascii?Q?ezUG/E7EoRqWOW2nWbPbsdPBDe5K3iH1FxsTRXevksu3euoAPUJ2JJUwMWhN?=
 =?us-ascii?Q?Z/fuufFaAAMfsoFwj19rhhjYqX95VytbuiJbPKJJgPGujfgUCIuzCIQeJgor?=
 =?us-ascii?Q?iY70PlbmqqGuvwmRXXQCz43kmXkhyrTJXYXhpZh9P7Wk8uKtzJzwfwh+HbII?=
 =?us-ascii?Q?Lo47F7I0yta/AxxQL81jT2KuCTnyPRPWNb8LJ4gYYXJTzgYm25tqrNj9NgZP?=
 =?us-ascii?Q?YQg7m96PaWuF6SPxjFGzeH4/XyWpT0igIdYnLj01ONZAWZ/uwclXTu0WzyMc?=
 =?us-ascii?Q?R42QVs+i5YGGv2wJ1bwJwJPV8MdxGEgqvXeBfcesiFERbX1daP8tzfwt2Gxe?=
 =?us-ascii?Q?gj7t76h12eDQh3tbLbYc74WHdvgAgGro6cCeFyaQyzEkfiF7a43jpisp/hpy?=
 =?us-ascii?Q?mjXBYncge+eNRXut8r0TucujrWyQL6EtA7CBI8RrZe4MRsVTA7Gb6hDlXKxF?=
 =?us-ascii?Q?WApfmTcWi9ST1HeBBIROCg=3D=3D?=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(2906002)(36860700001)(70206006)(70586007)(15650500001)(83380400001)(81166007)(8676002)(82740400003)(356005)(4326008)(83170400001)(47076005)(966005)(478600001)(42186006)(110136005)(40460700003)(1076003)(186003)(316002)(42882007)(4744005)(336012)(41300700001)(9686003)(26005)(6266002)(8936002)(5660300002)(82310400005)(40480700001)(33656002)(223123001)(36900700001)(130980200001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 11:01:41.1969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db090b2-b094-4443-addb-08da73ad36d1
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT035.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3193
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now Dialog Semiconductor is part of Renesas, the mailing list and
web addresses have been updated. This commit aligns with those
recent changes.

Signed-off-by: Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..b1015d06d429 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5923,9 +5923,9 @@ F:	arch/arm/boot/dts/stm32mp1*-dhcom-*
 F:	arch/arm/boot/dts/stm32mp1*-dhcor-*
 
 DIALOG SEMICONDUCTOR DRIVERS
-M:	Support Opensource <support.opensource@diasemi.com>
+M:	DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
 S:	Supported
-W:	http://www.dialog-semiconductor.com/products
+W:	https://www.renesas.com
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
-- 
2.17.1

