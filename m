Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E912C583361
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiG0TUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiG0TUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:20:04 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7812266AE1;
        Wed, 27 Jul 2022 12:13:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i14so31802237yba.1;
        Wed, 27 Jul 2022 12:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhBUWWVRG0hanjTnDj5rTeKOyivME1mqkocwt5OE7us=;
        b=ceauQS1yAK6jl7VwTvkVaNDAv8cC/ocYrB/v9xEKwC2YCk/xhSZXEahlPlCSahSQpa
         YbtFG2kU+oMQcogSH/a2XxIxoCM5SpBp/d7hk+sLrD/n5kb8LufjJrpdWtNqy2lVaZMP
         1iyhyUE1MYL9lEQTW7fzao/c3rb7Ulv57841Z3qk2SSC51mPUGqh2861G36so6/fVp6v
         zIktx7r7i9FRATdJq+vMk8H4uTXgZNSTbNdU9KCiS/yXja/W3sdRV8VW10n5NkWT1Oyg
         CMNvUG3mzP7VRuPY8Du9Q9LRNJ/WHHxD8pfp8a2Fn9Fi2Iq6xJaKLUwVPjcyLg5ji6gj
         2MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhBUWWVRG0hanjTnDj5rTeKOyivME1mqkocwt5OE7us=;
        b=EyoKng4g2OGJKUAzMGUtHAuUnYm4kGU51ix5u1OQX8qtWggaHM0T9iw0L68aNcsqdf
         ySDb7+YBHMMRRTPvgwdLZUZHNPrPz12f3VCTIEOEBgIAdXnV9Jomd7FzxDGEgjfRvwsA
         cniR5wUmhM0WbYtoi7T8F9LQGYT01XmXO10U/YU7pKP1PJCirGCY8UOX36/3zGfTjOtf
         D02o9nS/h6Xzj84ZKeL6xGkZ2HKm3yu7DWcAMXtGMJ/ugJE3GgyN/v7qEwHc0Pby8vYm
         Fq/nMZg5r/2QDndImnYCUcxFQEsYYs6mOoQTsQqUkl2JtyE8pyedZmNg7oRlT/kKErZA
         Fivw==
X-Gm-Message-State: AJIora+4iXRAcmptLtcbubdVIPUTdajxOkKyW6oOi9dShbg5AR0cpF7Z
        YWmrNb6Ox4MEnO+CC/B3cjtYLi/15EnL3Kt7+ewbm2cJGUA=
X-Google-Smtp-Source: AGRyM1v8JWg8mpDpYDeS0qdMtXhObRgUeYqjoM1X9hZANMRXNC2uRkYXRrKpkqB1jirjbmeZwEZRzYX9kIHmdGranR0=
X-Received: by 2002:a5b:1c8:0:b0:671:5d14:5974 with SMTP id
 f8-20020a5b01c8000000b006715d145974mr10588575ybp.123.1658949193593; Wed, 27
 Jul 2022 12:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220725193547.1038414-1-martin.blumenstingl@googlemail.com> <af067c133aa410370aaa4f11e334bc910b4c21e2.camel@svanheule.net>
In-Reply-To: <af067c133aa410370aaa4f11e334bc910b4c21e2.camel@svanheule.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 27 Jul 2022 21:13:02 +0200
Message-ID: <CAFBinCDZYb-Pt_Vn14cDmprM6CxRoEbTUTx16FMv=cWf-pnrQw@mail.gmail.com>
Subject: Re: [PATCH RFC v1] spi: realtek-rtl: Fix clearing some register bits
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bert@biot.com, mail@birger-koblitz.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sander,

On Tue, Jul 26, 2022 at 11:03 AM Sander Vanheule <sander@svanheule.net> wrote:
[...]
> >         value = readl(REG(RTL_SPI_SFCSR));
> > -       value &= RTL_SPI_SFCSR_LEN_MASK;
> > +       value &= ~RTL_SPI_SFCSR_LEN_MASK;
>
> Although typically a field mask has the only the bits of that field set,
> RTL_SPI_SFCSR_LEN_MASK is already inverted. So LEN_MASK has all bits set,
> *except* for those where LEN is stored.
>
> This means the code currently is:
>         value &= ~(0x3 << 28);
>
> which is correct AFAICT, as it clears the LEN bits, but keeps all the others.
Thank you for this hint! I completely missed that when reading the
definition of the macro.

> While this part is currently not wrong, I wouldn't be opposed to a patch to make
> it less confusing by not inverting the field mask in the definition of
> RTL_SPI_SFCSR_LEN_MASK.
I can re-spin this patch and move the ~ operator where most people
expect it to be.

> >         if (size == 4)
> >                 value |= RTL_SPI_SFCSR_LEN4;
> >         else if (size == 1)
> > @@ -143,7 +143,7 @@ static void init_hw(struct rtspi *rtspi)
> >         /* Permanently disable CS1, since it's never used */
> >         value |= RTL_SPI_SFCSR_CSB1;
> >         /* Select CS0 for use */
> > -       value &= RTL_SPI_SFCSR_CS;
> > +       value &= ~RTL_SPI_SFCSR_CS;
>
> This macro is not inverted, so it does clear any previously set bits, and
> probably doesn't end up with RTL_SPI_SFCRS_CS set. However, is in an init call
> and it doesn't appear to cause any issues later on, right? Is this because the
> SFCSR register is (unintentionally) cleared and that is actually required?
I'm not sure what's right or wrong here but the code reads strange:
    value = readl(...);
    value |= BIT(30); /* RTL_SPI_SFCSR_CSB1 */
    value &= BIT(24); /* RTL_SPI_SFCSR_CS */
What's the point in setting RTL_SPI_SFCSR_CSB1 (bit 30) when it's
immediately cleared in the next operation?

Also any bits read from the register except RTL_SPI_SFCSR_CS (bit 24)
are cleared - why even bother reading that register then?

If you have any advice on how to change this code then I'm happy to do so.
Otherwise I'd leave it as is, especially since I cannot test this in any way.


Best regards,
Martin
