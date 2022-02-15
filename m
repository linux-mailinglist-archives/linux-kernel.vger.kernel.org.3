Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25684B716D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiBOOyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:54:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiBOOxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:53:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911F4102423;
        Tue, 15 Feb 2022 06:52:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72C1DB819FA;
        Tue, 15 Feb 2022 14:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ADDC340EB;
        Tue, 15 Feb 2022 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644936763;
        bh=oHvI812wnFSZHuTw2mFyGnMQwXFVGo3Bnh6xMpiP8xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdjq0iQ6XSjhEYl/rI1cMvQa82uF75FAMOBXuy7bNuCfqoEzx0NcmpyeJezq3L7ew
         URSopB2PK2NyBTFqz0r9jyPK2VTDNfvtCppZSP+t/GCERdYQYdJeqcuUfxQTnisZGk
         cml/ziTELZQLptSUs5TIbSmtef8xgYwEfUX5FM4xwuEroLXwZLYf6WX9pi+1ywDUuS
         9fvEnwP8w+a9j8ocwNXhu3KI8iM3Pwv6bip2xkgj5FfrcDyGIyZDCMd5SlM+GYLRRq
         iX5V4PuFkYkSFlEBva298QHJEU3lHX8AMH6Y1EMJnWftKenGvzPucWDqwumNzOQtgf
         JgvPE//08keuw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3089400FE; Tue, 15 Feb 2022 11:52:40 -0300 (-03)
Date:   Tue, 15 Feb 2022 11:52:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        mike.leach@linaro.org, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/6] perf cs-etm: Update deduction of TRCCONFIGR
 register for branch broadcast
Message-ID: <Ygu+OHnxYAyqLFwB@kernel.org>
References: <20220113091056.1297982-1-james.clark@arm.com>
 <20220113091056.1297982-4-james.clark@arm.com>
 <25b85560-dd95-2569-d1bc-872902d6343f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25b85560-dd95-2569-d1bc-872902d6343f@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 28, 2022 at 11:25:24AM +0000, Suzuki K Poulose escreveu:
> On 13/01/2022 09:10, James Clark wrote:
> > Now that a config flag for branch broadcast has been added, take it into
> > account when trying to deduce what the driver would have programmed the
> > TRCCONFIGR register to.

Thanks, applied this one, the tools/ part.

- Arnaldo

 
> > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   tools/include/linux/coresight-pmu.h | 2 ++
> >   tools/perf/arch/arm/util/cs-etm.c   | 3 +++
> >   2 files changed, 5 insertions(+)
> > 
> > diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> > index 4ac5c081af93..6c2fd6cc5a98 100644
> > --- a/tools/include/linux/coresight-pmu.h
> > +++ b/tools/include/linux/coresight-pmu.h
> > @@ -18,6 +18,7 @@
> >    * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> >    * directly use below macros as config bits.
> >    */
> > +#define ETM_OPT_BRANCH_BROADCAST 8
> >   #define ETM_OPT_CYCACC		12
> >   #define ETM_OPT_CTXTID		14
> >   #define ETM_OPT_CTXTID2		15
> > @@ -25,6 +26,7 @@
> >   #define ETM_OPT_RETSTK		29
> >   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> > +#define ETM4_CFG_BIT_BB         3
> >   #define ETM4_CFG_BIT_CYCACC	4
> >   #define ETM4_CFG_BIT_CTXTID	6
> >   #define ETM4_CFG_BIT_VMID	7
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index 293a23bf8be3..c7ef4e9b4a3a 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -527,6 +527,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
> >   	if (config_opts & BIT(ETM_OPT_CTXTID2))
> >   		config |= BIT(ETM4_CFG_BIT_VMID) |
> >   			  BIT(ETM4_CFG_BIT_VMID_OPT);
> > +	if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
> > +		config |= BIT(ETM4_CFG_BIT_BB);
> > +
> >   	return config;
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> >   }

-- 

- Arnaldo
