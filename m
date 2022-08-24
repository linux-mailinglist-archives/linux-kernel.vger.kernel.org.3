Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED75A03CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiHXWLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiHXWLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:11:48 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC77CB61
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:11:48 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id u3-20020a4ab5c3000000b0044b125e5d9eso2327322ooo.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=fQnzJIEDcaaaAEZ4bKB8WpKO4pGwq6tvX+PHOcNDifc=;
        b=S6XK5qBaPzXK+yQlGtkLHV2f3omv6DmzUi5hJvo06Usv0rieEgwAalzLA8je3zA7ge
         PcrNsgBwROGm5JyPMqmTWcIQnm+01mcYqHYCUZCeO2iOOYSspE5h4praNEbit/FVx8W0
         hrM2dcbPkQxG4Qasa8Xx9uctrSpe26DwFYmdzbhwiL8uTwmN3zYVkxkT5tqZnwy5jkd3
         IWHOafy518S8yOStVuZONgoFxwPIlWDLtF84+I7duCrsexl6io7iAcruti1i05CjChSm
         QRaRRXRlqNuVzDL4Ktb4HDKBZYqtqmmE0GLaD+HWMOWj6vswPMn7oJJDyMXQ+f3WhO49
         eJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fQnzJIEDcaaaAEZ4bKB8WpKO4pGwq6tvX+PHOcNDifc=;
        b=A+eSMdQyGfkhDibuXidUdhdWWnbfbSxueIvjZO52nhZV8JIXMiukpKr/z+pnYPunyg
         WtA4ky/sEufNagPFxjb71z0dZZIdH4go3zoPOsaOYGBDMhHlbdENeqqRBtE9rLTBDJo8
         fKjVFncyMSMXvEmheApHjgmscNzxP0JmmruEhiCIBM2uxTAyJGZS58pKIJ/L26GdiH/Z
         nPyj+90vFCMrDGZjzbwNg3JoqXSbWgxLtpyZ0Kvgk97hS49W+FZYfXENuUFcrkSxoBfA
         LB5Y/zxx8cBveXsRX428dxRMYaGgzG8eyA1D5old11cfv8L8njJdnXB2vGchg6hJppLr
         PM1Q==
X-Gm-Message-State: ACgBeo0ki8wpRzPwibcC334E9jucjEphZ+XNP6taLXJthdk5EC8mYqJL
        eDPlYOZKaUVWWspCZtT9TDk=
X-Google-Smtp-Source: AA6agR5FdHoZOT2UUP6ZJu8ca+Dyf+1sJkKeajqFWEfOJpYGcXWI/8IEgi5CYLppJIooNiftxKBCJA==
X-Received: by 2002:a4a:e6d2:0:b0:445:6fb:498a with SMTP id v18-20020a4ae6d2000000b0044506fb498amr340849oot.96.1661379107384;
        Wed, 24 Aug 2022 15:11:47 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id w197-20020aca30ce000000b0034484c532c7sm4281344oiw.32.2022.08.24.15.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:11:46 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:09:35 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
Message-ID: <Ywahn6b92NcrZod0@yury-laptop>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-3-yury.norov@gmail.com>
 <CAHk-=wg24VuMmiBpTkpbL5zXzkXrxu1QzrLRcfy4NEh2VXuuLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg24VuMmiBpTkpbL5zXzkXrxu1QzrLRcfy4NEh2VXuuLg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just make the macro take that "last word op" as another argument, and
> then you don't need these tricks, and you can do the _le() version in
> lib/find.c file *exactly* like the regular version, using just
> 
>   #ifdef __BIG_ENDIAN
>   unsigned long find_first_zero_bit_le(const unsigned long *addr,
> unsigned long size)
>   { return FIND_FIRST_BIT(~addr[idx], swab(val), size); }
>   #else
>   unsigned long find_first_zero_bit_le(const unsigned long *addr,
> unsigned long size) __alias(find_first_zero_bit);
>   #endif
> 
> or something like that.
> 
> And yes, it means that the "regular" versions need to pass in just
> "val" as a last-word expression, but who cares? It's still cleaner,
> and easier to explain: "The first expression finds the word that
> matches our requirement, the second expression munges the word we
> found into the bit order we use".

OK. I'll do like this:

   #define FIND_FIRST_BIT(FETCH, MUNG, size) ...

   unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
   {
         return FIND_FIRST_BIT(~addr[idx], /* NOP */, size);
   }

   unsigned long find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
   {
         return FIND_FIRST_BIT(~addr[idx], swab, size);
   }

It doesn't actually look that worse.

Thanks,
Yury
