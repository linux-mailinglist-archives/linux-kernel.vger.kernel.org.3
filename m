Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3A4F9931
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiDHPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiDHPQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:16:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2098.outbound.protection.outlook.com [40.107.255.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B33337A;
        Fri,  8 Apr 2022 08:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0mzkoRv5JLQNU7v3J88TeMznuDv88/eriyUtxqf0Zbgue8DbEq68lnTi6e2rUoMixl/YAdBqFyois6Isv+miLrc2sWsFyXW9dXXetkuMPM9HxLMWiaTdDIXIPzc6pbuv2XoBM5vowMgENLXEAExJUz/Cy9RyhFwMy0NMRZwR5CXoQiK/6dGeKwqssxvfase7V05/2hrQYJIy6SMHJy9HM2Y0BtMBo/FzylEpvSGRlyRM1hGngAK0DUG7uHjje9ZgvWs85wxE5wgA3IHPVMXxnqTb9bZRCLemRfmJ8roANZgfkI47d2l3xVC0ZIaOc5qcwJEjDO6KAMEmqpXh9ziLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO0vsaL1Px62xwkT4nMwWYDwR9pjanj/mhbDsUPPhHk=;
 b=LLuszv0eWy3/eXdJXYl+QbCTnWX91UfazKQecWNjDybvK2LvQrq6/28UC7PE7Sn7EZceKzn/Uo6ivB8SqR1j4kPcw09YewYfBkq8pymdof6OxUspoHReThysU4tfvAcDnldNoRX5i2uUtYPCxRFOCye8iSrFlCe/HVg+AeCPicJoN+1p2wzw9xfaisVplOP4VTnOUtiGifrRo+MgjtKWoDlNy2iuIBcKnImiYwyBFPP/y5WRqLcPUQoACCOspTo+pNHPTTtFIt/6nexEedRNivimYtf8RIAqbxNAZXOZAo6ZNrCFO2fza5eQb58XELxAwNlayX4XFdPUvkW2T1qHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO0vsaL1Px62xwkT4nMwWYDwR9pjanj/mhbDsUPPhHk=;
 b=N3jsoFUcYYaaUO4ufz5F9gjzIX3QG1S+ZjHnX1kRlQZyBHMFYsLI5Vjx/9vzimh36+7hG83Ofk+jGBgirPcKgPX0N+VYZZdE34LE2QgiOgPgR/M7y7b0geKZc504xTIhxriFD/17KSTTS8f1qRQb/6ZeXUNlUovIW37YWF+WSGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PS2PR06MB2904.apcprd06.prod.outlook.com (2603:1096:300:4c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.22; Fri, 8 Apr 2022 15:14:39 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::74ea:8357:f542:4881]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::74ea:8357:f542:4881%4]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 15:14:39 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH v3] rtla: Avoid record NULL pointer dereference
