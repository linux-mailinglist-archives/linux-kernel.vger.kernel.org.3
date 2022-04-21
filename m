Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F71350A79C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391087AbiDUSAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391041AbiDUSAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34F346B04;
        Thu, 21 Apr 2022 10:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV/9aouH8aLKfV12Q+YdI5+4Ev+IewhyXgDm7NI+dorhD/PxHMJC/+/M2LZZ2+HFqXYWpWzt6YseF0xuv7ZG2x4tWS3H4HpNnWISYxS4OnQh21TJm9vFlMU8N8PIFc1UfZO8nIaNKxW6me7ZymHIyT/GOlv7hcOzpxneKsPIBv5GkjyamE/OgM1r57LuCGioJ/9C8FaRUyLqTTMm3KiwepaCJPKQ3QDEH24R1E/L+ir+sS8N9gXPNuWYkvTO+D12Az8pYEAW3B60de58Dl2lvep0QrwqjkshvZzrTAQUlqUyfSE2VzXOlB0gR3B4XMAgv2F8S5EzqkEIqMUOSQwPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWXg1szD/VfRg7AQHtNTsFToPwu23YRFqbagXQuDDyc=;
 b=nasCnB9eOcNIEm2HOaDKdP+JuUkY9cFdaeyqqOltIGKWBvxwu/Qz8G289Nvpy02IDPc3Gb1nRggyAAp1NqvQIED1lAmOQcy45SraMMp0JXkxzE6hKtUvEnOIGqS3TtsERVzsFNJGAyU6plHWOwvtsKNy0wtR2QUsri1MPryUbM+upMgX5nhZ1qg4eR5kxvzvbIWIGa0P+ql38OuEcyxHZBccxuJoI5Wclw42m1Dd03FcyPDQ/It76a3HGW+KtNbDSw5Z7I4AQLIzq4UET3OJ5bH2M7maw+pKtRqYt4qC2D/tbs28dYZ8JUq7PiY5ackB7HgHHBAHrPBerKa6gRlX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWXg1szD/VfRg7AQHtNTsFToPwu23YRFqbagXQuDDyc=;
 b=R/jOI09k4DfLWYckoKAjoU/dG6Nck0n31p4yUU+Nz+hXH/eJB/uoe5f/npIOA0caA6Tbt/+iKjASMOsg2A00fh+hfhVLgvM0Rneq6a16h2J5LYMwSz71RIERDUM48fGS8Zt2F1h+CxsSSQv14y6encv1bc7uLayKxYuUGP0PUNjDphxkej1/SS7f5VWntxXgb0kgarV7ojtTGGmW0TILKlU/NSvSx92flQ2qnQvzK7uIomEAejILAeXiY6Zjxz4/S/Q+nqxPesnYzj52meA6WAdJBuOA6F79Bi81p1yzBHCG8VOy+5OpKraAp8frgbAiJ3w9Y0098LlEtB9DlayqAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:21 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:21 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 8/8] nvmem: sfp: Add support for TA 2.1 devices
