Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4D849D0D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiAZReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:34:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9756 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237143AbiAZReM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:34:12 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QGNk4w021887;
        Wed, 26 Jan 2022 17:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=2S6RoYOKDgRmPNqvTk3vd39D/cbVKkwgeuHAS2BYmAM=;
 b=cMYAbyu8mAq3p3Pr/FQJ/zBmP8kFeEmvPKs+li1Qxupuz+WeZr4A2oubHHX7y0HHakgU
 6zyxfsOgjiZz2o4Bm0h8C7PxNPH7CqSN5dSfbwcrY0fW44/bJtUUZaKEJCk+SovNDRNJ
 Y5ospJ37evu/4Q60rOiGGj7r0KX5tLAJyuFCysDk8ZcTGYoCBc5G5dtcK1EZHJEpmwcH
 4cRWXf0OqU1h36UMFyvhcYnfTl3E4faThydB4P8g4QbAs2cSe3HerK0vRqkax4/GGJo0
 rQwuyolyam0A/1ymG6arjEsWTNktZ0oWOAcvwH0WrY+6AkGqlqwlIdfq8rxcbdtsBeOa GA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du639ynph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 17:34:09 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QHXwag000538;
        Wed, 26 Jan 2022 17:34:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96jphd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 17:34:07 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QHY1Z137290482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:34:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2E6C42041;
        Wed, 26 Jan 2022 17:34:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B2F742056;
        Wed, 26 Jan 2022 17:34:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 17:34:01 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] uaccess: Add mechanism for key checked access to user memory
Date:   Wed, 26 Jan 2022 18:33:56 +0100
Message-Id: <20220126173358.2951879-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eNFQBrFrISbFTVdKPp7KVazmVdb9mvGZ
X-Proofpoint-GUID: eNFQBrFrISbFTVdKPp7KVazmVdb9mvGZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_06,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something like this patch series is required as part of KVM supporting
storage keys on s390.
See https://lore.kernel.org/kvm/20220118095210.1651483-1-scgl@linux.ibm.com/

On s390 each physical page is associated with 4 access control bits.
On access, these are compared with an access key, which is either
provided by the instruction or taken from the CPU state.
Based on that comparison, the access either succeeds or is prevented.

KVM on s390 needs to be able emulate this behavior, for example during
instruction emulation, when it makes accesses on behalf of the guest.
In order to do that, we need variants of __copy_from/to_user that pass
along an access key to the architecture specific implementation of
__copy_from/to_user. That is the only difference, variants do the same
might_fault(), instrument_copy_to_user(), etc. calls as the normal
functions do and need to be kept in sync with those.
If these __copy_from/to_user_key functions were to be maintained
in architecture specific code they would be prone to going out of sync
with their non key counterparts if there were code changes.
So, instead, add these variants to include/linux/uaccess.h.

Considerations:
 * The key argument is an unsigned long, in order to make the functions
   less specific to s390, which would only need an u8.
   This could also be generalized further, i.e. by having the type be
   defined by the architecture, with the default being a struct without
   any members.
   Also the functions could be renamed ..._opaque, ..._arg, or similar.
 * Which functions do we provide _key variants for? Just defining
   __copy_from/to_user_key would make it rather specific to our use
   case.
 * Should ...copy_from/to_user_key functions be callable from common
   code? The patch defines the functions to be functionally identical
   to the normal functions if the architecture does not define
   raw_copy_from/to_user_key, so that this would be possible, however it
   is not required for our use case.

For the minimal functionality we require see the diff below.

bloat-o-meter reported a .03% kernel size increase.

Comments are much appreciated.

Janis Schoetterl-Glausch (2):
  uaccess: Add mechanism for key checked access to user memory
  s390/uaccess: Provide raw_copy_from/to_user_key

 arch/s390/include/asm/uaccess.h |  22 ++++++-
 arch/s390/lib/uaccess.c         |  48 ++++++++------
 include/linux/uaccess.h         | 107 ++++++++++++++++++++++++++++++++
 lib/usercopy.c                  |  33 ++++++++++
 4 files changed, 188 insertions(+), 22 deletions(-)


diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..b3c58b7605d6 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -114,6 +114,20 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 	return raw_copy_from_user(to, from, n);
 }
 
+#ifdef raw_copy_from_user_key
+static __always_inline __must_check unsigned long
+__copy_from_user_key(void *to, const void __user *from, unsigned long n,
+			  unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_from_user(to, from, n);
+	check_object_size(to, n, false);
+	return raw_copy_from_user_key(to, from, n, key);
+}
+#endif /* raw_copy_from_user_key */
+
 /**
  * __copy_to_user_inatomic: - Copy a block of data into user space, with less checking.
  * @to:   Destination address, in user space.
@@ -148,6 +162,20 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
+#ifdef raw_copy_to_user_key
+static __always_inline __must_check unsigned long
+__copy_to_user_key(void __user *to, const void *from, unsigned long n,
+			unsigned long key)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	check_object_size(from, n, true);
+	return raw_copy_to_user_key(to, from, n, key);
+}
+#endif /* raw_copy_to_user_key */
+
 #ifdef INLINE_COPY_FROM_USER
 static inline __must_check unsigned long
 _copy_from_user(void *to, const void __user *from, unsigned long n)

base-commit: 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
-- 
2.32.0

