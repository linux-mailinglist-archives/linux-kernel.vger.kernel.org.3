Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C45A3CB2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiH1Igy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiH1Igv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 04:36:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B52A252
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 01:36:50 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S4gFSR012120;
        Sun, 28 Aug 2022 08:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=oIVg7D7nYUVy8J6p1vXGkZm9gcaHYDw249/PBO20iKw=;
 b=inQETc9wgVBlW6swuEpg/f8jLUvIzQ9KMmFls8huOYplAoFt1IS7bziT9Y2DGNV50gIo
 AA2JD8yS9+BbwdaKKAlCVsvjxEPkcDymoNDSS4G9PTXrqqgECi/SfOPu+jmxWHPCHq+2
 n7FvNDFab+zj0wP2HNdx4X36dMiD5bX0viaCUTr+Xb+AssLtE7sX4M97Y2SB7G3mlu7e
 geIBs+zGdCRu1dt74cS8nYR+f7pEaZBrXbyRciPWUtiNTVWP04g31qcr4ZGFkgTdy5UO
 i9iXzXghAEI44CZYVcJ0iaTN8n5nS/5yl3ZsZAT/OyfCV8HitSvOEMvSWjZ6D4YedUIo NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7w9s9jm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 08:36:30 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27S8aTRb022215;
        Sun, 28 Aug 2022 08:36:29 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7w9s9jkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 08:36:29 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27S8M5R5022497;
        Sun, 28 Aug 2022 08:36:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3j7aw8rsmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 08:36:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27S8aPJ642205606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Aug 2022 08:36:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418EBAE053;
        Sun, 28 Aug 2022 08:36:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D552EAE04D;
        Sun, 28 Aug 2022 08:36:24 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.53.89])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 28 Aug 2022 08:36:24 +0000 (GMT)
Date:   Sun, 28 Aug 2022 10:36:23 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Message-ID: <YwspB8OP8/Phv+tO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-2-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: moWxYxgyMcP1MQBpUEpo2MFCUpgenddd
X-Proofpoint-ORIG-GUID: KUexBssiCLvdV0auCn5LDJfMDuSwsC5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-28_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=933 clxscore=1011 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208280036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:31:15AM +0800, Baoquan He wrote:

Hi Baoquan,

>  arch_ioremap() return a bool,
>    - IS_ERR means return an error
>    - NULL means continue to remap
>    - a non-NULL, non-IS_ERR pointer is returned directly
>  arch_iounmap() return a bool,
>    - 0 means continue to vunmap
>    - error code means skip vunmap and return directly

It would make more sense if the return values were described
from the prospective of an architecture, not the caller.
I.e true - unmapped, false - not supported, etc.

> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 8652426282cc..99fde69becc7 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -17,6 +17,13 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	unsigned long offset, vaddr;
>  	phys_addr_t last_addr;
>  	struct vm_struct *area;
> +	void __iomem *ioaddr;
> +
> +	ioaddr = arch_ioremap(phys_addr, size, prot);
> +	if (IS_ERR(ioaddr))
> +		return NULL;
> +	else if (ioaddr)
> +		return ioaddr;

It seems to me arch_ioremap() could simply return an address
or an error. Then IOMEM_ERR_PTR(-ENOSYS) if the architecture
does not support it reads much better than the cryptic NULL.

Probably arch_iounmap() returning error would look better too,
though not sure about that.

Thanks!
