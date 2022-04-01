Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AFB4EF8CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349639AbiDARWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242911AbiDARWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:22:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AC4204A80
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:20:11 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id b43so4766197ljr.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E67IK+Jvrwv6W81l4GfGc24c3hT0PbTkiVqWHmGtK9I=;
        b=FcZ8X+BsiTK5mr0/rPhVGjHTnv+cNiWxHv+L3sbH7dgqr9bBSCw25deZIzoeBz07mB
         EVFSxUbwVBcdN25WgvxcMiJ/alnt3etC/vAYbk4WOtzxOoaSMieAoITM47AtdYw1hLfr
         bkcaDG1yUYfc/w5DD4X3V5XPpRkYFdG2QljC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E67IK+Jvrwv6W81l4GfGc24c3hT0PbTkiVqWHmGtK9I=;
        b=CytZfcSnJhsq+5vbI5YTqNjOdyGmZpgE/hKaYqPecoRlMohawFU9H4ec/fZzRUUVdr
         mqu3PmB+t58TRULTzxCa2L6Gs/nzF12jZeJ5hI/dpWrmq0dHygbjdRkyMjNN6nK6Z9Ef
         76R2oR9EBgUqi2s3AY/VGmvqogDj4TVJbK248sxr2aifyw6r3ZdGIrNNP40Sgdtbmv7N
         2G81mt9jI79z1WFznfoRGXE+i8aSBxyn6GNdcpffE82xsQwiG4x9vE/K3A6TXsLHreYF
         Ii5TasEmBaMD6OVs21//IjKUHiq5XN5fbEDdMIwxba36ViLMNDUTtD+v4n3tOMpvQ3AW
         2Ehw==
X-Gm-Message-State: AOAM531+kNVuaYbbwFaGOOxVApBc7iAeute7YT5jjP+m7Pf+p1wYHOYZ
        qEQTn9GtD9oMcQotti0m8OK4z325bR2oTaRs0RI=
X-Google-Smtp-Source: ABdhPJxskH44vKjnr+35d1VDRs15Bo3p99CZ9iQnojWyNc180N0Z4hjJE8eNAITJpufUnolnsPnqiQ==
X-Received: by 2002:a05:651c:243:b0:24a:fb54:31d3 with SMTP id x3-20020a05651c024300b0024afb5431d3mr5010134ljn.242.1648833609894;
        Fri, 01 Apr 2022 10:20:09 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id bq42-20020a056512152a00b00447431cc768sm290166lfb.170.2022.04.01.10.20.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 10:20:08 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id bx37so1059611ljb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 10:20:08 -0700 (PDT)
X-Received: by 2002:a2e:543:0:b0:24b:56c:74a7 with SMTP id 64-20020a2e0543000000b0024b056c74a7mr1694187ljf.152.1648833608533;
 Fri, 01 Apr 2022 10:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <YkZ+K2Gtt75y1/O+@google.com>
In-Reply-To: <YkZ+K2Gtt75y1/O+@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 10:19:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdff1hwOzT+SHzKMGbr+3zc553WU5zvNNbZLdT1TsTNg@mail.gmail.com>
Message-ID: <CAHk-=wgdff1hwOzT+SHzKMGbr+3zc553WU5zvNNbZLdT1TsTNg@mail.gmail.com>
Subject: Re: [git pull] Input updates for v5.18-rc0
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
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

On Thu, Mar 31, 2022 at 9:23 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

I've been watching _almost_ all the pull requests I get this merge
window be nice signed tags.

Yours is one of the fairly few ones missing a signature.

I've pulled it (kernel.org and all that), but I'd like to get it to
that "everything" stage.

I can see your pgp key in the kernel.org key repository, I just don't
think I've ever gotten a signed tag from you.

           Linus
