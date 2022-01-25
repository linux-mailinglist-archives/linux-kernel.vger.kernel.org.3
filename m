Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D8B49AEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453957AbiAYI4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:56:48 -0500
Received: from mail-eopbgr80110.outbound.protection.outlook.com ([40.107.8.110]:35650
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1453196AbiAYIw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:52:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CchPKbnpDD2bLuRPjxRa70a422wDS8dPjIwsbUUwwEuPbgpYuA4+XO7sbqeGFebkxgM89Wk/GugsJ3GHgTRMlORE/aYS8S6GPN68GfI5aH6MSyLqvKUO70bghBkOBkKjGFt41HE/xUcjteEONI/UAl0CVKmkyh1rfdCT8SBPHqHmcS2djFJm3YlQqx6o2Pt6brRLVW1SQhlRfCql+7j1OXPjCwwLbRDeuC1NN0J1RCxhercuHd/vXlX8lZ75nMITTgHwx3BtkwU3XYLd+3pFoTAblHAdBwG+f2THfSVIyvZ6CidQtEiFzao/TcDZHB9MNosKPdkW/xSXHkeLVHJylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X07FiMvTMvbpr8oS6LHNALMIuFKEsGfxRzibfAZUf0=;
 b=kQzpmxxZ3bv6plhz/js0QR340DhrTTlCeD/UZQpNBvV6Z9/4a4vevCYplQ0EdjxDsdkZxpIzfVKRre3vIy9WqSnMDPe2kVbf8EMyv0XV+AJTUAmUp2IFdo2zcYZScRn4aRe4NpKkLwERhSVES9lGRQ9pehMdBo6ZEmsFXk/BOEtW8QzDLBMkW7/0b5E/N3N84oWuJLv2k6jH2SMvxjhBtrAFcgPChe8xaodCNkN55hbeXb4W4wVcHdaZ3sWq4Rap5fWiWvLP3BS9abAWjnfjUa7P3YFgPEpcnckSDsMnXlO7/RT14nMKE/vSZBQmqavG8msa1PDnvGRzpA9+0hH/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X07FiMvTMvbpr8oS6LHNALMIuFKEsGfxRzibfAZUf0=;
 b=BUGR6uBqZJOQOHgJy/VaJF0CxJNq04NMGOByvIJDDNF3CNVrW+Bz4bRoHWVbfIO8DWlg7mVzuKwHj3rl88oMgTqDTHEWcAQ5q7EIE11ipTSnFewmZziJnpZoC7ayh7jol4S6JXPrfP9ornBFi3JUMYlzpYoOWGBHwLE/UKsGmlw=
Received: from AM0PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::36)
 by AS8PR07MB8156.eurprd07.prod.outlook.com (2603:10a6:20b:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.14; Tue, 25 Jan
 2022 08:52:47 +0000
Received: from VE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:17c:cafe::fd) by AM0PR10CA0026.outlook.office365.com
 (2603:10a6:208:17c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 08:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT004.mail.protection.outlook.com (10.152.12.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:52:45 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 09:52:44
 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     Abel Vesa <abel.vesa@nxp.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Subject: [PATCH 0/6] clk: imx6*: avoid GPMI clock glitches on reparenting/divider change
Date:   Tue, 25 Jan 2022 09:52:00 +0100
Message-ID: <20220125085206.8508-1-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d917b04-666b-4a20-7299-08d9dfe00e71
X-MS-TrafficTypeDiagnostic: AS8PR07MB8156:EE_
X-Microsoft-Antispam-PRVS: <AS8PR07MB81568BD78EDE5E11C87748D2BF5F9@AS8PR07MB8156.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1x+uC85KivG3WWODoeQPQjZ+AGHY3Oeio2t42QRAPaN3TBdDksbUqz5+4+4Nioc8TyMKtw1dT86M/kJVeGIUNEC6ukRYjSSoi2/ovb0xzsRPUbqKULAQGkt/bDl7TFZFSKki7s7q550Ic02C9d7xv78XySLQQ2UZVzn3k6wQdj5ewUkShs7Qb/sUHB52KmMK9Y+D+bjMRVlTo216dcCjI6pWUDKV9UpJGrQJFszhwpVOQZaxsNC8zvLG3W/xiVRbARhcM1humAkVNvQRRXt/U26/GTrkBeTWaSZlh1gakQ5RlwCTpCL/dECDx4dG9JfQ17n5cpgud8/1qWhYsxUy0ZXlSo8pFJ7XvzH6Myu2bUrlNNSDC60c5OBBwlahFI1yoGeGXrJar9horrip+Qkmwda3R/65BPi9fG+Ah0GHm11rLvOQkhCPnISPRZeU+G2ytyZO7DJ+jCOKDsgmg87EvnKv1JEZ43HnvfXK/kJ+0JquFNw1z+dermOph37zVPPD67PzHj8fAXF4JwYJyM6NcfJHsyAjDjGSvtEl8YgUdB8B5GnHedVlKo0xt6ZuEIxbVHDfEufx4Z5gBDt5kKG9RTu+VqcN6uEt5jRpZOhLPD/mjOjxRVVgH7x+vp/p0BYg6nPqLQ7BZxxkdh/ESmj+LrL2AmYTxGQiR2QPc1H09iO+Zk02DfAt3T0xy4hzWyxACMXNBUNjhXKQvkqu+oUgug==
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(8936002)(70206006)(70586007)(8676002)(6862004)(107886003)(508600001)(40460700003)(82310400004)(426003)(47076005)(356005)(336012)(36860700001)(2616005)(81166007)(316002)(1076003)(186003)(26005)(16526019)(54906003)(2906002)(6666004)(86362001)(83380400001)(5660300002)(4744005)(36756003)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:52:45.4964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d917b04-666b-4a20-7299-08d9dfe00e71
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8156
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the i.MX6 series (but not on i.MX7/8), most clock multiplexers and
switchable dividers are not "glitch safe", so switching them while a
consumer is connected can cause glitches with a higher frequency than
supported by the consuming peripheral.

Without fixes, peripherals can fail occasionally. One example is
that system boot fails due to lockup of the GPMI NAND controller:

f53d4c109a66 ("mtd: rawnand: gpmi: Add ERR007117 protection for nfc_apply_timings")

The conditions where this can appear also depend on the device
from which the system is booted and whether the bootloader has already
performed all reparenting of the clocks.

To avoid these problems, the clock subsystem must:
 - Gate consumer clocks during reparenting
 - Enforce that all consumer clocks are gated before client drivers can change the divider 


