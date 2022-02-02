Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E298A4A78F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbiBBTvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:51:25 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:43959 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347009AbiBBTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1643831484; x=1675367484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x2nmNDZD6IkVp0jOwhomnRl1oPO0h2jwPZA823Tx2Ow=;
  b=l+MvRb6Ve0Mtfr2SXyOc+MPpaUaTW2xw5aS25haXUMWtp7J7Dv3q2XDY
   0hDbl246dAjClAvO0X2wVUduiI5u6G0zrW/ShVyOHoVxd07J6xxdcjjc3
   KOQ2Jn4hpHkLVpbIktT8KvkbK/xNvK+47+4IkjtvVKq1ZndCs0hnm5bli
   A=;
X-IronPort-AV: E=Sophos;i="5.88,337,1635206400"; 
   d="scan'208";a="191792094"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 02 Feb 2022 19:51:23 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com (Postfix) with ESMTPS id D249241A9C;
        Wed,  2 Feb 2022 19:51:18 +0000 (UTC)
Received: from EX13D02UWB002.ant.amazon.com (10.43.161.160) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Wed, 2 Feb 2022 19:51:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWB002.ant.amazon.com (10.43.161.160) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Wed, 2 Feb 2022 19:51:17 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Wed, 2 Feb 2022 19:51:17 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 369B521BD7; Wed,  2 Feb 2022 19:51:17 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <leo.yan@linaro.org>
CC:     <Al.Grant@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <alisaidi@amazon.com>,
        <andrew.kilroy@arm.com>, <benh@kernel.crashing.org>,
        <german.gomez@arm.com>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH] perf arm-spe: Use SPE data source for neoverse cores
Date:   Wed, 2 Feb 2022 19:51:15 +0000
Message-ID: <20220202195115.12924-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <20220202150104.GB1939745@leoy-ThinkPad-X240s>
References: <20220202150104.GB1939745@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

>Hi Ali, James,
>
> [...]
>> 
>> I'd really like someone familiar with perf c2c output to also end up getting
>> similar output when running on an Arm system with SPE. There are obviously large
>> micro-architectural differences that have been abstracted away by the data_src
>> abstraction but fundamentally my understanding of x86 HITM is that the line
>> was found in the snoop filter of the LLC as being owned by another core and
>> therefore the request needs to go to another core to get the line.  I'm not
>> 100% sure if on x86 it's really guaranteed to be dirty or not and it's not
>> always going to be dirty in a Neoverse system, but since the SPE source
>> indicates it was sourced from another core it is a core-2-core transfer of a
>> line which is currently owned by another cpu core and that is the interesting
>> data point that would be used to drive optimization and elimination of frequent
>> core-2-core transfers (true or false sharing).
>
>Though I don't know the implementation for the hardware conherency
>protocols, here I have the same understanding with Ali.
>
>For x86 arch, it uses HITM to indicate the cache line is "modified"
>state; on Arm64 Neoverse platforms, there have two data source values
>can tell us if the cache line is "modified" state:
>ARM_SPE_NV_PEER_CLSTR and ARM_SPE_NV_PEER_CORE.  The snooping can
>happen either within the cluster or cross clusters.

Yes, although it depends on the system topology if there are clusters.

>> >> +			data_src.mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>> >
>> >This one also adds PERF_MEM_LVL_HIT even though the check of "if (record->type & ARM_SPE_LLC_MISS)"
>> >hasn't happened yet. Maybe some comments would make it a bit clearer, but at the moment it's
>> >not obvious how the result is derived because there are some things that don't add up like
>> >ARM_SPE_LLC_MISS == PERF_MEM_LVL_HIT.
>> 
>> Assuming the above is correct, my reading of the existing code that creates the
>> c2c output is that when an access is marked as an LLC hit, that doesn't
>> necessarily mean that the data was present in the LLC. I don't see how it could
>> given that LLC_HIT + HITM means the line was dirty in another CPUs cache, and so
>> LLC_HIT + HITM seems to mean that it was a hit in the LLC snoop filter and
>> required a different core to provide the line. This and the above certainly
>> deserve a comment as to why the miss is being attributed in this way if it's
>> otherwise acceptable.
>
>As James pointed out, this might introduce confusion.  I am wanderding
>if we can extract two functions for synthesizing the data source, one is
>for Neoverse platform and another is for generic purpose (which
>without data source packets), below code is to demonstrate the basic
>idea.

The code below is cleaner, and I'm happy to rework the patches in this way, but
I think the question still remains about unifying behavior of the tool. If we
mark something with a data source of ARM_SPE_NV_PEER_CORE as at L1 hit + HITM
certainly c2c won't show the correct thing today, but i think it also hides the
intent. The line in question missed the L1, L2, and got to the LLC where we did
find a record that it was in another cores cache (L1 or L2). Looking at the way
that c2c works today, it seems like marking this as a hit in the LLC snoop
filter is the best way to unify behaviors among architectures?

I'll send you a perf.data file OOB.

Thanks,
Ali

