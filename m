Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE8B51A479
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352789AbiEDPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352850AbiEDPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:54:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22F7E0A4;
        Wed,  4 May 2022 08:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3FF3B82752;
        Wed,  4 May 2022 15:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A781C385A5;
        Wed,  4 May 2022 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651679424;
        bh=DeTg730M6LkL1e7xitjy/b9lK60vsB4JxDVrsze7OSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyUBe4ESW1Sl5pQ0qDMtLWx6cKt8BeYTzzN+z8BkppK2I52/oZiRlIXhm6e90LE+J
         hv11n3wCTfPor2aMjDJb6rDIEB4ZHyWA6jrEKzq99lb332k8E4iTKObFLZ6xCukrva
         O5Mv3Ya/QKnP8G+ypFPqF02n9VZDuzRrNp9yKq8kILblMbqUomBxwGsmjSciyCJxlt
         slwV/QDVA6QNh9VGkdAtTER5OOlhnMDAbR6/XnbMnfnYdH5OrEObX3JBk2iO16lVHi
         2ZV+Dr6g/4y8NpyXnwNEHtDhg7PFXjV7WztEu5FSMu6u4jP5iUEwOD9sD0jjtQ45aG
         cLARrxWXRqlyA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5099B400B1; Wed,  4 May 2022 12:50:20 -0300 (-03)
Date:   Wed, 4 May 2022 12:50:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/7] perf vendor events intel: Update CLX events to v1.15
Message-ID: <YnKgvLxcRhu6i53j@kernel.org>
References: <20220428075730.797727-1-irogers@google.com>
 <96b5c9f4-f0a0-0019-8059-3e833c95b011@linux.intel.com>
 <YmqXGCMbBOLcd261@kernel.org>
 <CAP-5=fWQMVVFZ=4WLWJkojZARHnmYp+AgTOodG_W=qqNZFw6iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWQMVVFZ=4WLWJkojZARHnmYp+AgTOodG_W=qqNZFw6iA@mail.gmail.com>
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

Em Tue, May 03, 2022 at 12:47:25PM -0700, Ian Rogers escreveu:
> On Thu, Apr 28, 2022 at 6:31 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Apr 28, 2022 at 09:12:26AM -0400, Liang, Kan escreveu:
> > >
> > >
> > > On 4/28/2022 3:57 AM, Ian Rogers wrote:
> > > > Events are generated for CascadeLake Server v1.15 with
> > > > events from:
> > > > https://download.01.org/perfmon/CLX/
> > > >
> > > > Using the scripts at:
> > > > https://github.com/intel/event-converter-for-linux-perf/
> > > >
> > > > This change updates descriptions, adds INST_DECODED.DECODERS and
> > > > corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.
> > > >
> > > > Signed-off-by: Ian Rogers<irogers@google.com>
> > >
> > > Thanks Ian. For the whole series,
> > >
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> >
> > Thanks, applied.
> >
> > - Arnaldo
> 
> Thanks Arnaldo, it looks like CLX was accidentally skipped.

Checking, I usually take these using b4...

- Arnaldo
