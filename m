Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5620C5075C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355572AbiDSQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354857AbiDSQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861923BF4;
        Tue, 19 Apr 2022 09:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98FD361828;
        Tue, 19 Apr 2022 16:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B24C385AB;
        Tue, 19 Apr 2022 16:42:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="APjJnJG5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650386541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DbYOZGBq5KrFSwlc2YV1AKjCLUSH+OPRXx+/9nV6IJU=;
        b=APjJnJG5C0iabYt25SXnu9XyX6Tl7POtgqLfznlID6gfQpXRhwILH3jdFqM3K6qgNwZbUu
        hBaSI9xDuGqxJtNXgZ5mLGIP1Jlo1CqTIpFMBbpaR8u2U/owGKAGYbl1gfRQ+iuFkgE5oT
        +hdjJOuuH+bNZPVDHBT5tXrf3hmT/Tc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b5041d5f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 19 Apr 2022 16:42:21 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ec42eae76bso178725127b3.10;
        Tue, 19 Apr 2022 09:42:20 -0700 (PDT)
X-Gm-Message-State: AOAM533c40SrPq6+YxxkrQq5zSnRusQYyvyASfnTVzC8Eow7PmcBTtKk
        TpdGYcsp0MxKfxXYmQaC/gfkScDeSwTo7FSBhn0=
X-Google-Smtp-Source: ABdhPJwfGxSUNuIrFeX1GBvrPtyXTqhnRgzjLKBthgOJFOXlJ/13XNneWEON3yCcwy6xO9WOOQJsc4Kr24WZhjo09F4=
X-Received: by 2002:a81:1d4:0:b0:2eb:1b10:f43e with SMTP id
 203-20020a8101d4000000b002eb1b10f43emr16846705ywb.100.1650386539906; Tue, 19
 Apr 2022 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160407.1740458-1-Jason@zx2c4.com> <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
In-Reply-To: <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Apr 2022 18:42:09 +0200
X-Gmail-Original-Message-ID: <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com>
Message-ID: <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com>
Subject: Re: [PATCH] random: add fork_event sysctl for polling VM forks
To:     Jann Horn <jannh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>
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

Hey Jann,

On Tue, Apr 19, 2022 at 6:38 PM Jann Horn <jannh@google.com> wrote:
> This is a bit of a weird API, because normally .poll is supposed to be
> level-triggered rather than edge-triggered... and AFAIK things like
> epoll also kinda assume that ->poll() doesn't modify state (but that
> only _really_ matters in weird cases). But at the same time, it looks
> like the existing proc_sys_poll() already goes against that? So I
> don't know what the right thing to do there is...

Doesn't the level vs edge distinction apply to POLLIN/POLLOUT events?
In this case, the event generated is actually POLLERR. On one hand,
this is sort of weird. On the other hand, it perhaps makes sense,
since nothing changes respect to its readability/writeability. And it
also happens to be how the sysctl poll() infrastructure was designed;
I didn't need to change anything for this behavior, and it comes as a
result of this rather trivial commit only. Looking at where else it's
used, it appears to be the intended use case for changes to
hostname/domainname. So while it's unusual, it also appears to be the
usual way that sysctl poll() works. So perhaps we're quite lucky here
in that sysctl poll() winds up being the correct interface for what we
want?

Jason
