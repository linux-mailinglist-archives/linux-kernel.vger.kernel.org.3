Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9719C56B54E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiGHJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbiGHJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:22:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCFAE2C677;
        Fri,  8 Jul 2022 02:22:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E950BD6E;
        Fri,  8 Jul 2022 02:22:09 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AB173F66F;
        Fri,  8 Jul 2022 02:22:08 -0700 (PDT)
Message-ID: <e55094af-557e-8044-fc14-00189bd392a2@foss.arm.com>
Date:   Fri, 8 Jul 2022 10:21:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 10/14] perf test: Add thread loop test shell scripts
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
 <20220701120804.3226396-11-carsten.haitzler@foss.arm.com>
 <a14e7015-7446-8cb3-612c-00dcb469c939@arm.com>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <a14e7015-7446-8cb3-612c-00dcb469c939@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/22 14:53, James Clark wrote:
> 
> 
> On 01/07/2022 13:07, carsten.haitzler@foss.arm.com wrote:
>> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>>
>> Add a script to drive the thread loop test that gathers data so
>> it passes a minimum bar (in this case do we get any perf context data
>> for every thread).
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Hi Carsten,
> 
> I checked this on N1SDP and I get failures in both threads tests. This is
> because it's looking for "CID=..." when in my output threads are shown as
> "VMID=...":
> 
>      Idx:628048; ID:10;	I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000AAAAE3BF0B18; Ctxt: AArch64,EL0, NS; VMID=0xa588c;
> 
> I think with a change to the grep it should work.

Errrr... I get no VMID= ... it's all

Idx:563008; ID:12;	I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 
bit, IS0.; Addr=0x0000AAAAE4B00A60; Ctxt: AArch64,EL0, NS; CID=0x00004aff;

are you using containers or something? because:

             if(context.updated_c)
             {
                 oss << "CID=0x" << std::hex << std::setfill('0') << 
std::setw(8) << context.ctxtID << "; ";
             }
             if(context.updated_v)
             {
                 oss << "VMID=0x" << std::hex << std::setfill('0') << 
std::setw(4) << context.VMID << "; ";
             }

I'm running without any containers etc. - bare metal. Haven't bothered 
with any VM stuff.

In OpenOCD the CID should be the the pid/thread id. It seems to not be 
the same thing as VMID. I haven't traced this beyond here as to exactly 
what this represents though my first reaction is "This is extra VM info 
and not the PID/TID being looked for". OpenOCD is full of tests with log 
dumps that produce CID and VMID:

Idx:1676; ID:10;        I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 
64 bit, IS0.; Addr=0xFFFFFFC000096A00; Ctxt: AArch64,EL1, NS; 
CID=0x00000000; VMID=0x0000;

A quick git grep CID= in OpenCD will show them all. My understanding is 
CID is the thread/process ID and thus the test/check "Do we get reported 
data from all threads? - anything?".

I don't think using VMID is right. The fact you are missing a CID is an 
issue though...

> Thanks
> James
> 
>> ---
>>   .../coresight/thread_loop_check_tid_10.sh     | 19 +++++++++++++++++++
>>   .../coresight/thread_loop_check_tid_2.sh      | 19 +++++++++++++++++++
>>   2 files changed, 38 insertions(+)
>>   create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
>>   create mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
>>
>> diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
>> new file mode 100755
>> index 000000000000..7c13636fc778
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/sh -e
>> +# CoreSight / Thread Loop 10 Threads - Check TID
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="thread_loop"
>> +. $(dirname $0)/../lib/coresight.sh
>> +ARGS="10 1"
>> +DATV="check-tid-10th"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +STDO="$DATD/perf-$TEST-$DATV.stdout"
>> +
>> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
>> +
>> +perf_dump_aux_tid_verify "$DATA" "$STDO"
>> +
>> +err=$?
>> +exit $err
>> diff --git a/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
>> new file mode 100755
>> index 000000000000..a067145af43c
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
>> @@ -0,0 +1,19 @@
>> +#!/bin/sh -e
>> +# CoreSight / Thread Loop 2 Threads - Check TID
>> +
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +TEST="thread_loop"
>> +. $(dirname $0)/../lib/coresight.sh
>> +ARGS="2 20"
>> +DATV="check-tid-2th"
>> +DATA="$DATD/perf-$TEST-$DATV.data"
>> +STDO="$DATD/perf-$TEST-$DATV.stdout"
>> +
>> +SHOW_TID=1 perf record -s $PERFRECOPT -o "$DATA" "$BIN" $ARGS > $STDO
>> +
>> +perf_dump_aux_tid_verify "$DATA" "$STDO"
>> +
>> +err=$?
>> +exit $err
