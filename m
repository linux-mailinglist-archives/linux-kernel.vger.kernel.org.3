Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A74E547B90
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiFLSqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFLSqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:46:45 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0315C857;
        Sun, 12 Jun 2022 11:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhBuoORmUvd+pV9ZaxMl9X4qy+rnGRvM90NU2f2aWKTulIazHXBne4EmqABqmUygiS0M3g1YYGM6+ZA/z5by9iPiimRfRrHUH0G7WYytq12YM94PbVCyJtV7oIbucqjzIy9i+r20rfr7yMJAuAaDDglI2LYgOpV3d31yrhg6UpNDBgF5nXhwHLPfbp4tYXzau6O20UkBF6OhSI/S0i38iRl/5XWgQ2KeaPB9rorADazRX7JIenjAnmzVBH1KSVftN0dYMw1fKs9PUpwCMoBbWeU0jU5I8lOFctRgN4O44Re3uZpcogNKgmF/187Ln7U7dsU9qOyU9ea1eSmvtmFPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6iF86d0klIhnVYVoG4MMBhAtxWA0VNgvmGZaOQZolE=;
 b=MzQJfUthycuTkYwAjykO1G02BN8dGCGh5ga3p9wgewOpTmlMqk2a2wVnA0iS9FvEoX2oDwoxDuo7bgDCNZzGMs8ecAkway4NYNaPvhBxVHuG04G45b5rGVajrNCQnklnWVLpMhLcPV6y4D81U6+d2/sIlbDFw7hJoxBxvHK7YMIe0XOdyY7cQFUi9/0TLpGCnSyS/pFAHgxBP3yCPVTCBXHKElxUrJeAZOejp3qetS3WA5m6IO6b7u26l/F7He+f/O8fiYy9tcDF7xZbQsK+uCLcdEtNdz5jLPU3hKfcFJ3YZ5OYwdeBPxyl4TDXPuSVRNm8mDLs0XZe5hfH3I7hMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6iF86d0klIhnVYVoG4MMBhAtxWA0VNgvmGZaOQZolE=;
 b=K/FiWPq0aObJmLdnRXHrZPOKMIUuHBekJu7sYcOJBw2uztJ3ocE1Qkz8jcL/aTJqGYDnSUH2NUBjP9u6ofWgJ4ajDcc9tgdIfcirBBZIIM7hj35bRnTfRUhHiEcKUuveFUy6EdorvpXhZyzIkP8wFvnhSAr9pQcxUbJ84oYTxqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:111::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Sun, 12 Jun 2022 18:46:42 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::a162:2f17:bb41:c95%9]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 18:46:42 +0000
