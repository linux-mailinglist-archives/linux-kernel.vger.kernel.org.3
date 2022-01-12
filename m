Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C648C598
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbiALOFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:05:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43914 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353989AbiALOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:05:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FBBE6123A;
        Wed, 12 Jan 2022 14:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664A4C36AEA;
        Wed, 12 Jan 2022 14:05:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TTQd4tcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641996336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2Onz98c+33+SDzjnajzIgrO/ZHgm9HXNCXoG5KboUk=;
        b=TTQd4tcrhmezqnVhlpvOnr9kcn7P3fAVbx/pO0J0grvtGhYLUs3CbRXWujnCvnErbKMGW6
        Wyq+NeuLONXq4wwfCFu9ZENOYDHJ94fI99lr5yBoOF2o7Hi7odDW8zOo3QN6Vt0Mfgm4OR
        KDx3XmPgq7C/C1QuZ/bYwuCyhHmlf+0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eceb28fd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 12 Jan 2022 14:05:36 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id c10so6714539ybb.2;
        Wed, 12 Jan 2022 06:05:36 -0800 (PST)
X-Gm-Message-State: AOAM531jf1Yu7CM21XcHwtT4y0wr65G4oCu48BrNEDU8l92k56+WFDU2
        gsGgRxxpmeJgHWuOYZc2ij0+hblZb1vT87yHjkg=
X-Google-Smtp-Source: ABdhPJzay9qb9mCewfSQngccVDC+2AePoYkiOhkebHRX2mcSgbGmPEXQ/2AeRLpPEHg/3ndaeZJqOgUmtAHqwJ+thmQ=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr13228018ybe.32.1641996334980;
 Wed, 12 Jan 2022 06:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20220111195309.634965-1-jforbes@fedoraproject.org>
 <CAHmME9pi1Y7urg1VQeCi7L6MxHRUk5g4wc6VKDywo4yPh9h_6w@mail.gmail.com>
 <CAMj1kXH24ubv7yAqmbnzqe22cGh1L0-N8J6fiCT2NgU2HmeBJw@mail.gmail.com>
 <CAHmME9qXg3_HdnDwN-LOBJQhxz4acYCjgQhXRovQ6-9TWwHwWQ@mail.gmail.com>
 <CAMj1kXFybcnneHwpvKYNnK0F3t48kqDpV-RKLgR1A+w4QbUxTg@mail.gmail.com>
 <CAFxkdAoC_Ap7YWqE5PLXczfk9YivuWPk5K303DuTuj9B8keERg@mail.gmail.com> <CAHmME9o+J_xPWBXAmFPAubO08Un-7vhXf5uJn2Zj8hoYu9NyfQ@mail.gmail.com>
In-Reply-To: <CAHmME9o+J_xPWBXAmFPAubO08Un-7vhXf5uJn2Zj8hoYu9NyfQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 12 Jan 2022 15:05:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9rb-QNnEKnuw5ELtA_UuxmVar1UTuO6VJKTE=T-xqFTvw@mail.gmail.com>
Message-ID: <CAHmME9rb-QNnEKnuw5ELtA_UuxmVar1UTuO6VJKTE=T-xqFTvw@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: add prompts back to crypto libraries
To:     Justin Forbes <jmforbes@linuxtx.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 2:59 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> I think I've actually got a patch for the root problem here. Testing
> now and it should be out shortly.

Actually, scratch that, it's a lot harder than I anticipated. I just
saw your v2. Let's roll with that. Sent you a note there for a v3.

Jason
