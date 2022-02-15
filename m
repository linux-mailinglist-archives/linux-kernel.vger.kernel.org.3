Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258974B7197
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiBOQck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:32:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiBOQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:32:24 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2133.outbound.protection.outlook.com [40.107.215.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD88AE7B;
        Tue, 15 Feb 2022 08:32:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocbuCte6iXkEOhZQi+5ncQy/Gl8b5cGDuTLHE4n9G60oR+jZFhLC0fBYhXlrgJvjEJPZf3vxCtyzCs2ERJasrMpBw07CW2SdfuDlhsox1MbO3jnHAjCfHnup2q+Pt4+WVsPftnOp7LW3nQaHenEs+whGBhR9xeS42s82jJgsl2RitWpIBNfxKJziyvgbZ79FxF9ULrWLCALKzCHBK7KBXbXVDijQp0vIW5BRzvKHqrtE60QG/4Fc86Hvx41w0XFtBfwXBvIwZv8uW426PYKjfxd5WJKKwkuPz7nbQpxDF1TKVaYGa4r+8GmwxtG/NMTe4NGdtvcHFExEQXo/cJisyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD84erzwZcmJvxTAi4UMStZBHu2WVrQkwtI8CCbdPFE=;
 b=CdIR6Zh2/He3aaJAKUhk09DL8KpTbyWV1NSLrpaT90E4RyD8rjZvqtReBboBXNbEQyM587wq0lWPsrNZCLwu/PjOjcqVqFlvHhV48HHfeRogvNwAB9n33QpqcZ5qkWfU5YmB8u7jEZ4heNtwS3Pi+dVW4S4LRi22fkhT5rK5R74riKxMLHfR5oRe0h/EAps34HCD1MIWSzDqBpoOUDotDaREuepDaiXzrbQOcIpJbVTfsSKkAMWITgNzMWVp4/705oMY+5y+jtjV4ZN5dyCXSzv6foshZtRFCg0MsPuNTAXBuT7SLQNKHcvgc1KTG+q507HXJNGAPKu4xhve+kHcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD84erzwZcmJvxTAi4UMStZBHu2WVrQkwtI8CCbdPFE=;
 b=lvAkiUUz0YvOCFJeIcYazYxQ6FqfUNLR18SVUSoLEvht3hVzEGvNKDFmqMiCqtE/pdEHMtIjmSFJEMAtuusLll3FoAPu/EurBqQe+JOdDfn2JKrM6thTHo+mPuslnal6/aRc4m+ZraW3alDlDtGICg5TK5xldj6NazTVRqp39qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by SI2PR04MB5695.apcprd04.prod.outlook.com (2603:1096:4:1a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Tue, 15 Feb
 2022 16:32:09 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::ec21:c033:761d:3e03%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 16:32:09 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v3 07/10] ARM: dts: aspeed: bletchley: add shunt-resistor for ADM1278
Date:   Wed, 16 Feb 2022 00:31:48 +0800
Message-Id: <20220215163151.32252-8-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0141.apcprd02.prod.outlook.com
 (2603:1096:202:16::25) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0103781-5d00-4c4f-7bf2-08d9f0a0b5ac
X-MS-TrafficTypeDiagnostic: SI2PR04MB5695:EE_
X-Microsoft-Antispam-PRVS: <SI2PR04MB56959F5388F7B5619879498E8E349@SI2PR04MB5695.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYKzsp8Pp3gVWPLfUnlV62DmY2/LK+/2NmfLVwkhsxdTwsB5EhFHUj5dY4IJKBl09vwP2gEuGr/BCqG4sgiZLBmJr12rI8ZGHi2KAW8zYcQypn+mAo05ivHuqIeTlGofIGLfcifaVwY86rGmzxBTQaSe61vk2R6K1PHngFSiq1EvE0TBqml6KaQY8mF2EwAeZpONd4ThHMmLamKNwJ7dYU2I1jQ1WWPbPotT/lhus3qbkI1yQYsSE08I/TCKQ35wPl9uuUHkQBhdtk2Kajdodw+NRdjGvmVjS4TGuSrdDwllMcYteW1MOQs8HOn60kZ5W7X/OzUBoX05K+KjqIIhOPF1XVydVNgRf0LCnQ2vAi87MqaOsPY8l+iSEf7bw0LEFYGGBP1a2BWY+z/VZPaUhxMRn5KpaeARPhIFtgZoNDyevn3rw4XSRfm+7x+Y8ubSCMWth0/TT1+0BJyeMOHfbupJtTayMFoFscFfNGj+lhJX+jsXrNGbk0SeivbjQleydn3OQwrCVMn/X7NgZjxH2GV6N9PakKOdA9QfwseihJpZ7SIg8RJWB+QCkdUyhN5Lf9LHluS+oN6z3rTfOWti5DTL8VDn+Qlc9r8n05cjMU2IQoW7y88CgSa3+mtN5tjffaA6YhMwDD51gE+7QjuqgUmSLQYQw+XqyqkP8mlhGRNDz2xi710hVjokcqDIO+mmg+kTVOf6iaI4nxJFv6+NrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(6666004)(38350700002)(5660300002)(52116002)(8676002)(86362001)(2906002)(6512007)(36756003)(186003)(2616005)(1076003)(6506007)(26005)(107886003)(54906003)(110136005)(6486002)(66556008)(66946007)(8936002)(316002)(508600001)(4744005)(44832011)(66476007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oJNxKkBc8WCyTxjaw3IXTXhS0ZGGdC6Z2bP6MsRsio26nlqP//T6Yu2iDey7?=
 =?us-ascii?Q?rOdQFSMpRt1Y+Y9Zr2Z2BgW1iTEvW4elGy108MJo24fv9R8CJWz4QEWtBzuY?=
 =?us-ascii?Q?MI98fChuAzjWtpXUI9gyZgSnqtO4qSzcwLErr0pTfHnsPuoh0dzGQg2BD6bz?=
 =?us-ascii?Q?Y+ERr3XjjCw6j5p1WTXPcCYxFMZvN4eSIR6dh2ZB/SqMg4E5TryNUChtxTyN?=
 =?us-ascii?Q?AC+7NDjJH4qQZd3q+DOFn0vDq+/juPEKgABmHfFsTOK19s9Tu+IDwaAn+l1/?=
 =?us-ascii?Q?3z8e/PbvCYNjVmCEhaOd4ysVGHX9dmPcDULbfoIoiwFd48khI6lqfJc2zMv8?=
 =?us-ascii?Q?NNtODokDq6yqHZJLgVp3rQPv6qxQR2HNV2WGgPCAn0tq0JT+sATUtht/k6K8?=
 =?us-ascii?Q?RfzSBTRVKrtM+AvBWEv/OO2d2sVMUT4nMmMyKRlxfEhTTsNGPNGcTBraHmB1?=
 =?us-ascii?Q?IaQHtO2zsskrDKB0swCRSQ79emtUFuYOZok4EFgTAwNBm6FcaNuNIB3WT7MU?=
 =?us-ascii?Q?1ayWF3wIoSmKzK19BpukTEYH9ET72nDhfwuMgmmh+w6+wvg7YfwwCTv/umKd?=
 =?us-ascii?Q?IF/ruaMvqM+nDfZ9j4j2YzWVJ58K9Lq8RahXQYT5nM8xiNKfX1jc9Y7+YGIi?=
 =?us-ascii?Q?A/Avt+h1YvcZUU814plBOBQhEWNeGv6+LL+zCazmR6PAGA4MCiCn3pz00hLc?=
 =?us-ascii?Q?V6GATHF+PJPfeG9BHaVzZTYqyGfgisMlQI45Ql2c/Q5D4vnyB2TVSYhITiVB?=
 =?us-ascii?Q?PR/3zJNdVhRQO9R7MB3bfo7Bilm4q+fVUCLjugaitbniUT2COXj4WQF7aIaD?=
 =?us-ascii?Q?k+KzAwif5PqNaYV6FWJNlh0bC8SXS2g4qt1KUEhNEZrStrsu6OQpiU4HRk/B?=
 =?us-ascii?Q?Ks+shl3WkyrUyS+xj6CA79zXSDy9g8lrzhIIWTIFiBNnMnjbsp7qxTx/jxVU?=
 =?us-ascii?Q?kj26zUA0IPWUpekVwunW+fv/hTAYgRJuAFlXzJXDx3j8iwZOIRzL5Xx+om4W?=
 =?us-ascii?Q?RdnT4WCNSZ/8RnPq9cR7dzPLE1rAoIXR08Cly/G+6j6yX3GGhETryDZYRziD?=
 =?us-ascii?Q?z+nq15vDvVsNfBBU0qq7RoUPkVEraa8ceIiQ3k8D0aWHeFfYwpcRgw7SBJE3?=
 =?us-ascii?Q?tlvyQwPk1m2dlTBMKdob9sRaHXwcwFGBFRZhQOiXjI95tJvsPr5067O8eFCJ?=
 =?us-ascii?Q?azq2iNCLCXRqXWElEjD6uEKXItFUSc5uiQI0kLqlqbDkK/h+uwZxgAsOCiEG?=
 =?us-ascii?Q?PCalkSe2djH8/2a+M4WC+yw7Vi4ACuvR2XUSErx8e/jiDRBIJgKWrat20BQ7?=
 =?us-ascii?Q?Z2fKaNkM17W7euRx7yOrDUnQ1RNi50tbfDglTWu/XSl2w0EnMH/jIGT8e4wd?=
 =?us-ascii?Q?b8Is5wA1eKpUMwrvtcKe8ISDS2HYP2eXrc/aYLGAmOHQZe77g7mZtIjwhGhZ?=
 =?us-ascii?Q?41C9+W+onGKQ2goTXbalvYkbTvPYU7KBQKgOk2pboqrbrWPdTMb8/OAzRNml?=
 =?us-ascii?Q?C5A/yr9GxLX+pO/pKy4Y1TGFfa35+nZCJ/Z0KCuIS1SKYNaW+8RsVLt9tBlb?=
 =?us-ascii?Q?ZTUjKA0B0fOtFWyLIox1120CWRiuuz20B/EJyqsdrapswy4A1X8mt24mrdTb?=
 =?us-ascii?Q?qnmAYKK8YoP1EZMn+XXAA2I=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0103781-5d00-4c4f-7bf2-08d9f0a0b5ac
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:32:08.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZfYI4WnDacbxSsdRFnaU+B0HMIan0uSlkEK3kwnSsb8HoVcZ+6uVj8t5oGE24No3XeYwPdHF/zWz8/1SpSXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5695
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix with correct shunt-resistor value base on EVT HW

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index ba9ac01cc585..c9c3ff39bee5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -714,6 +714,7 @@
 	adm1278@11 {
 		compatible = "adi,adm1278";
 		reg = <0x11>;
+		shunt-resistor-micro-ohms = <300>;
 	};
 
 	tmp421@4c {
-- 
2.17.1

