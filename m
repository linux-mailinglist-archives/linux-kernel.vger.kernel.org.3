Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB9A4AA396
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354422AbiBDWyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:54:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46390 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353907AbiBDWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:54:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84958B83957;
        Fri,  4 Feb 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FB8C004E1;
        Fri,  4 Feb 2022 22:54:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="F3xewLKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644015252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QxwkuLgPKcqsxzlJoEWQGZSMC8UnqMv4aAMgB0OnAPM=;
        b=F3xewLKMrJUKNLymDWNlunywkxhzWi9wNLR0nQVWd1mRbxzuVAtbMQ6AVHlJfcK+/7WPaN
        5U0uUZs7g/MyrHdyDrUGlpFvtxBQRAjxmkUGLfBFbBv99QrY+2Hq6Ku3Hsmio8GobMJvEG
        FlBBA1N191EtpCNUDZ43y8U9HceigVU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3f5cffff (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 4 Feb 2022 22:54:12 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id p5so22772580ybd.13;
        Fri, 04 Feb 2022 14:54:12 -0800 (PST)
X-Gm-Message-State: AOAM531+HNg94miKjRfygaktENHpcc9yiQ/vSRr3D1ymXjNZyZ9cPZ7c
        4pYr2iuRAEHlb+3GyhphSx9Upk5UCtqJ5IPAFxM=
X-Google-Smtp-Source: ABdhPJyg6qhfv7p/Cl3RpX4gPSi+5RfI90iNM+xYT+XdWVz832OsApbvQQHOCovDliZ7OM+dvEpMpVts81zM2f+eA3I=
X-Received: by 2002:a81:1084:: with SMTP id 126mr1259045ywq.231.1644015251136;
 Fri, 04 Feb 2022 14:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20220201161342.154666-1-Jason@zx2c4.com> <YfznyWaVCz3Yl1ma@sol.localdomain>
 <CAHmME9ppY5QY7QCXK1HapEUY9nOn3VSJgvddypmMj_CVfycPeQ@mail.gmail.com> <Yf2sJaxm3Nd5BUnr@sol.localdomain>
In-Reply-To: <Yf2sJaxm3Nd5BUnr@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 4 Feb 2022 23:53:59 +0100
X-Gmail-Original-Message-ID: <CAHmME9rEAsCz2N1eVFWsR4wZcSuDWqqgeJEvLuy2z4Ltrm=8wg@mail.gmail.com>
Message-ID: <CAHmME9rEAsCz2N1eVFWsR4wZcSuDWqqgeJEvLuy2z4Ltrm=8wg@mail.gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 11:43 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Feb 04, 2022 at 02:24:07PM +0100, Jason A. Donenfeld wrote:
> > > In the above comment, 'key' should be 'seed'.
> > > Likewise above.
> >
> > Caught this too right after sending. Fixed now for v2.
> >
>
> This wasn't actually fixed in v2.

Doh! Fixed for real now I promise. :)

Jason
