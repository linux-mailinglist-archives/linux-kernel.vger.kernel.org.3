Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B1543C74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbiFHTHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiFHTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:07:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574E3ED30;
        Wed,  8 Jun 2022 12:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX62DokIzurh0tKnhqUdH+mUAGv4hxwbODzbwGQ2pyoYTvtFAPfWHLADkLqsisoYOpaGkj5uDgE6/fCuNdpg0Lr1oZEJrW09+kJSwH0vsPmZugNxmmwIOMCAX4RSpuMOvhNEe6HqO/I1qvwdMXJYQ+AIXKLyML2wL8MGNOtjB1X1fx/Mef9kUog6OXRjR463FWtDUyc1yQB9p7/qlGrGtXlLPoy/9Vk51fj6Zl3+9CO8zE6oBvykCVuV0nVKJFcmlF/sgisXbeJxNbXmTkr0bgtiuqxiA/vyGAF0boAKGaCTbcGME0PLqfzgu8m+vBbmPnxFEvnB4uIXHN/7a0D/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JfHpjbR+8XQZBWfEIC3GokrI0d9n+OYO9EcKqnk1ds=;
 b=Y+qPnG9UNjwpy04qqVe1WBG6ggP1GDdr9xcJxQF1QXrnen2fFMpifYVG0XYyh5o4ysUqs4WAPOa4z+1EI6n+uhVJo8wleIncOg72df68b3mCn+Heu1R2iwIbwDVGax45X0DOrGp3HeKqGTicL2mrf+msr1nXBYSpTiqNGqXri+IPWQ59R0/Bb6UMk6qIdp9SfykMgnul3Vr1F1SvVDFjOurBlDYbGtHKJVK+VNnF7WBVs0P1agvVBrialldjKo2BPZvRUtZyn2+GkA6ub/Vrd2AQ8Kjlqr2ilUcV8zU+nM2LaTLoX15634U0QeXyUnHje6CjUJXlFlTw24jaa0A0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JfHpjbR+8XQZBWfEIC3GokrI0d9n+OYO9EcKqnk1ds=;
 b=WjXk9C/IIw/RJBJ/5DolUea9k4WqF+fBEiHILWlAsTVF0qgW64Lyq/MPsZvAhSuEb6Wo7NiVbGjqcD/R+Umvn7vdMnDxIbXN+mAp1lwhwlMzf/LJ2D2JIzf0oYd27zvoyQbHgn/a8exJ09qWIB3/j2zR2ONdjQGLBUKnW8XCGZk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by AM6PR04MB4199.eurprd04.prod.outlook.com (2603:10a6:209:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 19:04:47 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::e0bf:616e:3fa0:e4ea%5]) with mapi id 15.20.5273.022; Wed, 8 Jun 2022
 19:04:47 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     peter.chen@kernel.org, pawell@cadence.com, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lznuaa@gmail.com
Subject: [PATCH 1/1] usb: cdns3 fix use-after-free at workaround 2
Date:   Wed,  8 Jun 2022 14:04:30 -0500
Message-Id: <20220608190430.2814358-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44)
 To PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c27b0d36-c428-42f7-a453-08da4981c151
