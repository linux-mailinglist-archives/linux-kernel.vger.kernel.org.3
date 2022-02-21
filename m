Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742914BEB10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiBUSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:36:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiBUSei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:34:38 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41EDE08
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:32:17 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id f11so8146198ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V53eWTyFzxXJsbz+KFVi3xpj3YJA4O3z/bAQ81RYVTo=;
        b=bHLqVIqXmciNyNIryl4JvTW1k3xPS3riIMOsdTzw8F5qtWIlFN1PUlW1XUtMszynwQ
         nOW9RAkEfmlrpOACs2jEptbmnWRadW1x98jfNTMPDdkq39kLfLJq5gfKZdgWu+Za8Jey
         OpyfRrlzj+SEmphpzlP3Lg5eHyTGLoPPk9N74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V53eWTyFzxXJsbz+KFVi3xpj3YJA4O3z/bAQ81RYVTo=;
        b=KE6HwCXHrnal72dhRUkJrsIEGIwcTtdZZiIGSUvSjtNHgplZxm0ek+x0+1IayF/r1o
         O6qiHWHDGO6DTsjG5coQm3p/t5ug2hhV6s3JUOq5GZrDMhayD3lUj31C5sSsUsdfKbHR
         vl3dKBCNCVh1ZPW0xm48xUCwkbyoyqyNSvh2Hhol0fNOQ+OHFKHcPPJfFYdXrbwY7Wbi
         WSlLp3VtioMKJUXJroQcDPaOEYrBhONL2UY+LtV7pHT5ABpMnF7Ac5FkarvmtxD/Tvbu
         vYTH+n4ZoZhoO2yiQuxZV2o10lm1bPACDSb+z9Vtda0nkAEueQ5BziLKrcWnPo8UmZzW
         skNg==
X-Gm-Message-State: AOAM533hgFEf5UPnfjWqO+6gUS0f5FuFXdALELtiStXGfWHXqxPNOUti
        qXFx1v5u0kOlbVfbfQ78Mt+o7AE41eXtP3t6
X-Google-Smtp-Source: ABdhPJwScL+5BVbBJJb7Lzoi/D2/gv+60yyHeKtrixsBamUvcGXjTZeEBPLU/WsdsXmhk7LjAa1nDA==
X-Received: by 2002:a2e:2a45:0:b0:246:430d:805 with SMTP id q66-20020a2e2a45000000b00246430d0805mr2608778ljq.439.1645468336069;
        Mon, 21 Feb 2022 10:32:16 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p20sm1175353lfr.175.2022.02.21.10.32.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 10:32:15 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id j7so20246117lfu.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 10:32:15 -0800 (PST)
X-Received: by 2002:ac2:4211:0:b0:438:2f1:83c4 with SMTP id
 y17-20020ac24211000000b0043802f183c4mr14986464lfh.435.1645468335096; Mon, 21
 Feb 2022 10:32:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wiWZ=3dTuRq46KvQVpx-e7xqrnMAVB73dzj7g4Pbwc1zg@mail.gmail.com>
 <1778a683-30fa-9119-c3ce-2dddb5939809@roeck-us.net>
In-Reply-To: <1778a683-30fa-9119-c3ce-2dddb5939809@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Feb 2022 10:31:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyJOBhc9PQr-iAW7yYWoni8Gr+O30vtwDR--opn8hyTA@mail.gmail.com>
Message-ID: <CAHk-=wgyJOBhc9PQr-iAW7yYWoni8Gr+O30vtwDR--opn8hyTA@mail.gmail.com>
Subject: Re: Linux 5.17-rc5
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Mon, Feb 21, 2022 at 10:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Oh, that is "just" the result of the netfilter build problem.

Oh, ok. I assumed it was some runtime failure since it was under the
qemu rubric.

> The real question is why to patch introducing the problem made it
> upstream even though the problem was reported several days before
> the push request was sent.

Yeah, there's a separate gripe-thread for that. The fix is in the
netfilter tree and has been there for a week...

               Linus
