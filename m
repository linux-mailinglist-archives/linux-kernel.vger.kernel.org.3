Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78227589EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiHDPnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiHDPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:43:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3140252BF
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:43:31 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274EYUag023748;
        Thu, 4 Aug 2022 15:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Qs8dniwne9jKSHHgdOMyZn2b2E8k4xTF6TyfM5TV310=;
 b=ggv9+cQ7kFRs4FFb0vVXIEKqcJMtNrtdUWfSZMkrHsyia7+X67zwcEgoy5fN0QnV37IJ
 eW7dPV7PSBPfZWbP8SOSy8PrqJJvhlubSHB2Z6ekcHao8PlX9lbAHy9RHO6nsbpkC3hX
 Zx/QGowQ0K6q09oft5IyHDFKwySFlZW3e97oNCmQ1dys7SryMACT+AOZ7TMqw3Ni2+jp
 TVHu3Qm1nmgos/XLmQuhe01NNkpWnq18TZzaI99o38sz3edDPcowEtBtmtvQvoPSqgMM
 G0YrT4WvzmQ6KrCDOBeBuF/Y17MNjH0Gqr0OvhTLXrLN4dbd4FVT/CGygW0ogx2324KA 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrg05tsp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 15:43:03 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 274EZlem027499;
        Thu, 4 Aug 2022 15:43:02 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hrg05tsn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 15:43:02 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 274FNCCN001181;
        Thu, 4 Aug 2022 15:43:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3hmuwht88u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 15:43:00 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 274FgwjC30343616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Aug 2022 15:42:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D46B11C050;
        Thu,  4 Aug 2022 15:42:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E24C711C04C;
        Thu,  4 Aug 2022 15:42:57 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.176.127])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Aug 2022 15:42:57 +0000 (GMT)
Date:   Thu, 4 Aug 2022 17:42:46 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed
Message-ID: <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801144029.57829-2-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: le9rdsRVjWcSIk49df1kvrGphIsDtxce
X-Proofpoint-GUID: 5UicurC8gMMnk31CoSegeIIHBqn6pKjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_03,2022-08-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 mlxlogscore=771 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:40:19PM +0800, Baoquan He wrote:

Hi Baoquan,

> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -3,19 +3,20 @@
>  #include <linux/mm.h>
>  #include <linux/io.h>
>  
> -bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> +void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
>  {
>  	unsigned long last_addr = phys_addr + size - 1;
> +	int ret = -EINVAL;

If ret variable is really needed?

> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 72974cb81343..d72eb310fb3c 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -967,26 +967,27 @@ static inline void iounmap(volatile void __iomem *addr)
>  /*
>   * Arch code can implement the following two hooks when using GENERIC_IOREMAP
>   * ioremap_allowed() return a bool,
> - *   - true means continue to remap
> - *   - false means skip remap and return directly
> + *   - IS_ERR means return an error
> + *   - NULL means continue to remap
> + *   - a non-NULL, non-IS_ERR pointer is returned directly

If ioremap_allowed() returns a valid pointer, then the function name
is not as precise anymore.

> @@ -28,8 +29,11 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> -	if (!ioremap_allowed(phys_addr, size, prot))
> +	base = ioremap_allowed(phys_addr, size, prot);
> +	if (IS_ERR(base))
>  		return NULL;
> +	else if (base)
> +		return base;

It is probably just me, but the base name bit misleading here.

> @@ -50,9 +54,9 @@ EXPORT_SYMBOL(ioremap_prot);
>  
>  void iounmap(volatile void __iomem *addr)
>  {
> -	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
> +	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
>  
> -	if (!iounmap_allowed(vaddr))
> +	if (iounmap_allowed(vaddr))

I guess, iounmap_allowed() should accept void __iomem *, not void *.
Then addr needs to be passed to iounmap_allowed() not vaddr.

>  		return;
