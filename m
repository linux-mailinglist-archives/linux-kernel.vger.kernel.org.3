Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD60A57B60D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiGTMCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiGTMCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:02:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA506B241;
        Wed, 20 Jul 2022 05:02:13 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KBvTUF023688;
        Wed, 20 Jul 2022 12:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PounAutb3kLS4hWLQOwWstVt1Gn/0IZTeXgbAgcBKLU=;
 b=OhZNbju618cRfiZf7Eyko8mruqAG2W2TCSBDQiXAkINfmhpxzeQliRmkQyV/kZIjmWLG
 LzLAUrEVAgn8NK5k826QKAFr7spN01LkN9eCPlejYs+qRldvQFjqtHu4lPCmXhfc1Cep
 857O1djV0+Xj13rnAjGYUG0kG5E4vvT1wjyv+dwpAmj3V1Rv8Lwf4jHZ2nUhB7eQ9Ivy
 CrgLdIEtEU/AUiUlg/U1NlqP577UGnOCMlBRKm9WkAaEhq9JlwvnD7y3myufxuLaAmcX
 Ra9SYA0ssy+T5KYZXHLA1VwHUGBJ7+dj14aO6mzhNS0Jhe6okjRgxhaSJPTYGmt5Fz4M Yg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hdyenan0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:02:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26KC20pX031544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:02:00 GMT
Received: from [10.216.42.116] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Jul
 2022 05:01:56 -0700
Message-ID: <224b19f3-912d-b858-7af4-185b8e55bc66@quicinc.com>
Date:   Wed, 20 Jul 2022 17:31:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Query regarding deadlock involving cgroup_threadgroup_rwsem and
 cpu_hotplug_lock
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Imran Khan <imran.f.khan@oracle.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <tglx@linutronix.de>, <steven.price@arm.com>,
        <peterz@infradead.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <8245b710-8acb-d8e6-7045-99a5f71dad4e@oracle.com>
 <26d0e4cc-be0e-2c12-6174-dfbb1edb1ed6@oracle.com>
 <bbc01477-231b-3dbb-3e09-9338f5413f06@oracle.com>
 <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
In-Reply-To: <ba48eac5-8ef7-251b-11fe-8163bb7a2d54@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: puTMElQ4vtFXSKIlvddnNTps20B_11BW
X-Proofpoint-ORIG-GUID: puTMElQ4vtFXSKIlvddnNTps20B_11BW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_05,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like these patches are the fixes.

https://lore.kernel.org/all/YtDvN0wJ6CKaEPN8@slm.duckdns.org/#r

Would let Tejun confirm this .

-Mukesh

On 7/20/2022 4:36 PM, Mukesh Ojha wrote:
> Hi,
> 
> On 7/20/2022 8:57 AM, Imran Khan wrote:
>> Hello everyone,
>>
>> I am seeing a deadlock between cgroup_threadgroup_rwsem and 
>> cpu_hotplug_lock in
>> 5.4 kernel.
>>
>> Due to some missing drivers I don't have this test setup for latest 
>> upstream
>> kernel but looking at the code the issue seems to be present in the 
>> latest
>> kernel as well. If needed I can provide stack traces and other 
>> relevant info
>> from the vmcore that I have got from 5.4 setup.
>>
>> The description of the problem is as follows (I am using 5.19-rc7 as 
>> reference
>> below):
>>
>> __cgroup_procs_write acquires cgroup_threadgroup_rwsem via
>> cgroup_procs_write_start and then invokes cgroup_attach_task. Now
>> cgroup_attach_task can invoke following call chain:
>>
>> cgroup_attach_task --> cgroup_migrate --> cgroup_migrate_execute --> 
>> cpuset_attach
>>
>> Here cpuset_attach tries to take cpu_hotplug_lock.
>>
>> But by this time if some other context
>>
>> 1. is already in the middle of cpu hotplug and has acquired 
>> cpu_hotplug_lock in
>> _cpu_up but
>> 2. has not yet reached CPUHP_ONLINE state and
>> 3. one of the intermediate hotplug states (in my case 
>> CPUHP_AP_ONLINE_DYN ) has
>> a callback which involves creation of a thread (or invocation of 
>> copy_process
>> via some other path) the invoked copy_process will get blocked on
>> cgroup_threadgroup_rwsem in following call chain:
>>
>>     copy_process --> cgroup_can_fork --> cgroup_css_set_fork -->
>> cgroup_threadgroup_change_begin
> 
> Similar discussion is at [1], not sure on the conclusion.
> 
> [1]
> https://lore.kernel.org/lkml/20220705123705.764-1-xuewen.yan@unisoc.com/
> 
> -Mukesh
> 
>>
>>
>> I am looking for suggestions to fix this deadlock.
>>
>> Or if I am missing something in the above analysis and the above mention
>> scenario can't happen in latest upstream kernel, then please let me 
>> know as that
>> would help me in back porting relevant changes to 5.4 kernel because 
>> the issue
>> definitely exists in 5.4 kernel.
>>
>> Thanks,
>> -- Imran
