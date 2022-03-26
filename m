Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C34E83CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiCZTbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiCZTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:31:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD31532052
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:30:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e16so18508484lfc.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfLtMPKWOgtbixf5r664NcyfUg09ely2U/JmDYjA8BY=;
        b=F+3ZVjB7BCSCLcZtwiPvR46BWAJVWdiaN3i439/aLf4lD0vcChmXZbsSzeMY76YnAP
         RENdKWXQ/ux4mV+RSnrCv9PyYnLL2iFG+BKvgFzACMUl6/c2Z2wMhjk96WLCFrW6tOyb
         ViEQgfC6S4WqObuYEM6u9bBkGdgNiFF6lCkqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfLtMPKWOgtbixf5r664NcyfUg09ely2U/JmDYjA8BY=;
        b=rgCvg5O7fCwB3vF56b4Dlrl2uqUWp9HQpB4oExrsti9Kaw3cHVlp4UV+OoC87+kIFB
         VNvVDMxDHrA0ndFvX6+7Y6NkPYT97yvzmv6lvOt1oggSN4CauI1F0InRoIOzoy2Scayq
         c3FLa8RmOd6mIoSRZNVpax4cyMeuaczOLFkmFad8TBS5tWkFFI9OOgeSRUgBi9XVVbdK
         zlDge+VvpYdtWv7to7DnSCYgoeRr8jkomWvszG3Mry4ZEiPF5RsiNgYx3x2P3dmUbR3h
         QgAEsIHGFczIlEdu/ER/hd4SAtzrenaNT3lAuJmYdNmt009cdIj8NimvrQ0gKAnKlpIV
         b3AA==
X-Gm-Message-State: AOAM533Vv24EBRcy5KO20MjJ3jisJl7fRX8QAYt5YrNT9Wf3f8ToxLiN
        WPh7BnTKfjfvP5CPhF6jnm4kG0JP2Vsbfrgh08E=
X-Google-Smtp-Source: ABdhPJzJ3e2jfkWDwn+DzxHjScOxJWUV9rVa+G5F6TOVbzZIij06b5j5gVbzdstSR3t0GL8rZI9peA==
X-Received: by 2002:a19:9201:0:b0:443:c317:98ff with SMTP id u1-20020a199201000000b00443c31798ffmr12926860lfd.331.1648323014857;
        Sat, 26 Mar 2022 12:30:14 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f38-20020a0565123b2600b0044a75d9de78sm606927lfv.163.2022.03.26.12.30.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 12:30:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d5so18550219lfj.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 12:30:13 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr12850936lfh.687.1648323013613; Sat, 26
 Mar 2022 12:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <202203251443.9BBADFD98@keescook>
In-Reply-To: <202203251443.9BBADFD98@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 12:29:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
Message-ID: <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
Subject: Re: [GIT PULL] FORTIFY_SOURCE updates for v5.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Fri, Mar 25, 2022 at 3:03 PM Kees Cook <keescook@chromium.org> wrote:
>
> It looks like all the dependent trees with related buffer fixes have been
> merged (I was waiting for the scsi tree to get pulled). This has been
> in -next for almost 2 development cycles, and I did overnight build
> testing merged against your tree under the following combinations,
> with no new warnings (there is one Clang 14+ specific issue in
> drivers/net/ethernet/huawei/hinic that we're still tracking down as a
> likely compiler regression[1]):

So how much of this is _completely_ compile-time?

Right now it looks to me like FORTIFY_SOURCE ends up doing two things

 - added runtime checking based on compile-time sizes

 - compile-time errors

How hard would it be to separate the two issues out?

Because if all the compiler issues and warnings have been sorted out,
it sounds to me like the compile-time side could/should be done
unconditionally if there are no runtime downsides.

Hmm?

                Linus
