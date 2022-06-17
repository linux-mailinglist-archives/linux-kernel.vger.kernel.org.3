Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4866550081
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344636AbiFQXRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiFQXRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:17:14 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0A63BD6;
        Fri, 17 Jun 2022 16:17:13 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id d39so5376621vsv.7;
        Fri, 17 Jun 2022 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSDZ7HTkBptINozaQgd44hsL2jDW/c98k9G0DTyiBuE=;
        b=DxP9ExIgxdV43n7HDDhEjeRKg8RRvDZ0MuRWCAITTVVi/uWZaRHAsmj4snKStNcPdQ
         Qv71wgckPNClb54/PGGLCOQNDdQVoSanpNmXaCjY+cQGhf3Hkg+6vYPiK+AZmLTvdYN2
         dMx7ikVKhsYeI4A62hGOtAIJUagdPuxiw/fTRZpIGn4FHQFVICUWub5/XqCwCp0ybGfT
         4QzQtAjlEVnsABaZb1gih7KwDd5uMrr0gG0iRF7wYg6xwbQTXuh/+Ld4zTOGQ/OdLwAU
         UIV/74aDLLTtXa/9L9jQSEEIiikDkyC+e5MC+Tbs5zyMIXaT1ARhbM5qMpYUHmR3X2NB
         xpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSDZ7HTkBptINozaQgd44hsL2jDW/c98k9G0DTyiBuE=;
        b=w5YQxULuY0Bba21B63wJdDwCeYqenC4MfehUN55ZqndoiACb12nmOqINCcsXlZB1Qw
         7EcM4EmSd5Ce8b4kVPfYBTRfXIgdTQNil90MJE6Uf2VmawSpAPLxDebyH1gV7YSgyS8q
         RYlRFxFu3VxeOGTgYg9piK5zZFkwteE+rBctQwhCOVms8I1XMZGi5Yug+AgGAioF7nRM
         F3+SHha77BW5DsFO/ANozPtK5TVdWIFeqhBuCg0MUuAHjyISJbCWy+yB4KLwSuxR2oTA
         5qsVH3X1Ftg+ZUwgCBRZ1ellSDHVy0iTlRkyhmk0zQjyaa6ECD7U95A6oTp2GtLqYeRF
         H0uw==
X-Gm-Message-State: AJIora+oyM8ctqjObsokM/1WqXp+sJwt9HWA27P5ZN/Dgott61/xMTNH
        +oTg3PZNaVYr6KI9Em8QRtE27D4/JSmSOXl3hULfK/KoS7o=
X-Google-Smtp-Source: AGRyM1ufVwu04pWZo26CS4YTa8IofGe3YhzWdESb0nMrvGrJf0ZwXjE5GYYxBN+jDlqJEh8X8sI4Y1OmF87203ofNps=
X-Received: by 2002:a67:e342:0:b0:349:f16a:9ce with SMTP id
 s2-20020a67e342000000b00349f16a09cemr5943201vsm.74.1655507832544; Fri, 17 Jun
 2022 16:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACXcFmmw8bzSr-pmTauMS7a=036eW0=1KLdwAD1MOB_fY-7VRg@mail.gmail.com>
 <Yqr+rFeixFuHzyHD@zx2c4.com>
In-Reply-To: <Yqr+rFeixFuHzyHD@zx2c4.com>
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Sat, 18 Jun 2022 07:17:00 +0800
Message-ID: <CACXcFmmdrELd8CkwmBQf5-W7PkR=McjcUz9kPDzaCh=NrODKUA@mail.gmail.com>
Subject: Re: [PATCH] random Remove setting of chacha state to constant values.
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, "Ted Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> ChaCha is a permutation that requires those constants.

No. The actual permutation does not use the constants.
They are used in setting up the state & directly affect
only the first round. The other 19 rounds do not use
the constants; they operate on the more-or-less random
state left by the previous round.

The actual permutation works fine with any input.
The only question is how to set the initial state.

I think it is nearsighted, but there is a reasonable
argument for using chacha_init_consts(). That is
exactly what ChaCha does, and arguably we
should not deviate from it.

There is no such argument for
memset(&chacha_state[12], 0, sizeof(u32) * 4);
ChaCha has a counter and a nonce in those
bits, so setting them to zero is a deviation.
Dropping the memset() and using whatever
the existing state has there may not be ideal,
but it is certainly better than the zeroes.
