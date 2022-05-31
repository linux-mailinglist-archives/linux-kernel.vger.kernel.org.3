Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75137538A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbiEaEPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiEaEP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:15:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB1A90CDC;
        Mon, 30 May 2022 21:15:25 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24V3CNBR018710;
        Tue, 31 May 2022 04:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/9LInnWuKKhNhyYnDHrxS8Xb/Pzojn+6vFD2s6bYgQQ=;
 b=fEShOBfL5Aqx5bUH+j1RTdpFgzM0NMNeFllN+MoSZtbMer6Dj3tW9UxPWMs6+C/+dV9U
 wOsXddb74hm2jEFr9xMx5gKjeZiF9SQXKre+h2vcxsMVLR4n/84aMp9FmB9vAvIytiNC
 9vDQYk4AiDPMIroo/2sqMNQt73SUivP8yt/jslr9BJca6v7N5Fv37FNhHHVC6Wu4lXf7
 RiOUsQo8tX2/pPm8I/tHZ4JN76grDD5sKy1xGK19FP4f7m9eqFryHsnqkbvqULih+7Yx
 OwL2xxCaFJjpj6HqN2hbiIGnr5K4sm77xxLCfo+2uVm8DcOd5hnkWsuQVDgldd7FcZ9d Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdawb8rnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 04:15:01 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24V4CEdn002321;
        Tue, 31 May 2022 04:15:01 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gdawb8rmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 04:15:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24V45RVE029354;
        Tue, 31 May 2022 04:14:58 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3gbcae3fqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 May 2022 04:14:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24V4EtKP22675792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 May 2022 04:14:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4088052051;
        Tue, 31 May 2022 04:14:55 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.43.34.53])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 7D1D65204E;
        Tue, 31 May 2022 04:14:48 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Tue, 31 May 2022 09:44:47 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3] of: check previous kernel's ima-kexec-buffer against memory bounds
Date:   Tue, 31 May 2022 09:44:46 +0530
Message-Id: <20220531041446.3334259-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qcq5m2-7pM6dQbx6vztd7xC-CvMTqTT9
X-Proofpoint-ORIG-GUID: YPdZ-wyC1Vd67mhOjDzMZxRH8o2s6wYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_01,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2205310019
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

Fix this issue by checking returned PFN range of previous kernel's
ima-kexec-buffer with page_is_ram() to ensure correct memory bounds.

Fixes: 467d27824920 ("powerpc: ima: get the kexec buffer passed by the previous kernel")
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog
==========
v3:
* change the type for {start,end}_pfn to unsigned long [ Ritesh ]
* Switched to page_is_ram() from pfn_vaild() [ Rob ]

v2:
* Instead of using memblock to determine the valid bounds use pfn_valid() to do
so since memblock may not be available late after the kernel init. [ Mpe ]
* Changed the patch prefix from 'powerpc' to 'of' [ Mpe ]
* Updated the 'Fixes' tag to point to correct commit that introduced this
function. [ Rob ]
* Fixed some whitespace/tab issues in the patch description [ Rob ]
* Added another check for checking ig 'tmp_size' for ima-kexec-buffer is > 0
---
 drivers/of/kexec.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 8d374cc552be..91b04b04eec4 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -126,6 +126,7 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 {
 	int ret, len;
 	unsigned long tmp_addr;
+	unsigned long start_pfn, end_pfn;
 	size_t tmp_size;
 	const void *prop;
 
@@ -140,6 +141,22 @@ int ima_get_kexec_buffer(void **addr, size_t *size)
 	if (ret)
 		return ret;
 
+	/* Do some sanity on the returned size for the ima-kexec buffer */
+	if (!tmp_size)
+		return -ENOENT;
+
+	/*
+	 * Calculate the PFNs for the buffer and ensure
+	 * they are with in addressable memory.
+	 */
+	start_pfn = PHYS_PFN(tmp_addr);
+	end_pfn = PHYS_PFN(tmp_addr + tmp_size - 1);
+	if (!page_is_ram(start_pfn) || !page_is_ram(end_pfn)) {
+		pr_warn("IMA buffer at 0x%lx, size = 0x%zx beyond memory\n",
+			tmp_addr, tmp_size);
+		return -EINVAL;
+	}
+
 	*addr = __va(tmp_addr);
 	*size = tmp_size;
 
-- 
2.35.1