Date:   Thu, 21 Apr 2022 13:56:57 -0400
Message-Id: <20220421175657.1259024-9-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220421175657.1259024-1-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95606dd1-c142-4117-decd-08da23c06231
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB81010D1EA2F638457F36C29396F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrmwTKdNGse2dPlwAlNcjgxcCZokbacQDmEuNL7gXOYquUiGAbUEJqpq6OTdW5DAnuN1Od2Lb7Of+1Q3wFT7m4vU1c+PrLwbfc5hafJ63cmHUQ4Dgh1oclozNoxjWtx0y8T+A1Fps/20GA3rhncxjoDl4Gr/8Fs32SNvwZ14Kx1ROzNNN49JUNhxb8VDlA0URtDQ0RMyTz9rInTJLyqR4Q5VxzMXa6Z92r5uE3Qq9404XTiX5RlHSlfKeReiDr4ugf0p5/Mxy71t+sbBu3K9GzUF7wk8Mg6q6suiTbNSBgr8TJVRG3WCK5NscqoEzT+JcsxDhqb2e8YkrKLHfVH8GqJ090xbkpte+2fLYIk1ih5LUTgxXm2vRJiYBQSg5Nv1RLILnLJzFKrAbJaT4Md0ZuDNZLKrCdA2OlYOlNqisbAonOX9kTiiznbxiBfk2zqOxuGjvHbSIuEaBI+Qov/GVYm/x2+FyzOgT0Z7EnNxesFN60b3yjm7Xy1NQhmK+mHAnCaAklyhSWJ/0M8LhnAxp59EkerGKV8XNaaIAwEl0KtWz+F9/jddPhcxVFagvcVnWzjPX253mxNQ9jKxWxfz8OtckiPWfnsN4gE+aSWYZVg5Oc0WKGOgWpEawxptB0vhQJHdVd8FQEkdQXeW8ZHsCgvai4zzb6NmBs8xf6lorjxQ4SgS+Qix0ZcS8yVeqvMRXYCrCyp7ZTIH64u+gKSZFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(4744005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dX6scfOVDnZEqpemRKGZhrr0DD0KiD5bZctRi0+u2C//ClIJYEQjjwPF8uV7?=
 =?us-ascii?Q?edB3V8QKThOysDZTQJSOsqSMr8upsfeWZyDfSp2HKnH5mHwB0GqMx4Rflf7N?=
 =?us-ascii?Q?HMt+KlLfnPqa3067DzxZFegiVFHCS6nU1IIKjFBJ/y24tGs0RLe3CSoJRnJe?=
 =?us-ascii?Q?ZQTi7jlwJ5toa+3RkO+ab6bJCYYUXewlFO48V8SFhH7mwCTBT7iRF2fx657g?=
 =?us-ascii?Q?Jrt3SE+CayRuCO52sHJFzXIB+XjFBKZXVkO9W2Pk3Lk+wsDUzi/d4ioqM6Xz?=
 =?us-ascii?Q?K6SZmiqaiZikCv7Iu7F/VkyUuLAsOpQOos/tnfelR1a2VaI7hRVwBxgZXlE7?=
 =?us-ascii?Q?pHI1r1b6jciDjC4M6v3QqW95f+e4BedHYhRBvty9/ToYOOlw2skKuPpQXL87?=
 =?us-ascii?Q?RuO7LK9Qp4drKlEWIqTO3lS7P58YVgAsorwcdgZuKw0KymcHdrTiGKcYIzBg?=
 =?us-ascii?Q?jljPUA6YEV0ZdzUl/AO1MFfybJpNbmmnKeLxtStcuiaEMGXNyJeKximpBeXq?=
 =?us-ascii?Q?KU96uA7lP/pwBCd7r0ClpYBcolBuXuHuENCAnZQIpGiyZUwUdnu0hHh2uthl?=
 =?us-ascii?Q?uMmgXWkPaZQY2VvfRf5gBKtTzFPpPWf6wu1aHmz0k19n1QqQNkXveuTpltf5?=
 =?us-ascii?Q?MwsP1fJSVEDNsYeo2UYZR+QQMd2fJRLYhdlbI7e7CGjWgFb55dT8pCgXTbIV?=
 =?us-ascii?Q?ojpRXC6ht4h/uQcaX4nh0QRsV2ZHvmNnEwNDbr1e5cgWVBHzEdRS3N73J0iP?=
 =?us-ascii?Q?0cGnDCVF+mL1YAC1LYcSle+cLmt67kX7zYrIakr2jzwDgosJ1veqVHEomSPG?=
 =?us-ascii?Q?9a3v6BI0yc+0zshHFydp5pRqBkmCz/mui2ND195sHGWxEXNqk0G86S9evx/F?=
 =?us-ascii?Q?u1stVJ7SEAto1sQALz4emaSzI8UsKBsW5zOd3sRQ1FcO1EjQvqlWpoeLvvaL?=
 =?us-ascii?Q?zQRb/J2eHu7kuazZBe8bcxVsBSRzTRzsUiAdnfp9vvpjdsPzqf5/mr0SZcWB?=
 =?us-ascii?Q?cshof7AWXsBSmGtpgEFd+FmZF31ZFUtmbyaf3LQbCitJ5nMmEuKeZKGOyalR?=
 =?us-ascii?Q?gB5mpamNTYNQp5hpRtVXsC7pQ9JjnzZ6L9i2em/0COGO9BCfKmLU7gIQpeyv?=
 =?us-ascii?Q?rLZ7/DolkcbfRF9kyegrqGgV/djfsIsGxYse38VQ57h9EPPSRbGF4yvdQ0Bs?=
 =?us-ascii?Q?0X4j2bbQR73QcdL9QFu0AHQieoQAAUNmrzV2o92clRz1CFn/R0ciVsHVHuWV?=
 =?us-ascii?Q?edtgqHCcucM4ANhtUaURRE8kgq51XoN0XQtZnSNUN+HWeWUmGxfW5Q3X/X/z?=
 =?us-ascii?Q?k6h0DdoAgCTtw17qHlMpHBWL/VirXCrArkhrzycHKeQY0KiaVkEtNUw2nygR?=
 =?us-ascii?Q?trhIautR1mP1dyTzNdNCz89iGWhGbx/5hAwCaZInfWaqZ5GFoImqp2MQyGpc?=
 =?us-ascii?Q?d447+aFcd8UNmOAcwQo4gE3b1YAYkEAsqk4TN/cTRNCH+NLoW9C/nBNjs08j?=
 =?us-ascii?Q?RvaMrmRLKwAQ1LwWOaCtiECnBcsdRYB4hOyocY80G/dsoTyTkNL826NIXShR?=
 =?us-ascii?Q?KxLDobqjBxCYEeYAcUsxpntjf2CKG4hDqd+zC5OyxmneZWIxGbSbtRSasfHG?=
 =?us-ascii?Q?uk+PpmycBClVt85nxIHX9bc0+BmSLX21w8EQzCh8au9qf82/5CVlJGscwZWl?=
 =?us-ascii?Q?dulfJX9VVNoLzVoLy4dzwFIfg6YsEPFs9aQroL91er2N1ouUJom9fqy/7iMR?=
 =?us-ascii?Q?6N0mWkR2TRJpWGnw4MZiupx5qAUVQ2Q=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95606dd1-c142-4117-decd-08da23c06231
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:21.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SF8VAJFLEUqZcIkV7OE2rNgQcED15rMikTjvDw0FjX7OLKYVgH9E7Sz2z5E76v8sSW9Os1jUaf8+WU+1NYKpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Trust Architecture (TA) 2.1 devices to the SFP driver.
There are few differences between TA 2.1 and TA 3.0, especially for
read-only support, so just re-use the existing data.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/nvmem/layerscape-sfp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
index e591c1511e33..6336be5d8726 100644
--- a/drivers/nvmem/layerscape-sfp.c
+++ b/drivers/nvmem/layerscape-sfp.c
@@ -70,6 +70,7 @@ static const struct layerscape_sfp_data ls1028a_data = {
 };
 
 static const struct of_device_id layerscape_sfp_dt_ids[] = {
+	{ .compatible = "fsl,ls1021a-sfp", .data = &ls1028a_data },
 	{ .compatible = "fsl,ls1028a-sfp", .data = &ls1028a_data },
 	{},
 };
-- 
2.35.1.1320.gc452695387.dirty

