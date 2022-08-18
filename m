Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61F597DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 06:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiHREqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 00:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiHREqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 00:46:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D4D5E30D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 21:46:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMN1ct009288;
        Thu, 18 Aug 2022 04:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0JBOs6HlHg7Mg1xf2ppWSsQiLRFFk8voQZ+fG5Ay2PM=;
 b=ofYNntuXorsaUJ0OYB6x7USJM2K0vMJn8Ute8aiFwKt9G2mEapAoEwp1qz4Ouq828ebz
 jT2pWflw7Q+pIrDDjpkEDB55YqCFIUEq7VdF4xJeI2nFwUKJzouxcfa6bga5aak145Kn
 ZOEJvKT0gclaWTLjNGm1O12q/zT55Bhhj58UD/9mCaobmElPAc9n6t8f9agpJXRKUotu
 x7vxjsUB2tvMEqE5dOocsQ3ekbXbgcSjIgt6V3bF8HBOsTjynpu7pbL+wIi4DEAna4I6
 EriZgYusUq9jjcIxJX2ClGaMZ2/PX36QV7k4NlYHfJnL/EVM1NVkKVJJbM5liTCyzjT5 Dg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j127jar92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:46:07 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27I4k6tA031997
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 04:46:06 GMT
Received: from [10.216.2.114] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 17 Aug
 2022 21:46:04 -0700
Message-ID: <e5901866-4bda-e95e-c0a1-ec29ec487e19@quicinc.com>
Date:   Thu, 18 Aug 2022 10:15:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] mm: oom_kill: add trace logs in process_mrelease()
 system call
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <quic_charante@quicinc.com>, <quic_pkondeti@quicinc.com>
References: <20220816060017.17996-1-pbrahma@qti.qualcomm.com>
 <20220817090247.ef99115ca7a6c847f90dc4c6@linux-foundation.org>
From:   Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <20220817090247.ef99115ca7a6c847f90dc4c6@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kd6jcTOdqImCGANkcUc6TMp6GRaRRh_g
X-Proofpoint-ORIG-GUID: Kd6jcTOdqImCGANkcUc6TMp6GRaRRh_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=792
 mlxscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180015
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-08-2022 21:32, Andrew Morton wrote:
> On Tue, 16 Aug 2022 11:30:17 +0530 Pratyush Brahma <pbrahma@qti.qualcomm.com> wrote:
>
>> From: Charan Teja Kalla <quic_charante@quicinc.com>
>>
>> The process_mrelease() system call[1] is used to release the memory of
>> a dying process from the context of the caller, which is similar to and
>> uses the functions of the oom reaper logic. There exists trace logs for
>> a process when reaped by the oom reaper. Just extend the same to when
>> done by the process_mrelease() system call.
>>
>> ...
>>
>> +	pr_debug("process_mrelease: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
>> +						task_pid_nr(task), task->comm,
>> +						K(get_mm_counter(mm, MM_ANONPAGES)),
>> +						K(get_mm_counter(mm, MM_FILEPAGES)),
>> +						K(get_mm_counter(mm, MM_SHMEMPAGES)));
> This addition wasn't changelogged.  It's the only pr_debug in
> oom_kill.c.  Please explain?

The equivalent pr_info() message as in oom_reap_task_mm() is made 
pr_debug() here as per review comments in patch-set v1.

>
