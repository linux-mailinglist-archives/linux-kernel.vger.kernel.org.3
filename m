Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA7E548080
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbiFMHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiFMHRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:17:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07olkn2062.outbound.protection.outlook.com [40.92.15.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E8E1ADA9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY7cG9SD347hXcToCGCxyWBcAkL6AYJJOtKtCQ83x7Le4upjMBUxnHmz3RwYpGFB7KYScJBdK7/7tgLyusFhoRTb3CJ1vbBmmTtXZR26nnIM6m8rzlDZ1TIoQz1I/4nv4iXiu5PQW45J5YraInPwJ7mVYduzsRMnE+QwVC4F4cgv7cbL+JEXH3IJCVdHT+G1zlAyy9tEZTGE7hYRY+/T4VcgfrATo/V22YlVD0zSZUoj5ma20KfoPcps5aPfQBX2i8TxXOfekE8a0ov6FJG08VFkbnNgx8Lx7+/y+G1G2JPStArVJBeM7L0Max0XoYna/+8UlbpqS4AYR0J5WUnKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/7DaI+9Ht9GxO9JpXhMlBYIN0g2synHQI9P3OqNzeI=;
 b=Wmu+oXIOFY/sgdNSf//HOLikEakRG7JzdcU2u26105XacRY3ibBFRfwWQa+6yUl8vrZr9ms2dcnZHN9GYT8XcZmLxIrCPBftx98I4Qu0U7jWBEA6lJIeVo2KOeGpQoeUbfC5JiFaEkkuytLVfLxCS5mO127VhoHxswzcvfcXygP1gjYwO6UnKnNxCEVcnm97BB+nlIOJ931EpkDZResFt4sXe6MiObqKfBVt7MN3f1hNyDm31IVUZK5XYhMVYpyPI7+XjcpuAjwqQfhNoDx0owpje/9rddmn8Fui/O0QQVrOtJYhdXmuDlUHUVj+PyQ3XJMMlrEmoOYQZsq+EViFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/7DaI+9Ht9GxO9JpXhMlBYIN0g2synHQI9P3OqNzeI=;
 b=M29uPFlo7p7VloeiolveqGGOiuct0fABsbYPVMpSWRdzpb/W+2pFJ6qgzgUo+Er9d6ogXkifpuQeDyJ0YjKtZm2LxAhKirKif1pPVmnTrH6aYaQHgau+Alxsxjv5xcEnlFbI2kMmVki++fD0S448BM70BwxwgAgfXASc2vPEwYUaDc0S8vkFAoR1OaJLUZeIJZyOYUGVpxvPlvJ4FeGTsn3yL/sZ83odmzicUb4d+2XnAqiz2V4XaoSvRA/7c04Ux+g8qCxrM/HapPoDdyWQfUtsHkVPeS3H5OSvmReaj52GUmbS42TvE/9Nt4AL/YqdIiMCYSqV31V3IIYBi7R7iw==
Received: from PH7PR14MB5594.namprd14.prod.outlook.com (2603:10b6:510:1f6::17)
 by BY5PR14MB4216.namprd14.prod.outlook.com (2603:10b6:a03:1f1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 07:17:02 +0000
Received: from PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f]) by PH7PR14MB5594.namprd14.prod.outlook.com
 ([fe80::ad4e:5917:88d1:c56f%7]) with mapi id 15.20.5332.014; Mon, 13 Jun 2022
 07:17:02 +0000
From:   Celeste Liu <coelacanthus@outlook.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Celeste Liu <coelacanthus@outlook.com>,
        Xiongchuan Tan <xc-tan@outlook.com>,
        Wang Ruikang <dramforever@live.com>,
        Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3] riscv: don't allow write but not read page mapping request in mmap
Date:   Mon, 13 Jun 2022 15:16:47 +0800
Message-ID: <PH7PR14MB55944401F3CECBF340F1DCB2CEAB9@PH7PR14MB5594.namprd14.prod.outlook.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [3SVmB70UxyosvBczflPqGy79onvokkTkcQl6KO3MFn6qtbVNxlZT/YhohBDV8SCT]
X-ClientProxiedBy: TYAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:404:15::22) To PH7PR14MB5594.namprd14.prod.outlook.com
 (2603:10b6:510:1f6::17)
