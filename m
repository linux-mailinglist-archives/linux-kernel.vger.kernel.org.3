Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491725B23D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiIHQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIHQp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:45:57 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C550CE125E;
        Thu,  8 Sep 2022 09:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqVtUMIqdhA6hgMawLNF0KNbJYghJa8QahDihnsk0CJiC9pIhW9kQEgK7GGt1tLOMLi/3EEg2pjXxhoYRoA0E5tVOWmAK+Yl3t0vFDlEXxvIMAuxiiEwl9eCiomaD7dEdVMKMG56YdidNPaaQ7eAMkbPtwRRujGX+fYFjcEvppz1MMrC9ePoFJzdUQfe9+LuGshG1XGz47V+qeceRsAqHWpMQtgP3p+Ti1v1XmWZioiLRYCv7X+wceTBeTJc/e3s5XOWY+ZLTo+21phdgjLtkELzdMwvhB0QzxpowIMFX8ptAJr1Nnl+xT1f+daxv4KBpapFsrQhRPUvafXC4Wd3Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gUyqhuY3XQ6oB9MBb/zcuTON5i8WkICgpkZtDmDuBM=;
 b=npPkFvRSBMizpu6MTNvcXK5ph7b7aKvmRAWyJKBiwrHFwqNwf9bH22Ynn3WpsLQOGRJYP4wd8ZhRmoOscaqGQEuXjojSpqZfkQnhAQsCdCNo2rMEkQKgYie0VYhXpOqNJDI3p1eizd3KdK2KEfnDWfopgJ+Ht325wHeBjZ/HsmFWk2Ld52Y8iVgSlkY4Mlfvcb+V5Fe3m2iFxETtfJXf7w5aur9fcfSF5HKfDQZe95asYB7LXA4tEPImOCpWS5OXJDcD7S2tob61k1zm9e0guFDzxVz+3pSglBS2b4I9XrYd2ORnZzN8GYVgrEHKVNYhyHR4IoyvL5DYcpbhzV+ysQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gUyqhuY3XQ6oB9MBb/zcuTON5i8WkICgpkZtDmDuBM=;
 b=Kxiurmi5vgFNNWZCiSIJJMb7Y7IBLZNQ0iXQsSPBDLVXMXG775+af1/T6hAQ6LBxTsIpN5YzOPVaij1aHn7cMw+MfLANCQlM0fjnWfzT/JQraSQFlEGpvBCr8mF+36JL0/19RSzCWGIIM0/U6mYwwfvGyiHhqYfgmFB9M8hSrUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by BY3PR13MB4978.namprd13.prod.outlook.com (2603:10b6:a03:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.4; Thu, 8 Sep
 2022 16:45:48 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Thu, 8 Sep 2022
 16:45:47 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>
Cc:     oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: [PATCH v4] checkpatch: warn for non-standard fixes tag style
Date:   Thu,  8 Sep 2022 18:44:34 +0200
Message-Id: <20220908164434.122106-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::21) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|BY3PR13MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e086abe-0371-4fe8-d467-08da91b994c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHEcLZjF9pyOsh1xILsCXlc/V4rZTFbvc8k1bW+aEODHfQJS39ofsx2L0jxAUpg+KGp/1iib5RR/tTnpQK3Jz1UMqBZNMfdBDCv2xfCFCmzwT+qw5ZEXxlZHFej4Tr7Lr/MvGXlxTqJ3JK0bzPA5/Wef6kckraXtIt6pu9oFzIvPMv4G2dftyYNOXd/r3RmKfWStte58zST4Nd21uAlaYnS/+9tjQFDDDtDaoUY2fd+BtUYbfep0fdbCuq7RIaTmyxZbeDSGn0pskes/VCL681uxVxVmRYDH3PFKJmr9Jjo1MmQTb6/m0iNmoB3f1AQTa6omtUU0pSHAGOCrJF2NA1LPakui2P6hZioTTwW4WMxapkHHaJJaoFYh/KQNEpJJOdC/MMfUZEsnKS9at1K6lwxCRbDPzk2g5Z7Pvu/aL9WZg2q3Ixm/wmVUTvsNZ3pNUcGkQ2WQXofkJ0UHNMxDjtkJ98CKsp3J9S/WjD5QohKWhBPDfwBl8LALJesK0nk2YX019cDm8FIMb8aH4uZUDeZ3nM5PM8g4d9bj4dSZnGoPhHNts5z+0rcGNyd6qPZCKniFNkDXcNOFfv7/2lStQp0yA5Q+k7RCLbsZUYRDY6RIypcLJOTWIhutSqnpVXT0Vp7mT5offu2QLv7kKTsoW6Ld+2mWSakJOiM/1IZ+svI+dyrsZmNptyisrksktBM2G4xLlCwluwah/ucoNuIuekomyOX/KhW+tIFU1k1t30f6woxZ8nfae4LHrn7i9iw9ztbGmlRbCVlVPe5vrLhCjCLp1OvB3Xbrq8SJTml8axM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39840400004)(366004)(66574015)(36756003)(5660300002)(38100700002)(1076003)(186003)(2906002)(2616005)(52116002)(6512007)(26005)(38350700002)(6506007)(966005)(6486002)(86362001)(316002)(110136005)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(478600001)(8936002)(83380400001)(41300700001)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFYTVJDL3U2bFRSL0wxWkxvaHVEbkJFSklBZnNvcG9NanFFZHp6am9XY0lO?=
 =?utf-8?B?Y1cwL0szZi83QkMxV2lITmdHNCtjTkpRRkVGQWh6M24xNWdkSjF6bEw5ZmQz?=
 =?utf-8?B?NWRYcldsZXF3UC95VzFLQUhQSFpPdEFyZWt0R3pNdlJpNUJibXRhQVZ5MmRl?=
 =?utf-8?B?cHNDR3cxcE9VdTFmakdDK0FncmY0dmxlUEYyTHpja0ZWUG5JTnN3ZkRxNXpW?=
 =?utf-8?B?bjd6ZGMvYi9xai95TFlUWkFxS0hGekwwTjNNVk4yQVV2a3gwbTA4NXdZZi9n?=
 =?utf-8?B?dUJtY3BCWU5Va2FpRUtveGtuNi8yTC9XTU9QdTJhVzl1UmtYWXBGR0pValRF?=
 =?utf-8?B?QnErYmdJTVp6SElVOWdJVHJtaXZOUnFiS2JQTHo4SnNSUWVON1ZrUnBkYUoz?=
 =?utf-8?B?K2tkTDdxVmhnOXhRSjd5aU5YWkFySEtSaS9vSEZqLzJ6WVJvNjkvU1NnTTA5?=
 =?utf-8?B?QTQxcWp6MjBnMlh3M2tMQmdFM2YxTnEyNk1DSlJJZVhwLzhOWmNuRnBwcVRY?=
 =?utf-8?B?akxkbzZlNWw0d05MSjBYK05sbE1SbTBjOFdiNTJhc0NTUjdxTENsbTNLM0Rw?=
 =?utf-8?B?cEd2REFGY3VaakpNUlRaU3lxOW1kOFRkWUVBTWl2UnVJQ0Z1T1F4Rmx3b1Jk?=
 =?utf-8?B?dXhkRUdUWUJjQW9Na0lwTUpFNnBTZHZvYzNkaDJlQVB5Wkt1blZRanFnVkdv?=
 =?utf-8?B?T2hjMHozNy8zRmZ6dHA5UUtsNFo1bkJZaGJXcXYwd1Y2NDBzWFI2bDlsSTd0?=
 =?utf-8?B?emY3RDBwUE41T1hwQ0JNNXRKRndVei9DbCthcGpPRElEY25IWDVxTlMvSTZD?=
 =?utf-8?B?c2ViL0NCckxBSlpjTDNIdHhsbi9tWkdqSnFNd3o3YzJoTUZaeWpIaFhLY1Z0?=
 =?utf-8?B?anBrVEg3bFFIMHZLdVo1azlxWUFnVEVLNW93ZHQvSzhnb3lzbmU4RS9mTy9p?=
 =?utf-8?B?OFRzKzNXTHRpa2QrdHd2ZGlDTk5XcHdDR2FLME9rRUhYdTMyWHpxNGZ3OVQ5?=
 =?utf-8?B?TVpZZExqcHJENGVkK2d4Wk5ESHV3TkZlL0Y5OWh2U3laWmJWWmlnMjZLUVor?=
 =?utf-8?B?Ym4vUzJmOWVBZmlDU2FEN1YxZWdCRGlyZGMwL2tRREN5UllEOVc2M3ZRUnhB?=
 =?utf-8?B?WFRjYk4wd0E1ajdka3VzMnVIWUt1NDVBc2NrbEl4N1cySkkxV3hZL2xXNlQ1?=
 =?utf-8?B?T3Z1OWw5OXMreHplTzNIUmZDcm4vaVp4ZDI0Mk5Tam5RL1ViVUhJOENZZ2pG?=
 =?utf-8?B?dkZQWUxJSng3VGhaQUdzRmt5QTNNVGpEM2NBN1ZHaEVXOW1aT0ZiblMrcE52?=
 =?utf-8?B?ekZNcjJzTEFiKzhNWXo5RmtjaE9TbXJoMnhUMTYyL3phZ1VXanhvUnNYSkwx?=
 =?utf-8?B?Tm4rTEhZaEJGM1pBRmhYbWh3bElqUVc4Y3Fha3UySGdITW1SUURXc1E2dFN1?=
 =?utf-8?B?SmV1Ri9PeDA5T09RV243TlFqNEY2MjRocStYdDZSbGdtVk0xR2pwSHh6aldP?=
 =?utf-8?B?STNRS0NoNHc4YWRkZWR5cEJvVERRQmVUU0FFWW5vcUIvYmg3dS9vNm5NVW9z?=
 =?utf-8?B?UzYzaEdXWklxNytkem9Ncmg2ZEFuenNaV0l1U2pkbU8yYW93SERQcTRSUHh0?=
 =?utf-8?B?Z3BBQjF3RElXL1VCM0hqSmx5OUtqNWpyZmhBZFdJZjFQcmV3ZWNvamNHSmRJ?=
 =?utf-8?B?ZWhva1BKbWhEc2ZVZVBxS1JTVTVkZnc5QlhlREVVSnJHRUJVQmxqMDdIV0dT?=
 =?utf-8?B?NUtIeEFucDBySEkzL09DNk9oY1VzMVkwd3VzTDdENitTa3liYWVndGhqazVP?=
 =?utf-8?B?NjhPTlgyR3MxampQVzFMR2d2Z3BLTXdwMmhjbDVValFLYS9wTzQ1MGc0OHlW?=
 =?utf-8?B?TG16NEk0eVJ6Vndjd1ZPVEVtVUVhUERqSGRhNDVwTmE1NmhzSnYxV2xPcjVZ?=
 =?utf-8?B?ZnRUSkVEaG5udTcyeDgzSUJKdkdyWkJ2NXZHeUEyQWJqVzArY0hLQVpyRTRy?=
 =?utf-8?B?RWs0b1ZiMmpIWi9mT0RPUlU3U1d3TmxsQnl2YWQxODBQTnpkTE4vb1A4VTVw?=
 =?utf-8?B?alFqY29yQ0ZNZXh6eHBEc281WW91akwzTmVqbG1yZkszVU1SanplVnlWRVlv?=
 =?utf-8?B?K2lmMERaWFJCTklTdGl2VXg1NHRFWHlHaGp2MEZSaitUdTdmdm9xT2E4VVhq?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4978
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
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
* Changes since v3
- Add test that title in tag match title of commit referenced by sha1.

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
index 79e759aac543..ac7ae2e4a1d8 100755
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
+			my ($cid, $ctitle) = git_commit_info($orig_commit, $id,
+							     $title);
+
+			if ($ctitle ne $title || $tag_case || $tag_space ||
+			    $id_length || $id_case || !$title_has_quotes) {
+				WARN("BAD_FIXES_TAG",
+				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr);
+
+			}
+		}
+
 # Check email subject for common tools that don't need to be mentioned
 		if ($in_header_lines &&
 		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {
-- 
2.37.3

