Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B685A3E48
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiH1PPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH1PPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:15:14 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2041.outbound.protection.outlook.com [40.92.98.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3956FD116
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liv6HsYR6TsL0QEAdqxo+PyLm6DqdpHMnsmFhzibPvQbYyodAmdTv/rGPxtKMSTg+kZPcI1tO1378/Dlec1gpXOnnUCdQR0ZXsuFwNF2kK3UqFr7OF1x8Qcnn7dYU5Ob5wL2hoQ6brotSh6O0WGF68XdXw5rMsGiJrb/h+uW1xaaFwo4Qo5QHfTAstIz6PcoANANH63CPkagNj3AfugSVszBLpdaw4RHCqsswZvSozyeoP7LgtgWFRj9FoluVUULn4hM5kI1x+/D9dPJ46/b4OtC2eFBB8z/Flz1LqPQY/2AYWYu8DpcG6HTo6tc3nQYAn03Ex4OusoOhkY/WBnhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKnQft38QxJ6ZtIRD/OwLQFOkrlNaWt7EzY1FxzF4Io=;
 b=KKTCBwc1CbxdPRI5ya8tG2NMLTNGnG9z08IYB0pyJ/k+Pc4PxwW3HDnGejXQ3fOeZsO9bT7MEJ7CGotbVt7s9L8U1AykNJbt7XiSw1MG55tBGWizwKOfbEBwJ/wNi4/zyeA8GwOggrY2N4ryGOf6S+BM+VbC32zeHG6+ZW8ohLcXDScCXRN+cy63Swki0jE5V8hf/B0seGYwb9sonFjeZTN8lQlo4B8C5wsFEt7nOGEO5UfynAGUmeGvUg+wictgJKlXQaaDkxfnSL42GZQbYd0fls8sM2YfTSbtq+5Grc9jT+puF9fySLJsrO7FGZT5RfhaPJAGVehbcfrZ+cVFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKnQft38QxJ6ZtIRD/OwLQFOkrlNaWt7EzY1FxzF4Io=;
 b=GWM2y3KRSiMcVdLy4N9gD4M1iq9RZMokf3uybM+sqkX06FniUPRe8kv+Ff3TMI/O+YJypqtiuDpKtvNt7iWLaAWUSXNRmVLg8bX+OK7QuTBwLEwR3HjR76x6kfTllY6DtJEtuKegEAzN+7O+4pvUlpojKM9ZSbtdvuVO2vo/cYWFRe1zbpT3NI6gZhZyMO55DDrXoPH1AETqaEbpIELpriDaNzq6oP1GT/2jCUqXJFAvk8oc8bmihvU4VzHMU9/5C3wwuvZ7Sr3bz27/EL9yALFaDutquaUlNxg3+hSc7U1ma7ndrMx4pzpq4bIMPdotI+7CAaKnKkz78hrmsYjQHA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYYP286MB2978.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:30e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Sun, 28 Aug
 2022 15:15:02 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::44fe:ca4a:1afb:e2b6]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::44fe:ca4a:1afb:e2b6%7]) with mapi id 15.20.5566.021; Sun, 28 Aug 2022
 15:15:02 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] mm: simplify size2index conversion of __kmalloc_index
