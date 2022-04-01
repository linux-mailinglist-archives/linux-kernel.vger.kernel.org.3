Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579044EED56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiDAMl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbiDAMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:41:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DEFC6825;
        Fri,  1 Apr 2022 05:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK44Y7TNYRc3lJrpd+8e9vmRDZJu+kf3zTKHYrGik97WrTygxB+UHiOr65aFUK0aRf0iRjGKZ2SpimqhAU09mxHDCE2JOeDdGuZ3ne6m1noUmccin9/4sWjVRfb2bhlwh1okSD/wcEayUzRLBRl9hIbF2+ekun0x9/BMmE4IeszJI3AocnqCc9PWKo/n7FAuOBLQKe8D1Cn942XWgHXHr5DlZ8YVGxEUUef79+hk89KK/qgJiJbHP2dbDRGGdthtooLHd4DLLr3hNgScXspUHKb18sTbCuUC5yPPtmntkTjVgxK6wdzJeL3Ou0eroUSYU2o/Z/HfnxcD2Is7F0KbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3l+RbOckGFLtDPt0n08j7Q7hCcZWtW7l2b5eFRnUasw=;
 b=Ovh/LQ1MraIXcN73Y71xxrD07oWTQN3PCLeqimPcrlmgbvxS5tm7Y5lKdPhPZtMs2maU3Ol1mwz76RnmIsS7s5XoCNZrnLiMyO6ez0lIBcSZxNFD6WeGFdKUNGWkUnTgBVqti5z7o6v/bwFAFTzN8l16oL9SI5V5R4UJW6ie8yQQ5Aqnso95gzxEom3GTvtmozuyDgxBOeI6h+cCl/IbBrQ+QcnrgViBTF27V+Y+26M2FJlMLrxGMXB85vGGztfAU0YWPTAtIDF8MnZ1QU43KDtN+XrIlqQZ+XnmdZJ4q9tKfUs8iHFWpyw/b7GegtQHMJBX1+3z/pN0fAbmL67giA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3l+RbOckGFLtDPt0n08j7Q7hCcZWtW7l2b5eFRnUasw=;
 b=c9+BLXBJQIELJjbI1Ys7o4PxZG16sMdsg28X/O2t43sOqoi0ULF+J6U/u37TgwAoZyUzOC7vgo3rSI4r8rX+hHQQx+JCNz5gYSl59vMsUefdENzLhoDJpkNEp21Ai/Fg1Qc1ZgUo+Kvw95lzmUfgEoNpybQyjCLOHqRifoXVAes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYAPR06MB2093.apcprd06.prod.outlook.com (2603:1096:404:1a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.25; Fri, 1 Apr 2022 12:39:57 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5102.022; Fri, 1 Apr 2022
 12:39:57 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH v2] rtla: add a tag to avoid dereferring a NULL pointer
