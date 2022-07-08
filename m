Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15556C2D9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiGHUpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiGHUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:44:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2044.outbound.protection.outlook.com [40.92.107.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319A49CE3F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqRrK/eSwegSJr72eahjS3J2akwLFU9ifi4Wzzc6YKmD3bmaGsVRf81y5w2sdE9WRMs/gQnd6YutTz0Fiihg19f3effXGwYFLjVAd+ojoiERE3+fWbZ+oYgLDg9YNSzugx1zTX3X9pA0z9owveZXQvhSKir84Wm38t1nQvB6ese6kLhRr+nF4MEtiVrYTZ1bgCmvjxokaf6VhKa0XXcDW4AbXMwFiyMAt5XUPI3Y2qy3HVL5JXoH3iwYWDnmFVpbKldjEDZ7UPensD5/qH6bMBN5l55Lg+O+lMZhnBrm/x7oZp6dOf31rE3ZmvtAZrGDsXBlbdnmMpTMXGTUKSGVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4NhtYnQMBIxsGM0tNxNz6EJinn3yONEplQUbUiY9/k=;
 b=aO9P+id8j9dIY9ZsEhkcWwp4PtlywRemXiYdd9uMRzMhif4u19kbHyK9ZZlygk2F8/nYr66Qbt1KmwXNSmaFBR2WbZ0M1Vcce520sEFDjGJ3bK+QM0C0vRmCJsWCs0ck2NipOBTZ0+Jhb3kaPEBB7nDZqeW09mmOp01uUV630ZcJdSx/qvvUitVvIbMpDcb6HwSVduiBTAY85jug+2M9GVNO64rNQJ2EQ+VYV1WP2A5g56e9MJILn3ZA0IZQmnoiQ6QoJLEWvzXGkm1gz8EN4zQRCsFyd4MQ+qgDAIk71PkpnQrWC7GLZCXSD9dYXtEHWNi3feBJlDLeDZ0Su+pvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4NhtYnQMBIxsGM0tNxNz6EJinn3yONEplQUbUiY9/k=;
 b=O26cDcJrYK6dwnygXaTCXOtFkPcY0i7clTNKJTBPJ7c2FmJMwC9zxGNIC9XV71wL0OwyORk6V614Vii3Tl2MBlvzxZLWobyl7GbvjlPbkNJ/Zsc+NBLveESsoe3/GO5RPXKdUQV/SJ2dZu7fFoTlAW5RE0F3a9G3cPV2ndhaHSCcFcConhrkFWprarWpNt7MnoQ1/6ctOudWsuFBT9JqiDi1MqC9jh4Lg2njNK+/m/XBTjwGa7O5eOT13nvf/1xEaPF3jzufMAE1H+UCSSI6Go7pZLiZ/za4B+Qe6slFoj6h9MjHd7tG7hdpcU17wFgy+3s7bvqoQqwujYU1d/jofA==
Received: from PSBPR04MB3991.apcprd04.prod.outlook.com (2603:1096:301:1::9) by
 KL1PR0401MB5244.apcprd04.prod.outlook.com (2603:1096:820:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Fri, 8 Jul
 2022 20:44:54 +0000
Received: from PSBPR04MB3991.apcprd04.prod.outlook.com
 ([fe80::21b8:a14e:260b:cade]) by PSBPR04MB3991.apcprd04.prod.outlook.com
 ([fe80::21b8:a14e:260b:cade%7]) with mapi id 15.20.5395.025; Fri, 8 Jul 2022
 20:44:53 +0000
From:   Wenting Zhang <zephray@outlook.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Wenting Zhang <zephray@outlook.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: always honor the CONFIG_CMDLINE_FORCE when parsing dtb
Date:   Fri,  8 Jul 2022 16:38:22 -0400
Message-ID: <PSBPR04MB399135DFC54928AB958D0638B1829@PSBPR04MB3991.apcprd04.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZnY4+7SjfT2nAdfJ6HjQxuxd8bXRL/43]
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To PSBPR04MB3991.apcprd04.prod.outlook.com
 (2603:1096:301:1::9)
X-Microsoft-Original-Message-ID: <20220708203821.1695996-1-zephray@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5f6fda3-b85f-4157-16b4-08da6122b604
X-MS-Exchange-SLBlob-MailProps: DJLbvgWm8MbzvjTTznORWVK4iZPQeQ1VU1K3mRwsVX+lgbIz9Ke9J/0SF6PfYYxjM/aTSGTW7ne37rsEEl1pLG6FJqpEvQkQdrxW9uoz8h0dz9gz1H7wSTxBFD9a6uRWZA8rGLQdE8GYvSnXG53K3Cv6jKtKQzhcdoYmOA5IwmKNqH1u8yxX0UsQA+gZQgAbBEaP79PhlTb5kBxtHg4zhmqsNT/YnXnat+U9urr5z3vom7HRHpLNucK5VERz6YFbpQpn4E2f5mJ2c493MmHM75Yc4M7X2swq++MWkDGpmi3t8pCyXckqKw0ufLNpzrbfwgN7pa5gWUFeZ6lgRHocmtemQAo/oYsnrPLQpUw0Xtty/RS3jyd96m0x7velx1QfOUlfn51AHvcOS78HLnrMNX6PWMT03B8wGrXnz6cihhzoqoGIfnP9cccv/M5ug+yPi/Phjb+5lYaroel5jaliDXXheoOFyPCCu97DvonF4tZhGGldoAdVsBEcd+yfLPX909jI/lIYGNhFopXXS2hgazpG175wnK6S3olC0JQerloctXrFHgPGL78H2z7F37rLDJLV/17xkGEOcFSw43qrf4kXowpscQ5oAkqilF4WABkewuQdsWIbA+cxUnUUri7lq0JQmWATWYYUXZM5UIoYNSJHNGvm8R/nyFaJzkOfqjFy0lWIcRgEn3s/GGbjkJwZQjqHdJjjZTE/tOkFnnDXoQ==
X-MS-TrafficTypeDiagnostic: KL1PR0401MB5244:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVsSGVvukMIXQuW40Tv38dmO7geKYi2WpRf1i4/oI2RQZT4iaV3kslHExrGDFY9TUeSb953jDjfd32+nuktphKJgCW882Yqjg6hgBJB4GGnqR8NijNfbwtcJdG68Ruud+LYFp6lc04+DWJGPXlP4Hk7gK5X0QieAyWQ69PHymMJHuZ9Oap1Bo6G+0SSs8rlid+kl2t9chDYXYkM4vSUborvxsXmvQhI5oZ1Rl8gsROwEcWW/Asrx0Uh4lzn0RNg8fzpTbPhzR5k8hDVi7+Fb9jwa0DOahKZjF4hUtum3a5DFCndPbPCEzcejKhCdjiSZz+hXAOz0VwSnLLQ1BTMk3MMmyr71+tpHIxtdXJ/FSauufDJJUFF7QvLkyVzWiD1TyqrUUZOVLHjWlun5Ki0ECW+Do85a/mTGTKh2gT2R55y3hmVg47NqarNdUgxAMxFOuialvuTO3L2mXUUdJ4JNnIhdCUMiDm9NcruR6n7SBkOB0Olsd9DARdfa8v3cl1zDrWbzhiGJTxmmF9lg6QQEsBcZmGGgO7QvXtXQtnepeV5ESlbQnq+ckuT74MA9Hkp7aJlMEAr0ZXIoBAjJoXVQ+71RD0R3n8FRiO+t40q0uFWR3alRVtWM6CoyZB43S4uzIAsGtZgETcNtIrnVv9+1ZKAVpZUelekpVValPy8rXITlQzTa70ZarKUXrW3e//aMJ1Cq1VyrJ4AyNA9IXt8VaQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Ld3XOb/v3ZBedNODPTTNoy9SUDC45JRjXRmxYM8t/1PRoIR5GOLvYowDdcK?=
 =?us-ascii?Q?T6sG+osQacUqBjK3ppXPlMRx2IyA3ZmFtNbn3crVfH4zxr72W2Wyo8L3Z6FF?=
 =?us-ascii?Q?JdLUtY+roymScER69eZYImcAicD6vdWCIU+XHinb7DDjot6MG9hAbcoVzH4i?=
 =?us-ascii?Q?qoc+1WhT41ovsf1z7SmM5S3bYIvrzL7xt5OUqkk3fAYjZKE+3ez0+DPGyOfo?=
 =?us-ascii?Q?gBPNCpxsf7PknuOh5m6gSZaQ5udWcDUV2D390AOOcDJivQEFMU9VtyxRUjDR?=
 =?us-ascii?Q?A936kX+12swae2rtGiAkk3U1A+RbLtrxEeSv5jiujvosapQpkU4X/8u1QXOY?=
 =?us-ascii?Q?uHmwrUK7ESJ3yIibhWO8a1/y/kiD5mx305sFYcW0PCuQHNs7rkBDNme2L2AL?=
 =?us-ascii?Q?MGGg+iCvt5r5qYe2bCgoli5MA9RG3pPd//OLTgVOJS3e3n62bXHc1mmuFxdv?=
 =?us-ascii?Q?hc1fvXwUyuod/0HM54KGgXK+AnxLOewggt0aALr5DPNbOM4VVHCEuQVWz2Bs?=
 =?us-ascii?Q?birajOUqEDS3sbZaPjIEKmPzmZnmla48fNwxbtBf4iSZ/YoMrCVNuYaKj7Kh?=
 =?us-ascii?Q?ROzUGSao/7DDe0SFfOmYxJ+V4ibh/qIEk9M3zWyGwwZQoK7/qiC+l47busap?=
 =?us-ascii?Q?BMIxDJc3eC5f1+NHZcYjFplnt1uBuI2iKBCRR0yCsus4ftJPRrNlQ9TND/Vu?=
 =?us-ascii?Q?o188Kqb3lkFgGloxJkMveZ+8m+3o00XVHab2vWDT4W9fEhif9uRJ3dQiJxaE?=
 =?us-ascii?Q?f7kV4eHyY8m+AsQYy0a3CRnETd47cOYeITWcLimR2fRwqNInfWKoVTHiXSb9?=
 =?us-ascii?Q?dl+WVzL7zM2ywJPVuEmATZJPOlGOH7RbtnXpC5hlNuCuPwDJ0sX81JxbX6WK?=
 =?us-ascii?Q?TOCTnPp+Cjh1hfIX2G9i+Xs9+OVX/0KA0tQQWjfTWZZSvSIeTpbLX17FKOnp?=
 =?us-ascii?Q?M6B2ckDdIYDkDs6y+T81b3ZTnRkvWSKDCp0CK6u2NY7UaZpVGxkHynnTbJ43?=
 =?us-ascii?Q?2qqjIYzPqrmEnvvG65dX0NGAwh29/p/IJqLOmEoE5VlgeDeIvyPofvZG2e83?=
 =?us-ascii?Q?ygdtQ/knhziyZwCt6KtP1ENHRU/lgX+Tx5M4MQyvP5O6TClDIngOeC2f2t/F?=
 =?us-ascii?Q?KGsIFL9zbanSqWFtLn/Y2VAvbeL5O8TA1klxkYTQ44Z3z6yB8MOOpmcwH/Xd?=
 =?us-ascii?Q?4HsiWjpeE+My/tXro+7saBjqt/ah3qAoZdPnrlPS/+14jAcJiqO2Q/gj6x1o?=
 =?us-ascii?Q?OohZnRKwTdpXeXfztK6Bf2ICJOEJRR26MVD+kSKghg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f6fda3-b85f-4157-16b4-08da6122b604
X-MS-Exchange-CrossTenant-AuthSource: PSBPR04MB3991.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 20:44:53.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB5244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_CMDLINE_FORCE is enabled, cmdline provided by
CONFIG_CMDLINE are always used. This allows CONFIG_CMDLINE to be
used regardless of the result of device tree scanning.

This especially fixes the case where a device tree without the
chosen node is supplied to the kernel. In such cases,
early_init_dt_scan would return true. But inside
early_init_dt_scan_chosen, the cmdline won't be updated as there
is no chosen node in the device tree. As a result, CONFIG_CMDLINE
is not copied into boot_command_line even if CONFIG_CMDLINE_FORCE
is enabled. This commit allows properly update boot_command_line
in this situation.

Fixes: 8fd6e05c7463 ("arch: riscv: support kernel command line forcing when no DTB passed")
Signed-off-by: Wenting Zhang <zephray@outlook.com>
---

ChangeLog:

v2: Add fixes in commit message; fix code style

 arch/riscv/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f0f36a4a0e9b..061cf8db3156 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -251,10 +251,10 @@ static void __init parse_dtb(void)
 			pr_info("Machine model: %s\n", name);
 			dump_stack_set_arch_desc("%s (DT)", name);
 		}
-		return;
+	} else {
+		pr_err("No DTB passed to the kernel\n");
 	}
 
-	pr_err("No DTB passed to the kernel\n");
 #ifdef CONFIG_CMDLINE_FORCE
 	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
 	pr_info("Forcing kernel command line to: %s\n", boot_command_line);
-- 
2.34.1

