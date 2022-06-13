Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF65482C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiFMJGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiFMJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:06:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2091.outbound.protection.outlook.com [40.107.94.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6562CE0AE;
        Mon, 13 Jun 2022 02:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEOU6C+/qDmVH1hHokWeYaHeDtAp7D/z3MMTZWkN6LQhK8XqbODJBDORXkZvOffC9QC9sxFiciR4GOHSBF32F9W/vqGxDoZLMaU67BH3uVd0qmFSchEfHHsa8i44T1g4wG0w998sb7HFebt65eiFGRIQirSX7RKebnsdexLLk8JYyG5FqBEdlUN/lDvORBqgyZL02qf7GndYjDSKM+OovtEdl6arRzAFPUCyhOJWT3evYdU08C2K6hB8yeQtdzNx3kqBp1mmEJ9p4d3fPR6KIsOohn4HAd+qkvy5sbWnh0uwsBTX0QAMORKFF7VsOQcFlgUDKGnuJQYzMh50MEqm9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJAVKnxSXvgRv/gceeEvzZhk2k4rf8+I3Jn4MLt5dUA=;
 b=Q8DYe5HSYfLZWQdR2zhmJaH4bb6/cHt/tZZXM5JHSdGarrkg6luGUdr1YSo8IrisdVITLlM5lUyQRj0myoUfNdc+OoradBdn3lqo6tLjElAJJ4gJzbxAAryX1tmW7DBKTKXAaHJ/qWNLkakCh93a/p/qPnjkdTEXek1w/rQyufBtzkvpeyiemp/IUdJ6Y+A7XIKGT2wuf6R5x1FIWlv2zi1ql1V/fKPOKOxNyD9aFIDx/YIMBbeEoexvOXmKVDj3vmjo+gKFqLRA7JcZoZr8Fx88BpTdFqp0+kyn8A6rBoMaNBVJTQnoaBz/DDr8vW+NaiWYwxMCXtJfP7jqaUjtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJAVKnxSXvgRv/gceeEvzZhk2k4rf8+I3Jn4MLt5dUA=;
 b=Y46oZtIOGgbTGjUpXE3arQUSHnN9g/pUffgEad0WoJvhWVfGKgQwIG0ffstcP7imqZ75d97PdE0lGJWwUtMTdfJRjy7kh5aEOmPIktbdT55mtU/LRcVngsTZn5wbUZ9ntH/MRegoCuY8w4um+mhPKckK8FwBy4Y5mLgELK0rQuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by MN2PR13MB4104.namprd13.prod.outlook.com (2603:10b6:208:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.6; Mon, 13 Jun
 2022 09:05:58 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::4d5f:a0de:1d6c:1bc9]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::4d5f:a0de:1d6c:1bc9%3]) with mapi id 15.20.5353.011; Mon, 13 Jun 2022
 09:05:58 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
