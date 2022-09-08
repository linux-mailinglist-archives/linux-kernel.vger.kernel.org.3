Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5AD5B1BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiIHLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIHLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:43:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2103.outbound.protection.outlook.com [40.107.100.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862DACA0B;
        Thu,  8 Sep 2022 04:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBIg7DP1GiAdFNeziptf80E2M1RnzJ2MOQ5gUzugo2G4XS4ON/0bWkbOe1Zxlwz9MO1TI74r75rdBPdKvUE2/vZ2zkWtYN5rS47icicOW+bIhs3L1zHW2wiQ9rEZAODreBAECzGb+fdgNNFb71NZNUflJkXvoS9Bgf1pbOi1ipP5JlI2elMbQYsW9YczdZm8aafoRXHgX7LpDCZpCm19orzcK2//6WRwSUkH2K4VsXoGYTMGkcJSCuv+jybt1/1hvnzBADXFig4QrI/+IS1AjOGXchyDqssOWdO8Gt+GG0+sJefBVhruvaNEj8rsrpA1b8GMDxXGHunQ1pwRgnlahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOoP6zgu5g4F0ZDuoa9OEKup+UjLbJCbuIBpP7pWoVg=;
 b=mKJD1A2B+j2DEqmsrv7Ag7kNxC52SEKlF1kzJ5dsemuklF0wsqCybKL+xLtGAxtaPCwMgzy8xalUK/60PeBushzJNiFxvKcr88/It//kdNoBXSvTOjjv708zjzpAcu8HDWqWs+VvmXavLqKnrHs0j+c2x/DEWTM2H68i1Aq/+vRPns1vvxIp2c5TmFN04PbXFebQyyufvkZhiMj+wThU3ASTLvdyaOUOs7NzrdNj0vfdWczV8t37ZkGE8hvuro0g03dtEifivlaoWnKnFfrpVulzdgdyRytOty+Zz/+jyyP1tQHh30+nNYzUetQXMvaw99EYwKrfAK7OLDoV5JDzBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOoP6zgu5g4F0ZDuoa9OEKup+UjLbJCbuIBpP7pWoVg=;
 b=bqpfKt5EKXZj2CdsourB58ghNFKETMl/6pFNBE7m5oPsomvm+tMASPlbDeRDQHmYDGeebC8RwDrXiRE3jU+b2/V4wz1eenxmDiCORCs/qP8dScQU+VGZIWAT2XBeVRm74QAK+wP2soaMje/SoCcLflmQTAaRfeB/rLTEN+YmpIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by BN0PR13MB4694.namprd13.prod.outlook.com (2603:10b6:408:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 8 Sep
 2022 11:43:52 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Thu, 8 Sep 2022
 11:43:52 +0000
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
Subject: [PATCH v3] checkpatch: warn for non-standard fixes tag style
Date:   Thu,  8 Sep 2022 13:43:25 +0200
Message-Id: <20220908114325.4153436-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P195CA0061.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:87::38) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|BN0PR13MB4694:EE_
X-MS-Office365-Filtering-Correlation-Id: f0194508-36c0-4cdf-8f59-08da918f672d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6CE4l9vI4S6kQyqNQBd64HyKVGA44SmaP1fxK1ZVKeSRm7FomXUGZzJb2Iif1969rUffwF3LeX2spD86EeCaGjmx2TI83bMmOEwcYYAQgfFF30pcovr+p0RyW0zLsXQhYQO6X5kMBTEFNzBFI9oFMBr7hv5154zguAiaZkMGfQqn662g3KH/gcgkvyrtZC4KpaIomxwQM/I12aFJutNqDwAEeM1nC7sN/XXMtMdx2o9be27FBqdG+Dyfb2huQ4foTVJEPfK+3twH8ro7xTgh0AeAzQbSn1IXI1yBrg/QgWSilT0ansRdB2hTZyKJ/PnMTv+8UeGxeoUqyoDiSqH6UftI1iuzPt/7GNYJ6vSqmpA7/zbwvpG9xnvGt6zRuPIzAvNxSb250BVVA1hc/1A1bnOLsLF+aKFDylbl2D71dU2OiDARfc/0LUr9ohfcdpNhVN6WG9y99WJvGz7ixja0+vremPhTv9WL4c7yNVOtqV0kwzU0Mc/7sgjSExte1Q6bx3C88jpHHbU9bWt0t5Z5UvXxks9q5khWoH5f4GFWNJh4avliQrtW+XfCaZJBYp0bC4smE40vKCKcpoI4tPweiFr2kT0HUaq5C5xjydTVVRFsHMGX+3ZPd6I9efryiiZIKBESm4KopSTbZEv25tqm6aN3f1YEsNWT8uGOxHYbNYUCfTsNN3qj2UYQCLTGgfn/wwqvuqnEwRN78A7AJ1eUfP2QC4Jn/6nz1uJ9VkQXeoCiE+DWrWEVUXLwgbgKXu7AvCZUd48Xe//r8UbF1vQhpL6shQTLMEDwKh5ypG6Tbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(396003)(39840400004)(136003)(2616005)(1076003)(186003)(83380400001)(66574015)(38100700002)(38350700002)(86362001)(8936002)(5660300002)(110136005)(54906003)(36756003)(66946007)(66476007)(4326008)(8676002)(66556008)(316002)(6506007)(52116002)(107886003)(6666004)(6512007)(26005)(2906002)(6486002)(966005)(478600001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhyQXlEdmNDeWtVdVZkSXgrRnhHUTc3MmVkbVN5emRDVXd2ekt4WVRNbmVu?=
 =?utf-8?B?ZGwxbUZkOFQ5WDZod0hPWUo4TXBycG5HWVd0SVR4NE1TenZjcVcyTFExWjFZ?=
 =?utf-8?B?L2c5a2pvSy9tMm5wbnJWTU01d2VNcEdkN0srZXNPK0o3MjY2U0pPWFltSnJz?=
 =?utf-8?B?NktOMlFvUng0VWJOT096Z3ptRmJwZWhYT3ZpMGo5c214RDJFQ0p6aGpkWmcv?=
 =?utf-8?B?OXQzWHFJU0tXSGhJWnY5Y1dJek1jUThzNHVVMjVxZzVOR21rUWVWbjJQM3Bk?=
 =?utf-8?B?R1VwY2pTL1pjMjdNNDVsU2R5d3F3N1V1VW9rN2dKL0xDOGZISEordm04YjVj?=
 =?utf-8?B?YVg4SkJiNE53RFNScDBhZjRkNHJFQk1uSFdKUUlOOGt3OCtJN2xtM2RkUEU2?=
 =?utf-8?B?VDJQYWhwQWdIYUlsM3lKWEpxU0tPek1BNmV1NGdNTmUxRjgrYjFha2w4VmF3?=
 =?utf-8?B?bjR2UHFYR3EzekJNd0FOQmxEbkxqYkNid1QzQUNRR0hUdG9EME9JN2drZUpk?=
 =?utf-8?B?cUFHSnFWa29RUllFdUhhUk16eWxJMzVMaFBhbmU5THptNldOMmoxSVVnSC9S?=
 =?utf-8?B?TjlDd0VrdW4vSlY2OXJvQUdHM3ZVWk1NMi9rYTNEYy9vRmgyVFhNb2g5RHM4?=
 =?utf-8?B?dFR2V0ZVbVlrNkJLMjBGUGtLaXVQT1RuQmdFWXZhazNVaVVicHJwaE9lTHFQ?=
 =?utf-8?B?Y3h4MUZVMGJLMCtnbmYyUUFpalFxYXJQUDBoZGYzcDhxK25XR1h2aWN4U2Qr?=
 =?utf-8?B?OThVSmtHbUJ6TThQOUtQQ2pKNHAxc3grMW5pM0Qva09RWkFCWC96UXNTR1hT?=
 =?utf-8?B?UnBYdkM1ZDU3TlZJOWNISUhWaTJ3bmd4KzF5YldsanJFWnE0bC9ZUVpJRVBn?=
 =?utf-8?B?L05xN01tSUlGTStaclZyT04wdVVIai9ERHl3bjB4VGxYV2Z2bGlPWW4vU296?=
 =?utf-8?B?dmhPZWEzc1V4dmNFK2ZzYUV1MGM0dVUwREtIYWxKVldYQ3ZHZmc1SCtsMy9D?=
 =?utf-8?B?VmVWSkhMT3ZxVjUrZ0h4YXFqRmxxRUFnTlB4UG40UjdWSEhYeHRYYWlneXU0?=
 =?utf-8?B?d2Q5cW5GTEZNdW1HWWxBK0YzSXU0VW9BeHg3bzRpVm1VRzNoK2FzNzFhL3RT?=
 =?utf-8?B?aytidmtvZWVCR2tDZm96M0xFZWtlUDlIU0VuWVNOMENqblpkU2JQb29rVWJp?=
 =?utf-8?B?TGx5eWI2OGJ4UjhDak9ST3hLeFMzdzdGbEdtVERHdW9KN0ZqbEJJdnVhUmQw?=
 =?utf-8?B?bGV5eVFYUkx3SzNXYUhRSEVsMFErWnR1R0VDeHNYVk9RSmo2VlRjYkJIcEZR?=
 =?utf-8?B?VGl2Zkkwb3ZXWEF1K0cyWlE0ZHlmTHcxQ2kxb0wzQkRBM3NFTGNkQ21Ydzh5?=
 =?utf-8?B?MVdzaEdlMGNxNndUcnFveHdTcHN1enVHV0lKMk9TcGM4TnNiZ1hVbG91NUV5?=
 =?utf-8?B?YmNOekxJaVYwdy9WRDBPNE4yWjRyOFdUVzFXM05JK08wK0gvTnRHa1R1OXRM?=
 =?utf-8?B?Q3QxemdldFNyQjZ4bHAzZklMc1NIZDFpV0grYzlmVmRCeWdQU0YvbDhWVkhv?=
 =?utf-8?B?RVZBbng3R0pSWnBtYlZobHNibWpwekVvbVR3dGdYa2hSUHhUTGZpalhlVDIx?=
 =?utf-8?B?cUsvcTNxZ2xCUitTSGs4OFhaM28xWm9YZ1BzbUNmRFNaSzlTUFQ0dEhDT1lM?=
 =?utf-8?B?ZXpqTUZNR1ZmUEpFWDd2T1N3YlJIYTE3Tm1NYURFRDNtQzhrZnI4QjJxQkR6?=
 =?utf-8?B?eEt4ZS9SSGkrWE5LbFpvRUt0bDMwbllpdWM3MUVReEtUVWxhYVExUUxhejgz?=
 =?utf-8?B?WE5uQ29nVXFybmdPbitUUUJoQlJURk1RT0Y0U1AxZWsyejhwbTZET21PbWNH?=
 =?utf-8?B?RFhsTkFiNzBLcG43UVQ5bjg2RVhhNUxoZGMzc1Nlb1B0UEdBSWQ1dUJLTmdn?=
 =?utf-8?B?UThvSWVUN1dTeVp2TjlJblpULzAvU1JYdlJaL0p6OG9WZVNaU3ZWMGxsa0Zp?=
 =?utf-8?B?VTZyZ3BjVXNDWW5FZnpBeWdvUStpYVMvTklSZ1NFOUFvTUdxV1l1Y1hYVW9i?=
 =?utf-8?B?MlpkcDNXczBQMk9EajdPSmoyQWNmbVVpbHhDdFM4ZkdtU0l5N05CcUVZS2N6?=
 =?utf-8?B?ZnVHNnZWMlVodHdNWFBhV0RsM29mbFJlRmpaNjRieFczcnFUTXVOSmpDMmJh?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR13MB4694
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
* Changes since v2
- Change the pattern to match on 'fixes:?' to catch more malformed
  fixes tags.

* Changes since v1
- Update the documentation wording and add mention one cause of the
  message can be that email program splits the tag over multiple lines.
---
 Documentation/dev-tools/checkpatch.rst |  8 +++++
 scripts/checkpatch.pl                  | 41 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index b52452bc2963..8c8456a3bd18 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -612,6 +612,14 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  **BAD_FIXES_TAG**
+    The Fixes: tag is malformed or does not fall in line with the standards
+    specified by the community. This can occur if the tag have been split into
+    multiple lines (e.g., when pasted in email program with word wrapping
+    enabled).
+
+    See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
+
 
 Comparison style
 ----------------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..a250bda52c66 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3140,6 +3140,47 @@ sub process {
 			}
 		}
 
+# Check Fixes: styles is correct
+		if (!$in_header_lines && $line =~ /^fixes:?/i) {
+			my $orig_commit = "";
+			my $id = "0123456789ab";
+			my $title = "commit title";
+			my $tag_case = 1;
+			my $tag_space = 1;
+			my $id_length = 1;
+			my $id_case = 1;
+			my $title_has_quotes = 0;
+
+			if ($line =~ /(fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
+				my $tag = $1;
+				$orig_commit = $2;
+				$title = $3;
+
+				$tag_case = 0 if $tag eq "Fixes:";
+				$tag_space = 0 if ($line =~ /^fixes:? [0-9a-f]{5,} ($balanced_parens)/i);
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
2.37.3

