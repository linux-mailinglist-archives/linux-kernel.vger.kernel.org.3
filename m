Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AA7573532
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiGMLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiGMLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E5FEDB51;
        Wed, 13 Jul 2022 04:18:03 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DApJoX002799;
        Wed, 13 Jul 2022 11:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=68kgUbjuW08vTufcIWEQ0Osd7G0ANEvWGaZxTL6iBI4=;
 b=tiEJ6M75BSJ55s8W/ft2x5hsDKFYCHxUaUNxMyeuiQuskoUtezwx7Mf7pOCPn2ZHwicB
 lER//F/N5lIrtNbceHnd6XYzEOsDSoNoTib7+3WFbZL4mpwfI700+k6k12Qlyyr2ZFjj
 hONcHpTH3Kq76u7MbCuiaTNgttscyHM7QXgD0wMmahfVua+LgX+AEe5F6MPBxbvlTv3k
 MNCdp1FSLJxRX8zpW6TOphSXY+0V+ybRCJFKuUAuxyCM/J8XrLNMAQhLi+ohyxXwfLR5
 jLGRtYepfvsWVqYKeY8PqS+ekVtV6zQFNzta6D2LkylmSXUdpGLlwtyhTDUpd+dO2R2/ RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9vnegphf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 11:17:55 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26DAs5qU019568;
        Wed, 13 Jul 2022 11:17:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9vnegpgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 11:17:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26DB60Oa023452;
        Wed, 13 Jul 2022 11:17:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn2fqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 11:17:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26DBHnje24903942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 11:17:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35388A4053;
        Wed, 13 Jul 2022 11:17:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA008A404D;
        Wed, 13 Jul 2022 11:17:48 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.47.210])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Jul 2022 11:17:48 +0000 (GMT)
Date:   Wed, 13 Jul 2022 13:17:44 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390/crash: allow multi-segment iterators
Message-ID: <Ys6p2MvQdL/lx7RE@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <cover.1657172539.git.agordeev@linux.ibm.com>
 <613f63d652bb4fa6fb3d2bb38762de6bb066b35a.1657172539.git.agordeev@linux.ibm.com>
 <YsbXfh3e2rDEKSNw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsbXfh3e2rDEKSNw@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vQD3I1K50xsXwo7orujsnmNnDGg6B7jM
X-Proofpoint-ORIG-GUID: FX389sqgQqZrWsvPh7YqTc4m7FZY8eV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 01:54:22PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 07, 2022 at 08:01:15AM +0200, Alexander Gordeev wrote:
> > Rework copy_oldmem_page() to allow multi-segment iterators.
> > Reuse existing iterate_iovec macro as is and only relevant
> > bits from __iterate_and_advance macro.

> Or do it properly?
> 
> You should probably put a mutex around all of this because if you have two
> threads accessing the hsa at the same time, they'll use the same buffer.
> But that's a pre-existing problem.  I also fixed the pre-existing bug
> where you were using 'count' when you meant to use 'len'.

Thank you, Matthew!

Would you mind being added with Suggested-by to the fix(es)?

> Uncompiled.  You might need to include <linux/uio.h> somewhere.

The problem with your suggestion is memcpy()/copyout() might fail
since pages to be copied are not guaranteed to be mapped on s390.
For that we use s390-specific memcpy_real() routine that only takes
physical addresses and bypasses paging altogether (I added some
comments to the removed code, just in case you are interested).

Yet, I am still going to reuse and extend your approach and
hopefully come up with something soon.

As a side note - there is an intention to make things more like
others, but not just right now.

> diff --git a/arch/s390/include/asm/sclp.h b/arch/s390/include/asm/sclp.h
> index 236b34b75ddb..d8b4c526e0f0 100644
> --- a/arch/s390/include/asm/sclp.h
> +++ b/arch/s390/include/asm/sclp.h
> @@ -143,7 +143,7 @@ int sclp_ap_configure(u32 apid);
>  int sclp_ap_deconfigure(u32 apid);
>  int sclp_pci_report(struct zpci_report_error_header *report, u32 fh, u32 fid);
>  int memcpy_hsa_kernel(void *dest, unsigned long src, size_t count);
> -int memcpy_hsa_user(void __user *dest, unsigned long src, size_t count);
> +int memcpy_hsa_iter(struct iov_iter *iter, unsigned long src, size_t count);
>  void sclp_ocf_cpc_name_copy(char *dst);
>  
>  static inline int sclp_get_core_info(struct sclp_core_info *info, int early)
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index 28124d0fa1d5..6e4dde377f8e 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -130,53 +130,11 @@ static inline void *load_real_addr(void *addr)
>  	return (void *)real_addr;
>  }
>  
> -/*
> - * Copy memory of the old, dumped system to a kernel space virtual address
> - */
> -int copy_oldmem_kernel(void *dst, unsigned long src, size_t count)
> -{
> -	unsigned long len;
> -	void *ra;
> -	int rc;
> -
> -	while (count) {
> -		if (!oldmem_data.start && src < sclp.hsa_size) {
> -			/* Copy from zfcp/nvme dump HSA area */
> -			len = min(count, sclp.hsa_size - src);
> -			rc = memcpy_hsa_kernel(dst, src, len);
> -			if (rc)
> -				return rc;
> -		} else {
> -			/* Check for swapped kdump oldmem areas */
> -			if (oldmem_data.start && src - oldmem_data.start < oldmem_data.size) {
> -				src -= oldmem_data.start;
> -				len = min(count, oldmem_data.size - src);
> -			} else if (oldmem_data.start && src < oldmem_data.size) {
> -				len = min(count, oldmem_data.size - src);
> -				src += oldmem_data.start;
> -			} else {
> -				len = count;
> -			}
> -			if (is_vmalloc_or_module_addr(dst)) {

There is no 1:1 match between vmalloc/module addresses.

> -				ra = load_real_addr(dst);

load_real_addr() obtains the physical addresses from a virtual one to be
able passing it to memcpy_real(). 

> -				len = min(PAGE_SIZE - offset_in_page(ra), len);
> -			} else {
> -				ra = dst;

Here a virtual address matches the physical one and thus - good to go.

> -			}
> -			if (memcpy_real(ra, src, len))
> -				return -EFAULT;

As the source address might be unmapped, copy_to_iter()->memcpy()
would not be safe to use here.

> -		}
> -		dst += len;
> -		src += len;
> -		count -= len;
> -	}
> -	return 0;
> -}
> -
>  /*
>   * Copy memory of the old, dumped system to a user space virtual address
>   */
> -static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
> +static int copy_oldmem_iter(struct iov_iter *iter, unsigned long src,
> +		size_t count)
>  {
>  	unsigned long len;
>  	int rc;
> @@ -185,7 +143,7 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
>  		if (!oldmem_data.start && src < sclp.hsa_size) {
>  			/* Copy from zfcp/nvme dump HSA area */
>  			len = min(count, sclp.hsa_size - src);
> -			rc = memcpy_hsa_user(dst, src, len);
> +			rc = memcpy_hsa_iter(iter, src, len);
>  			if (rc)
>  				return rc;
>  		} else {
> @@ -199,8 +157,8 @@ static int copy_oldmem_user(void __user *dst, unsigned long src, size_t count)
>  			} else {
>  				len = count;
>  			}
> -			rc = copy_to_user_real(dst, src, count);
> -			if (rc)
> +			rc = copy_to_iter(iter, src, len);

As the source address might be unmapped, copy_to_iter()->raw_copy_to_user()
is not safe to use here.

> +			if (rc != len)
>  				return rc;
>  		}
>  		dst += len;

Thanks!
