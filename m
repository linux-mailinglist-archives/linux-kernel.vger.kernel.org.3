Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55A15A0122
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiHXSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbiHXSL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:11:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BE057E39
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:11:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bj12so18043679ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mgO0n7mmdIa+740KgIEH+WGKNT+BZ2C0M4LSfLMHSwg=;
        b=hCD8qzdrwkCzZJrM7SltVOU+AvzCzVXfxFx/FiUf3qvpxeADeJL6rqlZGeZ68Id1rJ
         Tnkiv1MU3X8WctJZKaQM96vRhpc1Lgf7BeKVl8b8n1w5lDpF7GAkwXqGZ+GW3VzN/66f
         a83l3cFsFAIcnnMWTpdmBE4jnIx5hZaLG3as0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mgO0n7mmdIa+740KgIEH+WGKNT+BZ2C0M4LSfLMHSwg=;
        b=BYnQTUKiWoKMyeFxfFw2vcRjRdgJXKXIPg0W7z4pI2oFiPSHNufC78+B7LR8yfnPrZ
         D6g/0X8q+sBtxY4n3dd4s7RzN2FhRivMS325Y637CcWeJz6ainLE7JOd40bOJg5BO0OT
         n4Lne2a5NoF4cR9V1AErx/eQrd47nnlXl59qy8OTjALqJM7R8yXdBeR13QRy35itVVTE
         fyCiw+DFlv2Y43ySyzk7yLISsS+2kOfZRuZCLGQE/ksNVy9+Kir1dCDARQqluV79mT5V
         mL+fPE5dH6vSDd2F+dwKouyxsmJmEyBpFyybIaNSXkHXM6WtfJh9cRCcZ5brHi6PLiod
         VLbA==
X-Gm-Message-State: ACgBeo153VkdyqPXBcGAlR2S8Eunc1QLiL/yPmfq+fz/D3Gnk+oGMuU1
        /jEZ0HPmvzxhKGdpG40fRkVECUb97wptGMUv
X-Google-Smtp-Source: AA6agR6Fi/1hrNea8QNtLbA1xvWnXg/LXNAnUOTsWiaWRDdYP/2+UHawUIiPfdttgd+GifnKWFc9vg==
X-Received: by 2002:a17:907:2bf8:b0:73d:6cd3:906c with SMTP id gv56-20020a1709072bf800b0073d6cd3906cmr108472ejc.686.1661364683756;
        Wed, 24 Aug 2022 11:11:23 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id fj15-20020a0564022b8f00b0044657ecfbb5sm3442304edb.13.2022.08.24.11.11.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 11:11:21 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id u14so21734908wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:11:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr217741wri.442.1661364680430; Wed, 24 Aug
 2022 11:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com> <20220824012624.2826445-3-yury.norov@gmail.com>
In-Reply-To: <20220824012624.2826445-3-yury.norov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Aug 2022 11:11:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg24VuMmiBpTkpbL5zXzkXrxu1QzrLRcfy4NEh2VXuuLg@mail.gmail.com>
Message-ID: <CAHk-=wg24VuMmiBpTkpbL5zXzkXrxu1QzrLRcfy4NEh2VXuuLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh, and here is the "odd trick" immediately afterwards:

On Tue, Aug 23, 2022 at 6:26 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> +++ b/lib/find_bit_be.c
> @@ -0,0 +1,23 @@
> +
> +#define word_op swab
> +#include "find_bit.h"
> +
> +#ifndef find_first_zero_bit_le
> +/*
> + * Find the first cleared bit in an LE memory region.
> + */
> +unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
> +{
> +       return FIND_FIRST_BIT(~addr[idx], size);
> +}
> +EXPORT_SYMBOL(_find_first_zero_bit_le);
> +#endif

I looked at that "_find_first_zero_bit_le()" code a long time and says
"that can't be right".

Until I noticed the

> +#define word_op swab

that was several lines above it, and not even close to the use of it.

So no.

Just make the macro take that "last word op" as another argument, and
then you don't need these tricks, and you can do the _le() version in
lib/find.c file *exactly* like the regular version, using just

  #ifdef __BIG_ENDIAN
  unsigned long find_first_zero_bit_le(const unsigned long *addr,
unsigned long size)
  { return FIND_FIRST_BIT(~addr[idx], swab(val), size); }
  #else
  unsigned long find_first_zero_bit_le(const unsigned long *addr,
unsigned long size) __alias(find_first_zero_bit);
  #endif

or something like that.

And yes, it means that the "regular" versions need to pass in just
"val" as a last-word expression, but who cares? It's still cleaner,
and easier to explain: "The first expression finds the word that
matches our requirement, the second expression munges the word we
found into the bit order we use".

Or something.

         Linus
