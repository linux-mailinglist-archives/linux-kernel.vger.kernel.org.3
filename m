Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314E64CF07B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiCGDla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiCGDl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:41:28 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A961E4DF5A;
        Sun,  6 Mar 2022 19:40:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTWlK9Ke8PuC6g4EjAx8Xt61+grm4PV/+jF1X1NHI0pCGiq3BSpsKFSIRcEE8z7QicfBHDdcVq3AmYd+Sg2NDETnCmO4XZ1bE08205EyBI3jKp/Gs68YoSZhkmEeaiYm0aJ/WJ6031ZPS+C0hIlkUEq8udI+n5f0TP10es9eLCq5kynR21TzhzEJjDheberfQlIAO0D0ophRThB4z0htrtfCr0e8dl8crYEy92kPEMnAYd+h6J25gd7JC3NC9egDXBPoVyct/WRnOLegE8juVMB9tWVRRJQ1CVnBRtJu9ph5E4RJ8rQspTjq79osaJ3ePRkzVwrcJBvroY307vX2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43iaW1hoBi75dQNjNQvdeOBUwJos6d702cZlP91EJss=;
 b=Fi8QPdrmJuIQ+gbP2OmOskmtiQ2BbpuqbeIjIw/hopuxJruJ9KHa0gc5pxtvN7PIh9P1neTWYd6Gf9BOyYUK41tyyQfSHlwwKwnqXf8lCrMbgFpWO64Y4PacTXPnEeFivoTpsHP6BrfXH1/NXq1FJA4yB0juBQXTXW6jE+I5O5E8yj+O1qtkoyQ6PnleFEMLgE8NdvNaFGEX/DNBaXrT6JjudXvlmiBmTJuyfCMh3Fl2kCzhi4gpRNk7nLCJGghBY1eCO0Rex0S3cbIR03ti80COc3ssWeYosbG45/6izIaRDTftxb5axG2/8NFSLN7/6s8Q55H81JFSqEbYjTOReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43iaW1hoBi75dQNjNQvdeOBUwJos6d702cZlP91EJss=;
 b=VfAnAe3gC7p67FfNALGiabULqaI5WbamC0O8tHToP7SNk2XyOUPhwmFfOB10SaVamPacS88j7NgKRrNbgMpsSwHjyfnGE+w1LgFWX+tiEnGYa4mIxp40msNMr1VR4OwLY/c4DrRYhdSHZ0HannErHhEK39dx99ES2zvXQb71M9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TYZPR06MB4142.apcprd06.prod.outlook.com (2603:1096:400:2c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 03:40:32 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 03:40:32 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH] perf tools: fix array_size.cocci warning
