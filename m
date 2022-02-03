Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6544A7F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiBCGpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242665AbiBCGpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:45:16 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50569C06173B;
        Wed,  2 Feb 2022 22:45:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id me13so5303439ejb.12;
        Wed, 02 Feb 2022 22:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPWLqDuz3PhBYJuuaYmjOiGioBreRdhsii5ouL0ExTw=;
        b=fwHd0knwgMA5NM6XgplWstxJ4RU77bIq26BXf9amkhyOFPAP1E9JTo77O/SS2V3TWP
         2Y/I2kJHp4i3VNiFHDYtKxdwftMj1K+9rxLgAEF0vdrnuHpV4/oEcbGlQQf6D/8oP042
         rvjwsu8FvW9g4WnvuvpqPq2u4BTwkFQrVOkYApL3s5SkRM3IPZ+jKkK5lbzJW4bydBQM
         6pVLVGJFRjgl9Dx0G9XbVpD0zdjfZ1ukOqm0Mi4y+vJTJHVJgiZt4U4igqqKzdeQKlGP
         oTuL4X4TYJ4adI8UNS/S5QO/NpaL9jUU5MGszhanftP9LyVoXJ0Nv1tcOheQIGj6RE5R
         i2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPWLqDuz3PhBYJuuaYmjOiGioBreRdhsii5ouL0ExTw=;
        b=nP8Q2VWU5WQGhO0Vyd0qkxgZbfYqSdPFb2YwdVg5eEHauBrbguuqDN3Jk04EZu/ZKl
         vANtITYw1P/CToQ1I8lGM+h+rQS1cCmmw56SA0/04m0x2Quk2/n097I7UmKrU6sv+hSN
         XVyuzlapfRsIGhZ99F0uQAGKvBoKWdnH3zZRdck8oJ9PmvvXPsR/YM4Mkf70zhgJILQp
         7MTy0TVmgIQlTnxoyLBHUQRls/Q1smcHfiwoclm3tqmJ8d8SPOTmoKyjScm5ZfMj2TEL
         tYdQdR8r7OCLQ05XM4IcdfBH7oLY3e7cFb7qpXehufqRxOmO2nzAL2aGWjbwq/o5GTo8
         WxEw==
X-Gm-Message-State: AOAM5315c+40PMr3hUZbpLrOq6QFxLNLl6rLDFESPj5JoEn/HoT8B4qg
        jgHVkj5vqP0IyY6LJORI5/K6cV2XbGk1uB1Qslg=
X-Google-Smtp-Source: ABdhPJwtyQCwJhSQJkPu1a1GpN+5bxqo2ihPqbJhHyk4PTyhdzQqbXqxq7t85YpYwX0+lCpGKVrdwmtPIeOpvKFDq4o=
X-Received: by 2002:a17:907:7ba3:: with SMTP id ne35mr19546460ejc.128.1643870713812;
 Wed, 02 Feb 2022 22:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20220201161342.154666-1-Jason@zx2c4.com> <Yflyfk8BbGQvN3os@kroah.com>
In-Reply-To: <Yflyfk8BbGQvN3os@kroah.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Thu, 3 Feb 2022 14:45:00 +0800
Message-ID: <CACXcFmkWBKCHLoqHZXk3_aVY+U8Ct8ZfOCe2T0FS0SrFSeFsjw@mail.gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > Another aspect of the current mix_pool_bytes() function is that, while
> > its performance was arguably competitive for the time in which it was
> > created, it's no longer considered so. This patch improves performance
> > significantly: ...
...
> From a "this looks sane by reading the code" type of review here's my:
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I agree, it looks sane. & worthwhile.

Should we be concerned about relying too much on one piece of crypto,
though? Blake was derived from Chacha, which we already use in the
crng & we already use Blake in extract_buf().

Also, the Blake people now have Blake3 which they say is faster.
https://github.com/BLAKE3-team/BLAKE3
Why are we sticking with Blake2?

If overhead was the only objection to the current mixer, we
could probably speed it up some by eliminating indirection
as in my code below:

/***********************************************************
 * main function for mixing into input pool
 *
 * modified version of
 * mix_pool_bytes(struct entropy_store *r, const void *in, int nbytes)
 * from drivers/char/random.c
 *
 * always mix to input pool
 * (as do most or all calls in current driver)
 * so struct entropy_store *r is not needed
 * my version is
 * mix_to_input(const void *in, int nbytes)
 *
 * make things constants or globals wherever possible
 * instead of struct components
***********************************************************/

static u32 const twist_table[8] = {
    0x00000000, 0x3b6e20c8, 0x76dc4190, 0x4db26158,
    0xedb88320, 0xd6d6a3e8, 0x9b64c2b0, 0xa00ae278 };

#define tap1    104
#define tap2     76
#define tap3     51
#define tap4     25
#define tap5      1

#define wordmask    (INPUT_POOL_WORDS - 1)

/*
 * I see no initialisation of these in random.c
 * but initialise here anyway
 */
static int input_rotate = 1 ;
static int add_ptr = 3 ;

static void mix_to_input(const void *in, int nbytes)
{
        int i ;
        u32 w ;                    // __u32 in random.c
        const char *bytes = in;
        u32 *pool = input_pool.data ;

        spin_lock( &input_pool.lock ) ;

    i = add_ptr;

    /* mix one byte at a time to simplify size handling and churn faster */
    while (nbytes--) {
        w = rol32(*bytes, input_rotate);
                bytes++ ;

        i = (i - 1) & wordmask;

        /* XOR in the various taps */
        w ^= pool[i];
        w ^= pool[(i + tap1) & wordmask];
        w ^= pool[(i + tap2) & wordmask];
        w ^= pool[(i + tap3) & wordmask];
        w ^= pool[(i + tap4) & wordmask];
        w ^= pool[(i + tap5) & wordmask];

        /* Mix the result back in with a twist */
        pool[i] = (w >> 3) ^ twist_table[w & 7];

        /*
         * Normally, we add 7 bits of rotation to the pool.
         * At the beginning of the pool, add an extra 7 bits
         * rotation, so that successive passes spread the
         * input bits across the pool evenly.
         */
        input_rotate = (input_rotate + (i ? 7 : 14)) & 31;
    }
    add_ptr = i;

        spin_unlock( &input_pool.lock ) ;
}
