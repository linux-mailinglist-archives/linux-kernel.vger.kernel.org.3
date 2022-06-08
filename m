Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAAB543285
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbiFHO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:26:43 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2114.outbound.protection.outlook.com [40.107.100.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D11CF154;
        Wed,  8 Jun 2022 07:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4vhsCA6aWuJDC4ValfM9tN0J2QLvxx5Kg7Q+mHCamzns36Bal0aqHWvNL5IckguzvjFRkADq1VCJPaCf7plsw5j8TfMnsn5PsKX5JIxbQxhvX0hVTyp2cImriF4778czQYZeAg6tQrGRiO/ddVjrgAu9bkqkR1gKeLqxRjtDw23dYB53nEVUQhUZNi/6TtIhtVS3OixK8nD4kUFHnlp6lBmErWW/2OgO4GuylW0pGYMVc90Eg8i6Zu2wzorAVNe05IKD17VNbxYTfI5HkeEUkUENCkLhDm+ZcETgh+vnT+nMRsZEr3Def5QCd8H0Kj0UkOEoosU48vxybrnvxOpxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ptdwhEzdlfdFKXaSlo5QtOvL0x/AzbbVe4l4DK2CS0=;
 b=P6S2l6Fa/i68sPi491c5ozziaLuIDlV1pLlTChNUqIsn9jTubdqZX/NpyJtkp5qJONadgCtHMxDmz2F92QrSuiEyerwiBf1HLWeACIjbavJQdyjxCFv62ijquFuV1oDQNwuq+iqqSbQQAQprR87wu8h7fkYWLXEdhXKqPialWudD1KTEwsXvIfpkoFsYdcpHtDmC0RXi328VYIN9pjYsjlZJBft2rRoeDPVEP6w6R3Lz/YPBMKhsI7xwKsitlAZCVdiBLo5Sea2jgUloPr5G2rO+KO9cUPjQ7E9cwH0fyLSUE+nGVnEJ8SAJg1N9zS6X9ChVlrscEGg8XS/n4NynpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ptdwhEzdlfdFKXaSlo5QtOvL0x/AzbbVe4l4DK2CS0=;
 b=RAWfsAA3rkIztUVLlptBstNYYK3aVLn0rWs9B3u4OOm7GFXM/csyFBayASrRgotMzGa85mQPHnMLr3DykNnzRUjnRcgAGIeEb6uOfAoXjdYcdGwsLTmo68MfDeoSNU9J2cYK0kN64Ib3pHThnq1oxS/387aSn28J6wEVI/xzzec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by PH0PR13MB5697.namprd13.prod.outlook.com (2603:10b6:510:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.9; Wed, 8 Jun
 2022 14:26:37 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::4d5f:a0de:1d6c:1bc9]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::4d5f:a0de:1d6c:1bc9%3]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 14:26:37 +0000
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: [PATCH] scripts: kernel-doc: Always increment warnings counter
Date:   Wed,  8 Jun 2022 16:26:01 +0200
Message-Id: <20220608142601.832926-1-niklas.soderlund@corigine.com>
X-Mailer: git-send-email 2.36.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0602CA0022.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::32) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4eba852f-8382-4313-4943-08da495ae59c
X-MS-TrafficTypeDiagnostic: PH0PR13MB5697:EE_
X-Microsoft-Antispam-PRVS: <PH0PR13MB5697F6D7276407D15B2FA25AE7A49@PH0PR13MB5697.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YXirDJotddtLnoRa5eGopJ53DQ0IRyD9eMIVu6J1mzFKJ+2xBkZRZW1b57+jtmF7uoWmW9QbxH+g4MruEVZYl/1grNhgHBQfYh/0hstszUJgrGh3/vyUpx3etNk4rx6tH2R/rM/hZGx/M86qFjQ1lqgcYigcsBgnYRlF8ENCcvUIQj/YJ32mVLSib2AtVZJQQ6Sv2TgyTWQFKmd3KObqi3xE2GyTZ0hJlrTWdue960cF2qdIruf6zeagRaa8Npacd5GK5SF74eirplcbcPgvDO+JfymzAtlh5NrYnrhsER5R7GgkTsoSbjk813hQ6LfVC/VtFdfmVqqfpzFKgthlf4Q6vLmlLtsDXI4hJ39OhBnzsDRhn9DpUYXDARFOPAtIzmwnaY0Ok4lPdps+PaPWd0H9vuNCf5o2fxJ9CSz/tyHLPnl9LD4j+4GfPQH4BY6MS4iJBt4tlxbNgq1aN0LYgmDHpI4hQk6cK4HYkUjoHPNEjIByQMojpnrq0/wdoj+Aok6aMm4+2Xgb8oFxtudzaNQNZpMwzBxA81IOf4iWwg8g5sCahqOyHlJvXArof/ZOq78IajNyb+eOEPnMFFXKqWE0o9UPbqsvHglRUBTUUBEZvK2hFYXQ6HT5xP4wXbG3PBKwZ63TgGkASi6HYdnysVp3kWQwHS7U5z+gBwFX0Y/G6VnNP/CvMr4XwbwkcVLUJdcPyZqrVo40PBa/VmrZ9ekxaxoEtUshf0EwC4JJDM0E6rfnZ69z5DVAftNvHXq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(346002)(136003)(396003)(39830400003)(36756003)(83380400001)(38100700002)(8936002)(38350700002)(508600001)(8676002)(5660300002)(6486002)(6666004)(4326008)(86362001)(66556008)(66476007)(66946007)(54906003)(2906002)(26005)(316002)(41300700001)(6512007)(186003)(6506007)(107886003)(52116002)(66574015)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dYQkt0TGZNaDBVdTg4KzdYbUhkd00xVlR3RlpIc3JPRjBEOWk4dFhUMklB?=
 =?utf-8?B?MHU5a3lxYWsyZlAzelgyNGtHTmVpS2xEcXNhbVRNQm5QSFpCK0UzTXhaS1V2?=
 =?utf-8?B?ckVWSVhxSU1zSlhqQTlITjZWN3luM2h0TDdDVHpiSHY4Uy9wei93VDJLSE1o?=
 =?utf-8?B?QllKMU9GdUlSLy8yYWozaUZqRWhtRHIyTEwxM2crRXo2SHZqQmhrRDBndjBQ?=
 =?utf-8?B?TkV1Ylo4a2t0MlNHMHpIQVlid0JISERycThzd1BIdTBYOWFNam80aGdFdXRp?=
 =?utf-8?B?UFFyZFJ4cnQwSEgyR24vbjFYdXZOZlB3cGxOYllndmVubDI4Ui9UVWFpd0pv?=
 =?utf-8?B?cXBXTDQvOWw3ZEsvaDZkcUJybmJkdW1YckphMFd0Qm1uN09EYk43cnYvTlFv?=
 =?utf-8?B?S3J6amJVbExjdENBUVdFeElyQStjQS8rcldjM2NjbDJNRTlBSSsyT1dtNjhq?=
 =?utf-8?B?KzlvQjR5Y1o1NmNmV3M3bzIvdER0OXB5a2JQWFZsV1RpTFQ4N2djNUNsRlBV?=
 =?utf-8?B?TUYwcWp1RmpBVytkN3BMTXJ6Q2ZUcjFqTlkrWmV3SlhwZ3J3dDRna1NsUFpu?=
 =?utf-8?B?YWdqdzluY1lVSkxxOTFPbC9JRnhSZFg5clh6TjFocXdkd0U4K2xBeXpncXg2?=
 =?utf-8?B?ZFhqdFVVMzNWMlBtcE5SMnEwQklKelhjM0M2K1NMRExhb0loS3RWTlZsNUl2?=
 =?utf-8?B?MDVkd2piTy9IWjNKS3pLanRlSWVHNW5EVkF3ekV4TTFQbEF0NDlLcWRDT05q?=
 =?utf-8?B?RDh4TFhpamxWcVBqM3dEek1jRWdYZW5ldHJqb2tzL0pPd29LUjJPVkhtRFhj?=
 =?utf-8?B?bXVOL0lSUHBnTkh2eUNPNnZZTnNTQVhvUlhzbFdZR2tlazh2UnZDWXJtR09r?=
 =?utf-8?B?eHhpa3J6T2UrRHp5MlFCUDNCcWpIZTFUUUtvOGprcnFxNERkL25HMy9Temxy?=
 =?utf-8?B?WE03T2FsTU1Pb2tzUmI2N2VQREtjV0ZrczBUeHJtQ0ZBdkdHZWRYaFFWUjEr?=
 =?utf-8?B?S0RaeEhSSnZtM1F2K1ppZWgrancwRDhmSEhKaUwvVFBmdUIwb241YlB4QzJN?=
 =?utf-8?B?bXc2OWxiNSs5UHpzNnpiZGp6TENGVmJlSjNIYlM3R25LSjh6M0FGdVVwTW5k?=
 =?utf-8?B?cXcyd1pWOTZXb2MxbThiV25PWHRVTVNrbFhLQit5VlRYNEU2UGR2STFhMlB1?=
 =?utf-8?B?YTl2NWhVcHNlZDZ6eFdpYnlKci9seU15UlI5QVp0SXYrQmlxellBbzZycFNH?=
 =?utf-8?B?d3Fpc1J2UnRtOGJyaFVwMVVwOCsvblpEbnpSdDh3VkJLYXE3TmMwNlpYWDln?=
 =?utf-8?B?NkhCVlQ4eEpkcnlUVEVxSjM0TktmZlg3UmJwbDdlK1BRa1lNSjY1YmhGUmQ4?=
 =?utf-8?B?Uks2TC9vUjBzVTNtRjNwMjRiYk5HMTIvYUZwNjJXczNzT2UvaTFtQUNkWng4?=
 =?utf-8?B?ODROMmMvc1p4d0xJSE9EQjFJWnBKd0dkVzFBSGxuY0lHN1ZZYzcvTEZ3RklW?=
 =?utf-8?B?TnB3ekM4MDd1OHRZazhMOU5CUmZaTWRUWkxSQ0RQcjk0RjJPSmNWcUVTLzZo?=
 =?utf-8?B?UmtVenhjM1MvSUFlNGZzbXgzZkcwZXlZOS9sMnFLSU9NT0FuOTB2bUswUmIx?=
 =?utf-8?B?cWlaNWJGRGVydHRPa21SRmRGQ3U2QXRSbnlaZFQveS9zMmk1OVZnOVhITTk0?=
 =?utf-8?B?M0E3c3RyR3NHdFJORWUzanJVUzAydHoyZktsVjduQ251TmdlU3A4MUlRNFE4?=
 =?utf-8?B?TFFzQ01jc2k0V05CSjJOVnRxSkozWWxZQUlGcit2dGI3YjBUQzJ0UEdacGVp?=
 =?utf-8?B?SzlSUEV0cXkxbFlNZENRd3VBVkJBeEJ4aW1YN3lKa0piREFKVU1WT3ZEaFoz?=
 =?utf-8?B?cVVkWjhNSzdDZjBvZ1BuZGhOTVNPa0NLMDlXdVFIU0FITjZQU0RUY2g1dFd4?=
 =?utf-8?B?ZlJjN0p1MTNtZWZiSXFFWW9BT0hxOGZmaXZNVnFVaUE1QlMzd29BajN2K0VR?=
 =?utf-8?B?enlubWVtMUdvaER0REtLRXk0VnpDc2RtS3JwTUVweVdhcThkZXB4OE1KQVMw?=
 =?utf-8?B?OCtTaUtuakFFMHRGMkZCT2dQSWNlNnBudlh6MDFVaTdQdkpRUnJsRnhkSjlG?=
 =?utf-8?B?clRwTXlvSDlwK0o1bFQ5N3UzRFhOQnVtTDAxUTkwZE9JSHZYVTg0Z3pUNnky?=
 =?utf-8?B?TXNWSGgrQ2c5Y210aitFa1p0VWFBdnZ5eHZERm03NXd3MzIwTFNwclRhaUVG?=
 =?utf-8?B?ZEVSRSt0ZWh4eE95YWE3aW15eUplaTlhNFZiNE4zMVVzaHpNdlBFRTc0d29t?=
 =?utf-8?B?VlpvMGZGb0hra0duazA0MTNBZHNSajh2eG8zY0NyYnZaM0ZzRmZEd0Q1L3lK?=
 =?utf-8?Q?S1c+Kkec92QaPIx8=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eba852f-8382-4313-4943-08da495ae59c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 14:26:37.6017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Bp/4a+YmLxz2rEWcwFHOtfrfVWoAgGgr77qq0hNIqbBmzRdn3l8H7LkjvofXpfYhH+u3WOqwoYn15wHI9kt0Ijj1sVqZ2FNA9rg76m0eq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5697
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some warnings did not increment the warnings counter making the behavior
of running kernel-doc with -Werror unlogical as some warnings would be
generated but not treated as errors.

