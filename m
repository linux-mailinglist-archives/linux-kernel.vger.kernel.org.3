Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6B533C61
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbiEYMMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243397AbiEYMLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:11:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2131.outbound.protection.outlook.com [40.107.104.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A02B275;
        Wed, 25 May 2022 05:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeGrodi8SXc0DPhLLV4KprlfKfKJvLyQ+qx0m3hQO1JbdzaHY4y/UpOgAbeMF3u2C3e+YjEIk3yJZQYL+bPSCj+lewe7n9ys5U5uqO4br/BmDplc3CtHrKqp0MQJlWmBy/vMV5jW+SXqI+IohKOT2CzqZPcKBQJRql4V3dqILB9KnXqFYLfpLYhgOLofSUhNKJX7HF2hRsHfArtoHOzV7LYosbJdcTKdix6CuQJSdiX7tGdpmAop0ADhx5C16CKzP98RLPzOvrsfCHEZTshuzIqQkIZvHacbKAnsF37+D+qk94ug+hFb+AkuBLRkPqKG0114Iim/5AWKnYonw0qotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jjae7dwh6+X4JAvdK3cuLDQ6s2C6xrCvKxx6pngGV5Q=;
 b=HkFpiNMdWzSCJRzgmlgq3+rHrs2QGKB8iVAhF/i4WOZpKGlSm3q4OfiZCznWGgAOqIhBuuSlttGbgA5PneO/DkQ/qsREtkvgrpykVnQtapn1pOx3K56IKcnaF/D3jqmyhniabfi+hhzr1nQ/SbuD/yjGHq29N+jKUNhMbQ9OFczySJxypvtka28fxsoEL+uCJs6wWBV1fdzi6LUp5+7D2B9E/M9Ctx3GMTcGjixUrBifljIU6oeUsr1mUPS+epddChCvWdvz404ge6LP+nMUllTYVwnznH8fRJCJzR49rcomc2A59SFxyG1hQzhhSmwpVDSxb9mJkjyX5d3quQo4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjae7dwh6+X4JAvdK3cuLDQ6s2C6xrCvKxx6pngGV5Q=;
 b=TCNYQ+lBSL8/3mhHF5bItcV+cN8nmUIQjwqoy34CuoeYEnoh7DAm4gBR28p+sACDMCOKic0q6pZrwqRE/vUSX7ZdQwVchQdxyrzzlkYSWao2J0U9ViThpX/BrJDfmccdTwQGpriZecYwDzEBCfQF2KQb8teLJ3MNuLLLDnhd2QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com (2603:10a6:803:51::25)
 by VE1PR03MB5439.eurprd03.prod.outlook.com (2603:10a6:802:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 12:11:00 +0000
Received: from VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9]) by VI1PR03MB4208.eurprd03.prod.outlook.com
 ([fe80::cca9:49b6:f568:ecd9%5]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 12:11:00 +0000
From:   Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
Subject: [PATCH v2 11/12] MIPS: Report cluster in /proc/cpuinfo
Date:   Wed, 25 May 2022 14:10:29 +0200
Message-Id: <20220525121030.16054-12-Dragan.Mladjenovic@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To VI1PR03MB4208.eurprd03.prod.outlook.com
 (2603:10a6:803:51::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8285ba3b-7220-4ddb-73ca-08da3e479fd9
X-MS-TrafficTypeDiagnostic: VE1PR03MB5439:EE_
X-Microsoft-Antispam-PRVS: <VE1PR03MB5439D3E0C3ABF4756CF22FD5EFD69@VE1PR03MB5439.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7fWDWDEhdVS1xoUnoHv3AX8UpBZqnQuXIEfDGUD5wfQFCWCtmPswb+Au4LdwMqfzuNZW+KjlhDUNVl7bMKtYeNy3NZWcEvxkRYbPONMoCZ85aG/76IUP3B/m8BqWWG6JKFyOX9iqFSNQdOpWIVENXkC9ezwxqCP8b0T7nhzzSRoMrOI41QtHRaubqf6BAjHcPRE2u2SHbSy7RmX6OWnhU6D8Y7EkKIWpiOo0UaisanVOQWdmcPOPASUip4EFGE50F6vaH/QISp9cX25Kzz7LT5omrgAiQ+1e24ZB/mj4am+RTJRMeqYrGa8o/rur8a9DcZabR9JoeLV7ricyfHJ6eqXyKi+RCTeVRiPHmNw8k+PdROUB3F1Jq2aTZD6aNoeymPIeDF6khIb0HoIASPT0txpc7Xn0uXXSogsTqPmp1ioIJBvp66JNs9U42IXB3Yd9iFs0xU8uCPRFPksW0Z/4mX++KxESVLQnlQdrgcFJ+34cBQXF8zkGgymbfV7V7OlRhaWAWyiCZAUrIfQQGIAeamp4LkYyjIS61oolDTPK2+JCfQFqPhQXNnznSVFu/7pnAxodEJ8YcEGTqB4UwgTiBdV7RMskQW3dsKbMugQYqbRAA6BpB8lyzusj3RrEwcR0zdsamgrmm0jjpHMCKW+kTExokFIrMDn1pwKCnZluKC2RN4V5+y5L/8HT7vMa4/jib5idNuTz3pppvV3IkQc+eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB4208.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(396003)(39840400004)(376002)(366004)(346002)(36756003)(6486002)(7416002)(2906002)(6506007)(316002)(8936002)(86362001)(4326008)(66556008)(66946007)(52116002)(8676002)(6512007)(26005)(508600001)(5660300002)(6666004)(107886003)(54906003)(41300700001)(2616005)(66476007)(6916009)(1076003)(38100700002)(38350700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDDCGyG19l7vZzTs04oIbzH7dL1iWghHSkxGkrHv/MtNH4RokfQigrTQXjVA?=
 =?us-ascii?Q?jqTPRDR0viXugs87cZSg3Rpb70d3DfKwQn/dM5Fz6p4y6MF7+brYp2KO/UDe?=
 =?us-ascii?Q?pVrVaGNnY+KHINtehAMnzs3/pmURRlfG1rd5tDsrCdHvrF4Wl+1ZRoNMqyej?=
 =?us-ascii?Q?TTQH60xMYaH+V73MsPIhTztgv1gyXkwahYUMafsBXM6gP6/ISEGYtomu/a6P?=
 =?us-ascii?Q?wVQWXCa4ckaO0BFFQ7X+e3QgjIhoR1KUbhrkFknSaYUtpv9hq+AHAH/8XZ8m?=
 =?us-ascii?Q?wLXnqYFy/cEMfUyxWnK6AGezxHV0yGDPuKP6eSBlkjXl4gLW841FMXWSeOqb?=
 =?us-ascii?Q?IvLK5V/suARuznOFRRMNH5mcsRbzhbtX/KX92guLp6b61iXOPQ+RlxSFfpfD?=
 =?us-ascii?Q?DIbji1pNcYsC8aUbNr8fcqZscDDX93UevDeswFU1N7gAYUvG4nJE9xjSOkq+?=
 =?us-ascii?Q?3Jmjd0Tl5Rc14qUJC/VFEfzRQU6VzhhF50sQrGnJIic7ASew90gZQ+5Owa29?=
 =?us-ascii?Q?IxqmWLpb4Yrwj1HIomqR8dtYoI+V5eytlv2nkuq8WECCbWToFRbXG8oMQ1QD?=
 =?us-ascii?Q?LduJnWiDyf537rIv8gvwb2WXOMgkVP9YHmOpPaI07L0I+iWFCxUtrydH7B0X?=
 =?us-ascii?Q?VyQRMTO/SVu2gGWXv/FmlXf8pxc/pvz17hg3uvRLcbk6StiT5VKVGZY+gKfF?=
 =?us-ascii?Q?Bf8pkgwcR1WRhK4rtDoLnC7Fsf67Q0S6t1Ilgk8YMKNpATWO2zcCJCSXyzDg?=
 =?us-ascii?Q?sYV/vFDMX3GF6WAD/752B/qO+c1ZPvXtx65AvI6adRoqGYO0z46w0dGwj9WF?=
 =?us-ascii?Q?4C3AGVCQKlarIlz0hOL/Kp7tL56MFg+FBJzb4yT3D+pHS1ffnlGXt+J7GdxY?=
 =?us-ascii?Q?Nx3PKIn0zDVGRN5xJoV36LwMHUWcSgCVI/eQszqw/UjZAO2ul9COEe3VBzSW?=
 =?us-ascii?Q?XVrSXRqVROIloj/gqXRb/jw45otpOjNNWr9QjfVmV/O+Y6K83t+MxXzhoq9F?=
 =?us-ascii?Q?b50UsGLi4eKfwbqbzcpUt+5p7s7PAzUoP3lukdEg3HXNwo+JDeIcm+ujAWfk?=
 =?us-ascii?Q?+0abnoQVE/TNuIs5ZabJOrupHLnt5vmAvM/x4TjKThXY/RNBgIRXYY+Xk1XW?=
 =?us-ascii?Q?gfMaLPNpIZzpGyZOeZvE/5dxT4fRhnhRO4ejsZvokhaK2hnY+Qj/MYpI/XFA?=
 =?us-ascii?Q?SzNWTrTxx+FRD161bLn7NC0imPUZCrqPMpijbr2uey9I07wJ3gKWQG4cIi14?=
 =?us-ascii?Q?IIgRExNL8vC48FwLMNSuuJI0aJavm84fKrPtSnOqAkdR9njGBeFmE9tfxOej?=
 =?us-ascii?Q?93C+WdKxiWZ1glKVTVNatGYjsmNvtHLgIo/RmrEhQHbFqr2NkPGwoR/mNYjZ?=
 =?us-ascii?Q?UGgi5bD1dKMxY+TWlFOiMb5iXgTzYYShIeQuPW4VVNoBHYVH28cpbKp7kEvm?=
 =?us-ascii?Q?WxsgfWqpIDJ8x+3AnWo+fwGjzwxbRXAVDxCqI5Vty7mqbyjwM6u8FrhpRmMo?=
 =?us-ascii?Q?hu6VsZPkSdSkucKQE51MsfdLzyMX8KwJFhOilFI8h7uvO13tHDZSM4KHidKX?=
 =?us-ascii?Q?aLjuxziB/XawcxDXX1ygxeCXouH8xNnyVasg+/jPC0eWdmKWORs94KUGDP9V?=
 =?us-ascii?Q?w6xAWFjh9pXMKvEfb9360V0t7Ta0NnavFWiMDb6SRaAf837qWNuEjeumeTTj?=
 =?us-ascii?Q?y1RZ9MjrK5eSNcQPtXx5zzIvsJNahoyWl8n94DdFys6ee/ptVbINrqIHS9O/?=
 =?us-ascii?Q?9QEPwq+Hs3wxvL0LDUPelbLgint+1Fj58uNqij8KExdVXpv7tzQq?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8285ba3b-7220-4ddb-73ca-08da3e479fd9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4208.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:10:57.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoTVAjb5j9hYJEIAqfSZITfrl85SQCYnic55GWQlp7CMLQqNnwGWgi4LZoHbuvJJgNdrwR2Xum5a1MoRJzPmjWsWovIqcYKqOcm6qxUL4eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB5439
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Burton <paulburton@kernel.org>

When >= CM3.5 output cluster number.

Signed-off-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>

diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index bb43bf850314..a66e7705315d 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -12,6 +12,7 @@
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
 #include <asm/idle.h>
+#include <asm/mips-cps.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
 #include <asm/prom.h>
@@ -282,6 +283,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "kscratch registers\t: %d\n",
 		      hweight8(cpu_data[n].kscratch_mask));
 	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
+	if (mips_cm_revision() >= CM_REV_CM3_5)
+		seq_printf(m, "cluster\t\t\t: %d\n", cpu_cluster(&cpu_data[n]));
 	seq_printf(m, "core\t\t\t: %d\n", cpu_core(&cpu_data[n]));
 
 #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
-- 
2.17.1

