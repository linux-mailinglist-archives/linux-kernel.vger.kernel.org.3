Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA24CD1D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiCDKBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbiCDKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:01:32 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6625A19CCD8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maLu5ZghCjjpUkgZiuObo2RGjVSW487JKWk3O0WJqtFTM3jvMy4W6xxuRoPdlhQtsB/bW4CMRn60MN/k9e4GNNhbRBQB82tUIp5qFGvfvOWDsHH9VGnQGY/NyAp5RDlr6WfXsvsAPZE5QW7Yo0gHTxkYr6knFeTikeh+amPVfMnbwOx5gll6+WgCeJpwS275FPoeeCOHqI67t4gOLUPQLuesPn2/z1HGU2a7Qo/9A59sRfu7fKmngIOKZiJGJFdhuklP8mrYHuUDtofDWE2NN6fPRqtmnH3oY3ss2Dhsz3PsBtgZJDKnIPIhwlpIyG5ge4C9PEslGqEfHCoIvWpejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGORsz9QZviEvf4I88rk7tvdaUxGJw8W9K85w7vc/pY=;
 b=TdHezUeqHet9CH51bgS0q/mq0sYcmpEk3cTcYI6jng4X/APm4aUz0ffvNmFD5etSxD8mcWyUsQV2jWpziFPKbAAnz9fxcuQNat3ce+rOnjSrz5DUGtvyhNL/ike/vQrb4ZC7005zulteNAfka6ED5A75kmeviYtS6CVjVtUws4t2iAt3L7LIpsaiWeo5hw9VL8CwEK4xB7QLFetCSAT81cahOHw6a3CEVYqjNyvjlhGe4tw5HexEC23LPjZ/yIaQQWTgNWEgHw8Xy4QyeW3GPXcXkK/sViuYYF/lYLnJL/ToHErKFeYAgtOqd4ZbRVm3hRPP8zGC/l0uPOx99zlshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGORsz9QZviEvf4I88rk7tvdaUxGJw8W9K85w7vc/pY=;
 b=cwaQLC2ZpSPp4OGwGlGOOXzW4BPKQxCJ/P12o5klifa4ZtTeCkTzeYDGVKqr4bRuyWbz7yDqP9G+aaAbo9O2VRY8pkRjEY0xnk8O17VrIl8edo84zUMoJt8EPnDINM9TrZSQcjrwQsG0GWyzDud/hN+FNy+LngdyViwCr3oLSBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK2PR06MB3603.apcprd06.prod.outlook.com (2603:1096:202:3d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Fri, 4 Mar 2022 10:00:40 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 10:00:40 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     kael_w@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] fscache: fix a reference file name in fscache.h
Date:   Fri,  4 Mar 2022 18:00:18 +0800
Message-Id: <20220304100018.6133-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0181.apcprd06.prod.outlook.com (2603:1096:4:1::13)
 To SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73da4f04-1417-446a-bcd2-08d9fdc5d671
