Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B804D0FC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbiCHGJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiCHGJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:09:07 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50056.outbound.protection.outlook.com [40.107.5.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5411933A1A;
        Mon,  7 Mar 2022 22:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJmUq1hSK5sdwDEw3jlBzhcH6gb0XZlgR0nCL/aIw1K2JKsnPt/tptkFRSIBZ+eSroLn6+ZlkpHGNWmbfKsOQwNyQro01iDzR4cHXhhcdLhe7P+7K5KII4rdXJhPrIUdD7StL4I7CdYDjp3vEZyk256fRuLe3U7ksTbYj8LkFnaz28kPrV1SzKJ1bsgdrAQpSrdjBO3MRh+KOkeDcFj6V7oqyQsRgmO702HSkhn54lWSyjPUgU54kNOL7YZSKhWWqMjukzPJF+S+GrZKyYrhofNSlDhFfv5oDRcoMyXTCSBC8YAHV1RGneasQi5YpaO/sBld4qZNIhg84t6clte+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AitnvJcbD8JKrCHHw/dNfu2AezJnfznY2LREixRoSd4=;
 b=H2s+SLuxvM1eY43SaVB468I8jBd2Y1+87JBAb/3064YSSfc9OJKzv3EPdSXH2wutawV3BclhiHdZ0QKcBOaNk3Ef12NhIbb9XM2DJ3xmLdUOywUSI3jkoHs5z82S9oo01+qfn98qmy6kDagv1jV9aKD4MPhP5Aa6jt/oSJf35KXZZPcr6ytbTSLZ0mt/TrsnQFzQMFVqLiuHsssUVUgPqTABaZ3YIf9b6yBa71rCQ/W4zkY2md0h6b5YW9IslaknVEeOiBk34j7IdKj2p45ZlvkHxKXYE41/prN5jFB2Q6AGByqJaLVHAFmOg5362U34Vh30qV/N+9yR+TU5nEHA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AitnvJcbD8JKrCHHw/dNfu2AezJnfznY2LREixRoSd4=;
 b=TDpF0xxlGD2d7GfWDgDmKLlQEOSx92Nxld+eMi8yEFcK27J3w211bOIBr6VNcQ6jf51C8aVrULPEsl0NqIJvskpsMSNSvPt49c//lJRfeGdRTI8GfLVbesS5/Uo7sGPRhEmScDvsKyyje7j2f0RzySSHYMcKe5A2oKNMmKNKNYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB5471.eurprd04.prod.outlook.com (2603:10a6:803:d0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 06:08:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 06:08:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
Subject: [PATCH V2 1/2] remoteproc: introduce rproc features
Date:   Tue,  8 Mar 2022 14:48:20 +0800
Message-Id: <20220308064821.2154-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9324d7-1ea4-4635-92f9-08da00ca0392
X-MS-TrafficTypeDiagnostic: VI1PR04MB5471:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB54717E294A1FD2A5AB29A81CC9099@VI1PR04MB5471.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8y9lDB/4tTe7od+wnrQYxd9E8DuMd4ydT+7b1lD0z5u05dMWgyOVypqU5E2WFve9q4YhVFeuZ2q2AUkwemwwfCFWVpeYpMgKmsP9yP9tcl2WWiELJxK55sMBNJg18jg6f3hH06w7j9T3Ey6SRx6gmnSP1HmerN0P0hZiF/NWgnEjVQlwO2C1mTXqLwAUkAY2zYMQnLes005kpZ8jNeVGAJMn/kSwtlo4jaTbXlJF88L5HTevUNiL7uVuI1PjHzl7BloElZQVwQ1/Mjw5WzocfsMojAjMjlRCt47forZ+AWVdR3qGVRV6hcgrJL774/qRt05eWo/FyFTAY3+oXLHDTw/C9KVZVVFFNjYN2LqpyHIRxmSMb880wC1MYPzqjdR2yAWVfuACvJL438QhmFBvXwEOjCFeG9k9sW/ElBmg/DQun8hb+NAH/BhpYQ5NhwEz4VEOU/PtnymgnCmqs8O/9m6SkxOxHNHTc5b/ohh23iG99RUCLBKDuMDhPXR/Hh9Y5vl20pSt4R04xXmjJXCb+SeeEEtrl5N8XunCaqfk0Ndt2wjDdxg69Nw/RBq5N64YivGWb8b47DlW4RoqyFpFN9zzFtUyYfOxCGnM3miSBK8KsKZa0eOAVTefedJ89qbE43TLtyvk2lsYWO4i37b1yT8wL9fOerVMXhiEu9s95n1AzfBRCP3DMfWXi838j8XbjuPLbS4cQ5hNYraZt4UrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66556008)(52116002)(1076003)(66946007)(66476007)(6512007)(6666004)(5660300002)(316002)(8936002)(4326008)(8676002)(86362001)(2616005)(38350700002)(38100700002)(6486002)(2906002)(186003)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsmqLPRIt8ye6jj+mRj8L1F1hvm9v18PaoLd/CtR4XBkNh5b2T1DgJ2SUBog?=
 =?us-ascii?Q?TlLRMVzmHwyaFVkopSs8nf30eTDWgDacBmc2sIFtXDqhMbHlKGhwYtIz1j7L?=
 =?us-ascii?Q?clnmN9tL3Z3Zr+O98x2Md7hmcdDstVF5eSbb1AuKRsDHbE12W1MopBslPAXG?=
 =?us-ascii?Q?ILZchHwSwxrpzuSRtUneGHpPLbt+DIEzPdpSaTtJ6Qe1p9Mjcpv4yhR2JUOZ?=
 =?us-ascii?Q?ZWik5j3usHjM5yNTEE4I95wFS3ywT+0EIEqjMNqViGlN8CjI69vmDArKDTlf?=
 =?us-ascii?Q?2xGj8L2yxnRypuTt77twfnm7Du4qGj213kcQjpDfxtanrvJoZsUvdMNSZ3mU?=
 =?us-ascii?Q?JbeKWnvjFYrK8eU8Lslazxh+7I7W2TpQgOpU6aW0cN7MQ5+5qV32LBcc82H0?=
 =?us-ascii?Q?b4cFcXYAf2h7J7i7U7wEXqv34BwXzObUnXbiAr6DQzeJ1Z/4KHFZBCl6wjoP?=
 =?us-ascii?Q?29ajMvmmqU/LldQI47vW7J368fMxXz6EaIknz23tXm4N8YU1Is3vknokoyfm?=
 =?us-ascii?Q?O813pumtON41CuTNci4qn1NXuDeXh8qGCVI0cQgiZ4Fa4HM4q4N86pq5yHHz?=
 =?us-ascii?Q?BhJMOq8Q/DNDswj9b1c3d1cijnzDiM/1w3xJzmInh3wJR8m+n5RDNTE+aEk7?=
 =?us-ascii?Q?Cf0mRXtqeZE1imQsaVtDCGIjdoJQzlIrZvZFi+mIIAVTUzOgc14pvkpviafA?=
 =?us-ascii?Q?VnljdJzPlPf7XPWqAQO4QWuqxR7SGl6gHVmHYCIP8An8ftsp11EehogT+xsF?=
 =?us-ascii?Q?JC/c3yZAaSMuOCz6l9RGDZHShRgXJvWgdMOLHmMWG+LR3M5g2Q3WfcTPujUi?=
 =?us-ascii?Q?fswaHEDy9uSJGLOCPzlYA7XBzD1mudOjO85v/M+VNNPkQwO45UBBcdABAnRQ?=
 =?us-ascii?Q?UCs6w2hC0kknnVI12KtxT11qaAq6w+Go7j1Mw85UzpAXtbiFoZXeuJHwfJHr?=
 =?us-ascii?Q?ybpG/zdkdi2KIqnHG2Uqt/35oZPERv7lCSdWaRofkkJvzV+7k5+xucU/IBsq?=
 =?us-ascii?Q?Kr1+bkO25qOFJ1BUwcsx5dDnK8/M5+4Q9k4dAcZvrlJTud9w6GEQlGB9is3J?=
 =?us-ascii?Q?glpCA7IvYWF2C6RPPkPP4K6QtA3669mowSvBn/GJsg4YvZund+170uy4XTQq?=
 =?us-ascii?Q?r26vfsQjf6sRaYkOyr502dg6E4wjeaDX3UlMpgriXbhkUzvqqzMJY4PgAtTJ?=
 =?us-ascii?Q?NCS2f6xORyu2BsicCoPEHv4b24bpdFT53eltJfXTOvS9206UD9YMHaBgHFYw?=
 =?us-ascii?Q?Z+imiijO+jnIjyzjuPFUoXjp8DEaZFPB7Zpo/QtGuKDU3GIz1B6Ka8dt4P8b?=
 =?us-ascii?Q?tTORw5G6lMmk7dgqYaG5V2koJPee0llGa8pwdM5mIneQNQQYbJuJ8amCOMh7?=
 =?us-ascii?Q?jlaxIsajlD3/+gqD8oSUSNo7liGcCIDwcDcjyHCR6cigNqgU2G9aVmbWrh+C?=
 =?us-ascii?Q?7u5EH9p3CA6CXxuYCK6d2Lx/lkPh5ryO7HuWm49GmYIp7C+JQHatpY9hGtKm?=
 =?us-ascii?Q?ogcU2zIBnldj1rP6pde3zdtAtUTeS+J04GanxCeh476TAZmLpbBQg4Ds507r?=
 =?us-ascii?Q?ZsTUs3UnUOjzApP3xrTdnj14jIfLu+/LKmeCvyCU/wD2EjQMMQXtfeCrKTD/?=
 =?us-ascii?Q?di2nbDMXca3Oeuld1N8ixRg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9324d7-1ea4-4635-92f9-08da00ca0392
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:08:07.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLsJemREMKpB7/0CkS1kxsFddJolmsKNjlLkJknLC96ncHSSfCC54/IEH3sMTAcBPD8A9SMSzUJIBJUdZszjFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5471
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

