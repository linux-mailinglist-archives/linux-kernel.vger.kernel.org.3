Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC75A50C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiH2PyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiH2PyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:54:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2090.outbound.protection.outlook.com [40.107.92.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FB497B19;
        Mon, 29 Aug 2022 08:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWV3UH04DahhL2WIrGi35+ux2+7fq+VLCt8tljjTcbMrvc/DTDkUf4/4F0qIxQaVx1EyMbJ2RlHhn5k+vKscONgzqfdW2jd28ZAw3JKokAkUhw5xeBkZrfDgKSSOs775ulO0rlCV9YH1RMMlzsEaA8jjk4m9XECGCHdNNgff7UttFtVZi3KsQ9y6L/ci6yGGheZimLnw+89dzxz9CtUVYrfxkaObVxAgR4vKDZccAjCQxv1gy1ljB9lLEiz2+GlKylZNtFWAL3TzA4tN/NxwKMRP+vg7vvgD6aORY6vOJfPxqhB0zqbfuRkLdlYStqdZYZd9KsxHaxNEzUvCFCPLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPx0F3VoRRc6Wt9CRUuOEfwkYIVhfAWfXq+Yg9U5Ju0=;
 b=iNHDRidWutgE7aGNw4CmNSjpfFRm2ut6gkPgv/fhVzU1v3Lc9KUWTr2EgTMgYBRuqLTCA+LynebCfRe6PpFxXzsth33D5WW4r1R6big2vC+Ly0RMkWxjAPxl+DwVqbqzwgoXMStyRABbD4JuuSxwV0t2182TEutCo9bGzX+LrLSCum0lSM9eJ8hXbCzogdGu4wBzy3h1pWKjm8HcHNReone0ELcIiPlAbJZimwQ6BIeKh36wuy2YpwFQxpaLlZtJrMkos5Tng+YwnrjgHFr6wSNV9MjaJotT5G18FWrl47S6TfUNOiIIKC1cjSTifPUWoX2U7U0T88cX1/WESHDWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPx0F3VoRRc6Wt9CRUuOEfwkYIVhfAWfXq+Yg9U5Ju0=;
 b=kIzppg7SQJvlcCNHebGVUcguhz16vSjuku4y0SyUfH9GatWX3mvV4OHFM5V6SyjhrSssgEZMdcR1kYjUkEUPDXRTSAYpdav5p5g3pb4CvGG3W+RzOQQpiSPFwaMGRjUKhp5tz5I0+f+PRZWytMZ9D0bGrcsDSAWI+d7ERfWf5N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by CH2PR13MB3605.namprd13.prod.outlook.com (2603:10b6:610:2c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 29 Aug
 2022 15:54:15 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5588.010; Mon, 29 Aug 2022
 15:54:15 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: [PATCH] checkpatch: warn for non-standard fixes tag style
Date:   Mon, 29 Aug 2022 17:53:58 +0200
Message-Id: <20220829155358.2546732-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.37.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR04CA0063.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::40) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc920175-50e8-438e-e23a-08da89d6b95b
X-MS-TrafficTypeDiagnostic: CH2PR13MB3605:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QufVHZ4fxIu0SJXaERvZUeKPayJywCLGvEVIdXTHX5VEAzTbuCYPmcgkDPx8r95tMMN1ZYFlVqIoKAEZoZz1HKPupTWhkNTHoonsMmcZlhsGyQUKLcTWBaXkEhnnBXgvPTl7Nnlx6LRMYCofYaqJLbm0W2Y272K03sVaFIJrtejAhgcqEQnwEt06Obo8w570HMVj0HCvvAh2IxPkJSUhdeHxWNrSWgyy3t7mUUs03nR/0DlmHUEEJNSqKBFtJpQw+SID4Mdnd8B3Tl0UlDuknY+MayPilq0NFuoCKSVW2VEd7wbY58iQRC67Pfkhl8aWuhU4vLQXtpU23vvIW0a1+5599J/vd9htjIZWSwkQ7vs89tZkSouM/4+2BP/y25qMAiau8bLjkekB+0L6zhKf96EpToNrI/LY9UcMw6bTY/uZntYAFe6Yf2uxTdB6l5Q6O2lNTId3DEVUavwx9DHwU0RztslDaCHnZbblO6772jKKk+52g7JkoZ/q5mWjZDcMvbdWuoXtFqpADT6pjNltyO8yqrtczT1Tib60OKfE282mowyD/8g5JdjxtlZEdZ0QJRJezR+1k5WH35SIvXrO/pGEhwsKVuCCgPiCpK8qDXaAj7Vf9Apibffenhwt+JssakZYkTE+diUSwqJRcosPsa4Mh2hymF+zucDpOIw8cFUDbMDisajjD2IY7RitFCsfUsTpJLpwmUnzI6I662byowV/HavKu27unmM+WzlcianNZ+HdObXNV+QDff92xv+9w6sjagCYkKZi6or4DpyN6KzxYbP/16DmYPrYLfR5xa/CTj5QcEV4PpocDElTAiRIy2eKryQsfPHdRetaRw0mhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39830400003)(136003)(346002)(366004)(376002)(396003)(86362001)(8676002)(110136005)(66946007)(66556008)(66476007)(54906003)(4326008)(966005)(316002)(6486002)(5660300002)(8936002)(478600001)(41300700001)(36756003)(38350700002)(6506007)(2616005)(52116002)(6512007)(2906002)(26005)(6666004)(38100700002)(107886003)(83380400001)(66574015)(186003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWFoVXlIalNYMXAvdlhnbVcwQnFrUTAwZVk5Y1RyVnVIaUtEeWlUc3BoZS8y?=
 =?utf-8?B?MTRlZjdJcU84MURVRmRyYjRsRENwOUxuMktMbkFleTMzcCtuNVVsdmszbFgx?=
 =?utf-8?B?QUd2MnNqS1VwMU01Z3MvNkVVTEVodUdibVpxSHlTRVNmRzZzODVrNFhhMDJU?=
 =?utf-8?B?VHZVa05BUEFxa3lBZ0duQU9uZVVVbzlNaDFkbzNCaGZHdmpKMnRzcU9IdjhQ?=
 =?utf-8?B?K1ZwbWVKVHNvTDlPNXZaeWhMem0vY3kwOFY2c1BXbSs4RFN0VmhSV1dObTV0?=
 =?utf-8?B?dTdCMFNUY0ozMU5CSmQ2d0p5YlFhck91ZytDcWNRd24zV25Zc29KLzRDYkpB?=
 =?utf-8?B?VWNvZmIyMGVxL1hSeU5iVS9jY2VZN1ducTRXa3AySGpGK2t0dmxSVGRRdjBQ?=
 =?utf-8?B?ZnVlZnpnNExMQnVjaEJVMkZXYnNudXNkbElrcVdkRWFPRmR0b2xnMW52TEFP?=
 =?utf-8?B?RVd0YXRLbXZpKy9RM2pqRXQ4UUxOalNFSWhxNG85T3ZJd1Z3MkR4TTlPTVFs?=
 =?utf-8?B?bDhjYzA1RFV4Q0VaNWJreW9YbmI0NG5pR2J6MG4vMVV5WGJ6TVRqRjc2TWll?=
 =?utf-8?B?ekUyZXhxTm9jVUR3TFJZWHVJK1VmRCtKRmN3WS80S1g2UXVWU1hOTGZqYzZD?=
 =?utf-8?B?VXdRd29Jb2hmeU4wd1pNUEwvNFZCSDBlbHoxMjBPVCtkWlFLZXV4K1FMTlZi?=
 =?utf-8?B?SEFVTVZqN1NRd3RRRFNWeWpLbnhIUVBPVCtDUkFWaU5vWFBOaWJia1J6b3Jm?=
 =?utf-8?B?T1hOZ0RJS2RtM01YQkFOWG9rNWNuRXR2YmZiVUxzSGorRnRtRmNzTmpYYlB1?=
 =?utf-8?B?cTJkaG5DZkxOcFBaSEhJSGpYUmJaRnpRdlE0VnFSdFN4eE9hR1ROQTRDV0Nk?=
 =?utf-8?B?cFMzb3M4OHFTcVEveXdVUlQ5bDJLb0JETU1yT3VZV3VESHdmREdCS0ZueXV5?=
 =?utf-8?B?ZUh2TzMyd0tCa05Bd1VZRFZjcDlxRjlPWGkrdkFWUjdiUUhaNis3ZXJuK0g3?=
 =?utf-8?B?RktrU0RBWVhnTURtMDJDcmIvZ3JYQ2RKTWIwbmlZUXlMZXlaWGhOVEtXbjU0?=
 =?utf-8?B?MEhFeFE0MHNOenkzblFLYnh0Y2hweXVMNDI0Y3VOYk1PdWcwYXB3U1UwSGxn?=
 =?utf-8?B?RjMrWk5RWTNnUmVXVGd0clRHNlVvVXhwc0UzRldTb0Uvcmt6dzRjRzFyQXpj?=
 =?utf-8?B?OEJSc3NBMDczQzFOSG1HNlQ0b1RzMUhNcDJkNTVDVkhhOERqUXZyNkZZTkJp?=
 =?utf-8?B?eUJpSkR1bk5NV2tic2VUYWZrVk1EUytHNi9IVWM2Y2xSQ25WRHIyTHcxNWdM?=
 =?utf-8?B?L2I1TDdIbWM4VHlyZXI3R3hhM0VXSVo5SE9hRU1CbGcvYmR1eEN4a0JpaWNZ?=
 =?utf-8?B?SmM0S2JMU3UvNU1zU3lkQURlSmNoZkg4RWtEUjdudkpXd08zSEFZbHBoOTR0?=
 =?utf-8?B?N2Zhck5WZ0pocDd1R1ZBWWxRSWQ2YW5FMTVLems5TkxqeXp4M29wWmhqUzBI?=
 =?utf-8?B?ZWhyZmJrM3VQMWRvVmFsd1kydVBuSHRkZkYzMFRBOVVRZTdSN2ZxTy8wUnN6?=
 =?utf-8?B?a3lmQU9GUDFiK3hDSTBKLzBnRlVMVXorR2ZMSkFCaUtuUzhhbFZwZW9OcXBS?=
 =?utf-8?B?RUxGRjIwV3pNU3B5Z1poRC83Y3h3cnJvZCt5WEV1OTNnSUZlWEptTGhlSGZs?=
 =?utf-8?B?TmRyOXZ0K3hCWVB4bTlEdVZvakFWcEd6RUFYL2FMVThmTDk4NmZXa0t4SjVY?=
 =?utf-8?B?YUZNeVVVZnhRRFBKM3ZTcXlFSmxCOG91TUpTUmt1NUtVWmMwWHdsVkRZclYw?=
 =?utf-8?B?SEVzaXc1b2pmdEZtU1ZEa0d1a2dZZ21vUGpmck9PUXhpbTVwT2dhdDNORFYx?=
 =?utf-8?B?bXZJM1JjOGlKNHArOEU4QURUd2ZlR2FrQWtQcnVqNS92Qk9tRGI0WXI5UTVS?=
 =?utf-8?B?RTFSNG9yVDFpRlQ1Y01OOTFrY3FWdzBvbHNaTHlKcncwVkxhbXVETC9lWFRn?=
 =?utf-8?B?QWxzM2k0U2JCOTAwS09mejVVZ284VWRnbnlkNDNiTEh1QmlHS2xIYVpva1hy?=
 =?utf-8?B?V1JWU3VXNmdLVGVqbkhEMWxZTUdqNDUwNnlxYUpOb2NWVVpyRTJZSnlNMHZL?=
 =?utf-8?B?VFY4RVN0T3lvVjF5MSthckVNSXYrNVl6K2VJaG9ONTBKODdyOE9oNEFjczVE?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc920175-50e8-438e-e23a-08da89d6b95b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 15:54:15.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EotWf5x9gvek1PczoXnKjtBdSyf1GDiQYQDT2E9LMuvVEK/TfpZoQu63GFAQKzEwO2fQXOYWos+g/2aVYZy0zCjaEtLEuRH8YDYL/EOaCM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3605
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning for fixes tags that does not fall in line with the
standards specified by the community.

Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
---
 Documentation/dev-tools/checkpatch.rst |  6 ++++
 scripts/checkpatch.pl                  | 41 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index b52452bc2963..8164f362a2fc 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -612,6 +612,12 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  **BAD_FIXES_TAG**
+    The fixes line does not fall in line with the standards specified by the
+    community.
+
+    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+
 
 Comparison style
 ----------------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..9b8cdc582fb5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3140,6 +3140,47 @@ sub process {
 			}
 		}
 
