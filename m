Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A47953D398
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 00:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349546AbiFCWXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiFCWXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 18:23:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687D3524A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:23:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 25so11598485edw.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3OHmTUWRLi2a9puFadc7t+O3rYGfcwkImBjPtsts/w=;
        b=KHXmqdVp1Py6tPB4jihW6F8gAB7ePDwC80+2OA2LXUT5rqg6K18ghEQC7FVZ1vN+1v
         eG276KEtetF5sUv5GWAKtIgImyVvz+peHUo4qmqPCQZeA4wIuEY7FQXh5WFSojXQF09v
         XdXsjSVZxHub8oI7LXmskOukvjMqllUJ/Zyno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3OHmTUWRLi2a9puFadc7t+O3rYGfcwkImBjPtsts/w=;
        b=76z4pFHQxIMSm/bAZTJe3cV/QyampTxvHsVv6/D6vTyondvkURrtWin1H3IiSwjvQ+
         ObHQy7SocTpDSeGEpSKDVxwMFeAH1INUOB1powdD1mlkE/5qA7ohTY6aOTNgHPpGetWH
         yEdyDPnqDwwZjWZWWlL05GVxSHtrcJ2sxIZgGP8unWJWdFPqChwMgxFWRTScO/RlyNM1
         WVYV4IQSGMPs7HnvSqdBLhvuUlO3YycmcVYDMgzScamG70GEuhmQ61+BKwJ3ZMO2QQAx
         KCAP+qkcxgpg2CR5lHJnWTh8J4ETGUTdsI8hDs2+ypoJ/JCE0pba2nCTuTJndaasST1C
         0bIA==
X-Gm-Message-State: AOAM530IdYFE2L5nUPT0P/ztt9OnXaYXHIDNYn2SzfWX3Jyr4mJUuxSd
        BT8FmaCxX2XmOxf9S64N1q4VSltE3mB2HJUs
X-Google-Smtp-Source: ABdhPJyiqpmyRcGZWyOVFjwCEOLjYOeIaBql368TKm88+hcLp9nuiAZAx6NAr1R/ClnL0yc4JDZe1w==
X-Received: by 2002:aa7:dc09:0:b0:42a:aadd:8e71 with SMTP id b9-20020aa7dc09000000b0042aaadd8e71mr12935229edu.41.1654295016024;
        Fri, 03 Jun 2022 15:23:36 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id j25-20020a50ed19000000b0042bcf1e0060sm4368856eds.65.2022.06.03.15.23.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 15:23:35 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so7006574wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 15:23:34 -0700 (PDT)
X-Received: by 2002:a05:600c:2e07:b0:39c:37df:2c40 with SMTP id
 o7-20020a05600c2e0700b0039c37df2c40mr6874704wmf.154.1654295014299; Fri, 03
 Jun 2022 15:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <YpnwZ/Q5yTKRDBOD@kroah.com>
In-Reply-To: <YpnwZ/Q5yTKRDBOD@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jun 2022 15:23:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxbyfaqvS9+p9SsN34B4D=jXGdrUtCwFY+QurVKhDFyA@mail.gmail.com>
Message-ID: <CAHk-=wjxbyfaqvS9+p9SsN34B4D=jXGdrUtCwFY+QurVKhDFyA@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core changes for 5.19-rc1
To:     Greg KH <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
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

Augh.

This was very badly done, and I'm not talking about the deferred probe
timeout things that caused problems for people.

On Fri, Jun 3, 2022 at 4:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>         - firmware_loader reorganization and additions including the
>           ability to have XZ compressed firmware images and the ability
>           for userspace to initiate the firmware load when it needs to,
>           instead of being always initiated by the kernel.

This is actively misleading.

We *always* supported XZ compressed firmware images, and it was
enabled by CONFIG_FW_LOADER_COMPRESS,

What's new is the option to use ZSTD compression.

However, the Kconfig file addition for this was done as badly as the
above explanation was, and the FW_LOADER_COMPRESS_XZ option was added
with a help message and a default value that both are complete
garbage.

So when you do "make oldconfig", you would be expected to say 'N', and
in the process you lose the existing XZ compression.

Only when the resulting kernel doesn't boot, and you spent half an
hour trying to bisect things, and you start looking closer, do you
notice that "ooh, the config changed in bad ways".

Yeah, I'm a bit grumpy. This was *really* annoying.

The commit that does this breakage is literally called "firmware: Add
the support for ZSTD-compressed firmware files", and only when looking
closer do you notice that IT REMOVES SUPPORT FOR XZ COMPRESSION BY
DEFAULT.

Because even when keeping the FW_LOADER_COMPRESS option enabled, the
XZ compression is just gone, gone, gone, unless you realize that it
was implicitly enabled before, and now needs that default disable of
FW_LOADER_COMPRESS_XZ to be enabled.

I've said this before, and I'll say it here again (and I bet I'll have
to say it in the future too): the kernel config is probably the most
annoying part of building a kernel for anybody.

And it damn well does NOT HELP when people then actively break things,
and ask actively bad and misleading questions. In this case, for
example, it's not just that the XZ option is now misleading by
default, it's also that the whole thing has been set up so that you
can say "enable compressed images", but then HAVE NO ACTUAL
COMPRESSION METHOD!

Grr. This was *REALLY* badly done.

                      Linus
