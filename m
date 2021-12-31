Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA634823AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhLaLbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:31:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34792 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhLaLbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:31:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 013016175D;
        Fri, 31 Dec 2021 11:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2C1C36AEA;
        Fri, 31 Dec 2021 11:31:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CmyVLuUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640950295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bG16Sx/rFUWLFAduoTxKdTK55ZW+sW+5u57q+BYjnsM=;
        b=CmyVLuUCqyvpx0/XOTLhHA811Cvy8Dq/EIWB54aYb04k8zdTj7ukuQvG78o1He9GXkoQ1c
        6Bza0V/jakOyppk7NFE8IU9JmFNSgaG9T4+d9VDIFAt7Y2glzdBRJFU2B+sAE1UDSZMPTw
        pDzu5X/o3kq7nd2TnOupMIY5uV8ajPs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b3e5181c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 31 Dec 2021 11:31:34 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id d1so59069830ybh.6;
        Fri, 31 Dec 2021 03:31:34 -0800 (PST)
X-Gm-Message-State: AOAM533Q1KsVPNI4rKdqBvkF/QgYcFo7RJIztfQMuKCdkjfnGru3JLfS
        GWiWqDX9PZmWQ28UJBQnAgUhpoSEqA0bfl+0Eag=
X-Google-Smtp-Source: ABdhPJxIaZtLL/5kN5yybMhjkc7+SQZ0NG6cXQNO6BiXbNOTj7Xo2/9Q4jUo9Zut1KI18sY328RFMwnN6vLRCBEVGZI=
X-Received: by 2002:a25:a427:: with SMTP id f36mr41924649ybi.245.1640950294019;
 Fri, 31 Dec 2021 03:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20211231082608.171839-1-linux@dominikbrodowski.net>
In-Reply-To: <20211231082608.171839-1-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 31 Dec 2021 12:31:23 +0100
X-Gmail-Original-Message-ID: <CAHmME9rH1cHwPhf-mSyD7sas3rBHhYPDd1CvG+68Vw1piRR6QA@mail.gmail.com>
Message-ID: <CAHmME9rH1cHwPhf-mSyD7sas3rBHhYPDd1CvG+68Vw1piRR6QA@mail.gmail.com>
Subject: Re: [PATCH v2] random: early initialization of ChaCha constants
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, looks good. I tried briefly to break it with the following
assertion thing, but didn't come up with any hits, so it looks like
we're all set. Prior to applying this patch, I found the easiest way
of triggering the below crash was by enabling
CONFIG_SLAB_FREELIST_RANDOM.

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 4de0feb69781..0d9ac045943f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1035,6 +1035,10 @@ static void _extract_crng(struct crng_state *crng,
  spin_lock_irqsave(&crng->lock, flags);
  if (arch_get_random_long(&v))
  crng->state[14] ^= v;
+ BUG_ON(crng->state[0] != CHACHA_CONSTANT_EXPA);
+ BUG_ON(crng->state[1] != CHACHA_CONSTANT_ND_3);
+ BUG_ON(crng->state[2] != CHACHA_CONSTANT_2_BY);
+ BUG_ON(crng->state[3] != CHACHA_CONSTANT_TE_K);
  chacha20_block(&crng->state[0], out);
  if (crng->state[12] == 0)
  crng->state[13]++;
