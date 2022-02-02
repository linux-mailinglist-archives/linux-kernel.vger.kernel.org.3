Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5310A4A72BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbiBBOLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiBBOLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:11:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F101C061714;
        Wed,  2 Feb 2022 06:11:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DCAE61852;
        Wed,  2 Feb 2022 14:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0B5C340F1;
        Wed,  2 Feb 2022 14:11:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nec8bwHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1643811070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c5JjIYoKEKHglVHkMzu3VOgQtecCefZTnqMsNwFtP0k=;
        b=nec8bwHUWMgNyJGomQASFqfhaMOd8zL2rG9/gjzbj/dJ262XY9q27kuD/WX8CoOId2mA3A
        IjUOuUtFq2JuO7Z0vpcnVL3N9rCIe1sCbOeRRiV7uMY/Ae7uwNFnhfRpWBC+fvC9rw1PRz
        AlWwUAv75NJW4TvbbV0WKd1U+lTxglg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 29e0e4f8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 2 Feb 2022 14:11:09 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id w81so39108891ybg.12;
        Wed, 02 Feb 2022 06:11:09 -0800 (PST)
X-Gm-Message-State: AOAM533snHGRzaGhO7pViYV86RP1gZb8q7jJbvgUeceYsmBiNJ0AdgXg
        11iClzC+uQm2BmmeXIjWRoCmOcxWzKBweErJGW0=
X-Google-Smtp-Source: ABdhPJx+QdZ/n8pLp7rKbfmJ1K0BLHYaT7l24mXD1xR3rwzzbyNRi3RHuX0fD0BKjc8AZQQnh5M2nSVFbp4GmF0U7Rs=
X-Received: by 2002:a25:c006:: with SMTP id c6mr41866622ybf.457.1643811068149;
 Wed, 02 Feb 2022 06:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20220201161342.154666-1-Jason@zx2c4.com> <1920812.EuvsCRJjSr@tauon.chronox.de>
 <CAHmME9ouMHtTQxB1WHq3H+nfbg27OFaJtw78E5epCJsiHt3sHg@mail.gmail.com> <daffe6272525376d955a4eaa73263a7f08634ac1.camel@redhat.com>
In-Reply-To: <daffe6272525376d955a4eaa73263a7f08634ac1.camel@redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 2 Feb 2022 15:10:57 +0100
X-Gmail-Original-Message-ID: <CAHmME9ohMLtfBgF752XCq-EOk5SRGcNkf-vf1oawXEkz9iOTtw@mail.gmail.com>
Message-ID: <CAHmME9ohMLtfBgF752XCq-EOk5SRGcNkf-vf1oawXEkz9iOTtw@mail.gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
To:     Simo Sorce <simo@redhat.com>
Cc:     Stephan Mueller <smueller@chronox.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simo,

Your message makes no sense to me.

> Note that there is no study
> about using internal states of hash functions, it would be better to

Ignoring your probably wrong mention about "no study", we're not
making any use of "internal states". We're using the hash function off
the shelf without modifications. There's no whacky bespoke crypto
going on, no use of "internal states", nothing that matches your
description.

> if the current code is mistakenly stretching the entropy, perhaps the
> correct curse of action

Except it's not. The non-underscore version calls into account(), and
returns false when it's not sufficiently full. I'm also not sure it
matters in the way you think it does; perhaps you could clarify what
you mean by "mistakenly stretching the entropy" and what you think
this enables.

> they are stretching the entropy, the risk is compounding errors and

Compounding errors? This doesn't make any sense.

> It would also be nice to have an explanation (in the patch or at least
> the commit message) about how entropy is preserved

That iterative hashing serves as a good entropy accumulator is
rigorously shown in the paper that the commit message references.

And either way, we never reseed the crng with more than 32 bytes, so
what's happening here is rather boring.

Thanks,
Jason
