Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E20855E985
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbiF1ONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiF1ONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:13:30 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE811EC51
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:13:30 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q132so22398353ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ak9fGBSyNTC9/zM2LmAtjsPfz0fauhmhcL7y4wTmPs=;
        b=AWjGfj5bvqdOWR0OCeEbsZwXgKhFXY1IVpM59omVQIQ5g9UT3qIVK+sTls/SSa8N0u
         gNKxXtFnuCj8BwgRlShIV6JZ7rRPMV0WYd/Z3v5UP6m4nht2KvodkA9Ra5fSqwgpvT1A
         6odq10H/hYXdyKO68R1v/pgTC24/DPfGWy+I5KQJRi8NqRUkLHKvw8x/nL474HqXUPuO
         Wn8AKWrpRfmNr2+TsU7XoTRiQkpz6cdKZF7OHeT6yM6qK5EWaEfzpk0VRWJjsnMwQ/VB
         ldZXGycBnyUmJ6+6Auv9MiEwoy/75pubtFPA2hsaqieRS1YF/P4QuQHbO/rida3LwNN7
         g9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ak9fGBSyNTC9/zM2LmAtjsPfz0fauhmhcL7y4wTmPs=;
        b=tKLntu0V5TZDtkuuIZmvx3Napi5ETgqde2biQvcFh5xwzavx+vLVwouxY0Z8/sT+xu
         kqAe7h6Mv51dYZZaKq2HOBhj3Kj7PipWot7OUW6hNBnbmpdQPVJexJItykh9Yn44oNqq
         lgV1Cic2iNrXhAmoVjDDUzFnCTCjLLJvXwtLNKfIOJ75Btt6x3zVNGHBSxa6t7GbSFMM
         m9C14mDSE5qBP5Rty/cUPuKy7CUq/WiuQyfSzQoxWdenmpZvG/folqiSJVq0Sdi1cq2f
         oAYy09BSllgwZPdWaKzkQOgl9mXQ90oWjolWr7DTjUv81G/BhxfBOC0I9riqQr3WL4sk
         DSCw==
X-Gm-Message-State: AJIora+7Z5y3KWol/c3cXsln7YTms6pemcplIj+NF6cycObohL8q0IQ8
        X3BCWuCfozB+9fF/rUN6ZksCFMKVqOjJPIy3ZkX41g==
X-Google-Smtp-Source: AGRyM1tzbdsFHeeYT4fOTsfzgP49TpefwICfzEQ63caT6oTXLjkLH1NlVPVj5M+nSxqLxg5MWOERTK9fRabKLmHP74g=
X-Received: by 2002:a25:cac5:0:b0:66d:2c32:8593 with SMTP id
 a188-20020a25cac5000000b0066d2c328593mr3202257ybg.626.1656425609426; Tue, 28
 Jun 2022 07:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220627142350.742973-1-fabien.dessenne@foss.st.com>
In-Reply-To: <20220627142350.742973-1-fabien.dessenne@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 16:13:18 +0200
Message-ID: <CACRpkdZQNs6BgchbxFN4rHzk41xUnJKcxKTi78xTduq32y4urQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stm32: fix optional IRQ support to gpios
To:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 4:24 PM Fabien Dessenne
<fabien.dessenne@foss.st.com> wrote:

> To act as an interrupt controller, a gpio bank relies on the
> "interrupt-parent" of the pin controller.
> When this optional "interrupt-parent" misses, do not create any IRQ domain.
>
> This fixes a "NULL pointer in stm32_gpio_domain_alloc()" kernel crash when
> the interrupt-parent = <exti> property is not declared in the Device Tree.
>
> Fixes: 0eb9f683336d ("pinctrl: Add IRQ support to STM32 gpios")
>
> Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>

Patch applied for fixes.

Yours,
Linus Walleij