remote processor may support:
 - firmware recovery with help from main processor
 - self recovery without help from main processor
 - iommu
 - etc

Introduce rproc features could simplify code to avoid adding more bool
flags and let us optimize current code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 New

 include/linux/remoteproc.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 93a1d0050fbc..51edaf80692c 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -417,6 +417,7 @@ struct rproc_ops {
  *			has attached to it
  * @RPROC_DETACHED:	device has been booted by another entity and waiting
  *			for the core to attach to it
+ * @RPROC_CRASHED_ATTACH_RECOVERY: device has crashed and self recovery
  * @RPROC_LAST:		just keep this one at the end
  *
  * Please note that the values of these states are used as indices
@@ -489,6 +490,11 @@ struct rproc_dump_segment {
 	loff_t offset;
 };
 
+enum rproc_features {
+	RPROC_FEAT_ATTACH_RECOVERY = 0,
+	RPROC_MAX_FEATURES = 32,
+};
+
 /**
  * struct rproc - represents a physical remote processor device
  * @node: list node of this rproc object
@@ -530,6 +536,7 @@ struct rproc_dump_segment {
  * @elf_machine: firmware ELF machine
  * @cdev: character device of the rproc
  * @cdev_put_on_release: flag to indicate if remoteproc should be shutdown on @char_dev release
+ * @features: indicate remoteproc features
  */
 struct rproc {
 	struct list_head node;
@@ -570,8 +577,19 @@ struct rproc {
 	u16 elf_machine;
 	struct cdev cdev;
 	bool cdev_put_on_release;
+	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
 };
 
+static inline bool rproc_has_feature(struct rproc *rproc, unsigned int feature)
+{
+	return test_bit(feature, rproc->features);
+}
+
+static inline void rproc_set_feature(struct rproc *rproc, unsigned int feature)
+{
+	set_bit(feature, rproc->features);
+}
+
 /**
  * struct rproc_subdev - subdevice tied to a remoteproc
  * @node: list node related to the rproc subdevs list
-- 
2.30.0

