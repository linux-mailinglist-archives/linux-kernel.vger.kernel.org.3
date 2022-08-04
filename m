Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78D589F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 18:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiHDQHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiHDQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:07:07 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6B62E9C4
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 09:07:07 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274FjOp9011361;
        Thu, 4 Aug 2022 16:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Rw13iibRroFj5r1LOCo0kCVDpTitY73SlDYq+UMuyOU=;
 b=UKgcCzDFA1ql3bFcegYpzYfqBaTsFrN7oWPKCzceDP34gnEVPlx6TIN5SCwYLM/kpIjU
 ppFWcWNFh47waXhvqBEWxnBHTD73uxChdcTMe1f2hGHO8JEZhSz8mGiAxs0otQQPUDRb
 43cXIxOLiKYjMLg+tAU2CORoMS+W/ygX9HHMM2BB/7QX4zg3+QVc6HkXwkykt85fCCBe
 3usju4E4jXV8U1P4SbXjfLxsvYbywwfPn3NFnybczuz5rlxLpPlDR2IZX3f0CnGqSGCa
 lhxhqFKaBj/svmwEEhZIT2E+fTSFi+En/qDO6sTrVQJaLMc2NY6wFEgh/Jw3l65K8a23 kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrh1m0jpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 16:06:44 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 274FlAhd019559;
        Thu, 4 Aug 2022 16:06:44 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrh1m0h7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 16:06:43 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 274FpjfQ024253;
        Thu, 4 Aug 2022 16:02:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3hrf2184vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 16:02:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 274G2a1v32964982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Aug 2022 16:02:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F257C42042;
        Thu,  4 Aug 2022 16:02:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 932E742041;
        Thu,  4 Aug 2022 16:02:20 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.176.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Aug 2022 16:02:20 +0000 (GMT)
Date:   Thu, 4 Aug 2022 18:02:12 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/11] mm: ioremap: fixup the physical address
Message-ID: <YuvthDzuPlAwD/LA@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801144029.57829-3-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QmAPIXvbkzQJeLCkH0SYbeYlEeA0TOhP
X-Proofpoint-ORIG-GUID: 8VpsT3-3-3ZognIn2Ue-Z5ucQQ5rXMa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=488 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208040068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:40:20PM +0800, Baoquan He wrote:
> This is a preparation patch, no functionality change.

There is, please see below.

> @@ -3,11 +3,17 @@
>  #include <linux/mm.h>
>  #include <linux/io.h>
>  
> -void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> +void __iomem *
> +ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
>  {
> -	unsigned long last_addr = phys_addr + size - 1;
> +	unsigned long last_addr, offset, phys_addr = *paddr;
>  	int ret = -EINVAL;
>  
> +	offset = phys_addr & (~PAGE_MASK);
> +	phys_addr -= offset;

FWIW, phys_addr &= PAGE_MASK looks much more usual.

> @@ -11,13 +11,20 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +void __iomem *ioremap_prot(phys_addr_t paddr, size_t size,
>  			   unsigned long prot)
>  {
>  	unsigned long offset, vaddr;
> -	phys_addr_t last_addr;
> +	phys_addr_t last_addr, phys_addr = paddr;
>  	struct vm_struct *area;
>  	void __iomem *base;
> +	unsigned long prot_val = prot;

Why prot_val is needed?

> +	base = ioremap_allowed(&phys_addr, size, &prot_val);
> +	if (IS_ERR(base))
> +		return NULL;
> +	else if (base)
> +		return base;

By moving ioremap_allowed() here you allow it to be called
before the wrap-around check, including architectures that
do not do fixups.

And now ioremap_allowed() semantics, prototype and name turn
less than obvious. Why not introduce a separate fixup callback?

>  	/* Disallow wrap-around or zero size */
>  	last_addr = phys_addr + size - 1;
> @@ -29,12 +36,6 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> -	base = ioremap_allowed(phys_addr, size, prot);
> -	if (IS_ERR(base))
> -		return NULL;
> -	else if (base)
> -		return base;
> -
>  	area = get_vm_area_caller(size, VM_IOREMAP,
>  			__builtin_return_address(0));
>  	if (!area)
