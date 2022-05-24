Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5997532B43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbiEXN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEXN13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:27:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E3985AC
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 06:27:28 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OCH5HH008971;
        Tue, 24 May 2022 13:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=xf2fdIO0FYrbYefz3rUMA5V4Vp2E6/jT2Pv3lYomQMk=;
 b=Lqnwc8izt1JuQNxW7HxUhwhbCTC5TKFVnodLBTjFIo7J5CD+qiNNHv3qgt72Y0BVzmWK
 GPZGEPy4vGii/u7mNeVjQturXuPNDp+Dp5hm87Kj8dP/MuW81yw8u4UKpbKAUnJ1PxBA
 5Shd4T6REUUdRNDCvqs0aHr6HP6214V1Kw3e3gjlCdHb6AoZjHPi7jFaQGFnsMDwkVGn
 eTC+Fvnx2yExCzfedXzcRwoMmodJDDlJPFUZiHV6isq8FyC7RNNZUhiWejLV7bVPpCqN
 J+8SEMvqtSrTeuNij5nz91uvXts8oGsbSR7U1rHcc/BH7xpJ2awRZT3/JGN1od9iwYe6 bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8y7y1jfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:27:07 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24OCtufI010949;
        Tue, 24 May 2022 13:27:07 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g8y7y1jey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:27:07 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24ODK4DH025223;
        Tue, 24 May 2022 13:27:06 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3g6qq9g680-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 13:27:06 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ODR5gg12845612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 13:27:05 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48F78BE04F;
        Tue, 24 May 2022 13:27:05 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A67FBE053;
        Tue, 24 May 2022 13:26:57 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.104.172])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 13:26:56 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Wei Xu <weixugc@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
In-Reply-To: <CAAPL-u_c+q_uCMJXOtYGg42Fj2gSnD6c8vgYQmi1iVpRwHiQTw@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com>
 <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <20220518130037.00001cce@Huawei.com>
 <CAAPL-u_c+q_uCMJXOtYGg42Fj2gSnD6c8vgYQmi1iVpRwHiQTw@mail.gmail.com>
Date:   Tue, 24 May 2022 18:56:54 +0530
Message-ID: <8735gzdpsx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: prabyj7jX9mtGqsPemWtPk6pdJ5Dgmfv
X-Proofpoint-ORIG-GUID: cmIXNdZk3T_Z9Ka-HLM7VnS6Q8FYZ8FK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Wed, May 18, 2022 at 5:00 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>>
>> On Wed, 18 May 2022 00:09:48 -0700
>> Wei Xu <weixugc@google.com> wrote:

...

> Nice :)
>>
>> Initially I thought this was over complicated when compared to just leaving space, but
>> after a chat with Hesham just now you have us both convinced that this is an elegant solution.
>>
>> Few corners probably need fleshing out:
>> *  Use of an allocator for new tiers. Flat number at startup, or new one on write of unique
>>    value to set_memtier perhaps?  Also whether to allow drivers to allocate (I think
>>    we should).
>> *  Multiple tiers with same rank.  My assumption is from demotion path point of view you
>>    fuse them (treat them as if they were a single tier), but keep them expressed
>>    separately in the sysfs interface so that the rank can be changed independently.
>> *  Some guidance on what values make sense for given rank default that might be set by
>>    a driver. If we have multiple GPU vendors, and someone mixes them in a system we
>>    probably don't want the default values they use to result in demotion between them.
>>    This might well be a guidance DOC or appropriate set of #define
>
> All of these are good ideas, though I am afraid that these can make
> tier management too complex for what it's worth.
>
> How about an alternative tier numbering scheme that uses major.minor
> device IDs?  For simplicity, we can just start with 3 major tiers.
> New tiers can be inserted in-between using minor tier IDs.


What drives the creation of a new memory tier here?  Jonathan was
suggesting we could do something similar to writing to set_memtier for
creating a new memory tier.

$ echo "memtier128" > sys/devices/system/node/node1/set_memtier

But I am wondering whether we should implement that now. If we keep
"rank" concept and detach tier index (memtier0 is the memory tier with
index 0) separate from rank, I assume we have enough flexibility for a
future extension that will allow us to create a memory tier from userspace
and assigning it a rank value that helps the device to be placed before or
after DRAM in demotion order. 

ie, For now we will only have memtier0, memtier1, memtier2. We won't add
dynamic creation of memory tiers and the above memory tiers will have
rank value 0, 1, 2 according with demotion order 0 -> 1 -> 2.

-aneesh
