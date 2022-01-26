Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C149CF0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiAZP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:58:28 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54999 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiAZP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643212706; x=1674748706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ErYDq09UFT0S4fAZwr7R81XHAZgdbQsfSFczNPNGrlA=;
  b=fILmKinJwKWmbt3xacuw5/do64O53ptqNGM9mwNxL67IVlJd+Ut7zJXE
   61n/CCFSk417CabLiBfriuuW/c8J86/5f6I9wdg2Rr39V5hBv/a9r6uBS
   UdhZDJUpxpPJXqtEs9Dazpood2HlTHOpVat+f8zfvAi7Jm+etZRQI/ncg
   o=;
X-IronPort-AV: E=Sophos;i="5.88,318,1635206400"; 
   d="scan'208";a="190079288"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 26 Jan 2022 15:58:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com (Postfix) with ESMTPS id 1764541AE9;
        Wed, 26 Jan 2022 15:58:25 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Wed, 26 Jan 2022 15:58:24 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Wed, 26 Jan 2022 15:58:24 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Wed, 26 Jan 2022 15:58:23
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id D074721B6E; Wed, 26 Jan 2022 15:58:23 +0000 (UTC)
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
Subject: Re: [PATCH 1/2] perf arm-spe: Add arm_spe_record to synthesized
Date:   Wed, 26 Jan 2022 15:58:20 +0000
Message-ID: <20220126155820.21929-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <5ca990a5-eedd-0edb-26d3-b5e16c36ac34@arm.com>
References: <5ca990a5-eedd-0edb-26d3-b5e16c36ac34@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,
>Hi Ali,
>
>On 25/01/2022 19:20, Ali Saidi wrote:
>> Providing the arm_spe_record as raw data to the synthesized SPE samples
>> allows perf scripts to read and separately process the data in ways
>> existing perf tools don't support and mirrors functionality available
>> for PEBS.
>> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
>> ---
>>  tools/perf/util/arm-spe.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index d2b64e3f588b..a7499cde6fc0 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -336,6 +336,8 @@ static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
>>  	sample.phys_addr = record->phys_addr;
>>  	sample.data_src = data_src;
>>  	sample.weight = record->latency;
>> +	sample.raw_size = sizeof(*record);
>> +	sample.raw_data = record;
>
>Have you tried this with perf-inject? I think it would need the PERF_SAMPLE_RAW bit in the sample_type,

Yes I've tried the following and it worked as expected with the original
perf.data or the perf.data.jitted after perf-inject. 

perf record -e arm_spe_0/jitter=1/ -k 1 java ...
perf  inject -f --jit -i perf.data -o perf.data.jitted
perf script -i perf.data -s t1.py --itrace=i1i

>
>Although I quickly looked over the perf inject code and it looks like it's expecting some type of padding:
>
>  // synthetic-events.c
>  if (type & PERF_SAMPLE_RAW) {
>    result += sizeof(u32);
>    result += sample->raw_size;
>  }
>
>I'm seeing some comments in utils/event.h related to this on the intel events.

Yes i noticed this too,but looking at how the raw data is added to the same
other places like intel-pt.c:1703 the perf_synth__raw*() functions are used to
strip away the 4 bytes bytes before the data is added to the sample. The other
places i can find the padding used is in builtin-script.c but given we have the
--dump-raw-trace option it's not clear to me that it's needed to wrap the
arm_spe_event in another struct with padding like perf_synth_intel_ptwrite?

Thanks,
Ali

