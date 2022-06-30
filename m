Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D27562373
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiF3TtR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jun 2022 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbiF3Tsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:48:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091F01D32D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96545622D5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D133C341C8;
        Thu, 30 Jun 2022 19:48:48 +0000 (UTC)
Date:   Thu, 30 Jun 2022 15:48:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nachammai Karuppiah <nachukannan@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
Message-ID: <20220630154847.134d3d67@gandalf.local.home>
In-Reply-To: <CAEXW_YTr9VaEY78S_C5iN1EH3hySZOED8F37t1A=7PNgbQK9CA@mail.gmail.com>
References: <cover.1599072725.git.nachukannan@gmail.com>
        <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
        <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
        <CAEXW_YTr9VaEY78S_C5iN1EH3hySZOED8F37t1A=7PNgbQK9CA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 21:25:11 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Hi Rob,
> (Back from holidays, digging through the email pile). Reply below:

What ever happen to this?

Sorry, I was expecting more replies, and when there was nothing, it got
lost in my inbox.


> 
> On Thu, Sep 3, 2020 at 2:09 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Sep 2, 2020 at 3:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:  
> > >
> > > On Wed, Sep 2, 2020 at 4:01 PM Nachammai Karuppiah
> > > <nachukannan@gmail.com> wrote:  
> > > >
> > > > Hi,
> > > >
> > > > This patch series adds support to store trace events in pstore.
> > > >
> > > > Storing trace entries in persistent RAM would help in understanding what
> > > > happened just before the system went down. The trace events that led to the
> > > > crash can be retrieved from the pstore after a warm reboot. This will help
> > > > debug what happened before machine’s last breath. This has to be done in a
> > > > scalable way so that tracing a live system does not impact the performance
> > > > of the system.  
> > >
> > > Just to add, Nachammai was my intern in the recent outreachy program
> > > and we designed together a way for trace events to be written to
> > > pstore backed memory directory instead of regular memory. The basic
> > > idea is to allocate frace's ring buffer on pstore memory and have it
> > > right there. Then recover it on reboot. Nachammai wrote the code with
> > > some guidance :) . I talked to Steve as well in the past about the
> > > basic of idea of this. Steve is on vacation this week though.  
> >
> > ramoops is already the RAM backend for pstore and ramoops already has
> > an ftrace region defined. What am I missing?  
> 
> ramoops is too slow for tracing. Honestly, the ftrace functionality in
> ramoops should be removed in favor of Nachammai's patches (she did it
> for events but function tracing could be trivially added). No one uses
> the current ftrace in pstore because it is darned slow. ramoops sits
> in between the writing of the ftrace record and the memory being
> written to adding more overhead in the process, while also writing
> ftrace records in a non-ftrace format. So ramoop's API and
> infrastructure fundamentally does not meet the requirements of high
> speed persistent tracing.  The idea of this work is to keep the trace
> events enabled for a long period time (possibly even in production)
> and low overhead until the problem like machine crashing happens.
> 
> > From a DT standpoint, we already have a reserved persistent RAM
> > binding too. There's already too much kernel specifics on how it is
> > used, we don't need more of that in DT. We're not going to add another
> > separate region (actually, you can have as many regions defined as you
> > want. They will just all be 'ramoops' compatible).  
> 
> I agree with the sentiment here on DT. Maybe the DT can be generalized
> to provide a ram region to which either ramoops or ramtrace can
> attach.

Right,

Perhaps just remove patch 7, but still have the ramoops work move forward?

-- Steve
