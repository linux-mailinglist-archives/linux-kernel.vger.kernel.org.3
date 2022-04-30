Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4D515DE1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbiD3Nyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiD3Nyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:54:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E138866F8D;
        Sat, 30 Apr 2022 06:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHxBNurMNGE0buCWOHfsHk13gTQtFtn68vStkY66oirTYWkNORCi0unLAijOKhEG501hkRUgOpIYKWnHe3z/NNTqh9D/hmDIcWpBYlR6DxVrOe2uvZi02xJnVUXp7vLSVvQCL77VmcIhFv6VaaV37I1YQBxmFZVelbAidMrH/uytE0u8YcUA+wb5UzdTmZDlIpparh7Yx1rLweWuHB3PBZ+OdCYm13ADTSMfC2RDRJMjjz6ntVKaUc8UBUgeGpqzNuDfFUH1JNrx0khsiFKhXOiwBHcUn8tQ0UzL2w6u5P2to8BOVWaCmJCm3xTq+hB4oNypb4wMvPb/zwRd0CDsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmgCsUrRFQiDkhjhuP0NOx/lzAJkFtwARE4FbvL7+C0=;
 b=d8eP2LKw+ByVU+EV6RkJLdlkOcLeQcj/8VNL+h4G0hF6v3IUu2A/DgH/blrgL0Ivqc9b3UFgBAH2pygq437a7G/ZIGzNhBPHssaE5vjwLSlKZX2FAiavnsasMHkf8v+ZAohoQrkEozpRURjNSHosjtWSGPQ1B6QBgazpMWOohdMXu+0d5Hlcc+2mpUDbJxvFFFYBMk83pdGHg9WkzA7li/KydCMk0IjVkd1W28PXoBu8A8hW7eGBp9GVQGS3jIHDYGwn1bxKnySFdNlqnMF+4xFKMG+CjdnouMa1KUf7yiytwv2GRyjc+qkD4/6QmjpC+54M8g55Lfw9WQ6SV2SGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmgCsUrRFQiDkhjhuP0NOx/lzAJkFtwARE4FbvL7+C0=;
 b=AyJPX6NiAe2dK9ODObFRGl/QH01b/mupEujQfHlJ6fWjpSA3fixSOgLB+ipEo2dWpsxn2NQg9eJH7jTGfsOmOmUzuEZVrzSv20wgEuXx8GzyX96hC/2joynUY0EL179978shMzoOFRkM1guVAKOyOUZ99SyIGtsPSy6qmT3pDbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB1559.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b4::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Sat, 30 Apr 2022 13:51:24 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bd99:5c83:e2dc:a8f7%6]) with mapi id 15.20.5206.012; Sat, 30 Apr 2022
 13:51:24 +0000
