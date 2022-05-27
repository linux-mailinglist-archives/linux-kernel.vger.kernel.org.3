Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158FF535AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbiE0H4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348276AbiE0H4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:56:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274EB103D;
        Fri, 27 May 2022 00:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdCOJx2o7tA4spoFyD4O16cXwtLq7qfzEyFyQpXaTqZw2nuCzf47SRdh+Y/4TvQ8wVzAfvd74T4fA/hV0UaAWHrtvHYhEjvhZ7jCk1gpQhzJcmvnmE4XSUt6b/3P9G+s047miensB3UPiV+c33kex0nnRiKf3iE8yKZvr1KvLrRj6z35SbJ2uOdI0rchvQFVy4dqotwy6/j+id2B+k+TXBf4gjulwiPwgkd+e2Jq3YYxwNLUoO3p09ivT8dv9mwnhNWwcAf3fVxf2yZOk3JvA/QnmIfPg2WJHFMgxS1MTM03XsqByaJvtKBJEzyjEMoGHPeHUfJM9gJzRQF3C1Xv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIpDLn0/saJxW0hiOc6yFNUmxYY34zMVozRBqj9s52Q=;
 b=iBi7GlK4uM49GLSVZXbAif9lU9SuHmzs+S+me6yUqPRfCH/qTorblHdpn4zUJA0eWSY7an2+WSZQUm8wDkIJ2p5aNvx/PjZ/EygTElqfnYfgV3c9dw0BaFwX8iXmnqhhXjw71Fr0459/9BSo8Nk3v36XzY5hA3l1YvoLzrbxaqT9yp7i4V8HJAqkQZKN55HO0uiF2v5S4b0tEIDENkk+tYmn7GF7n/n+xu7SQJtTZP3V0uO2yvqH2okIGyqkDcjpQrj+1EC90uuhq1yqUtPyIdpvuNXyYO+jwlLgiZF67eFhvmMezJRn+QUljUW4NqjZxj3EsP4+gkuWP7EbAEvtYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIpDLn0/saJxW0hiOc6yFNUmxYY34zMVozRBqj9s52Q=;
 b=Pg+USNFdOPwLZLAZBzOMzggo8F1NXS6cd6JHAJHWg+4KTYMEr6ak8NbecrJHoC1Lq7Vi9zS2gZg6IuJRLYIU/tWkPCtw1AyvUQuW1O/i+cMajeMAxNsM5nTm31Nl7jkbo7lBHwOYWTX9RoQmBfcjsvBTid//WcH+PGEY2/u6TM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4590.eurprd04.prod.outlook.com (2603:10a6:803:6d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 07:56:12 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 07:56:12 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Disable some unused interrupt
