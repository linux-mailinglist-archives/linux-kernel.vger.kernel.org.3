Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9B52B5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiERJ04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiERJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:25:56 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C16598;
        Wed, 18 May 2022 02:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSuHhjcuOnbJ6j5zhJvCyVRLCmZ/Z3AL7Pv985Hdyi8RIVqdqu9pXqL/Cpa5pHTMYptmIOr1eTRx2RrheJvniLL8AxqNeZzgYMk4wJMH/p352oxzPA+EpXVGtKxNnyFvEm2SEx1lJuXn+xw2Nza+EP4XicUVHjzlPZm9/rRCj3qqJ4eYNKz1Crhco1byx8QTK1KSmYeL8Kd7tVzdgZBvQs+wX+gckmWLpPz6sUs0SLspxeKpoxisbx+6vud3f+CLZx5shM84v2xVJ3Z8JdgJSoHgEiZI/NZgDRbuklhE1Q7g1tdi57k5aYwy1Fay2iZtxelzRxci3auYZ8ufhA9hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmgCsUrRFQiDkhjhuP0NOx/lzAJkFtwARE4FbvL7+C0=;
 b=VPdgp4A8FElSkPDXG5gJEL4Nwig/wZDU4pl1m5bnHO2poaA1ikn0XrlJXesWypYUwprsHUP0duEq5I31HkApDIbFE3OUq8jPv5SL9ZcXraN9CdIsjsn2KdH/glLe7fZbozIiBUbgFLEmyo/XG9nzB6zIKjoCG/1ZB/PquKPSzAvQT8fPAZeFy+admZ6Dw/3h2SwV3ALe/GmrJ9SBI2YZzG5P7yJ/pa+YzmyhDiDlx6iGKvWl/gSQdzPIsvJv7hOlKKe6i2niUqYMDquQVAlAeAJ38mBTLNb7eNUlZLP29gaANhifnMVaBhK5iLJ9mvQ4yL+WSwV3QZeIp0O+UaBwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmgCsUrRFQiDkhjhuP0NOx/lzAJkFtwARE4FbvL7+C0=;
 b=JjdJWlhimKCm0NQLXLqh06pvspkyFVdnVpBOXxjSyWnJ9p5kahwcJlnQLW0rpLIRKwZF6IZ8SIU0z55JbwKv+WL6mTF+Ym+STG4Mz/AFuOroJI27wFsnwgdsKLLeGtGsa9eELOLlvBR9mNrZcvuC8bd28Y99YiUO5a9IYkbriQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1324.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:13c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Wed, 18 May 2022 09:25:49 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%7]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 09:25:49 +0000
Date:   Wed, 18 May 2022 17:25:42 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH -next v2 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar
 Crypto
