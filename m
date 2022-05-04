Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11151A55B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353361AbiEDQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiEDQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:26:45 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B31A39813;
        Wed,  4 May 2022 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1651681389; x=1683217389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Q/yiQSP0UKyBh6YQJ5BaZo0I0IrAyfxQYHuply2jAk=;
  b=hf2IYhbTP7/C5uI5Kqo6jNwp5esTQ5HkllgxU6KLMNpVxw0TrNzazoT3
   DTejx9bgJW+tXUB1EtEzMMF9Hs89opPjCk7dQ0EZoVEb2hUX7pjY0edfr
   W/ffJU0WtndriOjGqd5Mbw2F8tVxIdUMvfOEdFCJimA6ryHT07GqgpRoB
   4=;
X-IronPort-AV: E=Sophos;i="5.91,198,1647302400"; 
   d="scan'208";a="85452775"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 04 May 2022 16:22:35 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com (Postfix) with ESMTPS id 60F5DE42C8;
        Wed,  4 May 2022 16:22:30 +0000 (UTC)
Received: from EX13D02UWC001.ant.amazon.com (10.43.162.243) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 4 May 2022 16:22:23 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWC001.ant.amazon.com (10.43.162.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Wed, 4 May 2022 16:22:23 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.32 via Frontend Transport; Wed, 4 May 2022 16:22:22 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id B54541D1A; Wed,  4 May 2022 16:22:22 +0000 (UTC)
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
        <will@kernel.org>
Subject: Re: [PATCH v7 5/5] perf arm-spe: Use SPE data source for neoverse cores
Date:   Wed, 4 May 2022 16:22:20 +0000
Message-ID: <20220504162220.28528-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com>
References: <458a2de1-dc93-7e2d-5dc5-fbcd670572b6@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

Thanks for taking another look!

On Tue, 3 May 2022 09:58:15 +0000, German Gomez wrote:
> Hi Ali, Leo
> 
> Some minor comments below.
> 
> On 26/04/2022 14:59, Ali Saidi wrote:
> > When synthesizing data from SPE, augment the type with source information
> > for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> > the same encoding. I can't find encoding information for any other SPE
> > implementations to unify their choices with Arm's thus that is left for
> > future work.
> >
> > This change populates the mem_lvl_num for Neoverse cores as well as the
> > deprecated mem_lvl namespace.
> >
> > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > ---
> >  .../util/arm-spe-decoder/arm-spe-decoder.c    |   1 +
> >  .../util/arm-spe-decoder/arm-spe-decoder.h    |  12 ++
> >  tools/perf/util/arm-spe.c                     | 130 +++++++++++++++---
> >  3 files changed, 127 insertions(+), 16 deletions(-)
> >
> [snip]
> > +	/*
> > +	 * We have no data on the hit level or data source for stores in the
> > +	 * Neoverse SPE records.
> > +	 */
> > +	if (record->op & ARM_SPE_ST) {
> > +		data_src->mem_lvl = PERF_MEM_LVL_NA;
> > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> 
> Is it correct to use ANY_CACHE as the NA value? The LVLNUM_* enum begins at 1, so it looks like this should be set to 0 instead (like in HOPS_*).

I think you're making a good point here. To be consistent we should set
mem_lvl_num to PERF_MEM_LVLNUM_NA just like mem_lvl.

Thanks,
Ali



