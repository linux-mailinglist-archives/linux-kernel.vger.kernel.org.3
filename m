Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2310857899C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiGRSeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiGRSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:34:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5962DF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:34:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id tk8so11533786ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uKNO/2jKtYxtHpiKjjZWFyfX1vgvMagozZ10mRTcyRY=;
        b=IBilH2yk53/8G11w0puh2eRVbRH56qZC4Tjg3Pq7xlpPa17Nee9c7J7l1O2yx6UVN0
         z3xxHnOh5QjU9uN/l6evyV0y+yYqZOk6RJ/fGPflrU720VaN8nL55cKT5RMTIrXLfAFu
         hmXxGCVcHQ+wDwrb4zsbvFrKF9iDVqdEu3NLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKNO/2jKtYxtHpiKjjZWFyfX1vgvMagozZ10mRTcyRY=;
        b=ZvcpQRGVKpvAkxQT7Gf5dh+55vbQtbJH52dmvOGSiV2KXX6MNrIA0qE0ongTD591PB
         bfDoZTY0kEUdXlpWkELONuKe0o0TQA+QGqmLXUNplSaoUgm2oZnz38sId9Ry3lU8NYfA
         yP6ZgbQylkn6GaPqoUTESAP8kz5lu/izctbKY8Vz29o6TozlMbDmqMTB3twO/8tDzDDA
         XtMO5kra9zo1zm12Yjq7vVqiR9pzJlEV+6WclFaJ/ffgEa98qgeEZxl0AYLbPINtlyPP
         QCw/2HURecLRPtqptt8+4y7khmMKbEaI6BYW5sLmvTgYfygcGmWT7HxxtXrZCPsbrzGI
         gm/A==
X-Gm-Message-State: AJIora8N7eH6m0bZmkTQ3nxLGeylZbzxenQN61W87WdKCxRhScwzB/0H
        9bjeqZ5O8S1V1GcgqlbtewRylH3W6IsDCMIN
X-Google-Smtp-Source: AGRyM1t0sjJM8yhNmBSTv+n+O1m0qeVBNSVX6l8m3UrZb7Ta+eJZMpptgaRK/uHWQhs4vaj19ozl2g==
X-Received: by 2002:a17:907:3e9a:b0:72b:44d4:4482 with SMTP id hs26-20020a1709073e9a00b0072b44d44482mr27527055ejc.34.1658169260938;
        Mon, 18 Jul 2022 11:34:20 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709061dca00b0072b32de7794sm5770634ejh.70.2022.07.18.11.34.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 11:34:20 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id bu1so18308022wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:34:19 -0700 (PDT)
X-Received: by 2002:a5d:544b:0:b0:21d:70cb:b4a2 with SMTP id
 w11-20020a5d544b000000b0021d70cbb4a2mr23607916wrv.281.1658169258764; Mon, 18
 Jul 2022 11:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220715194550.793957-1-cascardo@canonical.com>
 <YtVG8VBmFikS6GMn@worktop.programming.kicks-ass.net> <YtWKK2ZLib1R7itI@zn.tnic>
In-Reply-To: <YtWKK2ZLib1R7itI@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 11:34:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWQOsxqE+tvZi_MjzGaqfG6Xo5AhbYXtiLWcKVVvbycQ@mail.gmail.com>
Message-ID: <CAHk-=wiWQOsxqE+tvZi_MjzGaqfG6Xo5AhbYXtiLWcKVVvbycQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: use naked RET on mixed mode call wrapper
To:     Borislav Petkov <bp@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
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

On Mon, Jul 18, 2022 at 9:28 AM Borislav Petkov <bp@suse.de> wrote:
>
> So I'm being told we need to untrain on return from EFI to protect the
> kernel from it.

Why would we have to protect the kernel from EFI?

If we can't trust EFI, then the machine is already compromised. We
just *called* an EFI routine, if EFI is untrusted, it did something
random.

I mean, it could have already done something bad at boot time when it
loaded the kernel.

So no, let's not "protect ourselves from EFI".

             Linus
