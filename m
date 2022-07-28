Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE40583E95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiG1MVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiG1MVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:21:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB24F66C;
        Thu, 28 Jul 2022 05:20:54 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SC4vHr036486;
        Thu, 28 Jul 2022 12:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WVijLc4ArdkZsma21CtXXNHb8fdXCR6dlQKqcWyVG3g=;
 b=ObkoJaks+5xtVKmeGZq+UVyIPOBsEBSI9LG1vOpx3UjP3HZUwYL/cqIE54t9HqliI6MJ
 WoslFbR8jPT/T2ib63lD0hY1Jlz0Piqct808Xthq+dJMaNb+QXTJpsAktBoJ5uAOQB8Z
 T5v9CgmR89R7cLLGKigQjb5ciGhxZS4qOcGSLarEWepN+FF8t+7rmASoscDi+qNkXE6a
 LIeeQ8l77bHWjW7K5ypc1Uz1BoJIrj6xa5C16P+1yCkJc1ivl+YCUGyho9ak5/3/rly0
 arzb462PE+U7g0iwZgitnRrXgBe8zFvBy8TuawDeK/LO5UkJ/2qnpnL3/S8XextN8qqo gA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hkt580s9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 12:20:48 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SC5Qv8028733;
        Thu, 28 Jul 2022 12:20:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3hg946ec68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 12:20:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SCKgqi22217188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 12:20:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88183A4040;
        Thu, 28 Jul 2022 12:20:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12C01A4053;
        Thu, 28 Jul 2022 12:20:42 +0000 (GMT)
Received: from [9.171.24.202] (unknown [9.171.24.202])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 12:20:41 +0000 (GMT)
Message-ID: <550e7e9f-19cb-0b1f-fd3e-f0d958b4e75b@linux.ibm.com>
Date:   Thu, 28 Jul 2022 14:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] perf/tests: Fix test case 95 on s390 and use same event
Content-Language: en-US
To:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        james.clark@arm.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
References: <20220727141439.712582-1-tmricht@linux.ibm.com>
 <3dc28d5e-46ce-fd33-82c1-4e27b60dfef0@arm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <3dc28d5e-46ce-fd33-82c1-4e27b60dfef0@arm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: shjAoil5cPYXXtoXJ1zPaI33zVwiRZMo
X-Proofpoint-ORIG-GUID: shjAoil5cPYXXtoXJ1zPaI33zVwiRZMo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_05,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 11:25, German Gomez wrote:
> Thanks for the fix, Thomas
> 
> On 27/07/2022 15:14, Thomas Richter wrote:
>> On linux-next tree perf test 95 was added recently.
>> s390 does not support branch sampling at all and the test case fails
>> despite for checking branch support before hand.
>> The check for support of branching
>> uses the software event named dummy, as seen in the line:
>>
>>  perf record -b -o- -e dummy -B true > /dev/null 2>&1 || exit 2
> 
> Just curious, do you know why the command succeeds in this platform (and
> potentially others)?
> 
> I got the idea of using "dummy" from [1] but only tested on arm64 and
> x86. I thought the platforms would reject it if -b was not implemented
> regardless of the event. Did I misunderstand the use of dummy?
> 
> Thanks,
> German
> 
> [1] https://lore.kernel.org/all/20220617073840.GA45710@leoy-ThinkPad-X240s/
> 

Well, dummy is a predefined event of type software, you see that when you add
some -v options as in 
# perf record -e dummy -vvv
DEBUGINFOD_URLS=
Using CPUID IBM,3931,704,A01,3.7,002f
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 0
------------------------------------------------------------
perf_event_attr:
  type                             1      <----------- type 1 is software
  size                             128
  config                           0x9
  { sample_period, sample_freq }   4000


So this event is never sent to an hardware PMU (which would have type 0) and thus
mostly succeeds where as the perf record command without event uses default
event cycles. And that one is sent to hardware PMU on s390...

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