+# Check Fixes: styles is correct
+		if (!$in_header_lines && $line =~ /^fixes:/i) {
+			my $orig_commit = "";
+			my $id = "0123456789ab";
+			my $title = "commit title";
+			my $tag_case = 1;
+			my $tag_space = 1;
+			my $id_length = 1;
+			my $id_case = 1;
+			my $title_has_quotes = 0;
+
+			if ($line =~ /(fixes:)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
+				my $tag = $1;
+				$orig_commit = $2;
+				$title = $3;
+
+				$tag_case = 0 if $tag eq "Fixes:";
+				$tag_space = 0 if ($line =~ /^fixes: [0-9a-f]{5,} ($balanced_parens)/i);
+
+				$id_length = 0 if ($orig_commit =~ /^[0-9a-f]{12}$/i);
+				$id_case = 0 if ($orig_commit !~ /[A-F]/);
+
+				# Always strip leading/trailing parens then double quotes if existing
+				$title = substr($title, 1, -1);
+				if ($title =~ /^".*"$/) {
+					$title = substr($title, 1, -1);
+					$title_has_quotes = 1;
+				}
+			}
+
+			($id, $title) = git_commit_info($orig_commit, $id,
+							$title);
+
+			if ($tag_case || $tag_space || $id_length || $id_case ||
+			    !$title_has_quotes) {
+				WARN("BAD_FIXES_TAG",
+				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $id (\"$title\")'\n" . $herecurr);
+
+			}
+		}
+
 # Check email subject for common tools that don't need to be mentioned
 		if ($in_header_lines &&
 		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {
-- 
2.37.2