Subject: [PATCH v2] scripts: kernel-doc: Always increment warnings counter
Date:   Mon, 13 Jun 2022 11:05:10 +0200
Message-Id: <20220613090510.3088294-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.36.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR04CA0068.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b::10) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68b5d040-e2f3-4e11-d554-08da4d1bee0b
X-MS-TrafficTypeDiagnostic: MN2PR13MB4104:EE_
X-Microsoft-Antispam-PRVS: <MN2PR13MB41041816314E4F9425D26037E7AB9@MN2PR13MB4104.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XFhOQ1Q9UeYSnaElgElSbZKpOuBMhRm5jgvTiNpMqX6kBQlW0/jJeTbFGtiTqA7hky0PhHzqsnnE++qxxi2S12KIfUtVXmIhpTK1bcxEWBhThWkKPRQNuLfzSnl3Z1n2BHg/sidKoNFqSun3X3kg+UY1AYeYmzckpCf0C47f3S3ckxUVcCi77uXIhZ0EStgr+8kJTGqLOMMy+9c8ufy4GiauiLHDDIwC5UZCg3aDPJ7hVeItxGx3qn8ULH4uLmhGm9vHDZ2cMuV/k9BQFisDK8rNXT+IIouTGwt6uEghQH+kfwi1gd7Bo2rBT7NcH1tVZxbTyzAYTX8OhR2g0xSxxCe61tWFFYUk1E9VcK+19fVjhWZ6MPE2yPV5T0HqP0Wpij/0dnNM7GmIeolREKfG64ilkLG8Pl5zQLFF0TXG7HvpS1f/sGFSroP1YcOezYQevg5/pKGK8c2wQP9Az618R+qCLmPxNdTjXjpH4uAsO1vh/Z2C4ux/OYajpJRUXIYWUlHqpx1FPAzUZQoaUcVN/J3PvUhLQCrXIaU5RqD/WC7y8YTaJCkNN2ns6JFCRZfTJc+bFDAhNMl3IfJy6fzYYllm/s4Jskx6OjHFYn9Wvz+0nHTvqSU5nzQ1FwfeQPUi9ZrS/X9VNIdcfCtLLKGJDQuSdFKBLoYn3INEJfuwxeSVWsK6ZDJKQVoZisAbop3XRsk98ez+iixlDvDmMxZSDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39830400003)(396003)(136003)(508600001)(83380400001)(5660300002)(6512007)(8676002)(30864003)(66476007)(4326008)(26005)(8936002)(6486002)(66556008)(66946007)(107886003)(52116002)(6666004)(38350700002)(86362001)(38100700002)(186003)(2616005)(316002)(36756003)(1076003)(41300700001)(66574015)(6506007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm5rWmFZR3VXTjRvUXVCeWN1bTRxWTdzZUM5ek1qVVp4NUsxbUF3M3BKejVo?=
 =?utf-8?B?OWoycjRNK2s2anVjSHlzY2pTRTVxZUdIUlpHMWtQU1lGT05zcHFLRXkranpJ?=
 =?utf-8?B?N2NoL3JPeU41U1JCeHF2T3ppTFROdDFaNTU4Q1lURVJGWFhreUxScG5xaVZ2?=
 =?utf-8?B?UXhHSEQwSWYzWWxkdk82SFpMUWtSdlRDVmNYNkxRSUh6ZFNrMmpDeXRUTjF6?=
 =?utf-8?B?UW9RTVU0WWlLdFhHRnM0S01MN0NJVFJwRlFiV3JlVUlJQVlkMEZrczhSM21r?=
 =?utf-8?B?RjI4eXJobnBzMHNFWFVCdWJGUDJWNm00SzBQcjN2RDhSZjliZmdwcDB3Ui9M?=
 =?utf-8?B?aUl2U2hmbVVKNWpQQVYyMWlSN0kwL3c0RzZ3VTlXSW5ZWC96Z2dGa2kvNlZa?=
 =?utf-8?B?RmExTG94dEhvVVQ2VDhLdVV2M0NmNlo5emJMMnVKU1hKbkgvKzdVVW1TQnN4?=
 =?utf-8?B?MWF1clhFNGhoWVhOWGpQUnJtMWR0MURvQzR5MS9nMlRmcmI5clhTN1lLaUJO?=
 =?utf-8?B?SnFMQ0p3TG14RGxXY3d6VVplTWlodllIZGkvTGVBNW1BYVBydlNlQVEydVhE?=
 =?utf-8?B?VEg3NVAwc0E4MGRKa1dnUGNsRzVXUzBBRFZCQlhtSUtSLy9ldEU3c0xjSkNQ?=
 =?utf-8?B?ZHNlQnZpTlI4TXVrajdDOWlWZmtSVGlDQzlpdWpCeXdVb3MvOVNxZkFpRzhF?=
 =?utf-8?B?bDNFeS9kVm1iM3lQcWJ0cmR1RFVOd1RDaFNMVXgxbS8zNzJ2S2ZBVjhIQVJz?=
 =?utf-8?B?NC93cVZDWlVySUNHNzJtZzlDUktwTHdKU2NKZWxDdTFaN251TmcvNS81MHkr?=
 =?utf-8?B?c0Jsc29xSjNjZnYrM0IrYm1RY3pVeU1tQk0wRGxrUXNUVEo0N2x0YUZJV2RR?=
 =?utf-8?B?NHlKeEQ0cXBrTXpCWFFuUkRLWjRmZDBlZjUrb2toNHBMSlc4cmJScnZYVm9H?=
 =?utf-8?B?OFJ1YjA0UGFZZkhlK1EwdFAyQ2M3cUtoeHRTVzBQUzhVTlVPcnBoQVI3Mmpm?=
 =?utf-8?B?QVhGdTBCQjNpWmZOak1QMkJVQlFxL0xTdE4xMjJzOTROTUxwcEJPaDB6MFBr?=
 =?utf-8?B?ZEZiSHBvYlZ6OG93V1dsNlIwQnprQ3lsQTRPYVFjZ3ltS2d3N2t6QlU4ajQ2?=
 =?utf-8?B?bjc4QjZRK0hLM255dEZOUmNYUXZZMFhBSWl4Z3Q4Z0ZORW0vVkNpZGt3bElS?=
 =?utf-8?B?ZWEvZW1hQjJ0WEUzY2ErRDRET3RmOVhQQkNNVEpqUkRkcDRHZld2MGs1UkhE?=
 =?utf-8?B?aXlqcmdVTlpReWcvMHh0cy8wbmlQZWJKSW8zazA0Zm9qR25YeEJORStJRkVI?=
 =?utf-8?B?ZlU4TmVyR3VKVDZtbmZUNW1ZbkpyS1ZrODNDdUlUMU9KQllBUWRZNkp6ZS9j?=
 =?utf-8?B?SlhWYVNnd09VNURBM1ZKelVsaFRHUngzV3VacnFTVVlueUVOUzRjblZZdW91?=
 =?utf-8?B?SE9LZ09IOWVrYWdlaDJjSExLZ28xZlNqUEFpUkU4OEJudHJGY3dHQVJBckJ0?=
 =?utf-8?B?MEtwZDBYcHBHV1hWZ3IzSGZ2MExkc1RaMHB0M1ZqVnRKOE1PekJDV3A1c1RD?=
 =?utf-8?B?RDRmSkp0TGdHcjRsMEwrSHh4SWZZbml6MlZVSmVtaDRsNkZ4QkRaZm5qaTdH?=
 =?utf-8?B?UHRPNTBpKzJSYlJUTWxINVJtcWd0UmpySW4vbnFsdlFMaTA5cnJXcVI4TVVo?=
 =?utf-8?B?aWNrV08xVm40dERtUUlKYkMzOFdpZTVxOENrYTNaOW5jdWtxbTE1a1JJZzUv?=
 =?utf-8?B?YWYzMXVUY0ZRNUVJTE9vLzZlY3V6KzgyVWlPOVkvejFBcm5BNnRGOE1aY0pF?=
 =?utf-8?B?Z0VDNnRrT0c4UGh5KytYc2FISGxCQmFlUGh2dThmM3d5ZU1UMG1SOVd0VlJJ?=
 =?utf-8?B?NksvM1lYRXlkRXpraFVWd0tXcy9oRVdHaWtaNUxSRm1GZ1hGbXBkYkxzUTU4?=
 =?utf-8?B?OXBKQVFySEVPYXVIQ285cm1zTGZyaEtXUldYU05qN3RvVm0zVTRqc1B4ZzA5?=
 =?utf-8?B?TjVyRGxkTlB0S1lDbHdaa2kzclpQUWZEeWNDSXJZaGc4V2QvNWI3aXR3dmRx?=
 =?utf-8?B?WGExakJIc0hoTHhuNjRoeGhlamlVTVk3dlAzd09KK2JOQnpndUkxRWo2R1ND?=
 =?utf-8?B?T1FWNmZTR3YvSTFSKzh2ekZlaUpmdVdiaEN5aVIrVkRWYkk2VGluc0x5elNL?=
 =?utf-8?B?Zmd2QVUyeDRMUTVzRCszdHZIWWVsaWliYUs2VklRcjlqdUNsc1ZiR0JGL2g2?=
 =?utf-8?B?Rk9VdWs5NzN2VDhRT2dGUGdZUXhON3ZNakFJVXdqdEJIZEw2UVpMdE9NWllR?=
 =?utf-8?B?SXBDVFNhOHBIQWhaOFZ1SEM1WHZZNGk0T1VRZ1N4UU5vVmdRWkU3TkwvTm9L?=
 =?utf-8?Q?+fyFxhxX0QEoDwnw=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b5d040-e2f3-4e11-d554-08da4d1bee0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 09:05:58.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx7OXNJZli0FbD9qdoWiXrN5bP17+Gi/DOzVSJ7e82Pp6jUaOJmN7edg+n5kB8bSc8q1b5tFddmJWbZCfzL1d3kKkJMzGtuZELIjAhJ+tEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4104
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some warnings do not increment the warnings counter making the behavior
of running kernel-doc with -Werror unlogical as some warnings will be
generated but not treated as errors.

Fix this by creating a helper function that always incrementing the
warnings counter every time a warning is emitted. There is one location
in get_sphinx_version() where a warning is not touched as it concerns
the execution environment of the kernel-doc and not the documentation
being processed.

Incrementing the counter only have effect when running kernel-doc in
either verbose mode (-v or environment variable KBUILD_VERBOSE) or when
treating warnings as errors (-Werror or environment variable
KDOC_WERROR). In both cases the number of warnings printed is printed to
stderr and for the later the exit code of kernel-doc is non-zero if
warnings where encountered.

Simple test case to demo one of the warnings,

    $ cat test.c
    /**
     * foo() - Description
     */
    int bar();

    # Without this change
    $ ./scripts/kernel-doc -Werror -none test.c
    test.c:4: warning: expecting prototype for foo(). Prototype was for
    bar() instead

    # With this change
    $ ./scripts/kernel-doc -Werror -none test.c
    test.c:4: warning: expecting prototype for foo(). Prototype was for
    bar() instead
    1 warnings as Errors

Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
---
* Changes since v1
- Added a helper emit_warning() to print the message and increment the
  counter instead of adding statements to increment the counter where it
  was missing.
- My Perl is not the best but I have tested the change against all
  warnings but the 'suspicious ending line' warning and there is no
  change in output format.
---
 scripts/kernel-doc | 82 ++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 47 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 7516949bb049e39f..aea04365bc69d386 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -427,6 +427,13 @@ sub print_lineno {
         print ".. LINENO " . $lineno . "\n";
     }
 }
