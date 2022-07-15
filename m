Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FC575CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 10:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiGOIAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOH77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:59:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52757E00A;
        Fri, 15 Jul 2022 00:59:58 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F7DL0h022959;
        Fri, 15 Jul 2022 07:59:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fVYrmCLytRMdV2BuUoTmeC7LqWv1xHlIm6mX4jyrEIU=;
 b=CaLEcwDAoHcAOweuugtUI4MgffuSpzZp1JePN15H0U2bv6FPP1llgP4oIVCleiIhddvr
 MYeDJtjpK2e6zJEYQuNlaR9unkbYqfXpVMpLZFyE63cW8DbDN/i9iRimShfkWCGx2IWw
 nqUIfF4iQL4YC7oOBwMpQHU2LqYFHSh8I+3SGIQvQ+XNXs+f608q6VWqfM6FZciRQa4D
 324smx7NftRKGwCm8KsQl+OrgA+zo6U90iCiMTi4Qdi/pdD+3sfoLX4RFMxBakU0Y+cY
 itqm3lYIXHEs9G3yM2CT1iZUOtfGzUyjwoF7fC3LgwbCyqIyGAmAriNfxIuMH2HfT1jw yw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb3nd8uff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:59:56 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F7wUPD024616;
        Fri, 15 Jul 2022 07:59:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xj03xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:59:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F7xpca25297284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 07:59:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E28F042045;
        Fri, 15 Jul 2022 07:59:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC1C642042;
        Fri, 15 Jul 2022 07:59:51 +0000 (GMT)
Received: from vela (unknown [9.145.26.36])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Jul 2022 07:59:51 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.94.2)
        (envelope-from <brueckner@linux.ibm.com>)
        id 1oCGEo-0002br-2L; Fri, 15 Jul 2022 09:59:50 +0200
Date:   Fri, 15 Jul 2022 09:59:49 +0200
From:   Hendrik Brueckner <brueckner@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH v2 1/3] s390/cpufeature: rework to allow more than only
 hwcap bits
Message-ID: <YtEedTrWv3Wc+cZQ@linux.ibm.com>
References: <20220713125644.16121-1-seiden@linux.ibm.com>
 <20220713125644.16121-2-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713125644.16121-2-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q_DGKmW8O11JVK0pBqw0XchW-w0XMO0R
X-Proofpoint-ORIG-GUID: Q_DGKmW8O11JVK0pBqw0XchW-w0XMO0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:56:42PM +0200, Steffen Eiden wrote:
> From: Heiko Carstens <hca@linux.ibm.com>
> 
> Rework cpufeature implementation to allow for various cpu feature
> indications, which is not only limited to hwcap bits. This is achieved
> by adding a sequential list of cpu feature numbers, where each of them
> is mapped to an entry which indicates what this number is about.
> 
> Each entry contains a type member, which indicates what feature
> name space to look into (e.g. hwcap, or cpu facility). If wanted this
> allows also to automatically load modules only in e.g. z/VM
> configurations.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/crypto/aes_s390.c        |  2 +-
>  arch/s390/crypto/chacha-glue.c     |  2 +-
>  arch/s390/crypto/crc32-vx.c        |  2 +-
>  arch/s390/crypto/des_s390.c        |  2 +-
>  arch/s390/crypto/ghash_s390.c      |  2 +-
>  arch/s390/crypto/prng.c            |  2 +-
>  arch/s390/crypto/sha1_s390.c       |  2 +-
>  arch/s390/crypto/sha256_s390.c     |  2 +-
>  arch/s390/crypto/sha3_256_s390.c   |  2 +-
>  arch/s390/crypto/sha3_512_s390.c   |  2 +-
>  arch/s390/crypto/sha512_s390.c     |  2 +-

Regarding facility bits for cpu features:  Initially, I used
MSA hwcap to cover all ciphers among all hw generations. With facility bit
checks, it makes more sense to fine-tune and load based on respective
MSA level or CPACF functions that is required for ciphers/hashes.


E.g. like

> diff --git a/arch/s390/crypto/sha512_s390.c b/arch/s390/crypto/sha512_s390.c
> index 43ce4956df73..04f11c407763 100644
> --- a/arch/s390/crypto/sha512_s390.c
> +++ b/arch/s390/crypto/sha512_s390.c
> @@ -142,7 +142,7 @@ static void __exit fini(void)
>  	crypto_unregister_shash(&sha384_alg);
>  }
> 
> -module_cpu_feature_match(MSA, init);
> +module_cpu_feature_match(S390_CPU_FEATURE_MSA, init);
>  module_exit(fini);

which becomes automatically loaded if (any) MSA is available and then
performs this check:

	cpacf_query_func(CPACF_KIMD, CPACF_KIMD_SHA_512

which in the worst case would fail.

This might be a very useful follow-up patch to remove those mod init checks
into the cpu feature.

Other than that,

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