Date:   Fri, 27 May 2022 15:54:34 +0800
Message-Id: <20220527075437.16882-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527075437.16882-1-ming.qian@nxp.com>
References: <20220527075437.16882-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e9c5ad-7900-4163-3a19-08da3fb65e01
X-MS-TrafficTypeDiagnostic: VI1PR04MB4590:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB45905D19ACE9A2E70D686779E7D89@VI1PR04MB4590.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZY7QMHUYZP05gCGfCdqkIHIjxWiQl9kSxR3iGKIGRcIf4/sQgYoZf3j8u3ufPDgRuCldmOlX3M9CQwfUgrhaUe1vhtHGtozBqIN/M2DJc+wsgQ0yKe+Wn/+FRRWihKuwL+cD6rmxUQfMrIugLy2n1C+wI/4BOOb8MXHU6PVjcc8b0tn/PNPh6TY1eH56HefgzW5CeAdT0FyBca8GQeSm+c3F9flXQSxy9EOIIlQZ97JNJTh7+Fz4jFieholaquJ4uNg6nIl0yKqHK2NrnG0ewdQZn0K4hvDmtnutH6+4kRuolhN/1PCXHC2XFuf5f/YYEJOKP80jMQm8M24TkwCEEpnnSB9b4+z/gFoUxYcmAiluGjQ99KW9DH62S1IFz1+niZHwdIR056CbqKlOKNBq+eqRD4RP1ZmnYuBpVMlME7aClI2HsL9bkBgtiv3FwWOheveqCE2GY5RUiM3Pyo3adwD83t8qAdaRIozIwYgoHNUOJzYJ5hMfgjcE1mk9YcuRJAQtdr/UvZeAabVuYDYiF1Ewmba8irAdMNf0AE2hYs13zfoy1l5aWGUKRKbdnaTcq/ucv1+eYk3ME3WD/2W7YH8TlN0kIDhgDn0aak+0WGfbFRelIpYpjyBj+Qnh0qkuw9odqScIMtHAn2tg7j6zBAUf33mvpqf+9VLKij69cUNBmkzZSAOUNl+15LGB0zskmDFoj13cz4rd0nEIFh6SEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(4326008)(8676002)(38350700002)(66476007)(66556008)(2906002)(38100700002)(316002)(4744005)(36756003)(6666004)(52116002)(6506007)(83380400001)(44832011)(2616005)(6512007)(186003)(1076003)(26005)(508600001)(6486002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ztmfT8s4ZCcuzDdKjsh5UWFglkw0EiMFChL+sj8Tk23918snJfHd7vhDCvmD?=
 =?us-ascii?Q?u71VR3CXz3hmR/IMNlmnBUhrE2ef5HYc/2ZJGQ6mqmsoCXOPYfC3lThXYHcb?=
 =?us-ascii?Q?4xZrtTy5kWZHeLAVUFCA2KQa2S9iaYyWhl6WWSlXBSlC1P2V6JlVzXt4MWT/?=
 =?us-ascii?Q?caQaKtdlo+W34IS4x61vQjtgNGevwgWl/TjaO435+im8JWpJStYmXAk7qoav?=
 =?us-ascii?Q?DvlWUcn+JTzj7qViH7RiV5lMe3biGd2BcCaJ4Cg3Fad184F2S3GXN9IrUi6q?=
 =?us-ascii?Q?jO+b2SFCzltrrcICe/cpvs/Vc4jR8U3gjbUxyTofuUPypnDL+p5aIDbNBikJ?=
 =?us-ascii?Q?3xWGlAQ9VRQv1IlOreBT/SBeJim9Nsl5TUj05tdpskVNarPimxba636bG9+D?=
 =?us-ascii?Q?Ss6+2YylZ+lK290rGtoQWM/I+SUL5uAs/v9HviCm/LZ0pqf4CYId+7p/mNQZ?=
 =?us-ascii?Q?CvMV+PnKkr1SMFwa+FKDbUrLInRWOuERJKjpm3AM4ombKt8mJyVoQAjwLMHq?=
 =?us-ascii?Q?fuUHteyWOH6E8I7R4ehoHht/ggpDMjtRxFZFSrVjCeIIvUU0bUilyDSxWWPY?=
 =?us-ascii?Q?Srm8Q2Mj3wpMAiMmou4Z/OVsTPy96NrNAIWNEfMRiUa7kQw98VtbFONoKG/j?=
 =?us-ascii?Q?9T9YY3xiKIKYHSVlyDzpHPWuNWx+LH+tJ5FZ1HEnpqsfxItJFEx0qJi50A2+?=
 =?us-ascii?Q?wTTHQ1h335TwipMR85AqEQOyTxo3LPIuSpj1TQjutQTdsaPabEwCCDwRQEkA?=
 =?us-ascii?Q?N0dt/4ZwrGFw9T0OqQAIqXBTvv1RBIi7a73kYHOhayczvCIr9yD+Fl+HmECL?=
 =?us-ascii?Q?IwAoMy6Hm5z2jZvJoo9Av+YXHEjChn3p4sDGr+WRhRRs1sgcoWhOB7Qv3aDC?=
 =?us-ascii?Q?IFZmPcgXy20gV3GY8mzLrhW2b4CJdBlri57ulnx8Pz7btiMiNCG8Kmjd0ARm?=
 =?us-ascii?Q?KyMVqsri5yvaRVtroh+xhXNzCDBwWrtf8JxP78VvUTQJyQSIkiif0TEJ5NYY?=
 =?us-ascii?Q?gO/EQcoJ09FJ0wJf8MKDKVn61wIqywepDaCm4MgQ565a9exN+j4BmbCGgoVK?=
 =?us-ascii?Q?25QrBNOUj6JEl5vg0sX1Odkmq/0S0ojejTxkGw7JOZwOzcGDMoXcicHVXRIX?=
 =?us-ascii?Q?erBWz0P/wmhMGfmzX8KTD1p52ybKgmGgntAvD8n/pW4Q0R7V557hA395sMvS?=
 =?us-ascii?Q?nuwb8UMTmx0A7yk5TH+9ij+0IsCYcpZYOc8ghdBvwkJGLukuj8oZw2F+SAJi?=
 =?us-ascii?Q?pZzbVKXD7nbA5+IpNtzBe4enBAWJDc6YjnxU/q05AIbAqT06Wy1E8otV6NHn?=
 =?us-ascii?Q?ohYmHS3Eak4LgmR5E8UCrpjt6L64Ylp1Y3L/7HfZDoPjt9ZtxVzc6Tn2fRuN?=
 =?us-ascii?Q?6HtrWfx7swff+vXUuknThCgjK792NDqC782bgLkHrQUI0vw5dcIYEht+hvN6?=
 =?us-ascii?Q?tnVUlRjBNgI1gG9Qf9Ti0Dzhc81wOmJdDDxf8i1SktoAOiX9bs+nPvNBVM/W?=
 =?us-ascii?Q?1hxTNDTz+hSc3b7JxbK0lROILriOxxwbJ/ZEdt1ByoBeNElUgOZby2rKguLj?=
 =?us-ascii?Q?iaC+/vfJF5N3jbMIj242ixzPoSMrYrbxssr8gVvLQa/YqmpWHwaUxY1Lt6BS?=
 =?us-ascii?Q?sgrEB8RP5w63TDrQViZelhcQbpjYR4bQou80JG9KIJGQ1RzjoQFG5ffzYxtu?=
 =?us-ascii?Q?pq2xqVosGt4d2B5ZvQsDKY3HV9cqdcz49r0xInjlh7/he+MPiocTOUpymICc?=
 =?us-ascii?Q?gXt8KC8Czg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9c5ad-7900-4163-3a19-08da3fb65e01
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 07:56:12.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkrUogPa/KwXY2RnnuGiG6jImAjjPhsfRmdiaubIt9nFw7IDF1hTDlWWj4iK6yE6d/xv6uPhdHjZmRw17Jz80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt STMBUF_HALF may be triggered after frame done.
It may led to system hang if driver try to access the register after
power off.
And interrupt STMBUF_HALF and STMBUF_RTND have no other effect.
So disable them and the unused interrupts.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
index c482228262a3..258fbee7ab66 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
@@ -76,7 +76,7 @@ void print_wrapper_info(struct device *dev, void __iomem *reg)
 
 void mxc_jpeg_enable_irq(void __iomem *reg, int slot)
 {
-	writel(0xFFFFFFFF, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
+	writel(0xF0C, reg + MXC_SLOT_OFFSET(slot, SLOT_IRQ_EN));
 }
 
 void mxc_jpeg_sw_reset(void __iomem *reg)
-- 
2.36.1

