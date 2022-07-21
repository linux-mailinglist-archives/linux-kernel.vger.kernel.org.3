Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E057C93A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiGUKl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiGUKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:41:57 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9982397;
        Thu, 21 Jul 2022 03:41:54 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id m16so929178qka.12;
        Thu, 21 Jul 2022 03:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZM0L7KaMSxOM/wakTGUefF7pMc1InjFxOidEaSTgOKI=;
        b=l7SEZv1MbWIF2XINR7muGIZED01C62l2p3jelI42OGjyeI9qQlFbNhsVItbVOZZ3NE
         DqDvzavLDaWFrRG6NnVCK14glNUT1XJgA37H7+pReeyBj5GkI4NqAxV7JmWptLv34uat
         da81wEn4Q+NW8xgrB2IQX1LYi0qA8M7qI+FKSPgVCYlKrSHO6fGaHj/71nDcQuAPRFXc
         78vLsJ84LodZgOD6yOGyUH4ZCBzu+/Q0GdDs91zFj/dU/MoEvhFShUI3O6pvV4eYjWlu
         f6BbJpeZHyGDHaPdICvBZk+gk3tfACjyFRPNbA7s9m9b52+BDVHMheQMpdtGCOOZtVrF
         5YfA==
X-Gm-Message-State: AJIora/46cWTOFTnp4NMx4m5mk7mX5GtmKeYCVc4ulsRCvw3pBiSJbrw
        2I/6jjFH6hJuPHsOIB3pNuz2pwaAYTbcPw==
X-Google-Smtp-Source: AGRyM1sz/sPTdTsxLBMziz+RAB/CS0GAoTA5sD6ylXO98epGcXFNriU3nxEAn1BnIyO0jQ+07Unoyg==
X-Received: by 2002:a05:620a:4444:b0:6b5:f7a0:ff50 with SMTP id w4-20020a05620a444400b006b5f7a0ff50mr10831185qkp.211.1658400113945;
        Thu, 21 Jul 2022 03:41:53 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bv15-20020a05622a0a0f00b0031ecce4077fsm1085036qtb.31.2022.07.21.03.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 03:41:53 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31e7055a61dso12418397b3.11;
        Thu, 21 Jul 2022 03:41:53 -0700 (PDT)
X-Received: by 2002:a81:6088:0:b0:31e:79fd:3dfa with SMTP id
 u130-20020a816088000000b0031e79fd3dfamr3528216ywb.47.1658400113296; Thu, 21
 Jul 2022 03:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220718195651.7711-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220718195651.7711-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 12:41:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXiM7S-qB-dgsvP8CfN81SFYJoWfNVyD=4f-TVv6TqAYA@mail.gmail.com>
Message-ID: <CAMuHMdXiM7S-qB-dgsvP8CfN81SFYJoWfNVyD=4f-TVv6TqAYA@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: renesas: r9a07g054: Update pinctrl node
 to handle GPIO interrupts
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add required  properties in pinctrl node to handle GPIO interrupts.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.21.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
