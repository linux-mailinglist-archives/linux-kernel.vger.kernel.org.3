Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3A5881CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiHBSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiHBSRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B81332EE1;
        Tue,  2 Aug 2022 11:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB92561333;
        Tue,  2 Aug 2022 18:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6D5C433D6;
        Tue,  2 Aug 2022 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659464228;
        bh=MAPAKOMDnapoFWQI4pbiRIHdLfwu4SmgOSEVB+CmYFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqCiNcvOxvcQF54d52JcBnBqklZPQOkv3iae9KzBU5KxMbhEAXyCWxwVT8+BjGV4E
         F4VvDFJM2YMMc+tcVGfhijodaIQdQqHqOAkhtOhCdM1FBav7kBvvVwLbnpzKUFa0dw
         +s/J42aE585ahlwTzU/GYJDkCI5S3iQO6fTAlp0khV+zpcZhYjoytvFIoWGU1EYc6R
         sYHcnkE3QWfZHkZehoZEwH8DM+R45lDrfhhdPWxUMz9Raq57mootGS7D1GR4nxO3Uc
         RVQqpeyAlXvk+YAhpPs7sZ9vRTEEQPwIgWSuSbMsn47dR6VpoUcoOAdTYe61YZndO/
         Icl18/KHyZkrw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F186B40736; Tue,  2 Aug 2022 15:17:05 -0300 (-03)
Date:   Tue, 2 Aug 2022 15:17:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
Subject: Re: [PATCH 2/3] perf lock: Add -m/--map-length option
Message-ID: <YulqIWpDMisldmHH@kernel.org>
References: <20220802073511.299459-1-namhyung@kernel.org>
 <20220802073511.299459-2-namhyung@kernel.org>
 <YuliN2UDbls5uW3u@kernel.org>
 <CAM9d7chZT-mociK=+iF_6SO=1JuD2xaL1HpE4eeo=myngq9vTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chZT-mociK=+iF_6SO=1JuD2xaL1HpE4eeo=myngq9vTw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 02, 2022 at 11:05:09AM -0700, Namhyung Kim escreveu:
> On Tue, Aug 2, 2022 at 10:43 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Aug 02, 2022 at 12:35:10AM -0700, Namhyung Kim escreveu:
> > > +-m::
> > > +--map-length::
> > > +     Maximum number of BPF map entries (default: 10240).
> >
> > --map-nr-entries?
> >
> > I think we use this jargon "nr-entries" for arrays, lists, etc, better
> > try to stick to it.
 
> Makes sense, will change.

Great.
 
> > Also what do you think about not using single letter options for things
> > that are not that used?
> >
> > The map size has a default, one that seems generous, so changing it
> > should be something uncommon, and then, if it becomes common that more
> > entries are needed by default, we can change the default in the tool.
> 
> Fair enough, I'll remove the single letter option.

Thanks!

- Arnaldo