Date:   Sun, 28 Aug 2022 23:14:48 +0800
Message-ID: <TYCP286MB2323E622C54B765F087C073ECA779@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hZVdC8DI4muvBzMv7Dv9m01GVaAis2MV]
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20220828151448.1042570-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d70d4f5-2667-41ca-eb32-08da89081455
X-MS-Exchange-SLBlob-MailProps: 70qbaZjg4muK/LAtLzPT6sdxwMOaJnMGsut5G7ZMCtlxo7VrOJmVX/b8WRyURgFytfRxVuk8RSGUU8GjtZb+L8X2cSm5R+usfPkLCQd/eyEdL2zMAbDUn2druGeAeQMCvRa55bXts0Zvl8MFEJ29M1oqYuM7+dTxe3X0TFoPoK7i3KODqUhpAW0cvgAahnRIRBeyBqhW8C9JPMFNX1C1OZwXDr1oLDVCFkcKHsg8w1SaT+w4jST5iTGnJkxUwP7RDr28ah609FL4Q7+c3NwVjBa0yueNrZHa88OxP2mw/d9Tc1xVo3bFfdlYN0+WomDxLVmFLOD5ErluKi+uP+93s8gZj8xyLfSo0qO7Ml3eCDfDD+eyH6uQprHpAlxlZC3hv65fq+PR/v0BlLlN6zn68/WG0/jI0+o32Ie/ZqtRihLglfr5kztKb6JIAb+PHm8qZmM2KZ0twMNroksFYbDaXLmk/zwbYEiYiZySbAcveiP7ecdenECpk1IUXjvmuIfIQa7rrsBpVtYmXn9sDgxuVBlJIWwtYRTQvbGjY2bY7RNV8ScElg6aaViMWIdg9thhb8rd5ppvNgSjkOL0IatrBjdLr4j33+HY0KTes+Qod8ByMXs7LYIjTRQbnP6jW6rlcIvFKkyDsC9jV1EYF7BDjGkKvnFdc7lYuEg7qbMlbNFor32DPtH/JY/+kCKGNqgYBrMjbp2+DsA/Srnl578vd+jq7actKiIdzbcxTxX8jurDX1Q+j67HzQ==
X-MS-TrafficTypeDiagnostic: TYYP286MB2978:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqPMHFYIVh4V67AAB04vaxnYVDmQhpAukPXqjvjxQ8bh+ZC0r15j+RNda0AapMNVjWiuwvdl5OuDBjdVXVluOzDuArQpWOan8ZGB6MxE/Dpcla8L1gHYtStt+giDECpBSmO0vNbJKxLiGDV2qlMPhk91OS6o0BDVTl9gKnanrBAyaOzLpJYNmRKLbmsBoHG7A50wmi67Jl6EbNzZQCfMCRQClfEhxdSEtBZKU8qZ5enIIStdpxgIODbn80jodz92nEX3Af6tE8r/DnuPLQ9MOtLG6pCI7bStbtarwpxJm5gxur4KDPtoYDPOgLKZcrNSJ7Nxy3Gie080pD+Xy0GOlHtHnb7A/nImZr+e3XVapdnfWGE+saqKjPnUbKryCZfn9Mq88pzQ4lchySDyDfBtjTFL0QUg8Uv1sEOUi2tF4s0h3c/456guacPb+4eCPDur/bpg7RhG6Sgj0usUdO4jRcdWH/DaAByx3Xk3/dlwAsokvl8fG0u/STkkkaXwa3rXTY5jHcLW+uFZizHreK/1kjkjJkylU8KhZSPtg3RiRb92qZdtNZS2XgmdkuFUT8zfoaOTs6d4SG4Z7Znm1xC5a/OR4ZL4L6CRoFjWepDqxN4bjB84Nd9o4rsJgJHhXZxbHxdYgGwchrAwCwErjTS6QQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hmw+3cMGKdnv/aCXtfP4WrJxa91TvGzXPPn3me6pI5R3e6m7VI8Wa9MN2B8J?=
 =?us-ascii?Q?4CKNumrAhI0tRwVRgvRplHsXxQ4hQv2xh3l/ONkAZRrab7rriLuZeh4P9Y7x?=
 =?us-ascii?Q?ou9Fp1Csen4y3WMcVtqWgrzeYdPAgTTMOpyt7nVNiAZxIn537tCOCzXpUz5/?=
 =?us-ascii?Q?9bySZzYfp6yQw8YBFJtlUwxlVoqgibtB7+0dZaxAfP/bN4Z7dM7HjI6KDQ1g?=
 =?us-ascii?Q?g0VRTR8I7wzT5oXFTTNpc83zBgZkKj7TELFhy+8qfu56yewVQWSKiIMPiGxc?=
 =?us-ascii?Q?yAWD06KkYDokHlX1b4jpqxXC4C0AUMBGyw1hNbPdyYf8mZPwBgNOnkvNAzGN?=
 =?us-ascii?Q?3tzIzMhcsnlrIwvWEv+6kJo8srkysQ8n2I3txOF/j8aYEqx3P2+5oPJjJy5R?=
 =?us-ascii?Q?9Kd9OKxu/xHjnR6OeencOWD2Hm/XjLnTYJYp23tnYH4KzA4WJRaPXyIQDrjX?=
 =?us-ascii?Q?5QWRoX/LVlxhlkEU+tOWgi4OfLI8fH5TWcMaAn2UyWRxKCDdwP6eQoIw5TUR?=
 =?us-ascii?Q?0M9f3zEcXZg81MD/6WSjP4fttjIczFirvlxh0wVb1nCMr86Kc1Yz9AwmlHjV?=
 =?us-ascii?Q?H/gqmsJVIHSmReihYQwhm+seP1oPegdL8GrZ2LWoM9YonUToERmOdh9AQq8X?=
 =?us-ascii?Q?YMZObENK2Rt/zi1ZlvO0r3ZW0OGxQe2VKLyJ81EfxeqUcYKV+LzEnWffM+hW?=
 =?us-ascii?Q?ucyF4yrPcha+ZD0r8hzfXbfpfLjQUxMPMg74rlK13I0vDSqxhRaEulLTCvbd?=
 =?us-ascii?Q?pMBkssZ2HZOlcF6J6miWL3sYC0V9wHqpvBsKdeOgKXMN3AIiTgoZ8NF6taXE?=
 =?us-ascii?Q?epw45rLQ4QLF+zlSBDbNJseLiwoP+YoidefdIlQykV4gK+hgxNGfNVXAhSyH?=
 =?us-ascii?Q?TVQXv6/mH7DjQ4DUA5QMii0IRyjgLwUJ/st4TbPb/JY6BpoURV7/lCoxd02k?=
 =?us-ascii?Q?v2wYPYFQop7yj+WD6J4cQ9XIhZbul1rKqimjNh4+KGAt0z5b3cvoapJoNJel?=
 =?us-ascii?Q?0ndVQSuqbMnxF8rAoUyYNFg3xWpqvCmGP0Q8YbwcYpc04f+0Dz7P0iVdNFtE?=
 =?us-ascii?Q?Msxl0qZHpYQO3VvnNUgIMLWqUk1cP4G2ieenYKFouDboTmaURhZjZGEC7YEx?=
 =?us-ascii?Q?cO6tQgUdWa13L+qUGp5tU/oNsC0PchTkmYu9rCcCSIR4HF0VD3TbxIzq78A/?=
 =?us-ascii?Q?1sBan7vTI7YgQfiyEK4wvyXr8cd3FfaZyQpjq6MQ3vttt16kT6LwoDupTCQJ?=
 =?us-ascii?Q?UdEoccFrqwS3/BgzyFlfuxLWgU0vDUIbLEXI5N14zA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d70d4f5-2667-41ca-eb32-08da89081455
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 15:15:02.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB2978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current size2index is implemented by one to one hardcode mapping,
which can be improved by order_base_2().
Must be careful to not violate compile-time optimization rule.

