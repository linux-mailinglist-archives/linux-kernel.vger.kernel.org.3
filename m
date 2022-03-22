Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38654E3DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiCVLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbiCVLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:34:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C277F6E;
        Tue, 22 Mar 2022 04:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtBk3/pW8zLrgsUhMjwoqULS2FfS7dMiYSWSfY/MZ6VcFaPpXEXLtXTSMa+TEGrx2EDEA1NPadLFVB61kwvTauMJQdsU1s4AFcNhrKEcBsZ00ILvaQn/xKgRaoMfgv6ySLHtYaHjWC3U5XxIbpjeYcUCe/D6FCQl1umN2eoR+xH2udw0X0Clb3657FYhkOBU30e5L0X7Jv2gW7fzPFOO28q4mqxIbJ9POyo6k3h7zD9lJ8esYUisNVWvZCBzdvq+Hw2JJtxQob/R2OEtQyIzn7YWRSJ9BghlKyPTyuEuCc0U5sU6RXt1TrHKbXsQl/LCtudjbBLrJ4IeCXgpePLmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4E+7UMrszfO6TeHDgDrwtJoKkYcyypKQ5DSNT1jYjk=;
 b=crtWrjGDnRemorIsFftVqknnh58NgebQxXypMrkpFgSn122/MHEsfU6mxDeqHia42iMKK5RVYIdO1JitLBjXQANWSjdG/EiaDK/OIr/t1jU9ZLr3R46AaFnjJUdGcnVoepzWqzG4ayGiQy24r+ITKHpMwWeCYrC7zA9bUpSm6WMgeQEnmVnGHkn1eJclvm3+bz18uA7ZyOvsxP0b/UGaJR0qurucRJeJx5szcSyxQlKJtZQL3G0PdphM4A6L2oIfiTgiQbnyMr6yvRpoKO70wvGoinnwbwc/lb+hdysOj1/epKZ3URDCmskborh63WEIJbwB5K9Xo3gbEEtaa61OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4E+7UMrszfO6TeHDgDrwtJoKkYcyypKQ5DSNT1jYjk=;
 b=N0Bx8qeTRSW9SsYnZGouetY5/aqQ5su50MaGmmn1lTjZV/D2Dt/4gn5psAwN5L/viiAJB7xxb38UA+HaZ1c/GfKSeo49/NRdbKwXDAZUNUHNIao/Ng53HrGpJXqljmuv+dLVC1kOIKJolX2556WYEtmw6j/g4j7xtDIDldiG9RA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TY0PR06MB5080.apcprd06.prod.outlook.com (2603:1096:400:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 11:33:05 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5081.017; Tue, 22 Mar 2022
 11:33:04 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com
Subject: [PATCH] rtla/osnoise: fix NULL but dereferenced coccicheck errors
Date:   Tue, 22 Mar 2022 19:32:43 +0800
Message-Id: <20220322113253.57390-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb52472-b9d7-4fa2-658a-08da0bf7ba85
X-MS-TrafficTypeDiagnostic: TY0PR06MB5080:EE_
X-Microsoft-Antispam-PRVS: <TY0PR06MB50801F31C52E0AE70DA693E6AB179@TY0PR06MB5080.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dN4VlW+DdNrcR7dQJbmGauHM5xyl0VKA/GFkD6XGhA6vsNu06FLB63C0IuvHHdAwYq1Xqubo4XX8xxwBC7eFcIOI3dyGJN+VaVwFWvVeL2mds3YyN0hdh3H/7Ha1X9V85abcfkIgT8DvnseTRWjJMnLCS5+njLaJwdPkfRbtK6Z4WRImesvB+ONJewRiFnWWE/yOMt9mcHQZRXxFYXiiAOQkHgRkWWSKxS3XVXUmNzznVUbcJ1ldFzFggsH9S/pdopi6YE3B9J3iW7uDtCEJciXSsin9X6ZuSuvgWfxdlJn+iynASIrtlMBxCD8DLYVPIrks92onG2tn+kKNoAGYxZMPDdEYPx/GBVf/Nj86IRmDqGWwSAXS/+HxlE6twNMTJe8U1wGFLGGo9grLocSMOn5v48+O8BXr1m68e3sKJP1IbvrzuVA8jIBNphiRIjlybjnF8KrsxOkUUytzSkDKb5ExO/gipsxBKVHJZTOmMNTVOhn5zhWON97zP2PQTfzRluN4LB8yNlW/6Cj7hcxq9pR0e5vRlVC8vi4cH8gsWnYCqB0Sn5Mn5FL32tnM1OWF3TnE/zQ39zT7s+DJhQIpoginpB2j2xOFXq/xLsnLnjFJEffpadFMYfBNqetYxgaxZmB95GJyiA3FhxpXEZQBrEpJir97dT5ZwAqPzpg8syq8VgGFJX6n4syVknPtxJuGWLuFLWMt5Dkim1Cx+7eanQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(508600001)(8936002)(5660300002)(38350700002)(4326008)(6486002)(66476007)(66946007)(86362001)(38100700002)(66556008)(2616005)(26005)(1076003)(186003)(83380400001)(52116002)(6506007)(6512007)(2906002)(36756003)(110136005)(316002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xHUOMs4DnsXnvog0NWmI6Fx7WncF8Mr3m3gHOszwt0ps7ViW1Zdh0KQ+4Gol?=
 =?us-ascii?Q?oZ2TZmkrjDWC/95ESCk92eJAT6hvNOVjLGLMaCNg4jQS76Cd8Ohn5hMfmEIl?=
 =?us-ascii?Q?js292FnD8zIJ8NVDm6abWhq662topn9KVaPGY2mZdKIZcDaDSba3uEJz1/Kc?=
 =?us-ascii?Q?SP36oEY8ypr+L9zYoWl3qqZ9pwdCWvNubrp7+FK/pkvgf4XhEbe3QNh8+qYI?=
 =?us-ascii?Q?4BuRp4Y1b6HilSFRaFXl+X/9sbFW8cUcErKtIhjZgbMCzp09hK7aUep6pGsN?=
 =?us-ascii?Q?GjABjn7DtX3sr1gkhB/E6IJvFQnDIx3ZnjjmV6nJufwq3Q1F6tPpzBh5JlkC?=
 =?us-ascii?Q?FJHZxvTapW81kORH1qGVdZhbP+lIUd+MjzM8JdahpLYxTopj+8+HXtgp2WTO?=
 =?us-ascii?Q?8aBntp6DiK7hCw9WBqkirDGBM3zn+KQ1JHR9O5TCu0D54YtasjZLrb8Vd5cJ?=
 =?us-ascii?Q?zBy4S/u/sZHPCYKJH0NgTloUiG2C+yGFDxQ4vaUrANhPbyK2Pvtsvw2zxpJi?=
 =?us-ascii?Q?FhyPgJpkI+Jx+o44MYHqXhLVNpslxSZq4pf1jMJ0rE5sI6skANyVO9tykFp/?=
 =?us-ascii?Q?hiSXgSDYv6DBCTFdygwncsAHP/08W1oGsLHnKEnCzoswR28t54lwRL/eQL5g?=
 =?us-ascii?Q?MWu9me7KYBdjZwTdT/g6+JUu718U5vyPP4yPJAIvG/L8dSI/vUT5/tdPyRyx?=
 =?us-ascii?Q?j7/p6urLnQPHi6yndI/EPvR42xPfENwSGaLQWX3ca+71BrsFpxUIMpmuytl9?=
 =?us-ascii?Q?cWlGwAR2273lm9uvUDVvEFFe4S+R+xwDg4YP9jUIt3jHNjKPLU31WeixVYVH?=
 =?us-ascii?Q?KSHUxRDZ4uiFpf8G2E7h5zSrRZaOXQaI/L4XMebVetkbRDLawJMDAOGlDBbr?=
 =?us-ascii?Q?yIaupnFYZBwInVo4i27r0MbESmatoxtlW6Cax5TpeFzzSLlCytEYj8ljZQaX?=
 =?us-ascii?Q?dqpQCWYmU15ry9YrMI1DGcjU7ut6KTdTyCIptzrcpvxSMwa2Q4a8AyiRq9Ga?=
 =?us-ascii?Q?GEqEK26EwEoz6LFJQrID05j4D8tYoFr+9mxeND6U/YgvFz5OslQ6PycJxLzO?=
 =?us-ascii?Q?4MO55X1fV/7DUxbGb8tErwAazABrCZhCQ1WA4uSwAKCpvE8X2v+piG2DwjnT?=
 =?us-ascii?Q?kUdP2z2MybrRRt6nrid5dlFCV1lPMo6sY8qr76mD8q3QW+ZYhaPZATdZEzw+?=
 =?us-ascii?Q?g6J1Fh+0V5frZcAa9V3TpN3gqpqWT2EEuvm2nebHfx9+Q4KJtVSj5tOF5LjT?=
 =?us-ascii?Q?wxH2elSiSE2dd1YTEU+0vgRTKcXypthiN8llUvMi50BjqD0H87+m+my4/UPK?=
 =?us-ascii?Q?y4hXjDn0gdtqQWyKbhyisRi7eUVvatCxwdTvOqZxrZCsIUFD1mkDwJlBtRBa?=
 =?us-ascii?Q?v6br/QPVtyIrbSps2meE03GRqeD/Getcm+4mszPTniNrSK0/Wt3OjgjTwAwT?=
 =?us-ascii?Q?cFrYRU2M4L9RFpFVvhpAaZEekGbSf3Uz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb52472-b9d7-4fa2-658a-08da0bf7ba85
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 11:33:04.2197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qojcHWWkWKhHsisotKYq8bBKVq/gxiE6Gvcz/gBnM9Mzm2lUsdcOFG+jzAE3EuHd+OzDN0vU0bSXbk/KQJfOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5080
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck errors:
./tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR: record is NULL but dereferenced.
./tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR: record is NULL but dereferenced.

"record" is NULL before calling osnoise_init_trace_tool.
Add a tag "out_free" to avoid dereferring a NULL pointer.

Fixes: 51d64c3a1819 ("rtla: Add -e/--event support")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/tracing/rtla/src/osnoise_hist.c | 5 +++--
 tools/tracing/rtla/src/osnoise_top.c  | 9 +++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index b4380d45cacd..5d7ea479ac89 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -809,7 +809,7 @@ int osnoise_hist_main(int argc, char *argv[])
 		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_hist;
+			goto out_free;
 		}
 	}
 
@@ -819,7 +819,7 @@ int osnoise_hist_main(int argc, char *argv[])
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_hist;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -869,6 +869,7 @@ int osnoise_hist_main(int argc, char *argv[])
 out_hist:
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	osnoise_free_histogram(tool->data);
 out_destroy:
 	osnoise_destroy_tool(record);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 72c2fd6ce005..76479bfb2922 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -572,7 +572,7 @@ int osnoise_top_main(int argc, char **argv)
 	retval = osnoise_top_apply_config(tool, params);
 	if (retval) {
 		err_msg("Could not apply config\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	trace = &tool->trace;
@@ -580,14 +580,14 @@ int osnoise_top_main(int argc, char **argv)
 	retval = enable_osnoise(trace);
 	if (retval) {
 		err_msg("Failed to enable osnoise tracer\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	if (params->set_sched) {
 		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_top;
+			goto out_free;
 		}
 	}
 
@@ -597,7 +597,7 @@ int osnoise_top_main(int argc, char **argv)
 		record = osnoise_init_trace_tool("osnoise");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_top;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -649,6 +649,7 @@ int osnoise_top_main(int argc, char **argv)
 out_top:
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	osnoise_free_top(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
-- 
2.35.1