Date:   Mon, 13 Jun 2022 02:46:35 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        Heiko Stuebner <heiko@sntech.de>, Conor.Dooley@microchip.com
Subject: [PATCH v3 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <YqY0i22SdbHjB/MX@Sun>
References: <YqYz+xDsXr/tNaNu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqYz+xDsXr/tNaNu@Sun>
X-Operating-System: Linux Sun 5.15.26 
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:a03:338::15) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8adcbdc-7f87-4771-a3a8-08da4ca3e474
X-MS-TrafficTypeDiagnostic: OSZP286MB1063:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB1063A24A5C553A373667669ABCA89@OSZP286MB1063.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtS3fzECMExrKFo+Cq105poPLucDKJAFdzgLeodCIq8gpdK34dgT7GEbpZEQJA/WHjPKOfJqIv5Lf4cH9TCmEL/k0ol1niasdGFRhFiM9M4QV2rCLSdBp7AEyvqxnkdBzNO16aZu7C2M5sBavK/hyjBdLv5v9FigOmlz5SKF+uT6+Mujx6zsl6DSzrdM5j/U46bbAmSO93XIAy80JUbmwiFQLKzYURC7a9KxPDeGKsPgA6cESVC6oxM9FVkXVki2OR0jRhqLqKT5fjudZhkpdKp8aZ2DePX/aJnpQbf7gqeaGXcwkMT3zl1bf3mPKUy/VzZwYi7XuFdGyYvxy3dMUFOKnITlh+xXYGdJDVw17xIwQu6w3nY9W2wrio7H/CLYbr7a27jql+p7Z/zJpNVr/z/X7eiZFYgfbu4VJoeG5ccgsB1iu3jlQRpUq3sEtCAyJA47ul3FDkq63pbC7z3h5S5rUo/eXkNX/XHsu1MsYX3VBMEWFi+pIZ7MDNi/eneVqnF4mzzuUuJlxnYw/SN/39C3U2OmjqKxR0WoWWlRcUHn4BXS1yBHGCignY1Pn4tXeh+yXMGsQThHo/ug7PS3HwfcEWbUNfIsdYGZkndMqlNbzw+z8oBFuSmMbguqy51yDPyHgWaiZ7sf/qIi/TvxdANS62sU4EYpUfKRNBqtHe+4H3yT1MxuaKxWivLSVC+nVP6Aef/p8c6Mg7q98LGsnuoSORZ8mtJ3qiXhlqFRZSiV0zcVwHjxXjjYTPCtLmjYumS3zV0ur9gDMen+cNsHqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39830400003)(366004)(346002)(396003)(41300700001)(41320700001)(6506007)(52116002)(9686003)(6512007)(6666004)(786003)(316002)(110136005)(54906003)(66946007)(66556008)(66476007)(33716001)(6486002)(966005)(86362001)(508600001)(38100700002)(186003)(83380400001)(8676002)(4326008)(2906002)(7416002)(5660300002)(8936002)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72ccEPmFxyu3JYVa5s4l3Tb6fW3wT7tQCTkJteyQlQRE3YnDs42SlZEhCC4m?=
 =?us-ascii?Q?FNbFl6mZ5vQ9okV+JWfYaINE8dIfveF9hLlQlu66mMdLFRWRIgZdbTYLHWbO?=
 =?us-ascii?Q?GG+BxE3DLyGiy+TGHFA/BZfUU7JPbpmgJyy22NyKZrjbd8zW5DzHpeaBoaWL?=
 =?us-ascii?Q?0nGfMpI5j0iM46r+mTzclOI5vuMXTwGobH0+EZ0sRFc291zO9laNXphFZOWg?=
 =?us-ascii?Q?mLO+mOEooVXBl3iYp/pa4sGBT4CLUOEazrYCjcXvppwxqiEbSID+swPQbvkQ?=
 =?us-ascii?Q?02bXHH7BxGv7elc00i6JJj22Y36Tlygo+8l/JqkEEHN56WzuFg/O7TTNgPUz?=
 =?us-ascii?Q?09OkhhRb4hc1QnGDt8Dwt8Zr31+FCqBMpKZtqJlKNT3o+EgLdMHscsnkXZLM?=
 =?us-ascii?Q?WV81Y7OJVunnO/WhUBNfJEyZKwSfTynxznFQqLD+7rcfjjMEbZALQtdA/Ljr?=
 =?us-ascii?Q?uY3pchiBKc/z2mj74jbZ6wJnHLhFPjA+ysZi3p/6zmtLiSWQtQz2VuN/GHwi?=
 =?us-ascii?Q?Xp4UyoYmqc1Fu3xsczUJE9zG9Wbg8DCv8yQ0m0fuYKDJPcWMDr5dCT9XrlU0?=
 =?us-ascii?Q?B3o0JtVI0Yt+aU1jHi/UnaN853DSHSwaqXcT80rkTOmN6lZ9kSbYUDd1sDm1?=
 =?us-ascii?Q?Un7hgs62A7Fp955WzGptVxE61hPVyuxQ4rzxhP6LmXtWzQqmDBu5e0G+8da1?=
 =?us-ascii?Q?rFsb7gvzxxwainR52pzX1wdsFIMXJOmZd+qJhpRGkuPxzTPmnhQcIFCrhaWL?=
 =?us-ascii?Q?OOR0rqxWJHjsrVV8BAqHJe/9UZFaKkONUUDRs5OoLNYKx5pJ5My8grk21w4D?=
 =?us-ascii?Q?liaeKcXnXRAnABycJsuFlMviZqGPsq5YJXDmBlCOA7Cf2upY1sU6UKogioZQ?=
 =?us-ascii?Q?ZQqFmzZO60e00p94U0wUeuTYR4UDcv0jq1xI5+jd1759jygqnIuq9Q4m2Dlk?=
 =?us-ascii?Q?Ce+YYy9yBJw1LRsFUOV9u1Uk4Zn/F20lYD3cSRdlY3q7vAHFq2Pex7uCWSX+?=
 =?us-ascii?Q?PjUebQ1eOx1ydj75L33W0uOCOseFcQ7B/jMZv8L5nDgppx2YkO8BBe88MXxY?=
 =?us-ascii?Q?DxKMU5wd5cLhvuOVGSL+8IFa8R1KTfjHasrWIUjo26/KvqYPLbOTX43pj/E5?=
 =?us-ascii?Q?GG1t+fzA/B1dqUx3V95nJH9NfMihnkNlscu4SXkoLU8VcWJihgaR/3G6e7Ir?=
 =?us-ascii?Q?JCwHXkp6FT71/deBCaQPyBHWXudAakuLNOYImzOlBvYEdygLPmOsKO82+ZZQ?=
 =?us-ascii?Q?ol76v2mX3yiZD6iBrA7VeRUCwGlsWdVidoTPWsTD+lN9XlsaMrdtZsrT97lY?=
 =?us-ascii?Q?hmU/mZlPD4ktJ2EHl3cLGRGuwUk2VFxbr+6mx/x+4Ac/r55zKEIkU4JX4EhT?=
 =?us-ascii?Q?kK/WwPNmiC2lsRmW/tzHmATWJ7qAmw/A82u9K81Rgkb0tD2qhv/XQ7FA4WBg?=
 =?us-ascii?Q?GaPp+MwndffTHB+Xhu23/K38EZyeZD5L4ALb77iyB7DI6tilgGDc9nTZUlI9?=
 =?us-ascii?Q?xFVly+HASYFOQsaVx+jQfasAp1IXxqR0FtmPfkyFGQ5Mg9xo0XqaqsFDv88A?=
 =?us-ascii?Q?72nQuLtILyyrVedm8gjlPG7/x6xFcooBbWhDBX7sXmVqp8qzwmuztBBF7cqh?=
 =?us-ascii?Q?7GJkjG/MszPN517piaw3AMbGYAURbCFvOw7Ir/ZovrODSSCtyS/3yh48RZ/h?=
 =?us-ascii?Q?4QAAa6/X3MKf/LYGuPBOPR1Y3iC6Aq0p9YPtrfQgL3ZD3hcaXXEJHcvKKhpc?=
 =?us-ascii?Q?5n6fXSItXw=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: a8adcbdc-7f87-4771-a3a8-08da4ca3e474
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2022 18:46:42.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R50NL+1EL2nhqSl2wvcDOstg3ctZapYmQUWktGc1llzEL7FBb+1NWtXfJ5X1Tfm0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

