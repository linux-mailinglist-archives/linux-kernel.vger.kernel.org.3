Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CE4A71AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbiBBNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:36:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230331AbiBBNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643808969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Y/tCcKryHNXOhXcpKvt9O1GxoDARflPECbDyG7zIOM=;
        b=Dse7gU8ebueedVq2h1lRJ7XZ2KEda75P28AaU7FVMJUhAsRuQIdy+9pYkmVp8I6MIzfD0i
        RMFevDSjRVlQ2NwL/2M0dh/8IB0GZ2bfeNkQtF84Yc3t95ZF7op/JNnHWVX7rFFnwPnMLl
        5k3D6j7+x3rJrPJdSQastCqnXECP2zs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-Gx2rU734MtmtTA29mqTfNQ-1; Wed, 02 Feb 2022 08:36:08 -0500
X-MC-Unique: Gx2rU734MtmtTA29mqTfNQ-1
Received: by mail-qt1-f197.google.com with SMTP id j30-20020ac84c9e000000b002cf986622d1so15479267qtv.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:36:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6Y/tCcKryHNXOhXcpKvt9O1GxoDARflPECbDyG7zIOM=;
        b=u/FoaRqWhwzjI3tRmPDjOdIFBgZ+ZTlCALm2CXgvwfSfyU6nQT4bz1QEi9l0Ps7AKv
         Od+HA5lciSp/lk+1K5Me/S1snzIaeAXMSvdqnHUkoqWScl0q3qCDE/KbRfu+EubCTwSQ
         o4w6nn5EkBlKiIwaQlNfX3Ilbk/4DdRS4Jn1j/+zAKFNdi4ty8QvwbOO1c6QjzWPgA1Y
         inc9RXbtA6jHBuB5dnP/U12K+eGkQOXOD7vGX8Vyq042S1EQ6eF+v6I27uAm+fxOFn42
         pCQZKty8ZcCpqtajlq/hynJ3WWXGR+cTuxjj2Z362/Z0sqU/wVIc7QoH7ItygJannXFb
         kq9g==
X-Gm-Message-State: AOAM5327PHTB3FErSVYQJC1P1kdk9/ZradZecKUSD9dQAwOX+yff3gKY
        2ijyGWcy3tTnL28P7/YY57mKI0MJyA/sXn8hOs0wKqFMVzXqfoHT9g8NvlhB9pIibjUQw7D8um4
        FfKvc+Ad23qtMCWmWZEnJfwAW
X-Received: by 2002:a05:6214:e63:: with SMTP id jz3mr26635023qvb.24.1643808967721;
        Wed, 02 Feb 2022 05:36:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiCnyRwi2H6w6JFHC4Wf9S8I+4E+HaEq5bvxXpGLRZuECjF5NxRRPczuDeTGlK9ad1s6vNFA==
X-Received: by 2002:a05:6214:e63:: with SMTP id jz3mr26635004qvb.24.1643808967488;
        Wed, 02 Feb 2022 05:36:07 -0800 (PST)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id s1sm4802575qkp.102.2022.02.02.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:36:07 -0800 (PST)
Message-ID: <daffe6272525376d955a4eaa73263a7f08634ac1.camel@redhat.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
From:   Simo Sorce <simo@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephan Mueller <smueller@chronox.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Date:   Wed, 02 Feb 2022 08:36:06 -0500
In-Reply-To: <CAHmME9ouMHtTQxB1WHq3H+nfbg27OFaJtw78E5epCJsiHt3sHg@mail.gmail.com>
References: <20220201161342.154666-1-Jason@zx2c4.com>
         <1920812.EuvsCRJjSr@tauon.chronox.de>
         <CAHmME9ouMHtTQxB1WHq3H+nfbg27OFaJtw78E5epCJsiHt3sHg@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason,
if the current code is mistakenly stretching the entropy, perhaps the
correct curse of action is to correct that mistake first, before
introducing a new conditioning function.
As it is, these patches cannot be say to just perform conditioning if
they are stretching the entropy, the risk is compounding errors and
voiding any reasonable analysis of the entropy carried through the RNG.

It would also be nice to have an explanation (in the patch or at least
the commit message) about how entropy is preserved and why a specific
function is cryptographically adequate. Note that there is no study
about using internal states of hash functions, it would be better to
base these decisions on solid ground by citing relevant research or
standards.

Thanks,
Simo.

On Wed, 2022-02-02 at 13:23 +0100, Jason A. Donenfeld wrote:
> Hi Stephan,
> 
> It's like this for a few reasons:
> 
> - Primarily, we want to feed 32 bytes back in after finalization (in
> this case as a PRF key), just as the code does before this patch, and
> return 32 bytes to the caller, and we don't want those to be relatable
> to each other after the seed is erased from the stack.
> - Actually, your statement isn't correct: _extract_entropy is called
> for 48 bytes at ~boot time, with the extra 16 bytes affecting the
> block and nonce positions of the chacha state. I'm not sure this is
> very sensible to do -- it really is not adding anything -- but I'd
> like to avoid changing multiple things at once, when these are better
> discussed and done separately. (I have a separate patch for something
> along those lines.)
> - Similarly, I'd like to avoid changing the general idea of what
> _extract_entropy does (the underscore version has never accounted for
> entropy counts), deferring anything like that, should it become
> necessary, to an additional patch, where again it can be discussed
> separately.
> - By deferring the RDRAND addition to the second phase, we avoid a
> potential compression call while the input pool lock is held, reducing
> our critical section.
> - HKDF-like constructions are well studied and understood in the model
> we're working in, so it forms a natural and somewhat boring fit for
> doing what we want to do.
> 
> Regards,
> Jason
> 

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc




