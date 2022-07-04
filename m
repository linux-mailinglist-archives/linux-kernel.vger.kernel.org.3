Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF3565682
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiGDNGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiGDNGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:06:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AFBCE15;
        Mon,  4 Jul 2022 06:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1V/Kn5IfcsSvML0N3QcRU4cEi4S0/7TAzxDCxESJXWGe4rj0UEnlQuqjBuU668fTx2orMYwt3+M7ltRj9Ywz7nv7k9PReRDbGJL3JY1Z5cHcwBc83OPsi3eQ9dph00EkrFcquqvwmdBcmFCmjtLLUPhFtUyZhdqTy9ya1arNXKw0MN6M7mOskoCG3aZyJq1ILn0QMy89rjs0hD8N3KxuB4Z4N2dK5Zz1HNSjx1Q4Zg+3BBgmwKZRvJ4AOMxt7gyfeghD+HkKq1CrWUVapFyVncYGTRka6VEMgXyh+iSrv4d1qui4L97XAE04EYExQSWfWykOZZS/Hq1Wf3Rp0Kqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvmZ+JYoo7rta2MI57iUO+GHrntjrxXXUCVri6eakJk=;
 b=LE7shyaMwIdEQW2Pg/NbzMwyj3slUnwIpcXy0pTqcjofwD35vBYxTOhCsf/pYzgBNPu4+WSlc4Ypb7gX6+Z/OWmgPNwRdBIMT21h0ywMPg2wA2ZZ/aHrXe19uPvcx6r7YCBCr5zttByKfTmT5gktyX/35gaSdS8Doo2wvt9/dJZVJ3geuxRFCIpswvFxglFNkkiPRqdWOd7PQflopdiwXcoXxA3n/hncTdLsrJN2aICiYCB1PrQCTFp9Fj9Xks41uPdjcbKl5Sjxtrl2/bhan0AzXkiNRHylabDh9uUHKtdSG2pzpzv3rvuEgRdMBclbOIBjvJvlgFBuIOVuSP/2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvmZ+JYoo7rta2MI57iUO+GHrntjrxXXUCVri6eakJk=;
 b=Ytfls4gL5H/Rx8kkbfMrLPmKhHVGsC3AEZ3DCRXvuv13rF4OIyDmFgevsntxA98a6phfLmCIgzUCSidJJfC9g1Hc58BfWCnZizx6UCp0m2+WXK2WMIP1D8/L+s9gN61F+TrpregPYjt0hpYPixlaT1WjbLs993V4+Id+ojm51eOBimDQ2TZ4AZ/oNLy2ZZoUVYVYBJbxlhI35Hir510Cx+Mr+HMmFj0i15LBMfit/xxFsu4T4Y8AgN8DhJrZXUVs+GTT8USwkbzKz86LOnYw3A1mzl7HJCPoNkVtXbphcXBSJ3u6O1fDJEXkxYGAFpzsjwkNex4coA0037B5pzVrPw==
Received: from DU2PR04CA0232.eurprd04.prod.outlook.com (2603:10a6:10:2b1::27)
 by VE1PR10MB3885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:167::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:06:28 +0000
Received: from DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::87) by DU2PR04CA0232.outlook.office365.com
 (2603:10a6:10:2b1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20 via Frontend
 Transport; Mon, 4 Jul 2022 13:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT071.mail.protection.outlook.com (10.152.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 13:06:28 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 4 Jul 2022 15:06:28 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.161) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 4 Jul 2022 15:06:26 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 0/1] add device driver for Nuvoton SIO gpio function
Date:   Mon, 4 Jul 2022 15:06:01 +0200
Message-ID: <20220704130602.12307-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.161]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.772100-8.000000
X-TMASE-MatchedRID: GdqubCsVQzmqLUinaN4ZqilowBbqmU94KScluPnLESrrOLyP6vXu3V4K
        cTYVV+tNHWtVZN0asThlQQXUuCbJtflsGNsZMn6ozLb2wizLvKbLs8X/TuXj8rSkeRV328rMa9q
        iaDSLgo2mN8unTxTf9aqy6TpRg4ah5XA+SF03EfU3b7aQG8jZ9/SCkSozt+9h9FQh3flUIh7dYV
        rFVbszaJC4BQ0gZBzHcxZ+avxQRTx6DPmtdXd7tNNQkwj8EMZJGAdnzrnkM48URSScn+QSXt0H8
        LFZNFG7bkV4e2xSge75GyoFyUxggdaNxVdIunjNIWu1lp+taDLLdUCpV1buipRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.772100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: ABD24F9D6A63DB5517AB424DFC5C3945D97D2CD3EB525353D8D8A55DBBF55EBF2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5b7c0b2-863f-4026-d10a-08da5dbe01fd
X-MS-TrafficTypeDiagnostic: VE1PR10MB3885:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YV1UAuOWmcbItw9ExwSgWcykpXm4R+JFMPVM39Im35RombgTdZSlvSFqD3V3rVUnGVL8+q2K/e+OV8tIhww2beMT51H1/dfVwHvrMKB3VWjHI6/hLjnGkjxxjW9eLxAVTLshJzpaD+tVL6wjuyna+cHRsBft3UtcQws7HzYsgsoORRopaGw1eMICHveN7LhuvCvqkClATKES82leHiSiFrXgNmPZSXiys+0Sn5fw3JGCVeVG+zhU1jkBtHKUoEOZpI2zSFcflDiUMWhLTyVfTO/et9IUFGBsXGKEvuAXqTn/OKdVyyJDZwsBcXgZoRH6E1rhs4bmwSmwXqULGKQEqh98RVEIlWlisLBBA9ddt3+Y83U+uKYT6wqwQSkvyGUVD/nRgfqQkZtAATh5cOmkAyp29KXD0v4Jsq7UfoWo6UgzXyaUclpUjeujdpyXuQjUlvrDKCdFWfMiFNMrfg5P73CxLv/20u1n/mfhWSk+cS0DCosobDIl5ww2JG4wq44NYPn3zY1scS98TemTcnip2WVGQiCaJ2KgkHzA7uRmOAAzhdKmaP3X/5hVWlH0r2e/kcUEMrgomaCnOc7NrgHi7HF3tohh1yWUQpn64BOP+iXAfhDxkEww58rMOP0VnecpKdS8guAcYwVeqpHEnAfZEESH/x6kPNspqVsGxfEd3uxIlWRfElSj3L0WD6QcawOykEjcFDgOm10nm7qTrPRl1E0zvyXAC2PbAzh4UKLlRsw4L8qJqBFizefGXIJnqsEyHTD5KM0XN1LW4jHg1R0fqwSIhC9CefN2Gg4NfeIrVBNrvZQ6ls+03I8v/cIeZjTF
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(40470700004)(36840700001)(46966006)(107886003)(186003)(16526019)(26005)(1076003)(336012)(956004)(2616005)(83380400001)(36860700001)(40480700001)(36756003)(41300700001)(6666004)(2906002)(82310400005)(54906003)(82740400003)(70206006)(110136005)(356005)(82960400001)(478600001)(5660300002)(7636003)(7596003)(8936002)(44832011)(47076005)(70586007)(4326008)(8676002)(316002)(40460700003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:06:28.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b7c0b2-863f-4026-d10a-08da5dbe01fd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v1:
 - implement get_direction function
 - style changes requested in review

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
 drivers/gpio/gpio-nct6116d.c | 412 +++++++++++++++++++++++++++++++++++
 3 files changed, 422 insertions(+)
 create mode 100644 drivers/gpio/gpio-nct6116d.c

-- 
2.35.1

