Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49D4AA4E4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378663AbiBEAHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:07:33 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:43332 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345660AbiBEAHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1644019652; x=1675555652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5wfmLOODIoBBqoFFpobkufQhEkHn9jh4Dhowg0sJqm0=;
  b=AquPyfv5SemvLZxMq+tUfRukrBPDhk4FEVoNt9sMcWI6X6uiHlvbQ8D4
   fiIiOuWjI3vLK/v+SjxOF9vLuyqQcFEAEFC+6KvkpF4V14a8v22dD4Tdx
   22Lv2cLNus7govz/rIcHJDOkzqHxmngJ2EjCIEjRJNpZGOLMPjcPhD+eJ
   8=;
X-IronPort-AV: E=Sophos;i="5.88,344,1635206400"; 
   d="scan'208";a="175745942"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 05 Feb 2022 00:07:29 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-22c2b493.us-west-2.amazon.com (Postfix) with ESMTPS id D986741560;
        Sat,  5 Feb 2022 00:07:24 +0000 (UTC)
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sat, 5 Feb 2022 00:07:23 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02UWC001.ant.amazon.com (10.43.162.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sat, 5 Feb 2022 00:07:23 +0000
Received: from dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com
 (10.200.138.153) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Sat, 5 Feb 2022 00:07:22 +0000
Received: by dev-dsk-alisaidi-i31e-9f3421fe.us-east-1.amazon.com (Postfix, from userid 5131138)
        id B438021B50; Sat,  5 Feb 2022 00:07:22 +0000 (UTC)
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
Date:   Sat, 5 Feb 2022 00:07:19 +0000
Message-ID: <20220205000719.19986-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.24.4.AMZN
In-Reply-To: <20220203091934.GA2013381@leoy-ThinkPad-X240s>
References: <20220203091934.GA2013381@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2/3/22, 3:20 AM, "Leo Yan" <leo.yan@linaro.org> wrote:
>[...]
>> >> >> +			data_src.mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>> >> >
>> >> >This one also adds PERF_MEM_LVL_HIT even though the check of "if (record->type & ARM_SPE_LLC_MISS)"
>> >> >hasn't happened yet. Maybe some comments would make it a bit clearer, but at the moment it's
>> >> >not obvious how the result is derived because there are some things that don't add up like
>> >> >ARM_SPE_LLC_MISS == PERF_MEM_LVL_HIT.
>> >> 
>> >> Assuming the above is correct, my reading of the existing code that creates the
>> >> c2c output is that when an access is marked as an LLC hit, that doesn't
>> >> necessarily mean that the data was present in the LLC. I don't see how it could
>> >> given that LLC_HIT + HITM means the line was dirty in another CPUs cache, and so
>> >> LLC_HIT + HITM seems to mean that it was a hit in the LLC snoop filter and
>> >> required a different core to provide the line. This and the above certainly
>> >> deserve a comment as to why the miss is being attributed in this way if it's
>> >> otherwise acceptable.
>> >
>> >As James pointed out, this might introduce confusion.  I am wanderding
>> >if we can extract two functions for synthesizing the data source, one is
>> >for Neoverse platform and another is for generic purpose (which
>> >without data source packets), below code is to demonstrate the basic
>> >idea.
>> 
>> The code below is cleaner, and I'm happy to rework the patches in this way, but
>> I think the question still remains about unifying behavior of the tool. If we
>> mark something with a data source of ARM_SPE_NV_PEER_CORE as at L1 hit + HITM
>> certainly c2c won't show the correct thing today, but i think it also hides the
>> intent. The line in question missed the L1, L2, and got to the LLC where we did
>> find a record that it was in another cores cache (L1 or L2). Looking at the way
>> that c2c works today, it seems like marking this as a hit in the LLC snoop
>> filter is the best way to unify behaviors among architectures?
>
>Thanks a lot for pointing out this.  I looked into the code and
>compared the memory trace data from x86, I found the HITM tag is always
>sticking to LLC from x86's memory events.  This would be the main reason
>why current code in perf is only support HITM for LLC.
>
>I don't think it's a good way to always mark LLC snoop, even it's a
>snooping operation in L1 or L2 cache on Arm64 platforms; this would
>introduce confusion for users when using Arm SPE for profiling.
>
>Alternatively, we can support HITM tag for L1/L2 cache levels in perf,
>this can allow us to match memory topology on Arm64 arch, and it should
>not introduce any regression on x86 arch.
>
>Could you confirm if below code can fix the issue or not?

Yes, that should do it. Want me to repsin this with the changes we discussed?

Ali

