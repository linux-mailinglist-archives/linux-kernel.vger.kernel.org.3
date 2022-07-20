Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBFC57BB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiGTQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGTQTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC9F4506D;
        Wed, 20 Jul 2022 09:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5028261D6A;
        Wed, 20 Jul 2022 16:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D32C341CA;
        Wed, 20 Jul 2022 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658333972;
        bh=hm+C30N+p4hS8b32Z2BKAjSUjZL+YBbDCozWqx7d3N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKxSyw+3EKZrvjmoEi4/1S4LOaeSX5rm5F17z20WO1wSH0X2ZcucSFohJTzA6Rdgr
         t/xgMXNfjoR7rAoqMCt7gTXE+UjUqvbPEFkeRlP6ZofBwvoJo7uijvAtzEvAELCcdk
         7CN2FW9IR7XWZB6OtmDClIGY3n2wWy3O69iOxxGe8vXieGSMCVzblOMXfNo9M7IK1D
         nBZ7f4BRaOcoJRM1Ko0cEDrj0wBq36ZwgmmSOWsC+5m9ihOIh67n7ASO+r4qHmF7eh
         p/nslKeH/HETClFbMZIFxUC5MDFACHyv8aE4KQglpYkD7ujo5ueXGGkbi0nB0wNAq8
         5+lfIz200SIkQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A6DF40374; Wed, 20 Jul 2022 13:19:30 -0300 (-03)
Date:   Wed, 20 Jul 2022 13:19:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     James Clark <james.clark@arm.com>, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, quic_jinlmao@quicinc.com
Subject: Re: [PATCH v2 08/13] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
Message-ID: <YtgrEoXRblaj0tVy@kernel.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-9-mike.leach@linaro.org>
 <ceed3c67-c9e6-787f-f668-26b57904136e@arm.com>
 <CAJ9a7VgNO43EhzC-cmxwjEVcN+CKnqoBxiwWJSS3TPC2cEd6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgNO43EhzC-cmxwjEVcN+CKnqoBxiwWJSS3TPC2cEd6aQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 20, 2022 at 11:22:37AM +0100, Mike Leach escreveu:
> On Tue, 19 Jul 2022 at 15:54, James Clark <james.clark@arm.com> wrote:
> > I'm starting to look at this set now.

> > Am I right in thinking that this hard coded value means that new versions
> > of Perf won't work with older drivers? Does this need to be highlighted
> > somewhere in a warning that it's not the Perf version that's the issue but
> > both the Perf and driver version together?
 
> Need to differentiate here between perf record, and perf report.
 
> My understanding is that perf record must always match the version of
> your kernel. If you use an old version of perf record on a newer

No, that is not what is intended, one should be able to use whatever
perf (record or otherwise) with whatever kernel version.

perf tries to cope with, and if it is not possible to record the way the
user asks to then it should emit a helpful error message stating why it
is not possible, see:

  evsel__disable_missing_features()
  evsel__detect_missing_features()

Used during a evsel__open()

- Arnaldo

> kernel then you are asking for trouble.
> Indeed, if I run perf on my x86 dev machine at the moment it whinges:
> WARNING: perf not found for kernel 5.4.0-122
> because the last version of perf I have is for 5.4.0-120.
> 
> The new perf report will differentiate between the new and old
> versions of the perf.data file and act accordingly. For version 1 it
> will take the IDs from the metadata, for version 2 it will search for
> the IDs in the packet data.
> An older perf report will not be able to decode the newer files -
> though that has always been the case.
> 
> Were we to permit and old version of perf report to be used to
> generate a file using the new drivers, and then attempt to process
> that file with and older perf report, it would fail miserably.
> 
> Regards
> 
> Mike
> 
> 
> > I thought the idea was to search through the file to look for
> > PERF_RECORD_AUX_OUTPUT_HW_ID records (or lack of) and then choose the appropriate
> > decode method. But maybe that's too complicated and there is no requirement
> > for backwards compatibility?
> >
> > From experience it can be inconvenient when you can't just throw
> > any build of Perf on a system and it supports everything that it knows
> > about. Now we will have Perf builds that know about Coresight but don't
> > work with older drivers.
> >
> > But then as you say the ID allocation is already broken for some people.
> > It's hard to decide.
> >
> > James
> >
> > >
> > >  /* Beginning of header common to both ETMv3 and V4 */
> > >  enum {
> > > @@ -85,6 +89,12 @@ enum {
> > >       CS_ETE_PRIV_MAX
> > >  };
> > >
> > > +/*
> > > + * Check for valid CoreSight trace ID. If an invalid value is present in the metadata,
> > > + * then IDs are present in the hardware ID packet in the data file.
> > > + */
> > > +#define CS_IS_VALID_TRACE_ID(id) ((id > 0) && (id < 0x70))
> > > +
> > >  /*
> > >   * ETMv3 exception encoding number:
> > >   * See Embedded Trace Macrocell specification (ARM IHI 0014Q)
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK

-- 

- Arnaldo
