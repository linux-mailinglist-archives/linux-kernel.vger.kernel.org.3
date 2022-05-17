Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F03C529BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242290AbiEQICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiEQIBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:01:36 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C583615A;
        Tue, 17 May 2022 01:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiWayjE1cJHmbgY/Tbb01/ysGdYGSrOT3MY/JsMkLygu5V/cjlykKPvVltXS67KZaPhnqDsM+O+0JshBC6dqB/wyU9wuWtNSmm0OBGPPLiFPTlh4unrmnXcAx8a1ZVPWkEDhveOwtzvq0Ht3GzzcSgouanp2l3NOtCgsTKtU6qZguby4Q+99Hn56Gw/sSeVuhrsPcyImRC8zduWsMp0kmqhynPCbcPHTBfXxq3RNq9r8lmNZHxfAwTcEsukm95AymQxxZghD38KKiroIRk1YGcbfsRCZLQp2Jr5SnDBaJbP5D6Z9Z6NteMAE+YmADR237QG7Z/njIHjFJLN9jxOK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cO5pQ+IU70ujZNtLnHCk+xOHdhbIIMynapQyg6Vnkw=;
 b=WUiOXOMuNOTFkEhn+T57r4r8OccnrbwZCqGLo3+SA6jx6cgLZe8DLjhIscKd21/MtzJnPU9YebyoRj8VaF25qkc7txaUHGjcq5675OD02Ijgs+8BhxqgYhQlwdiX0masmCXFYtkO1P8S55k/IjgkQWNKYzzFsJ38pQMjuk7znHlEVupBA/p7BBQne428GaMGo9LXCHk6kMLU6q2aTJqsGVT+lHVFTK9M/Ogpq4lXlqaH36+i3iZ2oKT7iFrVHGY2DgScFkLZUCj+f8iJPFKezLUtGOiTfXTM32ukKXfuFaMfBcpopLGqUp71VtabbSP6YBdfbpbCNk7kyDw3gro+cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cO5pQ+IU70ujZNtLnHCk+xOHdhbIIMynapQyg6Vnkw=;
 b=ece+lKfNe2SBWY3CM0SGWSEKNNw/uhXjQLO0IOllkvsmmj1tgmXIo16UjVRhlrxyyLGtAqOyVQgD81IxiRH5jix1zi8x+2I0OuaJ3cQ0a1nVSgb1lhkTwY/8PdqXXROeSN7vQ5T0p5EdeePBlbNfoFRxwDKsK7bm+Q323KodQxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB5924.eurprd04.prod.outlook.com (2603:10a6:208:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 08:01:31 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:01:31 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: support for reloading module
Date:   Tue, 17 May 2022 16:01:16 +0800
Message-Id: <20220517080116.24502-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd57076e-5a4f-44d0-cf56-08da37db742f
X-MS-TrafficTypeDiagnostic: AM0PR04MB5924:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB592426747681E21EFD177A03E7CE9@AM0PR04MB5924.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9P9HrzKSxBneltSZQCCN+0USAoGyQyrqQ28rJwCf0bb/zbfjrZU8Kcyj13qWcD/QUYWvCfb56TcSACLDf3wSkoka18EGvIcsgJ+y/fy6NNNnkBbOoD0JBvVo2TrUCfvrD++kKM/ZR5O+Anizgb2of2U34JKlQgNByG4m4aoVJZbI4aaW8d6Udzc76S8v8X9uN27XvftNcumh4ker1CtAiK18GwEip4BnhE3+EoJLOTbnfc63YoBFibxrdWsi1Mc8f7HIvpQV/Yl3ueUggf+5IOdgQQfk8g4IWXlrtwmwbGz1R3CcDU77pI2l82LqNDTUweD+VwaO8i4n+I50VRLw4XNxn/2NFZVCCPq31VMTo2j7fkEtYsd6PrKz2anUB/TbIpJ94LoqzsbXxJFiGK63QZVpwJJYCRxtMNsmhT1LQVwLYquDAQJsdtRvQLb7LFPpdYgjpEkNGJsxfZga3hdDF8XqAhJMcIgdAh4Xv39A5JpxGSH1yc8/u/QmTPdo5o5TvQ+Te8J1nIGhA1l5U7PbKAh8WFQ8CxXxA6pdO1u54KC6gOG5DSC+vVcKWUWxu7ko7CsGHOv/XhEzFZre2WgHHNi7hPwghpgnL5gkbDn2g9HtFtDEuxH15Kat30SwGhwR9XHAJCH3cTEzGWlv1mmuK2aD/u6WK4+TsgGUbyQnK0NXQ0/p8AcnbWwNBIlk6BfwGOd0TzEIw8n2rdt8BtQ0SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(52116002)(6666004)(2906002)(26005)(7416002)(6512007)(8676002)(1076003)(44832011)(6486002)(8936002)(508600001)(316002)(66476007)(2616005)(83380400001)(4326008)(36756003)(66556008)(86362001)(66946007)(38350700002)(6506007)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IvO57ftuMJXrLrZ8M1Tu4netf2BaoOY2eJ8lSbja977BD29vrx2TZSXFyyma?=
 =?us-ascii?Q?I5j44Jj0uJE+NvX6QPRLbmYouQMmVazSt8fW3Cei96wMAbZ5LO4IhI124ZEd?=
 =?us-ascii?Q?X44w5fH9S0f+nqBKnpBgPRPE5e1mH3HC2bZ36Rsw/V1SwPfAftv7TjcypCS4?=
 =?us-ascii?Q?/cv1o323rhbPlusvRF1BTlJYg1rcnthU2XprDpYb3b+6ZPjAq9kfIzeAKE6I?=
 =?us-ascii?Q?GvX7US2LP+29BvQN+/E0vIsYS2SbfQkscFVU4toPArm12F35IiEpwD8Etp78?=
 =?us-ascii?Q?0Ml/ldwIMVf/hQwHGPnLx+CxMFzlwsBXr+JKOvMK0TFZ8wQ0YQ0e7BsgKOpE?=
 =?us-ascii?Q?blWYg9mj+RRZE20rPRzpIBFurkX099zli/ZmfGf81aA3stnvntanOVq8Acl/?=
 =?us-ascii?Q?0a8KJPfxiZOuSsV55oquGf4QFYem6Aa7HEaSvzwSMv5HiuAGbrn4Emqb2rO6?=
 =?us-ascii?Q?jFVC40ktyft2nimt7JghDlYJLFt0H5g2exRzC7tVLNHEY8fD0sNQmQCMnJod?=
 =?us-ascii?Q?kSouyR4Rpjd7r6R81lUbnDwzWSKdB+3IZ3ZsSZhWsm6UqjTdfhDqfSwkLius?=
 =?us-ascii?Q?bNdzg0KqPigGYLrf3yanv9iPV8j8BxF7x73GQP1nbltKkRi4MCz1LU8pMQGG?=
 =?us-ascii?Q?vbKVrayBOLjMNcv9dGCOddesyHdWx4NGZ6lYotgyndB4KSfWGwDfO1c/6fb2?=
 =?us-ascii?Q?repeU+yrfNdmYVMZBCmUmVXfbEOBCWSSJjlqVzLbGrnYQZfFPHBL4pCrDxVj?=
 =?us-ascii?Q?PkFBT+FAUfpdqo7y0b4CKUfvzBrsJATH+nQHJYD7Lo64HyGTf3cY7euszzeM?=
 =?us-ascii?Q?/UvippK4WxH/oBfutl8W4aWZWyglsAOcTraIfDqzePHyQlJAnX6ByUdx0d0w?=
 =?us-ascii?Q?DNdKYYnV7y8/FMeqGBKlHZGUMYxBlgcEevG3wG6StjmFY0fBIQTlYmA3vvBS?=
 =?us-ascii?Q?9xjq7XzG60qCW36fgCDFuj2xqiZpAB8rh+1A+jmtKOkdca/raon6nZFU452O?=
 =?us-ascii?Q?+eVkjh9ZbG8GTkaxZe1QhBGVsnIpUUq8Daqy8K3rkwPYUokwLLVkIvlvcMPe?=
 =?us-ascii?Q?/ARwPv0yGhKpeZe9SNSYPFiSQ7OX/2OW1XsJ2xPLmNwNVbd8pWH5If5XP+FN?=
 =?us-ascii?Q?t7e9IwPK2aV0L+cKdUH7ePYxSLdm/nGzhUgDN6XcMEJWmjr2uR+F8CvYONBM?=
 =?us-ascii?Q?0C35kpameMA6CsO3dwsv5/Qxqap4LhRp7+/qdGPOy8aKqBabrgueX7xD21rz?=
 =?us-ascii?Q?fngQl7+FazGo/5yIxuHmwg/9TWAuzxmSSMxLMXCsoZ6Jw+/jxKOwdHp98TEF?=
 =?us-ascii?Q?KpF8irP7D131zQr38RPBrx/5b/7ScT8psuycE1UFBwA+QmN/QEOciOlkNqIo?=
 =?us-ascii?Q?dT0OC8YAZLewTMCgA8NXh6J3oA76pQ05mpU1Ujj0sr/5kSK/ibdIpxWzuXQy?=
 =?us-ascii?Q?ArSgJlFKjHx0svE6PoQmgrdTOn7aB7B8J/PHDOdq+fkkgmsiZmwzWROVABq/?=
 =?us-ascii?Q?ExEernF+N2eQwW2nhU9jkE0xyueLqXYuDjpmjst9EL2/EQ8ChEurSjU1F6Rk?=
 =?us-ascii?Q?vbof6g+F9FhDu9WzosZqEIgM9tWDLZGNRKEFEjcE3G4or0mfmqnudtYLXoCP?=
 =?us-ascii?Q?k8wuLLw4uDCKTd+uQocvlhM60572UjK5c3N0x/1byFifAplXSIvA0YkJ3VMb?=
 =?us-ascii?Q?gqUxU0tHQgJaZNy7rEl26EQ7UthuxTXJsvm3bOM8f6gbjsE1Xy4XwmSLMTWs?=
 =?us-ascii?Q?cKkqS7jiVQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd57076e-5a4f-44d0-cf56-08da37db742f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 08:01:31.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOwDkhhMZWOfGTQcfsW4bmh69kRKbdRFIchIsxJ1kDNWtotpAzNSJuBJZ8bl4wiwA5xkhIwWTIyr1pzsc5niYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5924
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no interface to power off vpu core.
So it need to boot from cold on first load.
but on the second load, driver need to restore the status
instead of booting.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 68ad183925fd..3cca7ae2355d 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -257,14 +257,8 @@ static int vpu_core_register(struct device *dev, struct vpu_core *core)
 	}
 
 	list_add_tail(&core->list, &vpu->cores);
-
 	vpu_core_get_vpu(core);
 
-	if (vpu_iface_get_power_state(core))
-		ret = vpu_core_restore(core);
-	if (ret)
-		goto error;
-
 	return 0;
 error:
 	if (core->msg_buffer) {
@@ -362,7 +356,10 @@ struct vpu_core *vpu_request_core(struct vpu_dev *vpu, enum vpu_core_type type)
 	pm_runtime_resume_and_get(core->dev);
 
 	if (core->state == VPU_CORE_DEINIT) {
-		ret = vpu_core_boot(core, true);
+		if (vpu_iface_get_power_state(core))
+			ret = vpu_core_restore(core);
+		else
+			ret = vpu_core_boot(core, true);
 		if (ret) {
 			pm_runtime_put_sync(core->dev);
 			mutex_unlock(&core->lock);
-- 
2.36.1

