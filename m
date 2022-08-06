Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6658B48F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbiHFIaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiHFI37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:29:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6AD15A0C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 01:29:58 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2768DaCi025942;
        Sat, 6 Aug 2022 08:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=mVyrJN7a0bfudjXyT++T2mCy0nAmG+VNlTdDZ0qmJRE=;
 b=TG6wTrqpfiJarefDlpHFXYQb6vuTb856BtfT+uPi8NMIi+YVcINEC3iKudMBpaRk+7WG
 Dmz7TadMn0Pki2nLt7/8n2QD//P06vIcmNSq66SlxD1yCJHmjScV49OWaKyxQUBkhWiG
 E4UwfwOj0b7HWfuHBHkY4MTVnPo/EyvjzehAFzYw+7AWrGs5X5Ss0SQUPXQl+Q4ewGR2
 16xu8JkxrXpByirh501lEZ3NdPXBKETMTCcEMtLxJgOW3bz0/Zh/ktvSJYMK5pi2rtRz
 nGqCnQWo223pqikXFTckFr4rFoUId77SVlOdJ0tLxPANgb0sFH3x1Q9WeMMk/X7pamy4 NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hsmkgg7hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Aug 2022 08:29:35 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2768MlWJ022115;
        Sat, 6 Aug 2022 08:29:35 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hsmkgg7hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Aug 2022 08:29:34 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2768K78A028395;
        Sat, 6 Aug 2022 08:29:32 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3hsfx8r6yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Aug 2022 08:29:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2768TUnJ29557152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Aug 2022 08:29:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 754FDA4040;
        Sat,  6 Aug 2022 08:29:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 951FDA4051;
        Sat,  6 Aug 2022 08:29:27 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.211.92.219])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  6 Aug 2022 08:29:27 +0000 (GMT)
Date:   Sat, 6 Aug 2022 10:29:23 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed
Message-ID: <Yu4mYxpV0GWRTjQp@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-2-bhe@redhat.com>
 <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <832b38ca-064e-0ab8-cd62-337d0d83d471@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <832b38ca-064e-0ab8-cd62-337d0d83d471@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rrSIkTZQCS3OOXrkjUVD7ES3uIAQvU-6
X-Proofpoint-GUID: 7_rb2n5uWJvpno-sqrXdE4XDFIN6yirp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-06_03,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=876 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208060042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 10:29:03AM +0800, Kefeng Wang wrote:
> 
> On 2022/8/4 23:42, Alexander Gordeev wrote:
> > On Mon, Aug 01, 2022 at 10:40:19PM +0800, Baoquan He wrote:
> > 
> > Hi Baoquan,
> > 
> > > --- a/arch/arm64/mm/ioremap.c
> > > +++ b/arch/arm64/mm/ioremap.c
> > > @@ -3,19 +3,20 @@
> > >   #include <linux/mm.h>
> > >   #include <linux/io.h>
> > > -bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> > > +void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> > >   {
> > >   	unsigned long last_addr = phys_addr + size - 1;
> > > +	int ret = -EINVAL;
> > If ret variable is really needed?
> > 
> > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > index 72974cb81343..d72eb310fb3c 100644
> > > --- a/include/asm-generic/io.h
> > > +++ b/include/asm-generic/io.h
> > > @@ -967,26 +967,27 @@ static inline void iounmap(volatile void __iomem *addr)
> > >   /*
> > >    * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> > >    * ioremap_allowed() return a bool,
> > > - *   - true means continue to remap
> > > - *   - false means skip remap and return directly
> > > + *   - IS_ERR means return an error
> > > + *   - NULL means continue to remap
> > > + *   - a non-NULL, non-IS_ERR pointer is returned directly
> > If ioremap_allowed() returns a valid pointer, then the function name
> > is not as precise anymore.
> 
> Maybe use arch_ioremap/unmap as before, or some better name.
> 
> > 
> > > @@ -28,8 +29,11 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> > >   	phys_addr -= offset;
> > >   	size = PAGE_ALIGN(size + offset);
> > > -	if (!ioremap_allowed(phys_addr, size, prot))
> > > +	base = ioremap_allowed(phys_addr, size, prot);
> > > +	if (IS_ERR(base))
> > >   		return NULL;
> > > +	else if (base)
> > > +		return base;
> > It is probably just me, but the base name bit misleading here.
> We could reuse vaddr, not add new base.

vaddr name is wrong AFAICT. ioremap_allowed() returns __iomem address,
not the virtual one.

> > 
> > > @@ -50,9 +54,9 @@ EXPORT_SYMBOL(ioremap_prot);
> > >   void iounmap(volatile void __iomem *addr)
> > >   {
> > > -	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
> > > +	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);

Same here.

> > > -	if (!iounmap_allowed(vaddr))
> > > +	if (iounmap_allowed(vaddr))
> > I guess, iounmap_allowed() should accept void __iomem *, not void *.
> > Then addr needs to be passed to iounmap_allowed() not vaddr.
> 
> The following is_vmalloc_addr()  and vunmap() in iounmap() use void *,
> 
> so we could simply use void* for iounmap_allowed().

iounmap_allowed() accepts void __iomem * and I that looks correct to me.

Passing void * on the other hand means you pass a pointer that
in theory differs from what architecture previously returned
with ioremap_allowed() and "knows" nothing about.

I think you need to pass addr to iounmap_allowed() as is.
