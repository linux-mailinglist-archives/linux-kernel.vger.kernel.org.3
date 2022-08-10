Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EDC58E8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiHJI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiHJI2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:28:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853B79686
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:28:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A7p73A026468;
        Wed, 10 Aug 2022 08:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JyH63/DzufmeL7nG259GtZLuQ0XDp5qO2kFdMG1yuIM=;
 b=DM7f2eLuGJTTvAzutMYfqmDK6LfZxBtnsjhwo7QZ38H2b1Y5LBxhD2Og4hRg/qfdH1VE
 dj8TJ3gDMuLYJwUXqeUJ0782E8EuZDcUUwKPmc7eWGN3STdeVjpb4LWHrTeZ8D9VpEZY
 DvGTumXba60TouprRvYqflao3N5/5a25OB1ECocD9jEWvhKQTY+KUgUOak1LGicEhz2K
 /OAqrMJxNcg+0AFIEUfi6CjPkk4YnmamOUzM3FG0M+DVvhn15p9YYHtPOPQkzAWKXS+N
 sXHHisseIAW5wRvh7uYT8ffc8hIyBM9rWTVWGsT6rbnFm9BHCnhNKbhsOCQ2oMC8EB+F lQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwqe1rn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 08:27:46 +0000
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27A8Rk1j026893;
        Wed, 10 Aug 2022 08:27:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 3hshckc8fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 08:27:46 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27A8IYAB007390;
        Wed, 10 Aug 2022 08:27:46 GMT
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 27A8Rjpw026888
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 08:27:45 +0000
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 01:27:45 -0700
Received: from [10.216.32.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 01:27:40 -0700
Message-ID: <3aab7518-ff57-abdb-8bab-ea581197a07e@quicinc.com>
Date:   Wed, 10 Aug 2022 13:57:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <pasha.tatashin@soleen.com>,
        <sieberf@amazon.com>, <shakeelb@google.com>, <sjpark@amazon.de>,
        <dhowells@redhat.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Minchan Kim <minchan@kernel.org>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <20220809185714.5af7057c1270b11079cb196a@linux-foundation.org>
 <YvNc8vuinnddc78j@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YvNc8vuinnddc78j@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y8tFQTZ82Hz8mefPlE0m5I5fV6vmkqXz
X-Proofpoint-ORIG-GUID: Y8tFQTZ82Hz8mefPlE0m5I5fV6vmkqXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=690 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100024
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew/Michal!!

On 8/10/2022 12:53 PM, Michal Hocko wrote:
> On Tue 09-08-22 18:57:14, Andrew Morton wrote:
>> On Tue, 9 Aug 2022 20:16:43 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
>>
>>> The below is one path where race between page_ext and  offline of the
>>> respective memory blocks will cause use-after-free on the access of
>>> page_ext structure.
>>
>> Has this race ever been observed at runtime?
>>
>> Given the size of the fix, I'm looking for excuses to not backport it
>> into -stable kernels!
> 
> I believe this is quite theoretical for two reasons
> 1) the memory hotplug (offlining) is quite rare operation
> 2) with all the retries the race window is quite hard to trigger
> 
> So this is good to have address long term but nothing really for stable
> until somebody actually hits that with a real world workload.
> 

Actually in the embedded systems the offline is not a rare operation,
especially,  in cases where one want to save some power through PASR[1].

This issue is caught with and in the page_pinner[2](currently being used
in Android) path where it is accessing the page_ext of a page after it
is freed. This is again not with the real workload but with some stress
tests. So, I am also agree with Michal here to not to backport it.

[1]https://lwn.net/Articles/478049/
[2] https://lore.kernel.org/all/20211228175904.3739751-1-minchan@kernel.org/

> Btw. I plan to have a look and review this but times are busy. Hopefully
> soon.
> 
> Thanks!
> 
