Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5280581A64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiGZTl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGZTl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:41:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A481B782;
        Tue, 26 Jul 2022 12:41:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t22so17735760lfg.1;
        Tue, 26 Jul 2022 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y73Cbks80QRaio2NF1SNbgs1LhYqx782nVW2SB+9Lm4=;
        b=YMoEDzJyIqDGYPZ7iyFn6c9nULvNilXBrX/9GQARqgB2M+Gw+IDQUWwSP33U/JwZA/
         zkvgFKTc2ZWYboqN9FgfIzWIsSD1SpICZ+zI0IvASGms9JPe03pkdssCEg1q3fcFieh9
         a9REYm5D7TTl2U2DGrPtvO/eWDMhlCoBrBoaf/WzIvnt26kUBMTQKBKjCn8GwC4Bt5wq
         wgf/UdQ/wOa9bHyzxAmPvNZAFF+lkIY24NvmB5nkHqfHDxe1gQBHobhcPfR85vuO2EFS
         edv35OOfF4PzLxANBkVcMOZTgIAw8MDq3zF54npNNZldaMPgaY0Pa/DKKz651AMpIZUh
         5dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y73Cbks80QRaio2NF1SNbgs1LhYqx782nVW2SB+9Lm4=;
        b=NZf/WWNV8AnSDgfTFaVZDIeqZAvbq4gS4bM7ZQNRpTN4/+8PXnFDTnTYg5T/5l1VS3
         EOVeNvxTjguKwGtz3QAccwiRqB1LTpfsWLDs5sdMqUUtYU/0KIQj5wgzFXqjTELbeAfY
         WIbw+ONnghNETEQOhTf+inwLC3byl84xYbGfUfKQZnvI9eaP/XzxBoPiap7wXBgnZuBD
         zpO/dBty0bjqK1Y6CTYkSgfpKx8CnB0au1hliiZVYymJYBoe65B1psHQtDeLZKp5nWFT
         pNAdxKeA6JGcaPYHrQ7LI/rr4D7C+LhDOodxFtm93QM3qYRhj8h9c40JTus/Os6Z6B40
         SqKw==
X-Gm-Message-State: AJIora+aD5NXQ0kT5GlIrFUKm+XmekZvgOygljhqQBDpQ/cUisHJgpXO
        dTqIyWZiT828jYlojCOwXjHEMU6ivT0eRBtdP80=
X-Google-Smtp-Source: AGRyM1uzC0o9Fyo0i233ZCX1c9oID7O1iPLRwqGSKX/Inr4uy4oQP80W/cr5a9qufJPHij/iX4kvsXVp2LMZnvRL62o=
X-Received: by 2002:a05:6512:22d2:b0:48a:1ec7:2220 with SMTP id
 g18-20020a05651222d200b0048a1ec72220mr6678625lfu.668.1658864510492; Tue, 26
 Jul 2022 12:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220717121124.154734-1-tmaimon77@gmail.com> <20220718125155.GA40038@minyard.net>
In-Reply-To: <20220718125155.GA40038@minyard.net>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 26 Jul 2022 22:41:38 +0300
Message-ID: <CAP6Zq1haOErfj2HZkqKwXZKr3+QvWP2VYK6QQOH5cjHYJ2rV0w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] char: ipmi: kcs: add Arbel NPCM8XX support
To:     minyard@acm.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,


On Mon, 18 Jul 2022 at 15:51, Corey Minyard <minyard@acm.org> wrote:
>
> On Sun, Jul 17, 2022 at 03:11:22PM +0300, Tomer Maimon wrote:
> > This patch set adds Arbel NPCM8XX Keyboard Controller Style (KCS) support to
> > KCS NPCM driver.
> >
> > The NPCM KCS driver tested on NPCM845 evaluation board.
>
> This seems reasonable, I've pulled it into my tree.  If anyone has any
> issues with this, please respond.
>
> -corey
>
> >
> > Tomer Maimon (2):
> >   dt-bindings: ipmi: Add npcm845 compatible
> >   char: ipmi: modify NPCM KCS configuration
> >
> >  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 5 +++--
> >  drivers/char/ipmi/Kconfig                                  | 6 +++---
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > --
> > 2.33.0
> >

Sorry but I need to do a little fix in the document file.

Can I do it or have you already applied the patches?

Thanks,

Tomer
