Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB5524679
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbiELHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbiELHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:07:15 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCCF4E3B1;
        Thu, 12 May 2022 00:07:10 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id n8so3972146qke.11;
        Thu, 12 May 2022 00:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGw8ncaGNVV4G0SqeS2qCZWEWhg4F6MASDrmPWZbwoY=;
        b=qI1pmKeqotCs7fUyimxURl4MUs87QCAoKQOIOPROsC60J5yqP5kXycFeBQPv+QbYpd
         XvfSWK7k6rofgzknz/qDI6JjNZPy0pMbrUwXU0hL1zrfbEOZb0KkGzzbJPBclDckVLLr
         C6DKIY3Rw0mf48xH/Jn1T7DL5WF2WtDFhv4xzBmxnhOa5PurUQn9nH+tXzQyCn0GhCHG
         SPSIpAywkfSyt+MrIIOH0zRaIIoAcbS9nW4pbalf8VG59LaZ2CNShLrRuWG3neHuVrVo
         o3FKwbEdgXwD00c8clERNYvs0XVkA3tQINmtsSpi4XhPpRC9GxwoHeGhZHh0O5SkIzSQ
         0sYg==
X-Gm-Message-State: AOAM533miV+OPPIJzkOS2tEVfbY//r2RHX3BakvJ6rMQpXe9/vNWz9w+
        nPq+yaRm6/tfkHg6W2k0voT9Stx4EyVc/w==
X-Google-Smtp-Source: ABdhPJyEeTMon2D3jM8SxhzMxjsFXJidW/D8zBbzCWizuBD4AIJ+xHGSEI5R1a1L+hJneFlX4kI3Sg==
X-Received: by 2002:a37:660d:0:b0:6a0:72b9:bb7a with SMTP id a13-20020a37660d000000b006a072b9bb7amr15145794qkc.732.1652339228880;
        Thu, 12 May 2022 00:07:08 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id z21-20020ac87115000000b002f39b99f6adsm2446948qto.71.2022.05.12.00.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:07:08 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id g28so8073850ybj.10;
        Thu, 12 May 2022 00:07:07 -0700 (PDT)
X-Received: by 2002:a05:6902:389:b0:633:31c1:d0f7 with SMTP id
 f9-20020a056902038900b0063331c1d0f7mr25940095ybs.543.1652339227489; Thu, 12
 May 2022 00:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220511183210.5248-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 May 2022 09:06:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXNzA=XsoiPAWrHQ_mCDvH9pgC+tEUuKzd+VheyrRVe-g@mail.gmail.com>
Message-ID: <CAMuHMdXNzA=XsoiPAWrHQ_mCDvH9pgC+tEUuKzd+VheyrRVe-g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
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

On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Allow free() callback to be overridden from irq_domain_ops for
> hierarchical chips.
>
> This allows drivers to free any resources which are allocated during
> populate_parent_alloc_arg().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