X-Microsoft-Original-Message-ID: <20220613071647.70641-1-coelacanthus@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d3e0db2-9c21-43a3-777e-08da4d0cb626
X-MS-Exchange-SLBlob-MailProps: ajGO1BpsH8pa1ecrZJr5VBzeO1LMF7ZW+cJa9PjbdjjsNWj5/tCvL449Wn2JrtC5+nP8OOjk8JPqBbk/spy30FimV925du8jdq5modm7l/IcXPxsl+YHaXaKnA5KBSxf32H4uFwXwTf6An/3fLBxp8lgSfzJPQQgsuRuTWKm0XGGOZ9uocWj7q+uTI4IoDISONwuA9GlW0gYZjm4VNbf8CyvIhbDpm6sJlaxtLGwv90a5Dh8VaJ2+ieFSK4VbXCu5x+kM8lg0yBPj05iiCGvag64I6Bw6oor9bdCvf+/bayPJpck9DhJbrabsKpn9k233ILPL7JqdNbAdLCjoXpWQpXxviN9+VmNqAJWbvKwD9SeoIzH4ik8bGtBlDB2CbFwtmwX+XCHSsZJ7qs/odg5eBQrr3W7hTqaoC2SvoC5Jd5VbrstiS9cfeCqcwgwgOX/kx7ZaRsk5nvf65USv9eSqXsvA/HQbi4Q9KqECdFdazVXnCaJk/zxzZmhKNPYxlU+0TI+f/sqs9WLTX6EYDZ2kxFFRiaexW+yPCRAH2OQl8v9ObdJkUUHKp8HM4rdB8DvcLy+4iw5qZMH1GqhU+NutqPUBnIlp/6VX4QzCmcDLgaRmh4LcxIh9bBVMGKduFOE1WATcwvd6he66Sb+jLbtz2QbkYH0eYPTV1Mp3BKGFRLQVv1Z472h/+Kb8x7LnK2rWEq40YqAqnUVFjyLVvYA5MIZic9MkMGHBPSTo0EPH6LSsrhJK4/epCxyq7SEbZpqiburWpPlCLAmX95XeMzMsTU0WRJeVXBWUAosVM7FaSlB3t8++SMHE4lWLhc0sDKf02S7AV1WXm/2pbWXNaAshgTiixY7Kk2Ot6M6OxpEMf8=
X-MS-TrafficTypeDiagnostic: BY5PR14MB4216:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oz9sTQVphsNF+uDmvvyZZjS/w79GK0fWKIP+ddn8WNzvA42hmlCgG/Xh7d6ppBBrYc4rIB3bU3+P6XFZ+qlU5RGk6pnpkM3360RYOlGPkcw58VpefVGG2WlLVbQMpX2siZme4yLBdEX85CUjyqkYwbeBQISMrab6F+GCXzyJ6Lr/J5irsYPeBJBAvQDri1WCp59229Mc34QwCDmlIFvBjgEzNWzIT/5/yQzQBd8+QKxyCQC+l9EZBc2zy2Fshlp2FWcRRYs1/i4QkzPpeihRKP30QFYz7dGbrcQlZLTTYWl/xS9fcJLpmj3cBZ1N/1SmW/xJ8tqWGKA0WM2Qp6kdgw1pioDOhbu1x2p1tbbW/VdYxOzql9426n9jkQ478jXvAK4wC3zZY71ObRK8jDt+qBQdg3eq4fOTmcEJqM5h86dDiSQTX0/K+JhD/ScZjl8d9DTevzm4FQf1iSpk42WPacl0NmPLg1k1seFRs3m5OIBWSlGmguw7AnqZVypkg6vGeZ3bDmYt+/k/i/meRS64kaEbUNkKsH7xT0dfYnFffpve8jbVHpGvZd41JPXe7VKX6FeSphd1Avxj/SdDThRNIAwvP8eJ0AWhrl1FiWD1HRBwdqQHR8TIjTQIyiSuXvT3IE//bU5GoEB9nqoXWp6qPD9vgahmJdSFXwcadGPJLxg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKe4cTi8Onrw4tfwjWck97/QYRcNCW0+K+Fwb2kVuscvIqCnMozpNrKc5kBp?=
 =?us-ascii?Q?S/MCqBi2Im+Kz0eYloQXXvb52dijakA0QSCCTjrPUuBdDDOuT9YwjeCrxiV8?=
 =?us-ascii?Q?ra4zrWT6tgcaupcpvWWUWf7dfbfMYb4D5U4MPk+5nWGD3fiN/i6lk+qE+uzW?=
 =?us-ascii?Q?08zhkonBwOaNVYiXLnjhxBRkjUNUJjG2LOW40DHr6HSETubF5j6kLgk1Y4IL?=
 =?us-ascii?Q?JbfVsOav3DxxlvI8CL4FAbFf/hz+uHzVTZihgIw0hhrnF2uA9XXG4sofUkpZ?=
 =?us-ascii?Q?pK2A/Z+jPoAoh97es285YfykM6ayCRPnBC6eGTY5WICDGKnjQvYr9+IR5TRA?=
 =?us-ascii?Q?RTToTrqjGA6zacnixQJcMcoQBwXdzXsO6ycLKus1q3wIT83mKQAgmqz4FW+p?=
 =?us-ascii?Q?ZjrWV8IR4dLJ2RvSLr9n7NjU8aKWOTlU7uN0PEhluaYay1BAFqXbBMfe6EIS?=
 =?us-ascii?Q?hzSCiX6qGLCwgJ9gvj2pHX3vyk2wGI4uXdlg1qJgLI9E8lnCx6SfaYFcVgIC?=
 =?us-ascii?Q?4MpdBONH1pxaZm3JPwq369pJvPssdL2lSJL7+xsfzH3ytVkJoTfrHDkDExmY?=
 =?us-ascii?Q?koEUg6Bs5RS8Z4OozfpPS1zfRYCe/wb1i3TimRLVRszX7f9O4GFIgV7/kXX4?=
 =?us-ascii?Q?S/YxaX44jx5SoDjafuR1QEKkaAFHODViPilC4x8X94nFv2hsl+36i5gbb+Rg?=
 =?us-ascii?Q?9eWz4ujf7pSfijULAGsehuBS0iIRCn+wU43KlWkL0x8NVMXyy/AoB1ahxukX?=
 =?us-ascii?Q?L2OZwSokTJwunNBxyUf5pRPlOGMzFBL53rXg9WrOPkILNn2wEGH07UNx259I?=
 =?us-ascii?Q?1U9FfH6xN3Kx5se6PZHmvWuVT9GotL3rYCbOoMDjJuGwvOjdWzw0sWG+G+hy?=
 =?us-ascii?Q?0/mFbN3awssHHIrF8HIhVnv95iVPdqtrB+wnDgwIY3ba4lEmLB4U2gALTgua?=
 =?us-ascii?Q?MxMVtz1aqW7GyDl+zmtgVsPrbA8vSMoaEfH5iCf/r4zTq+i6gqdv2gPoI3SL?=
 =?us-ascii?Q?Vj+5/n0BVJ9O14ZLt/LmqAXRtenmjrxpPQ7IpVIP/QpHA1maQv9Pjy4vvXJ0?=
 =?us-ascii?Q?T59alBSSPxB2CuJsXU3acy+v9kNZNWePwdpPZq8pj+ZKRoUS0HcczXsjjyc0?=
 =?us-ascii?Q?nN3/7aZYiiZ/H9BxIFt/Z8N+CK5d5sg61LXBJml6qBIAbspnb74Lz9u3YZEM?=
 =?us-ascii?Q?jJJdrBH3ghsIJ2WADk2ngqDWEmS0LE21lnbjkvr3myNztWfwyUEe6/kVdrFB?=
 =?us-ascii?Q?9U90IFmipV0kDeAqYlSecldWO04Je/8c8UKji1+VuXf4FCzGogWk/5Ll8CEC?=
 =?us-ascii?Q?haquL906G2c9qd4koVj1PKZxfuBROiOtayNw/1G90LEn4DNAPgT5YBnFS3vd?=
 =?us-ascii?Q?5gi2MF87LHBRFTNM40ra8oppKk3yW0DMHm1rRyqreJsUTxLhNkgckjwuMXXR?=
 =?us-ascii?Q?M7HRYvbwIj5E6faHNDTVO5Vxo9Sx9RCWQtNJxiG4OmRY23HEVh760gS+xHB0?=
 =?us-ascii?Q?z6pr1XqLvPv+gJZ8kUNomr7XgFj6FaoxZKws?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3e0db2-9c21-43a3-777e-08da4d0cb626
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5594.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 07:17:02.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB4216
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
v2: This version adds a link to the referenced spec, and reference of the 
previous related modification.
v3: fix DCO signoff name and add comment for reason

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

