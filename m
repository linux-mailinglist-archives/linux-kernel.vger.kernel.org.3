Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220C352BCF7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiERNbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237896AbiERNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:31:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF5233A21
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:31:43 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ICrwKi029894;
        Wed, 18 May 2022 13:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=n6RkeiMlQ3Uwhku+S25hPN1Cub1ZH5SPR80xoV8sWuU=;
 b=WJe52TKWf1J42lS0D43OJSBc/nI5BVpWlQn4iF383xDFUecmEZi4QGMSZlv30l/VZ03D
 aVACAJ+GmmcD7d2kmwq8DydeqS/bl0waIE/XRrebT1O5M9lGJ2jyzHLSE1TbSxSsnLRn
 LKyYmfIiUCvY/Y9i5bGrtWGSDpiCMqANtLkdrf0f45xhpNQwFE32PMZSE3EvqXttOqTb
 5xMZAve+u2yRRPRou0RZXvbdjSv1AUflZtijhQnHYEuoNEqCTFxXLcj+aydjkp/1KvMk
 B1dIVwCj88g/vULqCpVdDjDkA6AzCGb7NwrJ2kb2wYIbIOHFeNVAOq503MGw5loHXoQL +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g516w118c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:31:32 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24ICt2tr031943;
        Wed, 18 May 2022 13:31:31 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g516w117p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:31:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IDS4uu025015;
        Wed, 18 May 2022 13:31:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3g4j3ggvm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:31:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IDVRGC50397616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:31:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAD674C044;
        Wed, 18 May 2022 13:31:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0394A4C040;
        Wed, 18 May 2022 13:31:27 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.2.119])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 May 2022 13:31:26 +0000 (GMT)
Date:   Wed, 18 May 2022 16:31:24 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH] page_ext: create page extension for all memblock
 memory regions
Message-ID: <YoT1LMALyqTUtg6e@linux.ibm.com>
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
 <20220509074330.4822-1-jaewon31.kim@samsung.com>
 <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
 <YoNcBG6kQnmLZ3Z9@linux.ibm.com>
 <CAJrd-UuzTh-0Ee9+rMRES9onP_EkvJS-VpPP66J4M4n0Ku0ZWA@mail.gmail.com>
 <YoObTJcBUjeW+2l2@linux.ibm.com>
 <CAJrd-UtYqEMy+Yr9gP0v0dZ3HZ=fCHe67dTRe=5YtLWrbmd1UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJrd-UtYqEMy+Yr9gP0v0dZ3HZ=fCHe67dTRe=5YtLWrbmd1UQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nlli5OUDCpmZiJzO56rGlCzzAPJZJknA
X-Proofpoint-ORIG-GUID: eEVS-yoS7Asvof-tlx0K-lQ7ipnKIgOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_04,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205180076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:10:20PM +0900, Jaewon Kim wrote:
> 64
> 59
> 
> 2022년 5월 17일 (화) 오후 9:55, Mike Rapoport <rppt@linux.ibm.com>님이 작성:
> >
> > On Tue, May 17, 2022 at 08:38:18PM +0900, Jaewon Kim wrote:
> > > Hello Mike Rapoport
> > > Thank you for your comment.
> > >
> > > Oh really? Could you point out the code or the commit regarding 'all
> > > struct pages in any section should be valid and
> > > properly initialized' ?
> >
> > There were several commits that refactored the memory map initialization,
> > freeing of the unused memory map and abuse of pfn_valid() as a substitute
> > of "is memory valid" semantics.
> >
> > > Actually I am using v5.10 based source tree on an arm64 device.
> >
> > Then most probably your change is not relevant for the upstream kernel.
> > Did you observe any issues with page_ext initialization on v5.18-rcN
> > kernels?
> 
> Actually I observed only 59 sections were initialized for page_ext and
> missed 5 sections.
> It should be totally 64 sections * 128 MB = 8,192 MB

Does this happen with v5.10 based kernel or with v5.18-rcN based kernel? 

> > > I tried to look up and found the following commit in v5.16-rc1, did
> > > you mean this?
> > > 3de360c3fdb3 arm64/mm: drop HAVE_ARCH_PFN_VALID
> >
> > Yes, this is one of those commits.
> >
> > > I guess memblock_is_memory code in pfn_valid in arch/arm64/mm/init.c, v5.10
> > > might affect the page_ext_init.
> >
> > Yes. In 5.10 the pfn_valid() test in page_ext_init() will skip an entire
> > section if the first pfn in that section is not memory that can be mapped
> > in the linear map.
> >
> > But again, this should be fixed in the latest kernels.
> 
> Great! Thank you for your explanation.
> I will check it someday later when I use the latest kernel on our devices.
> The next version on our devices seems to be v5.15 though.
> 
> Thank you
> Jaewon Kim

-- 
Sincerely yours,
Mike.
