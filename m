Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1115598557
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245101AbiHROIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbiHROIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:08:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167CDB958B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:07:58 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IAWwak023044;
        Thu, 18 Aug 2022 14:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1g/BkFyX8It6eFh6KePQfu0ZOeCiGrJHX0cQQC2SOyk=;
 b=TTsBMXiw56AD9S0aHodHRMIzGde785Ie46GovzTCoDf9DsSzq2WZBFSdCcuieyo8WqNY
 rNlDkeEPwg4PjwAYJrivfxLW+Lrk1WRAlR6wwUScLSsnTyBMjWs5i1elm/MKBBZZUtzt
 MMt0n7FpJY59Z4xIjfJt9RUicaWRJMRoowXlfWSJqgUupx+6kDws2J4ss60o6jth+bvX
 111v6gpYh9oS6ge73Kh2j10cERRTBrjWP0PQFoY5o3KgyTUgMl0T0Gn4QXc8KeS4Itjc
 h0hcD65VD1e8jAQyAGICYDSIXp44RuUfWK04FJy4uLu29l7zlvWE7FrEnv2czO26vdsz RA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1hhp1b4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:01:15 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27IE1FYK021171;
        Thu, 18 Aug 2022 14:01:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3hywar3xk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:01:15 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27IE1EfS021164;
        Thu, 18 Aug 2022 14:01:14 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 27IE1EYP021162
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 14:01:14 +0000
Received: from [10.214.20.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 07:01:10 -0700
Message-ID: <be4bb3d5-2658-752b-826c-f2dc1359e92d@quicinc.com>
Date:   Thu, 18 Aug 2022 19:31:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <pasha.tatashin@soleen.com>, <sieberf@amazon.com>,
        <shakeelb@google.com>, <sjpark@amazon.de>, <dhowells@redhat.com>,
        <willy@infradead.org>, <quic_pkondeti@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <Yvpg6odyDsXrjw5i@dhcp22.suse.cz>
 <286e47e7-3d63-133c-aa6c-05100b557d42@quicinc.com>
 <YvvCpW0ep9N8CbDr@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YvvCpW0ep9N8CbDr@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xZS7wHPDsPq84jrGmyNyKiHEySmNd5Xy
X-Proofpoint-ORIG-GUID: xZS7wHPDsPq84jrGmyNyKiHEySmNd5Xy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=262 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 8/16/2022 9:45 PM, Michal Hocko wrote:
>>>> @@ -183,19 +184,26 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>>>>  noinline void __set_page_owner(struct page *page, unsigned short order,
>>>>  					gfp_t gfp_mask)
>>>>  {
>>>> -	struct page_ext *page_ext = lookup_page_ext(page);
>>>> +	struct page_ext *page_ext = page_ext_get(page);
>>>>  	depot_stack_handle_t handle;
>>>>  
>>>>  	if (unlikely(!page_ext))
>>>>  		return;
>>> Either add a comment like this
>>> 	/* save_stack can sleep in general so we have to page_ext_put */
>>
>> Vlastimil suggested to go for save stack first since !page_ext is mostly
>> unlikely.  Snip from his comments:
>> Why not simply do the save_stack() first and then page_ext_get() just
>> once? It should be really rare that it's NULL, so I don't think we save
>> much by avoiding an unnecessary save_stack(), while the overhead of
>> doing two get/put instead of one will affect every call.
> right see below
>> https://lore.kernel.org/all/f5fd4942-b03e-1d1c-213b-9cd5283ced91@suse.cz/
>>>> +	page_ext_put();
>>>>  
>>>>  	handle = save_stack(gfp_mask);
>>> or just drop the initial page_ext_get altogether. This function is
>>> called only when page_ext is supposed to be initialized and !page_ext
>>> case above should be very unlikely. Or is there any reason to keep this?
I don't think that !page_ext check is really required as
__set_page_owner() is called means page_ext should have been
initialized.  Will raise a separate change for this suggestion. For now
V4 is raised with the earlier suggestion of dropping the initial
page_ext.
https://lore.kernel.org/all/1660830600-9068-1-git-send-email-quic_charante@quicinc.com/.

Thanks,
Charan
