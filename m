Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83A50BBED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449532AbiDVPpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449525AbiDVPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:44:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2106.outbound.protection.outlook.com [40.92.20.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B75DA17;
        Fri, 22 Apr 2022 08:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRaHV2xdrKlTnztMWr3ShF0NNJkxGsxfErquBWVa5CbmcznaML6eG8JZ9zfLGvG9w9UYduGZRaLwZGny9AmaLeaxXO3HbZ46/QWW/L3FmAf8gwM8tNMvf+wvydf2V9be13RsWT00CV87RqRWMDirrSZL1rvzfL21bvDDHZuKanUQ/XXDCNn9HVmNKA7Fn+hLjElRBG+jFyrayuhtNP9ULPsRTi1CKtJHV0ZSoVQCJP3Q95U3rH3E1gaSfNM0YP4f+Q7dYb9lV9skjQfkVp4JCEK4HcgVQX8iFN5SyENJBdONg78wEKvsA1BxJp0MNZQqlvOFOTUjC7U794qlN7JnOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvoIg0xCoDbQbFXZmqH9PfX08WH/AvKhr5AHr7a1Bxg=;
 b=fSmY5Qqzk0TdDXG1rRVBmJoQtQ3ZLX7zG8medgH/02NYI4Wjbe0tzMNVSF+3jt6ZP2FSVEzwqybtFtIeL5zGsjv3ugqVeRkSJ0N/thRqAAE9BVJBvWZazDuOqAeqv2YTi6V6va9ta7lYJhCqqdCj7OWNuzgqvgBO9+n3P+CJzJi9dg/kayYA+VClfe+lpdzmsPD5PIFkIpcPvYfdizRep6HdnV0kvotgL3Ni5gOeSJ17o19Oww8T5Rj149fAFFYV+276dOQDQk2U8wnJG1HT2Da069Ce6m+leAkve82f2xeabYepWmCXfQSLHVdiJ5UjIbecZEV/aPNfxkJPnBmqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvoIg0xCoDbQbFXZmqH9PfX08WH/AvKhr5AHr7a1Bxg=;
 b=EhI7dqhBK4K3Yh2o+2mTHWbJcyYwkknJB+NG3wARiqcjSRpnb4PuOmUz58pEyXyYpBWi1aU9k156h+mKyGjc3NmQ1Atht32LBLauzKG56QHU5hpu7DgpySp+3ACSMWCPBuKe3xvZRu/qHgIvQ5C+SyLw4oBd6zY2fa2fPNqpHIZbsK4GleiJmkES9uPLEmnz1Fi8sPTUTz9aLmOP1+GUEtGzMC2TZT6HeBqJno3qvI0IblWxzwFs3HwldINg2IVuHoQeBIrJ0awkmSG9mQXv4eh+EDyKt6xLosyumfILADRlGOjHnvdn3pHAKCTaWIA5vWEgFZviFW3kFi1Lyew/2Q==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by SJ0PR20MB3642.namprd20.prod.outlook.com (2603:10b6:a03:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 15:41:48 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 15:41:48 +0000
From:   icenowy@outlook.com
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 04/12] rtc: sun6i: add support for R329 RTC
Date:   Fri, 22 Apr 2022 23:41:07 +0800
Message-ID: <BYAPR20MB2472C608678F3FAEDA7B7541BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [Dyt7YlPL/rJcXW6LKWcMHIxSxU5OtKRS]
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422154115.1068642-2-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e11d460-19f8-4650-7703-08da24769ce5
X-MS-TrafficTypeDiagnostic: SJ0PR20MB3642:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GQQ9S7ArIv4zr6gXV7o/gBbpG4iU5CHxqMR+KRBJRLpZ20N7ImI6OU3vJUQG2EcQlroqIGZk4uiAj9HKGy1wJjCAFF3pEtDGPNXoQpOkLvAYsBy1eCHsStcBTIT1ucmBBH7+BIQpTYrGUikJj/P31ji4UQ5DGVnT7RpUgWgTrDSjzLHqIzyVKNVxegXGUFH41BtlGqMM5T1QaYQ8v0+AqkAn1o2XAOLmi7QmqsPwpRQogM3Op0zxlimu32CvGJuD7pxn8iM+1sFQSnY3YdWqTx7U3vZCX+IGFcX9QbmrFSs7BHvoMri5n4yA8trBDHtkH3UBIY8K3lLpNG6TVpVer7N5DfVAkUpPoGppdu7I56EIg0pV70TFCzkmJqgKPGLwFudBevkJiVg+5x2o/JjDhf3UQ2e3tTHbvtDcW3T7d1GYTn0LPKJx9mR482+BBRqoau1oK5Wk1+oZP0wHTPCugt5/xkOwePBh/L5tg+Y/7zv4LMnruSkNIZ2NJueS0nyJYxSfgRdiByNizytLPEfo6U21ChZLe40aAVzy3jiJwk15ilMW8OhDTI/6PnSky4ETQPw6MHMHzh44+sz/1xAoQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rp0gpuVDbRo/6EhgCVnN+b4wnA22QSqieJ83N0hTAgrLuVaqe6I13p5CdM68?=
 =?us-ascii?Q?O3NzVZ5UZjyljv33vEmS3x+Lbt72fMZzLiL1TRJBaRlANhTDRS4gRWiumgVZ?=
 =?us-ascii?Q?ojk6sgyJgGyh6QfOkkY9HowHcGM1TwUP5+K8VmVk/IKdE0rXYTXUUftrGu3w?=
 =?us-ascii?Q?uAaKcCwRdIIpuL8BFl3+j9sIsCiBNm4wb2R0f88/4WBbjc2WdZQFKzXJY5Dm?=
 =?us-ascii?Q?IswxJm2JkVBWzEolkL4jLKUZjvDASfM3zbjyCcu/eZd0vCqy99R3L4vPZwtd?=
 =?us-ascii?Q?dKdQU6ypDN4V6mCYPrRZ5AoFlcCTb3z8LGFHfkHSNbwtR7BAEGlM2GCBOCHJ?=
 =?us-ascii?Q?XRE8QJ/172U4Zdbd4fO2s4B90xHOXX5jW6IihQMnKLXV9bQ4VOvCWfy18LY/?=
 =?us-ascii?Q?K8qz4z611rHBMELNXrXBevLLLz1SxPhbZ/tKNPdGDGci3FzFByi2NCm3kO2a?=
 =?us-ascii?Q?8nPUBsoaMNe4GVyAK3XCHJmWLB3ZJjbZm9Iyn3y5BhA0fU3w4vh2K7lQ6x7B?=
 =?us-ascii?Q?a8k3aEwTMn83iueDEnebMR7opnB43HSxQEd0gId297BzOxxwrDduuUvmdUa6?=
 =?us-ascii?Q?LE423cWSlrAqgOXo4xnfJPAmfxQYO6Gsis0WKA1wO3quCZ1USb1BpVygiw3B?=
 =?us-ascii?Q?ns1gr4RRn4/rf8Wz6RgZgX2YatC2Z4XjMBzLFz6XHvikUGmCCcmbJc8WM/XL?=
 =?us-ascii?Q?HnYkZJVzNg6gBBwL9+lcx8r+y4EaJRRkIE84XALVuALoVpDr5UlL5kGAn4Zi?=
 =?us-ascii?Q?1FwRYqHZD5UIU3WYKSTnS6Yhy+nXMm62sQ36Qy9+a0F0pyf4k5pTEmkSbGWF?=
 =?us-ascii?Q?0WGBquTwJdZkd9/YI6DDNKyqy0lHHAp/LxfhIyLRwPXSpnVbyIeWf1HbCRvm?=
 =?us-ascii?Q?vs6t1rCWf4dP2LI0wmwrcqROEAYXqobQUBsdz7n7f3XF4BhEHcG9dBet0rfJ?=
 =?us-ascii?Q?zEySRlkgYh8Scd/qO9K1X80O0Imj8XmeEsm1uzanrH6nEcChNi2mXPS6Jdrr?=
 =?us-ascii?Q?Hsr/TyQuweGiFmulcSdYrFqR9EJUzrLAkSwDEGZDdIielj6TdadYdsiWZaXT?=
 =?us-ascii?Q?O83HyKm6b2cL2t4PjgU9JAGa2QV6iHZnuDqeoVIbgu0G3On8CzDSRq25DRXu?=
 =?us-ascii?Q?dirGhfNt+i48e938AOcybQMtSQuMcODkcTBx5GMiEu1+IN1RMLU+tsXN+mpb?=
 =?us-ascii?Q?iQzE2lBLeAXeIF3Cc0IjwK7Q2905ERcUucw1xH4PTipFrDHjAi0AqRlIB/0Q?=
 =?us-ascii?Q?gkmsF02bWUo/zZ06f+GliNFoccz5qQBZyHD1oA3jD924dXA0uSZCt0BW+9md?=
 =?us-ascii?Q?Wk+VL2RPAvtaWaXce9xjkeMBjeEKgV+utzWL7MPo9Qj2uCAMHWgzt2Q+l1AG?=
 =?us-ascii?Q?FYqw3UmAPnrvfCYFMsbJ9nyEhj+8EHX87nhytv2dPdBSKut7gdUQfRfyJol+?=
 =?us-ascii?Q?PdlJA0JuByw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e11d460-19f8-4650-7703-08da24769ce5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 15:41:48.7589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB3642
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

Allwinner R329 has a RTC with a similar time storage with H616 but a
slightly different clock part.

As we have already handled the R329 RTC clocks in the CCU driver, add a
compatible string to RTC driver to allow probing of the RTC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/rtc/rtc-sun6i.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 5b3e4da63406..522e28fb05c9 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -816,6 +816,8 @@ static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun50i-h6-rtc" },
 	{ .compatible = "allwinner,sun50i-h616-rtc",
 		.data = (void *)RTC_LINEAR_DAY },
+	{ .compatible = "allwinner,sun50i-r329-rtc",
+		.data = (void *)RTC_LINEAR_DAY },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
-- 
2.35.1

