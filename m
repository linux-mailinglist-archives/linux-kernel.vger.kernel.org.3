Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE784FED91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiDMDb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiDMDbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:31:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D3D2E9F3;
        Tue, 12 Apr 2022 20:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqEjVyJY0R1J+vOWQzsxbMNl0yL7r+xympe7ax3EhMy87XAdxthJ9fLLO8Mi/8CNdFaJEvXZ8FOgdfjhlIMGaH81YHreAgNgt0GLE79E+8mpAbEXbEYgXVe5HA0gQxd5F6yuXi9PMFEukpZhpzMPoP07rBTD459QBpaoT6QdFjwWIyrAjvMb20hPBfi+/U4AySuSlKetq9Hj5BB+6VKvd3ARDnPNAGc9KkbqFpqRvDo43tFpWRX95r4mh+vfNj8x0pwx5pVhhV/ZZFjdMyMDrNPYKsmcUbOMPk2z1f+VNRV/nt7FS369OcAKKlMMc0ubUjGUnxEWWEVeAdq9ng2g4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk2Y3XgJjXH0qImFYqzGFPVUxHM3qhiGJN959Tho9/o=;
 b=VQy9t1cf4ne4GOcrV7zPhZS77Ey4hQbvyhDeAXfvwLN2ctGAixVAX7dntysgphfA4DQAktog+t6h92WMYOwrdUQSFGm4ZSY+tLaVbPQ7CQbQH1MUVe6vV4dkQgTLPB6LaafXoeVsLSF/e4rcGIhPUvzs1WcKSbsIgcXJyHUbNRKj+fZeyNNn/7uvajkqucGeWgqEnnCZjyRNl2tIBJM8Wu2O5Y5NXa33U23r5b8IyoTJ+nMDJstsBGZ7WJYKf8YjhAsPdhORfd+4yNwhEJ2ebCNU71YoZRdMQR0zBJZLN8YwDCc9/q+ecBn6VfAoJVNIzkbPGjNMdijTWMLj18xcKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk2Y3XgJjXH0qImFYqzGFPVUxHM3qhiGJN959Tho9/o=;
 b=Bdu9yo5y0Z5VvcMKhc9t6WQDkOpqvlp+NLC348/hx527Bu5ibULPACC+/suap48hMy3jJ3Z4LTbM0SFdbZDbtjzXAjj2/v+/S9LPPTQBivhCS0KgfdG0VgVsBuridGZJYX/e9PhZXYV4rkP5F6G+dL6bZjzJ1sGzGmPogG/LsKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7483.eurprd04.prod.outlook.com (2603:10a6:102:86::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 03:28:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 03:28:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] remoteproc: elf_loader: skip segment with memsz as zero
