Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB2500067
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiDMU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiDMU6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:58:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E7D71EEB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:56:11 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DJOsP6032104;
        Wed, 13 Apr 2022 20:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=zFdCpTXXgWrFWcy3H0SWpawLipk2KMmMnlwjdvx1Pes=;
 b=kmRlyV3ABI/BNExSjxztJY0YUKr5ucnFVOgR3vfOJFDnuF6YqyZ9ZpBkA7mSiGqe766a
 YvpS50BeljQM5G03BTHFWCiH58wUsBkEfNdJZ4RAIavuiiG1k1j8L+RtySkegHebMdId
 D4Q+r/qEB0jCWDKkEkZ5k7BfEcZV0keCNAXGB1Jl/GX7py+6kuw3rYUIovcPwPX13LfP
 Q1Flk7w5Affby6UfKL+7ovld8EKx1qkhl+gVvY+K6s99D667ClwxlU/xsOAVsTvSJpy5
 3K1Rrx3bTbgWlXz1M0R1U7YMrpPSxGYIn48GD8ywhm0EwJZDmJR4+IvfQ3EWox95wrjT Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fe4ng1mn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 20:56:06 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23DKjf5x009064;
        Wed, 13 Apr 2022 20:56:05 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fe4ng1mmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 20:56:05 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23DKrqc0021123;
        Wed, 13 Apr 2022 20:56:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3fb1s8nxuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 20:56:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23DKu1TF45285876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 20:56:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4A9D4C040;
        Wed, 13 Apr 2022 20:56:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02CE34C044;
        Wed, 13 Apr 2022 20:56:01 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.63.101])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Apr 2022 20:56:00 +0000 (GMT)
Date:   Wed, 13 Apr 2022 23:55:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm, page_alloc: check pfn is valid before moving to
 freelist
Message-ID: <Ylc437iBoQ4AU6zT@linux.ibm.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
 <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
 <20220412135912.93175db2ab4e83f4bb060dbf@linux-foundation.org>
 <6daaaf5c-529d-f3eb-7486-a72cabb6e396@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6daaaf5c-529d-f3eb-7486-a72cabb6e396@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SW9633Sh-JymDy_xVNz4-8CEsiVRHlvt
X-Proofpoint-GUID: 3xffx9zLA32th8JUbQMcVsgGaBbYNBDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_04,2022-04-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=658 spamscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204130100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 02:05:51PM -0700, David Rientjes wrote:
> On Tue, 12 Apr 2022, Andrew Morton wrote:
> 
> > On Tue, 12 Apr 2022 13:16:23 -0700 Sudarshan Rajagopalan <quic_sudaraja@quicinc.com> wrote:
> > 
> > > Check if pfn is valid before or not before moving it to freelist.
> > > 
> > > There are possible scenario where a pageblock can have partial physical
> > > hole and partial part of System RAM. This happens when base address in RAM
> > > partition table is not aligned to pageblock size.
> > > 
> > > ...
> > >
> > > 
> > > Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > Fixes: 4c7b9896621be ("mm: remove pfn_valid_within() and CONFIG_HOLES_IN_ZONE")
> > 
> > I made that 859a85ddf90e714092dea71a0e54c7b9896621be and added
> > cc:stable.  I'll await reviewer input before proceeding further.
> > 
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -2521,6 +2521,11 @@ static int move_freepages(struct zone *zone,
> > >  	int pages_moved = 0;
> > >  
> > >  	for (pfn = start_pfn; pfn <= end_pfn;) {
> > > +		if (!pfn_valid(pfn)) {
> > 
> > Readers will wonder how we can encounter an invalid pfn here.  A small
> > comment might help clue them in.
> > 
> 
> Sudarshan can correct me if I'm wrong, but this has to do with the 
> pageblock alignment of the caller that assumes all pages in the range has 
> an underlying struct page that we can access but that fails to hold true 
> when we have a memory hole.  A comment would definitely help:

We do have a struct page for every page in a pageblock even if there is a
hole in the physical memory. If this is not the case, there is more
fundamental bug that should be fixed.
 
> 	/* Pageblock alignment may cause us to try to access into a hole */
> 
> > > +			pfn++;
> > > +			continue;
> > > +		}
> > > +
> > >  		page = pfn_to_page(pfn);
> > >  		if (!PageBuddy(page)) {
> > >  			/*
> > 
> > 
> > 

-- 
Sincerely yours,
Mike.
