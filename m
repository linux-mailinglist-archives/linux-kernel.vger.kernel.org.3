Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57484B7252
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbiBOPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:07:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiBOPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:07:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89877F6;
        Tue, 15 Feb 2022 07:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2621961545;
        Tue, 15 Feb 2022 15:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531E0C340EB;
        Tue, 15 Feb 2022 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644937641;
        bh=DnTGqvl5fmkyuT7QiMmF5etuFCDPQuPejculypF4zR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMhPySvQsC4weAIAxfHr2zKYI3AGymiL/maKadoaaxofEkJ4D3g1nJH3J8k1uZMB6
         H608dLngMLgxtDoN7s/vE7P57fTIF66hwNQrGLoiRECkWj2Jbv9GO2t/zEtc1+owWa
         qFg9MG40OsJjZlRsClHSSjy0j+5rJXHd52Hr22mHQmfxgKYLIKAMa9peuisx5I/WUf
         8IV3dcqBTQx/6q2is2wMG1wEuF+dpsDNUsWe3p0zlGHJ52c0AUQryuZj2sskpQBXAX
         6HWXWKEj/Irx6GcylVtLOwWGAt/MIOIA/kwY7zyX9A01hZkTy05dj+QZOSOCA8Z4R1
         53cmMliKMxOTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBD7D400FE; Tue, 15 Feb 2022 12:07:18 -0300 (-03)
Date:   Tue, 15 Feb 2022 12:07:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: cs-etm: Fix corrupt inject files when only
 last branch option is enabled
Message-ID: <YgvBpvYzAMCGSECj@kernel.org>
References: <20220210200620.1227232-1-james.clark@arm.com>
 <20220210200620.1227232-2-james.clark@arm.com>
 <20220211160516.GD475776@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211160516.GD475776@leoy-ThinkPad-X240s>
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

Em Sat, Feb 12, 2022 at 12:05:16AM +0800, Leo Yan escreveu:
> On Thu, Feb 10, 2022 at 08:06:20PM +0000, James Clark wrote:
> > Perf inject with Coresight data generates files that cannot be opened
> > when only the last branch option is specified:
> > 
> >   perf inject -i perf.data --itrace=l -o inject.data
> >   perf script -i inject.data
> >   0x33faa8 [0x8]: failed to process type: 9 [Bad address]
> > 
> > This is because cs_etm__synth_instruction_sample() is called even when
> > the sample type for instructions hasn't been setup. Last branch records
> > are attached to instruction samples so it doesn't make sense to generate
> > them when --itrace=i isn't specified anyway.
> > 
> > This change disables all calls of cs_etm__synth_instruction_sample()
> > unless --itrace=i is specified, resulting in a file with no samples if
> > only --itrace=l is provided, rather than a bad file.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/util/cs-etm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 796a065a500e..8b95fb3c4d7b 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1553,6 +1553,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
> >  		goto swap_packet;
> >  
> >  	if (etmq->etm->synth_opts.last_branch &&
> > +	    etmq->etm->synth_opts.instructions &&
> >  	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
> >  		u64 addr;
> >  
> > @@ -1610,6 +1611,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
> >  	 * the trace.
> >  	 */
> >  	if (etmq->etm->synth_opts.last_branch &&
> > +	    etmq->etm->synth_opts.instructions &&
> >  	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
> >  		u64 addr;
> >  
> > -- 
> > 2.28.0
> > 

-- 

- Arnaldo
