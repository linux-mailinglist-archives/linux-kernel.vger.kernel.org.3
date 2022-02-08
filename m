Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE964ADBDA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379425AbiBHPAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379094AbiBHO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:47 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30042.outbound.protection.outlook.com [40.107.3.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7D9C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRUIgZgl/GxGXMTzpqZ0vkgWAIZ6AG2B1P91hme5dk8hKepLj6tAiITOGUHS//6WrOiw7kr4lef34l7vzrpG396LDW+J2w8pxqoKpmu19Jr5+nzQP300DG9Gz0Ci9qVhXL9GUHpm+j91CsZO/ypV+I7cOcJtpDOj1iJI1zLDNQDs01PADfUiTkuzDjH+ETiilOkQ1ILyfx9wvahjGEmOCEVXiYhYRO42kM3M8zmPzamQyKip+oNmvveZhxF1EkAk1KMYkoWcY+gktRkQJuaWPWwmIeY1MYFGsPnhHmug94RAhUgSkTBHogKFC+KwfsJzaOLt751FY5d7A6TvuihppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4O2Lagv7O1pf5L/VLtiBzyR7q63fNy3Dyk1iOpkkUQ=;
 b=dE6XFCl/Gy+sDMNxiJzt3/a5SvXEF7WOWZZcHEH+7C3vEUlOCk5uVV13PtWblTHkuaxVoKQ+8Lr6667Z5JKpt93rhtt7I0/zOGHHtuOKDbCg0BHk+ruasM4RwZlzahojzxKXTu6/OOqcBL5WtfVADLGNlne4ZfEjoSu/6L+mHItp9HZCvEi0MLr+A5xs/mTvqXNm7F+sN0u8GQ52DWcf6V61YWDDQgHDdGF4cTnW5E6YOJpq5ItabPkPn/yoJIjbcM61gR/5I7ewFIQjYcp7bHuDJDkkAnpW16/p28G9LEbSYbevl4hiZmvCbeGJGWxiigAYFdovblbScA7uPbrOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4O2Lagv7O1pf5L/VLtiBzyR7q63fNy3Dyk1iOpkkUQ=;
 b=eTU7Rxo4XJnZ+e+y+1XXlMo+qrhgbfJki4ajAvRrzSucNpXguZXbt8uVs1Ac0VKO2gVV278efftJcdkZSpXyEE9nrU9d1yVAmK5ZnEdm6mUy/2eink59ZtCm+BCJj2aCtdruLzsdRHW7570ksAVT4oLwm7pF/qLPO99YlTU7a34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by HE1PR04MB3018.eurprd04.prod.outlook.com (2603:10a6:7:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 14:59:43 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:59:43 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 5/6] bus: fsl-mc: move uapi misc dev create/remove in probe and remove
Date:   Tue,  8 Feb 2022 16:59:27 +0200
Message-Id: <20220208145928.12468-6-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd72cb19-e644-4aad-49dd-08d9eb13a391
X-MS-TrafficTypeDiagnostic: HE1PR04MB3018:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB30184AD39D3B74BCF522CE1EEC2D9@HE1PR04MB3018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QU6Ws9pPBCg1ESsLQTOu4cDhEv63KWtvs7TxWhLudutEfwis/YikAJN/WF29KLEYjW5GKcCp3IY0gNkcuiDiD1NPtRcuJLAJc/mBGOWbanPIAwsLtzJsluzIEhykLvOhQtMHT5XdqFKPh5vvCA0tDPMt7qEowWSmehREgyWbiQcTvs/QxvJNrwNqy1lYJQqQsZEWm8Xj4YOHmLBY+fCPR01uBvQOUpVZd+og/UvQGl+knM3DuiUpVJ/hpM5ggTY17g0Qikni7oCUUyrhwuUGkXG1AC4F7pwpLEARKAgKCYO2X+r0xUDAb9yLWOEnaTiDyNEChQxC7ydc9B7duLO8p3W3ugq0KyU5GkIoRANpBcD9rc0BEf5KhZwU7pEOycVXhSOyrbyxbRlAzfTifkCA6NiAWbiYLK2eXRJk1r6i3d26U8466o8v4k8zGE+XUCYws/lnKSOed3v/mDc8NHyDneE+c5pDWpsw2iS+RAu5sxfNIAzpZXR7KhZPoNvCcVEhBo9AEX54TghETTDz7eMpy7qd0JXYLiky1ExhogW3COwH4wmQgSlhZNmbpTqRc2tcYyBQR2y6dYF2zVPPE8sunJ6R0wYJm6EDW+bKcKlSwsnDzI8WVtHLcZ371D7gSu1HACTfOFD6vNBP8ASGrlPlBiXMm/pu9yS0BKN9T2y/t8rBBIto0zEx3LsFejrmv6dJR3koUoLSAKk7pX8i/h60A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6666004)(66476007)(316002)(9686003)(66556008)(508600001)(52116002)(186003)(6506007)(2906002)(6512007)(1076003)(26005)(5660300002)(6486002)(8676002)(66946007)(4326008)(86362001)(36756003)(83380400001)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bPc9ZkscoVtNMpfH1wHqFaVZm27rDo3Qvs41mH/vMnjNrqWVXjLyQpzjRojQ?=
 =?us-ascii?Q?Uu4E7ZIeRC2olBnzhIgQchNSu5LxtXGSMSVZYB2+YMxCyX+uqNLFN4RGinHB?=
 =?us-ascii?Q?CsPhWY18sdEOX6pjy79od0bok8qffsNv63ldV/xAB2hbmYwi38chpm6RRtP1?=
 =?us-ascii?Q?kt7eiLDnPTHo92y8cUyHx0fzGXj6KROe+P4O29YVTXLXX7t+BTTx84sEhXpl?=
 =?us-ascii?Q?NnYCEwvGVWeIVNGUH/xgjG5Mo7kvqQLpwSAzPUaUpG3ckxF3gsl3J13eOKPO?=
 =?us-ascii?Q?e/99Gag1XktLZJb445aKDspNM7eMRQV2WiUZL8aYGpkWEQwyZHKT5B2Be1yL?=
 =?us-ascii?Q?laYjkOd1ypMSBYzCFQw3xZguqMLg/hyxB4M+SHG44H7SJUvCSwAffyE1lBRs?=
 =?us-ascii?Q?mje379bkDepMt/08yfW94o7aKRIpeSaTNWvv49EmqpbAE0N7krB06k1joc2j?=
 =?us-ascii?Q?+ubP+huUdUZ4b7e45vHFslZ7wR9vJkU7rkmJbJ2EzI3+vGOfFEzq5rIj7o7E?=
 =?us-ascii?Q?nGbIIC7H3NP3Xj9XC2upqE6S5RJk/VN/ro7IshbUVgIqFI0NNjM6MtICMgod?=
 =?us-ascii?Q?nUw1irzpwRbv3N3ftkKhe2HJC6a0fB+xITgEB4F55tjS035f9C2cRJCIhne5?=
 =?us-ascii?Q?YPbyDxZiQQ3ENH86+Mh9vLokVM1IuUn9kP5O1UqUCkPmd7vztwSPktv8Dv29?=
 =?us-ascii?Q?t04ZoQYdnuZKkopCkXUXctrnxf/dgmjKEbAXSF7Z+tiM/3eMzxUQWtE9iSAc?=
 =?us-ascii?Q?RED+cEYKZ3slWDjDglCXbcx21Zpp3T44GDuzNWujnjeRfvVZLd55nKP4xqLi?=
 =?us-ascii?Q?psagYr91VRwUPzIW9ljxLZh4SVVyH9OxxnnGandYKCMkSypBbVvO45AqmtNn?=
 =?us-ascii?Q?GpoQqbYyVuRb4uFw6hs45lXLfYUSNGigiCuWcs5yyaeSnuJUk1bHlifPKrlY?=
 =?us-ascii?Q?rmx2KHQY5eYREYT34+YWDwHBgR3Q6oKk4eLA2/Ody53sqATvSLrWZpkVYjmg?=
 =?us-ascii?Q?nkVF9k/KVe5KNI3LNAK6fsZppA0VNrSPpZDQI3Q7gYzi0r43Fc8jWBq7cwHo?=
 =?us-ascii?Q?3qJ0WaTsAsNu4Vgr0qbJKs4o+emVYa/sfneYNIMa8C1j3QWHQTbGUqYSCI1L?=
 =?us-ascii?Q?6fCPZ+to9ZlMA518fKN4qijaKUTsQgRzjhvXHOB+t18jfVWOCeEkQjlp0oJI?=
 =?us-ascii?Q?jdpUgGSS2AkiP24pWqfrZw03Zxa1a8TWy1kfuQLL5zV2WSBVN/RSYmnu1fWx?=
 =?us-ascii?Q?XYLDwiasCpD4fH2C+3Za8spNzB2x3Y9TL16yahexh0KMt4KoSMKOfu55kjKo?=
 =?us-ascii?Q?QDaLpKQXqqe4m88ULH4TngyyFUYS7lYKk3M39wTqAadfPvABV69CryRu/19j?=
 =?us-ascii?Q?/sAbWqoeq13jooV1ewosaM01M3mYvMiWyyQiSmswQGFM7RHWnxpFwjMNdIhR?=
 =?us-ascii?Q?oIMcF048T1OuusH+McnTzDg2pNlMxMY9OvramLOrHbFia+w8hDpeKcoMMopT?=
 =?us-ascii?Q?bxM6THtCjSKOV6Ueb6DofvvvysBJyHr4rxTotZPkprezndiHABBME0o8AGUB?=
 =?us-ascii?Q?fqLomlkujebdjLEJjBFKl9LM2afUVeHsVYd3a8TyaiLXb7HLphf8mqn9Fokl?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd72cb19-e644-4aad-49dd-08d9eb13a391
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:59:43.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7h/Va3q6pmSgjd/zbNuMffUz5E/fSCH+3FsUH91KLPBbbE6Dora1qIfDr/0npnGV9Q1ooKtg2wdSG9Cnk1tU4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

