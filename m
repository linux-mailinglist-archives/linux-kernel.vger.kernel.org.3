Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F674AA917
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379965AbiBENRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:17:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58860 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379954AbiBENRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:17:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BB69B808BB;
        Sat,  5 Feb 2022 13:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EF8C340EF;
        Sat,  5 Feb 2022 13:17:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OvVBurtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644067047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxOIS5kX5iDZVwGwgniinnXsxnK0a00u8oGEMpWVZK4=;
        b=OvVBurtP0SjIsrQfCUdgLq8Oq5xWiSFrGIo7g4MBJ38YhoFf3NgNxqHUkgLl+aP6zct+oe
        3FnBU4sfK3OIYSHut3JyzzVsee8ZDJLEZQKJAliKkDIp3bUB+qUIYfK5Z112wfvUGeP5Nf
        n8FfI/IwAOZ1fm3odvTSgT4M6OfFb6A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 138ddda6 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 5 Feb 2022 13:17:27 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id v47so1873358ybi.4;
        Sat, 05 Feb 2022 05:17:26 -0800 (PST)
X-Gm-Message-State: AOAM533A1XHqw6X92Oungt/Opd3nJqv+6efEzB8xOG6U25ugx7EnuPJD
        Iavzvej0Nqo+x5x+059cQ40sQNJDFgMMKh5Fmns=
X-Google-Smtp-Source: ABdhPJxLE2UUZ+xJLEuCI+8R/QFuVT/T9l9JXO4lk42BPaYTq8udZQS2ipCphutbg+yPLaB9gcV4eMcSFFdsn13Iuv0=
X-Received: by 2002:a25:ba49:: with SMTP id z9mr3403522ybj.32.1644067045981;
 Sat, 05 Feb 2022 05:17:25 -0800 (PST)
MIME-Version: 1.0
References: <20220205103458.133386-1-linux@dominikbrodowski.net> <20220205103458.133386-2-linux@dominikbrodowski.net>
In-Reply-To: <20220205103458.133386-2-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 5 Feb 2022 14:17:15 +0100
X-Gmail-Original-Message-ID: <CAHmME9rsDkn=qRacYbZFjni5FF6G2dn+KOELr-agPhmH7ved0g@mail.gmail.com>
Message-ID: <CAHmME9rsDkn=qRacYbZFjni5FF6G2dn+KOELr-agPhmH7ved0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] random: fix locking in crng_fast_load()
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

Does this introduce a lock nesting inversion situation?

With your patch, crng_fast_load() now does:

    lock(primary_crng)
    invalidate_batched_entropy()
        lock(batch_lock)
        unlock(batch_lock)
    unlock(primary_crng)

While get_random_{u32,u64}() does:

    lock(batch_lock)
    extract_crng()
       lock(primary_crng)
       unlock(primary_crng)
    unlock(batch_lock)

Is this correct? If so, we might have to defer this patch until after
<https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=2dfab1b1>
or something like it lands, which attempts to get rid of the batched
entropy lock.

If that analysis seems right to you, I could pull this patch into that
development branch for poking and prodding.

Jason