Date:   Wed, 13 Apr 2022 11:30:37 +0800
Message-Id: <20220413033038.1715945-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413033038.1715945-1-peng.fan@oss.nxp.com>
References: <20220413033038.1715945-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a827282c-00ef-4a41-6790-08da1cfdbcd4
X-MS-TrafficTypeDiagnostic: PR3PR04MB7483:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB7483DE4D27FCF0FB13EE3874C9EC9@PR3PR04MB7483.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC3By8Ee4k1qkD67FKbeHesrOveVyvzYKwlznu8dG5bANeSbkbey4/5oWLX3jJEq0bpjniwiXTHZ68bsh0q/UJybh4v6pdaCSB74PB4GlwaygYOj8704Fz0MZPKwKo/P+dewJYGeRxnudbTsNVGtSuZnDJR13ZtDMHRFjng3/6rX/MgfOXdvN9c92vhMpIldIkgTYoHRX5Tsx0lDGOdcsE58YTXHAEy0zJj+ISGWgKMPcOZrNDKGRIj3G2hhTffCxbMLeAHmIgv0+iFIOuEqBZ6463v0r8nik2tH8kQGb/WKjHYUkjhsfWxolV52qcI1bB3X9K/6oIdKWHc65NYUh08DN6t+fJf+d00OLq4PjmPMqQg19VfgW6DbR+bXp2Tqm1tYxHbMNPtJ7yh4qCbb7z5sjrqGF2IjHVPlI74AUEl5MxfqXVqEuq6mFc1DTbn2364XejNlIT6f9uh92lmEEB5SyMfSHTjI4DUwagAs8gxrhoIt+EUhC6NH8kRr8+BUNjzW/idbDeCzpmlzmIDrFcPH50CsEkfc52Udp/FuJAGruBI3ztV63pmtAdqG7y30kScGFbhZlSorARRI0DX7qD2LAPaNBxTQZFCd9Sf3DeYn/qPnVw1bn/2lVrAwzOq0KzLG1dCcfrjbFxAGiTCQMZtPQbXAdlfyNgms1IHWAb/a7/TzJqlgVcdi/1Imin5F93PgBDnTO6msh9lQ2G6EPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(508600001)(52116002)(316002)(1076003)(186003)(2616005)(6506007)(83380400001)(38350700002)(86362001)(38100700002)(26005)(4326008)(66476007)(66556008)(6512007)(2906002)(6486002)(8676002)(5660300002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zx1m4pBDc7c4ZHkmqQM1z8krNMsqf+CSgGXyZVI00OF9mKGB9R/6TTKZvTnb?=
 =?us-ascii?Q?2e5Zl4/F8Lpngns2VfpSVTmfmL3aj+854pft3dorRxyDviYU2uNOA8lp8nUT?=
 =?us-ascii?Q?h1QH6J73sMn1jPm4uxPWa7s3mnRMLDmUtbmVfWhHfnLRrmZqS7y1Obfzs+kJ?=
 =?us-ascii?Q?jM2D1rJP8889pqwUcCpvRmwPagIG/vVXgQH5cgv3WC+Tg4HiwXRxULnQnghX?=
 =?us-ascii?Q?VAA2CQQjWcTAfkVAQyAsXK9vVY6AdgcUxGHqkymEysT4heA8KORDrD4swQBs?=
 =?us-ascii?Q?WVPwHs6VuuiTSASnCDHOhW7T0i8efi0ZNOtHRcv+NjaptUWGH3mpZ2yVVy1B?=
 =?us-ascii?Q?zPyMfVNqFnDBjbpe9Cili6fMTot1i4LdpPGs3SAo10mnHiZYo8O+8VfHLNLH?=
 =?us-ascii?Q?t8rKPD0f7wuOaW22zKxNN0mOQAYsqUsBVjppnI1o7SodM5VVrRJRUR7ECgFz?=
 =?us-ascii?Q?ieUkAtA2JJWWyrO9TZHaKDIi692HUEst3tJ23RDqRwjN86hQRmSkQwMDjQis?=
 =?us-ascii?Q?59Vlc1sD3exKu0gz3TyHnupbrZS2ljWDPNxd/0GW0IVy4u7MWytEVNJAoz8H?=
 =?us-ascii?Q?e41L2trbAqoLW193OVvwImUWWZecI/+jiieDyaDFSapPxqYrkVi8G9LWcIGG?=
 =?us-ascii?Q?Mdj3dpiYOauWpNkigs0ApbWmgAAAWUEOP8pixSA9CvB/FuMx+6RebEk0eayf?=
 =?us-ascii?Q?Hv5dh4+4nHZAN/FMWQ41tTk1roKIWnAC0rFuWjXDfCjvoz2av5WxQ9YKgBMv?=
 =?us-ascii?Q?9TOgU8gruOYUFhHVGDorfzgT1mc6fPI1GOBW38qalwLdBstSg9yoDvTIsuvb?=
 =?us-ascii?Q?QeSVWLJv4cHp+Qzwzzg6bVhoXdiTINs8APaFo/xzyh7M2i+ZhZQQcs2XftLa?=
 =?us-ascii?Q?wYYrXof80BY5pUGZ9VfPKJE/1guyTYhpID5EEEkdBChfxouv5mwf7FD/lZ99?=
 =?us-ascii?Q?KIaxXElBDrewJvqo0cbkpqnw0rq3HI/rPVCEW/mmdRfVdLNEe3R0N2GxQKuA?=
 =?us-ascii?Q?03OxXDa4Fyb4tpe2TX10RYIHWGzmcWnEC4tMnUQUl8s8cQUYtDD+ksVHMCXc?=
 =?us-ascii?Q?tuHYhfc781G0zjFKAX9ESs5rz+CRwiTELnbKgRruN2rzahWdeyLIySNIIh8O?=
 =?us-ascii?Q?s1Ltt6ta8jf4pT/m9EWXNiY9jeDLvHsPtKm9y5wUGmmOro3LkBtIn/UFoqiR?=
 =?us-ascii?Q?IF9eQbRLVpO1cwgnEdAS8f/g2AzvZZvtqYoosCEH0MoI+NrlXndNOdKw/8xA?=
 =?us-ascii?Q?joyKs3gv4QYJ0gEPqnisMbk32nunl6XnSLR1J2VaBEtF8judAd5WqIn0Iwij?=
 =?us-ascii?Q?Vd5qCja5Rnh748DWCUOtfz3TJeBndgXTo9MLvCfXp3ZDxZZ8i5tRCY1iT1OT?=
 =?us-ascii?Q?wRo70sjP80DPtTSDzadQyD8u276bT5IMdrTODWBef09bLTvFrCngOVFzpiUI?=
 =?us-ascii?Q?BbvzWzf1GzHjgcW5oM9V40UhGjjUNL9dmr/pbaia8CMHm3KfMQEU1ngU76uw?=
 =?us-ascii?Q?bPB7wR7auAAEM+X/F9bYoxx9mlH0KGXCGqn64ZEKK87Qbc1aJ1tnnx2lguJJ?=
 =?us-ascii?Q?X8QMRzctjaJIBgf2m22yIgtin0dBqJD07FlsMKI4uoHLKAtt1c+PY03zXXex?=
 =?us-ascii?Q?xDLAHHtJ83qH3TlWtv5/WrHnW8H/rJAMcf49sVzBjWJDySWSnvz1n6QUOfNx?=
 =?us-ascii?Q?/Sk0RyUKhviYCMX+UAKRPuUYM1XXlOT4FsUrnunoG6yBig2c/NfpRZ0ueWDd?=
 =?us-ascii?Q?C8CEooVL3Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a827282c-00ef-4a41-6790-08da1cfdbcd4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 03:28:54.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdkc68UEgzJwYQgzyfks5ZsfgVwntyjOsDMxJwBtynV9iNJUIxqUkSFyE/BXZk2qUrISbJFV8nCbLEpfP3w8lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7483
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per elf specification,
p_filesz: This member gives the number of bytes in the file image of
the segment; it may be zero.
p_memsz: This member gives the number of bytes in the memory image
of the segment; it may be zero.

There is a case that i.MX DSP firmware has segment with PT_LOAD and
p_memsz/p_filesz set to zero. Such segment needs to be ignored,
otherwize rproc_da_to_va would report error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index d635d19a5aa8..5a412d7b6e0b 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -181,7 +181,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		bool is_iomem = false;
 		void *ptr;
 
-		if (type != PT_LOAD)
+		if (type != PT_LOAD || !memsz)
 			continue;
 
 		dev_dbg(dev, "phdr: type %d da 0x%llx memsz 0x%llx filesz 0x%llx\n",
-- 
2.25.1

