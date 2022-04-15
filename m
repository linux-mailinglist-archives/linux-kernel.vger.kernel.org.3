Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E0502086
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348677AbiDOCdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiDOCdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:33:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C982C109
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:31:11 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23F02vpN006615;
        Fri, 15 Apr 2022 02:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=BTVLfpS91OirTYAOYzIAt9vxE2todQVU1COH8xR5O98=;
 b=S4DlMbboEz9B8oNrMOy2trrT+A4WgYlPwLU6MDJ/2GPMDRSfPIPLelbgqzs/IwDZwX+U
 /FM8p1e0YUNIlm93qmb7qsLzVWqivCiS6xX5odmOiJt6KiWm+u+Rj33HSNhFVhmvFw5m
 KZNpfRuANBJhBnr1ltih5t6XA56j4gkHapTL/WdqA61nr88Ad/5Y8+HoFFOsmFLOWvwy
 +Hgt3XB0BRlHnSVjN4kN9m+vYbYxQsZLrkHz9+uFRMgXf+Jv/k5YwKsPBhMklZN4PoSe
 23900oAVeZjzraSVIN84ckep9ppsM5wf8/Xuoh5GHWMpn4oeKev4tg9PHVKhd2QOUmMy 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fefh5khdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 02:31:09 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23F2DG70017060;
        Fri, 15 Apr 2022 02:31:08 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fefh5khd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 02:31:08 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23F2HKr5011055;
        Fri, 15 Apr 2022 02:31:07 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3fb1s9k6hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 02:31:07 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23F2V64L7603048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 02:31:06 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEA81AC065;
        Fri, 15 Apr 2022 02:31:06 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37BC2AC066;
        Fri, 15 Apr 2022 02:31:06 +0000 (GMT)
Received: from localhost (unknown [9.160.168.34])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Apr 2022 02:31:06 +0000 (GMT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mopsfelder@gmail.com,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Subject: [PATCH] virtio-pci: Remove wrong address verification in vp_del_vqs()
Date:   Thu, 14 Apr 2022 23:30:02 -0300
Message-Id: <20220415023002.49805-1-muriloo@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i7D--CHoAlxlyPvxrRP4niCQF1_Y5ckp
X-Proofpoint-ORIG-GUID: BVrEAblPwSmqC0-6Y1Q2V8AopluEdRV5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_07,2022-04-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=948 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150011
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 enhanced -Waddress when comparing array address to null [0],
which warns:

    drivers/virtio/virtio_pci_common.c: In function ‘vp_del_vqs’:
    drivers/virtio/virtio_pci_common.c:257:29: warning: the comparison will always evaluate as ‘true’ for the pointer operand in ‘vp_dev->msix_affinity_masks + (sizetype)((long unsigned int)i * 256)’ must not be NULL [-Waddress]
      257 |                         if (vp_dev->msix_affinity_masks[i])
          |                             ^~~~~~

In fact, the verification is comparing the result of a pointer
arithmetic, the address "msix_affinity_masks + i", which will always
evaluate to true.

Under the hood, free_cpumask_var() calls kfree(), which is safe to pass
NULL, not requiring non-null verification.  So remove the verification
to make compiler happy (happy compiler, happy life).

[0] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102103

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 drivers/virtio/virtio_pci_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index d724f676608b..5046efcffb4c 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -254,8 +254,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 	if (vp_dev->msix_affinity_masks) {
 		for (i = 0; i < vp_dev->msix_vectors; i++)
-			if (vp_dev->msix_affinity_masks[i])
-				free_cpumask_var(vp_dev->msix_affinity_masks[i]);
+			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
 	}
 
 	if (vp_dev->msix_enabled) {
-- 
2.35.1