Date:   Fri,  8 Apr 2022 23:13:32 +0800
Message-Id: <20220408151406.34823-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ee1f083-fe50-4981-9696-08da19727fd4
X-MS-TrafficTypeDiagnostic: PS2PR06MB2904:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB2904C1996932B50D68697824ABE99@PS2PR06MB2904.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bx73NKy79ytLpHsd2WRkRtcf07Cwk4CNFPsHJMt0sOhXmvH66UibmFS7BhUOJKsEcJZaoQ1TnAFZe18PbFbrELV7pHymG4XaAvZ0HmCTz+O7d7WDZNf7FQsB1+6nZqKv/H2CW66McBrFzUv/ROB/g3bHVmw+/OajvOLDryMYjzNLqne5Bt17iVdBJe+3BgbNWRqN9Aunz99SwDbdrDgHXTh5mh4bWvgUhBduvh/n8X6iSjnp2SB7fzeodCRFuoyju3FeZJtCFPztA08kDQrbEGXi7xvmqYtzUAfdemCVPqLWoLZaOLIoTMyJ/01DV0eeT/xruxYbEq3gq1Z20FFqAR9DeqDghFFZ0eP3NW+zogV3MWEY6OXXWiF8kcfHxpJtJeYKje18aQw3222ukyHJPn5hpmjJWuxBbrv0df9NKz9akCwqj/VdEzFR1Kf2bLLyQrsAwQN7Wca6u5CpXEzndJTSO79WQIjvAucTnbFHS9pr42zEY3Uy5clpu0v+rk8QinyrW+ZY/j2BfulVmbtvYEinKrEk4TFY4h+wYMeBkVc229GysGqqaseq4QxxadzKjxF4d2HktH2WpLlu5Rr6e6DOgSpeG5AQnFIAEP12bPqhfdfqXRAdXMSlOUy5JVIPe7YLgwtsVk4+3VyO854tV5xq5H5RVLEnue4XVu75ekaUgiWw+v0KvF4J+RF5lnOAC4dMB3nosfaN3OJibero4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(1076003)(186003)(36756003)(6512007)(26005)(83380400001)(107886003)(8676002)(66476007)(4326008)(66946007)(66556008)(52116002)(5660300002)(6666004)(8936002)(2906002)(6506007)(110136005)(508600001)(6486002)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ukEFd9fUygjYjZOxa2hC4psLI/gvb872MeJC/mX2BgjM7uf4iYA43qkgqsw?=
 =?us-ascii?Q?O/NneP7qAuzfFAPkadxeuHr5d581nigYm7O2MdcAwVeEGW9ygL6eQZzKPYlt?=
 =?us-ascii?Q?+zFhs5ke04cq6CnSWy76v/XOf4+z/CWdHcN2me25YMSw/iDBEtAMfcphmQ1U?=
 =?us-ascii?Q?pqdf5A5dOuGVd36fvYPVcpYSyHlh/37gj+8gevcRB/fSt/wCdLE1rdMq9HUF?=
 =?us-ascii?Q?thGc29gSTqVGdFNk9c2IV4NeWunRc3Y1/CYugA3ZdxXTx4HqlpD5CZXgouj3?=
 =?us-ascii?Q?qbhKe6W4pVKyPzLivZVl6K/Wi6sr9Vh/iQ99OQg0HCnIyMecjAzAGID11F0E?=
 =?us-ascii?Q?mWG5pFk5ShGSBxkfc+2N3pZBQMw7Emklr4VJAD2QnElNX7mrx/yjuy+2oq6N?=
 =?us-ascii?Q?8QghlgVLoO9OZFc/VWWKegj+FoiCT0NzRMkXz/lATxpm9ebFwFahiQ2I+j1J?=
 =?us-ascii?Q?2JEIk3C8zo+Ruyd0F27YxRkqBnJd5oVQ04QNozCvngmen6a9JaBCv8G1uJDY?=
 =?us-ascii?Q?ik6zrNUCNEGaWx8C28jkmULE/Na0ujXDfEA3jMOema5o/8J035ZvwpBxbRtq?=
 =?us-ascii?Q?G/Ai8G4IG5eEmHnvJktfRofHtZnOxmax1y9LMIgE3tuIAZVjVKu1EumOfcwP?=
 =?us-ascii?Q?wbwkKn8kTvnl4tFKCOEuQrNC5mWBiHqjboVfE/bOP97dTpV7FFprlR6h3WPo?=
 =?us-ascii?Q?TKNJp2l0t6eZOGG+X9e95L7bBW8NjSvWrStyz2nJiHbu7vQ1aTrWzeb4oGSa?=
 =?us-ascii?Q?1/qqhQp8OIRA96QBktF/0jOYzs44EJhzMvLQqV7uVgCj61+IWahPi5dsH2Dv?=
 =?us-ascii?Q?M8OWncne7PnEspUoD5Dl82p8XvyHOKig5+pfE9cAxZbe4pemqnHel7dpYvXA?=
 =?us-ascii?Q?GYlpeOE2A8LY35G6czZlOlb7f704VSq22zXzUznyhNPBjQOlhHQ2ftZiYPXq?=
 =?us-ascii?Q?zjX4Q5OUoTwP1adAu/kBErBB33i74RNGZbwX5VMwNmowulOqS7fDE12kZbrL?=
 =?us-ascii?Q?jARKkDi94C39bJy7HwhiXbitrMmFhUntnx+7UVu0VKHyboEhJaGC94BnbBMh?=
 =?us-ascii?Q?ZDM4jydd4JNvUObBmVeWktbw/Tl6cfrCi0S6PspSMqqeerb02mF5bS8RhQSx?=
 =?us-ascii?Q?iy6xIseZLweXEe03DiaMyLtzU3a95yBRVRzOPfK+/oCwXDNuzi0/ZmzLIkjF?=
 =?us-ascii?Q?nEMlxxRamKXFDO3f5NsfWumGK2q9AMI0Z+l9QUd13YLgf3o3XmXVb9OtfJWb?=
 =?us-ascii?Q?WSSohd5knQa9Klj3nwoXw3z91oyGUgTTUDDv5dHhHIeIRJZ5igT3nKFm9dLk?=
 =?us-ascii?Q?sFiyFiHjnLI7nRE8NrLdHd9cgF0HePUGczFWM1ETCZJh1l3nSz9glWCDF22V?=
 =?us-ascii?Q?z9pQVExw1TrZZBVaV1v5h29nnC03GBlppFcvP0L4XvgEx4qNF8BHBFjufTqw?=
 =?us-ascii?Q?JpZUa0YmGtSfdpouxSao+b4VqYVKhw7iW9G3uUYJThMo7R3bIcHaEpByOdaT?=
 =?us-ascii?Q?U/ekK/hHmYhzcHrIRvs1ToO5p7Uf95HzXUaWy6Daak7xvp07vlePlTQNqXp3?=
 =?us-ascii?Q?QEzlDle/QXH5XmUAYAzLkQsIpxOZhQl0GGYPYpwKJDJLCHi4gA8leziJimiS?=
 =?us-ascii?Q?mE+fQ0iJCjN35Xe/fdWGX5aPMdE1NSK/twRA4Jpcasvys2X85LRxlgvG/hZd?=
 =?us-ascii?Q?fsVNpLvOZ7ExlcJS4yscdQ0eXEUDyokIxCagA4+5Vt0dFEDM2U8ayFpY4QwT?=
 =?us-ascii?Q?ubtmVnPnig=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee1f083-fe50-4981-9696-08da19727fd4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:14:39.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZuZTTuWVH+EkZ2iQcxeE7rbc0tSsCdZo+5u6KIRkCEY3Jljdjx3AJCCpv1sJgWJcPicJJ9EsdP/PppvZXC+5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB2904
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following null/deref_null.cocci errors:
./tools/tracing/rtla/src/osnoise_hist.c:870:31-36: ERROR: record is NULL but dereferenced.
./tools/tracing/rtla/src/osnoise_top.c:650:31-36: ERROR: record is NULL but dereferenced.
./tools/tracing/rtla/src/timerlat_hist.c:905:31-36: ERROR: record is NULL but dereferenced.
./tools/tracing/rtla/src/timerlat_top.c:700:31-36: ERROR: record is NULL but dereferenced.

