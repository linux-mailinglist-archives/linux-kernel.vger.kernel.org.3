Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D5508404
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351501AbiDTIvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiDTIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:51:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF4252B3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:48:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l7so2109362ejn.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qpUXxpkY1LQrTCewxX/BwK6Ql1sWiAOxr2avilSjOww=;
        b=D5HHuJNPDcWp1NhI9j9oJPY7JJPhJj+u4XdYy1OxHt81Dn0FBmrtkeHQZMXe3qs7in
         F5uWxg1sMMIckuW84/EW22jv0iNA9uPUNUpXhBgwaGBXD90wfqoVeAg5vD0JqA7Z6V7R
         afuF9PVp7P5c3qnx7lTC/QrKKRVORLV0+dR8r5DdRSOj1wqhtdBcrRypRedRZAPBtWwy
         SaH54loFCEpKBqpyIIQjPlk2f5KhSC5u2TKKbh624a6BsRP+Fseii00sZ3ehon6fl+Fb
         NwXX7xs3MKYk8Fm1MGhuUZRKZPNDmxLf/pVUe+jps6uDt3Aywxj6szZxoi3F2pSjopHn
         yMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qpUXxpkY1LQrTCewxX/BwK6Ql1sWiAOxr2avilSjOww=;
        b=3gI3GY+p/r90L4KlC4PEDeJ3Uduo6+h0jJbEWGcO2Bu/GQh7Np7w3aVEtnxuqeug0E
         +XWGLVyl6kEP6I7L3/pB1INziELgyfZJ1sMYy404gC/iOMvjiv/8tVqDP1bcz4tgi3rC
         Fqop6Ryg03STLhvyiBSOP6C5n5OfmhJDnRSeSm0JbgKrjCRqC5zny8SeJiOCqRjyUcQt
         0+TaF9iRsPI/ABj0MnB2r3qWarNugSjOlBjwqbA/3VXSWfzg0wq7f8NIddT9//WGigR2
         HDplHDIhWS8SiSyo9EB+dVy+CXBCxlfBd4UOkjU8rg1O4/xfR2sbgkhTRPjqRDIbaZJp
         /RIA==
X-Gm-Message-State: AOAM5333Iq2pTUmUhQndnDm6QLt5ahs4WhujGCRY7ehE4ykNmZVi4Eat
        JwU+5/59/QbVfqEWK7mK31y+VQ==
X-Google-Smtp-Source: ABdhPJw837T3cRO9mLC5fpo5UIyr0XVBpI4v0Nlm9M0zRzKPBvuTg9N+7xCZv7v5VIuNF5cHZ9SIrg==
X-Received: by 2002:a17:907:7286:b0:6ef:f594:e063 with SMTP id dt6-20020a170907728600b006eff594e063mr2925426ejc.611.1650444510495;
        Wed, 20 Apr 2022 01:48:30 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709062bd900b006e8766b7907sm6490432ejg.223.2022.04.20.01.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:48:29 -0700 (PDT)
Date:   Wed, 20 Apr 2022 16:48:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, acme@kernel.org,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 5/5] perf mem: Support mem_lvl_num in c2c command
Message-ID: <20220420084823.GE843168@leoy-ThinkPad-X240s>
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-6-alisaidi@amazon.com>
 <3ad0128a-1b3d-37a7-81f6-fd597b565b18@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad0128a-1b3d-37a7-81f6-fd597b565b18@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:04:28AM +0100, German Gomez wrote:
> 
> On 08/04/2022 20:53, Ali Saidi wrote:
> > In addition to summarizing data encoded in mem_lvl also support data
> > encoded in mem_lvl_num.
> >
> > Since other architectures don't seem to populate the mem_lvl_num field
> > here there shouldn't be a change in functionality.
> >
> > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > ---
> >  tools/perf/util/mem-events.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> > index ed0ab838bcc5..e5e405185498 100644
> > --- a/tools/perf/util/mem-events.c
> > +++ b/tools/perf/util/mem-events.c
> > @@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
> >  	u64 daddr  = mi->daddr.addr;
> >  	u64 op     = data_src->mem_op;
> >  	u64 lvl    = data_src->mem_lvl;
> > +	u64 lnum   = data_src->mem_lvl_num;
> >  	u64 snoop  = data_src->mem_snoop;
> >  	u64 lock   = data_src->mem_lock;
> >  	u64 blk    = data_src->mem_blk;
> > @@ -527,16 +528,18 @@ do {				\
> >  			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
> >  			if (lvl & P(LVL, IO))  stats->ld_io++;
> >  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
> 
> Just for completion, can we also handle LFB as it seems to be being set
> in "/arch/x86/events/intel/ds.c"? (Sorry I missed this in the v4)

With fixing LFB issue pointed by German, the change looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

It would be appreciate if x86 or PowerPC maintainers could take a look
for this patch.  Thanks!

Leo

> > -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> > -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> > -			if (lvl & P(LVL, L3 )) {
> > +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> > +				stats->ld_l1hit++;
> > +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> > +				stats->ld_l2hit++;
> > +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L3)) {
> >  				if (snoop & P(SNOOP, HITM))
> >  					HITM_INC(lcl_hitm);
> >  				else
> >  					stats->ld_llchit++;
> >  			}
> >  
> > -			if (lvl & P(LVL, LOC_RAM)) {
> > +			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
> >  				stats->lcl_dram++;
> >  				if (snoop & P(SNOOP, HIT))
> >  					stats->ld_shared++;
