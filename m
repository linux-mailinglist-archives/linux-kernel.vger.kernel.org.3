Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB55969BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiHQGrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHQGrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:47:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E015A83D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:47:32 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H1T9GX022177;
        Wed, 17 Aug 2022 06:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vOuxriRt907sajIb3LTQUHlA9Y/Omm5ol4lH6AscHAM=;
 b=EIkjUzUDs3C3y0YB1vhz2nyvLFl7SH7ZxqvuH1PdaFsyRjnl3NsW8+WnETaaHXS2YZzZ
 LJVXtNP92MJnwEjoY1Xxed0xQU/SA+VAKJAIEDshjvaYQQC57CrWa9JYE6HuXhMMBvgk
 YjjBG6rdM3b0TFwagmx6cYxutWPfdoteZrIzjaPBxx4oX7bxP8qeDXf4oe/IDroB3bYx
 MX6oRqGtvv0qSyfgCspev65CN0NwRSkvD3eOc4Kco87vmSe8fK03W87ty0h0+IGZ7BdG
 hqucSB/rr9IUcbQihN3QuGZXfu7OYSafuW4v5iZYi00ZOTEUJaTYUHQgMy5ZgNAmSdrU Vg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j058t51kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 06:47:28 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27H6lRIL000930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 06:47:27 GMT
Received: from [10.214.67.15] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 23:47:25 -0700
Message-ID: <1326361c-44c3-d2e0-c7a9-1e4b3e84ab6e@quicinc.com>
Date:   Wed, 17 Aug 2022 12:17:22 +0530
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
 <20220816173556.cb493d6a85edd65e1fa52911@linux-foundation.org>
From:   Pratyush Brahma <quic_pbrahma@quicinc.com>
In-Reply-To: <20220816173556.cb493d6a85edd65e1fa52911@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rC0XQY3xHC-GvHK-5eP0AyMRYmEVKN0w
X-Proofpoint-GUID: rC0XQY3xHC-GvHK-5eP0AyMRYmEVKN0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 clxscore=1011
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=730
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208170027
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17-08-2022 06:05, Andrew Morton wrote:
> On Tue, 16 Aug 2022 11:30:17 +0530 Pratyush Brahma <pbrahma@qti.qualcomm.com> wrote:
>
>> The process_mrelease() system call[1] is used to release the memory of
>> a dying process from the context of the caller, which is similar to and
>> uses the functions of the oom reaper logic. There exists trace logs for
>> a process when reaped by the oom reaper. Just extend the same to when
>> done by the process_mrelease() system call.
> Why?  Please describe in full detail the end-user value of this change.

This patch provides information on how much memory is freed from a process
which is being reaped. Adding trace events in the process_mrelease() path when
process is being reaped would enable more holistic debug as it happens in
oom_reap_task_mm() currently.

This extends the debug functionality for the events as described in [1] to
the process_mrelease() system call. Now the coverage of trace events is complete.

[1]
https://lore.kernel.org/all/20170530185231.GA13412@castle/T/#u

