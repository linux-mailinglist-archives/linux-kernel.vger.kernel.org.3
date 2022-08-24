Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1238659FC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiHXOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiHXOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB06887083;
        Wed, 24 Aug 2022 07:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6QLzP3WAtbIIA0S/lRrCtTHblBs5fTuBrs4g5LWPoc2EMdwP00FCVN3NPDr2ufPpmNo93wMv3+74oWXgniKZC0e16a/k0xHGq6LMwTcviS/VIWRRjB3EFsHsJz/ZqlpsWPJfYlb5w9oWeXBLfyoajHUSmdTJbFEr8Mi0KHJet4uzcxgVFXyEUQqX7MYEpUsVYyXUt9JG2jPDtKHJ/3mscytopih6lepHrY4Wc/eNksnl6V09/kuQ20CAE0ScpVqAESgocjBaHuZwp/Sc91UkrqSDB8f17JWuzamN/cINKcg7DSRzYrhjnc08XAedCLo8x5q5yEhj69Kni0ljv3oQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPKS7mP9x5xeWYCKJ6oQrZloI4Ysy1MV9iOHvMTjwBI=;
 b=e/TY0dqx43Duywx8TR1bkljTBio/KT8kfK0sH/RCxYkPAQX0357vbMr1BCh04Tp1bgxDyeUt7oBUabmd6lDbW+BFivgTF22rrOBNrmvrzj56b4+4TFfZqYvZoLc75mxkZd5NP8Wfo/BuWVUILpYV3l6FfMObLifcNMemB531gf0CtWkjoXJz7FOQxNRUUSRTFqsountAUGlf1Sd04x9iw/fdH319azW2MQSUEq/KSkf7weWFmEI83gtA9JGre/gU5wT3HmlR22gpAk30xTg2DRQkmIFkObPREUOCsEZaad7IgwY9foKtEPKllM2TOZcjIa+kuvm50GZlMnno6z7C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPKS7mP9x5xeWYCKJ6oQrZloI4Ysy1MV9iOHvMTjwBI=;
 b=lyTCzUVIWgP6nE3BVZhVRFBchkPL9MtzSru9Fu2BTOJVmmQ53ZDRw2DPIXuh4Uoc2oUG5Bch2CNLgT69OYmaNxPhk+2DVhcuIkPySaMwEi5w8Ye0YTO8TxQiZxenSGpY+eZjgrfqfOCFS0ddMzR5lVt1OmAMj7fDY528XXmeKgH5eheLoDrliinzf+mUIv0tfGJGcJ6cKVlfnuduMi2glgjb0j/w/piIc3i6yeqW1qHy9PiJpxH05wHZjLsx63BvZ4FsOIQrbGhyeNh344oez2GKIBWaM0paUYcO79NPK9IaCkPHC+zvixD5KYC0KkmqKhgx2eXUAnzqpC14RVFsAQ==
Received: from DB9PR02CA0022.eurprd02.prod.outlook.com (2603:10a6:10:1d9::27)
 by DB6PR10MB1559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 14:03:59 +0000