When devices are owned by VFIO lets not allow user-space to play with
them through the restool management interface thus breaking isolation.
Drop restool misc device creation and destruction from the common
dprc_setup() and dprc_cleanup() functions (shared with fsl-mc VFIO)
and open code it drpc driver's probe and remove ops.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 8482c4fca835..82bf3fe09273 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -618,7 +618,6 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 	struct irq_domain *mc_msi_domain;
 	bool mc_io_created = false;
 	bool msi_domain_set = false;
-	bool uapi_created = false;
 	u16 major_ver, minor_ver;
 	size_t region_size;
 	int error;
@@ -651,11 +650,6 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 			return error;
 
 		mc_io_created = true;
-	} else {
-		error = fsl_mc_uapi_create_device_file(mc_bus);
-		if (error < 0)
-			return -EPROBE_DEFER;
-		uapi_created = true;
 	}
 
 	mc_msi_domain = fsl_mc_find_msi_domain(&mc_dev->dev);
@@ -713,9 +707,6 @@ int dprc_setup(struct fsl_mc_device *mc_dev)
 		mc_dev->mc_io = NULL;
 	}
 
-	if (uapi_created)
-		fsl_mc_uapi_remove_device_file(mc_bus);
-
 	return error;
 }
 EXPORT_SYMBOL_GPL(dprc_setup);
