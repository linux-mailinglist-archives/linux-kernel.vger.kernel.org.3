Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43141480BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhL1Q6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhL1Q6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:58:41 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D5C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:41 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j11so40853085lfg.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zrQnwrOYo44Zy15SHr8SgN0Chy99tnjGBiLMnJFezuA=;
        b=BmyOQ+n+2q8EtIH/+W2DQ5gXaSxydrZiDK9gQHpDFhjnKjR6A8ZiGKOFENrAsf6Kup
         7ZLAlzKRdwHSiPXOZhv7qImo9MVw0HrNTvk8cWiatYdoPJkjmx19D6e3+Zjwof54ELdh
         rDzOQJb8fwd8ex27GBGO4UTLQ3rCOBUXN8Wmi9bmDLnUWhoMgbZtH7yelbeYBB1sYK1c
         VQs6bRoXLKz/h0t+7Z5LMKBkLauP9PBtroxAEcn01Smq8JU0Mp2DOcS1CXKKyGSTke8I
         K6dya80J5nEoQmQ8hMXysyICDX3mgBxEhYMCysmu24r1wSPnKD+Zf1P384FKCozPUIS/
         2HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrQnwrOYo44Zy15SHr8SgN0Chy99tnjGBiLMnJFezuA=;
        b=fh9S2Wi1IBadKbySlp5mpXfpnl4rSFcFJoUts8jMi2Wskc+fDrWW/BQInSlXj/u7co
         iLUU/RY9gXk92OM3rZxxDT+UQooRAnvKZpkV+1asNKS45B3BmLpLAmp8MepWMKSS5WBr
         Eqnr8qFk0qwY1YnpxwL6VC+9sMLqF9oFbmOe+sc7J9agjyF5PSNYNuk4JBU2kWu7Pe+9
         kCH9erpt/S//Rt0+xNxasV5hFsTgI9VMHRY3nTQ9fFFWvTOpZ3IztKe6+6qdd67kYRc5
         LwxP7A867ZHWjXrxueRjiHk4JW67tZYtLNWIcgoT60++DZUXL1fBm3ecpOu1KwPbU3+K
         QzXQ==
X-Gm-Message-State: AOAM530KOxQxkDzXIqN0qXnGf4nNFR2lZGfDP0R1VnbhUX3oX1Prc0tT
        g3MQ+r/eINZqm7/ordnHbRANQxGx0t7OLTj2/x0+ig==
X-Google-Smtp-Source: ABdhPJx4JoO51qdE7YskaABs81LWtu6BBrmrra8NDnH7XzKiBYGjPn+QvguCjJ0yBPPCmHp7CTk73mpMwcHQOOasimo=
X-Received: by 2002:ac2:4c46:: with SMTP id o6mr20144159lfk.373.1640710719665;
 Tue, 28 Dec 2021 08:58:39 -0800 (PST)
MIME-Version: 1.0
References: <07a8e48db446888bd77f16b88568e80904f52103.1640528089.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <07a8e48db446888bd77f16b88568e80904f52103.1640528089.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:58:03 +0100
Message-ID: <CAPDyKFpeiPcbvB2gV3P5z2bGpo_--gpFT_zUaMKA1kX8HT0uEA@mail.gmail.com>
Subject: Re: [PATCH] mmc: pwrseq: Use bitmap_free() to free bitmap
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2021 at 15:15, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> kfree() and bitmap_free() are the same. But using the later is more
> consistent when freeing memory allocated with bitmap_alloc().
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq_simple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index ea4d3670560e..988467fbb621 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -54,7 +54,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
>                 gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
>                                                reset_gpios->info, values);
>
> -               kfree(values);
> +               bitmap_free(values);
>         }
>  }
>
> --
> 2.32.0
>
