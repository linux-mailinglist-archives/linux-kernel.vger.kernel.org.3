Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709D850039F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiDNB1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiDNB1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:27:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568B17A9C;
        Wed, 13 Apr 2022 18:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 291ECB8269B;
        Thu, 14 Apr 2022 01:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D812C385A6;
        Thu, 14 Apr 2022 01:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649899486;
        bh=dIFSmQFvO+u7t69e2aunIFG5AulvQBr/ncUxbYb4pcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EenLTlV8oLBhvDxw/C5592woP0nHbx1g4nwECBVKHSC/o02vajjJANuWetn+Z/kQu
         5ioz/SWtxy34O6ZJQme/aCO0BxQEEIsagqF721tnH1SaLdYs/dTSutV6qQnZvC7nFT
         fCV8djjesWXIVBom7AxrOuIFP39jUjC7Fw/iL9YwwE9b6sNFgE8F8U8AGn8efJx4G4
         vcZgEe5UByw4rdOpQeN6V1NJPvBesSBqj/wkgXvj7nqgSu2GqxWQ6924MjLmj/6w5c
         c7c9SO1I1kFPA8SEzGYxciSLIC29AdrMZNGuAordDjm7JUqGDO1edku6S0j49aMc75
         DeOA1UK6aboDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A23140407; Wed, 13 Apr 2022 22:24:43 -0300 (-03)
Date:   Wed, 13 Apr 2022 22:24:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE
 event
Message-ID: <Yld324cGySbCPF9i@kernel.org>
References: <20220413075124.635589-1-leo.yan@linaro.org>
 <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
 <20220413084941.GB521036@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413084941.GB521036@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 13, 2022 at 04:49:41PM +0800, Leo Yan escreveu:
> On Wed, Apr 13, 2022 at 09:15:40AM +0100, German Gomez wrote:
> 
> [...]
> 
> > >  	if (sort__mode == SORT_MODE__MEMORY) {
> > > +		/*
> > > +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
> > > +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
> > > +		 * compatibility, set the bit if it's an old perf data file.
> > > +		 */
> > > +		evlist__for_each_entry(session->evlist, evsel) {
> > > +			if (strstr(evsel->name, "arm_spe_") &&
> > 
> > This didn't work for me when the file recorded "-e arm_spe//" instead of
> > "-e arm_spe_0//". Could you remove the trailing _? With that:
> 
> Sure, will change to "arm_spe".  Just curious, if there any local
> change at your side so we have the different event name?

Ok, waiting for v2
 
> > Tested-by: German Gomez <german.gomez@arm.com>
> 
> Thanks a lot, German!
> 
> Leo

-- 

- Arnaldo