@@ -734,9 +725,15 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 {
 	int error;
 
+	if (fsl_mc_is_root_dprc(&mc_dev->dev)) {
+		error = fsl_mc_uapi_create_device_file(to_fsl_mc_bus(mc_dev));
+		if (error < 0)
+			return -EPROBE_DEFER;
+	}
+
 	error = dprc_setup(mc_dev);
 	if (error < 0)
-		return error;
+		goto uapi_cleanup;
 
 	/*
 	 * Discover MC objects in DPRC object:
@@ -759,6 +756,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 	device_for_each_child(&mc_dev->dev, NULL, __fsl_mc_device_remove);
 dprc_cleanup:
 	dprc_cleanup(mc_dev);
+uapi_cleanup:
+	if (fsl_mc_is_root_dprc(&mc_dev->dev))
+		fsl_mc_uapi_remove_device_file(to_fsl_mc_bus(mc_dev));
+
 	return error;
 }
 
@@ -792,7 +793,6 @@ static void dprc_teardown_irq(struct fsl_mc_device *mc_dev)
 
 int dprc_cleanup(struct fsl_mc_device *mc_dev)
 {
-	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 	int error;
 
 	/* this function should be called only for DPRCs, it
@@ -821,8 +821,6 @@ int dprc_cleanup(struct fsl_mc_device *mc_dev)
 	if (!fsl_mc_is_root_dprc(&mc_dev->dev)) {
 		fsl_destroy_mc_io(mc_dev->mc_io);
 		mc_dev->mc_io = NULL;
-	} else {
-		fsl_mc_uapi_remove_device_file(mc_bus);
 	}
 
 	return 0;
@@ -854,6 +852,9 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 
 	device_for_each_child(&mc_dev->dev, NULL, __fsl_mc_device_remove);
 
+	if (fsl_mc_is_root_dprc(&mc_dev->dev))
+		fsl_mc_uapi_remove_device_file(to_fsl_mc_bus(mc_dev));
+
 	dprc_cleanup(mc_dev);
 
 	dev_info(&mc_dev->dev, "DPRC device unbound from driver");
-- 
2.17.1

