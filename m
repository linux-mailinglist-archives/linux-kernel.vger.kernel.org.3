Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D660249A33B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2366181AbiAXXw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:52:28 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:8116 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1840615AbiAXWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643064894; x=1674600894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tCQU+m5DYoHuerB1mz/UMZFKa6gGl9Rfb7pcDwFKfco=;
  b=Xtzq4h8cl4HVBhJokEwve7jCp06LmsIAgX5CXpFnnqOwbgPf6BYeON4d
   2/twaKpXfjFNvvHFAIg0xnfu3VX6aiI74DNA1yQZuOkp8xpINYyb+QxuH
   UO5fV6rjcQlosFgX55TCZlwv1lIICOZicERhoF70XDLjQabJ8YVLqHqXa
   U=;
X-IronPort-AV: E=Sophos;i="5.88,313,1635206400"; 
   d="scan'208";a="172800001"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1box-d-74e80b3c.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 24 Jan 2022 22:54:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1box-d-74e80b3c.us-east-1.amazon.com (Postfix) with ESMTPS id 643298728F;
        Mon, 24 Jan 2022 22:54:11 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 22:54:10 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 24 Jan 2022 22:54:10 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Mon, 24 Jan 2022 22:54:09
 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id B167A21B28; Mon, 24 Jan 2022 22:54:09 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <james.clark@arm.com>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <alisaidi@amazon.com>, <andrew.kilroy@arm.com>,
        <benh@kernel.crashing.org>, <german.gomez@arm.com>,
        <john.garry@huawei.com>, <jolsa@redhat.com>, <leo.yan@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH] perf arm-spe: Use SPE data source for neoverse cores
Date:   Mon, 24 Jan 2022 22:53:33 +0000
Message-ID: <20220124225333.19864-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <0ba26f30-6978-36ad-f7d0-7b8465648e54@arm.com>
References: <0ba26f30-6978-36ad-f7d0-7b8465648e54@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22, 11:24 AM, "James Clark" <james.clark@arm.com> wrote:
>On 21/01/2022 18:24, Ali Saidi wrote:
>> When synthesizing data from SPE, augment the type with source information
>> for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
>> the same encoding. I can't find encoding information for any other SPE
>> implementations to unify their choices with Arm's thus that is left for future
>> work.
>> 
>> This changes enables the expected behavior of perf c2c on a system with SPE where
>> lines that are shared among multiple cores show up in perf c2c output. 
>> 
>> Signed-off-by: Ali Saidi <alisaidi@amazon.com> 
>> ---
>>  .../util/arm-spe-decoder/arm-spe-decoder.c    |  1 +
>>  .../util/arm-spe-decoder/arm-spe-decoder.h    | 12 +++++
>>  tools/perf/util/arm-spe.c                     | 48 ++++++++++++++-----
>>  3 files changed, 49 insertions(+), 12 deletions(-)
>> 
>[...]
>> +static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
>>  {
>>  	union perf_mem_data_src	data_src = { 0 };
>> +	bool is_neoverse = is_midr_in_range(midr, neoverse_spe);
>>  
>>  	if (record->op == ARM_SPE_LD)
>>  		data_src.mem_op = PERF_MEM_OP_LOAD;
>> @@ -409,19 +418,30 @@ static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
>>  		data_src.mem_op = PERF_MEM_OP_STORE;
>>  
>>  	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
>> -		data_src.mem_lvl = PERF_MEM_LVL_L3;
>> +		if (is_neoverse && record->source == ARM_SPE_NV_DRAM) {
>> +			data_src.mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
>> +		} else if (is_neoverse && record->source == ARM_SPE_NV_PEER_CLSTR) {
>> +			data_src.mem_snoop = PERF_MEM_SNOOP_HITM;
>
>I'm not following how LLC_ACCESS | LLC_MISS ends up as HITM in this case (ARM_SPE_NV_PEER_CLSTR)?
>I thought there was no way to determine a HITM from SPE. Wouldn't one of the other values
>like PERF_MEM_SNOOP_MISS be more accurate?

Thanks for taking a look James.

I'd really like someone familiar with perf c2c output to also end up getting
similar output when running on an Arm system with SPE. There are obviously large
micro-architectural differences that have been abstracted away by the data_src
abstraction but fundamentally my understanding of x86 HITM is that the line
was found in the snoop filter of the LLC as being owned by another core and
therefore the request needs to go to another core to get the line.  I'm not
100% sure if on x86 it's really guaranteed to be dirty or not and it's not
always going to be dirty in a Neoverse system, but since the SPE source
indicates it was sourced from another core it is a core-2-core transfer of a
line which is currently owned by another cpu core and that is the interesting
data point that would be used to drive optimization and elimination of frequent
core-2-core transfers (true or false sharing).

>> +			data_src.mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>
>This one also adds PERF_MEM_LVL_HIT even though the check of "if (record->type & ARM_SPE_LLC_MISS)"
>hasn't happened yet. Maybe some comments would make it a bit clearer, but at the moment it's
>not obvious how the result is derived because there are some things that don't add up like
>ARM_SPE_LLC_MISS == PERF_MEM_LVL_HIT.

Assuming the above is correct, my reading of the existing code that creates the
c2c output is that when an access is marked as an LLC hit, that doesn't
necessarily mean that the data was present in the LLC. I don't see how it could
given that LLC_HIT + HITM means the line was dirty in another CPUs cache, and so
LLC_HIT + HITM seems to mean that it was a hit in the LLC snoop filter and
required a different core to provide the line. This and the above certainly
deserve a comment as to why the miss is being attributed in this way if it's
otherwise acceptable.

Thanks,
Ali

