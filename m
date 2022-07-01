Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B4562FA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiGAJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiGAJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:14:30 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20040.outbound.protection.outlook.com [40.107.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC7944757;
        Fri,  1 Jul 2022 02:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOENq+GjtyJTaKrhHQtMD3k4nwuwK+EXuV8aXOdqFQKFLHYJlpSkK5GHqYF9ygH1SQ8RhO/tF9dinPcS0NrQuQSvWRhL6zAJ6+CCfzAWPutc9DlBMI1MgcfYGbp4OkQZvgNqgdpfQYYpJrudEY7AxbgNnxuabxAl5cDg4iesHPO5EB5oL2yBfS8SyLzRAdLoHIo1+H1amkSKhbHeV1dbDvTJ/vfc5d2KHrgWJOIBXBsahC8dSdMaWeVcKMhKIsQ/F6+zOZfRxEPbxgEr99y2w4YD3+6RDbqWaZxk1ydTgAwypthqAvrvgAN666cnuT+LONFLzKdhwSBY8ploiAS2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFn6xSNGn11Tw1reH3bwrNxGeWp4jj/ppeQHNJQVHR0=;
 b=lYlWkiIj60czv/bIta+hL5WAs/WJs/uFGB+mwLWDdtwZALnnErLREHd0wdb0f3FZp3r3CXFGu5+5JJ/DygphbtVPfSB9phsi/YJ93RN1CYoCqw9QVxKmc0yHtAKp9gLV+FtN7Im7G/RN2msfsQlHBOd22J1+Mx8PlgrwJeHmglLhZxm2jc88JGKMA5bBY9dbE5ZXwm7TykQ2HBjXBTlrd8WKpu/5nbBwV9Yl98iPS4mSmIK8fv7glKGlTu6dSeFWTERW1rsFh4jgdgUYeWywr43RK+bQK0KTkAUSPOmu9yrKov8m+mwNvgvQM1zncUCBwAYfXvlxf6bAiginWI0l7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFn6xSNGn11Tw1reH3bwrNxGeWp4jj/ppeQHNJQVHR0=;
 b=MGlU90AoTcVTPUEHaDedJsHe0Lv/TxvLaGW3VNrA1IMdCiwQB/FXWSc9v5Pk78FWXQD1OqWlLInsU9hvsK31JSj2RtJLOZPpIssk0hvBqf8rVJ4ooIaaWeK1UUIclUfWQ0MdafL2qn7DvNJGZcuXFlurOBfLRhLqGHjGpp0tKJvEar8Ar9cJ1a8jsIPvOPkem/Zjh+JhnWVodoj3fDaxUJ3uVwCuwJ2GzKdRQ5xcaHL9S3IYUfnt0RmaonvflhcLZtqvDeISVMoLrWmMODlx70ASwM8h1yGpWcllsbTYHcnLa5pCcJ39pMl0bvnb4C4ht42cUcScoh7H5PIUOMMfOA==
Received: from OL1P279CA0006.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::11)
 by AS4PR10MB5545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 09:14:27 +0000
Received: from HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::3f) by OL1P279CA0006.outlook.office365.com
 (2603:10a6:e10:12::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 09:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT031.mail.protection.outlook.com (10.152.0.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 09:14:27 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 1 Jul 2022 11:14:25 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.68.241) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 1 Jul 2022 11:14:25 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/1] add device driver for Nuvoton SIO gpio function
Date:   Fri, 1 Jul 2022 11:14:11 +0200
Message-ID: <20220701091412.20718-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.241]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.762500-8.000000
X-TMASE-MatchedRID: 7A6GU0Gm5XHZZee1+o5TZrKInvvcD/cTKBLfE09F1HJswYo64ufkVY35
        bSBoWhq9H8jJDe3vPQOxVpcooiqIm30sLl6yOD1JdlqJAfns3+dXKa5mdWEgiSa1MaKuob8PYi1
        nZ7WB6LEfmRnL8RBuBO0MuScTztGMkpsU2cOjMqF8XGXq+kYTkOq4eBfl/7E8CuDAUX+yO6YXiv
        wflisSrFgLks93sG9tTBJ5VCdJL8UbP/eOGYK8VoAy6p60ZV62fJ5/bZ6npdg7AFczfjr/7PtfJ
        60CTYV2pzmeonZHr9BMniG9LKahgayy8p2Vvqk2+TEEeBO+vyI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.762500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 42FA62E12592507C1E39F899CD506352F4D954EF8CAAB54915A059DADAD6BD382000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de934b1b-3e1d-4543-cf45-08da5b421922
