Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248E44C938E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiCASuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCASut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:50:49 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA3593A3;
        Tue,  1 Mar 2022 10:50:07 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2d07ae0b1c4so154992177b3.11;
        Tue, 01 Mar 2022 10:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFOUnJaNT7S8s2P0/5Z5ByV0p6iETlTm76+dPdZoFfw=;
        b=mQOqndGQU1Ma2g78mo5qT2uGNSQpwU8dW3aJ/LxrfG94rjUsxR1a9nkhu36qHqbYk/
         aVtfXqoIXCuk7haDWe3pzxLEA7s3orEBAieKubV+VQHuxRvF3ftv0Z5BrpALdp8XkvNa
         CalSYW/sTSebq7VZo81VA9Z8oEycIA+goprRRvID3p8cHk+vDffhspzclIOOTyw+W3hG
         tsazt7nUFVD4eaXW4vYBiYynGk6w6x7E90Pz0ontOkbPryP5lQfaeNAfvlcLX+hwMCux
         ne8o+ti9KhJuUKWS7SFWdNBE3D/eMIfmGP75spaGkiyeTFQPuHhBLgHnTFiGL0siIs6O
         Y6Bg==
X-Gm-Message-State: AOAM530AczsDi6X2o9f/zabqX0IWdmABtDst11Ft7qlrlOyJZME43c9Z
        RHstY1iysLhcB0N+krAcZFKHEhc9JXEWlo8jBAXfbgW2r9g=
X-Google-Smtp-Source: ABdhPJwxPnRnXRB6L+ThKzPw8aNwSGoWS9x5ro88N83WCkCovOVcU1q8nE1LtPfWZ1N1OoJTy45NN3wcaVcNIDR5Rfg=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr13735653ywb.326.1646160606847; Tue, 01
 Mar 2022 10:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20220301173120.297105-1-Jason@zx2c4.com> <CAJZ5v0g+GihH_b9YvwuHzdrUVNGXOeabOznDC1vK6qLi8gtSTQ@mail.gmail.com>
 <CAHmME9o4Vu_rPqWkPYgD79perwqgL-f8hh1j7dWZQczBZD1dww@mail.gmail.com>
In-Reply-To: <CAHmME9o4Vu_rPqWkPYgD79perwqgL-f8hh1j7dWZQczBZD1dww@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 19:49:55 +0100
Message-ID: <CAJZ5v0j+fCwdNHdQMZTzo0dvBh2KQHAb97dJq7XBZP=JY8yFQw@mail.gmail.com>
Subject: Re: [PATCH] PM: notify of PM_POST_VMFORK events from vmgenid
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 7:19 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Rafael,
>
> On Tue, Mar 1, 2022 at 6:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Mar 1, 2022 at 6:31 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > There's an additional virtual power state that various crypto-oriented
> > > drivers may benefit from being notified of, such as WireGuard: right
> > > after a virtual machine has forked. In WireGuard's case, the PM notifier
> > > there that clears keys pre-suspend will be adjusted to also clear them
> > > post-vmfork. This trivial commit wires up the machinery for that change,
> > > which builds on the recently added vmgenid driver in the random.git
> > > tree.
> >
> > Well, what does power management have to do with WireGuard'?
>
> I guess a bit more background would be in order. If I post a v2 of
> this, I'll include that there. But for now:
>
> WireGuard has ephemeral session keys. They're not supposed to exist
> for longer than a few minutes for a crypto property called "forward
> secrecy". In order to ensure this, WireGuard currently registers a PM
> notifier that fires before suspend/hibernate, which memzeros the
> various keys. That's all well and fine and works.
>
> There's now another power-ish event that WireGuard also cares about:
> when a virtual machine has been forked. In this case, too, the
> reaction is the same - memzero the various keys, only for a different
> reason: rather than forward secrecy, the property we want here is that
> a key+nonce tuple is never used on more than one plaintext.
>
> The argument of this patchset is that VM forking is kind of like a
> power event, so why not re-use the same notifier for that.

IMV the problem with this approach is that WireGuard is not the only
user of PM (suspend/hibernate) notifiers and the other users of them
will have no idea about what to do with PM_POST_VMFORK which from
their perspective has nothing to do with suspend and/or hibernation.

> However, if you disagree, I could move ahead with a separate notification
> mechanism not involving the PM notifier.

Yes, please.
