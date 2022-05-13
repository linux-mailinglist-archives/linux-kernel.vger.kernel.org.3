Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18173525CC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378010AbiEMIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239375AbiEMIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:03:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC23DDC5;
        Fri, 13 May 2022 01:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtBi8XOKOALn7oLnqKtttlVVFQUUiJUs74CmtOP2VzdyV9lEY13hvzGbp9mskIZ8tP5irdokXjl2aKlL9F95KqiOdTOwwk0ZmrKhRpNusTLX9rFLDNpPms31rfpwI5wIBTBnqLo/X/x03Fsjrs6dmYJHFbNnefy4IowYwiW3rfPkvMVEdKjw6JUYDXek5UhDIzQnT85/A09sNHOCp1xdB9yViC/9KBOCmYUO8K5hOTlGT+OQlxkqrApfGrXodZ3Dy3sCgkRm4fj8i1CPaoUfrNItdiw+aesDQqYJkZgmAB61AkdRB3XfdeBl1Cl9jf/+UGs+f0vmb2+pVbjRcmc1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftuoKR8cFbjd9A3d19hoFCCkwTdPeGOIEhXGq0fmT4s=;
 b=FNRTk2zo2Kmo7DkdD6LY9srWjRakS+cKzPxCop0BSxtkBPxM6utuJ57Ex3sB6PEwMRi/XeuYhvzQl1xwHS7hGz+vbQskxZE1+na5v3kDmhI8n43+kJxta1Ui+AzkAh76HBH5B1571EsXddJg9ftvHFI2EdH459zk8FNxqoITKf1EDehWQthcoCSPul33eHBMd8OxxwrCMhlpfFXIgg4EpGzEj4C+9f1mPecHnD0yqL/VGmjMIlu2dbwiotl+IDD+MNsL8OQFILDRcPzG/MVrY46RKNendqBqvVANbDP/MpWlSG4XohnABcPWByyijaxkuzQEyxWTpVk3cKArWQhEUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftuoKR8cFbjd9A3d19hoFCCkwTdPeGOIEhXGq0fmT4s=;
 b=bZ5xrHy/V3aGtEf4X7uuhTlr2DqEzUYFNRm1oa5dKpEibEhjGHw+4RviGrA46x/KyYRzRkcxZzBO+nMnVH0mUtFpwlfwwXP7Q8zyg0izybdXZ0ZnLO8hYaUifv3hJ+f2o75KG2qqKAbCy6AXcj4gf6jVqgl81j1nKnZ2SyLe6fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SEYPR06MB5159.apcprd06.prod.outlook.com (2603:1096:101:5b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:02:58 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.027; Fri, 13 May 2022
 08:02:58 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QLA2XXX
        FC-SCSI DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QLA2XXX FC-SCSI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] scsi: qla2xxx: fix minmax.cocci warnings
