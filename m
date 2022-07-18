Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C18B57899E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiGRSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiGRSfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:35:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EE8248EA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:35:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id fy29so21759989ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wvDVeCPZSKsQ1iYeMyLd3oWMSh1qMXx1KJqR09/AQsE=;
        b=EwLXjpVQO3GPGwx9EHiWHXuUFvxgk+FZuiceO6VnMKQHAqh1pVyaaXS4ceyIIeSpcH
         L/hqkZztVlSz/vxaWsGsgm4BkBiPOafZx9hF/It8EUx+FH4+Xs+F8Anfhp9JVMcin2/v
         oOUJ5W/BUU2E0ppmAklPxWL1CFcOprHfrOyRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wvDVeCPZSKsQ1iYeMyLd3oWMSh1qMXx1KJqR09/AQsE=;
        b=kAspc8uhCclAgPVQ2EmX/kTWtwYodYqVGKQnU4FyJsh275VkuQx+vrelXZjChUoQIa
         VszBfMapl0WtF0kJIre4niAHhO5tRP+xUwImEP7XrASgEXv+NkeDw8Ro7L5hjkvgCqvP
         4EKJPegLOsLROVyq3dvg0TMRdH+Tnwr803tYhdc3cWnpunk57m42iSnAseKvOEOSAEac
         HmQTYqsilCdFa8au+nW/n3eyEgwyvixB747ff90qII3WO1d9NjBxJke3oH03x0EODHBU
         gngKow3sb511fXkh3369b+Q0sYqBSAskvm9KUwQFV7S8KHheNPsK0PICSGVKhidm3TS/
         wihA==
X-Gm-Message-State: AJIora/lsNYOLEUAhZ7zT2yig8/zxn75M2tW70lSWeoMxGvRaVTyQARl
        MA4fYtUfKZhTlhpdb4pS+UhXOI5WosNazlRP
X-Google-Smtp-Source: AGRyM1vVt0Tvp9CEa2uzZUbBGO8XJcVjRO2P927xFebbd592r2HsO+vG5TIPdBiboU6kg6+ebmFg1A==
X-Received: by 2002:a17:907:9803:b0:72e:ec55:b2a5 with SMTP id ji3-20020a170907980300b0072eec55b2a5mr17548990ejc.347.1658169307934;
        Mon, 18 Jul 2022 11:35:07 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7da18000000b0043ad162b5e3sm9021249eds.18.2022.07.18.11.35.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 11:35:07 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id e15so13074252wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:35:07 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr23821149wrw.274.1658169306930; Mon, 18
 Jul 2022 11:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <87cze3docs.fsf@mpe.ellerman.id.au> <20220718134418.354114-1-mpe@ellerman.id.au>
In-Reply-To: <20220718134418.354114-1-mpe@ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jul 2022 11:34:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihbCSydApZcH21hev5pcKu=-CrQgwp6qmPwuv5kMpwxQ@mail.gmail.com>
Message-ID: <CAHk-=wihbCSydApZcH21hev5pcKu=-CrQgwp6qmPwuv5kMpwxQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/64s: Disable stack variable initialisation for prom_init
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
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

On Mon, Jul 18, 2022 at 6:44 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> With GCC 12, allmodconfig enables CONFIG_INIT_STACK_ALL_PATTERN, which
> causes the compiler to emit memset calls to initialise on-stack
> variables with a pattern.

Ahh, and that explains why "volatile" made no difference. That did
seem very odd.

Thanks for figuring it out,

                   Linus
