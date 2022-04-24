Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5350D0B6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238791AbiDXJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiDXJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:10:45 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2120.outbound.protection.outlook.com [40.107.215.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7B5E143;
        Sun, 24 Apr 2022 02:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQdgLl/3pn15B+8hjK6AsG/VlFRJ9gkChdzdG81mg6kH9ZtWNDkyx/0OtJg52gRPb3CSPAuzfjhIQcnChtmB169B5cPothL63Cf3X0nhsq9FGstcPlglkMww/IvS60/GPTSTLVYKroKwTm3YuM6t+qiirpyP+xAPE1bgKvN4FO1B9NLoVjAQ0YA/6T7GuRhLFY71milGl1AvgFIap9I+2XtzbaRxbU5eETiixgqcJxvM2MyYGSRh1CU7sQ82p8iJvAFJD+raCkoZXo1vud7vFm9SM+CO1/sjV5lwLfhG3nj0uMHaiwQNUnLA2ePEBDQWWOFTrEA/9GqBYEdrKrpW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYCt2JSFWfUKiNHxmCSbd0+pqk+uxmyxEfWMM6fsc6U=;
 b=iVG0JwhOdJvQmGrQJk8xfqyJ4s58iVPZbOue4oLjIMVQW3dBLb3X33244DlD/sEcdXFgCULm034vC73qV16puLQ2mT8TRf6hlMz9bWUVSd4X1SHONnDpIHvNBgI/Cvh78TwT76/ORNWPKuxJHeVZEGOoDyyo3EDGchA9kAKzFF/q1easxg9v7jzbFsJfLAVTV6TnjkJQOFfo/g38H49Yw5Enw08DxRtngp6rIUlWgBcPmBSCWXYC51nC1lCH20RED50KMclvq8dQA5PYYS2eOdOiKnMXD/5INJN/IgBzwpCq8nYJPZog/CydSAAVx9/zw7ScOmxAEKrxeQvFmW0MWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYCt2JSFWfUKiNHxmCSbd0+pqk+uxmyxEfWMM6fsc6U=;
 b=Q6sIYYqW2wLP51Bsaqa+P0N7C0Cuzg5sI8LeD80TqLHapW0Hk+083MMV8llmUNE/Jl4DBsnJI3ZnXC16CWel/SYdjs2f2gSl16ZAA3xfRgmy4oFCmoL9wE1MlQ7yEuHRuGHtu3IvAqUid5pgQnW1elPKBKnZC36VR6YcNgjUTBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 KL1PR0601MB3921.apcprd06.prod.outlook.com (2603:1096:820:2d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sun, 24 Apr
 2022 09:07:40 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.019; Sun, 24 Apr 2022
 09:07:39 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] perf sched: simplify if-if to if-else
Date:   Sun, 24 Apr 2022 17:07:27 +0800
Message-Id: <20220424090727.97865-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0066.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::30) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c73901e2-2328-46ce-843e-08da25d1e1c4
X-MS-TrafficTypeDiagnostic: KL1PR0601MB3921:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB3921FB3B276025337CE9B593ABF99@KL1PR0601MB3921.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rQefXzCVM6nRVdA2oonbL8QEmn/fMlhRze9+Fc1D5KMfWcJyvpHHzdZIVQ78KCNNBGTOJoH+bBXoqZVga3OsVC1lvKIa/DkD0zHRJOckKUiFKhJ8zDr+LbLCfLtb++NMdICF12zNowK/5JtFs6O+HTS9FQqInyN5Ssl7NnQ8hz5WoVyaAvDO/A4mawG3eI8LSw3XMkMwBq3Q56giul0xa2kXPmzFCIPdd5KqY6l6s61uXATYtX6XFuUpHOPu/zeO9beL8T9/JNwx4bS4owzHV+xKqxvhzTQCL/cK+zuxpJpXf1vJs0a7fG/7QPQvuM+pkVzU/z99nRjuaXQc2Xa2DxueCpn15Rj9RUIzOCog91bH8W5SmWbevMxdwjmAYhhnAIWciRT1ZQPZlBzX1sjAOr538QK44i2vcoOLkCHJvZzQXAtKlar1/BYzLr4zU5e9pdJMnUVfIEmeH3rMYIaYRo7kP5AHCGyIB4ntlEKSIQzOe0GiLkI5+0CPPyQjJnGnILnqeYiaHw4bzDkKjn+8PgxevQOR06oypqseNFleaPYCzJ9rjr/HOqWIDR9vsdqGmtb66ZyYg/1qvX9/gVIaV8iu6mAcQj0aBrrJKqF1xzeRHicvaBi9h0X5bGB15yRkWaQ3YRvfsv1i3FBLf1skDHpkMIoZ+rz6Bx0XMqIt6amUzCfIvgwv8oBIm/1Tqf209ReOo3KvGh3Vm2hlb2qiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(8676002)(4326008)(107886003)(38100700002)(316002)(83380400001)(508600001)(86362001)(26005)(6512007)(6506007)(52116002)(6666004)(186003)(110136005)(1076003)(6486002)(2616005)(7416002)(8936002)(2906002)(4744005)(36756003)(38350700002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jjl8g+Qu0vWjGNm4/CtI5s/YIO9wuaEjhUCy0bMAlUm19hl6yMBL21zSIteO?=
 =?us-ascii?Q?k5HRDHQ1YkpFWbcfARGgD4062HgKIinUkgJnDwUNBSUu/XqRLHU+d7mY59Bi?=
 =?us-ascii?Q?Bk4elm0jWgh+F6e1if7XDrC1LdlQcDbleiI591FdGwDUvkjxHUFm1/KrHnwb?=
 =?us-ascii?Q?3mQZFdkK6rp3C9rWSx5sGfPGl4vyLI8ZorEqBhaDPSBHraiwcetrcHoP9I+q?=
 =?us-ascii?Q?XItIUXGml6ow3JTalcuySTgaiNSLPQOvku7QSfXZU0dorBX5ks7VWPCI6SpI?=
 =?us-ascii?Q?7C4InlEnEyy8yfROc94MWSiWW2Hq+U8Lx9N2mtXnT3SPHSFZ0ZfS23LSfEI6?=
 =?us-ascii?Q?xvXb/+KchrkhluPfn2+3yUbqWjwx9L/4rhBuiaBkhKCxD5JXG4BWy0HUjmtR?=
 =?us-ascii?Q?a28K9SHjnfd1peQmi67ww/xqCIEEP1lJKYJgwmaM6k9x9G0LhMkLVHWnwKuU?=
 =?us-ascii?Q?fjENSt1JDpPqwTafeIflGhGwHELlV+XYX9ay/QJYFgAOR8G62mgHz+HjRhwG?=
 =?us-ascii?Q?yT5SF10uOEdqeJkVHWJy/C5n++hoN2KceiNYGqP1YV+RiUxwwcZcrinDtJdU?=
 =?us-ascii?Q?UIGrCPGQSSLOQ1zsbpgQlIAGqfmiLaxjv+qDJ38NSaIplWy+OOJL4yF9A3Jf?=
 =?us-ascii?Q?U8yySpDtLYcAfqVWF12VdossXx1DwgrQDWMB+vIEE+4wj63lLZ+QdmCDAiXj?=
 =?us-ascii?Q?sr9g4x9UvVYxnY1t7wcJtKpJ6jKsObjmdV2KAKzSn99H4/kX7s1Ld300Dgq9?=
 =?us-ascii?Q?ic/mRWvjdofsS0usPuD08o6h/j9m7LSbMM8a0jK+EID1TNdx9T0bJPtYEYFc?=
 =?us-ascii?Q?f3ogRDTpRKXjdQYY2e1HHAKeUjBs1nL/dEDmwJoNBak3WLhiQvBtuo5UbsE0?=
 =?us-ascii?Q?IKekaAJd1dPE/YifGQbtKkhbsxidB+bJOfN+77Rd9TEWo+8CM8ByJtT+okRC?=
 =?us-ascii?Q?3rqJeolFvLhSbRCNwL3dFnKtvnuHhMGxYm/nS5N5WCiYFd2fT3ia7j2YPfVu?=
 =?us-ascii?Q?akpEu2mkk5TlCTKkbyGBIMZ5ztUbqTq1tIVfKnqR6tFtUptYmvmBelekYHdr?=
 =?us-ascii?Q?hxw0uadwJ3Xbu/OtAOaTt6UNxZCrLzi+HoAIiDt9aprp+XDblrZy6BnfBT5a?=
 =?us-ascii?Q?/jUoBRfp/tfDbC688FrWmVQOiozunQXN/5Cl7BAi7emu0n9Y7ET6C6gGFTTn?=
 =?us-ascii?Q?l+FPrngtc/6ihv8UEGbhVCaLLtCIg+M4mJv+12ymlJe9HBP4v7YFpdWm1qid?=
 =?us-ascii?Q?rTnrn8SyLi+bW5deXkAW5iK2+HmJHQpq1ygELKSz1jv5zCFLKvpWr/ptrx96?=
 =?us-ascii?Q?vy6z2RtKFZN2j5112yT7KoEQ2CXkYF+SlcHlO0YOjEwcXX9ECq6t6wP2rRlj?=
 =?us-ascii?Q?U8wZk2iSncJ6ecFpDWipB9OjgbOfptLc5e56RJc/SBIXpCJF8Xu+Cwyc9e9+?=
 =?us-ascii?Q?U4iIJx21tJurf7AUSaIeOU0SR2DsgB+KG6Q89faQpZGMxhUWsVtiDJechEEs?=
 =?us-ascii?Q?PByvOkiJZS3FIZ1Qwb8w8eDLL3TdZ+0EOb4yYZlCMRcL4RccTshbG1NUN5z1?=
 =?us-ascii?Q?QQdWueJSSA0zNDkA26EX8bwpR9OsJVC+Te/Fo6D3YmBZcR2mAEfkj7KA/Fwc?=
 =?us-ascii?Q?EC60LIH1i+iVv+N1THmoUHy0IZL7s2ZV0VFPiIiU1aLeoS7oq7hE/Pi+g1+a?=
 =?us-ascii?Q?pGk6vPYDfmJYbdbF7stW1Whatu2ey03Og6yfw4OZQGZQULNOolxvbYvfzAvT?=
 =?us-ascii?Q?+x2HD0FrOA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73901e2-2328-46ce-843e-08da25d1e1c4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 09:07:39.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzxlMr4qLf8OjJjDmiF+Qn+3fOVqXNY9GngzHuk5U5z/HxtrC/7zAnhhGTU7q27h26ADq6ee2JwL3RV9iOgg6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3921
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if and else instead of if(A) and if (!A).

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/perf/builtin-sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 646bd938927a..66f8e9318123 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3070,8 +3070,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	/* summary_only implies summary option, but don't overwrite summary if set */
 	if (sched->summary_only)
 		sched->summary = sched->summary_only;
-
-	if (!sched->summary_only)
+	else
 		timehist_header(sched);
 
 	err = perf_session__process_events(session);
-- 
2.35.1

