Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC74AEC9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiBIIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:36:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242084AbiBIIfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:35:51 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE95C036495
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:35:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU28kxFEUbbaRSNwFZACifeh+Nc/eg7Ahq8UWzNpSrfJntEoSXLkyXBj1yTww8Q/XE2prOHA+62u0A9CireGmkROEqmv+91cuwiRGW2618ShkuuxMtCIXdDGcVUxz+1k9z8IbQHPZFtvRLkb8pSfAt0bOGBTppU2RgnDkqGKhH0/95QtPKvd+2CjCQI7c77p4DLdMzOpQEVVvqhg7MDqJFtcGBojURUaRQ8RqUf4QUkSCBdRwdCvdwtYVCmmdnYtIkpQqvmp5jHA4txsXWGderHhPKfTbQV/Y2Xyi9RareLsNvUro77Sy6vcGJc+qojwiLvVgpq2d/7j0VlJUZRQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czTM8fPXiwl0ZVzsgWec1E7mKpNpO8Z5Y29GEpbDOSI=;
 b=e/oG+kvPWHBg4PfO14IqidgImBiN7QsXg5xUDbwJ0ScPmRN53kV//kXvFkB0g/dmhtvH6YhFh8NzVSI9WMGCHylG+vgXsnlmX+Sq5V9WX5FvRkgVhuopLncMqik6P3fPowWznC9XH94Iyi1lLe9w/OIjCNKEjCRNbeMIoXubEb8+zfbibz/BbAogIKv7vSwllcoriw8Rk76W1YU2U86/E1WAe+zmDT90w4+4valKikY0jJz6IHI/nM9sb0Wsa1RcHEDMOzztCG0BSed1dgXFbInAcF2mWwswBzfojl3u4j2PAZJLRQ5NXjEOQkGoPZ2eKkWdxL4XdxNgDuLiEomxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czTM8fPXiwl0ZVzsgWec1E7mKpNpO8Z5Y29GEpbDOSI=;
 b=HRs4+2BUwG4fsWcGennegC9Pagg4etDh26wqkEnG0eu62pFJQewUnVrMhCecfhvQC6iPOYmha8IzQlOkyYtxATVWcAKJS/d0K+VXGoWXp3tjF5XOMB5L8sPEx+l+fxv8QyOf6BPT4tyREJdziPfbKKusguX9yU2WU5lbL3Qvp28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3559.apcprd06.prod.outlook.com (2603:1096:300:6b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 08:35:24 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 08:35:23 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] x86: tsc: use div64_u64() instead of do_div()
