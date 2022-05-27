Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97025535ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348280AbiE0H4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348426AbiE0H4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:56:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1786D22BFD;
        Fri, 27 May 2022 00:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbnkyUjjRGp2LsAoJiEQjQZT8sp+Ndq/KUEh6qUl5500x1fzMhMyFTRKR/SZrkCQRknR2IBS3AA4JbrkkoBDcm2P1rguqtr11myAEmYSWiPQNpw+X0zEuldn+7ObPYxKrChQUPRnOBgjyP8EIoiOV7awoBTXw23vI6XCFQpX8TQY7EroBpBB8ZSkFvGjOoXqc9udLUjdH1LDdcldhHKu3vjxE6Eou7FJSmbxWMtFEVUnPaWakOLhr29z7BwNdAKvoDoCqhvOOjlFCYA9ErwwFhD3TvH9M8ZKajo4sr5XPtCdvnseMzZ9MdRJtboJsWtOf5/htMlbAq5fS5B/60QsKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn9KcAJpl7bMxZlfZUZj4TiNiAX2Q3bkG91s76yuZys=;
 b=NOepxDtGX9gIHeul6xSW7rB/psjsc08xAMsuPBdupCkzWzn+k4sYd3zsIPa9VRKobJlt6+xDTSik1XENVL269zwpUn7F75BeTmBiXLRlUEcIi/nMkW2RobjXcpg1zFTNoPzz3Gj20mE45WakAI9ahFlK7VxEVzspWLcXId3V0gDsj5Kum4B+O5AUtjaBAB0OM6q/ETcWsYLa94ZFze6ZGjLPrimbP6rnluHD4KqhNFfA9U+zp2QJ77XuNBFgwBSfJkkQRsglyO//AzfqzrjP1GvGolxbtgmJysuxG3k3nXKdGPev7CzEULeUGN4aI8J3tus5zmKVQS4VMYfcojCisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn9KcAJpl7bMxZlfZUZj4TiNiAX2Q3bkG91s76yuZys=;
 b=gYR2ttwNklIUH/p8Jeu3uIRAB0lxfmcnuaso85VIeyjFlCNgW6Y5Fjfih5aTA1+xbNWmUE35SNEZ91UCeCw+t/oB1ii3R8loyabjU1e84Gl3nGSFja3iFAfTLHILccXIDlgAwKd4DxZJ4unueo0Ls17XdoEI/ZcxMlc1kzdJBoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB4590.eurprd04.prod.outlook.com (2603:10a6:803:6d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 07:56:16 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5293.015; Fri, 27 May 2022
 07:56:16 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Leave a blank space before the configuration data
Date:   Fri, 27 May 2022 15:54:35 +0800
Message-Id: <20220527075437.16882-3-ming.qian@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77227141-8d07-435e-5032-08da3fb66068
X-MS-TrafficTypeDiagnostic: VI1PR04MB4590:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB4590BCAC1F29A30E88990DDFE7D89@VI1PR04MB4590.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFsQSmhaBOcFL8/YIVWri4mLN5Epz89V8Y7H42DjciIkOxcUyseeVbNFNy2JufT/YVgG1dRu2QalWaCe1cDZSsnBA9ARA76dqXP6vxJBREXlvJb425TroLxLNybl89xvkQsQu6YY1DOjMaNLy5qDMwSZb6pMIroOqI8jfiMcHLTU7UsSNVMCbb369WVasouonMtmEN6cwFn9xVykJ9x22FYWPsYcfkTAr9KP3W4Pmb0KNreON/slhjQ1kvy6nZzl2YQV3qEIzuKR/rByjT7U/x/QA0gfpu6Rg1bXzHoDHP1NJi6QHfuGrPMWmfH3zvCPQxG64QEaL0l57I5YPd/GRGj7Kd/C1oeal4uPzci+E8ZU7gIj8K0j5JmPoz8Wevjw0P+VK3SZOs3pxsQJttZ6FcgOQPMeVvD0HRB1o3hK7m9Uv8dsauefvAd50I8Rkpf6WdjzyONA6ZKeKJFD12RuPJkSDdi4Q6F13kZLK0otYcaZOQZpn5vwMDQXrLUEXARG5TuzUqE0Ugm3Gz6J5XOX0kDKquS9EK7TgxJrq4KMPK9aCUeDBWyS0j4Fq2nYgMat4RdPzVh66PRHJlArDthcHo4PHhT1wwpHoirPvsotwwcvYXw48h/zVi3dBz16JVWpt+9wyqVl700yZkJaprUOMdovTebyXwvTvoz88OdcZWyzZ/2EElH+SXROeSxA9AKLTdZI8W4Nc/v8s+qvDK5uww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(4326008)(8676002)(38350700002)(66476007)(66556008)(2906002)(38100700002)(316002)(36756003)(6666004)(52116002)(6506007)(83380400001)(44832011)(2616005)(6512007)(186003)(1076003)(26005)(508600001)(6486002)(8936002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZqRPY2hTTv0BY1lHETj2fcZ7sKjI5KarFlDOhlMlRVSjWc9AMTZvhbootk7t?=
 =?us-ascii?Q?664CwbONr0VquvUycZFFs9g6StOHjFQFg4LMe1DMeRqtRLbxyORVXI7Rq9yc?=
 =?us-ascii?Q?rjycQu21hQsijHwOB1avZf+uvY6PuZZ39icLGQm78Xjo8rYBlDXrx62gvN8N?=
 =?us-ascii?Q?KqGvJhvGGiLMXd5f6FVA4M8uCOGVQVaF3FEr64Xyh6g7dklLLYst2BxaHJIb?=
 =?us-ascii?Q?WF/kpkM6G45wok8vafb9JZ94EOQjJp8VFzqELBs0IwW3xOk5TM5ga/2ou8yQ?=
 =?us-ascii?Q?wecgaoxGrPBVTUEBd+w6tb8o82XwJ88CZmHezKyi/veNPcx/oOoKPqFzfX8f?=
 =?us-ascii?Q?DFs6vxqLVGKAsZrt6w2eJwMkeGiZhrATVXbfcMp7dz/QkuDJESvuGqfMw+mo?=
 =?us-ascii?Q?IO+4p/pibqjXm+VvnKBzXoulL3yfOmCJM3mEnzw+OX+tiBnt1wY+3NuGdp+B?=
 =?us-ascii?Q?mVeSpHCupBuSkMByPXHXnbPgorBw0r2nPemKOi/Ke/4+waVoQXpx8w/dYcpD?=
 =?us-ascii?Q?BcQkSNAmysykXaFHKYGVTcsMmttCxhJD4evssOFIt7cEHJul0sFOKqR5WHuM?=
 =?us-ascii?Q?RTFFs+G3wgJxwW0Zvbr17jATjIyBwHX4qsbmMEvWQohbyIWL2TMM9jkwONEm?=
 =?us-ascii?Q?OfgLP0sgARoPkfkXHasSqBIACiEcPsM8SaUSUy3wLgpKcE6Em58WfDumYAlL?=
 =?us-ascii?Q?e8dsM3OvNLIUETNUViYEDrUYKHCbW7qSwpLbqDpqHOwtsQLCQ9kxe/su41E5?=
 =?us-ascii?Q?Hn02TK8sv0aENd4yaiqhGlhUO4+YXw9XC+ni/+QJsqqvx1UOBpW89AuQiieB?=
 =?us-ascii?Q?RcytFesrspRELq3050Cg63aj8/epNuUtOCIXBjBORavZvqaOnGqxl+c9wllL?=
 =?us-ascii?Q?9QPwZ4Fu7DRw74kjrFEy69IBBNEEZF22T040bcs1nv7Omhz7btAEBkohLb0M?=
 =?us-ascii?Q?yebv+iuquSbNvUgEjZLxXKumyeJWSVmslGmPMLg4nDyhx39SSkBl7VLBOKcV?=
 =?us-ascii?Q?nI1wOQyWoSbtqsyh/3EjgHcRWsEs2YQJesLPkxUSZq3yk1Vl9qL4UStQajsm?=
 =?us-ascii?Q?t3ONbTSpBb1vXVKQP5ZfguQwJnATXcNKyGs4xI98U6Lwt6mIgLfqNKwmZHlJ?=
 =?us-ascii?Q?eXbq0uNE9FF5vbl5HlHYRg7mM/iTLP3rNwkNlbF9lhif/6jsG1du7Whk7LZO?=
 =?us-ascii?Q?nt+DvLN/OOGiFQdemm630y98uYzzB2212anm1YJ6EjlN30GOObSkHGFVarDg?=
 =?us-ascii?Q?Ohl1AZozw1+i0GMLHwC7hHSeNO1jtjdmD0PL9EIimW2CrIkAgKgSFyPgIMCu?=
 =?us-ascii?Q?pQumY++03FxXa9cgFkA/nb1MMz2eRlHlmGWAmO56Flt3Xo6Pbwq9WWMJvE4K?=
 =?us-ascii?Q?8sptzMMeXIeMmUViC2e2hFYlelm2lXwzTjA6TMAQyLsNv8dyHVt+2qLgcnZz?=
 =?us-ascii?Q?AM9SK5G+okt4N0rE7wwNCfTs8GIQLj9ZwKA8kCd5rXX9zT5K7Duz00I67D60?=
 =?us-ascii?Q?ObqBqZWVsSpGNkfSHld/uSJM48c+R7JHzjpYsUw8XT+ZUtXwyxtQN9T4X+5C?=
 =?us-ascii?Q?nIGvsD09mbD7mAXZAv5Btiteaj//Jv+jDAMJ8YGjRvGyGlQhsRBNzQlEtl5X?=
 =?us-ascii?Q?K9z6acvNsISdh1cvYhZCcOw+Oo3STTFHbOPIW2RxoHMbzFwl4DFAyOq0pI+F?=
 =?us-ascii?Q?lvQ+tWZ5rK6HJkDN3uUoShYC9wgIZ88WDAn4zIXtnJaNXmqSXOpub/V27l2s?=
 =?us-ascii?Q?O+P2JbjUOw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77227141-8d07-435e-5032-08da3fb66068
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 07:56:16.3830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtM1vrni8h1n4QTqeUM7+V+CA4JUE0G92rYj1UgjGCyFBcEZA0xF0kM3yU5wPHxe08R2vuwWT+fWiVyN7C728Q==
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

There is a hardware bug that it will load
the first 128 bytes of configuration data twice,
it will led to some configure error.
so shift the configuration data 128 bytes,
and make the first 128 bytes all zero,
then hardware will load the 128 zero twice,
and ignore them as garbage.
then the configuration data can be loaded correctly

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reviewed-by: Mirela Rabulea <mirela.rabulea@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 734e1b65fbc7..ad4213e020f3 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -519,6 +519,7 @@ static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
 				     GFP_ATOMIC);
 	if (!cfg_stm)
 		goto err;
+	memset(cfg_stm, 0, MXC_JPEG_MAX_CFG_STREAM);
 	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
 
 skip_alloc:
@@ -755,7 +756,7 @@ static unsigned int mxc_jpeg_setup_cfg_stream(void *cfg_stream_vaddr,
 					      u32 fourcc,
 					      u16 w, u16 h)
 {
-	unsigned int offset = 0;
+	unsigned int offset = 0x80;
 	u8 *cfg = (u8 *)cfg_stream_vaddr;
 	struct mxc_jpeg_sof *sof;
 	struct mxc_jpeg_sos *sos;
-- 
2.36.1

