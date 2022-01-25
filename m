Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14C149B6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580548AbiAYOut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:50:49 -0500
Received: from mail-eopbgr70114.outbound.protection.outlook.com ([40.107.7.114]:28550
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1458155AbiAYOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3HxxmpWQsmGZOir/Nd4Zpaq5VG5JMIx5kSHy/pORXY54xFLt8gkqIFekON1jLg5z1Y/w2I8IMMHfbg/06qYtIV5iO7N4oUqSUuTFKxRHHcx5/Q1hETfFNDCSA7km/7d2xIvlzvvTYKgt3+9c/MLGjBC6yGeOv5MpCJ0vJ3boSrUx4f1WSMOWNR+abaWaWX6ysRwejCobI4yHf0tnY64m6tHbebF/GDM/wKFLwDG/KgoHMozYpSaP3W1Djy9zUjP7bT3/KInvJQQZiIAp9Npppyz7oFdYMf9DE3C+vja4xrAmxR8bph7rfZQ+xnoQ6Gb7gVEQOPbrhn9AmruLLReDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmRPa0ezI4Q3Ym3nis1pu5DWWX0O5en0ByK21nJL6UE=;
 b=QggYuv6E6pUbavyAWtuMn9CfhxsO6qzdmowTIIMUhvTdGk2mv5vb6y8/shFq6WpzHPAdTK7zVh/d4HdKsif2rrS5s4lsYrKv2rttbeAO/KssEmuWbN6mS7qbyxGE0K38obf3+Btn8onlIYjdWp/ATQPlADAR1EbVgoCe8lKwiwk72+pVHONk4WuR5VI6CfhWZ1Row6MJpgbMPfYwrTZLbTDQXsnBm57i1sDpjITqNVv+orYowO4MWKoct81+6Nm6bA79juo2aKFNUj180kNnWhSz0sH/k+5kf/U0U6czIiQYywMXDKl+Y8NDNB4jMPEaC6xvvgtmmj+AJE32t47XJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmRPa0ezI4Q3Ym3nis1pu5DWWX0O5en0ByK21nJL6UE=;
 b=Ymh6aOG7/cNiMLPKhORow1Q8AUBzp2UVOS08XLytSvgUBG1DJEWXzGm/wRcrrralmc4dzQHB2ig8z7RVshYsxPoq9YvxEd7oi3NcPy4absWn8twN0Nlm9WqZWi5Gw5w7HMp9j1SFEfJi9JYCydsv+gdl717l+AqkBgcfH5LZaJ0=
Received: from AM6P195CA0040.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::17)
 by AM4PR07MB3265.eurprd07.prod.outlook.com (2603:10a6:205:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 14:44:50 +0000
Received: from VE1EUR02FT053.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::d0) by AM6P195CA0040.outlook.office365.com
 (2603:10a6:209:87::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Tue, 25 Jan 2022 14:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT053.mail.protection.outlook.com (10.152.13.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 14:44:49 +0000
Received: from localhost.de (192.168.54.129) by mta.arri.de (192.168.100.104)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 25 Jan 2022 15:44:48
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
        Stefan Riedmueller <s.riedmueller@phytec.de>, <ceggers@arri.de>
Subject: [PATCH RESEND 0/6] clk: imx6*: avoid GPMI clock glitches on reparenting/divider change
Date:   Tue, 25 Jan 2022 15:44:35 +0100
Message-ID: <20220125144441.17750-1-ceggers@arri.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.54.129]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28382c16-5e91-4592-cbbb-08d9e0113d64
X-MS-TrafficTypeDiagnostic: AM4PR07MB3265:EE_
X-Microsoft-Antispam-PRVS: <AM4PR07MB3265DDD4BD480DAAE1C265F0BF5F9@AM4PR07MB3265.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDDMtkkiLiSVx3yXE4FB1nNYQ9EdB/vH9TEeGlJSYZqMYI1L7D1s/l7hreP391auYXb6BswRHv/rmtsOUdSzs+2343H18gkP0preuyZWPNMNvnrENB7i1XAJgCxmJLN8iphz2SoSYbS9YJ0uwv1iB7H6myXLLuKtbhyH7qo25Z/WiuUrpohYIV7t/QI5HdH7Zex/Qkg5xswo7OIhSasmqbXvEOPWANYKwMtD/8SJjaUaNdQ0gaNojfvnOqzgQYbmjTKXmUZjWkiXpw0FL5x4VptBtPL6/3bnxfIBExxPqqNWJaYuNNijNe6iOBiQ+nPfQL6boDzIHjuAJsVIKx0hIrbUaZCkgmMrL0O8qgRnX2Yh0IqZ11AfzKq/GqWrAP3mxFvGypnuaxreXecpqTvybU/fqhVzWCVjwmOfduvwwbN6k1PwJGXgf4Co9uQobHji/9XDmgwHGz1VB3MAnTtEdxy0aq8UjlkQ0Ba8pJsmn8Ycgc6nvBW/YiYN2W4WjTzQfcrFyIM+6Vmc6iOEsO5Ayxn2eQ0isfOnxTaN2oEa5VHz80ZTSSDSRzYT143mjTj35y+BIiuLo+ROOxLTtShMnUgSUMksUhluKvV0kLEx4RwDrgBpH6pCp75g1O4c94vP/RC+TUUQXgkUI+jbt1ZQF+GOJP9y5xvzyNF/tgZVDzufBZGRDIVSskz9cLTaT+2aLzN00ubDiUSdtfsRpKgd8A==
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(8936002)(5660300002)(6862004)(4744005)(4326008)(8676002)(82310400004)(336012)(86362001)(1076003)(2616005)(70206006)(70586007)(316002)(16526019)(83380400001)(426003)(54906003)(47076005)(186003)(356005)(36860700001)(26005)(6666004)(81166007)(107886003)(36756003)(40460700003)(2906002)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 14:44:49.6197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28382c16-5e91-4592-cbbb-08d9e0113d64
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT053.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3265
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RESEND because the series got corrupted on first tranmission

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