Date:   Mon,  7 Mar 2022 11:39:59 +0800
Message-Id: <20220307034008.4024-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64a9f185-52f2-410c-e0ab-08d9ffec3b0b
X-MS-TrafficTypeDiagnostic: TYZPR06MB4142:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4142B32FBDB09937E67C1B06C7089@TYZPR06MB4142.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgKlUejYcaFyJLV3EHbHzN2AVNifA6h0P4922wipVY5gtRS+Tn0xLilZfY93/wf8vPUbwOyeKsd5UAtoooofkdrgkfqAUZSi5U+tuc5XF5hhVMpz/2DcLvc703gfwBa5IC5GIUZTB924CFp9zx3NiGENrLZOM/S5SkJknpKq956Ze08MAG6NdXfoqcTQCKHX3AJRuJaqyVQbw1dwjxhKb+b9s3zccwQTvt+TU1Dk56rYlAq7+7yA43CuJA2hQ7sLfshcmRnui7gQhrg45vPQvOtxh+pgFv6TpGBA367xlZUwnQPU9ax8lZEazsqXTGRptaZOnAKgWn3doEyEmDqFDa9o96xQtY9c6WY/h+fCg7XXPu5my8Iz5VxpOuCeBfmhQSOIlPIfuiPFr0MOiiGLDjuNbKWkXE/euqAHDkHQ2nNnxqCEQUCiG4rrKGPx8cbtkJjWKDXDENb7STsb4oHuZCiJnDbKkgEs0bZD+aW9XiB4m0PcU87E7QyzAOd5eK4S0p2r9/ulRDAlODQoAgIeX+0BkX5uNORj3xbERfmlYbi8XUjOdftvc5oVhRIVv7cN3syIakHE5OXNpPumxQncT3oVfKP84hCO99YCDIaB0oPK70i71bsJXU9zb5+0gttTN5STd2Rnb8JlhpHl1yRKTR8kIi3eipgff+KQ5bYEGsTECNl5q/mg1tWR/Q8HH5cbjdmqm1ZmFYXXraJ5J7nvpvmPN+ENYK763pjPPvebUYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(508600001)(6666004)(6506007)(52116002)(5660300002)(8676002)(6512007)(921005)(6486002)(38350700002)(38100700002)(83380400001)(4744005)(86362001)(1076003)(2616005)(2906002)(36756003)(66556008)(66476007)(66946007)(186003)(316002)(110136005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c4j1IlvzPmsViungjSkVoKFbA2z+0VWUuf1VeXH7RRDvcmtq4jUd2cgI1WFb?=
 =?us-ascii?Q?CrRRFcI9ke6qgjQF5bhsE6gIfwO7M+MKpcrqpvjBDsljX2AyDd1zME7NIhFO?=
 =?us-ascii?Q?+t64W/szNRbmACPRhUPf+peZHZw5dOAtJvAPpmN3pNhdKo8OXkQszeYMZtoY?=
 =?us-ascii?Q?fsVlGPXsP+Xm7PtD0So7cjCbN61YaM7m3NqahvnyvU0Xpn9TjrM9J5Me9Xye?=
 =?us-ascii?Q?KVSoRbgUJ2iCOL/r/8S36RHvEFIFrJr+8tHIW4VQ4cwrI10tnkkOuSTL0EJc?=
 =?us-ascii?Q?TPzZet45aFrfbsCCLLYdhIzh9V2Uz+ruud6uBROtN48faI6cBQtyHWxNzowp?=
 =?us-ascii?Q?l/EAUvyfJb+lXljgqa/8myGb5CrNB9xYQEnykRj95vVbx04p/sUTt75K0k6c?=
 =?us-ascii?Q?NgQyVr3rt5sBTK9sWYjyJkhgkiTUG5zEXsKRKn7M9l3YrjyZYssSNViBigna?=
 =?us-ascii?Q?I/8hr4vrbwN3ng/6GebIRo4qXShJHdm8m3uY9yzmpssA2N0Qpdqmc7QNXHkV?=
 =?us-ascii?Q?QSzf+moEYtkQZZC1E6hSIH/aP3Gu5PhNOXRPsbU2N2wE+3hrCL5V+ZB925gM?=
 =?us-ascii?Q?5jT/v11MOIDQ2Dk9dHWXAc06Fs+krltY6888/1I2rCA9INpgdqZ8CDSsB4FZ?=
 =?us-ascii?Q?XVCqrdLkcsxJSGGs77p9TJX3iH0J9DNIt+DOO14ffPGSVWZJRpVw4jkKMKAR?=
 =?us-ascii?Q?c5q+7Sw8OLl0p1tzU4wmxLGIzH0TZAWJM+m0gyvJz+sl7rX+nQafOsMFUaC+?=
 =?us-ascii?Q?p7PbGgFYfno3Liyze2P1I/I6U+a8lKPIvQD1/RyMRilc6SsBko5lzjoy16Ct?=
 =?us-ascii?Q?fAh1xBZm8Bz+lBoUSdQSi6xZQDEQ5gl3xRcj8llUSAKl8Dy+gUA9fsOXCgaz?=
 =?us-ascii?Q?f84OsfwzjzIO6LlS1kiUhx++k9yzx4mj2Guh56+k9Y4lq0qsnIYTG1Lcmmml?=
 =?us-ascii?Q?i0TRZdhfgD2jaInjNT1Eb14vXPTAGmFLQCCT6c7hT5az/BT4FY5jEpXr41ud?=
 =?us-ascii?Q?nZg85NQnjXzeuo6b9AufMhVFlAAabOpnmO5Jgnw4RwlYCeajuKX67XZEiq2t?=
 =?us-ascii?Q?ShZURlxluYbUPtS0Ndfokp1e6QUGVrDrdgTqj+wjZy/6ZnTHakSgCm1dnvrm?=
 =?us-ascii?Q?pxWHWCetkRuPOPJcoC/0SSyq/1umoMOCcHOWpwuT5jtd56Ox61zXJevsg/nz?=
 =?us-ascii?Q?thvvXat452NF7qsNB0+trf12WkGhQ8Kc7dZ/Hem6zwN9FjBITXTplLhjgpDd?=
 =?us-ascii?Q?aq4JDbptOxB/7vB/5J9g8KasgTNK6QYrgzCr0I3QmkwDuKB6do8MIl3ea4V0?=
 =?us-ascii?Q?SzyXwwXW9REWO/GhmsfUvwlMXkM/C9LZW75aKXxuJjCEH+ZczcbpoNfbDXlw?=
 =?us-ascii?Q?PcxRAcPKkrhAHZBNhtP0OZWT/pzCZlNaX/WaHQPMycc2bvsUlH477YKZ1X+y?=
 =?us-ascii?Q?neL7RXM09y/jq8E/7nVXSp0DjMsuEG+HUTjQKSBbwsFUL4gmEJRi+KELY7Qq?=
 =?us-ascii?Q?zkT5bVCbUc1Nx4sXXeoCSacrmpVx5KF8/DLk/NloCdkGQeU958bM63qNxOFV?=
 =?us-ascii?Q?b57HBdRpLL9K/FUVDe4Y1bFfJjXDJJNCF1LW/EEBNKjLazyRUxiUe2fMcD4U?=
 =?us-ascii?Q?xAVNmkCdMax3yQ/T4E8DVx0=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a9f185-52f2-410c-e0ab-08d9ffec3b0b
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 03:40:32.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GlptqWgXjVU4GfF528qEUnuZ8aQ1xCEpkn7fXP4S/wJ+ssCSn0rfdljWSE2YBM2XYhG3bAwfPxlHL13ltQrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4142
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
tools/perf/util/trace-event-parse.c:209:35-36: WARNING: Use ARRAY_SIZE

ARRAY_SIZE(arr) is a macro provided in tools/include/linux/kernel.h,
which not only measures the size of the array, but also makes sure
that `arr` is really an array.

It has been tested with gcc (Debian 8.3.0-6) 8.3.0.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/perf/util/trace-event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 9634f0ae57be..c9c83a40647c 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -206,7 +206,7 @@ unsigned long long eval_flag(const char *flag)
 	if (isdigit(flag[0]))
 		return strtoull(flag, NULL, 0);
 
-	for (i = 0; i < (int)(sizeof(flags)/sizeof(flags[0])); i++)
+	for (i = 0; i < (int)(ARRAY_SIZE(flags)); i++)
 		if (strcmp(flags[i].name, flag) == 0)
 			return flags[i].value;
 
-- 
2.20.1

