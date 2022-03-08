Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403054D1C47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347847AbiCHPtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiCHPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:49:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC66536B58
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:48:25 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228FjCGK012295;
        Tue, 8 Mar 2022 15:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=389I0VekDwwKFjdESH9plHsPrSJCLzJsP3F8jIyG3CQ=;
 b=k0Rh9qRiWn8uZW60/j8lNA2V8qQqifmmn0NvxnXcwllG6u34i+4vEiwGh5AnPxJGu+9q
 2nQDhZzeosmI34cXCpE/o3yWRCNWMA94ZQow6cyxLpsOylHLgg6zP3H6bEminH+7AXmq
 hsiMZL1vwZ2PXVVBFrlinVDz2fVnN2HPF86UQvHBWHe5ZoNdWxM0zm6EI5YCqT/mo6iJ
 tN/CH5veMzwjaMmo2QFd9hBeaabW6VZqAcwmnkXWvrnUYyA4jVjfLV2/HyW1CIebgTLp
 xdsg8BVexfB09VtzSe8kxrc05NHa3Qucnz7Zx/KbqYuFyGexgQ1oFaj0ffpZK5VNzhnU gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep03vmx3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 15:48:11 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228Fit4i026728;
        Tue, 8 Mar 2022 15:48:10 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep03vmx2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 15:48:10 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228Flwmu020523;
        Tue, 8 Mar 2022 15:48:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3enpk2t7un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 15:48:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228FatBU37814606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 15:36:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502074C040;
        Tue,  8 Mar 2022 15:48:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C7C4C04E;
        Tue,  8 Mar 2022 15:48:03 +0000 (GMT)
Received: from localhost (unknown [9.171.12.198])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Mar 2022 15:48:03 +0000 (GMT)
Date:   Tue, 8 Mar 2022 16:48:02 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v6 31/39] kasan, vmalloc: only tag normal vmalloc
 allocations
Message-ID: <your-ad-here.call-01646754482-ext-2781@work.hours>
References: <cover.1643047180.git.andreyknvl@google.com>
 <fbfd9939a4dc375923c9a5c6b9e7ab05c26b8c6b.1643047180.git.andreyknvl@google.com>
 <your-ad-here.call-01646752633-ext-6250@work.hours>
 <CA+fCnZdCZ92BxnympNoRP8+3_gGDMZQgTeaUpga3ctuRq8zPYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+fCnZdCZ92BxnympNoRP8+3_gGDMZQgTeaUpga3ctuRq8zPYg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cnJS0jaZ73zICUKHNxVHC0PllMeIiWKp
X-Proofpoint-ORIG-GUID: SJYIB1z1q2pLAWtXKFCctbL9yPjmQfqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 04:30:46PM +0100, Andrey Konovalov wrote:
> On Tue, Mar 8, 2022 at 4:17 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
> >
> > On Mon, Jan 24, 2022 at 07:05:05PM +0100, andrey.konovalov@linux.dev wrote:
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > The kernel can use to allocate executable memory. The only supported way
> > > to do that is via __vmalloc_node_range() with the executable bit set in
> > > the prot argument. (vmap() resets the bit via pgprot_nx()).
> > >
> > > Once tag-based KASAN modes start tagging vmalloc allocations, executing
> > > code from such allocations will lead to the PC register getting a tag,
> > > which is not tolerated by the kernel.
> > >
> > > Only tag the allocations for normal kernel pages.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > This breaks s390 and produce huge amount of false positives.
> > I haven't been testing linux-next with KASAN for while, now tried it with
> > next-20220308 and bisected false positives to this commit.
> >
> > Any idea what is going wrong here?
> 
> Could you try the attached fix?

Wow, that was quick!
Yes, it fixes the issue for s390, kasan tests pass as well.
Thank you!
