Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFFC5A0AED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiHYIEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiHYIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:04:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D754CBB;
        Thu, 25 Aug 2022 01:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8f3/emqgE9vfK1niZgmmBSzqRIT+SToiCSeNtVSy1pwKfebk7euxsn6wTQVQp0iwxtDdSk+Vga8tvSgJWUweG7rGf6+AYVxkswhcOQbD3bSMYHzdQHVsUb7LOE7ajpmf4DWSbtfWLngaqe+VU5fo9bvTmoPFeBGDrzKn9YR6fJMwSj/AOPz8EqGp4LQ3uewpQQuQoWPkFyLtJKYDfWFvmulRrnU3k+Ss+9bFzRdLfwLFHVKVrpKDNd/jZ+5s87n5tnMFALDIL0WznZ7bPtsdIhPAuVAmkUS+ZnQiU/QtMoFYvyQAHj4cO+ZGQqYFjIPRizLynAdjzmUX2i28F7hNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWS35Vlq80g0hItJm6wIsCOkFZQVdiiBeaQNYqbKDoc=;
 b=QZ1fKTq5u66hLrCVmqvUlVDSDVcY+1ag/iTdw4Ne2ewyZ3sGFLg6qBF1FdsqhTFuyd+UxUkI9DqmS/JSMwbMusUiS/gLnErsSo2W4uYDAb39DBjQK0nd2jJ1L3GZdCzc4Q63gxqTOmguVs61x7sKn1CdVPtsXVHDvHtwmn8ry6DcTxxFhEi559o2U6iy1+wjY96cpZG73IolgQO0RWro3DcBJvoOxlAUHOtPnAhB3t6+AU/zyvJVYnOdTmBkISv8vKXwy5UYVdORKkTMaoHomdr64WtcqJ7S+Hwlt59dEGdOi3t3tw+4mqp0+6cWzWuDUgTCH/aJyASXFoKjuX5/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWS35Vlq80g0hItJm6wIsCOkFZQVdiiBeaQNYqbKDoc=;
 b=zYKoLAtjJ/SYy7ySKhVEG4oif40rGCkFWHcAMftIQ2hVJNSrBCMZeYRhwjFyKIB5r19/O1n94OdjLTS0D8MddfUdcvFraVNI2Dv1Tcdn/UpgtW9Mo2G91/Rl704E+llRjsbAsOrKQ/CmGDVDZ8qmYKedBYZ57x0LgmND0SkAEPgb24fAw3eQ30pR268n8JtZyWvlmBNtSs2QsMTFUxzHjK/XudxeT8zsmLgJ1vcQ1L3Vf7SnogSDAbyv/0cOlkS5NwvXIfYhDC1seuqqOQW6A+uT+DuaKi+EiqPTSE2RBU7xIWkIex700OJjAFh+zgTtIs0XLks2lo0pbws1xfhg/w==
Received: from DU2PR04CA0353.eurprd04.prod.outlook.com (2603:10a6:10:2b4::13)
 by AM0PR10MB2993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 08:03:57 +0000
