Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6466F571CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbiGLOde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiGLOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:33:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85158BA3BE;
        Tue, 12 Jul 2022 07:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AurH4s0rGWAPm73ibi5R+omSMAmTC1QTYeH/ycxdx5EbmGtgF9iC6xg3T/NAIrLEPkQ2kwa5nDVnuY8oEErhp6hdBxKXf80qCgJnfRHbrN7dviGunEzRewswxRGeNj25dQ6AZKImZT+qtZpIaNvpzzBbPCUxE9dJF2Hyd7LlpbcaqeYcxRH29Q+3PR4rZrJy8T6vsoMwgbnb52MYusD0d/NcdXdK6CW2H/EDYv/9iDU6isILThC5Oji2xZrWgRb2V14qM1r14nkhmYFNuzyURxx/OQS/sVfKskmTsg+f+IaoWiNUk6dD3BdSt8/A9cop4KrJoJ1r/zwLBBBwBvw7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9WamyfIJfhET+8cVmaGchV2T/4j3HH1XSl4B0KquZA=;
 b=jAKD7iabA8k162ocaZtHJ906h6rKqYfUoct0VGZhK2F5yZWjBTTVOVrAbwsTFic1P3m9owLqrEuUzbGKck1sTLE5pubEMOs2s7s+CMr4ehNoDIcZ4jwwKk8GYQdlV5KuWRZZeKplls0svAQeeAJnn6iOfG/2Kg1+BmqXLlFHLRk1ZMv/mfVxYX9gDSQ/raSwiaFNryWvL7NhMQb5Fj0XCm4ZynPf8RtNjTt4EqWMIF5DIJwRyPtHrBQcO7znU3S9kUc00Uahbh4yyFnvHmwRkaEpCfeYkU0K1P8YRdlU8P1aefmDWoudqS23LcSQgfYGJzWKfBvVxBBhZojxYT9KVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9WamyfIJfhET+8cVmaGchV2T/4j3HH1XSl4B0KquZA=;
 b=ftTtNQLlaBMJOGeicBlzjxuDTB8kAH/XsusNIqMtc5j9e6KHYfvR0GahflNkoCDmA82J+SdnIJcDFuFU3ZRVrA9S0Fd0vSuzSHk1EhWWJJx0B2ZRxjgpnlJLQNPrUHYgIML2BNO8MbU0rZs32Iy3/QtYSrl3aBsCahXHYPGD1ogdHuQpAySZnFGh3wOefoh/CCGU99O+T//Ygt1u1/jzrNKWwiFIf5E2YgNrL1pMZHyOgfvICYI84BnwXnByO4Uzarw0RqEBvPk/aIF6S/VmgI4vBTb7m32C4ggkT6n296b6ufEzJNudwx3cw42pXlaCXgorUjasd//1WpMII09FeQ==
Received: from DB6PR0202CA0002.eurprd02.prod.outlook.com (2603:10a6:4:29::12)
 by PAXPR10MB5735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:32:54 +0000
Received: from DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::9) by DB6PR0202CA0002.outlook.office365.com
 (2603:10a6:4:29::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 12 Jul 2022 14:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT069.mail.protection.outlook.com (10.152.5.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 14:32:54 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:32:48 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.161) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:32:48 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 0/1] add device driver for Nuvoton SIO gpio function
