Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C916524695
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350790AbiELHMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiELHMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:12:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC0B62204
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:12:36 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C5qPHZ009782;
        Thu, 12 May 2022 07:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=v4fdVTkpD0x7bMIL+g+Nii4Yo6oinbwoadD5PvLQjz0=;
 b=diB/cNfUw+WRgClkFk/ijSnTTiNN+DVUtej454VcLTKn3donBPD8yMQSwfYtxD3u897r
 6qAol7hkmwjXU5/vOZcfLZxzyiborbue5lKTYuPa33qLi3wF2i4sf8sXFDb20D20spst
 sUB704SazU5ga1X3EoLRIvK2d8lLDGzZVq0Qqw7+STkVk+AKGaGzJ4CC/svVlzvin6Sg
 aIhhS+145gYAZnmhgURdz+XzRvsY/oZFlXwc2IK21GW53VN2aAp1XOgJyZ3C1xdpGe9l
 LgOB5XKvZAloP3L5eOpTBt/VxTHIoeHOVbympQY+kAg6B/GP/3kVgiEFomFl6cU59CMb +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0vfm1d7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 07:12:17 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24C6sqLs029864;
        Thu, 12 May 2022 07:12:16 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0vfm1d6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 07:12:16 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24C77OB9019503;
        Thu, 12 May 2022 07:12:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3g0kn78g0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 07:12:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24C7CAmQ21299470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 07:12:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B3BBA405B;
        Thu, 12 May 2022 07:12:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F35CCA4054;
        Thu, 12 May 2022 07:12:03 +0000 (GMT)
Received: from [9.43.96.94] (unknown [9.43.96.94])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 07:12:03 +0000 (GMT)
Message-ID: <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
Date:   Thu, 12 May 2022 12:42:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T2Iz8RIj77DdMScIW3MWDrhAhauHdWa5
X-Proofpoint-ORIG-GUID: v5MXOij59Y8GDI03tvJAKXH726EDQAAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120032
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 12:33 PM, ying.huang@intel.com wrote:
> On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
>> Sysfs Interfaces
>> ================
>>
>> * /sys/devices/system/memtier/memtierN/nodelist
>>
>>    where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
>>
>>    Format: node_list
>>
>>    Read-only.  When read, list the memory nodes in the specified tier.
>>
>>    Tier 0 is the highest tier, while tier 2 is the lowest tier.
>>
>>    The absolute value of a tier id number has no specific meaning.
>>    What matters is the relative order of the tier id numbers.
>>
>>    When a memory tier has no nodes, the kernel can hide its memtier
>>    sysfs files.
>>
>> * /sys/devices/system/node/nodeN/memtier
>>
>>    where N = 0, 1, ...
>>
>>    Format: int or empty
>>
>>    When read, list the memory tier that the node belongs to.  Its value
>>    is empty for a CPU-only NUMA node.
>>
>>    When written, the kernel moves the node into the specified memory
>>    tier if the move is allowed.  The tier assignment of all other nodes
>>    are not affected.
>>
>>    Initially, we can make this interface read-only.
> 
> It seems that "/sys/devices/system/node/nodeN/memtier" has all
> information we needed.  Do we really need
> "/sys/devices/system/memtier/memtierN/nodelist"?
> 
> That can be gotten via a simple shell command line,
> 
> $ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'
> 

It will be really useful to fetch the memory tier node list in an easy 
fashion rather than reading multiple sysfs directories. If we don't have 
other attributes for memorytier, we could keep
"/sys/devices/system/memtier/memtierN" a NUMA node list there by 
avoiding /sys/devices/system/memtier/memtierN/nodelist

-aneesh
