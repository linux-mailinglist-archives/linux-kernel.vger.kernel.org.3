Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F944F7EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiDGMLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiDGMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:11:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5A1017E0;
        Thu,  7 Apr 2022 05:09:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k2so6129559edj.9;
        Thu, 07 Apr 2022 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=48DPePUYeyEwdbAHaYGxh409PflykhIhQcraUAIMxpY=;
        b=gZ/W139f5QyNs8aJNtETI6BzNJyv1a58fLCc4VjSp9brXwn8ri0Y57Mgjr2/dqhwQs
         ak74uKPa1L4BplgpckKopeYeL5j74tKIq4nmgZxYXCzq5xdDhzc3bu2BpzEiNqoC6Y7j
         70EXK3r20OG3dvMS+epr7WxHAZiVOX14zEB4FIsqXlqZyljPf9iQQdVjwy/rrR6rE3hl
         jrRGRxPbyK3FVThRM0ypZafRTZxUqC66Kev3LNW9vhGpDxHVJ6z0GjlwHq3rWdfa3zxw
         IgfORrH8uaP+zYPfNtIrrf4uOuknK0rNQOXmkCq3KEu0ZOHhpcW+dMpItb0YDgy9o0ct
         aDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=48DPePUYeyEwdbAHaYGxh409PflykhIhQcraUAIMxpY=;
        b=EfACKPfVdj2o68tWYuaKfDNYpDNuMDTCzdxh3bwGg1KSBvSGIIKAgSjhl6CiW6onNg
         E/AUhaTSfjn5DMlcK73pp5uzL/aEpPSa6Sol2LbSasUrCLTIM/kGmbYiTUjWPvCFfMbP
         vyf2TASCJ9Y2X4n91UFZmueAzK2CmwZA3007LDM/9SQj17KPTftCTh8fZ1oGqLW9/ueB
         IGzhzaoma4Seu+YBe6o1xUV4rEIW3HeTtoDAn2FevMY96F+Cz4gMUJ9xxzEI22/IRc5V
         /Dj7ARRohNXDgU7ZH4naoz3QqElPM93dqsL17H7SuHKN+Q8TjDv3X1R4InLMLTGgYXcW
         79sQ==
X-Gm-Message-State: AOAM533efQ1EwnR//XBH8g743eAwBT5bZAeFgYdZW6x74onjrJpHBQ9o
        0lFK3r0G5YqkIL8bV3Kf1XH8B2asg2ok3+2HKzocRueEwpE=
X-Google-Smtp-Source: ABdhPJz4hu2VQoELrGIeFJJOW4mMYVGE70JuuheH0xtLKehp6KjOjSVQJHQr+5Krpb70xaT2qjO+7BNm+J8BvwxPJ3E=
X-Received: by 2002:a05:6402:27d4:b0:419:5105:f7e7 with SMTP id
 c20-20020a05640227d400b004195105f7e7mr13882128ede.356.1649333341748; Thu, 07
 Apr 2022 05:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220405140906.222350-1-Jason@zx2c4.com>
In-Reply-To: <20220405140906.222350-1-Jason@zx2c4.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Thu, 7 Apr 2022 20:08:49 +0800
Message-ID: <CACXcFmnFiH6zD=rQXjzyUOa8+DcnOoTETUxA=a=xB3A=MmGO0Q@mail.gmail.com>
Subject: Re: [PATCH] random: opportunistically initialize on /dev/urandom reads
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does this help?

I have some code I'm not yet ready to submit as patches. Here's some
of it that could be used to initialise the pool (& I think also the
counter for chacha). The paper linked in the comments suggests that
adding a bit reversal would improve diffusion, but I have not done
that yet.

/**************************************************************************
 * Load a 64-bit word with data from whatever source we have
 *
 *       arch_get_random_long()
 *       hardware RNG
 *       emulated HWRNG in a VM
 *
 * When there are two sources, alternate.
 *
 * If you have no better source, or if one fails,
 * or if the argument 'fast' is set, then fall back
 * to random_get_entropy().
 *
 * Also use random_get_entropy() sometimes even
 * if we have a good source, to avoid trusting
 * the source completely
 ***************************************************************************/

static int load_count = 0;
static spinlock_t source_lock;
static unsigned long source_value __latent_entropy ;

#define rotl64(x,n) ((x>>(n)) | (x<<(n)))

static int get_hw_long(unsigned long *x)
{
    int ret ;
    unsigned s = sizeof(unsigned long) ;
    ret = get_random_bytes_arch((u8 *) x, s) ;
    return (ret == s) ? 1 : 0 ;
}

/* This should be a Mersenne number, (2^x)-1 */
#define MIX_MASK 15

#define GOT_A    IS_ENABLED(CONFIG_ARCH_RANDOM)
#define GOT_H    IS_ENABLED(CONFIG_HW_RANDOM)

static unsigned long get_64(int fast)
{
        int ret = 0 ;
    unsigned long x, flags ;

    if (!fast && (GOT_A||GOT_H) && (load_count&MIX_MASK))    {
        if (GOT_A && GOT_H)    {
            if (load_count & 1)
                ret = arch_get_random_long(&x) ;
            else    ret = get_hw_long(&x) ;
            /*
             * if the chosen source failed
             * then try the other
             */
            if (!ret)
                if (load_count & 1)
                    ret = get_hw_long(&x) ;
                else    ret = arch_get_random_long(&x) ;
        }
        if (GOT_A && !GOT_H)
            ret = arch_get_random_long(&x) ;
        if (GOT_H && !GOT_A)
            ret = get_hw_long(&x) ;
    }
        /*
     * fast is nonzero, so not trying expensive methods
     *
         * or no source configured, neither GOT_A nor GOT_H set
         * or configured one(s) failed, ret is still zero
     *
     * or it is just time for a different source
     * (load_count&MIX_MASK) == 0
     */
        if (!ret)
        x = random_get_entropy() ;
    /*
     * use 19-bit rotation, based on
     * https://eprint.iacr.org/2021/523.pdf
     */
    spin_lock_irqsave(&source_lock, flags);
    source_value = rotl64(source_value, 19) ^ x ;
        load_count++ ;
    spin_unlock_irqrestore(&source_lock, flags);
    memzero_explicit(x, sizeof(x)) ;
    return(source_value) ;
}
