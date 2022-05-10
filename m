Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9459652140A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbiEJLnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbiEJLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:42:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FCB2415F3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:38:52 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AA88Qm017836;
        Tue, 10 May 2022 11:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=me9LNv8Y4xpK6K0YUs/VaQRXYM8MnWuLPxbS1JSaCU4=;
 b=AZUwU0vW7PIBl8pn+K8ZGkkN6ll4LQJqBkLw+ZFbr+LEDzBtHjGFrv26A8AVOEKhlE0o
 2f4ypgjaUH1WflbeCo75PnYn58S48Yo0CqAenyiQF7VPAPaiWfT0J+anawnkCux89Dvh
 aqoCPFNZ/cvVjHzMRb3do6TvZnxHPfQY9s7SQsT3hsyYQ7MyxXc+d5BYygM5S3DWeVlq
 ZJkRU1yut5iR7zr8Qgv/+9Sfg2+DP6ZCDKTmXDyUgC5rEwO+I5VfMpVe/wrfYbR0cGRR
 kvrOAYRznvQdsnFge52hnyOa6Bi+p+KxcVKIFU5ZXzLJNfXWp8gS0p91MeEb4d0+Ecvv NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fymx0jr1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:38:37 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24ABZw1N016475;
        Tue, 10 May 2022 11:38:37 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fymx0jr13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:38:37 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24ABH86b018742;
        Tue, 10 May 2022 11:38:35 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3fwgd9vp81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:38:35 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ABcZFu24379850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 11:38:35 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EC6D12405A;
        Tue, 10 May 2022 11:38:35 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EBF8124054;
        Tue, 10 May 2022 11:38:28 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.24.223])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 11:38:28 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>, Wei Xu <weixugc@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
In-Reply-To: <875ymerl81.fsf@nvdebian.thelocal>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <87tua3h5r1.fsf@nvdebian.thelocal>
 <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
 <875ymerl81.fsf@nvdebian.thelocal>
Date:   Tue, 10 May 2022 17:08:26 +0530
Message-ID: <87fslhhb2l.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oyyZh7JwVYEaZ5I-CZ9zW5n4UakADTq1
X-Proofpoint-GUID: r15FvQ0tpc82jz2Sx0KqfczjX0VwwDOi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205100052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Wei Xu <weixugc@google.com> writes:
>
>> On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
>>>
>>> Wei Xu <weixugc@google.com> writes:
>>>
>>> [...]
>>>
>>> >> >
>>> >> >
>>> >> > Tiering Hierarchy Initialization
>>> >> > `=============================='
>>> >> >
>>> >> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>>> >> >
>>> >> > A device driver can remove its memory nodes from the top tier, e.g.
>>> >> > a dax driver can remove PMEM nodes from the top tier.
>>> >>
>>> >> With the topology built by firmware we should not need this.
>>>
>>> I agree that in an ideal world the hierarchy should be built by firmware based
>>> on something like the HMAT. But I also think being able to override this will be
>>> useful in getting there. Therefore a way of overriding the generated hierarchy
>>> would be good, either via sysfs or kernel boot parameter if we don't want to
>>> commit to a particular user interface now.
>>>
>>> However I'm less sure letting device-drivers override this is a good idea. How
>>> for example would a GPU driver make sure it's node is in the top tier? By moving
>>> every node that the driver does not know about out of N_TOPTIER_MEMORY? That
>>> could get messy if say there were two drivers both of which wanted their node to
>>> be in the top tier.
>>
>> The suggestion is to allow a device driver to opt out its memory
>> devices from the top-tier, not the other way around.
>
> So how would demotion work in the case of accelerators then? In that
> case we would want GPU memory to demote to DRAM, but that won't happen
> if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
> only override available with this proposal would move GPU memory into a
> lower tier, which is the opposite of what's needed there.

How about we do 3 tiers now. dax kmem devices can be registered to
tier 3. By default all numa nodes can be registered at tier 2 and HBM or
GPU can be enabled to register at tier 1. ?

-aneesh
