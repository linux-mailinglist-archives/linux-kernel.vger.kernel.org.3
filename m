Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7483495628
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347676AbiATVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiATVyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:54:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:54:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 803ECB81E66
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BFFC340E0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:54:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YGNRMuE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642715650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lokLTpWksCE0MydRUXeENjWpAFOTxKNvajfwP8CuTh8=;
        b=YGNRMuE158M0ux9u01cuEr6LKW9qIuFJ0++srrsz4KzcXoHsis11nyz6plg/XhwXe42z9U
        alZCUNVoJpUYXSZFrIRDYzpprmqrlN5f+PCYs2xOxQp4Q9TUpa2EGFTtwl76df3rrvT1pF
        wOkuTWsP2oItotKT2PfFPzXHPqO0qEA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ba7d6a91 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jan 2022 21:54:10 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id w5so1936360ilo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:54:09 -0800 (PST)
X-Gm-Message-State: AOAM532nEAwI33vhtE426TIZG2irn4U+rYH4UltSjgFQB/i7L0DTrrIx
        Ux1o9qO3ucUOhRezFV2Pa89qEneHl+2iLxKK2uU=
X-Google-Smtp-Source: ABdhPJwR5pYiHJ1PdesXQLdzVtSd28dV8G734VFr7Pnb5vCfH0Pok/e0PsTbTMuLhfeIbeP129/2WLZq3Tu7VM1Bu+M=
X-Received: by 2002:a05:6e02:160a:: with SMTP id t10mr579655ilu.82.1642715649293;
 Thu, 20 Jan 2022 13:54:09 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9pxJFBv-ZZ3bPMJdmxUO4oeY-wS4BtW34w1ncbeeU=MeA@mail.gmail.com>
 <20220120150734.509125-1-Jason@zx2c4.com> <Yemg2rWLqmYNzcDF@mit.edu>
In-Reply-To: <Yemg2rWLqmYNzcDF@mit.edu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 20 Jan 2022 22:53:58 +0100
X-Gmail-Original-Message-ID: <CAHmME9pDHLXUdovYNPkFzOVecPmyq_bKxW9MDB5WHrsHv_o_4g@mail.gmail.com>
Message-ID: <CAHmME9pDHLXUdovYNPkFzOVecPmyq_bKxW9MDB5WHrsHv_o_4g@mail.gmail.com>
Subject: Re: [PATCH] random: use named fields for adjusting chacha state
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ted,

On Thu, Jan 20, 2022 at 6:50 PM Theodore Ts'o <tytso@mit.edu> wrote:
> This change means that we're only initializing the key, but we're not
> initializing the counter/nonce (well, IV) value.  Could you fix this,
> please?

Right, as I mentioned in the commit message, this was the point. I'll
understand if you don't want to make this change, but the idea is that
indeed we make the nonce and counter values start at zero. This is
what's done in the original "fast key erasure" chacha rng [1,2] and
openbsd's arc4random [3]. And it seems sensible, in that we're not
really getting anything from having a 384-bit key over a 256-bit one.
It's not actually a meaningful reduction in security, and it
simplifies analysis by having the key rows used explicitly for keys
and the public rows used explicitly for public-ish values. It's always
scary to do seemingly _less_, and you could argue that these fields
are fine as input for a little additional pizzazz, so why not? If
that's your perspective, I can understand, and I'm not wedded to
changing it like this. On the other hand, if you agree it doesn't
change things cryptographically, and it simplifies the analysis, then
we can make the change. Either way works for me.

Jason

[1] http://blog.cr.yp.to/20170723-random.html
[2] https://github.com/jedisct1/supercop/blob/master/crypto_rng/chacha20/ref/rng.c
[3] https://github.com/openbsd/src/blob/master/lib/libc/crypt/arc4random.c