X-MS-TrafficTypeDiagnostic: HK2PR06MB3603:EE_
X-Microsoft-Antispam-PRVS: <HK2PR06MB3603FFF6BC1219A088A4D41AAB059@HK2PR06MB3603.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li94umShOai9mLiaAnGilep8sBwrmlT5U/G44wxSRLIdohzSyFkbQ6LTx+9fob28BMENzeJY2zYYtje8aRA0skGkprtIhy7lInH+4MPMD8rgannUOMqMNN4FYBo6QsqLFpugBzKgA1ecrFRwI03bAPQIbZl1Ew+WPV8l1o/jWVkTQXRonFcA0nWoeQt8b5ypZJG68yd82ZYYiQrm90I8dFr5C21GW9FiuRrkTyIp07QGoiMMqV8Q+Atj788x8zJEyGGg1wZ+q+P+gD/W0W4Fl6ock76XrJfVxtv364MVER1rMM3wTZYhC65IK34twYSZeIBQhJ89mR1E+JEF25aoMx8YLAbvVmSJh+h4X5OwBYzWruI4Bgws62G+kiWvHhvzZkxNroSUAF+3V3g4M0X3lHMpl3EfAyMRZTUAGC0Y3gHg6PpUfSIUQvyW3zmpkQLLNYXbHwqJmtIdCkdHWFZAHrfPvz++C56CKmTFrDlIRSr0TpcBzHSNKWgxylDjR6cyw8fiQMzyYBL/erOKY97jnOH2MMaa/V+yrj/PIbp7FWAp2HCDiGyaCkAuQECIyOXwxlyslTCp7Bbti7HmOL1JqOt8o3+oppS7T77r/1lO2GnIMF8vp9D2AeUT0WZ/5kAruwxC6sOD+WUm76BF2rK8ZybIUp/alPjEVNo8KsiaREZnueWcGMKI7opDOps3xN24ZgqUpwYwVP40kAo2/RCl1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(4326008)(8676002)(508600001)(6666004)(86362001)(66476007)(316002)(6512007)(6506007)(66946007)(52116002)(36756003)(107886003)(6486002)(2616005)(1076003)(2906002)(5660300002)(83380400001)(38350700002)(186003)(38100700002)(4744005)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d5hj4ObHOBe6GosweuP1TD1z2mY0BN1HFHKPOGcq6zpPEwRyrmkY0CBKxqsX?=
 =?us-ascii?Q?hq4TZ6slTy+hZ/M9wKTK3ebFg6dKCDaSmdLagtV5GF6WuCSElALCsdDNJom0?=
 =?us-ascii?Q?sZSsS41Sy/Qh3tBNqEwCzyFWdOwxSZN3bxgXu6T1RurIAi2W3BH4lSuTJX0o?=
 =?us-ascii?Q?Z2eFOjOr3n8gKCR8i5FB68DL4s2XCkUJnFlPp6m9HOa0eM7X24xhzORmJhsp?=
 =?us-ascii?Q?aFKWejJo5Xme7sfgC2GT02I4F5MJYNLhaCZ6M6rnkaRdXET307rAwXezzZ8/?=
 =?us-ascii?Q?DouQIWlC0whKaibSbkU7P6fIEz9d3pbDFrAVIQSCD67RDJQALTKNoLXTcqxm?=
 =?us-ascii?Q?NIysYLMK+AqRS5JKrsSuUhaqNRRoX4NyKn2if1V2uHIbSjmh8gq78UKmgfy7?=
 =?us-ascii?Q?PgMzx4jsZpRF43YWPTx2aiu6Sl4VVOtLVVCihKyISAfwR5TpMKdaZbZ5bzjO?=
 =?us-ascii?Q?H2yFO7ou11hu4e3VDgmfk8A5JpFtiATSdCRywWC3AO8k6ol57KsV8+grHdJx?=
 =?us-ascii?Q?Vcx2xBeDlSIEBtkjQlB80RnJ5vOP6ea7XyyUU9lmnbVwa5mWO8kdRaBKyoFb?=
 =?us-ascii?Q?q49HKfFNR/Nanyo6b+3FWaPmNDxsvw92HxWRpqKJHfgVE0hL+eUBGJBNB+A0?=
 =?us-ascii?Q?J3rb9TmDYVAnaVGGbXomNoD1MfWvXnTUFLn6RpPxeGeq1KjBRhPjWElQDOHJ?=
 =?us-ascii?Q?2P+GSxnhJM3YJhpz623PoyFntkx+YqTFYjNG9aezdPuUlnH6DSMUZntKncS5?=
 =?us-ascii?Q?V6KIkqTY9HWKvt+3cppbZfY+F622kxnTbGFA4JCnLvHfe1XyeVK7N6nrepRa?=
 =?us-ascii?Q?hUPMms1VJZG6HNF1berm6AJQ2U0yjEcK0PnX1DP9NpRvBh85nOZsCwPZe+Ls?=
 =?us-ascii?Q?0ThoKQba2XDX8p3Qm9gj+ZlcvoR3/XkGdwIwIbQ0WHAurccV0UtWGKpJZ091?=
 =?us-ascii?Q?wrpb61wKrs//WXeplWL7Tw7wSnUzXo/DDIQol7Z7tzXo8VxePnoLSImewBPJ?=
 =?us-ascii?Q?tOkwey/TOn37SqRechouGi8AYiGj8PiZYfm+eUgNN7eiX35VQg+kkNTR0EpS?=
 =?us-ascii?Q?64JD1C+FKwq2NWjs1B1EVHY4O7QbwsJCz6docO/xfhCWLvgv0EvcdvO1kEPq?=
 =?us-ascii?Q?rgwqXclUjVWbMoeOHwtkf7VYlXvXBse6eo5W0aiUmW4bAutKLExnZ6u5WX/F?=
 =?us-ascii?Q?gXPPMNJaofK4x10TxS2ITdN5MhQ4wOsUxhZyiDqablx1PprRu2e8KGBulFzV?=
 =?us-ascii?Q?UR0O4SHqTFH2WC1T9s4+wtmUqX4EUhosb13pHGUwyL0KGZqHdr6qapCoHTPX?=
 =?us-ascii?Q?DYTEmAzi3yh5Nk02w0NBVESahZe2+jOtg8QAgfczx5+SVPwTlp3ZgV5lbkgU?=
 =?us-ascii?Q?eECQAR4RD9fS4jBX4fTM5bPeEXOTLx4xRX3NXfuYgswurKONaB26ouYIahtC?=
 =?us-ascii?Q?ZQJPMfE2sJhgQbmUJxil1uUPyDhW4t/fvT4kB+TP+OnhnZJbBZukNvZsEcl5?=
 =?us-ascii?Q?2e+dCPZEN5Srvm/sKMH3BKWPfeyKxkG8rmRv2atOTleV6IMa+ZB1DQ467ZQ+?=
 =?us-ascii?Q?cHZAQabvZchkt26AFyCEDl5EddYcAt/tuETFlmgTuJVKPipq/cLrkMhIB6MC?=
 =?us-ascii?Q?EefqHRixQZGEUeu3npYLkEU=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73da4f04-1417-446a-bcd2-08d9fdc5d671
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 10:00:40.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsiKmwCTtkR0m6coNKnn9Ko5/l6PM6QMlSZ9j7SbD9S8L5Ym32Eyz7wCFM33/mXLtmRcFAIjspjIjdK5qC1bxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3603
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following 'make refcheckdocs' warning:
Warning: include/linux/fscache.h references a file that doesn't exist:
Documentation/filesystems/caching/netfs-api.txt

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/fscache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index d2430da8aa67..49aba6c7b12b 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -377,7 +377,7 @@ void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
  *
  * Request that the size of an object be changed.
  *
- * See Documentation/filesystems/caching/netfs-api.txt for a complete
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
  * description.
  */
 static inline
-- 
2.35.1

