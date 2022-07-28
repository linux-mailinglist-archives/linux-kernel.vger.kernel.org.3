Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993D6584638
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiG1TNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiG1TNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:13:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BA5691D9;
        Thu, 28 Jul 2022 12:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0461CE264F;
        Thu, 28 Jul 2022 19:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD9BC433D7;
        Thu, 28 Jul 2022 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659035618;
        bh=eEIcCz14NKsYTDaTni+/h7nuQpzcq7MfZLXvFYUeLZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGeWSaUBerfALX4Dze49FhFOcpoGF51xxmEqgJb6JyA+3bcypWXOuohuvgVv2PIRb
         FQw029fDmwLMrCqWzJAMUdpzoSE8gfbJ1WJzPf3aRNUKoPWAsjf0r9wg49ZRI66TX2
         bzWkk0X4Zu9u0zIQY8YoVQvgPL1IJiM877ygvx0czgOW8melhaP8pXpsud7qMfddXX
         n194PPJ1+pJkuXHHwoxrddV5pGS1j41dCHYeqrwDfJsCESU84U66k8Jd6llIVgKpFz
         Md5bMOco4etQJp9dHo8ZEyvft0T4Gt6BH/5HLkdpQkb39pHjulpXAM94EnJYTIQEP3
         xE3Nm/edOZ4bw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4C0A0405DD; Thu, 28 Jul 2022 16:13:35 -0300 (-03)
Date:   Thu, 28 Jul 2022 16:13:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Forrington <nick.forrington@arm.com>
Cc:     John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf vendor events arm64: Arm Cortex-A78C and X1C
Message-ID: <YuLf3xId+/m9YvAo@kernel.org>
References: <20220610174459.615995-1-nick.forrington@arm.com>
 <2955958b-4982-42bc-7c68-82cd23462b35@huawei.com>
 <3379eac1-d398-60be-b606-10098702d7aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3379eac1-d398-60be-b606-10098702d7aa@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 28, 2022 at 05:17:08PM +0100, Nick Forrington escreveu:
> On 13/06/2022 11:09, John Garry wrote:
> > On 10/06/2022 18:44, Nick Forrington wrote:
> > > Add PMU events for the Arm Cortex-A78C and Arm Cortex-X1C CPUs.
> > > 
> > > Events for Arm Cortex-A78C match those for Arm Cortex-A78.
> > > Events for Arm Cortex-X1C match those for Arm Cortex- X1.
> > > 
> > > As such, this is just a mapfile change.
> > > 
> > > Main ID Register (MIDR) and event data is sourced from the corresponding
> > > Arm Technical Reference Manuals:
> > > 
> > > Arm Cortex-A78C
> > > https://developer.arm.com/documentation/102226/
> > > 
> > > Arm Cortex-X1C
> > > https://developer.arm.com/documentation/101968/
> > > 
> > > Signed-off-by: Nick Forrington<nick.forrington@arm.com>
> > 
> > Reviewed-by: John Garry <john.garry@huawei.com>
> 
> Could this be applied please?

Thanks, applied.

- Arnaldo

