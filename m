Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC155390F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiFURkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352691AbiFURjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:39:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2023.outbound.protection.outlook.com [40.92.41.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688C81A07E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbrGZPrt5Fb8dAbVZSHn9MFMqDH7c/GeF0S4a+PJgLkKQvBFOiWuoheEkc48myohxAd1U2CDinI2ekBKJ8+qS1VpIRjlVu/dwz05wPz9WL7TeXqpRNmDGo+WCkwIJs+C7oZCAvwaden+wdyqapg7cAdc7zHLqZBD1lUW2w29SrL8nbuCH+O7rms4LvIRky40Mk8lbpWZ4wQ7VV+rt1uSLeevsvwhPMx1WKtEHQZMXgDxQbT8VF2cnq7YLbL0VcBG4oQw1AUQbcQJmY16+aB1miEPtmsfPQ1FZngUj206KGdWVnCga0ytLmXWncvXs6JNuNFHfMMTvbg8N8NJ/R9EIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLsYb9Vfr9Y7JWEXFo+mKMDXssdPROCQmuiO0zrLqZQ=;
 b=iZWpfJrOyHHs6FWVIKFYk0OV2xtdfpsCqBGIU5hs6O81JPRS9BdksmiCuvLMNiJLULhv8jMPFhjgv8mKVnZ9FwojokotKWyUnclLyYzkgX12G8ngkPwT+TyZ2/FIt8UnS64HCYq83lHaWTEEoB9XRWMXUZxnvHERAWhqEeQYloROUwkWtCyLVY6HbfaYAqfen9SZy7art29Qa/75KNoe5b8j2zmDEDWxK13xSAE/EGy9rrzLPa6geXMNmW5NgAIBQNau7emvTr2r/1uAWtAsrTrEXJaPFEMrnWeYeeVKFJsXw2ifULsyrppQIs33fYbQl2dIpb+XPl0TA1Vc7dvklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLsYb9Vfr9Y7JWEXFo+mKMDXssdPROCQmuiO0zrLqZQ=;
 b=oNxM8KjLX2qEybt/zsiA2P5Sd3atMM3/8AlthB6F/DknIOfVS5IQdWgu0hbIQBYvn/nq2NcemxkFX5+TLKexmpn5iBbE4+hYZ9cEhBW8RrHw0EgXzHSpPvY1iELmhCwrmLPcd/IQrKBzVChhrv+wYMJTTUgQL9FQg84LsFFQPooI4GXN51ZQm+XZXXwCZ6Ld/fnWwBfpm1uNc+HpPExzSJTR9harKAVSOoEV2e2HZxKpipVT/2OG2a4fqRmF4KNiMhYwq36a4YBwuVf63Zbkxlbici5p2tvMo/sfRtYVfAXNLq9usWuMTc9K1KnGY6GTQUBrZ8mEX+Lq9tO3ua/d/g==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by DM4PR14MB5550.namprd14.prod.outlook.com (2603:10b6:8:8e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Tue, 21 Jun 2022 17:39:47 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f%9]) with mapi id 15.20.5353.018; Tue, 21 Jun 2022
 17:39:47 +0000
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org
Cc:     Celeste Liu <coelacanthus@outlook.com>,
        Xiongchuan Tan <xc-tan@outlook.com>,
        Wang Ruikang <dramforever@live.com>,
        Ruizhe Pan <c141028@gmail.com>, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 RESEND] riscv: don't allow write but not read page mapping 
