Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB905064D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiDSGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiDSGs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:48:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0F13E91
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 23:46:14 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23J5thmQ026853;
        Tue, 19 Apr 2022 06:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=OwrZ1xSPlHo3K6MX7dSt0I5DPkr9r+mFtOkAh+aIZzM=;
 b=jxM5oSUSisNE/s8ojyMm/pLlzCxNaKqExNwVu6us450OfARL9/oeIIVZo1TVsuG+z1Ki
 Wa9SQ4my1VrQQ7jO+dJgOtKtDRGxFNXsYHG2QqyvfwtqMgbcTYYOaMQDL6y1Xhv51qnM
 Z6HieqsgBeXmYyllhr/97ck4Q9im8WA7PjKII3YmkPjtqDOsstktG0yyQdp+FDqLDwi9
 RDqU3Q59QBJsUq6vFF9+4HV3JvT30z7nRgv1T5LhpoCUT7fwdksXWUDHDT9JicNJaCw7
 bqD7SWGcPeRkeKP20i4D3vJ5nwff8gyKCykcRTRys3gZtosa7rZlZL7dGEV7gStna2ar gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg791y846-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 06:46:08 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23J6cwFA018972;
        Tue, 19 Apr 2022 06:46:07 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg791y83j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 06:46:07 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23J6axYP028134;
        Tue, 19 Apr 2022 06:46:05 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3ffne931er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Apr 2022 06:46:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23J6k2mS26476910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 06:46:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC43BAE053;
        Tue, 19 Apr 2022 06:46:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0284BAE04D;
        Tue, 19 Apr 2022 06:46:02 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.146.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Apr 2022 06:46:01 +0000 (GMT)
Date:   Tue, 19 Apr 2022 09:45:59 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm, page_alloc: check pfn is valid before moving to
 freelist
Message-ID: <Yl5ap4veIr5ugce1@linux.ibm.com>
References: <cover.1649794059.git.quic_sudaraja@quicinc.com>
 <fb3c8c008994b2ed96f74b6b9698ff998b689bd2.1649794059.git.quic_sudaraja@quicinc.com>
 <Ylc3JGy6DUq00ryv@linux.ibm.com>
 <ee7bfc09-80af-a348-36ab-9d4ba9c612fa@quicinc.com>
 <Yl0IZWT2nsiYtqBT@linux.ibm.com>
 <85dfcf28-7e43-7bfe-d63a-97dde28cf207@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85dfcf28-7e43-7bfe-d63a-97dde28cf207@quicinc.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VPFBGIVXxo8MypdEOJbUVELqEq4RSA--
X-Proofpoint-GUID: 2Swav3roYJ1Jp12puw-sVORFdyr8ZjQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-19_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=766 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204190034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 03:32:21PM -0700, Sudarshan Rajagopalan wrote:
> On 4/18/2022 12:24 AM, Mike Rapoport wrote:
> > On Fri, Apr 15, 2022 at 02:30:52AM +0530, Sudarshan Rajagopalan wrote:
> > > On 4/14/2022 2:18 AM, Mike Rapoport wrote:
> > >
> > > We have a feature where we carve out some portion of memory in RAM partition
> > > table, hence we see such base addresses here.
> > >
> > Cannot the firmware align that portion at some sensible boundary?
> > Or at least report the carved out range as "reserved" (and maybe NOMAP)
> > rather than as hole?
> 
> We can have the firmware or ABL align the address to next pageblock size
> boundary. This would simple mean loosing few MBs of memory with alignment.
> Same with making them as "reserved" with "nomap".

Reserved and nomap do not have to be aligned and there will be a valid
struct page for such regions.

Still, the kernel should be able to cope with firmware oddities so a fix
for 5.15 is still needed.
 
> > That said, your patch will not fix anything in the current kernel because
> > the issue should not happen there, right?
> 
> Yes, the issue seems to be fixed in latest kernel version with the patches
> to drop arm64 pfn_valid. But the core issue is present on previous kernel
> versions with the scenario explained. Any procedure to have this fixed on
> 5.15 kernel?
>
> > I'd suggest backporting a9c38c5d267c ("dma-mapping: remove bogus test for
> > pfn_valid from dma_map_resource") and 3de360c3fdb3 ("arm64/mm: drop
> > HAVE_ARCH_PFN_VALID") to 5.15.
>
> The issue is not seen with these patches backported. Not sure of the
> procedure to send patches for 5.15 kernel, but can we have them backported
> to 5.15?

Please look at Documentation/process/stable-kernel-rules.rst for
explanation how to send patches to stable kernels. 

-- 
Sincerely yours,
Mike.
