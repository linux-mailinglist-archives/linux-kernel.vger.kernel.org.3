Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAEF55B377
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiFZSUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiFZSUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:20:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB55DFCE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:19:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lw20so14685246ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nnL5Lxxf/SWDHyzp3vUYT4HVrZt90qdFl5DYglMXXuA=;
        b=QeC+mV/762n9+Kg8dqlJ2cSws1Yi/uDMsCvuWjTePgnggap1WZwqMbXoj4C+piq3Nc
         67KX/l5gHG5nSQ77D6XSxxQhLFdbpQwmgNiV1gl4zJHKvNETyoxTS3eRHMw8GiJaky0f
         Wu1UzKzTWhGLL2yIB9daWX/MpGmblYRuiPE6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnL5Lxxf/SWDHyzp3vUYT4HVrZt90qdFl5DYglMXXuA=;
        b=c09sbfDPzGqn1v1lPwDPxPddCr8DvdiHXI16lOxZu5gytD4MzshP15y828/TLL5dVf
         vU1nd9YoaqvX+R06ezgOee99Dx0iISPtA2A8eI91E7V8TxMqd0M1ODoJuQ6k+X4QOaCW
         JHAc3dicXZOtlAq5xjTuvBSCjDlIrK/b4FfljywFo8gtPLif43LXLa7Ns2bVB8XDp9LT
         GgyihiHs6vNk8/QrGZMvzN+Z9Wjiruq+dgyBhv0YaIr+62+74YGPRFJc5DpAUa87DqtA
         OUAOCHNuzNPq/ObuZjlBAjLwkjQT6NHt+z3/U1z4Ze77kfo+C/rH4DUUfk/wAaVsOw03
         +UZQ==
X-Gm-Message-State: AJIora8/2tUsfjviuaqQZ+hrewTVjM3dmjDTkYZiX62iU5bzOciSLoSl
        NbwQo5TVr119zbF9ftQdXDeYCEbvI0rGdQ9X
X-Google-Smtp-Source: AGRyM1umyW6l5I1AiDS6vGKbNouFn3r+xmRrpj2cAFJZxeDQ10amKqMSEDTBb6wiwhh5AgGFpPSYLA==
X-Received: by 2002:a17:906:58d5:b0:722:fc0b:305a with SMTP id e21-20020a17090658d500b00722fc0b305amr8810949ejs.251.1656267597898;
        Sun, 26 Jun 2022 11:19:57 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906941600b0072660d8d83fsm2020985ejx.188.2022.06.26.11.19.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 11:19:56 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so4538239wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:19:56 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:3a0:2da6:d173 with SMTP id
 a1-20020a05600c068100b003a02da6d173mr15489119wmn.68.1656267595975; Sun, 26
 Jun 2022 11:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
In-Reply-To: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 11:19:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com>
Message-ID: <CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v5.19-rc4
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 3:16 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Please pull a couple of Kbuild fixes.

Masahiro, I already complained about this once:

    Section mismatch in reference from the variable .. declared __init

and now you re-introduced this sneakily by just putting it in another place.

I told you last time that you need to *FIX* these things before adding
the warning, instead of adding a warning and then waiting for others
to fix them.

Yes, it's fixing an earlier mistake, but that earlier mistake is over
a decade old by now.

Now, the only warning that seems to show up for me is about
tick_nohz_full_setup. Which is only called from housekeeping_setup()
in kernel/sched/isolation.c if I grepped correctly.

And that seems only ever built-in as far as I can tell, so the whole
export seems pointless, and the fix is presumably to remove the
export_SYMBOL_GPL entirely.

So it seems fixable.

But I'm upset about this sneaking in when we _talked_ about this issue earlier.

Paul - that export was added by commit ae9e557b5be2 ("time: Export
tick start/stop functions for rcutorture"), and it seems to have been
bogus even at that time.

              Linus
