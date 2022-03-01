Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574544C9390
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiCASvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCASvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:51:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD435EBCD;
        Tue,  1 Mar 2022 10:50:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D232E6146A;
        Tue,  1 Mar 2022 18:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E41C340EE;
        Tue,  1 Mar 2022 18:50:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="a+evMrWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646160652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3PMVbtvLhHr1hDGNFr00QQ/+FwMy0Zd4jDjPEhVH0pM=;
        b=a+evMrWy53P6L4cLxqbBeu0993AL3O2wbYMSz0tqyNO8uKic8cLDvfwrGII5ACChcFZjcn
        qLmDnxY8V7vGY0Luac9nvSXkkARgo0Gp7jHwxojqfQvKtQ99vMKDZJ+lukLX2wNtW6sy46
        BVj/PTvMMPpr2qPo1H7wBLRj3q8mTog=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 333cf56d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 18:50:52 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2dc0364d2ceso6321887b3.7;
        Tue, 01 Mar 2022 10:50:52 -0800 (PST)
X-Gm-Message-State: AOAM530wRJt9aKCF2wfi0tJkF9YJ8zpQeT60IvtpaWCHe/XqYH3gbp0Q
        57/ZS2ImDHZh2R1q8N2viYqwMGz2vsZ/Xlo0Kn8=
X-Google-Smtp-Source: ABdhPJwZvmvKwp5AV8nO7mdf3a9IzS927T1nwsby5QxU8TZb+HY088MhWCqN/PNu3LgCzi9FuyFwXy+r1xdlgcYUiIo=
X-Received: by 2002:a81:8984:0:b0:2db:6b04:be0c with SMTP id
 z126-20020a818984000000b002db6b04be0cmr13150588ywf.2.1646160651145; Tue, 01
 Mar 2022 10:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20220301173120.297105-1-Jason@zx2c4.com> <CAJZ5v0g+GihH_b9YvwuHzdrUVNGXOeabOznDC1vK6qLi8gtSTQ@mail.gmail.com>
 <CAHmME9o4Vu_rPqWkPYgD79perwqgL-f8hh1j7dWZQczBZD1dww@mail.gmail.com> <CAJZ5v0j+fCwdNHdQMZTzo0dvBh2KQHAb97dJq7XBZP=JY8yFQw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+fCwdNHdQMZTzo0dvBh2KQHAb97dJq7XBZP=JY8yFQw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Mar 2022 19:50:40 +0100
X-Gmail-Original-Message-ID: <CAHmME9q=Q7UMje1wtciLyUFV7tons+o7dQUPgTVD7SbJ-uEOYQ@mail.gmail.com>
Message-ID: <CAHmME9q=Q7UMje1wtciLyUFV7tons+o7dQUPgTVD7SbJ-uEOYQ@mail.gmail.com>
Subject: Re: [PATCH] PM: notify of PM_POST_VMFORK events from vmgenid
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 7:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 1, 2022 at 7:19 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hi Rafael,
> >
> > On Tue, Mar 1, 2022 at 6:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Mar 1, 2022 at 6:31 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > There's an additional virtual power state that various crypto-oriented
> > > > drivers may benefit from being notified of, such as WireGuard: right
> > > > after a virtual machine has forked. In WireGuard's case, the PM notifier
> > > > there that clears keys pre-suspend will be adjusted to also clear them
> > > > post-vmfork. This trivial commit wires up the machinery for that change,
> > > > which builds on the recently added vmgenid driver in the random.git
> > > > tree.
> > >
> > > Well, what does power management have to do with WireGuard'?
> >
> > I guess a bit more background would be in order. If I post a v2 of
> > this, I'll include that there. But for now:
> >
> > WireGuard has ephemeral session keys. They're not supposed to exist
> > for longer than a few minutes for a crypto property called "forward
> > secrecy". In order to ensure this, WireGuard currently registers a PM
> > notifier that fires before suspend/hibernate, which memzeros the
> > various keys. That's all well and fine and works.
> >
> > There's now another power-ish event that WireGuard also cares about:
> > when a virtual machine has been forked. In this case, too, the
> > reaction is the same - memzero the various keys, only for a different
> > reason: rather than forward secrecy, the property we want here is that
> > a key+nonce tuple is never used on more than one plaintext.
> >
> > The argument of this patchset is that VM forking is kind of like a
> > power event, so why not re-use the same notifier for that.
>
> IMV the problem with this approach is that WireGuard is not the only
> user of PM (suspend/hibernate) notifiers and the other users of them
> will have no idea about what to do with PM_POST_VMFORK which from
> their perspective has nothing to do with suspend and/or hibernation.
>
> > However, if you disagree, I could move ahead with a separate notification
> > mechanism not involving the PM notifier.
>
> Yes, please.

Will do. Sorry for the noise.
