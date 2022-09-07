Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8CE5AFEE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIGIXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIGIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:23:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D783BD1;
        Wed,  7 Sep 2022 01:23:09 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28788GQj024283;
        Wed, 7 Sep 2022 08:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=xXa7LAAk9UwYnkv/kf2VLumlZSHOsw7QELcgqLgZJZU=;
 b=mtR3XXUg9pfFlrMabUivIDFKafCKs18+I5MU8PEe46/fUJWDolRATlXn2N8kl0T8msvo
 Y0edT7QbFQNsn3yNPNaKaio273N5vkiEjj1VLJLF6SuXoqrY8HlGdgja5+1GYpo3GD1m
 +lgLotB80rEGw05ZRyHOBt1cuKF5WhVjJXFAhD3ed1oLSDTHkiRFyeeq8IkgTJktxtsO
 +qBYuUouAcMRaED7cnHruM/vl6VO6UwDmniwP/uXrOLnM62da6JFhpLLnx/NCMDE14yP
 zuAmRvkhGEQJTiZ1AhcpLvuM4DgTG8gzhxjKvxCuFRoT2EdoJZV8t2oZ5gVPquODvcXz Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jeq4t901g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 08:22:35 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28788Sbk026453;
        Wed, 7 Sep 2022 08:22:34 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jeq4t900d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 08:22:33 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2878KMeV010791;
        Wed, 7 Sep 2022 08:22:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3jbxj8vuwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 08:22:31 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2878MRoq17301866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Sep 2022 08:22:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD8014C046;
        Wed,  7 Sep 2022 08:22:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 199C74C040;
        Wed,  7 Sep 2022 08:22:27 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  7 Sep 2022 08:22:27 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
        <20220824175757.20590-5-mike.kravetz@oracle.com>
        <yt9dr10ok3lm.fsf@linux.ibm.com> <Yxd5z0c8NlKVlVqk@monkey>
        <YxeL7ZMoyNmPAvY0@monkey> <YxfTA53/5pkpC7xZ@monkey>
        <367db2b5-5242-9be6-1d5f-d13e35f84167@huawei.com>
        <YxgD7qXPgkJ9VgJn@monkey>
        <25ffa1bf-0025-3421-53cb-79f986468cb6@huawei.com>
        <YxgQbSvDzQq7covC@monkey>
Date:   Wed, 07 Sep 2022 10:22:26 +0200
In-Reply-To: <YxgQbSvDzQq7covC@monkey> (Mike Kravetz's message of "Tue, 6 Sep
        2022 20:30:53 -0700")
Message-ID: <yt9d5yhzk30d.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GJ9D6KkJ257NaDv0kCIN9UQIhXZxNtrU
X-Proofpoint-GUID: 2RT4E0ehZUR5WGgGuvXZLFX04sl8vb4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_04,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> Would you be willing to try the patch below in your environment?
> It addresses the stall I can create with a file that has a VERY large hole.
> In addition, it passes libhugetlbfs tests and has run for a while in my
> truncate/page fault race stress test.  However, it is very early code.
> It would be nice to see if it addresses the issue in your environment.

Yes, that fixes the issue for me. I added some debugging yesterday
evening after sending the initial report, and the end value in the loop
was indeed quite large - i didn't record the exact number, but it was
something like 0xffffffffff800001. Feel free to add my Tested-by.

Thanks
Sven
