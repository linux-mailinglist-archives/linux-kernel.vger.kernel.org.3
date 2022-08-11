Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1BD58FEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiHKPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiHKPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:04:29 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983092B242;
        Thu, 11 Aug 2022 08:04:28 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id b2so936683qkh.12;
        Thu, 11 Aug 2022 08:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lm785/4LPbs1NDnlAeewo858fZRcKAan2W90C0EIZ80=;
        b=IIRxhIa7Ibb07sMCowGUMxUN25XGxDDVCvYNGSQyVPtz/0oyWam40Y2tHcJRyWV52Y
         qXnsS9DHCDS0ekg8oDW7U6vuqZqVRxXIx2FGtqlwZzCg122MqbnUHEqzeJ8yVUlVnBq9
         u200bWqXZTuRnU6AN093dRCnZp92jhuwH0YS4pOGx09bFM+j2duPpOW5oSoFCs4XOiTA
         3RVmTu70KtZVHimJVtYbsplBNmyy/c3b/SIxYo6JUuzrqW5ZTp/5yZff8WIWqvj+f4zI
         5QrmbeSjPt2Dwf4IgJiOez99k31mArTI34qzyt0Z77TJsihnuaw6YBOeYuMkrc/y0llF
         IinQ==
X-Gm-Message-State: ACgBeo0GO3WyXD0sC9IXZdwjONtzfZFzYbXurmIAas4yobHxKq+3owSI
        oLL4FqlwIniSj2TGUnP0XUQQ9cDvm2mSAU01
X-Google-Smtp-Source: AA6agR4+LzpsWWc5e02gdgNaUU33K68XRYMCmYfc0l51PVz2pc6hgTX/ocBfO6Ll6DELm8OFfTHycA==
X-Received: by 2002:a05:620a:4611:b0:6b5:fefb:5fb5 with SMTP id br17-20020a05620a461100b006b5fefb5fb5mr24924795qkb.71.1660230267500;
        Thu, 11 Aug 2022 08:04:27 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a291200b006b5e45ff82csm1159578qkp.93.2022.08.11.08.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 08:04:27 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 123so28679814ybv.7;
        Thu, 11 Aug 2022 08:04:27 -0700 (PDT)
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr27586122ybt.365.1660230266927; Thu, 11
 Aug 2022 08:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220722141506.20171-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220722141506.20171-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220722141506.20171-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Aug 2022 17:04:15 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdMHvYiC+aL-W6F9DjZycY5LCjMpJdCJBdyzUi41ONFw@mail.gmail.com>
Message-ID: <CAMuHMdUdMHvYiC+aL-W6F9DjZycY5LCjMpJdCJBdyzUi41ONFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: renesas: Identify RZ/Five SoC
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 4:15 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for identifying the (R9A07G043) RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Replaced RISCV -> RISCV
> * Reused "renesas,r9a07g043-sysc" string for RZ/Five detection

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
