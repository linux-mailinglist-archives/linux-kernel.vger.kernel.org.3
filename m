Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D304A5AD0B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiIEKxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiIEKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:53:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AA154C9B;
        Mon,  5 Sep 2022 03:53:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq3mz1OwkWYU6zEH3ziTJhkZuk89lB6lgIUm05VUAPGcbcLkBqQ60vnYsBM53KAMQ1wKLOJnqpFTorJfrZOhkFfcZel7liuxCC6CwqpvCZiYG+ZqNeX52bToBwdCVJoP1DO3/OoobPOQpb9EqyWz7BnBaE0BQh/ONnByY1C29wzdnz3jc+H/OnRNOAc69/oWYAgmNHwqZYdpMnu2swiGMW5JZtAD2qLjV6xMk+SnIuLDPlt5dc0d4h7XvDIFbj6Mnji02qs6bWkDpUwpQS/rEcsTK46AqxrNQmL9f1rw0Zf/9pp26cayW0XG7xB8oil5kmZGI9RCr/Jxu0sj6kTCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJqSnvbGTfrUGeH22QXM5Kx298LBGYtbvzK1tU5PDZI=;
 b=bv8L0VxmROm0ev92eAGdTfME+gYhGS+IMFR3U3sS+bkaE3W36wtNz7bkxKae4lIZjd3UF6NfgWBfnx4e7gg31gbyD8fwQ5Q46oJVkahkobte/MafUFb6ooTDGfCUG7Zu6BqQkVzIALKHjxPhddDwj72a3VOgl3e76OaeavsWPtTqsxvKLCyw/O5ze7R2Psrk2lIAF76mi4QKGdAeDdLpqZ6c86tK1SP4jAPoGHg3+9VMGYgaYSl1uKQrCFNuneVsCVGXrNV9Ypc0TFXaN8rqxXNeAWWYwqO+HCO8XbmTWP+dsb8DbzSWWZ1tg9XIy0XkCTjHL7uGso8IsyPgVl2ivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJqSnvbGTfrUGeH22QXM5Kx298LBGYtbvzK1tU5PDZI=;
 b=B6Q9JDRHX6KhEllI7tF794jyN/y2VBAH6Sqj5e8p4ZuWq4FgtSEkSGWQO4lcnjqZpkJRoCneK9hq8cuFP8n56tSXp6mzmmIE/t6fDftOCzj93aCrBPcZDLt60gF9kgMQlqWvbhAGJmCOll34Li/TvlHzkBSP4csnqs4rJzt5s5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by DM6PR13MB3803.namprd13.prod.outlook.com (2603:10b6:5:244::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.11; Mon, 5 Sep
 2022 10:53:29 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Mon, 5 Sep 2022
 10:53:29 +0000
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
Subject: [PATCH v2] checkpatch: warn for non-standard fixes tag style
Date:   Mon,  5 Sep 2022 12:52:47 +0200
Message-Id: <20220905105247.920676-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0104.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::45) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|DM6PR13MB3803:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfd0405-d4e2-4e71-1b07-08da8f2cddfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LItGbQynWW2DFcWyfJD4cXXQGhSdFLzMXjlDUHGxuNNLyyvMLzomU+SGq0U8pMP9m6Z1snSpPE/kIOf1i3o0USbEW7gdCj/4wfNVUvgXqWf2UgYfN/ZKr0VmEl7OOJLfp/H6+G4Mo2Fu1nKszz3T68p5AfDha3FABmY0c9+VuBjT8C0dIiYN+5yZu+ABzK28GHXylZ8VhOLsLbG6h/3hV+ZzpcWiCUgQIpsXru9G3aNppP+n/W6KM1bQZWMlo1NHRTD5ZZGBtkrU48a9HL5LD1UYZY8fn2QPOLw2JWsGLNkT9d0o9BpWWNfJC2pdZMVtjPmQyZHJbCn48VcTGnSUBPXJYHv9JldDwDU29FimEmt7pQdKnfAV/hvpIPX1fQAOqaay4YGIPWZ9Z2wt5hfOH0CKzyTtLvysqqNECYztMZ+q/MRcBi1/P7UHQSTM78DmNZzMyXYWnnnGiRbXELlml6W7KBuRRL8Rijby1ZbuvCj3alqdHsAzlCra4K5H9dhob90Ca4t5q9MzFnwcMmEhg67BUF/N4/V1asxGwCHs6wDruoorukkD99PRvGLvTX+8pBl0wUoBOxEwxCHqwU7S6qGrDznahmxe3qg3m9GQ17LgBl0PDsxE20p8KhclR//TPjAZQrQUivCEwRTURcYlW1iR2e4SZtcloHOUSRdCzXkbWbuY2Jo6T24QmxBUgnUHJjC5kERuz+5+zKtESSBfIfuz+bwazoWv+5GBdzvYuGAiWTqNIAdmzDSkZx2uygDLP3/EKX8W9yrimCJOddBhB2EhquIGiYel0Xa+isqA0Ek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39830400003)(346002)(376002)(83380400001)(66556008)(8676002)(4326008)(66476007)(66946007)(316002)(110136005)(107886003)(41300700001)(6666004)(54906003)(36756003)(86362001)(26005)(6512007)(1076003)(2616005)(186003)(66574015)(8936002)(2906002)(5660300002)(38350700002)(478600001)(38100700002)(6506007)(52116002)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGxDZXNzNHpMN2syNlVQR2kxNDdpMFlWb0t0SVRkM0RmVitaRmRvMk91UTFp?=
 =?utf-8?B?U0taaFZnQVJPbjEyU2pRcXF4dHFwYkFXNjlvd20xc2hXdXJVMVlyWGtUb054?=
 =?utf-8?B?UStGVlI5NklaMDJVa0dWR2tGTUxRTWVGUEpPRnFGL2ltSjZ2bGZZTTZ1czZP?=
 =?utf-8?B?VFdYb01ROGZXM1puR0NDSjNCbUprQ3FPeVk5SyszU1pLN05IU04vZy9vVElt?=
 =?utf-8?B?VW1ndkthMVQ4ekFUVXFyaVlSbDhFOFhqRVR1SjdBUHhETE1QcjhyaHdDZ3E3?=
 =?utf-8?B?b0RDY3ZNMExsbTVwVG8weisrd3YzOVNyRTQrblpid09xbWhBaTE5cVhlRm9h?=
 =?utf-8?B?VTZCS0ZhRXVtZllYa1ZYcjhraGJIb2xzRVl5bThIR0I0MjdNTXdIeHBlT3ZN?=
 =?utf-8?B?b1VqeHBaTk55OEt6cHAwOXc2WWppOGYwMUU4OUZxQVNrbkJjRGY3SmhQY2lB?=
 =?utf-8?B?bkFSZCtsVDMxWnFCU24yTWF0L2FCTkVKLy83Y21LdWtwYjUyM25uSUFZMkV0?=
 =?utf-8?B?L1p5dVEyNTdUNHA2Y2RYMFJVVW1JT2RKcUtzMFE1bEZYL1pXYjk3bU82eUZx?=
 =?utf-8?B?YTAxcFpZR2ZXbXllRTlkNVk3RTRMcWdiQTgvcnY3WGNKS3NwbmpiUXBJT1o5?=
 =?utf-8?B?UTZOSGp5aXAwS1BnMzZkVlNWWERKdENONEhPR2R3VnlXMUNjYWs2MC9LNE5m?=
 =?utf-8?B?VFlXWU1Tb2puTlRGRUo3ZHEwT0pacXJVSE9YZ1o3RitWeVFPY3AxUVNUNkxq?=
 =?utf-8?B?RlJOR00xVjU5alJlOGthallQQVV6bzFxeHo0Ky9ZS0J5WjRtRnRwR0VxYXY5?=
 =?utf-8?B?NVY0RzVlU21Ob3hpSVhyVmpxUmd6cGpuZnNmNkVlOWVBeEFCTUpTWUNwSXZs?=
 =?utf-8?B?RWpEMUFtaEg4RW9va2tPenJQUGtWdmdzTFRsblppZFM5ZDJ0R1VIemRJS2hY?=
 =?utf-8?B?L3dqcDhnZWhCQlZITnpkTDNCeU8wNERMaVNOYncyd1pFZk5YK1B5R0tkNlNi?=
 =?utf-8?B?MkE3QXhockZvZFYvMGVEUHBWck5vT3dUWmVMZ1BrTTlmYWN0OVkyRUFDOWk0?=
 =?utf-8?B?WnVyWDlqZ3hEelBMOVZ5cTlqR1BjUkNsUkNNYzY5Z0RQM0x6MGNYZHY3S01C?=
 =?utf-8?B?aWVuQ1g4OFhKQUg5Q1VZN2hLdTBESzhiUDdBYkhhc1kzS0xndkFPRmJxT0Yr?=
 =?utf-8?B?Wnp0OUxmQVJBY1k0UFJxV0RtVDFuUERMMUtoR001c1FQU0lWNFVzckZJOEw4?=
 =?utf-8?B?cXZoc2cyWEVRcmIxTXZBZVF2cGxrQXQvTWtZUXB2NVNWZjVjSUpuRmsxRzZD?=
 =?utf-8?B?Mk1ZLzlaLy9VQlVXaWVUamxkcEZEWERrWDQzczVJRWZTTXVsVFdYd21JdHV4?=
 =?utf-8?B?YytoaXpCa01CR003WXRkZ3ZZMkJXS1FFZFc1djhWYXo3d0diZXZVSTQzMFYv?=
 =?utf-8?B?aDJZN2JKa3Vmdnh0aGR5b3BhZGRvR0lucUJNRHlwcjdnS2dxcXFGQUdkQTZV?=
 =?utf-8?B?bGJlVnhTVkdrbmdXek5jOTd3M3VqTEJHRWd2Z1Jod1B2RUsyK29aaThmL2Ux?=
 =?utf-8?B?dW9QRkN4STUwNlJvMFdGWGJJclkzcTRmU0pFTmY4OGZGMklOclgzNUhQWklD?=
 =?utf-8?B?bDJQZ21DMFhPVFN3WlNhUnlxR0YrNUdoeHVpM3dueUFpMGlMY0NJdW5vMWdz?=
 =?utf-8?B?MmR2dG1CczZ6OFZuZ24rODFzckdQWGw5dWJRVGovNzRVMHFoZmRtTTFxZjVk?=
 =?utf-8?B?cUt0WWZDYVI3ZG9TTHZhVkVwSHBiNU5SWkVJUVdheTI3VDQrbHBMaDZXZjBO?=
 =?utf-8?B?MUIxb3hFWkY2OXJ6cXI4aU9taEN4NDVkTmdQaS81Yy95azQzdXFZcEladE5D?=
 =?utf-8?B?ZmtTbFZOZTdablFZR2Z2R0hwYWtWQ05MNjFLcTlWMTJjR2svR3lDUU42YnFp?=
 =?utf-8?B?eUk1Sy91VjZmbDIxa1BYU1hLbUt0cm1DZDhNeEFuTFhTb2t2bms3SDJtRTlj?=
 =?utf-8?B?MW1hRzhsWVlvMjdlYk9CSmNLRSswVTZ5RURBOVErTFNIdVlHVlE0engyLy9T?=
 =?utf-8?B?QlNNclJVK0poSlEvRUkwOXBCd3Y0UlVzYnVoTklmMnI0RHlwWFZIT1hmKzBp?=
 =?utf-8?B?U2VjcnJBS3U5TERTclNzWFFwQWlGNzZ6TnhOcjJnb1RMb09kQzYxTmZQODRh?=
 =?utf-8?B?cmc9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3803
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
2.37.3