Fix this by always incrementing the warnings counter every time a
warning related to the input documentation is generated. There is one
location in get_sphinx_version() where a warning is printed and the
counter is not touched as it concerns the execution environment of the
kernel-doc and not the documentation being processed.

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
Signed-off-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 scripts/kernel-doc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 7516949bb049e39f..0d1bde9e44f98d39 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1095,6 +1095,7 @@ sub dump_struct($$) {
     if ($members) {
 	if ($identifier ne $declaration_name) {
 	    print STDERR "${file}:$.: warning: expecting prototype for $decl_type $identifier. Prototype was for $decl_type $declaration_name instead\n";
+	    ++$warnings;
 	    return;
 	}
 
@@ -1302,6 +1303,7 @@ sub dump_enum($$) {
 	    } else {
 		print STDERR "${file}:$.: warning: expecting prototype for enum $identifier. Prototype was for enum $declaration_name instead\n";
 	    }
+	    ++$warnings;
 	    return;
 	}
 	$declaration_name = "(anonymous)" if ($declaration_name eq "");
@@ -1317,6 +1319,7 @@ sub dump_enum($$) {
 		$parameterdescs{$arg} = $undescribed;
 	        if (show_warnings("enum", $declaration_name)) {
 			print STDERR "${file}:$.: warning: Enum value '$arg' not described in enum '$declaration_name'\n";
+			++$warnings;
 		}
 	    }
 	    $_members{$arg} = 1;
@@ -1326,6 +1329,7 @@ sub dump_enum($$) {
 	    if (!exists($_members{$k})) {
 	        if (show_warnings("enum", $declaration_name)) {
 		     print STDERR "${file}:$.: warning: Excess enum value '$k' description in '$declaration_name'\n";
+		     ++$warnings;
 		}
 	    }
         }
@@ -1368,6 +1372,7 @@ sub dump_typedef($$) {
 
 	if ($identifier ne $declaration_name) {
 	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    ++$warnings;
 	    return;
 	}
 
@@ -1399,6 +1404,7 @@ sub dump_typedef($$) {
 
 	if ($identifier ne $declaration_name) {
 	    print STDERR "${file}:$.: warning: expecting prototype for typedef $identifier. Prototype was for typedef $declaration_name instead\n";
+	    ++$warnings;
 	    return;
 	}
 
@@ -1715,11 +1721,13 @@ sub dump_function($$) {
 	create_parameterlist($args, ',', $file, $declaration_name);
     } else {
 	print STDERR "${file}:$.: warning: cannot understand function prototype: '$prototype'\n";
+	++$warnings;
 	return;
     }
 
     if ($identifier ne $declaration_name) {
 	print STDERR "${file}:$.: warning: expecting prototype for $identifier(). Prototype was for $declaration_name() instead\n";
+	++$warnings;
 	return;
     }
 
@@ -1803,6 +1811,7 @@ sub tracepoint_munge($) {
 	if (($tracepointname eq 0) || ($tracepointargs eq 0)) {
 		print STDERR "${file}:$.: warning: Unrecognized tracepoint format: \n".
 			     "$prototype\n";
+		++$warnings;
 	} else {
 		$prototype = "static inline void trace_$tracepointname($tracepointargs)";
 		$identifier = "trace_$identifier";
@@ -2325,6 +2334,7 @@ sub process_file($) {
 	else {
 	    print STDERR "${file}:1: warning: no structured comments found\n";
 	}
+	++$warnings;
     }
     close IN_FILE;
 }
-- 
2.36.0

