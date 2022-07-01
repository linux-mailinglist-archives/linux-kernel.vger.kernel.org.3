Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15929563C3C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiGAWPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiGAWPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:15:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA42B2E688;
        Fri,  1 Jul 2022 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+D76cUt/nlXqM0vVhzfn41iJKsaZ1RveyORDM5a4vNo=; b=KnYynr/qgozANS3T/TpZM9Lyy8
        UDXuuIabRn9kanVRgXsHkyW4O5q07dIuobLlb7XdoIprbRBQG7ZQChORhtmE9XExTOx3I0rVkzskR
        lY1Pa3VqBqn78sJc3Og76CAbr8/J7giHn4kXxgEtaJobZQZOxxhFlKnyzfMxpc2zsPatykH4vppPR
        GhILSQzdrp34XT+CsWYsyr6GKiEzK2LYbktS8QLznloSMoHlyucBGRmPr1v+uK30VbtBfwxxyH3/h
        S/uSeIggOfQi1y/9NbwV6yJuJzpMll6WxuGfPJrrtrJiBxUMjcRTQk2ETqSrZmkEpr3kPEMAs4snx
        bJTNKYnw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o7OvI-007ApT-K8; Fri, 01 Jul 2022 22:15:36 +0000
Date:   Fri, 1 Jul 2022 15:15:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH v1] module: Add support for default value for module
 async_probe
Message-ID: <Yr9yCMsB1HJ1NEuF@bombadil.infradead.org>
References: <20220603055442.521888-1-saravanak@google.com>
 <YpoiWhMqANChE/ph@bombadil.infradead.org>
 <CAGETcx_BOGp_GpNqxjrW1rrmkLrS76Xfh6rUE0tKbd2nqUmDqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_BOGp_GpNqxjrW1rrmkLrS76Xfh6rUE0tKbd2nqUmDqg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 04:16:43PM -0700, Saravana Kannan wrote:
> On Fri, Jun 3, 2022 at 8:01 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Thu, Jun 02, 2022 at 10:54:41PM -0700, Saravana Kannan wrote:
> > > Add a module.async_probe kernel command line option that allows enabling
> > > async probing for all modules. When this command line option is used,
> > > there might still be some modules for which we want to explicitly force
> > > synchronous probing, so extend <modulename>.async_probe to take an
> > > optional bool input so that async probing can be disabled for a specific
> > > module.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++--
> > >  kernel/module/main.c                            | 11 ++++++++++-
> > >  2 files changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 710b52d87bdd..32083056bd25 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -1147,8 +1147,12 @@
> > >       nopku           [X86] Disable Memory Protection Keys CPU feature found
> > >                       in some Intel CPUs.
> > >
> > > -     <module>.async_probe [KNL]
> > > -                     Enable asynchronous probe on this module.
> > > +     <module>.async_probe[=<bool>] [KNL]
> > > +                     If no <bool> value is specified or if the value
> > > +                     specified is not a valid <bool>, enable asynchronous
> > > +                     probe on this module.  Otherwise, enable/disable
> > > +                     asynchronous probe on this module as indicated by the
> > > +                     <bool> value.
> >
> > The commit log says a bit more. Can you clarify this on the
> > documentation?
> 
> Oh yeah, forgot to add module.async_probe there! Will do.
> 
> > We should strive slowly towards more async probes. This will take
> > time.
> 
> Agreed.
> 
> > To help with further then a Kconfig option which sets this
> > to a default to true if enabled would be useful so that no kernel
> > parameter is needed at all to set the default. Then you can
> > override the default, and blacklist each driver as well.
> 
> Based on Linus's view in this thread [1] (I see his point), I don't
> think we'll ever enable default async probes for modules  as a compile
> time config. 

OK that's fair. But the position there was in reference to *not*
regress userspace.

If we have new tech we can do things differently if the expectation
is set from the beginning, ie if userspace *does* expect dependencies
to be dealt with differently. And systems which are old can be
deprecated with ACPI legacy flags.

> I think it has to be an explicit decision by whoever
> decides the list of modules being loaded in the system (OEMs in the
> case of Android, end user in the case of a PC?) to enable the default
> to be async probe and then the same entity can decide which modules to
> force sync probe on. So, I'm not sure we want to add a Kconfig for
> this or enable it by default. Let me know what you think. I'll send
> out a v2 with the doc fixes in the meantime.

Yeah makes sense.

> On a related note, I'm working on default async probes for built-in
> drivers,

Cool! I'm very excited to hear how that goes!

> but that's feasible to turn on by default because we can
> synchronize everything before we jump to init.

That's cheap, in that I think we can do better. Sure it works.

> And then
> <module>.async_probe needs to be passed explicitly for any modules we
> want to allow async on.

Sure..

  Luis
