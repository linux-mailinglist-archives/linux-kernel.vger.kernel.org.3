Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF275B1836
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiIHJSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIHJSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:18:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6DD292E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:18:36 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2889Bnnd028320;
        Thu, 8 Sep 2022 09:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8MsLN38a9tOwVpiqnlJSLrbz26fIt317nKdJHiaZFL4=;
 b=hJhFWLHPf2kAN+RUICErhQAp/GbG4n85lwhVfgTmLT+hs2iriW+PyEcbJLON3G7kLDwP
 S8Kh362PpqAE/vm8y2wxKfozkSMz6VxYtwmyiapYUYr+He+iTq6YwfX+S4fArdt89+w8
 T8CkQJEv/ulfJ1tz/EKd9Qvxe7Mm5mINXYKBZ+WgBlaJO/8h5RdoEjKJmC0qN3YnqmTy
 0ONlnDKQyCnqwqGNkV/ksQL1Bze2fLYQrIEyeIKYhb9g6+b6HZ626t1gayZJNnIg/FiX
 5ZfUDTDacRNMl6JUzN7RmSJjqDeW3E6PR/ubaq3HKMMMPNX1NDNT4KZpS+XAFnXgNSv9 HA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfaa5gf6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 09:18:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2889ITWI031126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 09:18:29 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 02:18:27 -0700
Message-ID: <f83f6106-ccc8-35d7-d275-acbc02b95d35@quicinc.com>
Date:   Thu, 8 Sep 2022 17:18:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm/page_owner.c: remove redudant drain_all_pages
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Joonsoo Kim <js1304@gmail.com>
References: <1662537673-9392-1-git-send-email-quic_zhenhuah@quicinc.com>
 <20220908084008.tmerssqksyrg3knl@techsingularity.net>
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20220908084008.tmerssqksyrg3knl@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RY-vTElUZQZIgxNzBwJgDWZR8QqLoH5g
X-Proofpoint-ORIG-GUID: RY-vTElUZQZIgxNzBwJgDWZR8QqLoH5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080033
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/8 16:40, Mel Gorman wrote:
> On Wed, Sep 07, 2022 at 04:01:13PM +0800, Zhenhua Huang wrote:
>> Page owner info of pages in pcp list have already been reset:
>> 	free_unref_page
>> 		-> free_unref_page_prepare
>> 			-> free_pcp_prepare
>> 				-> free_pages_prepare which do page owner
>> 				reset
>> 		-> free_unref_page_commit which add pages into pcp list
>> It can also be confirmed from dump that page owner info of pcp pages are
>> correct. Hence there is no more need to drain when reading.
>>
>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> 
> This is subtle because there is no comment explaining why drain_all_pages
> is called and git history does not help. I agree that the page owner
> information has already been reset and has been since the very beginning
> but I do not think that is *why* drain_all_pages is called here.

Thanks Mel, to be honest I've checked git history and also didn't find 
the author's purpose for this call.

> 
> After the drain_all_pages, there is a fairly standard PFN walker with this
> in it;
> 
>          /* Find an allocated page */
>          for (; pfn < max_pfn; pfn++) {
> 	....
>                  page = pfn_to_page(pfn);
>                  if (PageBuddy(page)) {
>                          unsigned long freepage_order = buddy_order_unsafe(page);
> 
>                          if (freepage_order < MAX_ORDER)
>                                  pfn += (1UL << freepage_order) - 1;
>                          continue;
>                  }	
> 	....
>          }
> 
> The PFN walker is trying to skip free pages efficiently and PCP pages
> are not buddy pages so the order is unknown. The order *can* be known but
> it's risky to try detecting it. I suspect the drain_all_pages is called
> to move PCP pages to the buddy list so they can identified as buddy pages
> and skipped and has nothing to do with resetting the page owner.
> 
> If that is correct then I think it is overkill to drain the PCP lists
> to marginally improve the efficiency of the PFN walker and the drain is
> subject to a race. Just because the PCP lists are drained does not mean
> a new PCP page will be added during the PFN walk. Furthermore, PCP pages
> get skipped because PAGE_EXT_OWNER_ALLOCATED is cleared so it's not about
> scan safety. The drain is a guaranteed expensive operation that is unlikely
> to be offset by a slight increase in efficiently of the PFN walker when
> skipping free pages so the drain_all_pages should be dropped. I believe
> the patch itself is correct but the changelog needs to be changed.
> 
> With a changelog stating that the patch is removing an expensive and
> unnecessary operation as PCP pages are safely skipped;

Sure.
I will stat your thoughts in changelog.

> 
> 	Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> But just in case -- Joonsoo, can you clarify why drain_all_pages was
> originally called?
> 

Thanks,
Zhenhua
