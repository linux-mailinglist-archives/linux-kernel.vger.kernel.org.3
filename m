Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B264ECA70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 19:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349227AbiC3RTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349221AbiC3RTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 13:19:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0B7220FF3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 10:17:36 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UGtbYM000488;
        Wed, 30 Mar 2022 17:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=WnT/FPbecNgeNjgTl4sWxg/cIo055hB7G+J95/VPQ7I=;
 b=qm0I0ARSatraS70sFTWe6RpOSDjt8mu2S1teH14vI9WOKrJ6IiZVMV5BGzy2JzfP+kVo
 PLWJLcI9ygVHRbkGAdcBjxq7quAt4KcPVCjtz+TyKg63phgh4QK+8o6RraSarUCUpBtq
 bwC2OX6YXRNcFIzYI2Pwfme7QUtDsD7HlktObQgUN9Bm/OBkp9uemXIleS4mYXfyxUAd
 HPXnK2uNU2HjL30Pkw5J4OXnhEZYd11SZbL/NseFQqMcePMPXc/QDcig7bCj4p6mBt1Q
 4B2MQWsC3y2t8xthVEf/z3PzxXj9WEQuFEihF6pH68BmMgnVPjx7VcB4CMTDBgtTmd6Y Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4psu72er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 17:17:31 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22UGxCBs019219;
        Wed, 30 Mar 2022 17:17:31 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f4psu72ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 17:17:31 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22UHHRZt013569;
        Wed, 30 Mar 2022 17:17:30 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3f1tfa6a3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 17:17:30 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22UHHTSk31392246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 17:17:29 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 259E16E05D;
        Wed, 30 Mar 2022 17:17:29 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 556FC6E050;
        Wed, 30 Mar 2022 17:17:26 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.53.202])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 30 Mar 2022 17:17:26 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
In-Reply-To: <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Wed, 30 Mar 2022 22:47:22 +0530
Message-ID: <87lewrxsv1.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5USCSqsLEyAdhhKHXkTTh47HeOaHRW_G
X-Proofpoint-GUID: doDzKTeHPCg52ARunJhVRlrj3-1UjLs8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_06,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=771
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Hi, Jagdish,
>
> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
>

...

>> e.g. with below NUMA topology, where node 0 & 1 are
>> cpu + dram nodes, node 2 & 3 are equally slower memory
>> only nodes, and node 4 is slowest memory only node,
>>
>> available: 5 nodes (0-4)
>> node 0 cpus: 0 1
>> node 0 size: n MB
>> node 0 free: n MB
>> node 1 cpus: 2 3
>> node 1 size: n MB
>> node 1 free: n MB
>> node 2 cpus:
>> node 2 size: n MB
>> node 2 free: n MB
>> node 3 cpus:
>> node 3 size: n MB
>> node 3 free: n MB
>> node 4 cpus:
>> node 4 size: n MB
>> node 4 free: n MB
>> node distances:
>> node   0   1   2   3   4
>>   0:  10  20  40  40  80
>>   1:  20  10  40  40  80
>>   2:  40  40  10  40  80
>>   3:  40  40  40  10  80
>>   4:  80  80  80  80  10
>>
>> The existing implementation gives below demotion targets,
>>
>> node    demotion_target
>>  0              3, 2
>>  1              4
>>  2              X
>>  3              X
>>  4		X
>>
>> With this patch applied, below are the demotion targets,
>>
>> node    demotion_target
>>  0              3, 2
>>  1              3, 2
>>  2              3
>>  3              4
>>  4		X
>
> For such machine, I think the perfect demotion order is,
>
> node    demotion_target
>  0              2, 3
>  1              2, 3
>  2              4
>  3              4
>  4              X

I guess the "equally slow nodes" is a confusing definition here. Now if the
system consists of 2 1GB equally slow memory and the firmware doesn't want to
differentiate between them, firmware can present a single NUMA node
with 2GB capacity? The fact that we are finding two NUMA nodes is a hint
that there is some difference between these two memory devices. This is
also captured by the fact that the distance between 2 and 3 is 40 and not 10.

For that specific topology where the distance between 2 and 3 is 40 and 2
and 4 is 80, the demotion target derived by the new code is better
right? 

...


-aneesh
