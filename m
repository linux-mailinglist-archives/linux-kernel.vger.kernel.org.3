Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1A4DBC02
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352540AbiCQBDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344149AbiCQBC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:02:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD41AD80
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:01:44 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o5so7576909ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XMh0e8fa1FhO/j0IsGbsAU4HyLhy63wh7ytckFoXEA=;
        b=ZAPyJAOyiCauXN4zX3OSYnlch2FhpkKGymlETb4hf1qg/yUx11Ck389ZeTeKlimDZ5
         k32Br1MVI6VyMPgKph8JKJ8h0vmoExNqo0yOVOdtD2RVWXQp0v4ftC3xRZvHBcMw8OSK
         37WiKTeGr5PV1Agc5D39u57OHv87ImiQYQioYc/Eo0SrN6yxCIlW47Q6J8Y6RqvBZ297
         4SBghgEzMDwNUb0iCR4iO0u2kRszJp8noDPUtZJbjoH0+3G+ggw4w/WbhjrxSPIxvoUd
         ZeJWydnICHA9U5SkohDzuPdEmGN3SSq8irKceinZLoXx/86ejfALffxIhtaleEL/DjRL
         x9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XMh0e8fa1FhO/j0IsGbsAU4HyLhy63wh7ytckFoXEA=;
        b=Xf/u/Mr7Iw8h0VUkffo39JEaKcmWdozyvfHB0Z018DDQpTy8gcvub3WZMwslRh+jIJ
         mTJm3yqoUUkJRn3cnM6LzTB3SZiDISIJbdtmDn5QrpV97LJip8VJkayNj5F4xeyAI6KA
         RDFvmWPHxz94Kw4KiynTZk1rDFcGRvsh5CpNYMYDL6oVvhmWHKwp+3fBlGC9o+RZQF8I
         wrf9v3Yr1t7YYivTEPE/2pMFzOmyuuL7L6FSqx3nfeETSibG6PFiwCsvbDwLkdAKhMsh
         HguYM08kiaWRIJU/fc8nfrtz8vUKPapNapYtJbCMt++KTgjv8BxzpE5CwDcmph2QmrAB
         SHQg==
X-Gm-Message-State: AOAM530rH6FHpEPfkCeXGd58DeXY2nECbKvm3YvqJeSxv2Sn7Tbz9kJ5
        +nbdNqgT+FojlsNRetkKqUZI4o/lcF+pqM1Nw8AXKQ==
X-Google-Smtp-Source: ABdhPJwXRv/OtHU5JAnu4idinx3RpVumcJd9VwVN957MrUxV0Dws0TZIyIbctEr87o3xFcpOU4oQFRrLx2WqgWBxz8s=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr2861981ybb.514.1647478904060; Wed, 16
 Mar 2022 18:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220316183227.725bfd37@canb.auug.org.au>
In-Reply-To: <20220316183227.725bfd37@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Mar 2022 02:01:32 +0100
Message-ID: <CACRpkdbvm4nnoTWORJV1h0qKFyaCE0q6JXLpXmi3f0nvx5wZ7g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kspp tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 8:32 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
(...)
> I have applied the following hack patch for today.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 16 Mar 2022 18:12:14 +1100
> Subject: [PATCH] fixup for "pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver"

Patch looks good but didn't apply to he pinctrl tree when I
tried to simply apply it there.

Since it is touching IRQ handlers, I suspect this could maybe
apply to Marc Z:s or Bartosz trees? Or can you see which one
needs this?

Yours,
Linus Walleij
