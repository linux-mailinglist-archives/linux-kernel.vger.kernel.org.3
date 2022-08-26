Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B895A2252
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiHZHxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242447AbiHZHwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:52:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90ED3E7B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:52:53 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q4fDYu010624;
        Fri, 26 Aug 2022 07:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2r67fnxG1d/G01C83dTecSDL8ltCIpH6BkdTqoYwbJs=;
 b=cQvtsIA4Z+pR1JhNaIVjqMZ9CvYi6PI/RqHBHUNOWnVF0lIgIi3xVI8osFW2RTWf6IuK
 mO+ixTtS8adeoYT1zKe+TkFKODEruDvPXVGo6pp5KqveDsMdfWwM/J/+X5V6SnWup9IW
 WALlDaUhz6AX4unpjLZasIFuT8io0nDVuUNs/WGA4ia4Iw8gm8E+76wJYGuf2sUmR6sp
 tlMbN/U77VBWApA17ixwHAKVv9GTTWhqOiyu94OtU3vZBbt2kjAFn/jS6JBu/wQCu7Rp
 Ateoo+UcEA+wMNiDuOai5pZ/z84HOscgzyjPu3P2nzqkVsYUlbHeZ/JpflIlvpoeHj4i OA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j64h7mk50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 07:52:38 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q7qbv2024922;
        Fri, 26 Aug 2022 07:52:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3j6g9j1x72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 07:52:37 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27Q7qbJL024917;
        Fri, 26 Aug 2022 07:52:37 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 27Q7qawV024915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 07:52:37 +0000
Received: from [10.216.48.161] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 26 Aug
 2022 00:52:32 -0700
Message-ID: <fc952f08-f987-9e06-b52d-4a23d66f9d5d@quicinc.com>
Date:   Fri, 26 Aug 2022 13:22:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V4] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <mhocko@suse.com>, <vbabka@suse.cz>, <pasha.tatashin@soleen.com>,
        <shakeelb@google.com>, <sieberf@amazon.com>, <sjpark@amazon.de>,
        <william.kucharski@oracle.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <minchan@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1660830600-9068-1-git-send-email-quic_charante@quicinc.com>
 <01fd2b11-513d-eb91-5ce6-fcaa198f8d28@redhat.com>
 <113fd59f-e4c0-4ee1-4196-6c926677947c@quicinc.com>
In-Reply-To: <113fd59f-e4c0-4ee1-4196-6c926677947c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oyOIePZPgahvipBwNzl_jEUG7-iQUkKV
X-Proofpoint-GUID: oyOIePZPgahvipBwNzl_jEUG7-iQUkKV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=561
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260028
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 8/23/2022 10:35 PM, Charan Teja Kalla wrote:
>> I kind-of dislike the "loop" labels. Can we come up with a more
>> expressive name?
>>
>> "put_continue"
>>
>> or something?
>>
>>
>> One alternative would be to add to the beginning of the loop, and after
>> the loop sth like
>>
>> if (page_ext) {
>> 	page_ext_put(page_ext);
>> 	page_ext = NULL;
>> }
> I think, moving this to beginning of the loop looks cleaner than the
> goto statement.  Will spin V5.
> 
I have realized that goto looks simpler and cleaner... Raised V5 @
https://lore.kernel.org/all/1661496993-11473-1-git-send-email-quic_charante@quicinc.com/
> 
