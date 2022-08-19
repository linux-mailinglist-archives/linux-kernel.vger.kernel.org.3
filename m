Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E859978B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347759AbiHSIrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347755AbiHSIq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:46:58 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C2CAC4D;
        Fri, 19 Aug 2022 01:46:58 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id h22so2872192qtu.2;
        Fri, 19 Aug 2022 01:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+CK74Trg82hJrsPmCVARJr/hdgf8gZ1Ixa5AUbpaM6I=;
        b=XzjqBAzBRBj096FUBrk7C8/92wcq5CWS5OekMmTDlOAqT1qkPG4EZ8bdjh/bTQl2RU
         iEYRngVWSgS6ztVe0HRniYK+c4VlfTPzgPmyOEStRhiD+6dUs/HuDTyFTSX5HY3BScWJ
         6QtH2akf8+poZbZlkpU2QqJfHdwEJfLadrSuq/A3XSfXTyiBv+qC2KBrDn/fv3K+AjmD
         fRFSbYPfxtP3Ou1h5Qg96e7NSIJAw8NZNq51WpiD4m5mL7hHuNlEKe7I4BXobjyzrfna
         wxSG/G2vIjve9v4bL/VXgCQVvGZs+8eF4FCOcBqhKK4mxRZS+NmFQ8inY/XXwK7lI7h5
         AR4w==
X-Gm-Message-State: ACgBeo2Hk8sIbjGoxQyGbfLcNl0WBXrd564Y3aXeqBuLK22kg6uXNhur
        IZ7AmsK1LsAWmKv3AArZ6G7fbAGwvVpAhw==
X-Google-Smtp-Source: AA6agR7JX3VqGOUpaLoLlGXacU1pVqICG5fmBaswxvqtBzMh7Dc4AMNabVthyzwvFLVn0PneCWxCNA==
X-Received: by 2002:a05:622a:40e:b0:343:7769:5895 with SMTP id n14-20020a05622a040e00b0034377695895mr5750192qtx.467.1660898816813;
        Fri, 19 Aug 2022 01:46:56 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id l8-20020a05620a28c800b006bbc3724affsm2507654qkp.45.2022.08.19.01.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 01:46:56 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-32a09b909f6so105248127b3.0;
        Fri, 19 Aug 2022 01:46:55 -0700 (PDT)
X-Received: by 2002:a0d:eb45:0:b0:333:f813:6c79 with SMTP id
 u66-20020a0deb45000000b00333f8136c79mr6505642ywe.384.1660898815488; Fri, 19
 Aug 2022 01:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220815151451.23293-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220815151451.23293-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 Aug 2022 10:46:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVn50f3HuphyqeGmgzXA_TqHdqDJO7C3YZd=qMA9ZRigQ@mail.gmail.com>
Message-ID: <CAMuHMdVn50f3HuphyqeGmgzXA_TqHdqDJO7C3YZd=qMA9ZRigQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] RISC-V: configs: defconfig: Enable Renesas RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 5:16 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> upstream kernel to boot on RZ/Five SMARC EVK board.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
But this may need a respin if "[PATCH v2 4/8] RISC-V: Kconfig.socs:
Add Renesas RZ/Five SoC kconfig option" is changed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
