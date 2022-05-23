Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495625307C0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353024AbiEWCmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiEWCmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:42:22 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140082.outbound.protection.outlook.com [40.107.14.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5262E099;
        Sun, 22 May 2022 19:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ugse0GxPG+dt6KFzrf8lW15VMZkEb0vjZ+zkJq3abkk/0vBNDSoG2LxVC9qzYJDF2C2zU3Mb1ByjJkoSMzUSUm7A2kWb+6OzK43D08iAVGhAtEfC3Yu7thikXo/IZMg5mf1K+DMd1vDcB+tQcY5QB/D37XSeDmDbMGxF7yMN6qLWUqUq+Nsv5CGWwIuq/bAnfjw36ll6e+5GCiDL33BWnF3tG7XoRP0YkDzIr/z8V2a/GZ0jI0nZrkR3/cZhwpFMADv0Aq1d2mnFYvytCQtTtbJC0hpJSTG2ZrV+J4uwDUwHV3YuObpcUVykTZPpFay5FFEBYHcD1PCGEQKm2/TbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh4Tw7Z54gQcwlt1+CWm+QCtEdTJrY82SlZfWGK2nI0=;
 b=WLftFv051b5/8Pl4uo7zciIWoIcaCJ0jNuPOtBXMll9v6lVBX1+5Hx+Emuh/npCIgqaQWzviifcaxVhABx6xR/J8vmgZtRue60IJtHuJD7ZcafIiPIl7JEgNjQ6lXI3BF8ZOwKeSK0kTiLiYtIjjySf+/OfRO3YLm4Gu51kMIC70aR/e/hjjaYNwOkA3o9RftMgWsM08K1RRDNa0lRI7YGWNM40WRw1AOFkMGclIpTijjDCPV3ZKjmcRJnadOTmGyzkM9ZsHrAqcK4I5b+tHZo7uUAbiVbyALGQcV/oMqz2Rngv+KrfxVKqBQef/SZZeiuic61MkTZ/sXYb63E3XWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh4Tw7Z54gQcwlt1+CWm+QCtEdTJrY82SlZfWGK2nI0=;
 b=qY3Km5KKXu65ApQ3WG60c0sdnlvth+gXZzTVgWZLfby1qFVbejJex3E4seiE1t4G68tvPVVl3hW2g4g3QrbInuXVeEzNeLTXYSDtUSSDifVdTiF2QUPjQAC5yEplLhZttbGsF+NCea/kXyBVjvS/mAl9JmBQk+1B9bsBEja83wQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR0402MB3832.eurprd04.prod.outlook.com (2603:10a6:209:24::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 02:42:18 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 02:42:18 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: amphion: return error if format is unsupported by vpu
Date:   Mon, 23 May 2022 10:41:50 +0800
Message-Id: <20220523024150.17012-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a46e52-ee8c-4d8f-2f2a-08da3c65da65
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3832:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3832FB645DBB959667337883E7D49@AM6PR0402MB3832.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJhGsfWATZtdx/mGDCoZKgnQNGBGlOgjrRYWgU3q8ZQnSrQe0l18UxY7MYqxWCkcgCmdmBJ6KCe1kjMlvbGMNkYgW5otvL4dY+P4Vza8Tt3VhkKePz+dgJMDXvJOKKKSXm4y7whbQ2yL9EnwIpF6yMbGltSfMbAjQqGZTJM84d4WYhPVMlkpe28MNOp/ks2RVP/wqp+arXWB9NcdbO9qjRL9rjdawi7hScIc18/W2qEyTClEeBY8E19myxDZhzd4hRX3RqXIuilh+lmXtDDfG5ZGv1QcpJkX7NYuUO8+p39hHpVgGuUhUmgZ07XXHq073EUVtCuuJ4OAfBiwi88TFO+N25sTWU+gy+ByGHTFDaZ8XsmNe4IYZsQt29r5rOCK4mQV4WQElF0saGAs2eJp15aYuKxYEGbRPjipIPajTCRJJrXcLhNlIBHK3rUXYH4/YhFlZmABfgcSvm4WfDhVpmrTAF/i6WvuW6wCkdIpH1eSguk7SOVJMLuIs6czjTMSgczZHSmhDDCOcksmPbF6wL/Vh85OA0vPyiNVYvaZj9G/f4K6hfAVN+GtN1BHN2rD0opcjsgsvvN7QbaNYvPFhGAJ+u1EgFx+eYWAv+FGKygTPgJ27cnJQCpnKDSz+G/FQY2aI5ewakTqOwono/5aPIgdH5zqE+bXTvG79Ezvacx+oqcF0KED9uzBROrEhkTO20IRWzUXpwOzy2TDSX57bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(7416002)(52116002)(186003)(2616005)(1076003)(38100700002)(86362001)(6512007)(38350700002)(5660300002)(6666004)(26005)(36756003)(316002)(8676002)(4326008)(6506007)(66556008)(66476007)(66946007)(2906002)(6486002)(83380400001)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjySQHiiBEhdo8nQPxfOsUbeK61yhSDVEVHJ/hqEDcLYaBQNOTG5i1nPcqgQ?=
 =?us-ascii?Q?AgjLu61qVJOsFI//SEjz8wtxs2k+pVh2s9hjQ+eOKMGCYNtJQpACoYa3SANX?=
 =?us-ascii?Q?ppJsJUxs0/PuVMX2aA8FIeKxy8mf+VXv++W8li+udxv1aJksoCEiTH3uk/js?=
 =?us-ascii?Q?QDaeIkHplVXkzF5Fga5PfY04fepq+OpOOvbcH2Ao7IUz2Koa/nAzX+Ih4MV8?=
 =?us-ascii?Q?/TUNU4R47rbwJOhFY6dtNiQusaWP5InALMDsHWA4HqrHakFTkOOT6d1wnnlP?=
 =?us-ascii?Q?+yJFhgZoJqCaxU37Zz9cPlFx6tcqWOjzNtYJppwcjly4MgwTPgD6Uv95ihnZ?=
 =?us-ascii?Q?4C3lefgjsdjIElSS2oKc91lwgViXDRm11OgvK6c+iUErAKjHgqTygUdHa1T6?=
 =?us-ascii?Q?u7l2gY4fu8fcGYkc16Y/1WM+kudY9AnP+vf/E+9Q8VMthXnm0rPZ29Ce/UcA?=
 =?us-ascii?Q?R2As2NMqJ3L7zXxYxjWqOsjUb8R4EB92PYJ1zZCDih60BzpU3cWx1P+jWYQ2?=
 =?us-ascii?Q?/JT6PLf9UP1PwVEYLninp7sdvJR9QHUtVnvG2+m84Dbi/LYaswl+orlYwXZ6?=
 =?us-ascii?Q?wBtixOFY6YiXImxNTstADyyf8nyFkZkseCIqxFYMR9ezRIe29rdAnp7C5/VI?=
 =?us-ascii?Q?EdqQy2Af3EJrKsr3nu5FUFb03E5reLDZ8DC63bMfXmJA1esaVc83iXTw3jHI?=
 =?us-ascii?Q?GQwDxZ8ouJHS819ZfYKLEngrbbpg30fLwMtd1xAQSuK7Wl9EC8OfZX1RmA3g?=
 =?us-ascii?Q?NPRTDJ71YWvRtwM0yPoH2Nu2V7AaXijryoemoO/ZI2gCHl7S/3ymIUFXsxIQ?=
 =?us-ascii?Q?rVFI58b58IjnvfQ5I2/7W+iiPTfZuje0LzGMOFhVDxWdugKNcPdzh2IpjILS?=
 =?us-ascii?Q?n4BmKOcQC5QsgKKHrnJvUravDOM/ggKlyKIjFEuj5Cks78pOWmKeE9/9i+2g?=
 =?us-ascii?Q?Nw7G9VQiYVRAC/CzQe/pRkyqONpWTEjS03cwNt6R9ZXQCyPDfwjlfAIjtjxE?=
 =?us-ascii?Q?+1IdRkwp497tc+mGwUD/jXpoV0YNCDEXBecGAQLcMlCQPXomzKNK0hH2wODE?=
 =?us-ascii?Q?C7xerEdoq9SjIZpZimuG7aYIJZsxHHX75SBAM98k+0Zc6WhhX4BlNC+DetJu?=
 =?us-ascii?Q?g2QPma4KpfaVgVt/gL2v+ujU01St2kP0D+LveB9YXvRFAAOoWKyCPyDuxNio?=
 =?us-ascii?Q?jiVB90UMq2b2nVvLG6vFm+xuxIozc6FRgrgJa4/9F0HIdlJxlngJX3EmnADp?=
 =?us-ascii?Q?asf37F0aohdcucOIj0fThqhyaEIUI3ji+gICAMioFrKfDDO22fhUbRo85C9R?=
 =?us-ascii?Q?Jrwfq+jKKUSBoM1auTYr2uHRrGhTnkjniY2+MAufLNhcHxn10B+4XroAbWQ2?=
 =?us-ascii?Q?1uvakjWEGcKdiYMBBCYv+E56DJ+oeYkyHnq3PZVBb0/ZPKRFm7Wc9ghQ0La5?=
 =?us-ascii?Q?A8VrInYUr3lJVQScsjGzixyIF3k8ZZQLmW8tT/Nw7zg/IGKxydGWl3bVIXre?=
 =?us-ascii?Q?Pqqaig6y6bm6s9Nk4f580dnV4p1NElUXpkYfIa2pIiZDu40/vM5PKx+C+yJf?=
 =?us-ascii?Q?fTAQo6Wdholzf+e2QQB4CeURwF3CvGA0+kncdhtGTOZcz+CIYSwN2cjBJ7BB?=
 =?us-ascii?Q?2eZaQ7IZPmqPJqYLF6+dpJB9E3WYnp1k/A6WHW+pc7DN6j0L9CAX05MLz2zg?=
 =?us-ascii?Q?3/Kh3OURNl5w+AjxzcKEMO1OHSjK9CddxCW9p/eqISo9SlDohiWyEtX5nPcy?=
 =?us-ascii?Q?pIab9K3aoA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a46e52-ee8c-4d8f-2f2a-08da3c65da65
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 02:42:18.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: le26+JN/TnEwhlpkaa/+ZcanoLpREVzHVy4d9FlwS2WK4SAHIuQ09bvr9oIeYO9LIcZbjKeEi0K+qc9v0j4hhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return error if format is unsupported by vpu,
otherwise the vpu will be stalled at decoding

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v2
- warn on failed to remap pixel format to malone foramt
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 drivers/media/platform/amphion/vpu_v4l2.c   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index f29c223eefce..40267c73b1f9 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -610,6 +610,8 @@ static int vpu_malone_set_params(struct vpu_shared_addr *shared,
 	enum vpu_malone_format malone_format;
 
 	malone_format = vpu_malone_format_remap(params->codec_format);
+	if (WARN_ON(malone_format == MALONE_FMT_NULL))
+		return -EINVAL;
 	iface->udata_buffer[instance].base = params->udata.base;
 	iface->udata_buffer[instance].slot_size = params->udata.size;
 
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 446f07d09d0b..89b88e063e45 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -500,10 +500,10 @@ static int vpu_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 		  fmt->sizeimage[1], fmt->bytesperline[1],
 		  fmt->sizeimage[2], fmt->bytesperline[2],
 		  q->num_buffers);
-	call_void_vop(inst, start, q->type);
+	ret = call_vop(inst, start, q->type);
 	vb2_clear_last_buffer_dequeued(q);
 
-	return 0;
+	return ret;
 }
 
 static void vpu_vb2_stop_streaming(struct vb2_queue *q)
-- 
2.36.1

