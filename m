Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C204B50C475
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiDVW33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiDVW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:28:36 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7721A0B23;
        Fri, 22 Apr 2022 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1650662580; x=1682198580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pIf8XjvVOLM926gmhXXRBBK1J3Op2QCT6Rw8kAViYLM=;
  b=n7DOI4VDYzR+FeJr/AzEpv/QIIzjQ9Nn9PxTsWFlWxh11NG5JXfc/f8Q
   hKAhxt841hKGcu9DFnMfK7AZs5/cVzfTTmlQzQH/EYyyapUByYoCtzIQw
   lxKRo99HXJzd6IRJTO5dhYuXuzmPYyfJM+mnG5uIGiqLVcWPRNt56JF3q
   k=;
X-IronPort-AV: E=Sophos;i="5.90,282,1643673600"; 
   d="scan'208";a="195599088"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 22 Apr 2022 21:22:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b27d4a00.us-east-1.amazon.com (Postfix) with ESMTPS id 9E8C68129B;
        Fri, 22 Apr 2022 21:22:52 +0000 (UTC)
Received: from EX13D02UWB001.ant.amazon.com (10.43.161.240) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 22 Apr 2022 21:22:51 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D02UWB001.ant.amazon.com (10.43.161.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Fri, 22 Apr 2022 21:22:51 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Fri, 22 Apr 2022 21:22:52
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 8D417D86; Fri, 22 Apr 2022 21:22:50 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <kan.liang@linux.intel.com>
CC:     <Nick.Forrington@arm.com>, <acme@kernel.org>, <ak@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>, <alisaidi@amazon.com>,
        <andrew.kilroy@arm.com>, <benh@kernel.crashing.org>,
        <german.gomez@arm.com>, <james.clark@arm.com>,
        <john.garry@huawei.com>, <jolsa@kernel.org>, <kjain@linux.ibm.com>,
        <leo.yan@linaro.org>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>
Subject: Re: [PATCH v5 2/5] perf: Add SNOOP_PEER flag to perf mem data struct
Date:   Fri, 22 Apr 2022 21:22:49 +0000
Message-ID: <20220422212249.22463-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
References: <c17dedde-6ba8-db9b-4827-32477f039764@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Apr 2022 21:43:28, Kan Liang wrote:
> On 4/22/2022 2:49 PM, Ali Saidi wrote:
> > On Wed, 20 Apr 2022 18:43:28, Kan Liang wrote:
> >> On 4/8/2022 3:53 PM, Ali Saidi wrote:
> >>> Add a flag to the perf mem data struct to signal that a request caused a
> >>> cache-to-cache transfer of a line from a peer of the requestor and
> >>> wasn't sourced from a lower cache level.
> >>
> >> It sounds similar to the Forward state. Why can't the
> >> PERF_MEM_SNOOPX_FWD be reused?
> > 
> > Is there a definition of SNOOPX_FWD i can refer to? Happy to use this instead if
> > the semantics align between architectures.
> > 
> 
> + Andi
> 
> As my understanding, the SNOOPX_FWD means the Forward state, which is a 
> non-modified (clean) cache-to-cache copy.
> https://en.wikipedia.org/wiki/MESIF_protocol
  
In this case the semantics are different. We know the line was transferred from
another peer cache, but don't know if it was clean, dirty, or if the receiving core
now has exclusive ownership of it.

Thanks,

Ali
