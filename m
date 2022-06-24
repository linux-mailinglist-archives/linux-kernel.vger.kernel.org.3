Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD82955977D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 12:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiFXKOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 06:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFXKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 06:14:40 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2067.outbound.protection.outlook.com [40.92.47.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E20277FDD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 03:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXpCjlElQfainZ7fAXibRzJwcTarplkVD0sFg7deOnE0acS4JfFffFNm3I5TMFRPlE4dVngpnSKU2YsABAlbzdD65dpo6ihUvLrGrwgwdMf8nXjSFsChbH6LcCkpjsq9CQXVt0ewJzVILrDb4ny4Wv1PlExx7Wzyx63ocuiwIXMy/BAj2bA/QUhgHn5sjI4N+QKhgzO015RoUjr9X03jR6SrOsEeYJitlxjDpuFgWjuPhucgCdUV2XMUJ75YMFFNfFdSCMvXKbho67f4uhWXN35bzbFLnCHh11eFlCJNo38ykSr6E2qGdoUNf4YYlk5GoxVYyw6QRpRNpnm0At3VXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=El0PYYyWBMRpGRZ5uhzoNYkr30vmXk2tcLSlu39pT28=;
 b=LoljChZur3mDCHey2zO7BfBsaMedLkXTC6uVCbK+HAk4VarPry+ucuhcPS5DwoXBTAw+hk6L60BFh9HI2hleEKg5TwuouQbceKKLhGdmZT7XhNzy9soNi4r3ROd9v6c/dEdR7sGVzAjo2Bkqeb5amuWTVSdRUiyrYDjfp/gUyHabb+wp/I+Lb2XHU0j1of9FI7Hp7JiFwGfLydevHDgVZ8rT1LWJEzQFRbXPvKNIJnEXJvnX8j8TB5DFjYDyAcAxRgJdJ2CZx0WudQKmhmSwpEFVljDI8jhz5+T7dhHJfArC4iPtULVjojJb9ATxw4jlC+8pMlo26KC+rVaveCxSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=El0PYYyWBMRpGRZ5uhzoNYkr30vmXk2tcLSlu39pT28=;
 b=A3IZZR7zSCdhUcqSXZczzXfhQ6PknCKiwM2KQPrmicdg73fLPiO7c1uRYkDAaD5ugmJnVdaCR66AG9VpJlb289yB8o+pdU2Djm9BgVRIR5DZUQMoL3UynUpFjdjA4A2gMoWLZFrl5gHPmqGJA7twqfdPQFGPlTe8zGhXs42wtE2TqDatlfxZflFzhOc1tQluCCM6UgDRaOqwSIx69Q0A7nUlXtzlQphFmLDEWAhR6UY8f/UQTO4zUKSnv9S4UAa7UQ3wNA5YDHZ4hzr8XRwv/06mBlOYkD8J28dz/kyBIKDG0HRh8AO85mgWjjdHQ3nPvHNMgTXvuIMBdqflNJszbw==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by CY4PR14MB1349.namprd14.prod.outlook.com (2603:10b6:903:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.19; Fri, 24 Jun
 2022 10:14:35 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f%9]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 10:14:35 +0000
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Celeste Liu <coelacanthus@outlook.com>,
        Xiongchuan Tan <xc-tan@outlook.com>,
        Wang Ruikang <dramforever@live.com>,
        Ruizhe Pan <c141028@gmail.com>, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v4] riscv: don't allow write but not read page mapping request in mmap
