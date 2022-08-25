Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E8A5A10B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiHYMjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiHYMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:39:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36759B3B25
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:39:43 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PCV0kL000742;
        Thu, 25 Aug 2022 12:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=D1HXvIipn38VjWnHwft/CRCVpfzWYUXHVdf+01lGdcw=;
 b=O5eHhNM1QHSFAxkuJS5q+9Kxyelvo/vJugHWBEaF5H8cjHEV64uGIgeHfyTZN3UiGgN6
 sGDlJ9DLrgX1+E03owbb5GZHRZdxiXgynUrnfWDSqIqzRXZ4NY+snPd8yXohs+SeCoMr
 NBcgivrMk5fMjObCrnoNIQZ/LtcZsITMhZx5he4KONfDndheE1jHKL4rqlg9QvD7BVps
 hROUhRmhCki+yoZFWtXzyFfBnNEwqby9h4NQfBeEaBelVt/ScXq2uEY2lN8fqiWHMLn8
 bS3Wx+KwmQJP2b7vTwPvziUWAXIzzmDLCHiCQRmaztaxVGO7ivWZUvSrU0i3m9kVukdQ xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j695g871s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 12:39:25 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27PCWGgj006994;
        Thu, 25 Aug 2022 12:39:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j695g870m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 12:39:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27PCZTcX017118;
        Thu, 25 Aug 2022 12:39:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3j2q88xdwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 12:39:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27PCdKrE38469962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 12:39:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC4F711C050;
        Thu, 25 Aug 2022 12:39:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3623311C04A;
        Thu, 25 Aug 2022 12:39:19 +0000 (GMT)
Received: from thinkpad (unknown [9.171.48.155])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 25 Aug 2022 12:39:19 +0000 (GMT)
Date:   Thu, 25 Aug 2022 14:39:17 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Haiyue Wang <haiyue.wang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        apopple@nvidia.com, linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev,
        alex.sierra@amd.com, mike.kravetz@oracle.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v7 1/2] mm: migration: fix the FOLL_GET failure on
 following huge page
Message-ID: <20220825143917.32175f7d@thinkpad>
In-Reply-To: <20220824113858.9f0a2200c4d4875a5f4da31c@linux-foundation.org>
References: <20220823135841.934465-1-haiyue.wang@intel.com>
        <20220823135841.934465-2-haiyue.wang@intel.com>
        <20220824113858.9f0a2200c4d4875a5f4da31c@linux-foundation.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JtL63ucY0yK-JM42RFLKa5zovTmLb8a2
X-Proofpoint-GUID: 2F93koStuZsD4VC0dwqoUaTqebve8890
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=714 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 11:38:58 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 23 Aug 2022 21:58:40 +0800 Haiyue Wang <haiyue.wang@intel.com> wrote:
> 
> > Not all huge page APIs support FOLL_GET option, so move_pages() syscall
> > will fail to get the page node information for some huge pages.
> > 
> > Like x86 on linux 5.19 with 1GB huge page API follow_huge_pud(), it will
> > return NULL page for FOLL_GET when calling move_pages() syscall with the
> > NULL 'nodes' parameter, the 'status' parameter has '-2' error in array.
> > 
> > Note: follow_huge_pud() now supports FOLL_GET in linux 6.0.
> >       Link: https://lore.kernel.org/all/20220714042420.1847125-3-naoya.horiguchi@linux.dev
> > 
> > But these huge page APIs don't support FOLL_GET:
> >   1. follow_huge_pud() in arch/s390/mm/hugetlbpage.c
> >   2. follow_huge_addr() in arch/ia64/mm/hugetlbpage.c
> >      It will cause WARN_ON_ONCE for FOLL_GET.
> >   3. follow_huge_pgd() in mm/hugetlb.c
> 
> What happened to the proposal to fix these three sites so this patch is
> not needed?

For s390, you can add my patch from
https://lore.kernel.org/linux-mm/20220818135717.609eef8a@thinkpad/
to this series.

Or we can bring it upstream via s390 tree, whatever suits best. It
certainly makes sense to have, also independent from this series.
Adding some s390 people on cc.