+
+sub emit_warning {
+    my $location = shift;
+    my $msg = shift;
+    print STDERR "$location: warning: $msg";
+    ++$warnings;
+}
 ##
 # dumps section contents to arrays/hashes intended for that purpose.
 #
@@ -451,8 +458,7 @@ sub dump_section {
 	if (defined($sections{$name}) && ($sections{$name} ne "")) {
 	    # Only warn on user specified duplicate section names.
 	    if ($name ne $section_default) {
-		print STDERR "${file}:$.: warning: duplicate section name '$name'\n";
-		++$warnings;
+		emit_warning("${file}:$.", "duplicate section name '$name'\n");
 	    }
 	    $sections{$name} .= $contents;
 	} else {
@@ -1094,7 +1100,7 @@ sub dump_struct($$) {
 
     if ($members) {
 	if ($identifier ne $declaration_name) {
-	    print STDERR "${file}:$.: warning: expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n";
+	    emit_warning("${file}:$.", "expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n");
 	    return;
 	}
 
@@ -1298,9 +1304,9 @@ sub dump_enum($$) {
     if ($members) {
 	if ($identifier ne $declaration_name) {
 	    if ($identifier eq "") {
-		print STDERR "${file}:$.: warning: wrong kernel-doc identifier on line:\n";
+		emit_warning("${file}:$.", "wrong kernel-doc identifier on line:\n");
 	    } else {
-		print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
+		emit_warning("${file}:$.", "expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n");
 	    }
 	    return;
 	}
@@ -1316,7 +1322,7 @@ sub dump_enum($$) {
 	    if (!$parameterdescs{$arg}) {
 		$parameterdescs{$arg} = $undescribed;
 	        if (show_warnings("enum", $declaration_name)) {
-			print STDERR "${file}:$.: warning: Enum value '$arg' not described in enum '$declaration_name'\n";
+			emit_warning("${file}:$.", "Enum value '$arg' not described in enum '$declaration_name'\n");
 		}
 	    }
 	    $_members{$arg} = 1;
@@ -1325,7 +1331,7 @@ sub dump_enum($$) {
 	while (my ($k, $v) = each %parameterdescs) {
 	    if (!exists($_members{$k})) {
 	        if (show_warnings("enum", $declaration_name)) {
-		     print STDERR "${file}:$.: warning: Excess enum value '$k' description in '$declaration_name'\n";
+		     emit_warning("${file}:$.", "Excess enum value '$k' description in '$declaration_name'\n");
 		}
 	    }
         }
@@ -1367,7 +1373,7 @@ sub dump_typedef($$) {
 	$return_type =~ s/^\s+//;
 
 	if ($identifier ne $declaration_name) {
-	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    emit_warning("${file}:$.", "expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n");
 	    return;
 	}
 
@@ -1398,7 +1404,7 @@ sub dump_typedef($$) {
 	$declaration_name = $1;
 
 	if ($identifier ne $declaration_name) {
-	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    emit_warning("${file}:$.", "expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n");
 	    return;
 	}
 
@@ -1554,9 +1560,7 @@ sub push_parameter($$$$$) {
 		$parameterdescs{$param} = $undescribed;
 
 	        if (show_warnings($type, $declaration_name) && $param !~ /\./) {
-			print STDERR
-			      "${file}:$.: warning: Function parameter or member '$param' not described in '$declaration_name'\n";
-			++$warnings;
+			emit_warning("${file}:$.", "Function parameter or member '$param' not described in '$declaration_name'\n");
 		}
 	}
 
@@ -1604,11 +1608,10 @@ sub check_sections($$$$$) {
 		}
 		if ($err) {
 			if ($decl_type eq "function") {
-				print STDERR "${file}:$.: warning: " .
+				emit_warning("${file}:$.",
 					"Excess function parameter " .
 					"'$sects[$sx]' " .
-					"description in '$decl_name'\n";
-				++$warnings;
+					"description in '$decl_name'\n");
 			}
 		}
 	}
@@ -1629,10 +1632,9 @@ sub check_return_section {
 
         if (!defined($sections{$section_return}) ||
             $sections{$section_return} eq "") {
-                print STDERR "${file}:$.: warning: " .
+                emit_warning("${file}:$.",
                         "No description found for return value of " .
-                        "'$declaration_name'\n";
-                ++$warnings;
+                        "'$declaration_name'\n");
         }
 }
 
@@ -1714,12 +1716,12 @@ sub dump_function($$) {
 
 	create_parameterlist($args, ',', $file, $declaration_name);
     } else {
-	print STDERR "${file}:$.: warning: cannot understand function prototype: '$prototype'\n";
+	emit_warning("${file}:$.", "cannot understand function prototype: '$prototype'\n");
 	return;
     }
 
     if ($identifier ne $declaration_name) {
-	print STDERR "${file}:$.: warning: expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n";
+	emit_warning("${file}:$.", "expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n");
 	return;
     }
 
@@ -1801,8 +1803,8 @@ sub tracepoint_munge($) {
 		$tracepointargs = $1;
 	}
 	if (($tracepointname eq 0) || ($tracepointargs eq 0)) {
-		print STDERR "${file}:$.: warning: Unrecognized tracepoint format: \n".
-			     "$prototype\n";
+		emit_warning("${file}:$.", "Unrecognized tracepoint format: \n".
+			     "$prototype\n");
 	} else {
 		$prototype = "static inline void trace_$tracepointname($tracepointargs)";
 		$identifier = "trace_$identifier";
@@ -2027,22 +2029,16 @@ sub process_name($$) {
 	}
 
 	if (!$is_kernel_comment) {
-	    print STDERR "${file}:$.: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n";
-	    print STDERR $_;
-	    ++$warnings;
+	    emit_warning("${file}:$.", "This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n$_");
 	    $state = STATE_NORMAL;
 	}
 
 	if (($declaration_purpose eq "") && $verbose) {
-	    print STDERR "${file}:$.: warning: missing initial short description on line:\n";
-	    print STDERR $_;
-	    ++$warnings;
+	    emit_warning("${file}:$.", "missing initial short description on line:\n$_");
 	}
 
 	if ($identifier eq "" && $decl_type ne "enum") {
-	    print STDERR "${file}:$.: warning: wrong kernel-doc identifier on line:\n";
-	    print STDERR $_;
-	    ++$warnings;
+	    emit_warning("${file}:$.", "wrong kernel-doc identifier on line:\n$_");
 	    $state = STATE_NORMAL;
 	}
 
@@ -2050,9 +2046,7 @@ sub process_name($$) {
 	    print STDERR "${file}:$.: info: Scanning doc for $decl_type $identifier\n";
 	}
     } else {
-	print STDERR "${file}:$.: warning: Cannot understand $_ on line $.",
-	    " - I thought it was a doc line\n";
-	++$warnings;
+	emit_warning("${file}:$.", "Cannot understand $_ on line $. - I thought it was a doc line\n");
 	$state = STATE_NORMAL;
     }
 }
@@ -2071,8 +2065,7 @@ sub process_body($$) {
 	$section =~ s/\.\.\.$//;
 
 	if ($verbose) {
-	    print STDERR "${file}:$.: warning: Variable macro arguments should be documented without dots\n";
-	    ++$warnings;
+	    emit_warning("${file}:$.", "Variable macro arguments should be documented without dots\n");
 	}
     }
 
@@ -2101,8 +2094,7 @@ sub process_body($$) {
 
 	if (($contents ne "") && ($contents ne "\n")) {
 	    if (!$in_doc_sect && $verbose) {
-		print STDERR "${file}:$.: warning: contents before sections\n";
-		++$warnings;
+		emit_warning("${file}:$.", "contents before sections\n");
 	    }
 	    dump_section($file, $section, $contents);
 	    $section = $section_default;
@@ -2128,8 +2120,7 @@ sub process_body($$) {
 	}
 	# look for doc_com + <text> + doc_end:
 	if ($_ =~ m'\s*\*\s*[a-zA-Z_0-9:\.]+\*/') {
-	    print STDERR "${file}:$.: warning: suspicious ending line: $_";
-	    ++$warnings;
+	    emit_warning("${file}:$.", "suspicious ending line: $_");
 	}
 
 	$prototype = "";
@@ -2173,8 +2164,7 @@ sub process_body($$) {
 	}
     } else {
 	# i dont know - bad line?  ignore.
-	print STDERR "${file}:$.: warning: bad line: $_";
-	++$warnings;
+	emit_warning("${file}:$.", "bad line: $_");
     }
 }
 
@@ -2268,9 +2258,7 @@ sub process_inline($$) {
 	    }
 	} elsif ($inline_doc_state == STATE_INLINE_NAME) {
 	    $inline_doc_state = STATE_INLINE_ERROR;
-	    print STDERR "${file}:$.: warning: ";
-	    print STDERR "Incorrect use of kernel-doc format: $_";
-	    ++$warnings;
+	    emit_warning("${file}:$.", "Incorrect use of kernel-doc format: $_");
 	}
     }
 }
@@ -2319,11 +2307,11 @@ sub process_file($) {
     if ($initial_section_counter == $section_counter && $
 	output_mode ne "none") {
 	if ($output_selection == OUTPUT_INCLUDE) {
-	    print STDERR "${file}:1: warning: '$_' not found\n"
+	    emit_warning("${file}:1", "'$_' not found\n")
 		for keys %function_table;
 	}
 	else {
-	    print STDERR "${file}:1: warning: no structured comments found\n";
+	    emit_warning("${file}:1", "no structured comments found\n");
 	}
     }
     close IN_FILE;
-- 
2.36.1