Date:   Fri, 24 Jun 2022 18:14:28 +0800
Message-ID: <PH7PR14MB55947E9E82EFE9A2817CD692CEB49@PH7PR14MB5594.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [y7AYfvYlilfWeVASV6hlE1X1Jg52DbnO82XT1j4lTnxL1mPPjWiu7SeWIm7EI9mKw6W49t3QSuw=]
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <20220624101428.264493-1-coelacanthus@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe4d5c1d-8295-4018-f619-08da55ca5687
X-MS-Exchange-SLBlob-MailProps: miquGJmX7XWwQsz/XoMH5rg+eqxFq46QFXjx4wlzJy+QxHtTOeC+v2LQSGHsLl74OWKQfxbexJf6viGR4r7f8FgAy8l+c9GhhzXcsEbZjtP1K9Y+sSIrgnTughnsVTESwe5lpJmswTCzrN4OktMAUbv2W+eJVa/fD9vUDMKmbv0d/5FPy03TNFUQIUucq/KQcEi2SmojvRGJEghgb+jhpgk08q8MqtdDrzK2YXnI0Yh7dW2cpfCBMDdlLwQs7iuuAmOtc7sTpGIsM2tW40eNBdGMaNhF757nG52h+eEQM2cTgVdyR8+CkFlWZlpsob9yt5txz+7n9u8IWm6hfqaANai+nxZX1oL46J1tItbkt+atrvXog1/qTlMSZT+G8xqt/DNZrZPRbAC7Vzb6tAef4Fi7WJY4TmU1tgJQ+nNFT+TTsGipt4ivrz88k9FXEAuBKT7+d6gskxdZJwutZtZX8WvXfbNM3T5ldRbgGIsHx3flnA/aarSBe0jo5Z08GS7FPuC65Pn9yUbuMG1NBsF6DWxXjAq6xyrog6DqiH20y7Mmr4V+h6TYJZ9a0Q8xdYY/X1nHFKIh5eH/GdQplUfC6R470KwVfYltCkCPXWI6U0pt6YJ6+ejDXXFqxBJea6tAjY3dewNwOGKXrY+36IrMT4WnBy7llnZlICo4XzuIX12yKWtx1QVUA7eFAlBKwcZSHdIToXnq881wbR3GKopWBN0FWpu/zn6K1JLoQjGXu4GmQVf2SQoGB6ZcefWZAbyhtD0Mc43Hk+ajJG2UOE55qw==
X-MS-TrafficTypeDiagnostic: CY4PR14MB1349:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bih+X7fD5RrqjrUfQksq2CpgmyKVulYhJ5Cy9B85xptOGuJm+KDo2pvehg3yEatfObTSHuJ3+EP636SXJ1yn5AlBhWUoAuDCL9flSeAxrv0WjsLGqMJiF3l/RUcXDA38U0oDWs+S0udGxMJHfmCsNflSSY1SerThPeORafQUGwOeUzaJVxBUBOKn+dyIY61RP2FsazhpgRLzLexjlvsgpQv7L7pJjlfz5bnmGcDAh6ArC8iX/DtSfzQfPb9iwP92QzwhsqIgmoPL8qzAWuHmDwkHJPI/omumhOTNMFe3c2Sjln79IW2mmRh6F+NbTj4QNdxEdrOiB4w29EEMVXVS8Mlx0SAi6Wpmm2tyrtOcA/BXlEpC6qxtjtfg9TLLOfKqBVTFVpyZ1fFMqtI0EG0oSqBV8og5HAsV0tyi3w9jrBzTFT7wmX665I8bPwhh3/HCIhibVelENMsOCmsXcpBHnBJfFyCn7Extrzzs0WfYsQmGwyUyOaD6zgpq6HzfrvXfyS+3D+oQ8i4nvFoyheWdC/aM060mfHOUO/V3/W9Y4Db+xJCe1X4inzREzc5b5iAOjVYYxsS8/CTzlQJK3xIMfVD0X09lhcm4FGBmy0uj2i98nYUC/RwO8194FBjIvWw//YoJl8w/52hTziy4ZHMYEA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Chtog5zusG7R2uNyPSzBph+mMY2j1rxrZHBOtrrFgfx8dgpDwSw8bkVyePYf?=
 =?us-ascii?Q?BQRkSGHWQp3+pAZfSHggnt8P3uEHv9TFVQiarpgJ/wOJ8b+vgCjp6OjrHoRE?=
 =?us-ascii?Q?otqHHiBDaI+zDN0e3TJjyc+mmJIKe4m+81HlIK8bOr88PyH3cZGRRV0jnWqF?=
 =?us-ascii?Q?qSlwGDDmA0Ckh3XD1zWLnICbrSSUV9JO0/jHAf4viredlwr7VkkFNmzmvIDI?=
 =?us-ascii?Q?F+v8/sB/HMoeaoe/SUN2ZuiyHEUMWxF1lHT1VavH4yCt9r8ZaP2cvYf+152I?=
 =?us-ascii?Q?BeW5bNrp15Dh+6rKIxRRc4ueba2SVGOAHvXFjNCkvyDTZYCYQHBo5/kxqhEL?=
 =?us-ascii?Q?66X638QZz9ZEJxUl0NbDknNy1bTjvnQlum5i0nWwrgrHkWfG7jS4vO7x0vsA?=
 =?us-ascii?Q?97J6O40sO+BlaCho2+aSN1Q1hozCm9nmvjMlk36cpJvRSthNr3/IGxWTE/ce?=
 =?us-ascii?Q?GPKNhT2CWBtDfVyKjqGyvtyo+D4QiCq8MBKX6ZgyQEb8TzS1CYQxAVnkkuwU?=
 =?us-ascii?Q?KzwQ8H8cmYJdxIcaT34rwttJCY9WIpd81u5Bs+o8JD4Si26pHS16f0LqU+Oq?=
 =?us-ascii?Q?A6NMtsqgvp87GVlVRGVUh+z2H79QXAG/lEaUdUEzl9SHat1OgbP6Y6Xxhwhv?=
 =?us-ascii?Q?hdt/1PT0gCtUy1s5Ruqpyi28X+Bn5rQNFTHVkCw/Q6nT9obgKWkJudn8BPK+?=
 =?us-ascii?Q?qCP7cOsM0Gb9ItT4M77hWl6vVNAxXOWCzr1PiuTVpMgll/QtVIfYiDcbUoA+?=
 =?us-ascii?Q?v2ED5WZEgUKxQOX+66U02/9sb5AObmUdidju+FdjC0TCubfhnH0R+w083fw4?=
 =?us-ascii?Q?nFGYKbTHFz/gH3hvRo10qOEvMqnkIR5nKODdsixilLXPs218DqLgxiHfj709?=
 =?us-ascii?Q?4YNi9vjQuBqGNASYabnOs7unk4Aqealm67VJMnvNPZAOclLtdvH1ejJhI6c0?=
 =?us-ascii?Q?aokYFB3thqcG6+ylyA0+IM/2GEUe8MmDjl6dQy1HQNMMetT4JCrFR/A8mSET?=
 =?us-ascii?Q?Kv0oNd/e2aDVrE3EA4u0FTNFqHU7VDrGgmsEOO/MxXR5clln/8ENofKR7rWF?=
 =?us-ascii?Q?i7tsUDGYnmoAX8WAvZwHiSipOoaSMtMzqXaEVd4vcML9is55Mj9ho3OQ750s?=
 =?us-ascii?Q?L0RtpFm6EIQC1L1Ya8q0zc8G7fWJedsKnEU/4aAq9S4DVAY2cjBoCcjLiBxZ?=
 =?us-ascii?Q?nlzlYjXSE9EcJeV0ammPyEUhIaTA7XdpxSrWwyqwa1i4p63eRgqyM9ESpIGh?=
 =?us-ascii?Q?iZYqBMWRGTWK2nRRDr4n5Tn7YvHGmYj8ykdVQurnRAMIbdVIPjmgK3H4UCIA?=
 =?us-ascii?Q?uuKHqRz+tYvC4o5Cg4cmSeT9O7TRwwHQufAhXq6vJFhH6Ih3Ebs39sNmUE46?=
 =?us-ascii?Q?UcxWYGQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4d5c1d-8295-4018-f619-08da55ca5687
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 10:14:35.2819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR14MB1349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Xiongchuan Tan tries to run oe of libaio's tests[1], it encounters
a strange behavior: for the same PROT_WRITE only mapping, there was a
discrepancy in whether it could be read before and after writing
(readable before writing, unreadable after writing).
After some investigation, I found that mmap allows write only mapping,
an undefined behavior, on RISC-V.

