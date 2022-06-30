Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAAC561607
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiF3JRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiF3JQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:16:56 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147A248DC;
        Thu, 30 Jun 2022 02:15:47 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id c137so13952945qkg.5;
        Thu, 30 Jun 2022 02:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9Vssd5sS4spcwdMP9Swa2WTwEcZk2KwnOex4FXzpQQ=;
        b=5A73qbb7M2HWdUOpVTFz1MxrxR0zILLX93wQTFnDa3K+a5kIO1XXBFFCAbteNUuExl
         UqLaQ/uwl0wVXT8pAUX7ZrdwHtUHeds5MA+xqS6UDteonpryxo7YxLzebcGy6336FZQc
         SiLwE2aOu7Uhz9umTksdVNMFwG2UktqRqMlBQzQoTEQhtRE0D5q7kYpVjwUF/2vvjpad
         SxWqJfVmm4o2a3xYvI4CLaVIVMRPpNwmBtZrkevaNXZV5fuTaAVd2sZZbkc5XHmVGivq
         AWhDEdwdKgpKYv3V0fc+lZXIbFeO4/VnrxjW0vRo6g7iRXorioPh+6O+9MpKwP+RGFUd
         XSYg==
X-Gm-Message-State: AJIora8oh8dEi2eHL4DGsT6/SmtLmNoCEkE9lYdiscSDjnSwzjalUzWH
        lk5fWAXzf85iJtzUFahOkuC7sw/od19aKQ==
X-Google-Smtp-Source: AGRyM1sceO94cADuSaVS9v3Qq5KWl2vlpisVMQq8tiQUP0ZBwqVECrdZ5wA/yvVWcljxJx3KdXDP6g==
X-Received: by 2002:a37:5383:0:b0:6af:373c:ebfb with SMTP id h125-20020a375383000000b006af373cebfbmr5436369qkb.475.1656580546377;
        Thu, 30 Jun 2022 02:15:46 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm10996020qkp.130.2022.06.30.02.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 02:15:45 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id d5so32641787yba.5;
        Thu, 30 Jun 2022 02:15:45 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr8111243ybu.604.1656580545430; Thu, 30
 Jun 2022 02:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656341824.git.geert+renesas@glider.be> <2fd9b9e3f60fe555d9dcad499c90e3ec869aa96e.1656341824.git.geert+renesas@glider.be>
 <c65d6a94-b5c2-e2e4-6fdb-b7982d291e01@linaro.org> <CAMuHMdW=s42sfFwimizTsNjyKue+W9NasTOG0jgjkgkoKv3wfw@mail.gmail.com>
 <bab4d845-330e-c7f0-5dac-a96caa93a39e@linaro.org> <CAMuHMdUuU4qtfYh=hpY9bWMLKAnz83Oj8f=M9_iUxmR+Zetsow@mail.gmail.com>
 <c04c3691-7be3-afc5-4f95-2b06ee402c0d@linaro.org>
In-Reply-To: <c04c3691-7be3-afc5-4f95-2b06ee402c0d@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Jun 2022 11:15:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEeLuaG_sgYZudKv8fEpExdHz4grFj8a6DuzdRng+u_w@mail.gmail.com>
Message-ID: <CAMuHMdUEeLuaG_sgYZudKv8fEpExdHz4grFj8a6DuzdRng+u_w@mail.gmail.com>
Subject: Re: [PATCH 5/7] memory: renesas-rpc-if: Move resource acquisition to .probe()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Jun 30, 2022 at 10:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 29/06/2022 20:48, Geert Uytterhoeven wrote:
> >> You sure? Except rebasing I don't see that. rpcif_sw_init() received the
> >> rpcif so it had access to all fields.
> >
> > Yes I am, don't be misguided by the name of the local variable.
> > The rpcif structure is allocated by the HF or SPI child driver,
> > and thus not available in the RPC core driver's .probe() function.
> > The rpc_priv structure (as of patch 4) is allocated by the RPC core driver.
> >
> >>> I agree patches 1-3 could be moved later, if you think it is worthwhile.
> >>
> >> This would not be enough, it has to be first patch to be backportable.
> >
> > I can make it second? ;-)
>
> Why? The point is that this commit should have Fixes or Cc-stable tag.
> If you make it depending on other non-backportable commit, stable folks
> cannot pull it automatically.

Because the current driver structure does not allow us to fix the
problem in a simple way.  Hence the need for patch 4 first.

> > Note that that still precludes (easily) backporting s2ram support.
>
> But S2R is a feature so it won't be backported...

Working rebind is a feature, too?

Actually non-working s2ram is worse, as it returns corrupted data
(haven't dared to try writing after s2ram yet ;-),  while non-working
rebind means you just cannot access the device anymore.

But note there are still issues with s2ram...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
