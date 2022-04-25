Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B699350EBEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiDYW1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343683AbiDYWLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:11:20 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2139.outbound.protection.outlook.com [40.107.114.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3FD1D33F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuDDmrsliRqCokPWHH8/nfoA+r9cgaEeAX4KrL/6U9a2BEBpgtGIKbxHLojQelE5Kx5fbxPMP8w2qtd0FL/HgxutYiVvc6D6tt08oZ6W2gme/PGcxt2KFp/Wwzbr8aweDFC06GHFwbXMaI7pwpSy/AdoSHnL4QckwI4b5bAlnjp56Pk+FoS0FXHgtS90a/ZQBg4tnP6PS1blEf/Z2BQCxicOaN21STzxX9l7oDRuZx9T5cbO8w34YtVVAOJeUg65T3+YT1DZypXf4J1UHJNxTt4K3JHpMqiAb6nhaPjQQ2mOqjgaZJLHyJTFthaRifSOU4TOsZU/Y8AzGFqtfG2hRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvcgZRKWV4Dxym+Sij7bWePHm5TCOVDlS63YrEoeSl8=;
 b=NypPCg8MdHZ0+MqU4dxBgYJKYCqVDsaMsA1YuuwySXOrnTOctw309FFfBSh3wXoUsRjt9Bp1BOgtHE3jE5oZUzuo51K+r3WlZYGJgWm+HRNdLgbM4m4t8vUKoIdA/otW1SOA+jkU1nsv+Hdq6Ng0T4f23iCEJHSWMaCedl0aikNkluvEv1n196KYdzzeSAGjGf/RhZO18ZHQzm89xApRoijIcims0sn9dnE9Pkzbt/348PZcKESoI/nG4E9/nef29F2IrsG9okGoMK+cuu9ydZJxSDFLCgVDgjdH+s8QxXgaie4jzM/bGUhqMAs3Y7UotpRMAl7lkaxRXcl1IoBtsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvcgZRKWV4Dxym+Sij7bWePHm5TCOVDlS63YrEoeSl8=;
 b=a8suYXZhmULc7aB7BC6ButguQsWt+CDGT0PjSxMXK5AlyrJXJiLaUA+8NhuqllNUlB1dvH9LaU2HJI1e3+sB0MURfCJ1a6gR3Gz+XAYlBE/DQEnU248sJq9i9bEzeGX8teMiRnEawTEPCW9jYJ/MpsJXuU2h9rsf+x2si8OT6vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OS3P286MB0996.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Mon, 25 Apr 2022 22:08:09 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 22:08:08 +0000
Date:   Tue, 26 Apr 2022 06:08:01 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: cpu.c: remove nonexistent ext from cpuinfo
Message-ID: <YmcbwYcSzwLSepWZ@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.26 
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 866e2b10-7b60-48d4-09db-08da270814b4
X-MS-TrafficTypeDiagnostic: OS3P286MB0996:EE_
X-Microsoft-Antispam-PRVS: <OS3P286MB0996FC9A44664C0A5C00894DBCF89@OS3P286MB0996.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yMSBp4cKv0CuV0BU4N3CxWIULR0O5LzHKTAQs6J1TzNkAwpySp3BokZ0YZR14CvAG/ehxcytbsnGFnvabWoOrMReQmhS2Id3bj/pxXHcMZDm+3Xbe+HOXC0M+fO+yBeXjsNmuh5nutj+WOQF5kh0KE62qStsh2mZxlWlg+xyOHxkPxVp+CKs4s1x5x0F+Qa2zEQPeNUItsXfNO+o8MOEyEt/XT6I9cnqKhzfBJuuGy7reYQSQ92un9ibRqn4C3E+FFkND+yce1223F2wIK6cV+JrlDwmIk1/X8WRUfuuZv/xrOjpEDeaBYUMWZNzRzcMPx47UJav02TrwmaZ2LNsE3Obu95yFrt1iY838J5F2VgdcoRfgzq273tfVzWTs5lF/IukvxsNHJ7ZhtY+JpLSQKXpMeVpqRqUUQ5wvL+YXbUSTESiqnwP8yRB4O898qnChFxcM+Jmbi6RjNTzSRvWgLHWmWPaXtrVXicHyC7TSM2eMtHcjXKeAlEMXhKbaZccZZoVJf8ARbCLZLFmTLnceblsSnMeRJ0B3Ps1l8w9rI81XJ38HAslwZkaBVKWdTC2Udm2m7/CSPAkmKASQlF4kUg0daVqwnEhQiLVROGXU8U0gXa6/2qMvDk37MFlZnXN0idVLD5nimwTY76CB1cHtD96zmFvQ9z7hwHxei2a2KVDy1eGjcGvyuTRW9kglKzEXknMwBhWesXWQ1C1nPwDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(396003)(136003)(376002)(39830400003)(346002)(4326008)(508600001)(186003)(66946007)(33716001)(66556008)(6512007)(52116002)(66476007)(316002)(786003)(6506007)(6666004)(110136005)(9686003)(8676002)(6486002)(2906002)(86362001)(8936002)(5660300002)(83380400001)(38100700002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NMJ6S6N1NrNF37027fyG/lWUJEK21bPuZIIhSB9EFJMrzUr2MmJSvlMmj8RJ?=
 =?us-ascii?Q?krGU1fvyA9yX7NokDUFJMx0bgOcRX1s+l38oE1w53v5d/lwA4mExSQ8dmzs3?=
 =?us-ascii?Q?4WegCuSzx0oQCw9t/OoEltPbFlC6qu7gWv73gLyyTeI8Mc/39n+GtDrizHl+?=
 =?us-ascii?Q?iqC/3GhCFc4wJEoG/wwinw0vj5gvdiAoj0MiZldfVE0PHqf/34NA3EwAxM8u?=
 =?us-ascii?Q?/Bmv6Zoaf3GG89DoWl2m72Q46NlCXbQIAw57bo6jUicy+lnQVcP7xbCm/iI1?=
 =?us-ascii?Q?gPQes/HhncywaFDAopW4bgM8T3gCJ8xFH37yMQRUUbEPxjnIGmI3UVxdd6hT?=
 =?us-ascii?Q?uwkvvQxz7AQT8pcOzqMF4lu+aD3qnMdEy25ZJI+ANU+lLovcmKgDGp1GqPSs?=
 =?us-ascii?Q?hLIoaT8ejA5OGHL7DZD7e8V40Cc2JT/qGQCIxVGtFwPZ3/XnXhv/MMagAhDw?=
 =?us-ascii?Q?ndX6MLzf/DWdT+CQlI3OI9gPP5K8Gp77urB2wXVwMaoe43s4Lk8I/+4YzdKI?=
 =?us-ascii?Q?+d++yKQUPAmIZWVOsqoBkVz0HsVD8qu1zqxfY46ZQ8WnRORFoYQyCtwb8QES?=
 =?us-ascii?Q?Bc/n6xdVI/2AmCTmq99bjWM9S57m5yKwyHukZ1UpeSPJwutivYllscjHjIku?=
 =?us-ascii?Q?hmhKr8s2dypn3eFDBef3zqgxHh6UtyeJvfJdmEJSeAGWtofz5UJ8Asoq8ZB3?=
 =?us-ascii?Q?bYYv0ZB+dJoQoF6vnbpJ+6Vzfe31L4yLymw/otmlac6/+ymldIXhf9JBYgFH?=
 =?us-ascii?Q?BzwklquM7SWTlaNMqh8pnss30kbaGcA0pwcYpkudD0ZL00JAPl/1PVJGooHX?=
 =?us-ascii?Q?Zf2yHkvLaEvnkfXuTaf7mCsd9aUnzFTOS2lx6XVjdvKin5yKEDFq7HHXOgMO?=
 =?us-ascii?Q?Esn/Jz+5NSJBmJN/otTnCJrf46Ms2l94KbkQwHverIJas/c0Z21/SKZrOf4k?=
 =?us-ascii?Q?F2Ko9RlInV8MVCqNboQPYc+CwgO04xgtsreJrvz4p/EBzbm9ujgB42EPLSJy?=
 =?us-ascii?Q?V4Og68nFDuVlXd74C2FkQ/08QbU4Oh42grujQtKvmyuugGA/9izkmr3Ojbch?=
 =?us-ascii?Q?PYQw8lQeWwksfG1c/Jqce76dUIgl+LZ/E7/uHYkRftsjo+FUk4ryvxUnlFII?=
 =?us-ascii?Q?z373bmuvmhisaoPM8Mg4JWbOIwbWLsJUmxAwBf3FFvSWgVsiXt1PX6t6N5fE?=
 =?us-ascii?Q?lqGQ7Usz3awT7yj6z+c76w+fiXKJTYAI4F1s/c4DMes7Tqo3dJo2wi3mvB8M?=
 =?us-ascii?Q?zyojTOBbeu29oEWFHHI31bjyLj0N0DBrR57ybDhXbX+lvxfLdTSTtPFn34P/?=
 =?us-ascii?Q?09eKwtWj5QxV8FJ/T1vQPI5GqwEdfLvGy3RmqH5do/+DPbbNadWyN3KuJipm?=
 =?us-ascii?Q?GgyOK+EirHpQFeN7rgejx3dkotiPgDvOssr14kIF+Nb+/4afqCkkJz+JcbQG?=
 =?us-ascii?Q?MQ88TNlXBb3kGHP8Fx0aNqvomEytkVaO8bdpYOYBqw/SmkLogz2+CODwhz00?=
 =?us-ascii?Q?TkwmhcSzXvyzSZ3MJTFPWUezEWPwj2pq9OZARWjlNvRmQUsLaHQLwwISPksc?=
 =?us-ascii?Q?JZOBFDbjJQg2WxA9K+gk9gXE2HtFmFSXDVIQOlvNqf0GMGqqYobNtZHr39Cy?=
 =?us-ascii?Q?iOqlQHA6ahdhE8KBD3bR5AmXOUGyb8GUq+X/Vn+BPlWyhlj8RTj35xBuMckH?=
 =?us-ascii?Q?5I0JDwT7S2tL8WYYJYk09zK6B+0g+icIu1e7cp+6E+cQQBPOEcR0C6srOKkq?=
 =?us-ascii?Q?lzGCXq/0eg=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e2b10-7b60-48d4-09db-08da270814b4
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 22:08:08.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsoxQOQeD046QkejsMWGajcfS8EFLm/QRNVmf59MQBE4Pd8wgeEomxPR2EnZBlOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB0996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no single-letter B/K/J extentions,
as they are never ratified. For P, it is still in
progress and not ratified.

The ordering constraint of these placerholders is now removed
from the spec. By commit ("Delete more nonexistent
extensions from the naming constraints") of riscv/riscv-isa-manual

Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 arch/riscv/kernel/cpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ccb617791e56..53a061ab0743 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -113,10 +113,8 @@ static void print_isa_ext(struct seq_file *f)
 /*
  * These are the only valid base (single letter) ISA extensions as per the spec.
  * It also specifies the canonical order in which it appears in the spec.
- * Some of the extension may just be a place holder for now (B, K, P, J).
- * This should be updated once corresponding extensions are ratified.
  */
-static const char base_riscv_exts[13] = "imafdqcbkjpvh";
+static const char base_riscv_exts[9] = "imafdqcvh";
 
 static void print_isa(struct seq_file *f, const char *isa)
 {
-- 
2.35.1

