Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9ED581AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiGZUUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbiGZUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:20:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B30727B1C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:20:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy29so28021141ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CN7dQvXWwaJGy07n6QHMuaIcTWf0n/HGar+msGxrYk=;
        b=FGJZe+ZwP3lgA0wU4CgENEV4uAjTArTRwFrNXA7DgfkgNXGLMfVrAiFenpM+aZxYi3
         oCzqZUMRn0IH1rFc2iDgLG+UKKXNBuUxdaPOqpCCmVa594FKN8Q6xS3xQ5n1poatxD3g
         x1xRQ4sgvnKIpYMJNA1ZY6TFctKZX6hDMIklw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CN7dQvXWwaJGy07n6QHMuaIcTWf0n/HGar+msGxrYk=;
        b=2bxDFnligYhkWxsFkTH5KzgdXIE5CofBo0PEd8k5N5wsrlRAI/+d0+5SKJwj8C7l33
         HMRi6MPsK+WXOH1nnCL8e0n+uHyQyo2LEY+6P5wHjsGV7qZ3jF96UTmp/HIHipc+sR1E
         X24M2sC4qV9DO+Z4WkWaAJkF+z+RMO+Hc9D8CBGZBOR54+2sGT3yhA+5+WGZ/DlnP/jQ
         S8EG8ytfs01+95ZBZbMe7KGStE1wjFc7OcxmqE/sCS5fGaD/Kp3WtuqVeKiaRQ2ao/8e
         uoowxM+2Z4UTV4s60AsSxYBxqzcSuuK2D1sXbKrYRlFRLwJXBAwBo52gs9EA9qQAnWxF
         fhFQ==
X-Gm-Message-State: AJIora8iFQ3cbuUseU4HweLvzL68VRHwkcHrVDAFzOIKa4dvCVrNRNbr
        i+fNFuYb6UrJWq1krhJLzDoVLtjAMqM7LAwt
X-Google-Smtp-Source: AGRyM1t7bTupUrfkic0K4ZBS6r+drVMtkpUoP23FckA65OaJbo2a189r7E8Xb5VPHMtRw3VTMwSTrQ==
X-Received: by 2002:a17:906:58d1:b0:72e:e049:cf00 with SMTP id e17-20020a17090658d100b0072ee049cf00mr14862884ejs.361.1658866840285;
        Tue, 26 Jul 2022 13:20:40 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id y10-20020a056402358a00b0043a8f5ad272sm9189027edc.49.2022.07.26.13.20.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 13:20:39 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id v13so13846293wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:20:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1a88:b0:21d:aa97:cb16 with SMTP id
 f8-20020a0560001a8800b0021daa97cb16mr12127299wry.97.1658866839283; Tue, 26
 Jul 2022 13:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWwDYxNhnStS0e+p-NTFAQSHvab=2-8LwxunCVuY5-2A@mail.gmail.com>
 <20220725161141.GA1306881@roeck-us.net> <CAHk-=whtGUwJwHUSNsXd4g7cok=n0Zwje7nACp8skh1fa2NtJA@mail.gmail.com>
 <YuAm5h1B6bsrR/9q@fedora> <CAHk-=wgYpJTMMxmfbpqc=JVtSK0Zj4b15G=AvEYk6vPNySDSsA@mail.gmail.com>
 <YuAv+lV324G7pmlk@yury-laptop> <CAHk-=wg2-j8zocUjurAeg_bimNz7C5h5HDEXKK6PxDmR+DaHRg@mail.gmail.com>
 <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
In-Reply-To: <YuBEIiLL1xZVyEFl@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Jul 2022 13:20:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
Message-ID: <CAHk-=wjpYLLoi1m0VRfVoyzGgmMiNwBhQ0XXG0VWwjskcz5Cug@mail.gmail.com>
Subject: Re: Linux 5.19-rc8
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Yury Norov <yury.norov@gmail.com>, Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:44 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Overall, I would say it's pretty similar (some generic perform
> marginally better, some native perform marginally better) with the
> exception of find_first_bit() being much better with the generic
> implementation, but find_next_zero_bit() being noticably worse.

The generic _find_first_bit() code is actually sane and simple. It
loops over words until it finds a non-zero one, and then does trivial
calculations on that last word.

That explains why the generic code does so much better than your byte-wise asm.

In contrast, the generic _find_next_bit() I find almost offensively
silly - which in turn explains why your byte-wide asm does better.

I think the generic _find_next_bit() should actually do what the m68k
find_next_bit code does: handle the first special word itself, and
then just call find_first_bit() on the rest of it.

And it should *not* try to handle the dynamic "bswap and/or bit sense
invert" thing at all. That should be just four different (trivial)
cases for the first word.

             Linus