Date:   Wed,  9 Feb 2022 00:35:13 -0800
Message-Id: <1644395713-3593-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aee8ed5-ec92-4895-d673-08d9eba71d76
X-MS-TrafficTypeDiagnostic: PS2PR06MB3559:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB35599B84AA14E8F13FE4BD89BD2E9@PS2PR06MB3559.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: py0LjKIVj3p7mWEYPfapFSMlqdh70cuPUYtUbmekMIY1PBQVYBeUBGnwVmq0LtHBlTedF5nlkGqP4s8/L0yeOySOMXH1SO1QmToER+2peoDsglPU7s5IERbUQV2xz+4rs2pJczt05XD3G5ceOlpgU5+PIMyxJ2l7xRQs0nllANkqD1eQRb1w8wgoLvz+e2380RO1qpGF5BvTOrrRN7IAXp+36qlNUUsR7fNdUz0x2zubftqC+w/wgjU0EF8Lqbd3F9vfd4xO2j0SRAyMEhtBLVkbjBy9unjwgHoix8z56woc6vpgf6ok12Cl3KnvRhZqajGGz3nv9gKyZwT4hpx0GN3U/aEZ7VBxlXbhqwnVOf0uXuOrDDS0k3JfVNHWmbsiX5cNBm9LjgIsFZG+5G7mRKm5HXy81RqBPhs2WjGFVcK7KhvzHnOuz+djt47Iy/T2bgmi4Ek3cyhEZfloZlM46ketFSgl8uRiPqGz7MNs36KAZr+bg2T+M+boaCMGsqrYMyjXd3yJhK0yyMcM6eomJhcWDCstETantQz5UR69W4wpKz0d8eFi7UpL52as83fyUU6WiUs9RyXYLpx0nt+Qmfqv3Q3GPvUqTCZxfqaxBQUE4IspWTmxkCteRm4QdwMduRrXdlULYsoReriBwFK9LliSzMhKAO3HH6A4xaz31P7jQBf2mBHzPyAyftzQYUZEuuhA0gQ8VHq/AIdmH6Oxqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(4326008)(66946007)(66556008)(66476007)(186003)(26005)(6486002)(107886003)(6512007)(38350700002)(6666004)(86362001)(6506007)(38100700002)(316002)(110136005)(8936002)(52116002)(4744005)(508600001)(36756003)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MD5b1pfLtbxc6zx8vMjOIqW6AhbZ3B8HvjpJuAmtEx4dRhWOQhYiQSp2jiZo?=
 =?us-ascii?Q?+gQK6Cr4blg7Mlu3hFcffRIZk3n4RkVpBVsw1o1WWGynP+MzASj0utJbJmr8?=
 =?us-ascii?Q?duN+E1ua4fWtEV0NpbsWupL3pc04ygIYInVpm8KoAhWbD+lD6ebMPG9SXzyw?=
 =?us-ascii?Q?hxJ7mf3Z1cS+bOEwYDZzJIOicFq8y7Ydr8emrG8uynG3iYJgbQvhBkXDIHdr?=
 =?us-ascii?Q?zDaklDx6lSluO6nXl44IgqdDacxUUI7H7bteOm9RhU5yAMzyg8nz2aKnbosR?=
 =?us-ascii?Q?dN3KyXxNDKXvAeSBIB5iSQCBNidyPOVz7ZxO36j0cuBUDd/lFNQ0/t91gEAK?=
 =?us-ascii?Q?Ng4O87nBw7Mxu5DEmNvTD/kv+SkVBaemBCAka906W7Yz1Mvr6D8WLmFErVFe?=
 =?us-ascii?Q?4WvAvFPexLBbNHAnAG8PdAyrKiwLpsZXQgVou7iBCTYrUtXRG7dK/lxzpLCI?=
 =?us-ascii?Q?NMSe4up5NJ1uspz519C4i7WxCk9Zd1RsjTgaF7qSJnszxWzg32myLIBNAFNk?=
 =?us-ascii?Q?LtJmt//hMFHYvqMKbZ+pRZzpsbqbSg21XbjKsf4utzub0pbXTeQzPra89vKQ?=
 =?us-ascii?Q?7b3FBv03f+8HgLbdJcH17BzR9DaTHdkdMaRpTcB1gpXDhRvvfTH/gyvbVN7u?=
 =?us-ascii?Q?ZH9VO50LO5uiehZBYnrh7pBV0adKy6omHyt8b8fynwnRDXRiSAo1B0FX2pFg?=
 =?us-ascii?Q?UTddNM9xG+k+Qnzdv1IrUPevgFyE5FV9jPC1SKXT5EELlcCCb1Fz+pdZlqJZ?=
 =?us-ascii?Q?NjdqfysrxNZ/hNHmIexTCIRBvK56080I3hj5cvgmHSSnOKPrgJIMVUkq7ALp?=
 =?us-ascii?Q?nuooRcssbk+ZRyr4rasvvzY50+Bh6blmOtIRDORvXyGB8PvzqYp8tVY5ABXQ?=
 =?us-ascii?Q?XQj/y+KvQmKTJeCgBS0ABm/hagMjMYMgZ9D8YttzwBQdDN4dD7tju4tTGlwt?=
 =?us-ascii?Q?krsWlEiqqACpfPV1BP6toBeh8Btii7/ZEbEfla0qiS2rTtdo+tQUK4lfYsNc?=
 =?us-ascii?Q?uO5crEViWixlODRTv9EAKceAndqbcqY1zSVHxU4kyTPrkP/WnDElHlTdbHYq?=
 =?us-ascii?Q?hP8v7ySQkTjn5yrBlYVyj2REW6+2sqXO9CZk8qZF06FAGGoITvphi2lOAhpa?=
 =?us-ascii?Q?qmGwiIUvgYHloi8ApcEhVRuE4IxApbpD/ew7ZiA2TOlZqUZVQXXQuv/GOeeE?=
 =?us-ascii?Q?dxp5j+DpcN45yJ0PbI4eRPc88xzkpw8dn18EJSjaU6sM9MiqAuhzLPiiclwx?=
 =?us-ascii?Q?7h+ou2sd1e6sY5SOGZNdd/XNIxrDzI+BlAXLAWJN9Uov9IeqjkLM6xLhMpSU?=
 =?us-ascii?Q?yfMr9m7TWPCKqBjJeY2eI9QZP/i04g/oqEjPos8J5oNsfkalMb3UKIvuZINZ?=
 =?us-ascii?Q?b73hT9r1d4M4WWFVTF/xeI7TjnF2HyNf/PZpdDPAT7Cr9Ws06o8EF/SziXO9?=
 =?us-ascii?Q?Twz3Db8ZGQhKYK8Pt+joPyYlJ/rEggZiY+bIMUH6n3eYuAGBNEXSDqesrLoy?=
 =?us-ascii?Q?GznjM/cGT82FqeAGQiHdXz4EZQR3JMNvl5WzGIK/zU8I5z+BzPC0CQOPlOPF?=
 =?us-ascii?Q?n6e6/sfNV7Ooy5lUNRMzSLMUDz+8ETWCftyhByj5t7RphpPhXNaCj1Gu9/RO?=
 =?us-ascii?Q?atb3OB67wgb8XlttgQj3FOI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aee8ed5-ec92-4895-d673-08d9eba71d76
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:35:23.8685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmJ1d2UTpnNiEh4WIP2EEfq57gN1J2lo5soMpvxjEaQbZqkssVrgi8eFq2K+URPByD8WubjwGJDzz0QoXRb0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

do_div() does a 64-by-32 division.
When the divisor is u64, do_div() truncates it to 32 bits, this means it
can test non-zero and be truncated to zero for division.

fix do_div.cocci warning:
do_div() does a 64-by-32 division, please consider using div64_u64 instead.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a698196..e97124c
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -365,7 +365,7 @@ static unsigned long calc_pmtimer_ref(u64 deltatsc, u64 pm1, u64 pm2)
 	pm2 -= pm1;
 	tmp = pm2 * 1000000000LL;
 	do_div(tmp, PMTMR_TICKS_PER_SEC);
-	do_div(deltatsc, tmp);
+	div64_u64(deltatsc, tmp);
 
 	return (unsigned long) deltatsc;
 }
-- 
2.7.4

