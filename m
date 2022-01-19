Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16344937FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353470AbiASKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353440AbiASKLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:11:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE33C061574;
        Wed, 19 Jan 2022 02:11:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 594C461566;
        Wed, 19 Jan 2022 10:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764C0C340E7;
        Wed, 19 Jan 2022 10:11:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mUQ+s6q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642587089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rZmc8gDqgNsLlJyQwY9u8TazOCsbUcBCdP5ULRWI5FI=;
        b=mUQ+s6q9VJYV9dD6t4jt5v4YG8mcJrGjjBluSq0ZI4jMahXa35imbu6npbY6pXmkButnVJ
        NaEwiEdAgsTFXRJfJKvrWDepfEXri42HC5+rG3ESUqucZTrnuyDgbuIHlBHI+5R0BOLrhD
        Lg8nqUX1IkVGNWwujIPwZYgcvuUUlz8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3f1b0a6e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 19 Jan 2022 10:11:29 +0000 (UTC)
Received: by mail-yb1-f176.google.com with SMTP id c6so5874653ybk.3;
        Wed, 19 Jan 2022 02:11:28 -0800 (PST)
X-Gm-Message-State: AOAM5321XsQfS0l5nSZJ3C5IRoaa5wD+miIQ4pI0tdtfjpXURpJadxAr
        Xu+pHAweKKQPVCSLRvvn26nPULnf8MXp8S2awGU=
X-Google-Smtp-Source: ABdhPJzYRh6013NycZtQZQi8QTZFhJmw5Fmt733wofIXKSa0m6oYQxRC7J/azk1MKYt3b7DTFrEvpILYXH/l94r/js8=
X-Received: by 2002:a25:ef08:: with SMTP id g8mr4332927ybd.115.1642587086828;
 Wed, 19 Jan 2022 02:11:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:209:b0:11c:1b85:d007 with HTTP; Wed, 19 Jan 2022
 02:11:26 -0800 (PST)
In-Reply-To: <20220119100615.5059-1-miles.chen@mediatek.com>
References: <CAHmME9oX+4Ek81xy0nBOegqABH0xYqyONAqinsu7GZ7AaQaqYQ@mail.gmail.com>
 <20220119100615.5059-1-miles.chen@mediatek.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Jan 2022 11:11:26 +0100
X-Gmail-Original-Message-ID: <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
Message-ID: <CAHmME9pQcUxs87EwQwBZNDA4ZzqugTggH+uiNPh=mv5zjp3g3A@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     ardb@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org,
        herbert@gondor.apana.org.au, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

Okay. Keep me posted.

Just FYI, as mentioned, I'm unable to reproduce this, and you haven't
provided any further minimized guidance on how I might reproduce this,
so it'll sit in the "not a bug" bin until I have another clue on how
to reproduce. Alternatively, Nick and Nathan are now on this thread
and they usually have good luck teasing out compiler issues and such,
so maybe they'll have an idea. But I'm afraid with the information I
currently have, I'm at a dead end.

Jason