Date:   Wed, 22 Jun 2022 01:39:37 +0800
Message-ID: <PH7PR14MB5594762EF0A4B69A1C31D1B0CEB39@PH7PR14MB5594.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [v7yOssjyVlnnmoYgN/Ax650AhkiIYZZz3q9X2fHY1ycdzua9C9j0xNTS0kE+ndI+Mvq77hDkP9w=]
X-ClientProxiedBy: TYCPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::9) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <20220621173937.92702-1-coelacanthus@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83e88a12-a3c3-442b-ee91-08da53ad08ab
X-MS-Exchange-SLBlob-MailProps: ajGO1BpsH8pdkbXaTHEBI4QwGIS8rnhWuIskGzFt2gjBuQEVGs7t3BgZYvyoi3eC6kiYgUZYyHqjTkPye5SWEdc7m82/hKKl2p82oMJ91wmYKkFWmqQ61dEshItvsFZ6bHB2CGsoTdMQVFOwk9J6vIpdsDoDMRmvUnMUm4EveQkOGs2y4CJToRSnVxk11UTgw7Bj+N7OfvXYd8GoMmU4MM+P2QddZ2qGnXlV3y5vFAhcHlR+gGl01APOtwwS0ef3XImYqU8h5tVKBVEeg0+M8t7u/Idr1ZRzOXUIf8hyYNEyR1W2iirkhvIyi8WafheyGLlWxrUMPvEKaLP2+DvOTnmDZAz6YwxbRYonpdtWeVeShfJzFNxMUFBW0YRyRhmdmBxIO4rB0qXAFw+hB7r2ylkyknIR91M5RAscEqwcW80lGB3DPKbmp0fPZdwI/+yyIAqjkt4khvF2TGbVTDfcgio0JF7wYKZYzb8HCymF+nNhB5/2r5vLdxX8Qhl8ge/obCrT3cQN/2lzvaciYC9/hLhVIVtX8H8U/NgFaubO9G9+1Lc3fKb/qP2mQMZlDOmqgXSaNNRU8dJLxJlc1NDNEakZOzhxsb5pReiVbRyGubGs+m1UgZ9atcya80NcEixBHV0ml26b0oYHpAGCreVrefdggXvJgVJzgWfgW+rnvM0t0QssmSgPviY4GWoprc2AVdbMD8n6kWBFS345+pCoVB7yB0dmNg1Kmc4LwqRHYLcksh25WyYkHfEDG9DJKmYXu4+tM4i3fmFT9UDg9oOQVHH2Sbn5T6jQAmBRWpnqZOLDbkCHEZ1zhta58Q4K7beeevaABmfd4XLZFMNnjIy4avjK5yj4UVBA/vqwrx5KrL8=
X-MS-TrafficTypeDiagnostic: DM4PR14MB5550:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a36LLd3jv9E1IYV/TvnBS8bd92PzV6N6QoWiqVttmoaNhfmRnsfulstPGapQNqXbgdSqOUFyUawHLA0zPiUHuYlugogou2+Rmn4+nvIGL31vNqRv1SLj0kHq04QFATzdn6u3qXHw7sQ9s2ALzgcFLWAbOetwEZ/a/v3qeLUU6uc+HA44FJ/ctqCUPelGIfS/veln0LZ+ElMxu+klb5VUR5NmRK4S0sDjpsaaTCIK7UgQ51V9zJp5Tx6nlXJ+roFO5mC2GgzxlANrlb7LmM82I01athRXEVzpLvj70LpioEjiJ8Z+sMqdI4RLGIBmgnZ7QQvDP+7qPLCNVXGtnObAjcpLJtPZsQPDMhcoE6+QZooL5usFacmPzCqrGlMwuTgYqMT/55eLY+/ivFGLc40ZdWJ9ENPWfnbxhNEktjLWei3vnqBIK/mevXRG1Oz5ULfVTjUFXo72SQeqPVL0BsQ/kd1fvDVko2l1puHh370jIs/FWu9asGzOfFZunGqMBjgEACTRFMzm5cwCZ22A14D68iXRNLDiZCtWqfjrMTequCRVUAE81W4HldeYYtNsaYZYp+yNWZDOX4yygybXfBt/oH/4PoNRTvHF1byYJ7vtvNyM20KCKRsBY3qc6U8e2VjiprRLTZ7BPTfefYzisWr07w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEYj51smeNyATC2c7D/s30k37ERY7EXPzPWMlHv51QQqwvHJc6/oKeO9kvpO?=
 =?us-ascii?Q?fRbVride89NvQd0zaOLtwgKKPNyehvmm7yAOH1D8BcAzTQqUslTC4TAolprQ?=
 =?us-ascii?Q?WLrmfazhnkJbPjdcBHtggOskgzegOdmof1U1djVC1wEIXwGu8Yxu3s2AElTm?=
 =?us-ascii?Q?pcz/S17q/SWZLkxiAX5+pFI8MmXZeVgq4J1Av58KT6DWJyLaKBouHo49Kr57?=
 =?us-ascii?Q?pgMvvSVTf3Qp8FllHIK/7+kiKS1hHwTJ9XqoQBL5Tzq9mmJkHbeHyYxJ5UO/?=
 =?us-ascii?Q?FdQIq3l1NHd6LePLqISzLGLqpvyrFloBG5KDuwci4QuO/wOaw9WEHKZKfQ6I?=
 =?us-ascii?Q?VatHZE3f8lJuepoXihQ8siI1z9yz9GVt92J2YNmlTYG3rjFP/FsDak/PbsFD?=
 =?us-ascii?Q?pESy0N/TVjCugHtqeLnTpy2WninwNWGqF2mKXzCHCJ93uN7RCr/wJQYHPk9K?=
 =?us-ascii?Q?rICnJGcEROw1oVrH437vhJhGzyIGPXbCVYIphEQEfs+6PGkwJXbCkXTftwhM?=
 =?us-ascii?Q?r535Kf8WWUYdtroRzQtfGnfOmYa/SwSh1rjDBHWMuOTulkT/PJ9IdTQf0tPP?=
 =?us-ascii?Q?Ggf/4i0dh1Fs6HrwPouhVlYI2Pz26Qqn1Tzbu79arGnAL7nAdtUEtzzWIooY?=
 =?us-ascii?Q?4A0w0+8Nxh3+ZsjRdyJKL6dC1ihU1FENLRSWqa4Fdzr3i8HWaDER9rq55yxP?=
 =?us-ascii?Q?XLRU5wq+9RL7cNqUT9GMQ/wGQeQOqUv7tCZHkk+r44W97//ZjgabmyLIWhTs?=
 =?us-ascii?Q?pwR2maq8b2gdVFdB278y1AdLqdj9+gWqgQgVWeqOHe5VrdmcMbgXjv97zyPy?=
 =?us-ascii?Q?wxIyGiwXkFTlIvpCb0Wy9SUwXFeAPw0K3ogTmJgGCozCnUYN2MSb/zVt0psF?=
 =?us-ascii?Q?aG6QV18ex7fvY4Pf5ydgHCSRTg+yAFI/H1sJHe+mCTR+bdS4g322rjqdR64+?=
 =?us-ascii?Q?I8y4spR11VEdpWToTp7IbXcurVHVdFBEGMv28i2eFdUJXQOWzOB4ZCEb9DIW?=
 =?us-ascii?Q?1578H+bYAHi/baaj/YomPfFxYGyHTLP3n7WktVVeJtudOwryUttiYbqZFWgW?=
 =?us-ascii?Q?AiIJ38aNAOtUOlZTDB8D+j3YYFhZqxKc29tni8zgGo3uMATfXsnZASprYYJQ?=
 =?us-ascii?Q?6t9l1KTlaE5lB3c27VkmfKjPFUK0It6bU0i8bI9zt4DT3ZQq0UC1huMCGpuW?=
 =?us-ascii?Q?04Qm/OVI+0x0jqpgPidV67TkXUMqE533aX8r9IYXhxJ6l3sVzFWSKkLHCTEq?=
 =?us-ascii?Q?Wiak3uVyrSBfQV0QR+aozyDhtz2KTFAGeQa/wpDE+jaaXw2LY1ClibrN4/uI?=
 =?us-ascii?Q?oyOwd0oxl2nCXSVCugYGAvkvwt/DnbsOnDmvQ+DTrtnx2/qFlQbpkffyyOHv?=
 =?us-ascii?Q?aJhQNhA8sj62Ke27gq6WIDHnKpcPaZle2xKR4uyxmnGDZNHZYEYgPgnNoLSe?=
 =?us-ascii?Q?n9yRgeVmp0i61XxiUSxiQjyAjG1jhqVtBKEbfCYPCxVFR+2cDBBWfGSkAmTU?=
 =?us-ascii?Q?TEW3FaRZPAQ0lUoPTcTc0aK7xHMxPj5pXRPe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e88a12-a3c3-442b-ee91-08da53ad08ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 17:39:47.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR14MB5550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Xiongchuan Tan tries to run one of libaio's tests[1], it encounters a strange
