Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035AE4E83A3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiCZTQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiCZTQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:16:50 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294F5C84D;
        Sat, 26 Mar 2022 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1648322113; x=1679858113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1qVgAAwGius5rPbM23I010ii9ouqb5CWP42FZkdIMuk=;
  b=EYocjRGcBS/rd+9P46PAS1/+tcr9poT3XCVtQA6qEwTxDyl9Yn4WwpS6
   DhiD3e8ybbdx4o50rB3Sm9jKa8Z197WNSWff2WgMkosuuscQlA6OGYC7d
   Q4XCTRdKJIROuUpXuIn18I5KhTrMjaQlc3AYRJGa+w2VKWQcm6m6DOMx+
   0=;
X-IronPort-AV: E=Sophos;i="5.90,213,1643673600"; 
   d="scan'208";a="189390323"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 26 Mar 2022 19:15:12 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-54a073b7.us-east-1.amazon.com (Postfix) with ESMTPS id AA33C9765A;
        Sat, 26 Mar 2022 19:15:06 +0000 (UTC)
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 26 Mar 2022 19:15:02 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D02UWC004.ant.amazon.com (10.43.162.236) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 26 Mar 2022 19:15:01 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Sat, 26 Mar 2022 19:15:01
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 1534917E0; Sat, 26 Mar 2022 19:15:00 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <leo.yan@linaro.org>
CC:     <Nick.Forrington@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <alisaidi@amazon.com>,
        <andrew.kilroy@arm.com>, <benh@kernel.crashing.org>,
        <german.gomez@arm.com>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@kernel.org>, <kjain@linux.ibm.com>,
        <lihuafei1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH v4 4/4] perf mem: Support HITM for when mem_lvl_num is any
Date:   Sat, 26 Mar 2022 19:14:54 +0000
Message-ID: <20220326191454.15084-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326062303.GC20556@leoy-ThinkPad-X240s>
References: <20220326062303.GC20556@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2022 22:23:03 +0000, Leo Yan wrote:
> On Thu, Mar 24, 2022 at 06:33:23PM +0000, Ali Saidi wrote:
> > For loads that hit in a the LLC snoop filter and are fulfilled from a
> > higher level cache on arm64 Neoverse cores, it's not usually clear what
> > the true level of the cache the data came from (i.e. a transfer from a
> > core could come from it's L1 or L2). Instead of making an assumption of
> > where the line came from, add support for incrementing HITM if the
> > source is CACHE_ANY.A
[snip]
> 
> This might break the memory profiling result for x86, see file
> arch/x86/events/intel/ds.c:
> 
>   97 void __init intel_pmu_pebs_data_source_skl(bool pmem)
>   98 {
>   99         u64 pmem_or_l4 = pmem ? LEVEL(PMEM) : LEVEL(L4);
>   ...
>  105         pebs_data_source[0x0d] = OP_LH | LEVEL(ANY_CACHE) | REM | P(SNOOP, HITM);
>  106 }
> 

Thanks for catching this Leo, I'll add your fix.

Ali
