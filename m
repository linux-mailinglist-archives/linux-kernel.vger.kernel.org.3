Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8EB4C020B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiBVTa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiBVTa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:30:26 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96D4522EF;
        Tue, 22 Feb 2022 11:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1645558200; x=1677094200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5kh9q0GW+wnQrt40nuaSNB7naZayQpuxWFvUGfnyRoc=;
  b=cXQzjesQHmSea9I77WtRTy54zV9thI8zPhTsomU/UwapoaErPKdhvphu
   8tHNAGfF201H2dQRIASEYN7qPWM//CsmnF4Y3wgJEbNi4EsbC0yqP6TDA
   VP9J/x5WPXUP25bTz5pSMi/ujbIsRQolP5rwR3ikSUYIy3eESoyaGJCqt
   8=;
X-IronPort-AV: E=Sophos;i="5.88,387,1635206400"; 
   d="scan'208";a="65281020"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 22 Feb 2022 19:29:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com (Postfix) with ESMTPS id E6F0714118C;
        Tue, 22 Feb 2022 19:29:50 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 22 Feb 2022 19:29:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Tue, 22 Feb 2022 19:29:49 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Tue, 22 Feb 2022 19:29:49
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 6E61F15C9; Tue, 22 Feb 2022 19:29:49 +0000 (UTC)
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
Date:   Tue, 22 Feb 2022 19:29:43 +0000
Message-ID: <20220222192943.20137-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
References: <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi German & Yan,

Sorry about the delay in responding.

>Hi German, Ali,
>
[...]
> >>>  };
>> >>>  
>> >>>  enum arm_spe_op_type {
>> >>>  	ARM_SPE_LD		= 1 << 0,
>> >>>  	ARM_SPE_ST		= 1 << 1,
>> >>> +	ARM_SPE_LDST_EXCL	= 1 << 2,
>> >>> +	ARM_SPE_LDST_ATOMIC	= 1 << 3,
>> >>> +	ARM_SPE_LDST_ACQREL	= 1 << 4,
>> 
>> Wondering if we can store this in perf_sample->flags. The values are
>> defined in "util/event.h" (PERF_IP_*). Maybe we can extend it to allow
>> doing "sample->flags = PERF_LDST_FLAG_LD | PERF_LDST_FLAG_ATOMIC" and
>> such.
>> 
>> @Leo do you think that could work?
>
>Let's step back a bit and divide the decoding flow into two parts:
>backend and frontend.
>
>For the backend part, we decode the SPE hardware trace data and
>generate the SPE record in the file
>util/arm-spe-decoder/arm-spe-decoder.c.  As we want to support
>complete operation types, we can extend arm_spe_op_type as below:
>
>enum arm_spe_op_type {
>        /* First level operation type */
>	ARM_SPE_OP_OTHER        = 1 << 0,
>	ARM_SPE_OP_LDST		= 1 << 1,
[...]

I'm OK with this approach, but perhaps instead the op type should
just be the raw traces op-type and op-type-payload? Macros to decode
this information are already present and extensively used in the text
decoding of the packet. While it's a little bit harder than just picking
a bit, the op_type is only used in a single place today outside of
the existing textual script decoding and what would be this decoding.
Do we forsee many more uses that would justify having to maintain
the immediate format vs finding a way to unify arm_spe_pkt_desc_op_type
to support both the text decoding and this?

[...]
>So I am just wandering if we can set the field
>sample::data_src::mem_lock for atomic operations, like:
>
>    data_src.mem_op   = PERF_MEM_OP_LOAD;
>    data_src.mem_lock = PERF_MEM_LOCK_ATOMIC;
>
>The field "mem_lock" is only two bits, we can consider to extend the
>structure with an extra filed "mem_lock_ext" if it cannot meet our
>requirement.

These are for the LOCK instruction on x86. I don't know that we want to
overload the meaning here. Minimally there is value in differentiating
exclusives vs atomics.

>
>> >>> +	ARM_SPE_BR		= 1 << 5,
>> >>> +	ARM_SPE_BR_COND		= 1 << 6,
>> >>> +	ARM_SPE_BR_IND		= 1 << 7,
>> 
>> Seems like we can store BR_COND in the existing "branch-miss" event
>> (--itrace=b) with:
>> 
>>   sample->flags = PERF_IP_FLAG_BRANCH;
>>   sample->flags |= PERF_IP_FLAG_CONDITIONAL;
>> and/or
>>   sample->flags |= PERF_IP_FLAG_INDIRECT;
>> 
>> PERF_IP_FLAG_INDIRECT doesn't exist yet but we can probably add it.
>
>Yes, for branch samples, this makes sense for me.

makes sense to me too.

Ali

