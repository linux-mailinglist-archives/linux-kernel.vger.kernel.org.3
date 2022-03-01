Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F794C92CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiCASTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiCASTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:19:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C4340EA;
        Tue,  1 Mar 2022 10:19:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A94C6B8185A;
        Tue,  1 Mar 2022 18:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E482AC340F1;
        Tue,  1 Mar 2022 18:19:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RxrJYkzC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646158745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NT0zvjVYVbO2mmt1snDCsKM12Dh5I5u9ARx8MJFSbgw=;
        b=RxrJYkzC58vOnIf22+KTBCJ0W9YMXSbVySWx0+vrs+4V/93AaDYn2uaBiKbLIzdFhW3/cb
        3cvoQJ20x3vrMq3Gn9OSrWZ1aCirIzSSNQbC4B8Q6zhA4cSeXS6bt+rc5nhY/gCmO3F7g7
        WYNKbdq3+xq3opzgmQ6jTxpxmcIj7wQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 853ec57c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 1 Mar 2022 18:19:05 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id e186so4778429ybc.7;
        Tue, 01 Mar 2022 10:19:04 -0800 (PST)
X-Gm-Message-State: AOAM532/XIkLP9hVxxtVzNTS2kD3ChVWD1v0m9DTFYLjOcYRgIcMAUl8
        EgjlXYXSuZoDacJZFSxXsyVp/3INsNrWcSPRIZQ=
X-Google-Smtp-Source: ABdhPJwYdUV4NCDTB/e0oT9pWULPHNndr/bgMc1TjkQ7h+EjJjb86Whp55kIXzEasNGMIDRTjZH3hbuTQK5CdIjg69o=
X-Received: by 2002:a5b:d11:0:b0:623:fbda:40f4 with SMTP id
 y17-20020a5b0d11000000b00623fbda40f4mr25652445ybp.398.1646158744264; Tue, 01
 Mar 2022 10:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20220301173120.297105-1-Jason@zx2c4.com> <CAJZ5v0g+GihH_b9YvwuHzdrUVNGXOeabOznDC1vK6qLi8gtSTQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0g+GihH_b9YvwuHzdrUVNGXOeabOznDC1vK6qLi8gtSTQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Mar 2022 19:18:53 +0100
X-Gmail-Original-Message-ID: <CAHmME9o4Vu_rPqWkPYgD79perwqgL-f8hh1j7dWZQczBZD1dww@mail.gmail.com>
Message-ID: <CAHmME9o4Vu_rPqWkPYgD79perwqgL-f8hh1j7dWZQczBZD1dww@mail.gmail.com>
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

Hi Rafael,

On Tue, Mar 1, 2022 at 6:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 1, 2022 at 6:31 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > There's an additional virtual power state that various crypto-oriented
> > drivers may benefit from being notified of, such as WireGuard: right
> > after a virtual machine has forked. In WireGuard's case, the PM notifier
> > there that clears keys pre-suspend will be adjusted to also clear them
> > post-vmfork. This trivial commit wires up the machinery for that change,
> > which builds on the recently added vmgenid driver in the random.git
> > tree.
>
> Well, what does power management have to do with WireGuard'?

I guess a bit more background would be in order. If I post a v2 of
this, I'll include that there. But for now:

WireGuard has ephemeral session keys. They're not supposed to exist
for longer than a few minutes for a crypto property called "forward
secrecy". In order to ensure this, WireGuard currently registers a PM
notifier that fires before suspend/hibernate, which memzeros the
various keys. That's all well and fine and works.

There's now another power-ish event that WireGuard also cares about:
when a virtual machine has been forked. In this case, too, the
reaction is the same - memzero the various keys, only for a different
reason: rather than forward secrecy, the property we want here is that
a key+nonce tuple is never used on more than one plaintext.

The argument of this patchset is that VM forking is kind of like a
power event, so why not re-use the same notifier for that. However, if
you disagree, I could move ahead with a separate notification
mechanism not involving the PM notifier.

Jason
