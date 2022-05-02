Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E95B516B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358512AbiEBH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbiEBH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:27:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D211C2A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:23:47 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24278Rqk021447;
        Mon, 2 May 2022 07:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=YQB6wDDMj5JcWys4Hc57er6zcN2qmD7KxLoOkNkGhBs=;
 b=YFOeKuTfm/Eh1cKAZ6YEFFoYzDeCN54SQhxppqigoNtu3yvSRR/niI5WQ//QR7wfGiC/
 X9YJcSCJZHI3BZ/uMxVbSH6bjzdK8DewtTbn0UvcBtP/0FI/s3vhr+2C1uKvDahmkYBP
 pKtSsvXgI0cCRytsjVqcEGoDETEGxI0i1hlu80ML+U5twL3oCEQq8jYZu/qDB0nTlssy
 ZbFMRX2q8mtCPLCbuPZUnumAY9QtJG1xeNwVyuyBQDsPLbPVWFBVn1bdYFutc1MrwEqu
 VvyCdwNhMrQwBnvR/euUsx1sihDReD749M7HK8HBdM1CsULiyCIiHwygcocZnUYNrlAy rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fsf66vn6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 07:23:23 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2427FpW4016249;
        Mon, 2 May 2022 07:23:22 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fsf66vn6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 07:23:22 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2427BnhP016235;
        Mon, 2 May 2022 07:23:21 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 3frvr93t3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 07:23:21 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2427NLp131064424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 07:23:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AF866E05D;
        Mon,  2 May 2022 07:23:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 158F66E053;
        Mon,  2 May 2022 07:23:14 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.74.71])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 May 2022 07:23:13 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
Subject: Re: RFC: Memory Tiering Kernel Interfaces
In-Reply-To: <20220501175813.tvytoosygtqlh3nn@offworld>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld>
Date:   Mon, 02 May 2022 12:53:11 +0530
Message-ID: <87ee1cv1nk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t_CELR3ehHiO8Nup_quIkLgssZJ9pJ2_
X-Proofpoint-ORIG-GUID: kbUDMArbM8dJzS2RSB7kA1dc_xzfQdaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_02,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> writes:

> Nice summary, thanks. I don't know who of the interested parties will be
> at lsfmm, but fyi we have a couple of sessions on memory tiering Tuesday
> at 14:00 and 15:00.

Will there be an online option this time? If so, i would like to
participate in this discussion. I have not closely followed LSF/MM
details this year. So not sure how to get the online attend request out.

>
> On Fri, 29 Apr 2022, Wei Xu wrote:
>
>>The current kernel has the basic memory tiering support: Inactive
>>pages on a higher tier NUMA node can be migrated (demoted) to a lower
>>tier NUMA node to make room for new allocations on the higher tier
>>NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
>>migrated (promoted) to a higher tier NUMA node to improve the
>>performance.
>
> Regardless of the promotion algorithm, at some point I see the NUMA hinting
> fault mechanism being in the way of performance. It would be nice if hardware
> began giving us page "heatmaps" instead of having to rely on faulting or
> sampling based ways to identify hot memory.


Power10 hardware can do this. Right now we are looking at integrating
this to MultiGen LRU. We haven't got it to work. One of the challenges is
how to estimate the relative hotness of the page compared to the rest of the
pages in the system. I am looking at the random sampling of the oldest
generation pages (the page list in the shrink page list) and using the hot
and cold page in that random sample to determine the hotness of a
specific page and whether to reclaim it or not.

-aneesh
