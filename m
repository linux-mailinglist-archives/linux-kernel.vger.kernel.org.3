Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4F52A576
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349470AbiEQO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbiEQO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A742430555
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 445F2B818F3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB605C34116;
        Tue, 17 May 2022 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652799403;
        bh=Aun7xA8wrKxkh8OitJvtWBCd91a1rKp95MRXQjNQsRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8SZ6Ne2UdUUm623dbz/Zoy06FydBfBFMzE5AvpQ8pjrJeWWKkg3nG+Fd4RmQ5Wen
         99w2nlSrztxq9DbVK0FyUOFNLE/OONGa3th44h3fQ74jV/4/SVO/IR9ob8sJOF/rn1
         h0MoXQS7+Rtsa9ajPLQySK2uky0/KNc8cul1LDkMt7qollmGJe4OdKDKKh4S+EIXnN
         383ZvVzOuMdBe6pssOJNPyCrisAPx3KYjGtvlDOdU998nCdWVjU+Dau7w8rT/2dF5k
         0x0V/opCynL/l+6+puuCWv6qtqY4fRaQICjIixmafGMC0G5F40fvwit5VJDWJ/UYc9
         tfVlaCK+BYmIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 088BE400B1; Tue, 17 May 2022 11:56:41 -0300 (-03)
Date:   Tue, 17 May 2022 11:56:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/3] perf intel-pt: Add support for emulated ptwrite
Message-ID: <YoO3qM9EyF1WZOkq@kernel.org>
References: <20220509152400.376613-1-adrian.hunter@intel.com>
 <d9b6a2c0-2387-2c2e-eedb-9de8a36a2eb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b6a2c0-2387-2c2e-eedb-9de8a36a2eb5@intel.com>
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

Em Tue, May 17, 2022 at 04:13:14PM +0300, Adrian Hunter escreveu:
> On 9/05/22 18:23, Adrian Hunter wrote:
> > Hi
> > 
> > Here are 3 patches (on top of "perf intel-pt: Add link to the perf wiki's
> > Intel PT page") to add support for decoding emulated ptwrite i.e. for
> > hardware that does not have the ptwrite instruction.
> 
> Is this OK?

yeah, thanks, applied.

- Arnaldo
 
> > 
> > 
> > Adrian Hunter (3):
> >       perf intel-pt: Add support for emulated ptwrite
> >       perf script: Print Intel ptwrite value as a string if it is ASCII
> >       perf scripts python: intel-pt-events.py: Print ptwrite value as a string if it is ASCII
> > 
> >  tools/perf/Documentation/perf-intel-pt.txt         | 88 +++++++++++++++++++
> >  tools/perf/builtin-script.c                        | 32 ++++++-
> >  tools/perf/scripts/python/intel-pt-events.py       |  8 +-
> >  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 99 +++++++++++++++++++++-
> >  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  1 +
> >  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |  1 +
> >  .../util/intel-pt-decoder/intel-pt-insn-decoder.h  |  1 +
> >  tools/perf/util/intel-pt.c                         | 37 +++++++-
> >  8 files changed, 261 insertions(+), 6 deletions(-)
> > 
> > 
> > Regards
> > Adrian

-- 

- Arnaldo