Date:   Fri, 13 May 2022 16:02:10 +0800
Message-Id: <20220513080210.53143-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2406fa-5f9c-49a2-1996-08da34b6fe0c
X-MS-TrafficTypeDiagnostic: SEYPR06MB5159:EE_
X-Microsoft-Antispam-PRVS: <SEYPR06MB51599BE4C81CD51005DA2C45C7CA9@SEYPR06MB5159.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myoS/tqp+AyI/bhyJBP9OKBmrR6niwH3m/UgKkm7DV5q1+bINu7b0jHEilJNWRyX169oTU3FOs5cEAb0cAHRoIs3z8y9hKyDnWBAeRNLZxghPN+tc7Bex+GoqfNMHp1Vxhe7H9OiSwUNdP7Fopj6W3VpeJUZ0Cs/saA5O7OxJDySp6DTYXzvZ6my/6lphuilknf0788/XOFf4pnEx5etLyRskenwDo24gisPisgANM9/T8LZ2ZIq1O/VliDVv7wJh+FiRzUCUuol+GKnIIJD9hq6NkvIwl0itFA+MArnRhtA8D7hVFNALMct2V2IZk/pJgaxKGsZDKB5QkJKGul5nddvbcKtRQbWY8VAqxYSV5jPy76MJjMa4Qd/bKIBtdOicuy23x39qr/8jmWWwzM9Yxn4Vf3JeH0xtfffmD/Y9ltdDhyNn+EZLCoaX80sD+qrVS5nejcoSULyCnrgi/r7uu8M10T+qWishThkkxaNrjfNBje8IGLv2k0T2KTFXuiPxy7nbreDs5eIQptk/6Anm5FZDsYvaROGU+RaQhoao1auWP2//cL6cD0JOy4fqOoheZg4NAdnuh61tg922U9QyH1FaDbeELAyaiaa4+MXX6ek16MtYOEqPtE5wXvYizuHSyrJ7UsDWPPmHS8ggcK8r1oXchyQNzBRckMJtbLEcp46kcdoIMs/im1Qx5mtk79gkLAubXgoB5o5yocDZ/B7cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(186003)(316002)(38350700002)(38100700002)(6506007)(6666004)(86362001)(52116002)(2616005)(107886003)(110136005)(1076003)(8936002)(5660300002)(66946007)(66556008)(2906002)(66476007)(26005)(6512007)(4326008)(8676002)(6486002)(508600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bEsKHtY4cFtMVrif0x/f4hdtyJwlSExM+cRan81bBVOru5KDGOS+m8qQWbtz?=
 =?us-ascii?Q?1v1HnJjgFONe2mk/CoEuHENmN/cm7jJa7K0Of9upuUynefksOheVWmHzLJqH?=
 =?us-ascii?Q?V9BmKrQCAR4K6UisYfu8mciFwhcv13jDi5qD0xX1T5RxUY8UQ4i/qfgNmViQ?=
 =?us-ascii?Q?rNaNFuMgJLIzgTtEuNZCoX5GpCZfiC6IHwhoq3XRoF7Gsnc5WpTCVbAZdjfr?=
 =?us-ascii?Q?OZYJ1qed6innpMLs2v7gzKxHwBiUO88t3ea5CfAytsaygY+bOyDXO7Dh3pLA?=
 =?us-ascii?Q?q7SToX2/NcTm7GrKIB1KAidjfOgUjuN/hNLA57o7CpwQHHXrw5O+z7dq+5UK?=
 =?us-ascii?Q?iMHYTg/S79Og+txfmOtOBGFHD1T2FaIwiYIhnwD4i7qUwGniLOl+yXcHEgFR?=
 =?us-ascii?Q?nx6FMejRq5Rn3eD1fQUKcWHpoDNiBHnznkMMwCvGF1+r9ncl7DyNh71bo5fp?=
 =?us-ascii?Q?oMhGF20RCaf5jOMN4LyGZ+VVow+gNvISBPrr4jXEE1eRC97c6tOagwLvFhCr?=
 =?us-ascii?Q?NmUyc18JatDsJ7x+LFhBuXzQtFNKcs5N9fHSATiV8WsGUuMLM6f6GmD6qSYi?=
 =?us-ascii?Q?TnyFwIoWuROwAMPBQWzmwLCJPfoLVbDf9m6IoBlbWiHlPnh7HVoWCBXgrs7O?=
 =?us-ascii?Q?sBXGkR6POOpWiBTb5dRZik8EJODSXlUCH5ktB9gQNm+vxFy5vY2fYqcDFGz6?=
 =?us-ascii?Q?LkD9yVd4uO+02zMhLAwZ7ngf8dZ7LSOccaWXR7G3aqPkGXpycpIydXlimgOM?=
 =?us-ascii?Q?3oMfiRFWdDsDcuseQUvRRLYh+7+f8GqsE0h6SHk9T0pk5zQFPlLAYfIzeegP?=
 =?us-ascii?Q?LPSpTlkaZh7sdyIwmG/axLZHDCxCLPIGSRCUQdo+fqkr0HBUkkagITqIUM/Z?=
 =?us-ascii?Q?zgF+tgIVHk90OYApWMBCJmv+1zXBz5x6VgO06yyMPvaGbOPpbos/Z+hTFrGp?=
 =?us-ascii?Q?InNGOZWL9kXtrsI0wDGqCjG+GJYshEhnKGQEvynzs8tRX0+JZjZ51gs3Oy4K?=
 =?us-ascii?Q?eWV4OJYh8n/lS635PUC3uQRpN0PI8oxZ63GBdc9r91cIeq0xAn67QQuyzCXK?=
 =?us-ascii?Q?MtI2qHacOD+K4jAMiyTUCQSJawu2MJOCNM5c+g64H0AdElAjhtFDl5MY5Wux?=
 =?us-ascii?Q?ujMQLoKKgONy2z2dzOfCrrVpcLGM8Q1TR2EXUjIalECieVYToFdUIMDvKSQW?=
 =?us-ascii?Q?4/aOpK9btDIdsfwDszcZoKq3X9rGjJAiWyN4oN4jI2gj2Qbqo2WmY5KoJPEn?=
 =?us-ascii?Q?/vrwi4KscZeUM0tIlUQS5A6qJHArQTrHQxpd7F5xTfY6BnfsVPjLJCaKz+u6?=
 =?us-ascii?Q?XpJTGvJolhMimMHzk+Q0EOoiQ9k8AlFfblqe4+68Lf22aRZ17nki9ijWeemJ?=
 =?us-ascii?Q?9uuVjsTqpxk5f0RzvLPFOaThRqAJMNIYMQDoNTobWgOjlOUPu/6Df5NVEdx4?=
 =?us-ascii?Q?2LMSV/h9NEkwmQ3z+hljZ/q0ZZVqTaEHJTQ+K6zsacsE2ARUaac75wAclxif?=
 =?us-ascii?Q?waNIydGsHXPh4T6TAJ6im5UARFkubhcLJozQt4VMnCIvZqExIraGr+TFlmf6?=
 =?us-ascii?Q?bDiTFdDWw1qABcLHdsj394oo0WzfGE4Fu4qR7nlAko12+11tGrNi9ehNAjC/?=
 =?us-ascii?Q?jmpuG6jJUTAbdQsGhvzC/Fzukp9aIgX8tFxBOe3OCZkM8iN7uLJUys5TI5aQ?=
 =?us-ascii?Q?810XHjAenSnUOBdoL9e7TlRu28CinrYs74zT7EeZZ5zl9CaXr5S+T1MxlLCG?=
 =?us-ascii?Q?cfBLP7skFQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2406fa-5f9c-49a2-1996-08da34b6fe0c
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:02:57.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4XNDYQZhKZS2FiT4hjlNF3kjVUBniglZAnPBe7BcPofoQgYowXaQJkYNdANMzF/dvQDC5O74LwR8uJpSyJSGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5159
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

