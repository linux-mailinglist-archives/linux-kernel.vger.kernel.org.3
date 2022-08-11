Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6005458F595
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiHKBfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHKBfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:35:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D596BC0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:35:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id uj29so31064645ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7AXow+QOisFMgzkGzUsU2b4xZ97chTqjQ2G4q81Qm1A=;
        b=YZmiCzheKgtbe31ojEIZRAQvzN7H0JMtocEUUEp7GsbaO6reOoFP+mxgzFDrbmBujg
         uIZrpf/w/auuzr/XFATJ305pt4IDx7blT4oXAqZo/ti31fGZG1xY+349bfkEEFFsSdzc
         nL7VznmKNEWnwYY5fPZTJ06phMH5V1puUgFFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7AXow+QOisFMgzkGzUsU2b4xZ97chTqjQ2G4q81Qm1A=;
        b=dKuEtMyF5mYYWLD95Bh1dVrwM5H0FJM9LuRcgqT6xMVq6A/9DwniKKnh5jhTP5zD4w
         L1DtMGoUPNMdfj5b6vkzm5gXNngjKGQwNWRgd8A7xW63SH3qq4tROI9t/g5dSPNxxdfA
         JNz5N+rRuZhutOnwOPnlkARUeOTP/Ov6x/1d8k8ms9i/2q5+wcEzcBcW3tdi05OpZfe+
         FIwz+wM0EJs2nUPEAgMo6AGvFIyKt0tDruHNGo6CVvf1MWmClmoyAhrHu/1ad4b8F+9O
         DvHhpRfzUxTYhHQib97Oo0fsUHRVLRYNNFk8wxR1ybuE1LgYccqkS9poEEIMpJ0NchAO
         J3AQ==
X-Gm-Message-State: ACgBeo3OU8NU2KlLuajDWRrdJ6TaX2TyicliQycyFHGmHjmxUpbuor51
        sKrVPw1AL9dPNr5OdVaTPSZMZW5kKyw31bvg
X-Google-Smtp-Source: AA6agR7dzzBJhO8wbyq9t6ByYBCBWBP5ag+27h3a9+5twoE4cfx09zxhphr6teKfq0NUZtKn+C0FsA==
X-Received: by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id ga6-20020a1709070c0600b00701eb600dedmr22682037ejc.178.1660181710776;
        Wed, 10 Aug 2022 18:35:10 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id k5-20020aa7d8c5000000b0043cc7a3ff7fsm8422099eds.33.2022.08.10.18.35.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 18:35:09 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso1413452wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:35:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr4001467wmq.154.1660181708418; Wed, 10
 Aug 2022 18:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220809013653.xtmeekefwkbo46vk@google.com> <20220810222442.2296651-1-ndesaulniers@google.com>
 <20220810222442.2296651-3-ndesaulniers@google.com>
In-Reply-To: <20220810222442.2296651-3-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Aug 2022 18:34:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhCF2ivkqAWwY3v7bHd2cT6fiJf1xnRDKzdfUqHbdhuQ@mail.gmail.com>
Message-ID: <CAHk-=wjhCF2ivkqAWwY3v7bHd2cT6fiJf1xnRDKzdfUqHbdhuQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] link with -z noexecstack --no-warn-rwx-segments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Nick Clifton <nickc@redhat.com>, axboe@kernel.dk,
        brijesh.singh@amd.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, michael.roth@amd.com, n.schier@avm.de,
        nathan@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        trix@redhat.com, x86@kernel.org
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

On Wed, Aug 10, 2022 at 3:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Broken up into 2 patches; one for the top level vmlinux, one x86
> specific since a few places in the x86 build reset KBUILD_LDFLAGS.

I've applied these to my tree directly, since I was doing the "fix up
the i386 crypto build error with gcc-12.1" work anyway, and this was
kind of in the same vein.

I want to put the "random tool versions cause build problems" issues
behind us before doing the rc1 thing this weekend.

Those were the two issues on my radar - I'm assuming there are others,
but I can't think of any right now.

                Linus