behavior: for the same PROT_WRITE only mapping, there was a discrepancy
in whether it could be read before and after writing (readable before
writing, unreadable after writing). After some investigation,
I found that mmap allows write only mapping, an undefined behavior, on RISC-V.

As mentioned in Table 4.5 in RISC-V spec Volume 2 Section 4.3 version
"20211203 Privileged Architecture v1.12, Ratified"[2], the PTE permission
bit combination of "write+!read" is "Reserved for future use.". Hence, don't
allow such mapping request in mmap call. In the current code[3], write+exec
only is marked as invalid, but write only is not marked as invalid.

This patch refines that judgment.

[1]: https://pagure.io/libaio/blob/1b18bfafc6a2f7b9fa2c6be77a95afed8b7be448/f/harness/cases/5.t
[2]: https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/riscv-privileged-20211203.pdf
[3]: modified in commit e0d17c842c0f824fd4df9f4688709fc6907201e1
     (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0d17c842c0f824fd4df9f4688709fc6907201e1)

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
 arch/riscv/kernel/sys_riscv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 9c0194f176fc..e55281b497cf 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -18,9 +18,14 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
 
-	if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
-		if (unlikely(!(prot & PROT_READ)))
-			return -EINVAL;
+	/*
+	 * As mentioned in Table 4.5 in RISC-V spec Volume 2 Section 4.3 version
+	 * "20211203 Privileged Architecture v1.12, Ratified", the PTE permission
+	 * bit combination of "write+!read" is "Reserved for future use.". Hence, don't
+	 * allow such mapping request in mmap call.
+	 */
+	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
+		return -EINVAL;
 
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
-- 
2.36.1