drivers/scsi/qla2xxx/qla_dbg.c:689:30-31: WARNING opportunity for max()
drivers/scsi/qla2xxx/qla_sup.c:3628:28-29: WARNING opportunity for min()

min() and max() macros are defined in include/linux/minmax.h.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c | 3 +--
 drivers/scsi/qla2xxx/qla_sup.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 7cf1f78cbaee..9dfe1782634b 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -686,8 +686,7 @@ qla25xx_copy_mq(struct qla_hw_data *ha, void *ptr, __be32 **last_chain)
 	mq->type = htonl(DUMP_CHAIN_MQ);
 	mq->chain_size = htonl(sizeof(struct qla2xxx_mq_chain));
 
-	que_cnt = ha->max_req_queues > ha->max_rsp_queues ?
-		ha->max_req_queues : ha->max_rsp_queues;
+	que_cnt = max(ha->max_req_queues, ha->max_rsp_queues);
 	mq->count = htonl(que_cnt);
 	for (cnt = 0; cnt < que_cnt; cnt++) {
 		reg = ISP_QUE_REG(ha, cnt);
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index c092a6b1ced4..2703408c60e7 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -3625,7 +3625,7 @@ qla24xx_read_fcp_prio_cfg(scsi_qla_host_t *vha)
 	max_len = FCP_PRIO_CFG_SIZE - FCP_PRIO_CFG_HDR_SIZE;
 
 	ha->isp_ops->read_optrom(vha, &ha->fcp_prio_cfg->entry[0],
-			fcp_prio_addr << 2, (len < max_len ? len : max_len));
+			fcp_prio_addr << 2, min(len, max_len));
 
 	/* revalidate the entire FCP priority config data, including entries */
 	if (!qla24xx_fcp_prio_cfg_valid(vha, ha->fcp_prio_cfg, 1))
-- 
2.20.1

