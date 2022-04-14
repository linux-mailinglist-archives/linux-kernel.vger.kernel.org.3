Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3572150193F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiDNQ6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiDNQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A6D14B856
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:31:07 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id b188so5925168oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8L5e1xKbydF7d2L0TADvbJn6wqVOYq7/kZpJYa2SRw=;
        b=AFJ0ednJxVwEVa8ibNzKw/zNCLJmlAKPerqWu/u+AY66jzOv4zx/Oesal+C140g0H0
         SuB4t0aZsJKwV7aL4NCyotrpd2DhcWfCCAdG0BvTPA5/fVu/bLyZqerILW1RprlCifdD
         qLqxjtAHsRLIYO4nB3X5MjYmJNtkw1UEHcxWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8L5e1xKbydF7d2L0TADvbJn6wqVOYq7/kZpJYa2SRw=;
        b=MlMjrJ75MH+wObXbu60eG6Kb7vT8V74LBOlmiOl3POzVFxsYvnJqAeF34nJJkQnpNW
         44c/TFCgu4GZOiDcDswB26cUKp9j9uhSs7P5izWfPpFk3Tfeki9hyqz+Rxeh2jJx8FJx
         127sYvR93DJGQqtyeE4PCZ8FE9xWu/D2Q21KAdzpknsuVEJp01aFWtPmy3T6meB9d6UG
         mGICvHn8gYIb8ExRpBp2hhdTgLvMcIR+TL7+2Y9ashkg3Dm/6ri9PSBIRZdzKibbk12R
         ApzkaOSeF8XrN8ZI9qwkS6Jjv3/ibxPYpyVbFzsnHlcMcoD9IayCM/4LC01wbzs8Y6bE
         VHTQ==
X-Gm-Message-State: AOAM533zhYFjHhsiVBI5PWIbt1UKG8+Qo3NlRb1UHzHY+KfdaMhKCNrk
        h0MYthqdGz8gi25TTaDR6kuamRHApnvuJg==
X-Google-Smtp-Source: ABdhPJwkrmZEM1yq4ZxzD3/nSKjdSA+/kHGiDSf7f6Na7EoPK7vMaoO1XDmx+sZXRnOHJQ5wUJOvrw==
X-Received: by 2002:a05:6808:1a2a:b0:2fa:6517:6510 with SMTP id bk42-20020a0568081a2a00b002fa65176510mr1745272oib.152.1649953866142;
        Thu, 14 Apr 2022 09:31:06 -0700 (PDT)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com. [209.85.160.42])
        by smtp.gmail.com with ESMTPSA id ed22-20020a056870b79600b000da32eab691sm811364oab.23.2022.04.14.09.31.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 09:31:04 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e2afb80550so5810387fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:31:03 -0700 (PDT)
X-Received: by 2002:a05:6870:f295:b0:e1:ea02:2001 with SMTP id
 u21-20020a056870f29500b000e1ea022001mr1597770oap.241.1649953863199; Thu, 14
 Apr 2022 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220407115918.1.I8226c7fdae88329ef70957b96a39b346c69a914e@changeid>
 <YlBGvFFSp/R2CBmh@rowland.harvard.edu> <CAE=gft7Zi9tpJ74Tf2iqPRbwJkmSLiKJt-WhwD+h-DxQh75D6g@mail.gmail.com>
 <YlDoSY19HYNJGI50@rowland.harvard.edu> <022a50ac-7866-2140-1b40-776255f3a036@linux.intel.com>
 <YlRATrMxRWt9gVqt@rowland.harvard.edu> <4353a956-9855-9c14-7dbf-bf16580abe32@linux.intel.com>
 <YlWdfWRXYjkfHLIP@rowland.harvard.edu> <b1df80e4-af6a-e84f-f49d-c74500bdec05@linux.intel.com>
 <Ylgt8Y7Mz4nOAhtv@rowland.harvard.edu>
In-Reply-To: <Ylgt8Y7Mz4nOAhtv@rowland.harvard.edu>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 14 Apr 2022 09:30:26 -0700
X-Gmail-Original-Message-ID: <CAE=gft7fvjUX7SdjubHBpd=v3abQ=gJrhM-Oc_RxxqSkoG6mSA@mail.gmail.com>
Message-ID: <CAE=gft7fvjUX7SdjubHBpd=v3abQ=gJrhM-Oc_RxxqSkoG6mSA@mail.gmail.com>
Subject: Re: [PATCH] USB: hcd-pci: Fully suspend across freeze/thaw cycle
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Youngjin Jang <yj84.jang@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan and Mathias,

