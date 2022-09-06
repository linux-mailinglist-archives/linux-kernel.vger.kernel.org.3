Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D95AE89F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiIFMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiIFMon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:44:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9514080
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:44:41 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286CbCEn020000;
        Tue, 6 Sep 2022 12:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aLiia9cv/H9VO0A3fCfKoChq6jsxospxMgsJGtmhiGA=;
 b=YzDfTpvOMPj4NLw/OUobNTG8N/rijW5GTwgfHL+Gqe0S18AmuvBfuqoCbQMPf+V+Q5ER
 wMf7J3I/Ry6ceMtuHXxnzIeBngzGQBYxv8JmgQM3J0S7tLnhi6UgZ5DjbHhgPMXZzyPo
 C/JPsXM+s6O+NwLXp8vdnMqJTV5m+zY12kLNg93c5qbPlfWjKP2hDme1nhm/KxT68Rpl
 Y7jvspAcytUTOyUrEe6KeP/4gNNqXTbr75PkKN6+hSkbl6g4PCtB49hEPE8Z0/HFIq11
 sIcMj8G5t0JxvC5cw+Gw0VGThzSaXniue34+iGWnbNoB4EmB6g+9vDcOnNjrgFf5Hms+ 5Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jdufwj5vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 12:44:23 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 286CiMXD023148;
        Tue, 6 Sep 2022 12:44:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 3jdckj5uj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 12:44:22 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286CiMbJ023145;
        Tue, 6 Sep 2022 12:44:22 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 286CiMQE023144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 12:44:22 +0000
Received: from [10.216.31.204] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 6 Sep 2022
 05:44:07 -0700
Message-ID: <423dee31-a7e8-34ee-1a99-6780a1a07c35@quicinc.com>
Date:   Tue, 6 Sep 2022 18:13:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] locking/rwsem: Disable preemption while trying for rwsem
 lock
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <will@kernel.org>, <boqun.feng@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
References: <1662028090-26495-1-git-send-email-quic_mojha@quicinc.com>
 <8c33f989-8870-08c6-db12-521de634b34e@redhat.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <8c33f989-8870-08c6-db12-521de634b34e@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iSHZm8a3EARX3dqIHGA8VPzPUqRxz_1o
X-Proofpoint-GUID: iSHZm8a3EARX3dqIHGA8VPzPUqRxz_1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_07,2022-09-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=560 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060060
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/3/2022 2:25 AM, Waiman Long wrote:
> 
> On 9/1/22 06:28, Mukesh Ojha wrote:
>> From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
>>
>> Make the region inside the rwsem_write_trylock non preemptible.
>>
>> We observe RT task is hogging CPU when trying to acquire rwsem lock
>> which was acquired by a kworker task but before the rwsem owner was set.
>>
>> Here is the scenario:
>> 1. CFS task (affined to a particular CPU) takes rwsem lock.
>>
>> 2. CFS task gets preempted by a RT task before setting owner.
>>
>> 3. RT task (FIFO) is trying to acquire the lock, but spinning until
>> RT throttling happens for the lock as the lock was taken by CFS task.
> 
> Note that the spinning is likely caused by the following code in 
> rwsem_down_write_slowpath():
> 
> 1163                 /*
> 1164                  * After setting the handoff bit and failing to 
> acquire
> 1165                  * the lock, attempt to spin on owner to accelerate 
> lock
> 1166                  * transfer. If the previous owner is a on-cpu 
> writer and it
> 1167                  * has just released the lock, OWNER_NULL will be 
> returned.
> 1168                  * In this case, we attempt to acquire the lock again
> 1169                  * without sleeping.
> 1170                  */
> 1171                 if (waiter.handoff_set) {
> 1172                         enum owner_state owner_state;
> 1173
> 1174                         preempt_disable();
> 1175                         owner_state = rwsem_spin_on_owner(sem);
> 1176                         preempt_enable();
> 1177
> 1178                         if (owner_state == OWNER_NULL)
> 1179                                 goto trylock_again;
> 1180                 }
> 
> rwsem_optimistic_spin() limits RT task one additional attempt if 
> OWNER_NULL is returned. There is no such limitation in this loop. So an 
> alternative will be to put a limit on the number of times an OWNER_NULL 
> return values will be allowed to continue spinning without sleeping. 
> That put the burden on the slowpath instead of in the fastpath.
> 
> Other than the slight overhead in the fastpath, the patch should work too.
> 
> Acked-by: Waiman Long <longman@redhat.com>

Thanks Waiman for your time and suggestion.
Would like to take others opinion as well.

-Mukesh

> 
> Cheers,
> Longman
> 
