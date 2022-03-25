Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7804E7074
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358602AbiCYKIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiCYKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:08:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613ACD31D;
        Fri, 25 Mar 2022 03:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e47SJV9eIY5MDBJaRYqOYy4YA8Pf6YyVsETJLMOPOjSV4EHgf72Evm2fUot3GJ3GJxI19S5axRKcF7GUQO8laZvAwcmAj8nKK/iQF7SIIKDHfBReWmnupF9j/Goce4var6tSSLBc0lOPxNP0EIDynz5MydMNxieP8ugrM3KOF8o8c6DYfXeGUtBHvpt/sTCMudh6RRfKG0GcwTuFGxcQG9QxkQ5WcLESD73xyHjH289hTNVSFautvAjbTwOGVY1kFAzRmEkoYuN8cV3x9PLh0bfIZnvqRZ9Zb0Jmo6pvW2ZHaZHskLSSu/wmPUjW5hDH0aX8MUE2KxHkQv3qdF2XUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn7qvMDY922p1ScjK2n2BUFcFXFgq4uwXHOePcTAp2w=;
 b=nZiymIe3J20PQjvN/mwGCFJgsUWf1LuR3RzqcwGyWuZdiKueKE9EWxd/ftNIsqyHJwD+TBQkhJaerR9tCJFpdHO7x9fyh2JHlfQ9IAa+bomAlvuYK56QIfNaAgL0HYbMOoYuwgN/wcpuSydtWyXKYiUkHFn1vBrHuy84Khq84FBzpKo4tKk+vWoSheNkxgyko/VcBQwbJ/dikWX3UMAq/Sx9Z0KVciKkM6sz0IDzrrWYlPzRzjSqDANbHc9JNqBlDxaQsKFdugU04CQh/EGw80u/eKU2oB3jODU2TJLqaLjPl1lwzu3fWS9wtVIZUj2eO9QdLLlfiPQ/WKFttRtn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn7qvMDY922p1ScjK2n2BUFcFXFgq4uwXHOePcTAp2w=;
 b=AMhE77CmITt8tIahjaFWxbyDMxuF7gYRbVGc8hz/lZPz4hyMlxxiNlLTnR2IF4nLfced+UTyukUu4GwZE5IRCedYb5s5iob2BOokXW67c8bXP7u+QuD6YMVOdvqU+ah6sCTSTPIC1XFBqjgApuGvK6deW5dF6T+awg6iECmvcKE=
Received: from DU2PR04CA0278.eurprd04.prod.outlook.com (2603:10a6:10:28c::13)
 by DB6PR1001MB1094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:61::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 25 Mar
 2022 10:06:38 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28c:cafe::bb) by DU2PR04CA0278.outlook.office365.com
 (2603:10a6:10:28c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Fri, 25 Mar 2022 10:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18 via Frontend Transport; Fri, 25 Mar 2022 10:06:38 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Fri, 25 Mar
 2022 11:06:31 +0100
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Fri, 25 Mar 2022 11:06:31 +0100
Received: from localhost.localdomain (10.167.1.162) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.24; Fri, 25 Mar 2022
 11:06:28 +0100
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <robh+dt@kernel.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>
CC:     <sjoerd.simons@collabora.co.uk>, <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>, <Gireesh.Hiremath@in.bosch.com>
Subject: [PATCH 00/15] am335x, guardian: update board specific dts changes
Date:   Fri, 25 Mar 2022 10:05:58 +0000
Message-ID: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.162]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3ce99c9-5811-4dc9-ed30-08da0e4726b5
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1094:EE_
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1094A3ACBB4A04992DBDC8A8A61A9@DB6PR1001MB1094.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bK043cTZT3aVdSfDeEVJegAPWt2m7SqmNvbZyxjantepC2Dq2Bo/qVswPzhHPRuKz1eOdEmMMMZX+EaxsWdqScyBbbnW0ptXLZRG0cxWuq25E50cX4aRfvrYILudfZ7qVrCjH9Zxoss+r12SzeZpi3kjUFwzx4Vy9HIbZnzBRc6BdL6WX1Agp1a10QM/GbBYBqHTS3hHVxUiE6JqUYEo5Nk9X+ptOpLlyE83hhwLdZeXlBGpgr50saINjqk61t9JhFypbe+V3IVFitCcfbxOXwQ26pLJ5WS+nL2EkHbN/dhUVrzWXwibZZ3c4eP95vRjp7BkmjYdch5CHnXr71gpgXg3pHgvZ8ZLcTK07I2vT0KgESZKpD7ATC8b3f+/K8Tbf1sMXQgQXfwPqA3z3BKyvrRBCmOGIJiHESwpeHRJMWe9eCUHJiCUF6OQxTM4Tg98il7SAYrc4r4WsS57eCkFaGjTl6tJekrQETdY2phnBDQGgx3FuTmMxzqTmTnE9UtIhLKf4G8aM4gGmbnIoLTjnbiHZq0V2pY7zO0uJn4vMuZfKI70uSdMUlLtP2BgYdznpWClGdtsCPv+RI49E+in8WxNhi+MUsQWNX2oVWA63gcWrz7tWznzQpogRxFnMDZszImGK7N3wkeloCRLWdIDz/I5VuuWVlj9yMtLf8i+6+DnzCeaYYOfpaupGeYL26vF8ETDW8ZAsvmRiJo/jXPKKQ==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(508600001)(2616005)(70206006)(4744005)(40460700003)(5660300002)(107886003)(6666004)(2906002)(15650500001)(36860700001)(81166007)(1076003)(82960400001)(8936002)(356005)(82310400004)(2876002)(83380400001)(16526019)(47076005)(110136005)(26005)(336012)(186003)(8676002)(316002)(4326008)(70586007)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:06:38.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ce99c9-5811-4dc9-ed30-08da0e4726b5
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

update guardian device tree

Gireesh Hiremath (15):
  ARM: dts: am335x: Guardian: Update NAND partition table
  ARM: dts: am335x: Guardian: Rename power button label
  ARM: dts: am335x: Guardian: Add keypad
  ARM: dts: am335x: Guardian: Disable poweroff support from RTC
  ARM: dts: am335x: Guardian: Remove mmc status led
  ARM: dts: am335x: Guardian: Update life led
  ARM: dts: am335x: Guardian: Update beeper label
  ARM: dts: am335x: Guardian: Update regulator node name
  ARM: dts: am335x: Guardian: Add lcd port
  ARM: dts: am335x: Guardian: Update backlight parameter
  ARM: dts: am335x: Guardian: Enable UART port two
  ARM: dts: am335x: Guardian: Disable DMA property of USB1
  ARM: dts: am335x: Guardian: Update interface pinmux
  ARM: dts: am335x: Guardian: Add gpio line manes
  ARM: dts: am335x: Guardian: Update comments

 arch/arm/boot/dts/am335x-guardian.dts | 376 ++++++++++++++++++++++----
 1 file changed, 316 insertions(+), 60 deletions(-)

-- 
2.20.1

