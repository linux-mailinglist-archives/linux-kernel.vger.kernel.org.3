Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4457FB7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiGYIjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiGYIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:39:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265741402F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:39:41 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P6QZlC024221;
        Mon, 25 Jul 2022 08:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ha/FcfhXmfYLW2Mh9nF+ML5JwMWzZWSHcaHYy6WmG4c=;
 b=lT6utZtmPVfHYxwm6c0N1IuX0y/RLulVmYjCKxqAoVxeW8X/pZMASo7vvQbahMBodoNn
 7zsDDv4hl7D2C5wDsw9D+o4Freg9Amwz/utG+D+tQ0QMw3p7ytBAhNvVK2aVmooJvDNJ
 VPH8DDMEAzbFDz+pWEkSU9N+i8U2bx8GqN7VCNv583GKt1SW8at9CifWHBVBftdRvoYR
 FkQbQmdShFKMvnm50GLKdBfWEWdYvP6l1LdnKBXEIilAY4x+eIMDSOkpgQWKtyGZW1pR
 SFQwrs/5/A3fWrQD6JDRnWBNL9Dq0r6qfkIFuyjaRX0OCK2QtprhDfowcx62ev3Au/Hn Zw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hg8arufpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 08:39:19 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 26P8dIoZ007828
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 08:39:18 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Jul 2022 01:39:18 -0700
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Jul
 2022 01:39:15 -0700
Message-ID: <e518246c-4ffa-14af-e568-798572f75bee@quicinc.com>
Date:   Mon, 25 Jul 2022 16:39:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] mm/page_owner.c: allow page_owner with given
 start_pfn/count
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <iamjoonsoo.kim@lge.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <quic_guptap@quicinc.com>
References: <20220722150810.27740-1-quic_yingangl@quicinc.com>
 <YtrEXB6o+VROImdg@casper.infradead.org>
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <YtrEXB6o+VROImdg@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fqIVd8Ppqw6e7At0-Oq0IhpYe2o0Qn9n
X-Proofpoint-GUID: fqIVd8Ppqw6e7At0-Oq0IhpYe2o0Qn9n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=590 mlxscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250036
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Matthew:
	sorry for the delay, I just started to learn how to upstream patch, and 
setup my Thunderbird with plain text only.
	you are right, two users will cause problem here.
	the uses case is dump CMA area to understand the page usage in a given 
cma pool. 2nd, dump whole memory page owner is very time cost, mostly 
our android device has 8G memory now.
	I will research and check again, if you have more idea on this , please 
kindly to share.

BR
Kassey

On 7/22/2022 11:38 PM, Matthew Wilcox wrote:
> On Fri, Jul 22, 2022 at 11:08:10PM +0800, Kassey Li wrote:
>> by default, page_owner iterates all page from min_low_pfn to
>> max_pfn, this cost too much time if we want an alternative pfn range.
>>
>> with this patch it allows user to set pfn range to dump the page_onwer.
> 
> This is a really bad UI.  If two users try to do different ranges at the
> same time, it'll go wrong.  What use cases are you actually trying to
> solve?
