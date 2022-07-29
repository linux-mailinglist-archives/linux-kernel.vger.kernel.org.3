Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26F584D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiG2Ijh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiG2Ij0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:39:26 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57F8246D;
        Fri, 29 Jul 2022 01:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke+O9YQ7QKL88QrwCVLIMJRzgbVNZRS8GUmHd765FkVVYg7HnHKfte5csuP3VOjzxOKNKHIqqGe1mGbOy8XcOO88+lqJqVcOrTXQM2u3SzCQd//ZRtAHYySLjqO9adrZ/S1lsnOK8FfFx21bhqgKKk62781DQlC4Eik9ia2ndC3EjizNOlr3FTx2+ed/yyVkHUf+cf6s3iTXRMwHtGS8CjMrMqeNQQ0NzbX+3HGQ5NTgkC8jYCL8V7k4liW2GzM+rrd9T+wdTD9vfVulEuBANMzCDvSp7pVTPDmO9e5z3YjpWUoGGRbMSDZJD1BxSdNprVJ2YgwnMNvItM261+5jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBttICur0Y0q9/qXOVqRA9P0MD5zSZxqwXPSaoXuvHc=;
 b=Jg2Oxd7lJLJdbohFikfzLp7QbT8kuLFbzUrslVyePueK3sbCDlyRInQvQNlgsu+5gr8VHfU+jzc96wRFBrQZqirwdMuWrYkN50d/C4XsQ2EwVCBqcyRzcyH9Xv1xXReslBOV0v2tN4UkuHfYb51T9WNcb7dnc/6ltPSuZRZue+2cxY0pgt4OIV5hDDMISzJKd/QK+Oqz4oKJfLTYNkfBIH+vu891ADVS0jYHWp/LIFEf0qntaBGerSg60HZRCDVcFQR7FlMa8eA2EssZcUf0b4R6A2MoTiYVeQL4rloJ7jE3j/3jn0F0m1pd+/SZHKN2mlxBnnB9gd+FP1CAhU21eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBttICur0Y0q9/qXOVqRA9P0MD5zSZxqwXPSaoXuvHc=;
 b=U6YdUX07zORHL9F/N3d0tt4hWn5CAtS+UHpU1hvqEe8Y8BRRS42UDdLtRpvj97PMEH+naLQRfikcv012jAy6p6hL5S16FA4JMClnp01OMd1u3UlchKuISmpSStgJPRc1WXvQVhnvCtiU07vWFzbRH1RkieD9+1t8W3zkSe2w9Ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB3039.eurprd04.prod.outlook.com (2603:10a6:802:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Fri, 29 Jul
 2022 08:39:23 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5438.023; Fri, 29 Jul 2022
 08:39:23 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] media: amphion: encoder add support for contiguous planes
