Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E9A4A8B44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353278AbiBCSMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 13:12:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353273AbiBCSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 13:11:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213GWJNn022031;
        Thu, 3 Feb 2022 18:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nhKHycpMQwtTugvcLuPH3X/j/G7Lvqk36pQtao0ooYU=;
 b=D5EMo0a4g6KYm3Tp6h1+mD1M4wSoGN8yC2jovQ6pPWLuo0MTOnawS+Cfuh/m1casYI9k
 zsUN//H7bHfiTVSjHnr494CB7me9vNmIW0hjQHVvfjTPDjUOSSpBF1rjyuyzHGYG6GBS
 xIgZiFnCmS+Ihvxp6u2QZrikLgjWdAAdD+TkIAgGwRe9YZdM/oLDwt48lx+nylnzZVfD
 kmMz4KMTSXVO0PG5NbB72dUSQGyGO1VYQoPlI7YU+oD671zTD2PF3dxojmxhI5aJ3KcV
 J1LNvPdLzjZF9/6srQwOoR+9fQJXvJ+fz4xFqMLn5vfxDOQKB6h/WzIn3rzcCrwSoeqZ zA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyvcmx4mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:51 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213I3CoQ021812;
        Thu, 3 Feb 2022 18:11:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3dvw79xv7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 18:11:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213IBhab33030614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 18:11:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDDC652059;
        Thu,  3 Feb 2022 18:11:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7944652065;
        Thu,  3 Feb 2022 18:11:43 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     scgl@linux.ibm.com
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        borntraeger@linux.ibm.com, hca@linux.ibm.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [RFC PATCH 1/2] uaccess: Add mechanism for arch specific user access with argument
Date:   Thu,  3 Feb 2022 19:11:40 +0100
Message-Id: <20220203181141.2682997-2-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203181141.2682997-1-scgl@linux.ibm.com>
References: <20220126173358.2951879-1-scgl@linux.ibm.com>
 <20220203181141.2682997-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jn2woPc_1p2MU2Yy7gx3u1tgeyaitvoL
X-Proofpoint-ORIG-GUID: jn2woPc_1p2MU2Yy7gx3u1tgeyaitvoL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM on s390 needs a mechanism to do accesses to guest memory
that honor storage key protection.

On s390 each physical page is associated with 4 access control bits.
On access these are compared with an access key, which is either
provided by the instruction or taken from the CPU state.
Based on that comparison, the access either succeeds or is prevented.

KVM on s390 needs to be able emulate this behavior, for example during
instruction emulation. KVM usually accesses the guest via
__copy_from/to_user, but in this case we need to also pass the access key.
Introduce __copy_from/to_user_opaque functions KVM can use to achieve
this by forwarding an architecture specific argument.
These functions are the same as their non _opaque counterparts, except
for the additional argument and also reside in include/linux/uaccess.h
so that they will not go out of sync should their counterparts change.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 include/linux/uaccess.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..cc2c7c6e2b92 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -114,6 +114,20 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 	return raw_copy_from_user(to, from, n);
 }
 
+#ifdef uaccess_opaque
+static __always_inline __must_check unsigned long
+__copy_from_user_opaque(void *to, const void __user *from, unsigned long n,
+			struct uaccess_opaque opaque)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_from_user(to, from, n);
+	check_object_size(to, n, false);
+	return raw_copy_from_user_opaque(to, from, n, opaque);
+}
+#endif /* uaccess_opaque */
+
 /**
  * __copy_to_user_inatomic: - Copy a block of data into user space, with less checking.
  * @to:   Destination address, in user space.
@@ -148,6 +162,20 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 	return raw_copy_to_user(to, from, n);
 }
 
+#ifdef uaccess_opaque
+static __always_inline __must_check unsigned long
+__copy_to_user_opaque(void __user *to, const void *from, unsigned long n,
+		      struct uaccess_opaque opaque)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	check_object_size(from, n, true);
+	return raw_copy_to_user_opaque(to, from, n, opaque);
+}
+#endif /* uaccess_opaque */
+
 #ifdef INLINE_COPY_FROM_USER
 static inline __must_check unsigned long
 _copy_from_user(void *to, const void __user *from, unsigned long n)
-- 
2.32.0