X-MS-TrafficTypeDiagnostic: AM6PR04MB4199:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB41994E75BAE1B69C907FDEB988A49@AM6PR04MB4199.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOAxO4buJSvUjmbrDV/BDZKxl6AFWbEX/VWgAlynYwcoYqitnpqoyVmjQMWFBgRU3m5qFwfnGFe6bqpnOYV/pd9TgTLHftBuVEmd0K7hSeAkJ5Khltnrogw14mBEaPcBLZ/NFbO7o1EWy01CBPbSI3T+DD6otVi6CGmfHpwlVqGKwz0XzuqEoCeu+vNLPSz/rastBoL8u3kgTp2xypHIDf6C336B1g2bjGSMqE0sGkI+Sgfq9Zqs6t3CQmX3qbxKmCz9hJNqgpgfd8/43KYxoZLe+NpizJ36wDV8HDB+nRngXZEh7qlJqcBDzOZz21o/sdgyWWEJUH0Wr3Nu/e399lKmkT060rg1yOUu/SH+FmuvPlpLDO1c/F3uCv0IXlX6FX4DoQibeM4XNHekuj6agpAIDIEMT9nQWd70MFTxQ6npiO1u/cNoZWzE9nBKXXe8Yf+tgNgI3ZSERQocwz3ugxmrC38XVljrg4nB4GE3X64rXR9LNybPUf8PFVU4I+gvSx+OA5tbzY3c9pUX3eygJMspgbx5Xrly2MRA5+8wICBQgT0VCKAun+BUPP3v0Z5+ABnxL/u1CQ8RuRb2iEXktqQb/IdZ9NEvZ0CZOwwe9hTWN8sL6nBEHsamz8au4ATzB9lRaGxXGS1nfY71hoHuchckQLzdZ7eQzmIcnfS2Ba99DTHuzk44cPQyo+7B3ZP/U+lvfyi3ywGZqwqXQ3OI0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6506007)(83380400001)(8936002)(36756003)(186003)(38100700002)(1076003)(6666004)(508600001)(6512007)(26005)(2616005)(38350700002)(5660300002)(8676002)(66556008)(66946007)(316002)(66476007)(2906002)(86362001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KmGqrTRImboKbaSF905UdcMzorSpVhMRePlRH78iuL5if+GYAERGTYhNSGCM?=
 =?us-ascii?Q?ZzcVAscSqLIK5iT6JfSTztBAs6Db5QQ1XNq1sOc99D2JZNE6HjuFc3pCeqR1?=
 =?us-ascii?Q?bNASbfjlcEK+7RfGWwGvQb3ox4JYp9TwyJDvd2u/Z1rmc3zW5mldmawoMVKy?=
 =?us-ascii?Q?GsXXTEtliuEMuS2Iiz3BUvrcp9RP3+Q8KK2dXSS+fOZfsDyUhOvHDVdsuNFw?=
 =?us-ascii?Q?KNlyTRuctSqxUVUhsg5Q5R64ufwf2I8xomQrL/DB4NKMulLM8cZxsqp+CYi8?=
 =?us-ascii?Q?buRNPf5+4l4gZrELlbXSLR6/yTudyevUedzYQszM98JcCa7cqVnzRW2ojGG1?=
 =?us-ascii?Q?mS1RHj/PSJE7LG982k9pWNvfVQHS+3Fi28t0TyBRobmNtsPA7y9q1lUUACTY?=
 =?us-ascii?Q?Qrn8pQwYnoy3GTOVnii3zH4IWo54chQeFtYGMOeWsqNUbzrfmoGN/9O7or1c?=
 =?us-ascii?Q?b9jBSE4nQ2a0hqi0Kme83RKnEAtnOADAakbiDzcZ0jLAYQIHct1Q45Q+d6GC?=
 =?us-ascii?Q?0WZhT3HdKWiIMM4/IZDvezRGwXDMKmM7VQmLmHp+9TImdXicMl7YsAwDuUt9?=
 =?us-ascii?Q?rpnD+r5rC8laSU30DGWx9+mN6vBb2jg6cenB8pJ5V2cd949xnpP28/NZpxBg?=
 =?us-ascii?Q?qcDjgITFrA3YgITBV6jFRcRolcolSNkUbwmfWPOWtjlV1lT7IWMYHifbFTwu?=
 =?us-ascii?Q?AbEqxJLKTx5JrVdRgZF8WOx6jq75UgSy5TefDNOtbL9iU6MORUUqEHynTJcM?=
 =?us-ascii?Q?Qhz9eROqf7G7eyBW4zHI1nwKzRo+7YgcGJyAJlQXuwwo1tb6Edtq9NcRsXcD?=
 =?us-ascii?Q?GdLKJvOT+R3XEIDTiTWI58POu2kjE0blN+BimRW8azIlpB1q8W/YQrmOwC58?=
 =?us-ascii?Q?V8pP+ddK3SVl80mk5RT119dO8r9wWPX0fshOwHYLyiyoxN2y70oNYToIkG3d?=
 =?us-ascii?Q?NM58CIle+IniTF9dF1ur9ogWX66y2yPx1ubd7Cn4rV45rRy5yHsvPuPnrKB1?=
 =?us-ascii?Q?xFEbIoOdS9CdimEVFP5jdrsW8/R2fdljZW1IOSth7V4C6dWRwXOdyZIGFiDA?=
 =?us-ascii?Q?C7hoFa+YI+AZ2vyYFx5dvEdmfgaWDIiEbfuVPX/9ITGguDnkHIgUBimfIrQf?=
 =?us-ascii?Q?8al9Ho9MZDJQlbjkDEnsnk6lyo7aqWi8OUNVkIk0j9mVdufJSawFznZ3rRW+?=
 =?us-ascii?Q?Q1pjx6tqA2NNDPw8k2x6wxWCCb89TmDwaU/7dUqg1nfuMWS6A/wyhRkJQa5c?=
 =?us-ascii?Q?VTUgO06Jty0TjaAyqwinWH1/chF1eXl6XZV3KyaIo1PqJhHDgx8/1RJWSF5t?=
 =?us-ascii?Q?UEoALdVZN8oBr8EKDjQAvLVYDUy54acJ/mu/gaG80JeH4Sr5c7XeFdVDpzNH?=
 =?us-ascii?Q?HrUhlZvj22+2Hf0woDHSyCkxNZNmO9WJGUdWnOZ6Hqr4tS1pOfC06Rz2tB+5?=
 =?us-ascii?Q?Hbbx/ot0qNw/kc1g4Q8HMMc3g2wqTFE3OHj3l5OZxG40JxA62v30Nqkv+Wyy?=
 =?us-ascii?Q?OSgjEEiH0IBZgwS6o8uttsUMMooh1svntei/rgaezqn6sz729Hx5JeifzHaA?=
 =?us-ascii?Q?vQUHmW0ReZvJtvTaFOuk/9aynuYX5UWQpxlZ2z2A9ahpF6kY1XBC5rksFFOT?=
 =?us-ascii?Q?m0Tgfg9rF4PkEUBGke9Aj7HB0EUKzjAevyM/PM0LglzjL0cLozKkfZQDGJC9?=
 =?us-ascii?Q?15NN154irNbAGAm/2p3R8XTIa1FVg9ItbO5d2THf7iud0EWQrTEorIh5QgbL?=
 =?us-ascii?Q?/UeW9kWG1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27b0d36-c428-42f7-a453-08da4981c151
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 19:04:47.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQkyFcUMtlXkGSLU6X/4L46wgoyp08DifiGHas399gUoFy0/H8tzzflkyxNTaEcRvqLYpS0GApcb32z+o3oq6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: KFENCE: use-after-free read in __list_del_entry_valid+0x10/0xac

cdns3_wa2_remove_old_request()
{
	...
	kfree(priv_req->request.buf);
	cdns3_gadget_ep_free_request(&priv_ep->endpoint, &priv_req->request);
	list_del_init(&priv_req->list);
	^^^ use after free
	...
}

cdns3_gadget_ep_free_request() free the space pointed by priv_req,
but priv_req is used in the following list_del_init().

This patch move list_del_init() before cdns3_gadget_ep_free_request().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Faqiang Zhu <faqiang.zhu@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 5c15c48952a61..29662c8ac0242 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -625,9 +625,9 @@ static void cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
 		trace_cdns3_wa2(priv_ep, "removes eldest request");
 
 		kfree(priv_req->request.buf);
+		list_del_init(&priv_req->list);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 
 		if (!chain)
-- 
2.35.1