Date:   Sat, 30 Apr 2022 21:51:17 +0800
From:   "Hongren (Zenithal) Zheng" <i@zenithal.me>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>
Subject: [PATCH 2/3] RISC-V: uapi: add HWCAP for Bitmanip/Scalar Crypto
Message-ID: <Ym0+1dJeppq74fUS@Sun>
References: <Ym0+Erz5DEnB78vu@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym0+Erz5DEnB78vu@Sun>
X-Operating-System: Linux Sun 5.15.26
X-Mailer: Mutt 2.2.1 (2022-02-19)
X-ClientProxiedBy: BY3PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:a03:255::15) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8ba11a-9e21-4747-6a4b-08da2ab083b7
X-MS-TrafficTypeDiagnostic: OSZP286MB1559:EE_
X-Microsoft-Antispam-PRVS: <OSZP286MB1559BED9A1FE4FCAA1D2D41CBCFF9@OSZP286MB1559.JPNP286.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgxlnJNqf8Wa11zhqqGI0eXt26A/pe7SIYfej+7A+EV+4nnSlVKjSC/78UWxOVLikmQvCVGqf7OVlOCPYBtjFBQBMtaUmBKHUChWKjJGjH5b8ze5z+eHGRBBL83crHCmRype/h2W5uidE1Vynevken8mFYMGlata/Mp2BWjxRZ5wCyqEEP8GCILAu0QYmlNWf+6hRZmK43lEvfPqUGAI1YBHPrRUYGg80HLqCUUYevFqbn7BOt51x4M/81AP3JTFR2DUGAE679dkfCZ/p0JeIlmx7x/EeARF9xWMNEwiWj551n3ly1D5FUGI0+HTbNzNUHY2Yvm7MplRqGV/ytkeIji0f+xF6kxcsPvkBvjXSlAbpCAKOqgY8+ao+fT2+/Wn/2AkJNrwqKqYLH2U5Q4tYEsDNljKcmsTR1TsMhnTtYE1JNHIMLkc72uI4phNw/fhdfMfTqhxvH4ib+M2SqUV276fWh+0DZ7o0y1ywzYJh0vrLLQVSxE7rpdpJ6PPwn7HNSmbPwxCMG4YYTAkKRHNSpyU/Wqjfb/BLVXkcOoXIt0vPK+W5atuSyThDe3RqjABLkQv5SJjiGa8NA4S0d1kKyy7J+UyWblHMy1ru0LBfdHJdqryctHCsWKlJeL/eBfOCqOvD+y081A28dyIhrLu8okZaId4wyH7R7XCGxIjwW07DDYmreJbtZ+FbN2b4SMGnwW49nq08clS7kaR/u/68N1u0BdiMAZtiissa1gjoze+yn0x2VOi+xOBGrE+N1aQP/kudaI2UresQJkD4ajRB8oXbDIWwh2htL9c2urHQKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(7916004)(136003)(396003)(366004)(39830400003)(346002)(376002)(6486002)(6666004)(6512007)(86362001)(52116002)(33716001)(6506007)(966005)(9686003)(508600001)(110136005)(186003)(38100700002)(83380400001)(786003)(54906003)(316002)(8936002)(5660300002)(7416002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(49092004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?60lVRJIm7eBDrb4HnyO5HrKP40/R6etad5dVPNmDFqcHBOmuIf7ycFtIc4+A?=
 =?us-ascii?Q?iEQ4GnNaN5BT2ePSKekVPWkXaGd2kfpiKrdbHM6WCkzafa8fzST1oMu5676h?=
 =?us-ascii?Q?ieSu9+WIYlIxAGyjMmwsQaVTiF9YMjmvIwjAmsJz+3XGfoW+PbGDLbWKD3yR?=
 =?us-ascii?Q?73iEpkc3YKKxmEfdpbVJ2gFsnD6/2xSDe53o19xBK683cxGlJcUanCgsCOg6?=
 =?us-ascii?Q?dEmW7kYeB7qOMTvHtwCn6gX0l6QLN16elDtRtl4RuEWvx3XLJJBsSSnG+piz?=
 =?us-ascii?Q?nEdINKRz2hzDVTV7lLpQSV11KDIf59im5JDJ3FqhX9kiVGb22yVBdjD4a8gh?=
 =?us-ascii?Q?KXK89fjdPOgurTH5+W9ePsq0fIsbK3dTZ14EEZb7x8j1t7Iv1NTTf6MSIGw/?=
 =?us-ascii?Q?G3KgxUJibsq/ZVDFGd30bKilJ1t0doIGc/uMe+h0LGTDVMZSKNHkcb6JRLf/?=
 =?us-ascii?Q?NZRn2MYfux4y5MuFVk3EuO4fQCwEAEjaz5c0Dp0Pw5mplyjTnnBetvuYSv1U?=
 =?us-ascii?Q?5648v4YPY6lig5WDUgXP1fAKiWU7wFTBNsJy6RfFVYqwTNiUsqMPdeeujhpL?=
 =?us-ascii?Q?anfe9h+kjgh20pFCb40EqCuUUZ5/83bmZlm0GxliWBg6cEK0ekocUrwcW+1o?=
 =?us-ascii?Q?AcOdmMFcc/uAYbYv4sv6Xer4en95QIWKJ00tNyKnwYaPwHT89M/k9OdWRUgv?=
 =?us-ascii?Q?iEx2EOXbJtQBpHVjegXe/a04H0MMMdfZfMIpHT1w86wQICNPXHwimjKlfuNX?=
 =?us-ascii?Q?0R3NuEqddOMKEAzTo73QDz1wOqVaPEsQZW3zcLAq2BmCL5X8wwl6vwZwLLpG?=
 =?us-ascii?Q?gI273lfywHhrwCf+B2F/UES2fcwNMIaOjmfHM/i4CwgLeh31puXYSU0VhGlh?=
 =?us-ascii?Q?pAFL67mXIuyCnVVCvEHIpBKugjbhtZmiP/myICycIMSbgXic+wVf5Ri7gnTo?=
 =?us-ascii?Q?SGdYkAeb3Qb+8kQJUQm3gYVQJA7indRRaDg12Ur/5O5zs5FE6GlHXPx0b4Kx?=
 =?us-ascii?Q?0mTdkLBkNT0PdHj555j28F8Hbgw2ykdeBC4kMPv/sWA633mGlmies3en+XhP?=
 =?us-ascii?Q?OXeuuunPKkRM5szRMYULRCfexltmgBTiNm1lJ2hXlu+khFpVSCdmzZ4q6MoK?=
 =?us-ascii?Q?POd6ygFZxCFN7eNuFVwAB5BC7FD4ouydhSWhZ7ecfYvEZQ0E+QrOvOOFwJWm?=
 =?us-ascii?Q?78heFGms+eeJQQIxy8Dwu4px/k0UwaaXlXoFHoBlAP8I0nJ3PdfUjY0YrlJF?=
 =?us-ascii?Q?CTifX4q0rGRg0hcUkzamIaSc+5fsWVEPIyNkjEKlnPdI1gUsRppLwfYTo3O6?=
 =?us-ascii?Q?bZNhhgq/pFR8BiFIEiRfM53Ot1BpLxZj9m26ieNnyd8sazGGA7XSwbvRwdtF?=
 =?us-ascii?Q?c8QaDBjxRj/cUXPZAx3NHkID4wSwVjBJSHoMfhhJfdgTmh0ZjcOxeIFPEdPe?=
 =?us-ascii?Q?gclZKki5BFRdZjWkWarf9lQ2ReaHINQByVW0yxysRUJF96L26jpC/vnl8b4t?=
 =?us-ascii?Q?wxzSCz9IUahZSGq7Afkzqgmv0kAatoH4yKPJYWKqSzv/esXpBsR41WbSWgT8?=
 =?us-ascii?Q?am70TxZ2vXJYArh2JhgOBtozJ9xD8wl5LagE2vFEAJ/QRtM8/U4EZHgpS+DM?=
 =?us-ascii?Q?WCDId7N89pEP+ZXbw8Kgk7invjjQi1nj/zp8B5WjDO53pMfwSXHu7P1I/7W2?=
 =?us-ascii?Q?RQ1MhxHrbajaIXSTTHgwedZekfh5Vq7yhFp1K0Q4gwgS8DDoS/YDAqbyP54H?=
 =?us-ascii?Q?DpuK0YtAkA=3D=3D?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8ba11a-9e21-4747-6a4b-08da2ab083b7
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2022 13:51:24.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HAqmPl28AaZPCa74JvTfsW7h27OpeyX03LNu4HTbydelywpXkGpNXa/Wlk7hrrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1559
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

