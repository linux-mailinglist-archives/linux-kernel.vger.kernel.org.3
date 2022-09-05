Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B85ACE6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiIEI43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiIEI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:56:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E88E4F699
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:56:22 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2858J3qi010809;
        Mon, 5 Sep 2022 08:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=awfKAyJobiW23FnyIu7wYsOrKM1T0q6xGauaFCmtZlw=;
 b=Je7KXinx5ncGPmXkWIHvQ1Ohf8WG3M7iX/y0KrEU1HvecfDkfSU8tVYGMkyOLlvxUyU9
 fBPp/SHVpfYjmje6ZFBb5GdQ43A4d/4yp7XV5lCy54P/UoI1yHkjOXvGNqYZQIRlaELL
 Fi5HJ8V5zgTGIDA/NCnu1xo8U3RTG56Mkf9rFmFa4YemBYOXIme0sWFc1Mn7C/A1Hzwz
 8QSkv7HHAYJD1VJZHDEEicuZZQssg5cADHUfMo50xdffTCp/9KbxQ7qBs15OM88czsgn
 0H5ACxSQ8KkCCZZtJAf2mB3c8wWNUe+RZ97FBZUg7htHB9ZBdII9yuVzyWwBKOCf6ba6 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jddgch2jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:56:18 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2858YeME016261;
        Mon, 5 Sep 2022 08:56:18 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jddgch2j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:56:17 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2858pKPo014752;
        Mon, 5 Sep 2022 08:56:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3jbxj9f0jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 08:56:16 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2858uFxE46530868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 08:56:15 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0200CBE053;
        Mon,  5 Sep 2022 09:05:02 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F66DBE04F;
        Mon,  5 Sep 2022 09:04:58 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.107.234])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 09:04:57 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>
Cc:     david@redhat.com, kirill.shutemov@linux.intel.com,
        jhubbard@nvidia.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
In-Reply-To: <YxJot6JbFl0HnXq3@xz-m1.local>
References: <20220901222707.477402-1-shy828301@gmail.com>
 <YxE/vuQlWJCJMuG2@xz-m1.local>
 <CAHbLzkqjZ_UhUbJ_f9Br7WCAgQvjrm5bMPRsKYvaFc2bzSuzrw@mail.gmail.com>
 <YxIofPiI8jvGzcjC@xz-m1.local>
 <CAHbLzkqGdnwY4P8jKQR0ojm6QV6b3dBi5pwrC1UJ4dqi3EqS4w@mail.gmail.com>
 <YxJot6JbFl0HnXq3@xz-m1.local>
Date:   Mon, 05 Sep 2022 14:26:09 +0530
Message-ID: <87fsh6jj2u.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X7aWyyQso9OF8Og6KjPupF7xNWXyDhBB
X-Proofpoint-GUID: wILYC-Ezq_dDGVScmYJp8t3RFRwffAQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_05,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 mlxlogscore=515 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

>
> On Fri, Sep 02, 2022 at 10:45:20AM -0700, Yang Shi wrote:
>> > How about another patch to remove the ppc impl too?  Then it can be a two
>> > patches series.
>> 
>> BTW, I don't think we could remove the ppc implementation since it is
>> different from the generic pmdp_collapse_flush(), particularly for the
>> hash part IIUC.
>> 
>> The generic version calls flush_tlb_range() -> hash__flush_tlb_range()
>> for hash, but the hash call is actually no-op. The ppc version calls
>> hash__pmdp_collapse_flush() -> flush_tlb_pmd_range(), which does
>> something useful.
>
> One thing I found interesting (and also a bit confused..) is that the ppc
> code used the name flush_tlb_pmd_range() to "flush tlb range in pte level",
> which is kind of against the tlb API design..
>
> The generic tlb API has a very close function called flush_pmd_tlb_range()
> which is only used to do pmd-level flushing, while here the ppc version of
> flush_tlb_pmd_range() is actually flush_tlb_range() in the generic API.
>
> Agreed that it may worth having a look from ppc developers.
>

It is actually flushing the hash page table entries. I will rename
flush_tlb_pmd_range to flush_hash_table_pmd_range().

-aneesh
