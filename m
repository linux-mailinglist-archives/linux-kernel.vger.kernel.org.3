Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F6D58E04B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbiHITjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245229AbiHITij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:38:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71E825E93;
        Tue,  9 Aug 2022 12:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D6FBB81722;
        Tue,  9 Aug 2022 19:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F60C433C1;
        Tue,  9 Aug 2022 19:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660073913;
        bh=pHC8fIPoGxLBJ9/lJmkXqCp6AtiWaVbDFdc2Xj+wo2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhzxPVf6KoXeLEeZ5kmhU456Qq7Orbo9wqIWq0MYZLG5YB3mgnrmItcxNzj68YIEy
         HICoW1b9oyolyyqF+pxeQliODs4qgnu0kHgzv4mhMykE3EyVpSfAbJnSbSsOStPLxe
         YtLMXcOdxeyK6zrBsvYPHiVN1Y3oudSSP7vRcl6kD3A/gD9hpIn07vLIXcCr6QYb1s
         zl7lussWseBvtGtlavmkl/nVrr5i1xQyv3qLuYxlTC372wg1WdiBAHJ0yXnWebOEOd
         yUD5AkMmAL68RMIyo+M+21SxMz2gB5eHWCBGDNVhPFaBcRSqIrM+X4rIVWsY2143Hb
         cFJIOylJoldiQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F86F4035A; Tue,  9 Aug 2022 16:38:30 -0300 (-03)
Date:   Tue, 9 Aug 2022 16:38:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 03/17] perf jevents: Add JEVENTS_ARCH make option
Message-ID: <YvK3ts/YHXJT+/Vl@kernel.org>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-4-irogers@google.com>
 <b1cc7151-e57c-6ec5-f3f1-361434e0b2ee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1cc7151-e57c-6ec5-f3f1-361434e0b2ee@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 05, 2022 at 10:55:50AM +0100, John Garry escreveu:
> On 04/08/2022 23:18, Ian Rogers wrote:
> > Allow the architecture built into pmu-events.c to be set on the make
> > command line with JEVENTS_ARCH.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Seems reasonable, so:
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo

 
> I assume that if we run on the wrong arch (than we build for) then it has
> same effect as if pmu-events is not supported.
> 
> > ---
> >   tools/perf/pmu-events/Build | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > index 28a9d01b08af..04ef95174660 100644
> > --- a/tools/perf/pmu-events/Build
> > +++ b/tools/perf/pmu-events/Build
> > @@ -7,6 +7,10 @@ JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
> >   			find $(JDIR_TEST) -name '*.json')
> >   JEVENTS_PY	=  pmu-events/jevents.py
> > +ifeq ($(JEVENTS_ARCH),)
> > +JEVENTS_ARCH=$(SRCARCH)
> > +endif
> > +
> >   #
> >   # Locate/process JSON files in pmu-events/arch/
> >   # directory and create tables in pmu-events.c.
> > @@ -19,5 +23,5 @@ $(OUTPUT)pmu-events/pmu-events.c: pmu-events/empty-pmu-events.c
> >   else
> >   $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
> >   	$(call rule_mkdir)
> > -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
> > +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) pmu-events/arch $@
> >   endif

-- 

- Arnaldo
