Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D8495ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379008AbiAUHcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:32:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239626AbiAUHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:32:33 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20L7CIjw013178;
        Fri, 21 Jan 2022 07:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sa/X22agqvoRs7vfFvCjXvJ1lq8n8/NDjwG4Ir2dd6E=;
 b=s6wjl87UrKyiqk6qG2wKlD69K4ktMxMSqao8oZp4L9D9g8mcSv0AUnTgPIXYBpPKVr7W
 E+L+3NbPgoq+ZH42r3eGTP1LtNFXPybRIB1uwj2GQpMVOULoY4H5tqwnMxrcXyfRH0Ft
 qshmgWpF5w3QoEynqAIOeKff9tZ782epV66E2q0nSVeAVe9aAcxh02WZtenOc2SdqqGx
 /fZFjIPHbiLk+k/KoSAlg3P1471e64pD1S4912Mu3rId34p81iBsNQ+VL2j1EYhQ3v/k
 J75x8cLqBs0ztUqi7cU1LHvCvY+Jtc8GldraoxRG/k21SYgKtgNg8V29tsFz9NrIvvRt Ig== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqr7s8cf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 07:32:31 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20L7IG1P004658;
        Fri, 21 Jan 2022 07:32:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3dqjdpj2tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jan 2022 07:32:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20L7WQAk25690424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 07:32:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2408FA4053;
        Fri, 21 Jan 2022 07:32:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A94E1A4057;
        Fri, 21 Jan 2022 07:32:25 +0000 (GMT)
Received: from [9.171.71.185] (unknown [9.171.71.185])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jan 2022 07:32:25 +0000 (GMT)
Message-ID: <b6896b1a-d529-1504-091c-d41287c01dc8@linux.ibm.com>
Date:   Fri, 21 Jan 2022 08:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked access
 to user memory
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com> <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
 <YegQCTqEsiFTUZ2R@osiris>
 <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
 <YelcCEuVbIg9ND90@osiris> <YemnprCIEjjGFeTn@osiris>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <YemnprCIEjjGFeTn@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RO7iWQhBA4QmDAjDkUUd7W4pExsPtxv8
X-Proofpoint-ORIG-GUID: RO7iWQhBA4QmDAjDkUUd7W4pExsPtxv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-21_02,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.01.22 um 19:19 schrieb Heiko Carstens:
> On Thu, Jan 20, 2022 at 01:56:40PM +0100, Heiko Carstens wrote:
>>> 2. Implementation changes
>>>     2.1 Modify common code
>>
>> In general such changes are done in way that common code is or _may_ be
>> modified to fulfill our needs. Common code header file explicitely states
>> that architectures should get rid of private instances of
>> copy_{to,from}_user() and __copy_{to,from}_user{,_inatomic}().
>>
>> So we should not add anything like that to arch code again, since nobody
>> would expect that.
> 
> Or to be more specific: I think the most simple solution would be to
> try to get the new *key variants into include/linux/uaccess.h, and add
> the raw variants in architecture code, similar to the rest of the
> uaccess functions.
> There is some (sort of) prior art with copy_mc_to_kernel() even,
> though that can only partially be compared.

So in essence adding something like this and then providing raw_copy_from/to_user_key?
(whitespace damaged, just pasted in)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..3b6e78ee211c 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -201,6 +201,59 @@ copy_to_user(void __user *to, const void *from, unsigned long n)
         return n;
  }
  
+
+#if defined(__s390x__) && defined(CONFIG_KVM)
+/*
+ * Variants that pass along an access key. Uses by KVM on s390x to implement
+ * key checks for guests that use storage keys Must be kept in sync with the
+ * non-key variants from above. The only difference is the _key suffix when
+ * calling raw_copy_from/to_user_key.
+ */
+static inline __must_check unsigned long
+_copy_from_user_key(void *to, const void __user *from, unsigned long n, u8 key)
+{
+       unsigned long res = n;
+       might_fault();
+       if (!should_fail_usercopy() && likely(access_ok(from, n))) {
+               instrument_copy_from_user(to, from, n);
+               res = raw_copy_from_user_key(to, from, n, key);
+       }
+       if (unlikely(res))
+               memset(to + (n - res), 0, res);
+       return res;
+}
+
+static inline __must_check unsigned long
+_copy_to_user_key(void __user *to, const void *from, unsigned long n, u8 key)
+{
+       might_fault();
+       if (should_fail_usercopy())
+               return n;
+       if (access_ok(to, n)) {
+               instrument_copy_to_user(to, from, n);
+               n = raw_copy_to_user_key(to, from, n, key);
+       }
+       return n;
+}
+
+static __always_inline unsigned long __must_check
+copy_from_user_key(void *to, const void __user *from, unsigned long n, u8 key)
+{
+       if (likely(check_copy_size(to, n, false)))
+               n = _copy_from_user_key(to, from, n, key);
+       return n;
+}
+
+static __always_inline unsigned long __must_check
+copy_to_user_key(void __user *to, const void *from, unsigned long n, u8 key)
+{
+       if (likely(check_copy_size(from, n, true)))
+               n = _copy_to_user_key(to, from, n);
+       return n;
+}
+#endif
+
+
  #ifndef copy_mc_to_kernel
  /*
   * Without arch opt-in this generic copy_mc_to_kernel() will not handle