Received: from DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::e5) by DU2PR04CA0353.outlook.office365.com
 (2603:10a6:10:2b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 08:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT091.mail.protection.outlook.com (10.152.5.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 08:03:57 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 10:03:56 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 25 Aug 2022 10:03:56 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Henning Schild <henning.schild@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] leds: simatic-ipc-leds-gpio: make sure we have the GPIO providing driver
Date:   Thu, 25 Aug 2022 10:03:45 +0200
Message-ID: <20220825080345.26371-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.047700-8.000000
X-TMASE-MatchedRID: +2JQkWdm5mrITpavYyPdekKt7woFwOAt+UviL1yO5g1bjFVYvBzkwFxo
        0H+7nJCrLX3qyf3ewG+pTtnpKpQyOgPEvA3Yio/GqaHo+UkmnD5eVDccyVYmY0hwlOfYeSqxbsF
        LINmYCfGCXgJyFho1RoO6W2ZdoUAOGgGhKVztRDuj9Csdp/rgSWs0SgWtnXgnSszr2nuUNKwmKH
        /Kj46+VYAjsy+r+wvn5nkafbcB4NlKp2trhZa6PI9CL1e45ag4cj8zE1EjtSTylEfNwb6iLbpKk
        QnaF6lamyiLZetSf8nyb6HMFK1qe11j5mhaIsibIAcCikR3vq9UOgGDv7pKLtCCjNjL/0CFKqAq
        GJsAjBbxJJHtN2hEdP7PbMzXkgN6
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.047700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: A5DD293160F7AEC87B66475773B1AA67F7B1F06238E9C943AE51A9BA1968A8C92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b9aa14a-f562-4d6c-63e8-08da86705c9e
X-MS-TrafficTypeDiagnostic: AM0PR10MB2993:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJsMow2+hxfB9eYTC8b87DhOctCFgxVpKfK4YMf8xQ9PeKfRfiuQMGrt0X6g+WnIMc+Qks7v6Qxb0VBL9g0GPC2/zexW5jv5hkGK0NrDgYYmtweYhGWVomsBVNAYB4j/7z7VSN+4C/2Pa19vmamg6HnxCeSh3GEUFpwcFFwN97NmpiGotBsh4ic2zGi3GgeOYbqMSb+nYWfHPfBulCMgur35RR5By7mT3t7I/QtchvQl5247ksazOypexouSTkxYYdI8RoWNUrcYfEhb6FiZbVccMA7I6c3x+Ici4W1Q9y1Ee6xzX61snaArpNlEQdAvaHGytOE6Cq5I+fvALmn/J3TLdAEVpRkAWoBTHkfGVzIwtmxh5JFgU8a48CkzAVwWH4f5IX88pbmNqu5F2QyRdmhaiMecGfea1v4fiTKKY6wECX8yJxVENHAZwLhK9aPRPI1jhRTWOcriBhmA3U8S3HVMRjbvxzFEV/Epd7F/p7RqPReoSnjwd5seTp7otpXqle40rZvmsDwHwQziC41k5jNfDp/oSj+AenfjnCGCtpuIkuhWQ8I/JKryqmwVHV8++rNg28jVQs96IulCZyBFGBXhEMhOA8VdNbLA22w9v1yY8xiopxAoo72SlJkEFP/UAGZnjaHId4pI6xA2+9k8aOTgme9tk6QLIVlzwpCVepjcogIiChXTC6AZBzywEyE4jyLmhxN/1cY/At9y/zm2Bm/FF0ZUyRlVkqFs9rzeaI2b2lyCbV4bIIQr//NzGSAY6oOSB/kigGGJFRf6QDiLP3cc2PZY0XZjdBx3ouONG5Y=
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(7596003)(82960400001)(7636003)(2906002)(356005)(26005)(40480700001)(478600001)(82740400003)(6666004)(36756003)(54906003)(956004)(316002)(2616005)(110136005)(8676002)(83380400001)(44832011)(70206006)(70586007)(4326008)(1076003)(186003)(336012)(86362001)(8936002)(40460700003)(16526019)(5660300002)(41300700001)(47076005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:03:57.3908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9aa14a-f562-4d6c-63e8-08da86705c9e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2993
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

If we register a "leds-gpio" platform device for GPIO pins that do not
exist we get a -EPROBE_DEFER and the probe will be tried again later.
If there is no driver to provide that pin we will poll forever and also
create a lot of log messages.

So check if that GPIO driver is configured, if so it will come up
eventually. If not, we exit our probe function early and do not even
bother registering the "leds-gpio". This method was chosen over "Kconfig
depends" since this way we can add support for more devices and GPIO
backends more easily without "depends":ing on all GPIO backends.

Fixes: a6c80bec3c93 ("leds: simatic-ipc-leds-gpio: Add GPIO version of Siemens driver")
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index 4c9e663a90ba..0c96ba98e338 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -57,6 +57,8 @@ static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 	struct gpio_desc *gpiod;
 	int err;
 
+	if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
+		return -ENODEV;
 	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
 	simatic_leds_pdev = platform_device_register_resndata(NULL,
 		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
-- 
2.35.1

