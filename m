Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE10A51BFA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377545AbiEEMnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377499AbiEEMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:43:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4729B562C5;
        Thu,  5 May 2022 05:39:51 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245COHIc012275;
        Thu, 5 May 2022 12:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=yCdeQV03+xbAyRH96hXQ7AP2UerzPzNHroHg7GfjtQY=;
 b=HJWzhTDOh0ZRozzuYqcRK8gpMuvBsDezpjIBhBa0EDXvr248zHXxeMsg7OHfTe5Fw8p/
 5FV78vmwu0cmRAzLtebYiBYkIUxt709ku9dF0Sei98aqxPwNY0Ux65nUWzmL5CyxmX4e
 ftF9rgErjiDzZXZAqOh7QZzlTCpyOoplctSvmQ9XkPVZ7j4+ehNd1Iak35aOP96sybUR
 EC6+IAJi9N6xfRsTcubz/qMYlhIs4ARd4VNdkupsuIPe1U/4QFcNv0GcmIGMixMDwGgu
 GUnaZfGsrI4M7nFIYZB2fb6akm+ru/kakmj0YuSlc5nNxqHsgxvR3GUGsGd6P+rGUG3T Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvej1ra6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:39:49 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 245CZTV5005918;
        Thu, 5 May 2022 12:39:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvej1ra5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:39:49 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245CbsgU012208;
        Thu, 5 May 2022 12:39:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fv24m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 12:39:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245Cdd9M28836222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 12:39:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ECA1A4051;
        Thu,  5 May 2022 12:39:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D25AA4040;
        Thu,  5 May 2022 12:39:44 +0000 (GMT)
Received: from osiris (unknown [9.145.145.35])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 May 2022 12:39:44 +0000 (GMT)
Date:   Thu, 5 May 2022 14:39:42 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.18-rc6
Message-ID: <YnPFjuBYZw/dj01U@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gfgpQo5AOA8FW-Y7B5t4LZQ6mAIQ2Zx3
X-Proofpoint-ORIG-GUID: azRkqFL_w7P3987WZGZviwFraoMV6g5C
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 updates for 5.18-rc6. Please note that this pull
request includes two s390 specific kvm commits, which normally would
have been routed via the kvm tree.

Due to lack of other patches in the kvm tree Christian Borntraeger
asked to get them upstream via the s390 tree:
https://lore.kernel.org/linux-s390/249d0100-fa58-bf48-b1d2-f28e94c3a5f2@linux.ibm.com/

Thanks,
Heiko

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-4

for you to fetch changes up to a06afe8383080c630a7a528b8382fc6bb4925b61:

  KVM: s390: vsie/gmap: reduce gmap_rmap overhead (2022-05-03 15:15:44 +0200)

----------------------------------------------------------------
s390 updates for 5.18-rc6

- Disable -Warray-bounds warning for gcc12, since there known way to
  workaround false positive warnings on lowcore accesses would result
  in worse code on fast paths.

- Avoid lockdep_assert_held() warning in kvm vm memop code.

- Reduce overhead within gmap_rmap code to get rid of long latencies
  when e.g. shutting down 2nd level guests.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: vsie/gmap: reduce gmap_rmap overhead

Janis Schoetterl-Glausch (1):
      KVM: s390: Fix lockdep issue in vm memop

Sven Schnelle (1):
      s390: disable -Warray-bounds

 arch/s390/Makefile       | 10 ++++++++++
 arch/s390/kvm/kvm-s390.c | 11 ++++++++++-
 arch/s390/mm/gmap.c      |  7 +++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index e441b60b1812..df325eacf62d 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -30,6 +30,16 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
+
+ifdef CONFIG_CC_IS_GCC
+	ifeq ($(call cc-ifversion, -ge, 1200, y), y)
+		ifeq ($(call cc-ifversion, -lt, 1300, y), y)
+			KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
+			KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, array-bounds)
+		endif
+	endif
+endif
+
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,16384)
 CHECKFLAGS	+= -D__s390__ -D__s390x__
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index da3dabda1a12..76ad6408cb2c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2384,7 +2384,16 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 		return -EINVAL;
 	if (mop->size > MEM_OP_MAX_SIZE)
 		return -E2BIG;
-	if (kvm_s390_pv_is_protected(kvm))
+	/*
+	 * This is technically a heuristic only, if the kvm->lock is not
+	 * taken, it is not guaranteed that the vm is/remains non-protected.
+	 * This is ok from a kernel perspective, wrongdoing is detected
+	 * on the access, -EFAULT is returned and the vm may crash the
+	 * next time it accesses the memory in question.
+	 * There is no sane usecase to do switching and a memop on two
+	 * different CPUs at the same time.
+	 */
+	if (kvm_s390_pv_get_handle(kvm))
 		return -EINVAL;
 	if (mop->flags & KVM_S390_MEMOP_F_SKEY_PROTECTION) {
 		if (access_key_invalid(mop->key))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index af03cacf34ec..1ac73917a8d3 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1183,6 +1183,7 @@ EXPORT_SYMBOL_GPL(gmap_read_table);
 static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 				    struct gmap_rmap *rmap)
 {
+	struct gmap_rmap *temp;
 	void __rcu **slot;
 
 	BUG_ON(!gmap_is_shadow(sg));
@@ -1190,6 +1191,12 @@ static inline void gmap_insert_rmap(struct gmap *sg, unsigned long vmaddr,
 	if (slot) {
 		rmap->next = radix_tree_deref_slot_protected(slot,
 							&sg->guest_table_lock);
+		for (temp = rmap->next; temp; temp = temp->next) {
+			if (temp->raddr == rmap->raddr) {
+				kfree(rmap);
+				return;
+			}
+		}
 		radix_tree_replace_slot(&sg->host_to_rmap, slot, rmap);
 	} else {
 		rmap->next = NULL;
