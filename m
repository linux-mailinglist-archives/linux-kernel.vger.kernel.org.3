Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C13564FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiGDIoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiGDIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:44:52 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208EB87C;
        Mon,  4 Jul 2022 01:44:51 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j21so14629223lfe.1;
        Mon, 04 Jul 2022 01:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wvvDrPdMiWD2bKHNoXzQT9rzvWbrQJdRittsndPYoM=;
        b=xcWyEnjRX4la4FJyp6L3L1HKjN/zzxvfDc88zuDX1vWws3bAEMKEKpYV/gT/idNgzy
         oT9t0fnyYLClVHG5c+sDDYfzUlgARvAKxq3d9Qv5p9u2H9KvDKBU/sCiTfqCv/lCyem1
         2ut5yI7+Alc1geF26vKj6+/VEGLxXOVLndPWlO67FG62WX3AOZwFawHGJI+8tlVkCUfl
         CRI8vrFy+MaJJMRVA5LcDOe8snBmjGPcPkYAhe2WTDVvm3Q4czAwuMIhHD8/Yc/fD43V
         RQ7PwejH5y1RfOD3wFHY7oe41/lmdAck4Bm0hoSIFfWXovOFmjPbfwLKxFs5bkqztqRk
         x57g==
X-Gm-Message-State: AJIora9EuRVxWcluZYOFrV1Ey0i1k9+khd9RYyMBZgo6UsLvwT46+0GB
        6quM0IcaUcyLydNYcimiC+jEr92xqkbzxf1Y
X-Google-Smtp-Source: AGRyM1tIAD2gDbVwR0taNgi/mVkd3JFXcD4fx4aHkSlpTAnl3gJJeuLCPJhXGnmq7euqgdViuEDv3w==
X-Received: by 2002:a05:6512:1691:b0:47f:ae89:906f with SMTP id bu17-20020a056512169100b0047fae89906fmr17885871lfb.229.1656924288889;
        Mon, 04 Jul 2022 01:44:48 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x2-20020a0565123f8200b0047f8132d10bsm5018352lfa.281.2022.07.04.01.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 01:44:47 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id v9so10187121ljk.10;
        Mon, 04 Jul 2022 01:44:46 -0700 (PDT)
X-Received: by 2002:a2e:9203:0:b0:25c:785:8c7c with SMTP id
 k3-20020a2e9203000000b0025c07858c7cmr8066041ljg.383.1656924286419; Mon, 04
 Jul 2022 01:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220703194020.78701-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220703194020.78701-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jul 2022 10:44:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDQYp+ub+GW8mBb=fFz9KJH5ZwxKe28cDj_0O6E0FN+w@mail.gmail.com>
Message-ID: <CAMuHMdWDQYp+ub+GW8mBb=fFz9KJH5ZwxKe28cDj_0O6E0FN+w@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] dt-bindings: interrupt-controller: Add Renesas
 RZ/G2L Interrupt Controller
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
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

Hi Prabhakar,

On Sun, Jul 3, 2022 at 9:41 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> Add DT bindings for the Renesas RZ/G2L Interrupt Controller.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

checkpatch.pl:
WARNING: From:/Signed-off-by: email address mismatch: 'From: Lad
Prabhakar <prabhakar.csengg@gmail.com>' != 'Signed-off-by: Lad
Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>'

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
