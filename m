Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980CB52C3ED
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbiERUGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242255AbiERUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:06:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66604DE31D;
        Wed, 18 May 2022 13:06:10 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IJg40j027170;
        Wed, 18 May 2022 20:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3JgnKZ+mUY8j3RzKtqkPm7SfmQ/4kc4VFfN2P1P7R+Y=;
 b=dqXvk20tEiZUqHLLkaX5D1EU/2uE7ATIxr+9QviFm6B+FpVw5YeYrIUZyVj1YHQ0jfVJ
 ZJN8Xfh/4LqFx1h3x6E3ilVMS9nRa5FhSSF+pDMl30X8NlJqh5EuuWprgGC/ErDIgOpJ
 wmVee6kiLg0onTd+ovGL7MEPcBElhHIk54N4WfW3+tmnLXeVQrUwhnlnTvuWePTXmesx
 hhGVvhdzz5FuiVsU8wdE5G+MYfWKCwDja0+A8jrO3a1R1uauP6DRX0if0ycte5ICrMzL
 Myr3RRaVmSIR3wk/tug7DHgGh5jZe1txf/5jo3J+R+1Yz9yNQ5WBmaot4HLkAd/ycyrn WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g576agh57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 20:06:02 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IJmUFw015763;
        Wed, 18 May 2022 20:06:01 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g576agh43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 20:06:01 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IK5LXX019229;
        Wed, 18 May 2022 20:05:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429e6gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 20:05:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IJq2CJ18940372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 19:52:02 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 095CFA4051;
        Wed, 18 May 2022 20:05:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB2C1A404D;
        Wed, 18 May 2022 20:05:51 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.77.53])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 18 May 2022 20:05:51 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 19 May 2022 01:35:50 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] powerpc: check previous kernel's ima-kexec-buffer against memory bounds
Date:   Thu, 19 May 2022 01:35:47 +0530
Message-Id: <20220518200547.655788-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: biRZhQYwiHimDKKLP5rnfJK5_zi4-rMx
X-Proofpoint-ORIG-GUID: 3sWKm3k6UXgfSfcunPfsLO6XWtqpMRaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently ima_get_kexec_buffer() doesn't check if the previous kernel's
ima-kexec-buffer lies outside the addressable memory range. This can result
in a kernel panic if the new kernel is booted with 'mem=X' arg and the
ima-kexec-buffer was allocated beyond that range by the previous kernel.
The panic is usually of the form below:

$ sudo kexec --initrd initrd vmlinux --append='mem=16G'

<snip>
 BUG: Unable to handle kernel data access on read at 0xc000c01fff7f0000
 Faulting instruction address: 0xc000000000837974
 Oops: Kernel access of bad area, sig: 11 [#1]
<snip>
 NIP [c000000000837974] ima_restore_measurement_list+0x94/0x6c0
 LR [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
 Call Trace:
 [c00000000371fa80] [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
 [c00000000371fb00] [c0000000020512c4] ima_init+0x80/0x108
 [c00000000371fb70] [c0000000020514dc] init_ima+0x4c/0x120
 [c00000000371fbf0] [c000000000012240] do_one_initcall+0x60/0x2c0
 [c00000000371fcc0] [c000000002004ad0] kernel_init_freeable+0x344/0x3ec
 [c00000000371fda0] [c0000000000128a4] kernel_init+0x34/0x1b0
 [c00000000371fe10] [c00000000000ce64] ret_from_kernel_thread+0x5c/0x64
 Instruction dump:
 f92100b8 f92100c0 90e10090 910100a0 4182050c 282a0017 3bc00000 40810330
 7c0802a6 fb610198 7c9b2378 f80101d0 <a1240000> 2c090001 40820614 e9240010
 ---[ end trace 0000000000000000 ]---

Fix this issue by checking returned address/size of previous kernel's
ima-kexec-buffer against memblock's memory bounds.

Fixes: fee3ff99bc67("powerpc: Move arch independent ima kexec functions to
drivers/of/kexec.c")

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 drivers/of/kexec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index b9bd1cff1793..c73007eda52d 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -140,6 +140,13 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 	if (ret)
 		return ret;
 
+	/* if the ima-kexec-buffer goes beyond the addressable memory */
+	if (!memblock_is_region_memory(tmp_addr, tmp_size)) {
+		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
+			tmp_addr, tmp_size);
+		return -EINVAL;
+	}
+
 	*addr = __va(tmp_addr);
 	*size = tmp_size;
 
-- 
2.35.1

