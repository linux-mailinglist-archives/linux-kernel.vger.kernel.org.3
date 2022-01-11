Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C88E48AD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 13:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiAKM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 07:28:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55984 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiAKM2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 07:28:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24188B81A3E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E10FC36AEB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:28:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QP4GEnPm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641904127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiEZM+TuQkz/rWMmBuyvLomwMgK/T4Yumghh1pwQzxg=;
        b=QP4GEnPmdWAWjy8LTUhNN6ZoL/0Fj21YJG0Lp5z3iOMOkYt0B19Svicidbusl0Dw1d5mv0
        13eqf9GGrZKuQeAGiiXXd0zDbCVb+LsodQsnPwsl4MLdiXSPe2kKQ9LQOb9Bf6Q7Mujrxm
        0WoZ5bp7/xfCO7brfq/OQplNE3I26aM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e902b790 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jan 2022 12:28:47 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id p5so39526940ybd.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 04:28:47 -0800 (PST)
X-Gm-Message-State: AOAM530eMaepeiw2U23iaeB1d19xvHBgaYdwwm11Th5bowayUkVViCCA
        Li7a4bAFjlEX1Zs1DHPWxQEnojT40SdpDUPUVxE=
X-Google-Smtp-Source: ABdhPJz5XO05GsBBkjMQy7FM2NXVN7MwQz9XEnLQx4IDmAgFn3htclDHZ5HKefOJ3JJFbL8zjrGlt/Gn+XHKv95Rzqk=
X-Received: by 2002:a5b:10:: with SMTP id a16mr5788418ybp.115.1641904126664;
 Tue, 11 Jan 2022 04:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20211223141113.1240679-1-Jason@zx2c4.com> <20211223141113.1240679-2-Jason@zx2c4.com>
 <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
In-Reply-To: <CAMuHMdU0spv9X_wErkBBWQ9kV9f1zE_YNcu5nPbTG_64Lh_h0w@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Jan 2022 13:28:36 +0100
X-Gmail-Original-Message-ID: <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
Message-ID: <CAHmME9pZu-UvCK=uP-sxXL127BmbjmrD2=M7cNd9vHdJEsverw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] random: use BLAKE2s instead of SHA1 in extraction
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Tue, Jan 11, 2022 at 12:38 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Unfortunately we cannot get rid of the sha1 code yet (lib/sha1.o is
> built-in unconditionally), as there are other users...

I think that's just how things go and a price for progress. We're not
going to stick with sha1, and blake2s has some nice properties that we
certainly want. In the future hopefully this can decrease in other
ways based on other future improvements. But that's where we are now.

If you're really quite concerned about m68k code size, I can probably
do some things to reduce that. For example, blake2s256_hmac is only
used by wireguard and it could probably be made local there. And with
some trivial loop re-rolling, I can shave off another 2300 bytes. And
I bet I can find a few other things too. The question is: how
important is this to you?

Jason
