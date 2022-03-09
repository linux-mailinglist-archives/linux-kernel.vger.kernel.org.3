Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F604D3CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbiCIWcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiCIWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:32:43 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E2612150B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:31:44 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s25so5269160lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4je0unW4G5dhYAERbboQeaK3T2YDLbSq75BkxjOTCkc=;
        b=NvqzVrCnOoQt5ccdqtnDcaRXHev3N/fZfvAWcFnh1bTbxVAVYlSK/1PikemA2qT9jk
         m8Zz4PK09MV1rCbVfKku3JDVdun0GJbIht1p427qlROuJMB+VRHB8+bcQqya5vF8+bkV
         tFe/oiRBcvfRKEG/xcFzgb/UE23TJ5UDD+ovM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4je0unW4G5dhYAERbboQeaK3T2YDLbSq75BkxjOTCkc=;
        b=pp9W5HtzLhHd/LkeBNmjBtmw3y9ESHB0+y5E3WnCad9lNq6j/2YTuTBEklkEHuHHe2
         mp/aZtIw0PDY97K9l9QXYeGNaX7WehEzzHTVnMgtfgngbg72soxvC4L7tmuUoaubyzVd
         GGDYeSylRUjreBcypbUi/L7UwXnnyo+cDef/QYqmdq4pLEIvj67n6khIagyXfXj3pbnV
         ACo4HwETF8g/ru4IT50X8ANpZPNsaXStEYsF4krzqHMRFjlJpmPtvwaGb5HEGr3dHsQ5
         I4DygfVi09qI6J5W1OE3FuUF5pHgViYHi/0RKhr+qiK1/0PfSa4DampKdxYvQikHy2jb
         lBiQ==
X-Gm-Message-State: AOAM5330AmhAh4E4PZzhBqQnA6q96FalI945F4Js6CkUVPOyqXQomdqs
        9w3TwwKCcV/kDeyByoDykmEoRTO4O6MUsGLOFU4=
X-Google-Smtp-Source: ABdhPJxBeWIiwRHyblziJH8New0zovdS8+TVnj1DSXi0Z9wTOgkAtxic8NSWA6A0DOeM0dJoQnD+pA==
X-Received: by 2002:a2e:9c8:0:b0:248:f8:67c5 with SMTP id 191-20020a2e09c8000000b0024800f867c5mr1113949ljj.19.1646865102492;
        Wed, 09 Mar 2022 14:31:42 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id t25-20020ac243b9000000b0044824f72b16sm617402lfl.80.2022.03.09.14.31.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 14:31:41 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 3so6298913lfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 14:31:41 -0800 (PST)
X-Received: by 2002:a05:6512:3049:b0:447:d55d:4798 with SMTP id
 b9-20020a056512304900b00447d55d4798mr1100238lfb.531.1646865100980; Wed, 09
 Mar 2022 14:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20220309220726.1525113-1-nathan@kernel.org> <CAHk-=wi23APrArHX7bcrvKBDZYpHXbeyEW7dRsirwoSPCKgqJg@mail.gmail.com>
 <YikqFxHP+Y+lecbX@kroah.com>
In-Reply-To: <YikqFxHP+Y+lecbX@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 14:31:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAL3L9gTPp5y7-dweM1xrOA+7aCtG9BvbeQk6Gaz-1UA@mail.gmail.com>
Message-ID: <CAHk-=whAL3L9gTPp5y7-dweM1xrOA+7aCtG9BvbeQk6Gaz-1UA@mail.gmail.com>
Subject: Re: [PATCH] ARM: Do not use NOCROSSREFS directive with ld.lld
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, stable <stable@vger.kernel.org>
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

On Wed, Mar 9, 2022 at 2:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> What about this one too:
>         https://lore.kernel.org/r/20220309191633.2307110-1-nathan@kernel.org
>
> it should fix a arm64 build with clang.

Heh. That one just came as a pull from Catalin. It's now commit 52c9f93a9c48..

            Linus