On Thu, Apr 14, 2022 at 7:21 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, Apr 14, 2022 at 05:00:12PM +0300, Mathias Nyman wrote:
> > On 12.4.2022 18.40, Alan Stern wrote:
> > > On Tue, Apr 12, 2022 at 05:56:42PM +0300, Mathias Nyman wrote:
> > >> On 11.4.2022 17.50, Alan Stern wrote:
> > >>> For example, what would happen if the user unplugs a device right in the
> > >>> middle of the freeze transition, after the root hub has been frozen but
> > >>> before the controller is frozen?  We don't want such an unplug event to
> > >>> prevent the system from going into hibernation -- especially if the root
> > >>> hub was not enabled for wakeup.
> > >>
> > >> We should be able to let system go to hibernate even if we get a disconnect
> > >> interrupt between roothub and host controller freeze.
> > >> Host is not yet suspended so no PME# wake is generated, only an interrupt.
> > >>
> > >> From Linux PM point of view it should be ok as well as the actual xhci
> > >> device that is generating the interrupt is hasnt completer freeze()
> > >>
> > >> The xhci interrupt handler just needs to make sure that the disconnect
> > >> isn't propagated if roothub is suspended and wake on disconnect
> > >> is not set. And definitely make sure xhci doesn't start roothub polling.
> > >>
> > >> When freeze() is called for the host we should prevent the host from
> > >> generating interrupts.
> > >
> > > I guess that means adding a new callback.  Or we could just suspend the
> > > controller, like Evan proposed originally
> >
> > Suspending the host in freeze should work.
> > It will do an extra xhci controller state save stage, but that should be harmless.
> >
> > But is there really a need for the suggested noirq part?
> >
> > +     .freeze_noirq   = hcd_pci_suspend_noirq,
> >
> > That will try to set the host to PCI D3 state.
> > It seems a bit unnecessary for freeze.
>
> Agreed.
>
> > >>> (If the root hub _is_ enabled for wakeup then it's questionable.
> > >>> Unplugging a device would be a wakeup event, so you could easily argue
> > >>> that it _should_ prevent the system from going into hibernation.  After
> > >>> all, if the unplug happened a few milliseconds later, after the system
> > >>> had fully gone into hibernation, then it would cause the system to wake
> > >>> up.)
> > >>>
> > >>>> Would it make sense prevent xHCI interrupt generation in the host
> > >>>> freeze() stage, clearing the xHCI EINT bit in addition to calling
> > >>>> check_roothub_suspend()?
> > >>>> Then enable it back in thaw()
> > >>>
> > >>> That won't fully eliminate the problem mentioned in the preceding
> > >>> paragraphs, although I guess it would help somewhat.
> > >>
> > >> Would the following steps solve this?
> > >>
> > >> 1. Disable device initiated resume for connected usb devices in freeze()
> > >>
> > >> 2. Don't propagate connect or OC changes if roothub is suspended and port wake
> > >>    flags are disabled. I.E don't kick roothub polling in xhci interrupt
> > >>    handler here.
> > >
> > > I guess you can't just halt the entire host controller when only one of
> > > the root hubs is suspended with wakeup disabled.  That does complicate
> > > things.  But you could halt it as soon as both of the root hubs are
> > > frozen.  Wouldn't that prevent interrupt generation?
> >
> > True, but probably easier to just suspend host in freeze() as you stated above.
>
> Okay.
>
> Evan, this discussion suggests that you rewrite your patch as a series
> of three:
>
>      1. Change choose_wakeup() so that for PM_EVENT_FREEZE, wakeup is
>         always disabled.

If I understand this correctly, this means potentially runtime
resuming the device so its wakeup setting can be consistently set to
wakeups disabled across a freeze transition. Got it I think in terms
of the "how".

>
>      2. Change the xhci-hcd interrupt handler so that port-status
>         changes are ignored if the port's root hub is suspended with
>         wakeup disabled.

This part confuses me. This would be way deep under
xhci_handle_event(), probably in handle_port_status(), just throwing
away certain events that come in the ring. How would we know to go
back and process those events later? I think we don't need to do this
if we suspend the controller as in #3 below. The suspended (halted)
controller wouldn't generate event interrupts (since the spec mentions
port status change generation is gated on HCHalted). So we're already
covered against receiving interrupts in this zone by halting the
controller, and the events stay nicely pending for when we restart it
in thaw.

Is the goal of #1 purely a setup change for #2, or does it stand on
its own even if we nixed #2? Said differently, is #1 trying to ensure
that wake signaling doesn't occur at all between freeze and thaw, even
when the controller is suspended and guaranteed not to generate
interrupts via its "normal" mechanism? I don't have a crisp mental
picture of how the wake signaling works, but if the controller wake
mechanism sidesteps the original problem of sending an MSI to a dead
CPU (as in, it does not use MSIs), then it might be ok as-is.

>
>      3. As in the original patch, make the .freeze and .thaw callbacks
>         in hcd-pci.c call the appropriate suspend and resume routines,
>         but don't do anything for .freeze_noirq and .thaw_noirq.

Sure. I had made the _noirq paths match suspend for consistency, I
wasn't sure if those could mix n match without issues. I'll try it out
leaving the _noirq callbacks alone.
-Evan

>
> How does that sound?
>
> Alan Stern
