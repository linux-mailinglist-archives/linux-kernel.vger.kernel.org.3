Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FBA59C363
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiHVPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiHVPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:50:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0377140ED;
        Mon, 22 Aug 2022 08:50:48 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MDfqsC018658;
        Mon, 22 Aug 2022 15:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/kFdotxqYljhODEbmfcrjJRxem7m3XLEa6JfkgUOlME=;
 b=e7Sv3iVEHhM1QezCNWYR6rqei1mNP3oeyqeHxZCcPs2yjmXwU1vPYG2JF6NhsM2tsIil
 Q3BNp/e+d5bCs1j1+GLyeWeSo27AoWABPGw30tBPwbUISoMPIpgKSunYhnOLyDA7iYXJ
 xLZHAHPW5Jy5mnOniMKN7tYfjAVF6LwEc0IVbcQo31xuq2cfmSWaZI5swPlGQYfMEIr0
 h3Y08Nug4PRHyP3RNH3zbbtuQ3VhLJ7mwpWDyejasxKu2xE87gqoIq3UBp6Q3MtX/hlw
 E9fX0E0R04NDhDwQBHZB5oVeR0r418ML+B/Tcwwil9lCw5n36uvKRwSVB32WlHtMX0ap 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4awkasuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:08:18 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27MElKn0012965;
        Mon, 22 Aug 2022 15:08:17 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4awkastk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:08:17 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27MF5AAr022369;
        Mon, 22 Aug 2022 15:08:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3j2q88svrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:08:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27MF8Bw325559456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:08:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A44B4C04A;
        Mon, 22 Aug 2022 15:08:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D089C4C046;
        Mon, 22 Aug 2022 15:08:10 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Aug 2022 15:08:10 +0000 (GMT)
Message-ID: <a381b32861b106afb209628e094260caf5fe9f7b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Christoph Hellwig <hch@infradead.org>, Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Mon, 22 Aug 2022 17:08:10 +0200
In-Reply-To: <YwHZRhpwL37yLb/o@infradead.org>
References: <20220820003125.353570-1-bhe@redhat.com>
         <20220820003125.353570-10-bhe@redhat.com> <YwHZRhpwL37yLb/o@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9TrsJ1zE2LTP3LvI4TlHsl8k9DtHeji8
X-Proofpoint-ORIG-GUID: kUOOtbbtGXvg16G1-b06F3wGukiJtZiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=927
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-08-21 at 00:05 -0700, Christoph Hellwig wrote:
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> >  {
> >  	if (!static_branch_unlikely(&have_mio))
> > +		return (void __iomem *) *paddr;
> > +	return NULL;
> 
> This logic isn't new in the patch, but it could really use a comment
> as it is rather non-obvious.

Yes, makes sense. Basically we fake MMIO addresses because the s390
architecture doesn't have MMIO as a concept. That is until the PCI MIO
instructions introduced pseudo-MMIO though only for specific PCI
load/store instructions. Without those PCI BAR spaces as well as config
space is accessed with so called function handles. As these are a bad
fit for Linux' MMIO based APIs we create fake MMIO addresses (called
address cookies) that encode an index into the zpci_iomap_start[] which
can be decoded by our implementation of ioread*/iowrite*().

I don't think this is the right place to describe this overall scheme
in detail but maybe we can leave a a good bread crumb. Maybe something
like below?

/* 
 * When PCI MIO instructions are unavailable the "physical" address encodes
 * a hint for accessing the PCI memory space it represents. Just pass it 
 * unchanged such that ioread/iowrite can decode it.
 */