Date:   Tue, 12 Jul 2022 16:32:34 +0200
Message-ID: <20220712143237.13992-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.161]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.778700-8.000000
X-TMASE-MatchedRID: hFLyEsT3hO7myE8VIo655Oe5ohS7aAq5Y0SWNEYONDwovbifIQL7Gt1e
        FEoaE12nS/960Jlq0wYmCLyuQEHwX1rA0RozUTb5R8nBzTVv4cP1YpjvL2and+XSonB/2H+nfku
        Ztv/FS5r+82zEszKLqou6u5Cfj8OaLTUajgWs9Zhyesl75m1CJ0nhx5itBwM1KiJEqUFWRgilY4
        F8r0vXP+3R1srXHCxHPFMmMT6c+jZBX8T1O1z2r7mMVIxbzR0NARXFFtiXVhqUzbPKik6p5nqLr
        3o+NE+Iy5JfHvVu9Iu6o5pOE3X0prgVRaiuBGNhQxx/Lw6+Y+49d1nHWxkekGwTEruL9ObTjWP6
        asaL88UGmHr1eMxt2V+vEFKOZZiQ4vM1YF6AJbb2xnRRfQRo4gtuKBGekqUpI/NGWt0UYPD3Edo
        3RWRWq3c28wePRSwl0GApBmjBj6eGOxaVuBlLauJOCaWYu8AT
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.778700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 4B6D28F28357C109AF8B1FBF3038C36057E611C718075D3B278D1E1049064DE62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0073405a-e3a1-4870-3447-08da6413682a
X-MS-TrafficTypeDiagnostic: PAXPR10MB5735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaA5ccwBRbmF0mhP79sB8JkJbUho3XFxQYZHWkTsXCPeH8Bwp/c/mQ6N+4QpZxWTCup4Euk3llHvMDT7O3D3ATl5ax8lPec7ORiT6orzLcjwtiu/Qi3sOZR7rSjarsf6fCfILgHv5z/WZ7hrRJuz8PoyWxlVMVJx0UL9FXLek5KdyLtjJ0QCB9Xz53J8VKMYHRG5SsfxA7UGir208UcDe8f9PsvDkU7vD0/+grJnpZbc3WbnA5LE5pJKT8vJ2ax23NfLhqm6VSgc2HRdu5otvhZ1GhXRq9Xyf3xdV42y4iZ8NI5BsEmb7pSerWRFFpt914i3v5RGkM99idwNA00hj12uGth3Id4jtPsYzvbCAoAhWoRGJMdtVFxodd/BKmj6jzgUQUzlCk7biDTXPtn6DqWCwefKdlRjzk0z5XKwVkJ5SP2uHKK79MlcbSxFAV2L27zN7EKQkc49R0ICFCtXiXmIIyKikUKcAOs8Gk98hbYhi1jSpAL+tifRc1TryYKNCjtF9B7iL83jdTtYrZvYLp2mjtrGxCZDK5lSx+4VftzH3BrVbuFcVnYxowO5fdoZrSFtdxH/ruoQc+ETbwtNOSvrSOD2MJ4foYXH1cO9A3po7I8cdvLIrITZCWoltNgHk/qYCdHdr3+5TidxBzH5ep4cCMhHD+iCmQQka6540EBlD5vhBL1KHlk0vP74jd25HPAaXt1GpcEIEkyQvyMbGvBoH+ex2tvQKQY+OSf2lFIkePpcH5hZzi5SCSjDgPxD+i2+WGerp+WLf+NjPVyy0mmsuyrDUw2pvCxAF/dbP0JXWdQfpb9t3VqO46+r4yXalPQCIzv2T9vhddfy9fdnLooWf1u4SG3c9E/BcJz4724=
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(40470700004)(41300700001)(70586007)(54906003)(70206006)(2616005)(8676002)(40460700003)(110136005)(6666004)(4326008)(2906002)(83380400001)(44832011)(478600001)(40480700001)(8936002)(82310400005)(5660300002)(26005)(956004)(356005)(82740400003)(36756003)(86362001)(82960400001)(16526019)(316002)(81166007)(47076005)(36860700001)(107886003)(336012)(1076003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:32:54.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0073405a-e3a1-4870-3447-08da6413682a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5735
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v2:
 - move from subsys_initcall to module_init
 - add 2 more patches to show how it can be used later
 - v2 is based on [PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper

changes since v1:
 - implement get_direction function
 - style changes requested in review

This adds gpio support for several Super IO chips from Nuvoton. The
driver was originally developed by Nuvoton and i am just contributing it
on behalf, because other patches i will send later will require access
to the gpios. The driver is valid on its own.
In fact v2 of this series shows a future user, not to be merged right
away but to show what is planned.

The driver supports several chips, of which i only managed to test one
but did not want to drop the others.

I hope the original authors will help with the testing and addressing
review feedback. The changes i did so far mainly are inspired by similar
drivers and some just concern coding style. If more has to be done and
the original authors do not jump in, we might start off with just that
one chip i can test and add the others later on.

Henning Schild (3):
  gpio: nct6116d: add new driver for several Nuvoton super io chips
  leds: simatic-ipc-leds-gpio: add new model 227G
  platform/x86: simatic-ipc: enable watchdog for 227G

 drivers/gpio/Kconfig                          |   9 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-nct6116d.c                  | 412 ++++++++++++++++++
 drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 +-
 drivers/platform/x86/simatic-ipc.c            |   7 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 include/linux/platform_data/x86/simatic-ipc.h |   1 +
 7 files changed, 467 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpio/gpio-nct6116d.c

-- 
2.35.1

