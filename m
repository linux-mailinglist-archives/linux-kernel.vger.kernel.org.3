Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B061513816
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349043AbiD1PVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349129AbiD1PVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:21:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB84B7151;
        Thu, 28 Apr 2022 08:17:34 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SFFtY0025437;
        Thu, 28 Apr 2022 15:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Q+rV3z8C5E6PlcUoo4fQ3zmgPF5V/RMCDgir8bBJ3Zc=;
 b=ZBsJB++JnSyV5DBadlLlSyGl168mG2kYIYEuS8+fRPf9bPZskTDRlvZqR8aMec8g55/8
 SV/gI0wYhMg4ITVXpPnx7m+MIQRsoifawzWtegGbfZ1Ct/wCEQ2ivCXL4S893CcZXBPK
 BOKE9EBlX9sMp04Mn8ESUTXb6ysrIEn4qqcbtqH3M1loUrwrgJZu/pHl0+ygqmHZfPeN
 m7KQsFYG9p9ZFKM4wurkC2N46mgcZZ4eaXJWQn42fjteWJMxH4oBO3qenQXBfGFGQmr0
 jbrk5xFeDJM1jtpPVwcc2eWaujA/5UbRbrF6ZDELCCK4PISACFX7byc0RMY7xA/EtcZ8 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtqv4nrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 15:17:23 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23SFFvNh025729;
        Thu, 28 Apr 2022 15:17:22 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtqv4nr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 15:17:22 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23SFCxLJ023075;
        Thu, 28 Apr 2022 15:17:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3fm938x46u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 15:17:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23SFHS1022872346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:17:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5947711C04A;
        Thu, 28 Apr 2022 15:17:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F226E11C050;
        Thu, 28 Apr 2022 15:17:16 +0000 (GMT)
Received: from [9.145.182.141] (unknown [9.145.182.141])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 15:17:16 +0000 (GMT)
Message-ID: <4eb9f64c-aabd-8461-27a4-05b2e808e1f0@linux.ibm.com>
Date:   Thu, 28 Apr 2022 17:17:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] perf test: Fix test case 81 on s390x
Content-Language: en-US
To:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        irogers@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
References: <20220428122821.3652015-1-tmricht@linux.ibm.com>
 <768de4e7-7bf1-62b5-4446-28420c3a82d5@arm.com>
From:   Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <768de4e7-7bf1-62b5-4446-28420c3a82d5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QDqfq5GFwbNK7EvMlZwoZome8oN-hco_
X-Proofpoint-ORIG-GUID: 9uEBVlsUS2ynLlyjHEnnq59iJVHsqyzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 15:43, German Gomez wrote:
> 
> On 28/04/2022 13:28, Thomas Richter wrote:
>> perf test -F 81 -v fails on s390x on the linux-next branch.
>> The test case is x86 specific can not be executed on s390x.
>> The test case depends on x86 register names such as
>>
>>   ... | egrep -q 'available registers: AX BX CX DX ....'
>>
>> Skip this test case on s390x.
>>
>> Output before:
>>  # perf test -F 81
>>  81: perf record tests                       : FAILED!
>>  #
>>
>> Output after:
>>  # perf test -F 81
>>  81: perf record tests                       : Skip
>>  #
>>
>> Fixes: 24f378e66021 ("perf test: Add basic perf record tests")
>> Cc: Ian Rogers <irogers@google.com>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> ---
>>  tools/perf/tests/shell/record.sh | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index cd1cf14259b8..d98f4d4a00e1 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -37,6 +37,8 @@ test_register_capture() {
>>    echo "Register capture test [Success]"
>>  }
>>  
>> +# Test for platform support and return TEST_SKIP
>> +[ $(uname -m) = s390x ] && exit 2
>>  test_per_thread
> 
> The "test_per_thread" might still be valid though, right?
> 

Right,
this issue is the perf record -e instructions:u event
which is not supported on all machine types and configurations
we have in our test suite.

Because of the 'set -e' at the beginning, the first perf
command fails and the shell exits with error code.

Since s390x does not support x86 register names anyway, it is easier
to just omit this test case on s390x. At least I thought so.

The alternative would be to add some more tests to check s390x
machine supports instructions:u event and then just to bail
out on the register_capture test function.

Maybe this helps.

> In my case, the register test skips gracefully (arm64).
> 
> $ ./perf test 82 -v
>  82: perf record tests                                               :
> --- start ---
> test child forked, pid 54345
> Basic --per-thread mode test
> Basic --per-thread mode test [Success]
> Register capture test
> Register capture test [Skipped missing instruction]
> test child finished with 0
> ---- end ----
> perf record tests: Ok
> 
>>  test_register_capture
>>  exit $err


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