Generated code for caller of kmalloc:
48 8b 3d 9f 0b 6b 01 mov    0x16b0b9f(%rip),%rdi
                            # ffffffff826d1568 <kmalloc_caches+0x48>
ba 08 01 00 00       mov    $0x108,%edx
be c0 0d 00 00       mov    $0xdc0,%esi
e8 98 d7 2e 00       callq  ffffffff8130e170 <kmem_cache_alloc_trace>

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 include/linux/slab.h | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 0fefdf528e0d..66452a4357c6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/percpu-refcount.h>
-
+#include <linux/log2.h>
 
 /*
  * Flags to pass to kmem_cache_create().
@@ -394,31 +394,16 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
 
 	if (KMALLOC_MIN_SIZE <= 32 && size > 64 && size <= 96)
 		return 1;
+
 	if (KMALLOC_MIN_SIZE <= 64 && size > 128 && size <= 192)
 		return 2;
-	if (size <=          8) return 3;
-	if (size <=         16) return 4;
-	if (size <=         32) return 5;
-	if (size <=         64) return 6;
-	if (size <=        128) return 7;
-	if (size <=        256) return 8;
-	if (size <=        512) return 9;
-	if (size <=       1024) return 10;
-	if (size <=   2 * 1024) return 11;
-	if (size <=   4 * 1024) return 12;
-	if (size <=   8 * 1024) return 13;
-	if (size <=  16 * 1024) return 14;
-	if (size <=  32 * 1024) return 15;
-	if (size <=  64 * 1024) return 16;
-	if (size <= 128 * 1024) return 17;
-	if (size <= 256 * 1024) return 18;
-	if (size <= 512 * 1024) return 19;
-	if (size <= 1024 * 1024) return 20;
-	if (size <=  2 * 1024 * 1024) return 21;
-	if (size <=  4 * 1024 * 1024) return 22;
-	if (size <=  8 * 1024 * 1024) return 23;
-	if (size <=  16 * 1024 * 1024) return 24;
-	if (size <=  32 * 1024 * 1024) return 25;
+
+	if (size <= 8)
+		return 3;
+
+	/* Following compile-time optimization rule is mandatory. */
+	if (size <= 32 * 1024 * 1024)
+		return order_base_2(size);
 
 	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
 		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
@@ -700,7 +685,6 @@ static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t
 	return kmalloc_array_node(n, size, flags | __GFP_ZERO, node);
 }
 
-
 #ifdef CONFIG_NUMA
 extern void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
 					 unsigned long caller) __alloc_size(1);
-- 
2.25.1