Message-ID: <YoS7lgTmcRT0q9y+@Sun>
References: <YoS6qRhxGuwHmK7q@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoS6qRhxGuwHmK7q@Sun>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33fbae2b-a1db-439f-6746-08da38b06561
X-MS-TrafficTypeDiagnostic: OSZP286MB1324:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB1324E8E61DF4E5A1C0442D9CBCD19@OSZP286MB1324.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+pDy2P4AziHMVYZfxmPZ8NODBj0i/2UVtw2U+y/2de3C9fRPAzb7OYsvUStx1uVP5XwHAZloTFwzPRvE/1FC/wsXpcq/QvFl6R4GITdMMJrQ+dIZsaE6sFOAn14OSEd47ohrizJHS5J9Bi/dvkkp/W7kzxXhXXV9OIoRZjl1LFXyqZqa3Q6AcM1z3A+2Ok/2UvAJc24t1KzjrmZziqFprZ7d9YW6zK12E7QZZbR+xQ4HEsX+NlM57nBz5ErgkZqBDLFVFiy5NM/BeR85P2uY/X9SowV+AlA9dyT3QPydydR1vTYVRHac5/mGYQqp91CqaaxRzM4sogTIyMUFIFlsBSzhxtIjZ39oFWTXStskZ8wrpYfluabGcAQ09B70NK5KZ3dLOxWnnEBlRPhGc7OzS2SJoHD72IO8tpLhGBmgjjYCpEc+f7Cc00F+wWN02JEHPFtISvGCgX2L84Xg6f5GAim6wvfQ94KfMB+M+mahXE2TjbMRKk5m43L7mrIYe5IYf/Sl6dB3tVzcfCc6p6pAEkHrk5NXEml9V3kmMsEjp8JG4djvIW6cpNAWm5VD5iaqC1mbvgdRYvZuY6oRl+j/UTM5GTmPFiAiH3OfI81mOyfxtJpiwH50m/qGWRTunhZ+F4wUwnvuJQJ8Sd/LSoc0vNcnN9MrNvoMTgvfSF9zQAsOHx1MKVayXHw54do+y+K5GKgKkR+SxrctyTutO6gvTMkzN4StrahanakFof93D9kqljCTzamLrmbGf6rkj68QWMumfAN+kCvHC3ujezRpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(346002)(136003)(396003)(376002)(39830400003)(366004)(52116002)(6512007)(6506007)(186003)(38100700002)(508600001)(54906003)(110136005)(6486002)(966005)(2906002)(9686003)(33716001)(66946007)(8676002)(4326008)(66556008)(66476007)(6666004)(5660300002)(7416002)(8936002)(41300700001)(41320700001)(83380400001)(316002)(786003)(86362001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2yELDRNvZXK/b/ENvQEMRJxIt3MEBBwrMDz5J+NjKIr87aNyRIsjPdBtF8eh?=
 =?us-ascii?Q?sWhtVxYp/sY+S9CPaRT//kNoV+ympU5rRXpM4+GBod1L4HqWzK9JPXuKh92s?=
 =?us-ascii?Q?0MDVQ9TYkzifrnKKxQ8N3uKA4lod46mQ4JE6J1GWUskg49q2OP2Iw8JsSFHb?=
 =?us-ascii?Q?Lns2xKsfxMrO7WePpsvz3rBqffdeYBlmAnbiqS/UEugs5XOmeqEbp33v4OF9?=
 =?us-ascii?Q?6NCdQ0B3Q3Irb/LjXtaQCsNDEY14Lm1Lt0RXPiKE1pLnlEABymmuQkPMH8KF?=
 =?us-ascii?Q?VKlXZRRwMfoEKRXAtfcQ0QxSi74CYbu9Ruc02VC//Dn3UJq0+mjO/oqZ7Xi6?=
 =?us-ascii?Q?m6p3iV8V1JbRZlf2+xyEwUtbAH+2+fz7QLbaX20MihWe8v5N3xV7BwgENv8u?=
 =?us-ascii?Q?NC9Dk2eDEgwmPR/Wuqp4E9vTLTnYqprRJHkf26DlNV40h1GAJwsAuXDud9H/?=
 =?us-ascii?Q?rejn343TQH+mW7Y5uV9zeDgz9Z4obbNVxpT2lJbp8Tsv3CzeSSvxaml1yjqo?=
 =?us-ascii?Q?4BnineYXJC/+I13kjXF01IM2zB5FoqU8XXaxvlrXKCzNzgg4qXngxyMjVy8m?=
 =?us-ascii?Q?TByDWJveJHXBEzaOaQp8/fblE73U4kHBom0Hp+Y18Gj4ppU7ZF5K2f7rvUT7?=
 =?us-ascii?Q?QmJIzb1xgzI66841q9QsunRSIpEZyPqCyCbiB8CQ2CFCTjhHrtN5h2WO93P9?=
 =?us-ascii?Q?8je8W1xxQMEYlprylFo/BT29X/zQ75AQ88UnIBu/3WdMaaYqM7ED8mpLndSW?=
 =?us-ascii?Q?agdnQdmCVbWdYlaAtOWXX7kRiazqyAXQyR4NZlgMu9t9ckhpWVs/kdrFRueA?=
 =?us-ascii?Q?iJllIc2Ly4lXUTgPgqcBM97aJ/XokLnezU8VMHYkmGornDKl/oN5m+5T2WWn?=
 =?us-ascii?Q?M4jALbA9orNvqrz3koxPcJqKzkVcgPie1AaigaIPzfbrTV6SVuDeO7Gjf30c?=
 =?us-ascii?Q?/25Pux64EGa2M4oxy1Fx4UmNdo9PMqQCA0Kyei44GhyUf/ZjDitgN6+02SxX?=
 =?us-ascii?Q?ak38f/nr3e6nZciHAKKRWgzSQJJor+fRlszc+1vSzx/AUxdUMiE44Fj9KYLT?=
 =?us-ascii?Q?vbQV2DPYF2BeecJOSHEa+R2e/hG3gmAZ8KGsK24tjyYlewiH26zcEdo5/qsz?=
 =?us-ascii?Q?TJnucbeDUCeqt3ExO4bAS1TDUDQq9P/vZfROJ6HXeitdPFXmYrbCE6Gllj4f?=
 =?us-ascii?Q?AwcrUVPm89mCTTKRdPcG1Km0iWhY5scjHdimyD0mwsIGXotOZon5JWonnlzD?=
 =?us-ascii?Q?OZSaU/wraI0cRZ8McKKBMPc8xf3TDh5MY740c5/2zKM8BYnVe80KSiCEZL2S?=
 =?us-ascii?Q?KskMSm2uzjfqZfeAPpfwXCEZ3IL0BxjCoYsotjRKD2ri12eTuvjkXtUF73zh?=
 =?us-ascii?Q?2BhmOvdLWOee7qTo9l3voKN+KF7Eux5yGSDx6LwxUdZDmdr6/CP4B2hlZ7aM?=
 =?us-ascii?Q?VB/sZ3TU+LCZ+6tVA04S9fL1Bj4QsbqwyJYBp2bfPMpVPV1wmh8TifzUqRJw?=
 =?us-ascii?Q?al0OCsJOOodMplpnV7sxd1w8LQinkdpUb4H9TvdSS0evLjWIPU0QU2jU28mR?=
 =?us-ascii?Q?hnJ/xEN4f6t3/2VQ/hAoW0oH7+CExmOKw+exnTu8SfISwiyP7pBkQABYaN7E?=
 =?us-ascii?Q?d0PjN3JcvFPRGlCfqH1iRNzrFnBwhrjrt1ZYfdBdy+febhW6CJbLOL7fy3Yp?=
 =?us-ascii?Q?1EHF1CIZV4ub7xU75vqvQmiSkWS33/SZUzdj78VpjuHtiOa6t5E7C734279v?=
 =?us-ascii?Q?+4f3lFFEbQ=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fbae2b-a1db-439f-6746-08da38b06561
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 09:25:49.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWKQefj54T/6G1fxPJCnmNcngOuGI/0zb8FsKkmb06bE0gAsPUXxaudqyBGNp8tf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1324
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
this commit provides a way such that the userspace
can detect it.

RISC-V currently still has no mature mechanism,
but no matter how things in the spec changes,
(no matter how "M" mode things change), the kernel
still needs to offer some API to the userspace.

More discussion can be found at
https://github.com/openssl/openssl/pull/18197
Userspace currently has to use env var to detect them.

This commit along does not assume any specific mechanism
below kernel.

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

