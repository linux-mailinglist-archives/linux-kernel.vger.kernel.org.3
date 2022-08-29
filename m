Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C5C5A4770
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiH2KpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiH2KpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:45:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2FDB7E4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:44:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T9eZUC007820;
        Mon, 29 Aug 2022 10:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QqnU85WQAU5nBie0nkaeNbLSIcZajjHqTcDzluokVFE=;
 b=U3fTUE5Ub/CaYHZzI6CnY7lBzy+Yq+H9Ivg4aGC9bTlO01T4wwuA6xWjNu3bP5tm7XNd
 YmQiGGjsoM1z0IXMMp8Qsq3Y7i+GBkkG9SVChptkHlSdEISJWIDiFpOIKW+OP3CflxKj
 tInH2qmCY0M8/gZnER11/6sCI7MmDJGYms/WtCW9nJ9PVIcg3107pUxx3M6f0Z2oq7f7
 Gl0iHwF8jVOTo1T1x0ObQuKMSjMLRHjPiw4BlXrwfuPL9TlmRLhbPBRl/1J9vmg2XkbY
 rPzPvawJloq/FUa+Gz03PVI+hF8595If2sJblWErWIkVPeg5zKW4Zq1mhBt5bDrlkego 4A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7bg8vbu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 10:44:34 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27TAUY6p001898;
        Mon, 29 Aug 2022 10:44:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3j7cbm6xtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 10:44:33 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27TAiXhQ018147;
        Mon, 29 Aug 2022 10:44:33 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 27TAiX0a018145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 10:44:33 +0000
Received: from [10.214.20.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 29 Aug
 2022 03:44:28 -0700
Message-ID: <a36ed9a5-7d5b-f8bd-ee07-2b9009188db9@quicinc.com>
Date:   Mon, 29 Aug 2022 16:14:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V5] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <pasha.tatashin@soleen.com>, <shakeelb@google.com>,
        <sieberf@amazon.com>, <sjpark@amazon.de>,
        <william.kucharski@oracle.com>, <willy@infradead.org>,
        <quic_pkondeti@quicinc.com>, <minchan@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1661496993-11473-1-git-send-email-quic_charante@quicinc.com>
 <20220826201941.de6ed957a0d6547b2d501c19@linux-foundation.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20220826201941.de6ed957a0d6547b2d501c19@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tOf7tybzL_PVTnXzjYC-APkcIl4poadD
X-Proofpoint-ORIG-GUID: tOf7tybzL_PVTnXzjYC-APkcIl4poadD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=440 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290053
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 8/27/2022 8:49 AM, Andrew Morton wrote:
> On Fri, 26 Aug 2022 12:26:33 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> 
>> The below is one path where race between page_ext and  offline of the
>> respective memory blocks will cause use-after-free on the access of
>> page_ext structure.
> 
> What are people's thoughts on a -stable backport?  It looks like the
> bug has been there for years and the means of hitting it are obscure
> and the patch isn't minor, so I'm thinking no?

Michal also said no to back port and I also agree with.

https://lore.kernel.org/all/YvNc8vuinnddc78j@dhcp22.suse.cz/#t
https://lore.kernel.org/all/3aab7518-ff57-abdb-8bab-ea581197a07e@quicinc.com/


Thanks,
Charan


> 