"record" is NULL before calling osnoise_init_trace_tool.
Add a tag "out_free" to avoid dereferring a NULL pointer.

Fixes: 51d64c3a1819 ("rtla: Add -e/--event support")
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Add the fix for timerlat.
v3:
- Make the subject clear.
---
 tools/tracing/rtla/src/osnoise_hist.c  |  5 +++--
 tools/tracing/rtla/src/osnoise_top.c   |  9 +++++----
 tools/tracing/rtla/src/timerlat_hist.c | 11 ++++++-----
 tools/tracing/rtla/src/timerlat_top.c  | 11 ++++++-----
 4 files changed, 20 insertions(+), 16 deletions(-)

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
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index dc908126c610..f3ec628f5e51 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -821,7 +821,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	retval = timerlat_hist_apply_config(tool, params);
 	if (retval) {
 		err_msg("Could not apply config\n");
-		goto out_hist;
+		goto out_free;
 	}
 
 	trace = &tool->trace;
@@ -829,14 +829,14 @@ int timerlat_hist_main(int argc, char *argv[])
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
-		goto out_hist;
+		goto out_free;
 	}
 
 	if (params->set_sched) {
 		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_hist;
+			goto out_free;
 		}
 	}
 
@@ -844,7 +844,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
 		if (dma_latency_fd < 0) {
 			err_msg("Could not set /dev/cpu_dma_latency.\n");
-			goto out_hist;
+			goto out_free;
 		}
 	}
 
@@ -854,7 +854,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_hist;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -904,6 +904,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	timerlat_free_histogram(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1f754c3df53f..35452a1d45e9 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -612,7 +612,7 @@ int timerlat_top_main(int argc, char *argv[])
 	retval = timerlat_top_apply_config(top, params);
 	if (retval) {
 		err_msg("Could not apply config\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	trace = &top->trace;
@@ -620,14 +620,14 @@ int timerlat_top_main(int argc, char *argv[])
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
-		goto out_top;
+		goto out_free;
 	}
 
 	if (params->set_sched) {
 		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
-			goto out_top;
+			goto out_free;
 		}
 	}
 
@@ -635,7 +635,7 @@ int timerlat_top_main(int argc, char *argv[])
 		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
 		if (dma_latency_fd < 0) {
 			err_msg("Could not set /dev/cpu_dma_latency.\n");
-			goto out_top;
+			goto out_free;
 		}
 	}
 
@@ -645,7 +645,7 @@ int timerlat_top_main(int argc, char *argv[])
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
-			goto out_top;
+			goto out_free;
 		}
 
 		if (params->events) {
@@ -699,6 +699,7 @@ int timerlat_top_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
+out_free:
 	timerlat_free_top(top->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
-- 
2.35.1

