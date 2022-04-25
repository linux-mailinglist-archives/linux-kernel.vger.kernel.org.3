Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5A50EA84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245516AbiDYUbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245526AbiDYUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:31:15 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E4C13597A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:26:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id i38so10183852ybj.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1ClqhRYmz5HXClsBXkFldoXhUBQuMz5hmz04W+s5Ig=;
        b=SV3IRHMjAU9BfJwPNilSNBAcSVoAMOWBYYLA0e0oQyYiMxf9Nw9gWUTjBEk1CBmTAs
         Niw0SWuKhHt9jGq49BeSNAl/1cSwK+zxQlup5uCwMDIJhM2M3gOatO5JAwKArsRPQdPg
         aZnw8RNIcruOOrZt2tMc7EtM/RvF3NZufVbPaibATHZ20a6nWn0Lox/FXS7nX2R6btqq
         RMvfSvYfapVFh2Iirdot7fAegoabbm2ZR8ThDF6g4O5Wlaygky63T93y5nfmyCtIjLDp
         eFIchiZOCIFYoVPeaYVlpwdCHEkCXO0AnC6c+N8pNojcgtdoGD0N+y/GrrBhsPMl4oFk
         MtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1ClqhRYmz5HXClsBXkFldoXhUBQuMz5hmz04W+s5Ig=;
        b=gr6PA+/ky98fp67MDhgkCmXAnI0ttCYlx3FEhvdBXoUJ1XdVO5inAwPs2U5Ldlc4Md
         ZrJfVsOAlnU69aNdQDnP/yGQDwFqN3jZLI/H2ag3olwOvNj/TC0WQaQLaX2RotUht2NU
         2TxG5sT1CkNTp9AxDr7FRLeBnFrOyjlp3urbYA16gSAN12ITsrB3IUCw0AZg7DiWSQvB
         0ch7zv13UJpitNqPoSWUK4iLhiRJgXpDfzWuVrkZfsW465xh8hOXnD8EJQYe68RvO54/
         idsj+sa8UiloJ/pcxPXAtEYP6i6YyQ4whSurXk8pdCDaD+/fj4QbqcPsjhrOzY+H1kz9
         9gqA==
X-Gm-Message-State: AOAM5300F9dvVQo6v4uX7Na2Pd5tD6/a2YpG9wfQWolj0Ut38sB0kAHC
        HYRZQUoEGu7d80vooy+fJL6SNLs/gigM8s4y+Wy9lg==
X-Google-Smtp-Source: ABdhPJxB+vfWOOzXZiU6MC4ksRjAF+ObiO6SpIQGl0f3Kgfoajj+j6ai/aqm6x0QGRFBqrGJF5F8tyZTrczeruOnEvI=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr6378314ybi.626.1650918390364; Mon, 25
 Apr 2022 13:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220425171412.1188485-1-sean.anderson@seco.com> <20220425171412.1188485-2-sean.anderson@seco.com>
In-Reply-To: <20220425171412.1188485-2-sean.anderson@seco.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Apr 2022 22:26:18 +0200
Message-ID: <CACRpkdajs2TUe-E+y6RaroSc1bdpHwUOhmZ8FgPrdFj8g4L1Aw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 7:14 PM Sean Anderson <sean.anderson@seco.com> wrote:

> The vbus-regulator property was never actually read from the device tree.
> Introduce a new property vbus-supply to represent the regulator powering
> the VBUS when acting as an A-Device. This supply will be enabled and
> disabled as necessary. Note that this is different from vbus-regulator,
> which represented the available current available to draw from VBUS in
> B-Device mode. Because no one was using vbus-regulator, remove it.
>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
(...)
> +  vbus-supply:
> +    description: regulator supplying VBUS. It will be enabled and disabled
> +                 dynamically in OTG mode.

I would add a small text snippet like this: "If the regulator is controlled by a
GPIO line, this should be modeled as a regulator-fixed and referenced
by this supply" - it's helpful because otherwise people tend to start to
submit weird stuff like adding yet another GPIO for this.

Either way:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
