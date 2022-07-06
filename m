Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FDB5680EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiGFISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiGFISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:18:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59DDF5F;
        Wed,  6 Jul 2022 01:18:31 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26685gK6036271;
        Wed, 6 Jul 2022 08:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=V2CZ4gY54/pQbJxuXJAl8m7gTB+wm6t3bS+kX/vImVo=;
 b=jwlCdiPOIy7I7CjM6N5ZSfxsRTquU3h0+eoTDG+mCAf7KxwfroPezZyg4/Hkqwf5IDK5
 blWH1UIkvVN+zT137bwLeh3E9lMm4JfCPwOgkGaXyiYUU0j6D0yj3lJ07KTyD7tyAVM2
 Ibjl7XBZ5JQ6c9muMe4XoaPQOtXp3sO2qOGUsAPiZEZ3SImYOkA1mAV7z/tIFGDwPowY
 7FtiCtyEg+U+WNNP/V2xcAusXyGNI2ADPj3yvLp4o1P8HIwOiFE9acC0XrLDHvVfy/zl
 +9fr4weqAUfgQ1jzu0oqDkfCOJVGuDuxRxHqowzOX9/bx7lD2QqNtDvnZbqFNt6WVcIH EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h55xfh3j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 08:18:22 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2667a5cn012417;
        Wed, 6 Jul 2022 08:18:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h55xfh3hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 08:18:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26686beW013087;
        Wed, 6 Jul 2022 08:18:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3h4ujsgp5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 08:18:19 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2668IG0615008116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 08:18:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F830AE055;
        Wed,  6 Jul 2022 08:18:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12FF6AE045;
        Wed,  6 Jul 2022 08:18:16 +0000 (GMT)
Received: from localhost (unknown [9.171.42.49])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jul 2022 08:18:16 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/crash: allow multi-segment iterators
In-Reply-To: <3e713ce3865246766feca8397af2860cbe46854d.1657049033.git.agordeev@linux.ibm.com>
In-Reply-To: 
References: <cover.1657049033.git.agordeev@linux.ibm.com>
 <3e713ce3865246766feca8397af2860cbe46854d.1657049033.git.agordeev@linux.ibm.com>
Date:   Wed, 06 Jul 2022 10:18:15 +0200
Message-ID: <877d4q3b94.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CrDlVV1nYjvMRfWgYvpb2dGx4YW7EOSL
X-Proofpoint-ORIG-GUID: w0SkKzNZ_rFmb5tc2JT46Gy2kpuUtxxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207060030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> Rework copy_oldmem_page() to allow multi-segment iterators.
> Reuse existing iterate_iovec macro as is and only relevant
> bits from __iterate_and_advance macro.
>
> Fixes: 49b11524d648 ("s390/crash: add missing iterator advance in copy_oldmem_page())
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/kernel/crash_dump.c | 65 +++++++++++++++++++++++++++--------
>  1 file changed, 50 insertions(+), 15 deletions(-)
>
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index 28124d0fa1d5..ac873245d6f0 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -210,6 +210,52 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
>  	return 0;
>  }
>  
> +#define iterate_iovec(i, n, base, len, off, __p, STEP) {	\
> +	size_t off = 0;						\
> +	size_t skip = i->iov_offset;				\
> +	do {							\
> +		len = min(n, __p->iov_len - skip);		\
> +		if (likely(len)) {				\
> +			base = __p->iov_base + skip;		\
> +			len -= (STEP);				\
> +			off += len;				\
> +			skip += len;				\
> +			n -= len;				\
> +			if (skip < __p->iov_len)		\
> +				break;				\
> +		}						\
> +		__p++;						\
> +		skip = 0;					\
> +	} while (n);						\
> +	i->iov_offset = skip;					\
> +	n = off;						\
> +}
> +
> +#define __iterate_and_advance(i, n, base, len, off, I, K) {	\
> +	if (unlikely(i->count < n))				\
> +		n = i->count;					\
> +	if (likely(n)) {					\
> +		if (likely(iter_is_iovec(i))) {			\
> +			const struct iovec *iov = i->iov;	\
> +			void __user *base;			\
> +			size_t len;				\
> +			iterate_iovec(i, n, base, len, off,	\
> +						iov, (I))	\
> +			i->nr_segs -= iov - i->iov;		\
> +			i->iov = iov;				\
> +		} else if (iov_iter_is_kvec(i)) {		\
> +			const struct kvec *kvec = i->kvec;	\
> +			void *base;				\
> +			size_t len;				\
> +			iterate_iovec(i, n, base, len, off,	\
> +						kvec, (K))	\
> +			i->nr_segs -= kvec - i->kvec;		\
> +			i->kvec = kvec;				\
> +		}						\
> +		i->count -= n;					\
> +	}							\
> +}
> +
>  /*
>   * Copy one page from "oldmem"
>   */
> @@ -217,25 +263,14 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
>  			 unsigned long offset)
>  {
>  	unsigned long src;
> -	int rc;
>  
>  	if (!(iter_is_iovec(iter) || iov_iter_is_kvec(iter)))
>  		return -EINVAL;
> -	/* Multi-segment iterators are not supported */
> -	if (iter->nr_segs > 1)
> -		return -EINVAL;
> -	if (!csize)
> -		return 0;
>  	src = pfn_to_phys(pfn) + offset;
> -
> -	/* XXX: pass the iov_iter down to a common function */
> -	if (iter_is_iovec(iter))
> -		rc = copy_oldmem_user(iter->iov->iov_base, src, csize);
> -	else
> -		rc = copy_oldmem_kernel(iter->kvec->iov_base, src, csize);
> -	if (rc < 0)
> -		return rc;
> -	iov_iter_advance(iter, csize);
> +	__iterate_and_advance(iter, csize, base, len, off,
> +		({ copy_oldmem_user(base, src + off, len) < 0 ? csize : 0; }),
> +		({ copy_oldmem_kernel(base, src + off, len) < 0 ? csize : 0; })

Question
--------
About return value of STEP in iterate_iovec().
We return "csize" in case copy_oldmem_*() fails.
If i'm not mistaken this could lead to an overflow in iterate_iovec():

  len -= (STEP);

Because len could be less than csize in case iovec consists of multiple
segments, one of which is less than csize.

Better to return len ?

({ copy_oldmem_user(base, src + off, len) < 0 ? len : 0; })

> +	)
>  	return csize;
>  }

Another thing is that now we never report any errors in contrast to
the version before. This is OK ?
Maybe set an error flag while iterating and then when the iteration is
done, check the flag and return an error ?



>  
> -- 
> 2.34.1


Otherwise, looks good to me.
Tested on LPAR and zVM , all our tela-kernel kdump tests in
tests/dump/kdump work now.

Reviewed-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Regards
Alex
