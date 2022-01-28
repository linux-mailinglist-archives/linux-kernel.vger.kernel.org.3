Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83EA4A027B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343731AbiA1VDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:03:08 -0500
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:39068 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiA1VDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643403786; x=1674939786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0elh7Uegmz6NB5gRLtcnKnV9reRQ0A3TuI1lW+jT4v4=;
  b=CKQCLyki8E1/onFeb3PMNGmLq20Qsd6k1Oyc6Bv2QuzV2qkm664UJJCF
   GtNKqEGVPIIun5+tozTvK11ealtg/MIHITLi7rOiT7SIc99gzYZcGCvYM
   VAeiXD76w8yP0+Dd57pJMXdPmpoIcoKL9Xu/hMAf2fScmXuT+EzT59+Mw
   8=;
X-IronPort-AV: E=Sophos;i="5.88,324,1635206400"; 
   d="scan'208";a="58828092"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 28 Jan 2022 21:02:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-5feb294a.us-west-2.amazon.com (Postfix) with ESMTPS id 2F5E19FCD2;
        Fri, 28 Jan 2022 21:02:53 +0000 (UTC)
Received: from EX13D02UWB001.ant.amazon.com (10.43.161.240) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 28 Jan 2022 21:02:52 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02UWB001.ant.amazon.com (10.43.161.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Fri, 28 Jan 2022 21:02:50 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Fri, 28 Jan 2022 21:02:49
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id A5DCC21BC4; Fri, 28 Jan 2022 21:02:49 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <german.gomez@arm.com>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <alisaidi@amazon.com>, <andrew.kilroy@arm.com>,
        <benh@kernel.crashing.org>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@redhat.com>, <leo.yan@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
Date:   Fri, 28 Jan 2022 21:02:45 +0000
Message-ID: <20220128210245.4628-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
References: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On 28/01/2022 19:20, German Gomez wrote:
>Hi Ali,
>
>On 25/01/2022 19:20, Ali Saidi wrote:
>> Decode more SPE events and op types to allow for processing by perf
>> scripts. For example looking for branches which may indicate candidates
>> for conversion to a CSEL, store exclusives that are candidates for
>> conversion to LSE atomics and record the source information for memory
>> ops.
>> [snip]
>> +				if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
>> +					if (payload & SPE_OP_PKT_AT)
>> +						decoder->record.op |= ARM_SPE_LDST_ATOMIC;
>
>In "utils/arm-spe.c" we check "if (record->op == ARM_SPE_LD)" so this
>ORing could break some of the generated samples.

Yep, you're correct. Interestingly I can only find one use of record->op using
equivalence instead of a logical and so perhaps it's best to fix this one use.

...
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> index 69b31084d6be..113e427afe99 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>> @@ -22,11 +22,18 @@ enum arm_spe_sample_type {
>>  	ARM_SPE_TLB_MISS	= 1 << 5,
>>  	ARM_SPE_BRANCH_MISS	= 1 << 6,
>>  	ARM_SPE_REMOTE_ACCESS	= 1 << 7,
>> +	ARM_SPE_BR_NOT_TAKEN	= 1 << 8,
>
>Can you rename it to ARM_SPE_BRANCH_NOT_TAKEN for consistency?

No problem

>
>>  };
>>  
>>  enum arm_spe_op_type {
>>  	ARM_SPE_LD		= 1 << 0,
>>  	ARM_SPE_ST		= 1 << 1,
>> +	ARM_SPE_LDST_EXCL	= 1 << 2,
>> +	ARM_SPE_LDST_ATOMIC	= 1 << 3,
>> +	ARM_SPE_LDST_ACQREL	= 1 << 4,
>> +	ARM_SPE_BR		= 1 << 5,
>> +	ARM_SPE_BR_COND		= 1 << 6,
>> +	ARM_SPE_BR_IND		= 1 << 7,
>
>I'm not sure if we should keep everything in one enum/bitmask. I'm also
>looking at adding more of the data from the packets to the record, and
>considering refactoring the record structure. I'll share here when I
>have something.

One straight forward way to do this would be to make it a u16 field that was 
SPE operation-type header and operation-type payload with some accessors instead
of trying to re-encode the operation type into a new format.

Thanks,
Ali

