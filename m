Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEAD4CCB77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbiCDB57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiCDB57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:57:59 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40056.outbound.protection.outlook.com [40.107.4.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92513D553
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKUC5K2HusXw5edbxpJIfV1I7WZhLf7h+09s6eaDXohKkO6HbSH2JOqr+bgP6LiOVE3aMTTSPEcZwc0BE4lAiCtKt+6d9ZNuVECxBtuz2wAdjaVKdoGWtFYwM2lO0pTJ+YweYLcVJJc43ObE3eT6z+k97p8OO1a9zgsDAb1R35tsh2RU0xc2aghQBeRRVrzu6N7Tgj2qx6iAlMaKkWNFBiSNlWDN76UHfJlzLqFPd+c1iI+Y9BvjEL75BSJ17zHBXsho9OBPXdh63hBgigI/8cqE6Ugt1sKyCtRNm8mvBOALFp8PX2MvwNjE7nw99cLaWeub4mFaj55YzemDs7tbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVaQNysEKGyldpDMAif2619U++i1t/ASblcqty/3j4k=;
 b=I9fsrRoMLzRv4oTrgeY99SD+ZZIA/e4R14epa1xpwt2iyBg8cy8u71kvyy7Em+vlK3q5ZyLPeLb5bYWGWz9yiMFeuChXIXZbyB6uNhwPdRdsTvNEkkND8iKZyX+iFalx33tVWuxRp8CnMLahsd7+7xkqpAvqmYu8nK6BEcg37HwNmX8KzuhKpiCU/vHiqBEdGYLhkBbQpvSrLH97qVHSX6/hCgyeD7JYMIW2GPD+hYAbtFTv9igEr2uLp7rItkLd8zejtnxgmLd4GX9fzBB8VrUvfulhS6uPdTX0hmecBvs3W3A1WOvpthXboJWNC10j4A1Ee07trEGhLB3lzSX1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVaQNysEKGyldpDMAif2619U++i1t/ASblcqty/3j4k=;
 b=IZE8qAzYNFivW+4SQ3NPdSKVFnAGn/PnE5D03MsgRSYxi3jsqdA02d6Im9sQH0oZy/olGzzxbJijbDGlN2ePg68K5nX2kSLb70QYycJLFl2106Hhg/dsLktIFKI3SZNqg9FkK+BfgLvSqlEqlHiEsnzEa6/SANVEhVhO9dq1L6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com (2603:10a6:10:af::27)
 by AM6PR04MB4920.eurprd04.prod.outlook.com (2603:10a6:20b:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 4 Mar
 2022 01:56:44 +0000
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::884:f2d3:1dfb:6669]) by DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::884:f2d3:1dfb:6669%7]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 01:56:44 +0000
From:   Kane Jiang <jian.jiang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Kane Jiang <jian.jiang@nxp.com>
Subject: [PATCH V2 0/2] About i.MX GPT input capture patches
Date:   Fri,  4 Mar 2022 09:56:21 +0800
Message-Id: <20220304015623.338645-1-jian.jiang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To DB8PR04MB5771.eurprd04.prod.outlook.com
 (2603:10a6:10:af::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3907c39b-29fd-44d5-9821-08d9fd823c09
X-MS-TrafficTypeDiagnostic: AM6PR04MB4920:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4920C97415AB0B59D9FCED349A059@AM6PR04MB4920.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NthvJpHMtTSdk75u+Aym05kk7qDcc3Gxey4tb7EvUg6Uns+35NTCw0juBITCXWlWIT4ZWqnmCcQnhCQpkL/XQr+mrsqJeLUQfu3watFfGwznExbSOuk3N8o1FSbJcrAkqTscR7u9xlT8Ign+aulB/6m/yVp/O4RREwthFh4dhwbcKr2VPaYvMt/QPklPCilb5TEi53dffblGy5H6t6PznAZ/kZi36QIbQGDdBKt2fb0EeYT08E0PAFCIhCqN0CJVr4mqLlKCikq2zXg7dPaq54YuspsMtSPvv7PuZH9UKZF3ekranLYOXmOzEBdMz6iUQScqHlx7o1x9+sQ2sq7XDSCVLe0OAhcXggjjS+Iw5AqGBema7j0+DED2waTkQ+awRay/JMx4cex+4m+PcTSrLnu/RUI9+SDGvZd7Zs0hfkpsEymQO6UXi96IMBIp+FqF1kwZHdzFw8GxbWoBo46aBU+mVxnA42t2Ls8RgcOinmM1vmcV7Gx6hg8l5lvlTZv3KeZ1TG7BVdGXpMtoyLS0qF0tSYOIPXsCwqMvpMKUZwiyQh6/MpUGKOwrLsz+jTv7bmQEw94wmEAPOo7jF2AMbo2jPI542eRqYSX0Ie2rpcRldIK39HNgMlxUhy37Br9xnXiR4/gkNdGrdj24PhH9/H8xDemWVCu1yLGNYlNRC8Tp6ARtJdg3SKJzIQN7APvG3ZtlQKq8DMDAbCuhwmTGmdCGaV8CNXBWikaL1XrFPMkueF02htlGgOkSg3GakYoUMDXri5ehGzg4QuIm1DR6VII6QE8Qb8kYNT1PQx+VFeSZxaFKPwjtMGmJ9VHWbDsnmY2haE/EwYz5aBlS0wMzBR2w/nmN9vKXyDyUNXSQLVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB5771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(921005)(966005)(6486002)(2906002)(6506007)(52116002)(2616005)(36756003)(6666004)(6512007)(5660300002)(498600001)(1076003)(110136005)(83380400001)(186003)(26005)(8936002)(8676002)(4326008)(38100700002)(86362001)(66946007)(38350700002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//Up0OMOVw8v38eYQgC+muVvL8bgZQ0ZeHmM9EaxX+6gBJhExt3gdu1CYkRl?=
 =?us-ascii?Q?5rsEMST0zEQ4rwMryi7PMW3KuK6nM8Xl3vy74y3Cj4wil2ZaafjROX1TbVtu?=
 =?us-ascii?Q?Jo1r/1QC6eoWMIQuzZMJywMq3KBKwzt3zSC1d7o2IvmtcYvJqfqWs4KvXt0P?=
 =?us-ascii?Q?aBsAKeJkkuAxQkfhijKWHMzdvX3b5fmtCNeOyMZliXbC4HawnTNL8buRREnf?=
 =?us-ascii?Q?mv/kYB/pStjuu0d822KL59edyzUlxnObugu5zlhB9sDh04lphYWeYyxf8bqG?=
 =?us-ascii?Q?MAQi2YGJUgggLm+xPAv5G8/bGaaiJ+XuQGqx+823WTv6HmTJe+Azm111tX/X?=
 =?us-ascii?Q?kKWvn54R2Rh8e8aGnMF4jYLbWNSSddtbeg/TroaygfGdc1aqH2yWEDcjSwPX?=
 =?us-ascii?Q?wRFP757qSAdUv8viNXk+YH152IpipNh2A4GdZyM64NGPYn9BOiWk8h3cjYxi?=
 =?us-ascii?Q?jawkoasPSifzhaeTGhGQnf55Wku1QuHcMu5FDBEp2YDJNyAljN5IOiqJP60s?=
 =?us-ascii?Q?DHgNsRwO4OlLQf0TG56NmTBIYwnuUWo7q5ab3ojEtz4dYiaRMXKhusQcimuP?=
 =?us-ascii?Q?k8TzkTlFFPnDllbu2X301cNZ2i2z9YnVNK6iWv50NY1mIBuQDNUJ2Cwv+IZe?=
 =?us-ascii?Q?eZ0D+6PB/HLX0quHggftMYqcm3gtPbfEejWJH4WZSFKqgGXkAs0x9tuEcfSB?=
 =?us-ascii?Q?FILcP9Y+5/3mJqFPMWcMLdd1tcJJgr3bvfansoylYzVw6ZpdyxxKdIF7p7cq?=
 =?us-ascii?Q?6CuRfHescl0jTAmZ61KRl6tRPuFaW3d3kZbij03LL/O7FgVfB15BoGFick0S?=
 =?us-ascii?Q?OLXjZnqssCRdAL5iD1LCcwb9wnDFEv1Ggjb4TfqWU/iFBaMIkllCWbgY6Ujf?=
 =?us-ascii?Q?g1eoQ6f+AAyv7/+PZKOTa8uYnOvr/ZPhLmB3sshXhisoNITa3QAaf0Q/3ndA?=
 =?us-ascii?Q?HBN07EGhQB8F5H1rgKVPt7foQ9QhhuFyyttrrzDFul5YzfH7vcqn3hIJ2hrC?=
 =?us-ascii?Q?50mK6tRq6W3Lt0Xh/5BEG7mS6G4MPSutzqx6I8PXkffYry0QexFlGXGLvpjc?=
 =?us-ascii?Q?AzAEnSwSrlMfCZjVKRmEnot1o0AosDUwW4g125oA2y07Rq2FxFdoaNhRWq/Q?=
 =?us-ascii?Q?cvUsCUYU+Aco28jixUcdhNpFcgWHoQf9WuAn4klYFW6T84L9BomOTUxSPb0N?=
 =?us-ascii?Q?m/gLKsECB8el42UldMqCPTqZZlG4Rp9bgdp9frEpvUtD1wU9fPFcn6V3n4fZ?=
 =?us-ascii?Q?MBTDrFttBd/zXmVTna7v2ueyups5qWuO/3WJxasEGvWN7eKnzlsh+owoQZ5y?=
 =?us-ascii?Q?HZjIT1uHaVdU7u2HqBHSQNO4EvZM7LblK5dXGDKSdIIhtGAu6ktKSN/u1tAo?=
 =?us-ascii?Q?IMA2ZAq2Zdh0lxdtsRVbMfq3HI7RiJslbe6zT/+i448uBYplhQaAUvTX6+ox?=
 =?us-ascii?Q?/aetbycrTfV455vWfUJLV7j9Rg229yv214iNUV05Kn5VkZw6x5nlFmW3iRq/?=
 =?us-ascii?Q?xUqsokmyYEaa7PPlurow8y+ImFNK1zOTklKLJ9/sdxk4acgNd9os2t8DMw+i?=
 =?us-ascii?Q?Y2sj2KUNhdzVLhi7gZWRhq5nUB9xbQDTCQJki1TJPcLSu85haNtA5BijY9TC?=
 =?us-ascii?Q?nTeotfc72arMWp9F/x80Ncc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3907c39b-29fd-44d5-9821-08d9fd823c09
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5771.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 01:56:44.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLkkGgwhoArJ55YWgNaWyiyvFz2ByVupbnLF4b0fF5O40OsBmGJcgRsUkEuxBvQPdzc49ETPlWorMnDCN01Ktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4920
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The backgroud of this upstream is: I used to enable i.MX GPT input
capture function for i.MX8MM. And I found patches following from Steve:
https://lore.kernel.org/linux-arm-kernel/20191016010544.14561-2-slongerbeam@gmail.com/
https://lore.kernel.org/linux-arm-kernel/20191016010544.14561-3-slongerbeam@gmail.com/
After applied the patches and do some modification, GPT input capture
function was enabled in i.MX8MM. When checked in latest BSP, seems the
two patches are not included. I am not sure about the upstream status
initiated by Steve. So as a latercomer, I am doing this upsteam again.

---
V2:
 - delete the patch for i.MX8MM example in yaml file because of lots of
   warnings due to chips missing, will add to it later

Kane Jiang (1):
  clocksource/drivers/timer-imx-gpt: Change to cyclecounter for GPT
    input capture.

Steve Longerbeam (1):
  clocksource/drivers/timer-imx-gpt: Support i.MX GPT input capture
    function

 drivers/clocksource/timer-imx-gpt.c | 480 +++++++++++++++++++++++++---
 include/linux/mxc_icap.h            |  16 +
 2 files changed, 446 insertions(+), 50 deletions(-)
 create mode 100644 include/linux/mxc_icap.h

-- 
2.25.1

