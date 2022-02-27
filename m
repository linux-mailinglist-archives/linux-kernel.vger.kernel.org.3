Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DADE4C5ECB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiB0Uj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiB0UjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:39:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385DC6E546
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:38:29 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id v22so14754556ljh.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9xhZwaxUuMiS2YT5xPkv6KeE3gRj8GLelmcYGjQjfc=;
        b=HNhkInAoG//sp9xFN6zmJL6sLovoGy26g7FjBTKa/4kA94lIEccpn4y2F0GU0emrRb
         M063ohN1Jr77irshWpKDEv2h3KFpcTzLhtfmyZeYrkz8yaq1l7yzAKmhtSemockShu2a
         SE0jMAbWBb4HkSxF6fAH5LzIdGUhK8c/rspjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9xhZwaxUuMiS2YT5xPkv6KeE3gRj8GLelmcYGjQjfc=;
        b=4fDqGf1lPnd0sxlYvmSrBYBaqKBllzKQT3RXv4DowaKIwefrbkdZO+gMp5nc8M7DFf
         5fAlDK4jQ6e0wjq9MycOYBIzBTsISPxUbgCy/ELFWGB24Cn3JJzJwOGUw/QIxS7NIBJD
         DIBFH8CabpVvFxv5no/jr4JfaRTuNZy+f8vh5P+iJ4kemV/p7JyZUnsS3lzuur9fcjFQ
         1fsLe99MMOZ1k//gP2JZ2/yC2VZ1V68VaDQdSKeMyBJtcx4iSck30aHDTOecRnXKj6Hv
         RlSue9DedhLkQg3FPfgAsG+GJCiFYpgV2Qs6ofIUgeZ4DvOJJFEaKFxdvuVr1uLhXIWh
         T+2w==
X-Gm-Message-State: AOAM531NzIpRuoUyqUbEDgIb/jFSWPhmnQDp+GmuU7If01M02PIdTmkp
        QX3t5aMofA0DzhPRJ2XNUdkiFL0YyNvrXzvbUx4=
X-Google-Smtp-Source: ABdhPJwiY8EuT5m0mNsklOc0xSA1RVEDmpOg6qB4Y4gMMDSegxOyOtFRj1N8oj9AHwr79yvSOoDgXg==
X-Received: by 2002:a2e:9783:0:b0:244:dd26:c0f9 with SMTP id y3-20020a2e9783000000b00244dd26c0f9mr12135402lji.461.1645994307347;
        Sun, 27 Feb 2022 12:38:27 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m2-20020a196142000000b00443d65ea163sm727994lfk.248.2022.02.27.12.38.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 12:38:26 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v28so14714096ljv.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:38:26 -0800 (PST)
X-Received: by 2002:a2e:80c6:0:b0:246:3334:9778 with SMTP id
 r6-20020a2e80c6000000b0024633349778mr12342769ljg.443.1645994306221; Sun, 27
 Feb 2022 12:38:26 -0800 (PST)
MIME-Version: 1.0
References: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
In-Reply-To: <CACRpkdYM21hcH5d9rXyvjMPHQp429OZ1Zcy7uLU2tndoJcOmUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Feb 2022 12:38:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
Message-ID: <CAHk-=whg3eRY1nOJjHam+jORmVymU539CxhBUjp4=tGoFitotw@mail.gmail.com>
Subject: Re: [GIT PULL] pin control fixes for the v5.17 series
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
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

On Sat, Feb 26, 2022 at 5:11 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> some more pin control fixes that trickled in the last week or
> two.

Hmm. Am I confused because I thought I'd see a fix for the orangepi
problem that Guenter has been reporting?

That problem has been pending for quite a while now.

               Linus
