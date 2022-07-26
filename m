Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA35814B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiGZOBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiGZOBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:01:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBC8DF3E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A146155E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20515C433D6;
        Tue, 26 Jul 2022 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658844063;
        bh=AosfRxjkoU2i+zR4aHlEc3dyzHUvSeatzF0JZdFojzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/h0WLug9KwfRBC8mTu66Uue6gyvGeCAULQ5rNjPPPm4Jihv1Ei2+xoXr7kfOkriF
         GotTS2uWHpIWTXmTbXM0unkosb86uFyJLXM2wkF4H1jXoaI1OJdd73y5h3VoiSnnMn
         K7Nud0LeEmyCH8NdS8JrdNeilEfGoax5x7VOyhF14xVPNBmnHvH9Q3fvoOwk87weN1
         cBE+pRuwm4SuL0G4nl1VyD2L8NeybZrz0wMPRtZN/KkMnpNat4bi+iaQb+mjYMryXg
         RMQKJBfPOePGoiiG79YfULiRMQKMyfnIC4pV/N7jZV8NwpqV9yDWLX8tJHHkPBF1Zn
         dci2uheA9AdVg==
Received: by pali.im (Postfix)
        id 28EF782D; Tue, 26 Jul 2022 16:01:00 +0200 (CEST)
Date:   Tue, 26 Jul 2022 16:01:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Regression: Linux v5.15+ does not boot on Freescale P2020
Message-ID: <20220726140100.cfucgnhhh3yniqni@pali>
References: <6b227478-73b8-2a97-1c78-89570d928739@csgroup.eu>
 <20220723150702.jecerkhxhy65dgww@pali>
 <875yjld2oe.fsf@mpe.ellerman.id.au>
 <20220725125256.cg6su4d2ageylvp6@pali>
 <e2487668-b6d9-9ddb-1bb4-9f4d37fae1a7@csgroup.eu>
 <20220725201009.gwuchzswcqaxntrk@pali>
 <20220725215416.GV25951@gate.crashing.org>
 <20220726083406.tcjvny6d2di6q7ar@pali>
 <CAK8P3a2iM+RoySWEC2e0==rwBSVrZoRa8c4ADyFNB24JZM=hkw@mail.gmail.com>
 <20220726134405.GX25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726134405.GX25951@gate.crashing.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 July 2022 08:44:05 Segher Boessenkool wrote:
> On Tue, Jul 26, 2022 at 11:02:59AM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 26, 2022 at 10:34 AM Pali Rohár <pali@kernel.org> wrote:
> > > On Monday 25 July 2022 16:54:16 Segher Boessenkool wrote:
> > > > The EH field in larx insns is new since ISA 2.05, and some ISA 1.x cpu
> > > > implementations actually raise an illegal insn exception on EH=1.  It
> > > > appears P2020 is one of those.
> > >
> > > P2020 has e500 cores. e500 cores uses ISA 2.03. So this may be reason.
> > > But in official Freescale/NXP documentation for e500 is documented that
> > > lwarx supports also eh=1. Maybe it is not really supported.
> > > https://www.nxp.com/files-static/32bit/doc/ref_manual/EREF_RM.pdf (page 562)
> 
> (page 6-186)
> 
> > > At least there is NOTE:
> > > Some older processors may treat EH=1 as an illegal instruction.
> 
> And the architecture says
>   Programming Note
>   Warning: On some processors that comply with versions of the
>   architecture that precede Version 2.00

But e500v2 is 2.03 and not older than 2.00...

>   executing a Load And Reserve
>   instruction in which EH = 1 will cause the illegal instruction error
>   handler to be invoked.
> 
> > In commit d6ccb1f55ddf ("powerpc/85xx: Make sure lwarx hint isn't set on ppc32")
> > this was clarified to affect (all?) e500v1/v2,
> 
>   e500v1/v2 based chips will treat any reserved field being set in an
>   opcode as illegal.
> 
> while the architecture says
> 
>   Reserved fields in instructions are ignored by the processor.
> 
> Whoops :-)  We need fixes for processor implementation bugs all the
> time of course, but this is a massive *design* bug.

I looked also in e500v2 and P2020 errata documents there is nothing
mentioned about eh flag. But it looks like a bug.

> I'm surprised this
> CPU still works as well as it does!
> 
> Even the venerable PEM (last updated in 1997) shows the EH field as
> reserved, always treated as 0.
> 
> > this one apparently
> > fixed it before,
> > but Christophe's commit effectively reverted that change.
> > 
> > I think only the simple_spinlock.h file actually uses EH=1
> 
> That's right afaics.
> 
> > and this is not
> > included in non-SMP kernels, so presumably the only affected machines were
> > the rare dual-core e500v2 ones (p2020, MPC8572, bsc9132), which would
> > explain why nobody noticed for the past 9 months.
> 
> Also people using an SMP kernel on older cores should see the problem,
> no?

Probably yes.

But most people on these machines are using stable LTS kernels and do
not upgrade too often.

So you need to wait longer time to see people starting reporting such
bugs. Need to wait at least when v4.14 and v4.19 LTS versions stops
receiving updates. v4.19 is used in Debian 10 (oldstable) and v5.4 is
used by current OpenWRT. Both distributions are still supported, so
users have not migrated to new v5.15 problematic kernel yet.

> Or is that patched out?  Or does this use case never happen :-)
> 
> 
> Segher