userspace currently lacks a way to detect whether the
platform has Bitmanip/Scalar Crypto capability,
this patch adds an interface such that the userspace
can detect it.

RISC-V currently still has no mature mechanism,
but no matter how things in the spec changes,
(no matter how "M" mode things change), the kernel
still needs to offer some API to the userspace.

More discussion can be found at
https://github.com/openssl/openssl/pull/18197
In short, userspace currently has to use env var
to detect them.

This interface does not make any assumptions about the
underlying hardware

Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
---
 arch/riscv/include/uapi/asm/hwcap.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
index 46dc3f5ee99f..bfed3e5c338c 100644
--- a/arch/riscv/include/uapi/asm/hwcap.h
+++ b/arch/riscv/include/uapi/asm/hwcap.h
@@ -22,4 +22,26 @@
 #define COMPAT_HWCAP_ISA_D	(1 << ('D' - 'A'))
 #define COMPAT_HWCAP_ISA_C	(1 << ('C' - 'A'))
 
+/*
+ * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
+ *
+ * As only 32 bits of elf_hwcap (in kernel) could be used
+ * and RISC-V has reserved 26 bits of it, other caps like
+ * bitmanip and crypto can not be placed in AT_HWCAP
+ */
+#define COMPAT_HWCAP2_ISA_ZBA   (1 <<  0)
+#define COMPAT_HWCAP2_ISA_ZBB   (1 <<  1)
+#define COMPAT_HWCAP2_ISA_ZBC   (1 <<  2)
+#define COMPAT_HWCAP2_ISA_ZBS   (1 <<  3)
+#define COMPAT_HWCAP2_ISA_ZBKB  (1 <<  4)
+#define COMPAT_HWCAP2_ISA_ZBKC  (1 <<  5)
+#define COMPAT_HWCAP2_ISA_ZBKX  (1 <<  6)
+#define COMPAT_HWCAP2_ISA_ZKND  (1 <<  7)
+#define COMPAT_HWCAP2_ISA_ZKNE  (1 <<  8)
+#define COMPAT_HWCAP2_ISA_ZKNH  (1 <<  9)
+#define COMPAT_HWCAP2_ISA_ZKSED (1 << 10)
+#define COMPAT_HWCAP2_ISA_ZKSH  (1 << 11)
+#define COMPAT_HWCAP2_ISA_ZKR   (1 << 12)
+#define COMPAT_HWCAP2_ISA_ZKT   (1 << 13)
+
 #endif /* _UAPI_ASM_RISCV_HWCAP_H */
-- 
2.35.1

