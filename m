Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294244D77DF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiCMTIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiCMTIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:08:31 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF5652FF;
        Sun, 13 Mar 2022 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1647198423; x=1678734423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3qnpGEDwzlBqk4oSVj6XhjSrpezFHas77xLMut5hfbw=;
  b=UfMlsu89OEVit3eW3OQB30iBfBn29f73RvExYnKjKB09S1DKfZU9SUgG
   YTiQUsM2VL9IGe7g75GePTcvzq85/VnobMQin4p0HZb+2C8/5Lfm/lhCg
   sPUqG7rSjtqfNTRCt6/ZI4Jwa2f251th4FIZy1G9NJFYdyIAtIOEIlqX0
   k=;
X-IronPort-AV: E=Sophos;i="5.90,179,1643673600"; 
   d="scan'208";a="201917501"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-718d0906.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 13 Mar 2022 19:06:24 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-718d0906.us-west-2.amazon.com (Postfix) with ESMTPS id 968C63E1840;
        Sun, 13 Mar 2022 19:06:24 +0000 (UTC)
Received: from EX13D02UWB001.ant.amazon.com (10.43.161.240) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.28; Sun, 13 Mar 2022 19:06:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D02UWB001.ant.amazon.com (10.43.161.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sun, 13 Mar 2022 19:06:23 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.28 via Frontend Transport; Sun, 13 Mar 2022 19:06:23
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 5A23C17DB; Sun, 13 Mar 2022 19:06:22 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <leo.yan@linaro.org>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <alisaidi@amazon.com>, <andrew.kilroy@arm.com>,
        <benh@kernel.crashing.org>, <german.gomez@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@redhat.com>,
        <kjain@linux.ibm.com>, <lihuafei1@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <will@kernel.org>, <yao.jin@linux.intel.com>
Subject: Re: [PATCH v2 1/2] perf arm-spe: Use SPE data source for neoverse cores
Date:   Sun, 13 Mar 2022 19:06:19 +0000
Message-ID: <20220313190619.18914-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220313114615.GA143848@leoy-ThinkPad-X240s>
References: <20220313114615.GA143848@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 11:47:58 +0000 Leo Yan wrote:
> Hi Ali, German,
> 
> On Wed, Mar 02, 2022 at 11:59:05AM +0000, German Gomez wrote:
> > Hi Ali,
> > 
> > On 21/02/2022 22:47, Ali Saidi wrote:
> > > When synthesizing data from SPE, augment the type with source information
> > > for Arm Neoverse cores. The field is IMPLDEF but the Neoverse cores all use
> > > the same encoding. I can't find encoding information for any other SPE
> > > implementations to unify their choices with Arm's thus that is left for
> > > future work.
[snip]
> > >  
> > > +static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *record,
> > > +						union perf_mem_data_src *data_src)
> > > +{
> > > +	switch (record->source) {
> > > +	case ARM_SPE_NV_L1D:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > 
> > I understand mem_lvl is deprecated but shouldn't we add the level bits here as well for backwards compat?
> 
> Thanks for pointing out this.  Yeah, I think German's suggestion is
> valid, the commit 6ae5fa61d27d ("perf/x86: Fix data source decoding
> for Skylake") introduces new field 'mem_lvl_num', but it also keeps
> backwards compatible for the field 'mem_lvl'.
I thought about that, but then I'm making some assumption about how to fit
this into the old LVL framework, which is perhaps OK (afaik there are no
Neoverse systems with more than 3 cache levels). What stopped me was that
perf_mem__lvl_scnprintf() does the wrong thing when both are set so I
assumed that setting both was not the right course of action.

> 
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> > > +		break;
> > > +	case ARM_SPE_NV_L2:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
> > > +		break;
> > > +	case ARM_SPE_NV_PEER_CORE:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> 
> For PEER_CORE data source, we don't know if it's coming from peer
> core's L1 cache or L2 cache, right?
We don't.

> 
> If so, do you think if it's possible to retrieve more accurate info
> from the field "record->type"?
No, we just don't know and it really doesn't matter. The main reason to
understand the source is to understand the penalty of data coming from
the source and that it's coming from a core should be sufficient.

> 
> > > +		break;
> > > +	/*
> > > +	 * We don't know if this is L1, L2, or even L3 (for the cases the system
> > > +	 * has an L3, but we do know it was a cache-2-cache transfer, so set
> > > +	 * SNOOP_HITM
> > > +	 */
> > > +	case ARM_SPE_NV_LCL_CLSTR:
> > > +	case ARM_SPE_NV_PEER_CLSTR:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_ANY_CACHE;
> 
> Seems to me, we need to add attribution to indicate the difference
> between ARM_SPE_NV_PEER_CORE and ARM_SPE_NV_LCL_CLSTR.
I don't think we really do, see my reasoning above. 

> 
> For ARM_SPE_NV_PEER_CLSTR data source, should we set any "remote"
> attribution as well?

No, we should leave remote for data coming from another chip/socket
which is really impactful. 

> 
> > > +		break;
> > > +	/*
> > > +	 * System cache is assumed to be L4, as cluster cache (if it exists)
> > > +	 * would be L3 cache on Neoverse platforms
> > > +	 */
> > > +	case ARM_SPE_NV_SYS_CACHE:
> > > +		data_src->mem_lvl = PERF_MEM_LVL_HIT;
> > > +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L4;
> > > +		break;
> > > +	/*
> > > +	 * We don't know what level it hit in, except it came from the other
> > > +	 * socket
> > > +	 */
> > > +	case ARM_SPE_NV_REMOTE:
> > > +		data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> > > +		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> > > +		break;
> 
> Just curious, is it possible that 'record->source' combines multiple
> bits?  Like we can get a data source value with:
> 
>   ARM_SPE_NV_REMOTE | ARM_SPE_NV_REMOTE

source encodes a single value (not bits that represent flags) on Neoverse
cores.

[snip]
> > > @@ -796,6 +868,10 @@ static int arm_spe_process_event(struct perf_session *session,
> > >  	u64 timestamp;
> > >  	struct arm_spe *spe = container_of(session->auxtrace,
> > >  			struct arm_spe, auxtrace);
> > > +	const char *cpuid = perf_env__cpuid(session->evlist->env);
> > > +	u64 midr = strtol(cpuid, NULL, 16);
> > > +
> > > +	spe->midr = midr;
> > 
> > I think this midr setup belongs in the arm_spe_process_auxtrace_info callback instead.
> 
> Yeah, arm_spe_process_event() would be invoked for multiple times for
> processing perf events.  arm_spe_process_auxtrace_info() would be a
> good place to initialize midr.

Will do.

Thanks,
Ali

