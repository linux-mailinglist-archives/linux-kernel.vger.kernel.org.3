Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51E44BE824
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354882AbiBUKdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:33:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354809AbiBUKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:32:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782B6D1AB;
        Mon, 21 Feb 2022 01:53:15 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L8bgMm007312;
        Mon, 21 Feb 2022 09:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Husi8wtRKofd8szTIt2dJMfs1/XgcfBR5L2eNXWgu18=;
 b=DGZISxB+NeF5OICy1PbldWQxrg38gZDCRSmhAGygHhgQxd1WH1IVbIvakUSTNPefzKJe
 s6XLNE5tfu9NbJIV4Oe6o0AyBXm5cEgKv7yByNIJa8r23ptKUiwS1vOCErVDJTjkSUri
 0oc4zLE10fd+KdNbQnnCyGxdtqqh3eiWMFkPugJkIofkpGYLrh1KJJLyJsM1ZVDDQilh
 9Re7U986gj6tnTDZc3CIH3RGDbvpyP9t1DmyZrGjEP+K05D6xgT6D9NYOSIFdhC9YCaa
 kRE0c2vwzwmyt/iCDpPYLNTIeMs1Z8a47gcVU7x4s4UlGSTxeaY/Ryzg70cEH7ikuQY8 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ec73b9xns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 09:52:43 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21L95ijf022196;
        Mon, 21 Feb 2022 09:52:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ec73b9xn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 09:52:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L9gt00005389;
        Mon, 21 Feb 2022 09:52:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqthscn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 09:52:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L9g4co51904786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 09:42:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A18FA4040;
        Mon, 21 Feb 2022 09:52:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B31EA4057;
        Mon, 21 Feb 2022 09:52:34 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.47.34])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 09:52:33 +0000 (GMT)
Subject: Re: [PATCH v2] perf test: Skip Sigtrap test for arm+aarch64
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, elver@google.com, dvyukov@google.com,
        will@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, tmricht@linux.ibm.com, irogers@google.com
References: <1645176813-202756-1-git-send-email-john.garry@huawei.com>
 <20220218104611.GD56419@leoy-ThinkPad-X240s> <Yg+Xmt27POS2y2LI@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <447ebda7-eaff-f765-d6ec-66ad0fc957a0@linux.ibm.com>
Date:   Mon, 21 Feb 2022 15:22:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <Yg+Xmt27POS2y2LI@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ibLGMgGsf-sQWJrRFeaJVvLEIjmQN1JX
X-Proofpoint-ORIG-GUID: 928iv4aMq9dObk-QFqjwDZBoNkzfkhiu
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_03,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202210056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/22 6:26 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 18, 2022 at 06:46:11PM +0800, Leo Yan escreveu:
>> On Fri, Feb 18, 2022 at 05:33:33PM +0800, John Garry wrote:
>>> Skip the Sigtrap test for arm + arm64, same as was done for s390 in
>>> commit a840974e96fd ("perf test: Test 73 Sig_trap fails on s390"). For
>>> this, reuse BP_SIGNAL_IS_SUPPORTED - meaning that the arch can use BP to
>>> generate signals - instead of BP_ACCOUNT_IS_SUPPORTED, which is
>>> appropriate.
>>>
>>> As described by Will at [0], in the test we get stuck in a loop of handling
>>> the HW breakpoint exception and never making progress. GDB handles this
>>> by stepping over the faulting instruction, but with perf the kernel is
>>> expected to handle the step (which it doesn't for arm).
>>>
>>> Dmitry made an attempt to get this work, also mentioned in the same thread
>>> as [0], which was appreciated. But the best thing to do is skip the test
>>> for now.
>>>
>>> [0] https://lore.kernel.org/linux-perf-users/20220118124343.GC98966@leoy-ThinkPad-X240s/T/#m13b06c39d2a5100d340f009435df6f4d8ee57b5a
>>>
>>> Fixes: Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> I tested this patch on my Juno board:
>>
>> root@Juno:# ./perf test 73
>>  73: Sigtrap                                                         : Skip
>>
>> Tested-by: Leo Yan <leo.yan@linaro.org>

Sorry for late update.

Patch looks good to me. I tested it on powerpc.

Tested-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain
> 
> Thanks, applied.
> 
> - Arnaldo
> 