X-MS-TrafficTypeDiagnostic: AS4PR10MB5545:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNrOrj06OcAeu3PH0y64aAxMwSE0m4CsLA9jrF8bWBSrHqXrSZ5L+ieDxh30sXVmQoEXf+Np4GVenXMeO/HwCjecnSIFpPkvqkh0VPB4+qOzlUz6m+bdcc/bNyhZ3z01THr8wwwdFSbm1TltQZ/scOX5mwciMYhLDAN4FX4v0j0bj71zuttMEgy4FWUuX1HU3U0Z8MFDH/xD5F/n9gDs6nex78PQvn5p2m0TFGacB/Hptd2eYmO6bjOQyq4KjM1I7/8IPwBtPANpdW2ZzebA1mMxi6DP3VxToWDyX4zn7O2I3TJ+RWKkX7fDlErEPI6T1CRMydiGnDhNfw4j30xl11ACwh3QaVCrdPu9Ogucr7Bs1hRlnyzqjOz8n0LfMnSrl53MY6slyWvol+QHh+FZMjRE2+dMXBlyCoFW7U3PYRpBfQ4w2wxuWjUFt2fHQK4nIj3nyzP3Ywk/xU87f8LY5C8r4/Pnt1uVJdbyZwfRHBaSPD6VW+5qBr9NWzJ0tx+dzCd8gdyDMoTbujFFlTjzCY3jlRiOf8ZBe6J8komd5AD1TDCeYA5mwqCJ965hSTa0fw9W2OaT+y86ULMLIifQX8OU2deOdlOHY+unx2An2/HxyrtRr1IagdWKSH6n+3zYDrECz5aSAwWt5OJ4wVrGuzb1a7E+tBKWJdGGGGXGbj/PZf4W5npXi2OBaJBhdXlpdmzPyV/2QUuzwyEOaNLyErt6LrVIcexkxYaiytajnAgBJconh+HPYKyNh09wuGprFaljUGtBAU+vlDAsT0FMcHvt/wJ42wHIpqil5XKiYa1H909p2tGS4ZfRaEmWnfMbDYZJwYo5p1+P+od6UcG3lNw9uZozU+nIj+2ndw3vsuE=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(40470700004)(46966006)(36840700001)(16526019)(26005)(5660300002)(54906003)(86362001)(47076005)(82960400001)(40480700001)(82740400003)(336012)(956004)(44832011)(2616005)(8936002)(36860700001)(82310400005)(478600001)(356005)(36756003)(83380400001)(70586007)(1076003)(2906002)(4326008)(70206006)(40460700003)(81166007)(41300700001)(316002)(8676002)(186003)(110136005)(107886003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:14:27.3246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de934b1b-3e1d-4543-cf45-08da5b421922
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5545
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds gpio support for several Super IO chips from Nuvoton. The
driver was originally developed by Nuvoton and i am just contributing it
on behalf, because other patches i will send later will require access
to the gpios. The driver is valid on its own.

The driver supports several chips, of which i only managed to test one
but did not want to drop the others.

I hope the original authors will help with the testing and addressing
review feedback. The changes i did so far mainly are inspired by similar
drivers and some just concern coding style. If more has to be done and
the original authors do not jump in, we might start off with just that
one chip i can test and add the others later on.

Henning Schild (1):
  gpio: nct6116d: add new driver for several Nuvoton super io chips

 drivers/gpio/Kconfig         |   9 +
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-nct6116d.c | 401 +++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+)
 create mode 100644 drivers/gpio/gpio-nct6116d.c

-- 
2.35.1

