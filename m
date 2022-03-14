Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5B4D8BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiCNSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiCNSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:38:40 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC74E3EA9E;
        Mon, 14 Mar 2022 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647283051; x=1678819051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GNEfO5t/KNUf2cvjnQzdxGPpMnXGCdat3iHHsYtvCuM=;
  b=XQ/BYTJNS8Age5OM/27aEZrLC/auI4Pa0hF8ZMXhQaxgnZyq3A6Tw9A8
   rM0ymeGXBPGSmq1GPEJsU0WmhmNtTC8JhHDcSvVwA7k1yBUSBFQnjc6bo
   PR+RJNxQJabRSkuYLVCqyU6GomLLKteQh4M7jzt3vWfZ+1mE4RLsT5Mad
   8=;
X-IronPort-AV: E=Sophos;i="5.90,181,1643673600"; 
   d="scan'208";a="70825562"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 14 Mar 2022 18:37:30 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com (Postfix) with ESMTPS id 3289241EAE;
        Mon, 14 Mar 2022 18:37:23 +0000 (UTC)
Received: from EX13D02UWC002.ant.amazon.com (10.43.162.6) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Mon, 14 Mar 2022 18:37:23 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D02UWC002.ant.amazon.com (10.43.162.6) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Mon, 14 Mar 2022 18:37:23 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Mon, 14 Mar 2022 18:37:22
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id BCEB7176D; Mon, 14 Mar 2022 18:37:22 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <german.gomez@arm.com>
CC:     <Nick.Forrington@arm.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <alisaidi@amazon.com>,
        <andrew.kilroy@arm.com>, <benh@kernel.crashing.org>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <kjain@linux.ibm.com>, <leo.yan@linaro.org>,
        <lihuafei1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>, <yao.jin@linux.intel.com>
Subject: Re: [PATCH v2 2/2] perf mem: Support HITM for when mem_lvl_num is used
Date:   Mon, 14 Mar 2022 18:37:21 +0000
Message-ID: <20220314183721.3198-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <df73fb93-3892-6713-8ebe-bc57a861ec5d@arm.com>
References: <df73fb93-3892-6713-8ebe-bc57a861ec5d@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German and Leo,

On   Mon, 14 Mar 2022 18:00:13 +0000, German Gomez wrote:
> Hi Leo, Ali
> 
> On 14/03/2022 06:33, Leo Yan wrote:
> > On Sun, Mar 13, 2022 at 07:19:33PM +0000, Ali Saidi wrote:
> >
> > [...]
> >
> >>>>> +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L4)) {
> >>>> According to a comment in the previous patch, using L4 is specific to Neoverse, right?
> >>>>
> >>>> Maybe we need to distinguish the Neoverse case from the generic one here as well
> >>>>
> >>>> if (is_neoverse)
> >>>> // treat L4 as llc
> >>>> else
> >>>> // treat L3 as llc
> >>> I personally think it's not good idea to distinguish platforms in the decoding code.
> >> I agree here. The more we talk about this, the more I'm wondering if we're
> >> spending too much code solving a problem that doesn't exist. I know of no
> >> Neoverse systems that actually have 4 cache levels, they all actually have three
> >> even though it's technically possible to have four.  I have some doubts anyone
> >> will actually build four levels of cache and perhaps the most prudent path here
> >> is to assume only three levels (and adjust the previous patch) until someone 
> >> actually produces a system with four levels instead of a lot of code that is
> >> never actually exercised?
> > I am not right person to say L4 cache is not implemented in Neoverse
> > platforms; my guess for a "System cache" data source might be L3 or
> > L4 and it is a implementation dependent.  Maybe German or Arm mates
> > could confirm for this.
> 
> I had a look at the TRMs for the N1[1], V1[2] and N2[3] Neoverse cores
> (specifically the LL_CACHE_RD pmu events). If we were to assign a number
> to the system cache (assuming all caches are implemented):
> 
> *For N1*, if L2 and L3 are implemented, system cache would follow at *L4*
To date no one has built 4 level though. Everyone has only built three.

> *For V1 and N2*, if L2 is implemented, system cache would follow at *L3*
> (these don't seem to have the same/similar per-cluster L3 cache from the N1)

And in the future they're not able to build >3. German and Leo if there aren't
strong objections I think the best path forward is for me to respin these
assuming only 3 levels and if someone builds 4 in a far-off-future we can always
change the implementation then. Agreed?

Thanks,
Ali

