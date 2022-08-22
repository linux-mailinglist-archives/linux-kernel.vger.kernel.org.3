Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4259B7A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiHVCbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiHVCbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:31:14 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2130.outbound.protection.outlook.com [40.107.114.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A21A2229E
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXOhWRNy2CGNvln5HY4b1PZ9dtB8i5DYXLAdGGdvEl7ieHNYlaXJFbJwBl15VIoidYsMZEGm+WkbjfjNrLDBD+Oa+aDy35x/5OgimNq1ZLIPBrPOJ7Nf3wwCakhIwLsJUhVS+xK2TjOXuIEPadImrppLUiUU+JkAPAN9/JoWPE0d+pGNA/f8VarxMgmPK20dsQoMCX595uf6e1dQfA0WXQwd4LPZ7Lk+0PbboCuitWERjeUexfE3lRBqV8DrUz0PqPgGcR2RAn2JH740FeQ/WMsqRwhggwGzfKqSAwnWS3j7Jr78H+T0p6xuAssJzENkoOHGnnfgWMH32MQMQ3Kodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79r48KSAnMbMn61sJE+bkTvfWYk9M39Y4s+NcfLUaLE=;
 b=kaUIiM0cms0l/X/ZrWLl3ZJ3pMK2X6r1HzgSW09qLnJoA2q42m3f9FEtBXqaudNTJcrV6bwtg3+3OBAx83IOhuWsUok+fW2EKI7+euJq5Jy/FVL0LbYRH9gKfwNdK85420fYN1S8OdirCDmVeBsG5TRcXF2IgZS+TKzHvburRwkICWqbyt0VusOVnZ4ujrWohJMWWAAmBgA3eYw9vLfuIEHEshOhSEwHbmq32jfanCn8chgOo47NjrhDqrq54nl1Jkz9eRSKPFE5oU7cyC3ulF/4417SkWH0j6t6nFsprblYQmF2TpIGAQy5Pg9YLSmoMmgpK5JwcYFTCZl0DeuSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79r48KSAnMbMn61sJE+bkTvfWYk9M39Y4s+NcfLUaLE=;
 b=dYSo2ODNKBtqYX+Jc6dwuRXkCbWtckRfHd3P6EYlfIZYVwgWc4eAuQ+RgmhI0OnYVJvP79O6yMWtQw61p8NXhEvYQKAvxAv3CYdGJE3cYn7DyjswpsQde3Qn9lzFipcNCBImtWovMVenLCdvb7gC2ikBS1PHGFOz/uQPKzKlY4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by TY2PR01MB2459.jpnprd01.prod.outlook.com (2603:1096:404:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 02:31:08 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::cf2:7a63:ffc5:5cfb]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::cf2:7a63:ffc5:5cfb%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 02:31:08 +0000
Message-ID: <87fshpggb7.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ftrace: makes ops_references_rec() inline
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Date:   Mon, 22 Aug 2022 02:31:08 +0000
X-ClientProxiedBy: TYCPR01CA0124.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::10) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f18d609f-0e4c-480a-8c47-08da83e65f06
X-MS-TrafficTypeDiagnostic: TY2PR01MB2459:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADGnKjab1HCa3yX1GWkXCrR+GR3Q3lA6qKuohNjD9KiM73yfFq9SuOYtuMHB2284/8D+vYAkifcbMWtLhLpUVCvPbHvGXoP827fOcbJS+Bl2ypr9ToffSvx4lgcJu72+qXy4L2N5VPTfHUuzzrWZTHJBebz6wDURcqsPF58LHQkd7q+6QgCeIzGYRbGt0JpZ6RzqvRVwHGWCX6ufoCThJRG4LkYYXWddxizlnJnQ2FSUAeBgAZojtO7CjJ2YT+6+sD2OzYRgGYHAQG/NhtzYRYIUuzA+Goe/KdpWBaoXbi+ghOSrcym9Ll3XXxpR6FDQdaA60HtZYknu7XsGNUFMCcbat1MYMlOnTJ/zqe+JOu7QbTs2nudaNL4xg5nxiHIECark7/I9FnAh2a3OMRS73frtzUFcyLg1SdUw2UX0pyCCMxJdknyrAnBN7fLeLNmhi5JR39Bf//MUyM81s6EZapsW1GYEPOpAfeTRQC4p4Nf+JUh5XkDLUW6hvS1Kwa6FS86wwN3ROOJzP24G+okN5w3s9dO35/2Xtz3jVvzTcx0aWzmnlitX0qEX+kotb1lu07h5MytWFUVP9rcvav8fAcmdyZ+zMSwgrm7QF5QBNHIc2HktjrPi6eVMxjoiX5z0nJGUBbptEc0N6948dKbPeKDZxTVTwkSKXTN4XzxCX8203Icd8uJUKl8UFQ/gucaCv/BeMgXU0iy+S8V2vtzEvMIZIf10y1oigESsAkYXrkKwceTmRyK1FfIqhatrT1hnHjB/NOLWKSgaGGssAlX54g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(478600001)(6486002)(66946007)(66476007)(316002)(66556008)(8676002)(5660300002)(8936002)(41300700001)(110136005)(2906002)(52116002)(6506007)(6512007)(26005)(83380400001)(4326008)(2616005)(36756003)(186003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WKbhD7gZuGZ/7tk8eGRcS5lO/MmuY+zk48xcEpg6MeLdUhZtQFxL1AIYJ4KD?=
 =?us-ascii?Q?py/i2UTpd7KQNgbcdVCm1WjgWftpFt9NPwQdX0qUBxDxByhC4s8/LG3o3QUH?=
 =?us-ascii?Q?1bY4cCuyFqr1ftKtbboO3mkFsYXwoTzr7zWdLRPUhhaFSggnKVETz40HPTWT?=
 =?us-ascii?Q?/ExYUveDJ3YNnStCoszpzanJGny1khKgfCr46h4GGE/PhEKT73wf8uHcZc4l?=
 =?us-ascii?Q?tTX+UuQ7dXSf1CmK+vK55ifxMz076uRwq1KJ1qTb/ieJLHM/qJ+3ocrRlLt2?=
 =?us-ascii?Q?NaUq95pHin2oERQK2Cpc6oA+Yy3YMDBA/L/vMNXgh71fboGZPrUqyG9u4yhS?=
 =?us-ascii?Q?SLWhbC/Mmo8C3uQMwBjN7JgArb9Ncw+gM2krfhwCPyL3M1p40Ysr1SAtEIEf?=
 =?us-ascii?Q?eADvXbWWer/zLpIUiUHI1VMS1UJLPOVITL6NYPE/szvrV/20RqvNJh8ha7R1?=
 =?us-ascii?Q?g47je95mD6ZzfbuOKgE20zDGYpRGLhJE4H1CZfPClz29ZzL7NowMfRt+imep?=
 =?us-ascii?Q?trnpqAKyNDmMq9S1Gm/1WtD4bCMThl//UkhTgc0g0hVIy/bJj1+X2pyRVsGS?=
 =?us-ascii?Q?xBe1fzqy+7+cbIrwnzGfrXpa2de2eqRTJ1wcxJcSz+mufW+1sPyXqnYqwwJ8?=
 =?us-ascii?Q?grAlvBJHj/3bCgNHycqzhjFtv23tlr226eQKzYqOZ91ji2BGZRB68WyuV1ZZ?=
 =?us-ascii?Q?XUEV86pi7N4Kw1Cz6QlYSvHZvillrA3VDR17rvE7/h2C/yJpyt4+37HaKJ24?=
 =?us-ascii?Q?j4saP8TbNi+IYVuv9O42kns+SzooNWzSg7VCGZrcQ20fHDeWkQjnPAoa4IFC?=
 =?us-ascii?Q?mZepMajzFEW54CAa2hEFgUhvyWMCJDaDz6hT2VJx5ZFAjI7f9XneqQFi3kQZ?=
 =?us-ascii?Q?5XphAERum6bJbLqvTwxTGg27Korc/fUS6G1XEE+LWndFugKGTm9Yc6Rp32uM?=
 =?us-ascii?Q?ZCj/lTPj3oaPF6//R1KKkWg8/n4dehdTazSw0W4j5fPKyGxGJv+CaRuPomA8?=
 =?us-ascii?Q?qgw8iBGNAk+YqiuoucnRmWglmU04XMbKYFI9KxsJQVsyztJVWdW002JkanF/?=
 =?us-ascii?Q?A64j1BotD7lJYIyUMaR93fb63x094h5bsMdzCyMGLCGAZqXhPrJh4+S+KJk4?=
 =?us-ascii?Q?Q2hxeJyY3/439rpUoQKpEc3xgsv+W0L/4Efadi5Tkl89ul5jUR+ZSl1VfLy7?=
 =?us-ascii?Q?FoN7j0S3FbIKop7fX/KahcrsNLBDIZ2wPuzQBiXqDrHClcK3ALhx1Ucp2+mW?=
 =?us-ascii?Q?HIb7vjhcJmHjYLzu7IW3HQls1ixXz0CYzzSWyT1Y9oWES0DdbAYtEJR9BBCC?=
 =?us-ascii?Q?cwohsyr/CSpWo4ElZ0BWoujhCeMJJO1tExdyyZU/PSgq+aWZlWqM+6NYiSRY?=
 =?us-ascii?Q?I+gMxxbSfuU1GvICCTlT4KRBcfFyqBURpB/yiHDRGMRH2cyzVWCjNJ316V3V?=
 =?us-ascii?Q?3Riz04p+wq6SaiHO+aWA8LtJIpcT9qO1MwnE4EF7n4mRl70jUiCLk+QDFxyT?=
 =?us-ascii?Q?yuICKXNTx0Amft5WK36mKsF4wipCSsaL+ZC8CLVT2A4QYWYVmVXjEz4LM2B0?=
 =?us-ascii?Q?pmF91k2g6uOMk+QK41viygXNRGdHNFhala46qleSXCwF9dV1MDLVvd/EI+2L?=
 =?us-ascii?Q?Ye070W8jsYPk13nuxedeWhs=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18d609f-0e4c-480a-8c47-08da83e65f06
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 02:31:08.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjWaKtLUa8WpdxY4jCZxKmN6M+L0Cg0SVTJkATUm+etiAINg0maBjPRzBkgNKQawrVuyqlshW8QWshH7JJJ8f0F9d3pgaHwwp7x6sxgbG69fZgQqDcLMnB1ZceV2dZQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2459
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the
same function") changed ops_references_rec() inline to function,
thus we will get below error if .config doesn't have CONFIG_MODULES.

  CC      kernel/trace/ftrace.o
${linux}/kernel/trace/ftrace.c:3149:1: error: 'ops_references_rec' \
defined but not used [-Werror=unused-function]
 3149 | ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
      | ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [${linux}/scripts/Makefile.build:249: kernel/trace/ftrace.o] error 1
make[1]: *** [${linux}/scripts/Makefile.build:466: kernel/trace] error 2
make: *** [/opt/disk_cd/morimoto/linux/Makefile:1843: kernel] error 2

This patch makes it to inline again, and fixes the issue.

Fixes:  53cd885bc5c3e ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
CC: Song Liu <song@kernel.org>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is for v6.0-rc2

 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..b52782857f97 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3145,7 +3145,7 @@ ops_references_ip(struct ftrace_ops *ops, unsigned long ip)
  * If the ops does not trace the current record function, skip it.
  * If the ops ignores the function via notrace filter, skip it.
  */
-static bool
+static inline bool
 ops_references_rec(struct ftrace_ops *ops, struct dyn_ftrace *rec)
 {
 	return ops_references_ip(ops, rec->ip);
-- 
2.25.1