Date:   Fri,  1 Apr 2022 20:39:27 +0800
Message-Id: <20220401123948.69312-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4000a8-959f-431c-eadd-08da13dcba67
X-MS-TrafficTypeDiagnostic: TYAPR06MB2093:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB209303715634A5EF28DA1D7CABE09@TYAPR06MB2093.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siLjgW2Nl3dVTObEMsi+lFZTtVtg4ZYl4blOzT9RgUoYZv74G98MIOs7WqbTN01q5kr79gg0wDf3d1lG4s1ybLF87rMz6XjA57X1+cjNjBa2tMP1wsOjFJFFhW0R/5NKqcQlG6TQdpo5s+ff6hjUsqc1rtXvUOVVMqHjMJYH+ymR7PBclf6FEhgnNQNCucVnRosfknyjCzlwc8T3fAwS3Siwvr7PW24XpCWerEsjld4U033FWE4EqoOy7x+WWRRDhDajkR3k+KHju0IPByvACkMaZkze7ctL3TnTfvYxbiiO/nGj3KVQuNtUbiKjvVh51Q/ToVwJOcWSP3vxKHzc2Uie8cyRBiGQasl2yyDlueaK85/EvGiN6ZEboyr6b1MqM5lu2Gw+m/fA5nxPWCjLjknPOQ99t+kmHVzSa5ASuIMyPhGQUPC+OwAxXILaKtjl8CjbrK60skf/2AA60XcMR6LIrxFiFRqKrutpOZMqJ1/nzqwy4rk2n2djZx72/PzWWn1A1vguJxaRk5iZxpKf7Tu3O45FidelkeREbq/LEZH+7ExEQ1SbP2FhykvWB+A8Dopwi+aETV89ZD4mj+u+DI0xLTETudwY29emY7CEpyMdSNIlOTOf/owmZaVUvyvyGgXcdlP1TzPG3YWC+i0NKH4FkEhy3xpuemfooYxYvjqFEYyNIqwjk57lbDW+9Zzd3JL8fgVsRDRYHu7e0eYDCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(86362001)(6666004)(5660300002)(2906002)(38350700002)(38100700002)(83380400001)(316002)(4326008)(1076003)(110136005)(6512007)(6506007)(186003)(26005)(66946007)(52116002)(66556008)(66476007)(8676002)(2616005)(36756003)(6486002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GJigdhd1lM08Zl3sJpddvpjXbhoiI5IF5GNSX+1mxy0Rbj36QNs1QnIai0E+?=
 =?us-ascii?Q?aYUhL1yD9HGQlxCdlmQ4v83KaL3lYaBD13ogcWtsp1OcBwjjyobS4rEclQ/r?=
 =?us-ascii?Q?zEp+6eRtHIdg3xXrSM3lX66payon0YxK5KA9O5LEAoNoy1vQEOyx6jEUn7Fp?=
 =?us-ascii?Q?/1jaIViq9DZ0nsb9OMbVTUSZwMcF7ay4m7etJlMXfH7K6KBiKsurciSuzEZI?=
 =?us-ascii?Q?34w80vhQo9I4kGGYtp/JXlPO7BacMGy0Ivk+VUnbr/ksfo1mSsNymH2rrRZU?=
 =?us-ascii?Q?nXFKbULqDlG19unOt7gqB0SPi/xps+UnEKroOPNDmFCzwgo+Gy1NamerFdZn?=
 =?us-ascii?Q?fiNRZStEGYLe82Q5UudN6r+t3d+Zn++QHxc+XNdGLou/CH5Ikmt5CiAvOeha?=
 =?us-ascii?Q?QvNXHLt6+aGozumduNVxskj4uZuBRd7Z9Der2m/bBe7JJGqY+dDXuWUs6qkv?=
 =?us-ascii?Q?3jwooaqx+zKbwRN1ywJFObyZxnjc817u+Ezf+gCKUO8/JnrsfhE8tBH0uwg6?=
 =?us-ascii?Q?hDyvbGkgNjJFpF5HBuis9TCXPev1uQqg3CVQ44APqeBSuV55qCATg912SvRz?=
 =?us-ascii?Q?tjEIMGnxCJTiQxGaxrAXzLOLhw5jCMiAs03As8tefLCcyHwcpiNBfK4HyApv?=
 =?us-ascii?Q?404wnRUEM2lyJOs0VghwvfY7En8ZyGCn99LuH03a302q7ALuuvdaFa8r1n15?=
 =?us-ascii?Q?fb+80R9OVGItIDR85JB8HKjVP1zGdo3lhQ+eUJYctIctaoqtifkXWRt6cNdH?=
 =?us-ascii?Q?9Lg7qYfLuyP0wIKOG7N01MxNPkk4j9RfiJjIZ4TB+qzm1uagZ3AbDRiT/0Qw?=
 =?us-ascii?Q?rcITQVosWBugVXiCHeUVfenAXw03cjnXtJdWGL4LDXTsUIKhCPnGkjvFNl7e?=
 =?us-ascii?Q?PfCiFglqcRjhjg+neS8/01pcWfuVqJXdhvB3UFDij60PFXeR3pMtaup0KoRi?=
 =?us-ascii?Q?DuyOVYoe3odP/GNlsZ+Uu9Wt7l37Y4QHGCcxQ/4svJ4N016YazG+dG2kwPGC?=
 =?us-ascii?Q?3SunAzmvxMbWbpmC7tWTuhxmrowu9ym86liN1ipq136T+JzZvv7vilLbUvBw?=
 =?us-ascii?Q?v3Jj/M85tHUxi5P7BpKspV9dwEjkMDw7uZScOxo1tTraPnM1FkslDmy6Jbn3?=
 =?us-ascii?Q?NTE9YcK3w0SwAymvKRsFOxI70D3lvv39vqr0jy3duDqQxHlJ0TomTEGK/0C3?=
 =?us-ascii?Q?hajUcB0JVxvEMOF5EizGBi8gCgc2OVKQGokKBqeQP5F/3c5w4SiwfX8GCCEt?=
 =?us-ascii?Q?x1LuzISrZdHzMG0Dzm+2MLnplkSiGB32yDSa69oXHuGe6tP521MXvkX09vFm?=
 =?us-ascii?Q?coaS3YoNeDaOSZnUGpD3Bu3QTUmOy2e7TnC1PazRn4zjbhgAXZH+5j+ww8aw?=
 =?us-ascii?Q?1MlzCF8Pn7h4y5899RbT8fsVSpD0AuvDYas8WvvdHzdNiFGrAcX6grO4mlxB?=
 =?us-ascii?Q?bEo14zMFMinj1s9fpu28LuhJke1sBHXT9D2kvfhuZnn+V1VqOBidYYPenFBa?=
 =?us-ascii?Q?DDywPGqDbRDkSTqooEp5WBkyCuAI7ONTbHol6QSfdIk94/+d5fjHo4fUm/MR?=
 =?us-ascii?Q?Cnun84ulnvhLK4PQa/CK4IF4Wu/u1FrRgh6cs/JMTYRFQGhp5RtiLmUrZhl9?=
 =?us-ascii?Q?qjOfWOV9jqAmIP1D6dHioe3DH7ONS69IElxJCyUarC2UHd0KaeUyVksnNr65?=
 =?us-ascii?Q?pZAlj821uQEZafptVTbfFV+l5LPdgHna+TEU6tc6XBVNMLLMMs0FmOTpOjMn?=
 =?us-ascii?Q?s6e1kYtNhA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4000a8-959f-431c-eadd-08da13dcba67
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 12:39:57.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vFIYRLVTgBJXQfCCNXko9rH+kbPTYt54usJmXWTh/qFz3m6vVle248fUWP5/6AmAROGjSxSCGcwc0e015LK0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2093
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Add the fix for timerlat.
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

