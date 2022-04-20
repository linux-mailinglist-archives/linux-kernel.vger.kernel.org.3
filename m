Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03F508D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380669AbiDTQk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355833AbiDTQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577F23C73E;
        Wed, 20 Apr 2022 09:37:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A3061A1D;
        Wed, 20 Apr 2022 16:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04565C385A4;
        Wed, 20 Apr 2022 16:37:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QqnanUkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650472657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k0T1EA0oTFWB7zpScDc5u9F5eGYrVS61Bm9+xdnYgX0=;
        b=QqnanUkRBBLncuZxPNmWSfNtfPXFl84sesxbV7XrayclHtmMZfcnPRDIV29uYP/MyRXSUP
        +VX44yck+8Gdiln34V0KfGFzbrsBS2eGgFl4VfqJvEnF2E9jtTvM308OB+LWgfRjFslMu/
        4sOBxeqR6smnWMzITL4xL5xD66qu+wM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 59b67bc1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 20 Apr 2022 16:37:37 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2eba37104a2so24775317b3.0;
        Wed, 20 Apr 2022 09:37:36 -0700 (PDT)
X-Gm-Message-State: AOAM532x7c8jGflRI8+YzsdgJviw9X/TRvQTdKjmr1jfG9CCq767NHpt
        l07qvJrdD/TR34pjWHOZErYFniwvMH+F9QbgCCg=
X-Google-Smtp-Source: ABdhPJw1SvYzkrJYtAOpmP0c/NPYhdogO4aqIhMujpMFmNuXwvbwsi3Rzp9fW35qmJrOrSfi1BqQQrRwoepzEO+xLoE=
X-Received: by 2002:a0d:c005:0:b0:2eb:d29d:8bf5 with SMTP id
 b5-20020a0dc005000000b002ebd29d8bf5mr23402744ywd.404.1650472655570; Wed, 20
 Apr 2022 09:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160407.1740458-1-Jason@zx2c4.com> <CAG48ez3amS6=omb8XVDEz9H2bk3MxTEK_XPjD=ZO-cXcDqz-cg@mail.gmail.com>
 <CAHmME9r7Vt1XFzceHhy7O67iVMhtpLJ-d0p8UGgV4Srd4Dt2Hg@mail.gmail.com>
 <CAG48ez2X72XkpxaEDmzykewreuhk8=5t5L5b2Qdr1dn8LcFutw@mail.gmail.com>
 <CAHmME9q+mDw6n3FNJLvoZoD3UsX-G5PvTwb5L7h_M9RFKNemSw@mail.gmail.com>
 <YmAJoGtqA3PMrZmD@zx2c4.com> <CAG48ez1F0P7Wnp=PGhiUej=u=8CSF6gpD9J=Oxxg0buFRqV1tA@mail.gmail.com>
In-Reply-To: <CAG48ez1F0P7Wnp=PGhiUej=u=8CSF6gpD9J=Oxxg0buFRqV1tA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 20 Apr 2022 18:37:23 +0200
X-Gmail-Original-Message-ID: <CAHmME9rAidi+KXBiOJyEfz+R2enGTSCK5Q2Xf2iH_MsW2_e_2g@mail.gmail.com>
Message-ID: <CAHmME9rAidi+KXBiOJyEfz+R2enGTSCK5Q2Xf2iH_MsW2_e_2g@mail.gmail.com>
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
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jann,

Ahh, gotcha, that makes sense. Either way, sounds like something to
fix in the sysctl proc API (option c) if possible...

Jason