Received: from DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::15) by DB9PR02CA0022.outlook.office365.com
 (2603:10a6:10:1d9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 14:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT009.mail.protection.outlook.com (10.152.4.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 14:03:59 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 16:03:57 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 16:03:57 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v5 0/5] add support for another simatic board
Date:   Wed, 24 Aug 2022 16:03:42 +0200
Message-ID: <20220824140347.1842-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.198300-8.000000
X-TMASE-MatchedRID: tC0x+CmGG+8rpjrmrWphXLdeTPu4qCaOeDPho5Jw+XAsIMJqMNlanUlo
        PruIq9jT02DA+6J8XN1nbyATPFLi0iiUlO4YffC3skaOZjOmjNE3PGxhv7akGQrcxrzwsv5u1cu
        IRwt/4MjVjNsehGf0vd56eAtmq2rwdj1Cy2U84rvizmK6NdGX5G31FZ8LNR0EuZBZOg7RfX8vuz
        dRZ+l3c3PW+p0zOs/DPsWcKsQns01RtiPAXngvCe6Bh/vmoH4yjIJ0KdSGRo4fZhFimVQHW8ioJ
        Qie/DjpK4YqHgCSopVPpjLRqc8GljDOSE1tWAtWETeFhrKfkTXFJ9E937W8zopHR9xEGhE1RwDU
        669267wc0nbYaP5Pw86HTpvs6fCpmHziDDAkm8gTqqN9z4iBnlGEd5OSBmbmngIgpj8eDcAZ1Cd
        BJOsoY8RB0bsfrpPIfiAqrjYtFiRTgRq8dcB/GKgA87zTSqGJPM4zykv3Fcsh8dkI5KkwLn7cGd
        19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.198300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 0CEDD7B281A6F594F3EF8751DD9D22F365162C95EFA94F9827D39FC6D9A1A3122000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb903efc-f138-48fb-5b9c-08da85d97dcf
X-MS-TrafficTypeDiagnostic: DB6PR10MB1559:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li5tp9XRAu+qaFpGaCbH60THcg0bH4eTukpb3TsYgNS6NrR8asqJyuUyzz7Qc7M/DvWvTZM1E2X0P8x8hDHlGXHt5fEuZj5nFTnC894rZ8ObLD4DBpwbcBDrfxlzDAJstVhUvXQewadBt2pwSxJusfeZR9MkPvRAjOfh0iy6A3STfhB/6KLlQjG88V7wgw/cHxkO+pZEuHCyd1z3sFlWKTToeAZIIwDlz08yVbjbxMX15HOcrrNYQehaVQalrOVbQhqUk5Wmyd+F+sMD7erC4cLX4xtf+aR+BAqk0kupWFWjeOxAiky4w2PTcfOEaTtd/e646nbtm6+c/qdXcpeIuMjO7WOpHCMGjtNpLsLftlYWkhque7wc3z8ogrEIF6DKg96jz24AyIQ7bHs2mVvzymUulUCBYp3Lk1wudU0pSpZQ7p63M3bd/xPYCNGMy8VQ/E9x+OreQ1sk2GXvCV2gWoTusCiPLBbxS+8mGsDVfi9798tSBaMZC6vnebysSuhVZfQf7CXt0xI3ViLWdUWG3hcYqBJWzX6Bmkt11oy2/g0pG8l82wuNR3MmAtm0jwrS3JNQS+gUvMvDWYn6lw7Bd8NF9RjmwKQV93h4+ZR+vkvEeWG+d5vPkMD2yjoka2w42LjvDvXkUzqQr3Xc7nG7SMDU3awuPnxKAunE6JBy0Un7r/o+k8V1It9Cb+4J/NToKfZ+Hxnn/9SF9TvCX/Tf6Kfekyc31NZaMhPNGjqAZ0NZxYzDChjtji2mgLxLydo4ZY+W4k3hZodWQleXhh8KiK0/zZnEdbLix28BPL1rXTWVMtlz1g56zsgKQZEGYY8X6i0hL1qA+5oGBQh/BdZLoa0Oh9bpuJTnYeCZV4FV3tL+7gpDIusPvSn+fDS0IeL2Knb1ffGG8HbLLMQsFReSgQ==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(186003)(83380400001)(956004)(336012)(47076005)(1076003)(16526019)(36756003)(34020700004)(36860700001)(70586007)(4326008)(8676002)(40480700001)(54906003)(110136005)(316002)(70206006)(86362001)(2906002)(26005)(6666004)(107886003)(8936002)(44832011)(5660300002)(82310400005)(478600001)(41300700001)(7416002)(356005)(921005)(82740400003)(81166007)(82960400001)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:03:59.0786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb903efc-f138-48fb-5b9c-08da85d97dcf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1559
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v4:
  - remove int case from a printk in p1
  - include tags into commit messages

changes since v3:
  - update Kconfig as well
  - drop chip names from comment in driver header
  - add manufacturer check for Fintek again, Nuvoton not possible
  - drop revision printing for Nuvoton
  - restructure defines again
  - add new model 427G

changes since v2: (p1 only)
  - rename macros that change behavior
  - use chip type not device id in the macros
  - reorder defines a bit

changes since v1:
  - remove unused define
  - fix bug where (base + 2) was used as second data bit
  - add macros for "inverted" and "single data bit"

This series first enables a SuperIO GPIO driver to support a chip from
the vendor Nuvoton, the driver is for Fintek devices but those just are
very similar. And in watchdog and hwmon subsystems these SuperIO drivers
also share code and are sometimes called a family.

In another step the individual banks receive a label to tell them apart,
a step which potentially changes an interface to legacy users that might
rely on all banks having the same label, or an exact label. But since a
later patch wants to use GPIO_LOOKUP unique labels are needed and i
decided to assign them for all supported chips.

In a following patch the Simatic GPIO LED driver is extended to provide
LEDs in case that SuperIO GPIO driver can be loaded.

Last but not least the watchdog module of that same SuperIO gets loaded
on a best effort basis.

The very last patch enables a second model of that same board type.

Henning Schild (5):
  gpio-f7188x: Add GPIO support for Nuvoton NCT6116
  gpio-f7188x: use unique labels for banks/chips
  leds: simatic-ipc-leds-gpio: add new model 227G
  platform/x86: simatic-ipc: enable watchdog for 227G
  platform/x86: simatic-ipc: add new model 427G

 drivers/gpio/Kconfig                          |   3 +-
 drivers/gpio/gpio-f7188x.c                    | 228 +++++++++++-------
 drivers/leds/simple/simatic-ipc-leds-gpio.c   |  42 +++-
 drivers/platform/x86/simatic-ipc.c            |  10 +-
 .../platform_data/x86/simatic-ipc-base.h      |   1 +
 include/linux/platform_data/x86/simatic-ipc.h |   2 +
 6 files changed, 193 insertions(+), 93 deletions(-)

-- 
2.35.1

