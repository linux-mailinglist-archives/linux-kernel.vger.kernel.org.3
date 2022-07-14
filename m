Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4729575744
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbiGNV4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiGNV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:56:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6869A3DBE9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:56:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id os14so5814543ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2h7rSRvHiDfpV/JqGRkiaejTHAdpZEG7Nka6Pnjwvpo=;
        b=FAJHcFc6Pyx6GGP8vdmgf+D87FHKZIDU4UUfWsXA0WewkwL17U/1QlPKqu4O/F8LE9
         JfpMTCmZoPBCS8TLm4xmpgZBOQo9wDEYpKkuh3sullDTs4kLFk+Oybo3QTYXyGsvBZDD
         VeeHRypWibElYQzySO6Uhn086bFCNc6RzuQPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2h7rSRvHiDfpV/JqGRkiaejTHAdpZEG7Nka6Pnjwvpo=;
        b=0gl8000tU03+PiX7l+o0rhUpxjo9tfNmkB3O1Nx+y1ppiLusSmDDoCFGrp8y7DzuP/
         zjqY9O4pGvVPEi1KCAm4H8GvY+N35tCz/mcC0CdQhJBlCV01EGx6Uj3NiyUFO+Wu9iVu
         RGdBEPrfpi30zeOz/uogmBnfJuhOYpQiLfc7bySCSPw226nUWs6vfPV1ohRYF3lVKDre
         3WN8GHFmqitEsAdGM6hTZh6AKM0lAzWVEtZeh01X49RMyvNJcubc0r6ZjIYSwnoenMKE
         US9rJNqngQzX9F0kssfV/vSh/Xbve4NoJSsqqR0o0QzkJ+ZMT2V+w+kyzjMKcboQc4Kw
         X34A==
X-Gm-Message-State: AJIora/vV0ZAm9n+gbx6DBLXZVhfAEnI/nJJHT1jpLBNY+W3XYuMV+He
        s1/GAztFBkSUEmvtAE7ELAncihN4uouXjUHUGKg=
X-Google-Smtp-Source: AGRyM1v9INDl55NwoYw9JyoAhSkr1ms+2WGbFd2J42HP0g3A/otOQN6K/kjL/JIGaA9z2J/D2F4sLQ==
X-Received: by 2002:a17:907:6287:b0:6e1:6ac:c769 with SMTP id nd7-20020a170907628700b006e106acc769mr10918937ejc.388.1657835790801;
        Thu, 14 Jul 2022 14:56:30 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id lc8-20020a170906f90800b0072b609d9a36sm1213112ejb.16.2022.07.14.14.56.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 14:56:29 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id p4so1834396wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:56:29 -0700 (PDT)
X-Received: by 2002:a7b:cd97:0:b0:3a2:dfcf:dd2d with SMTP id
 y23-20020a7bcd97000000b003a2dfcfdd2dmr16997798wmj.68.1657835788646; Thu, 14
 Jul 2022 14:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220713152436.2294819-1-nathan@kernel.org> <20220714143005.73c71cf8@kernel.org>
 <CAHk-=wi+O_3+uef45jxj1+GhT+H0vXs9iz8rpjk49vCiyLS4DA@mail.gmail.com>
In-Reply-To: <CAHk-=wi+O_3+uef45jxj1+GhT+H0vXs9iz8rpjk49vCiyLS4DA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 14:56:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeVbrd3HOMh-t8968pMgZUFs6uP-p45Fn8qr27j8D0aQ@mail.gmail.com>
Message-ID: <CAHk-=wjeVbrd3HOMh-t8968pMgZUFs6uP-p45Fn8qr27j8D0aQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/speculation: Use DECLARE_PER_CPU for x86_spec_ctrl_current
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        stable <stable@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
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

On Thu, Jul 14, 2022 at 2:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But if this particular one causes problems for maintainers, I can
> easily just take it right away just cherry-pick it from my own
> test-tree to my "main" tree.

Oh, and as I did that cherry-pick, I suddenly remembered that I think
PeterZ had a slightly different version of it - the one I picked up is
Nathan's "v2".

PeterZ, do you have preferences? I've waited this long, I might as
well wait a bit more before I push out whatever version people prefer.

              Linus