As mentioned in Table 4.5 in RISC-V spec Volume 2 Section 4.3 version
"20211203 Privileged Architecture v1.12, Ratified"[2], the PTE permission
bit combination of "write+!read" is "Reserved for future use.". Hence,
don't allow such mapping request in mmap call.
In the current code[3], write+exec only is marked as invalid,
but write only is not marked as invalid.

This patch refines that judgment.

[1]: https://pagure.io/libaio/blob/1b18bfafc6a2f7b9fa2c6be77a95afed8b7be448/f/harness/cases/5.t
[2]: https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/riscv-privileged-20211203.pdf
[3]: commit e0d17c842c0f ("RISC-V: Don't allow write+exec only page mapping request in mmap")

Reported-by: Xiongchuan Tan <xc-tan@outlook.com>
Co-developed-by: Wang Ruikang <dramforever@live.com>
Signed-off-by: Wang Ruikang <dramforever@live.com>
Co-developed-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Ruizhe Pan <c141028@gmail.com>
Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>
Cc: Yash Shah <yash.shah@sifive.com>
---
v2: This version adds a link to the referenced spec, and reference of the 
previous related modification.
v3: fix DCO signoff name and add comment for reason
v4: fix typo in changelog and comment

 arch/riscv/kernel/sys_riscv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 9c0194f176fc..f29456cfe68a 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -18,9 +18,14 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
-	if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
-		if (unlikely(!(prot & PROT_READ)))
-			return -EINVAL;
+	/*
+	 * As mentioned in Table 4.5 in RISC-V spec (20211203) Volume 2
+	 * Section 4.3 the PTE permission bit combination of "write+!read"
+	 * is "Reserved for future use.". Hence, don't allow such mapping
+	 * request in mmap call.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		return -EINVAL;
 
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
-- 
2.36.1

