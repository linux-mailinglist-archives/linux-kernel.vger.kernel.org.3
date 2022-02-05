Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9348A4AA869
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352534AbiBELmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:42:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59746 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiBELmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:42:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D9F60C71;
        Sat,  5 Feb 2022 11:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF83FC340F1;
        Sat,  5 Feb 2022 11:42:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NlLvoTfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644061332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r3e1HBj6umTLKBV4Cgcv2IZJJyjKkK4ViVMyqUyHBHM=;
        b=NlLvoTfSl+auuMeqdNSMOAderY1DUQ7e7MUIvEF3zUICoQGPt4WHkHYXnXSiEBuGJHlIFE
        A+ngM9c2mnH/Muhx08dv3rQgd67hetFFYS6hLDgQwwpB61gB/BaGFcv75lo4sE0JHlgl8+
        3MLOpe1bdB2gMn3VmU1k1vKKRiWiKoU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1f2a0fe0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Feb 2022 11:42:11 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id v47so1316884ybi.4;
        Sat, 05 Feb 2022 03:42:11 -0800 (PST)
X-Gm-Message-State: AOAM533xpc2TKhDQhOUY7qXHjysJaBlxVy80dj09qjHESswZhUpxLCLy
        wcVPYl6Icqy4W402++cO4tGBL1Yu4fdW1Vk7jcU=
X-Google-Smtp-Source: ABdhPJyhU2wr8dszlkWySyqLobJ2hvFcAfqF2Yr939qD4qo0Y74omBRdhvPNLA/6OgnYI3r316iFQKcTO3dJLqP0Jwg=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr3115120ybj.32.1644061330628;
 Sat, 05 Feb 2022 03:42:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:6254:b0:129:4164:158b with HTTP; Sat, 5 Feb 2022
 03:42:09 -0800 (PST)
In-Reply-To: <Yf4z+Rc+69siZ0/N@owl.dominikbrodowski.net>
References: <20220204135325.8327-1-Jason@zx2c4.com> <20220204135325.8327-2-Jason@zx2c4.com>
 <Yf4z+Rc+69siZ0/N@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 5 Feb 2022 12:42:09 +0100
X-Gmail-Original-Message-ID: <CAHmME9pTDCUb7pAMeCMnU=jiAQd=ctrWN4K7s=8DqCtiOqbkrg@mail.gmail.com>
Message-ID: <CAHmME9pTDCUb7pAMeCMnU=jiAQd=ctrWN4K7s=8DqCtiOqbkrg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] random: use computational hash for entropy extraction
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/22, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> Why are we only using RDRAND here, and not RDSEED?

Simply because that's what was already used here; I didn't revisit the
old decision. It seems like any changes there should be made in a
separate patch with its own justification. If you think there's good
rationale, free to send that.

Part of why these changes are so gradual is because much of random.c
isn't my code originally. Were it mine, I'd presumably know all my
various rationales and be able to rapidly think within them and
reevaluate. But because that's not the case, I find that I'm spending
a lot of time trying to reconstruct the original rationales of its
authors. IOW, rather than saying, "I don't get this, must be bad," I'm
trying to do a little bit of archeology to at least make sure I know
what I'm disagreeing with, if I even disagree at all. That's time
consuming in part, but also is part of doing things evolutionarily.

With regards to RDRAND vs RDSEED, just off the top of my head -- I'm
writing this email on my phone -- I think extract_entropy/extract_buf
used to be used as part of /dev/random's blocking stream, which
ostensibly could mean more frequent calls, once every 10 bytes IIRC.
Nowadays it's only called once every 5 minutes (per numa node), so
maybe RDSEED could make sense? Or maybe there are other reasons to
unearth, or none at all. We'll have to look and see.

Jason