Date:   Fri, 29 Jul 2022 16:38:15 +0800
Message-Id: <07ed4b29871ccec0eb1bcf497f7cebdc94d5aac6.1659082839.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1659082839.git.ming.qian@nxp.com>
References: <cover.1659082839.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:3:18::16) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 632ec358-0417-42af-d10d-08da713dd639
X-MS-TrafficTypeDiagnostic: VI1PR04MB3039:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCOzhqJx63ISfF+whxrkGV8yKMpU44RPz5P+7icMZt24zQpKTdRG2wrSeuQ/1g3GEL9uVPkYXI04ov4+hVVe5m13Jlf1AbBSyVii1fXNrHHIcOE64e1rXaWtjAE/mu2hyx9kv2c9hFwiCJQsGWVpr+RClEDbbLVLR8netATZIb7LDmKjC+hVYh5QrbWja7qy1ibYOQ7dE/sE7XHCMcbcOCo0PYwp4zwE5RVZ+ISj4W01/j604uoEzPkBbXODWwFO5QM4Jlv+2I6Yj6FQ++44b+x6K/VoPaWADsmg+iHsEKc2MmZsK99TUoRM/gg53ZzHMXBkvK6KopH3q7oF4TA6v5MPsbW3XLBcIbtyI7FuEmPBaodn0duzd7+zqF4+Sn7MnURqhVBItX0PascROGSwb+qTbHBidzwL/UIF8tjOfZroGCDJ/lRzWoV73PeSpx3LfSSAV9+O3+nizodWliKWvl3yT1no7aQZ4eWHhwqVF7cWIO2r+lNdT3QgEE1c/kNmsOZ6KwyVuxbXeimiJ31q6tOZHNuvZBq1rQh8spFq3cCvsEyCy2x22Ssh0DaS5zRTnrrhKqihnWOtCIg9mEcBNBo5b9uLPpicLd5aW+7C54RS5yUo4mEfXNQ4nZ8PMTxEqBSJEih/IzbORcR8ahuLQGGUXFUHrTgZ1XPXdC1jNAeRbq5SBiQxPvUAPBl++ISdnD/UcLCbqtp124rdxhKQR35yHtsv6ApUjwlOQSEp/5aNGsbAVejWElZDEvHTLTckpx/sTnybzuBknBK7BfU76sihPB+ah8zXJKeFwytEG1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(8676002)(5660300002)(52116002)(316002)(26005)(44832011)(8936002)(2906002)(7416002)(4744005)(66556008)(4326008)(66946007)(36756003)(66476007)(86362001)(6512007)(6506007)(6666004)(186003)(41300700001)(2616005)(6486002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBIKi3voGfpZjlBgD4S8InX+v6zA8NNANOmItLiJbuqGY0q8BsSLbqqzjJ5k?=
 =?us-ascii?Q?1q6Q/E8OZW6mwYHJtEZCID6ERGBZ+xYKz63iLbzAyol0kIZMJKHB5IMQQIha?=
 =?us-ascii?Q?IyCVEvou60LRaRzaUXsACVaRUVFLam8zIm6oyLjae04AVhS53ZNAy28wiUKD?=
 =?us-ascii?Q?Kt13TXeR442pJISpN2at5fAGrdNLg07zZ9Tz3zRZP0qzqglJ9J/CnEX2pYC0?=
 =?us-ascii?Q?9Aidusunoa7o7aGdTektyWDd17wcizwJHFHe0R6Rw7k/b99IXyNTC4p3THYe?=
 =?us-ascii?Q?GzpZlYCFw5F4bx0BSSllfAB1kze5DzPzD3kUmnEhepDXhcDFFV/15/W2CV/w?=
 =?us-ascii?Q?caATDru1ykX3mbrwF5AgVZQ/wQTixOTcZtIPv2bFZ5qOjmOBRqccUHhUqysH?=
 =?us-ascii?Q?lqE8Rf5Q8dnRhhlqHHOako78cMkiQmyY2vhwv5myDSlFwAoOJbKd+R52QA6c?=
 =?us-ascii?Q?r1FonwMgMSzfF0MUS7Ur9mv7cobVocyU26J1dEzH83OzBI5GITi5+9uoYayd?=
 =?us-ascii?Q?QnyN0NlyFlpMTKzuRbpwl6V2tjA/g+5Ci9d2pEoTOp4J7GLFjiIWSGqR3sjI?=
 =?us-ascii?Q?tYjg/herVDdApbT48I2P9zD2YBmoPA1psj94mhpTNWW+PQYNt4vlJbFHtcdj?=
 =?us-ascii?Q?bjxwnV85z9Yolng93m2bpCBjcfkr9tQH3r4+5yus8ysuP8RVPOyFjxz0l5X0?=
 =?us-ascii?Q?wmLrPVnDYV5TgZDUvU/a8QVXSZTE9HuiPc/9EOKwvEvw0XbEuAajriv1MmuK?=
 =?us-ascii?Q?GVmlUYJJWt7mUuUyZpove9u4EVbbqVJX745x/n2npgef+3QRbLEQq0+2jTZM?=
 =?us-ascii?Q?YNw07rctwXqROWraNfybaRbV5WNm8psswOetHUOJr8lVXGhzrGvTjFEL10ld?=
 =?us-ascii?Q?sKyFIgBZCSSggZN8hWDj+fNFR6dWpcPZsRuuiy0ssAhfK42870jVgURybrb7?=
 =?us-ascii?Q?itQPg5TtTqVCh8J0jv69fkKN0dA3elUGlIXtrkezp5/HDWXs3RhpXGi2AszM?=
 =?us-ascii?Q?vVCnLJXrkJ83HT6jMiGtZAp0D03WoyIatU77lR7sLMJOGbY7LG8Bl9tY3CXL?=
 =?us-ascii?Q?3956jlzCVaInAH01cgRamVDf9yy7JSOTnKWJBV8jyHS4IfSRy4b+Sehw15kM?=
 =?us-ascii?Q?DVun/HFDvAvO2Uzs7rptU/1A6yWomh7wG/oD3oAQ3ZRdzgdqw/Nzxz2qiph4?=
 =?us-ascii?Q?J60elvSOoVb4qI0Yb9x7YBvRu+SBrPNZt467tapq3JPF+PNPbxAci8W0x93x?=
 =?us-ascii?Q?vZ3hXl1WrV6J4t7I0tqA+Ko8JRcEkuBcHjPBTUfNjhdDO4YuI0ufTTYWFO7A?=
 =?us-ascii?Q?m6Z+sTjQiCZYFxApKK8MPKgzuSjTLJm4n2fFjaM928otVCzBYoHwVR/sLc3G?=
 =?us-ascii?Q?N8GnfmOXayztkM+iNnOHUSy6Ujxz40PGokpR9bDevcCXv6gkBlnx8GteGJwg?=
 =?us-ascii?Q?vTr1RBG0kVub25smrKq71cnmtC//gx0+kh6o9a8oB+5NfZ87p9pE+lc36lob?=
 =?us-ascii?Q?+ADK5EsY1XnmgRZNluqeq/gzYPEVb4hk8hBECw2whgDcIfhR6DK/cRiZHTS9?=
 =?us-ascii?Q?5WbxFMjWFjmo7tfVXbFYf9JSArGCnNTgG1XAmGn8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632ec358-0417-42af-d10d-08da713dd639
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 08:39:23.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd44vUCFFbU1ld1T+jvTdEYeP/5kFal2huT7yfvvijk4wzh3OPbM2x2P/QZbgaV1D4TLpkXgbR0D9dthNMwiwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

encoder add support for contiguous formats NV12

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 060a1ee78b17..3cbe8ce637e5 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -72,6 +72,14 @@ static const struct vpu_format venc_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.36.1

