Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1C53B6ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiFBKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiFBKUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:20:33 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E78F2AD9AB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:20:31 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ea7so3229784qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xoHOj1xulzu3SD29GS2YKQ7gqDLAbM1bPx44xbkClg=;
        b=DSUMru50+KeenCQPQGfny1v3Ey5MgeseAd9dW+EgqLIhT5Gun0C2qi5V6HvzJ5dfK5
         9oH3esl6la/adwnvP6zQTXAtyI6MeB5Vn3s4G9c7nfdnvmZU68JdsXs9eSrgfZN0ARmr
         OH4fJBOSBRFdAoQUTC0UmFlnZdJeWfANDij0q8ZYbmsIjvCYD37WNd6KvnWCjQg1Pcmm
         yQzaVJUapywWsiOmrpKJKcU3NmpijxcNaQfuPopeCPySTuVY/EP8jp4kJP3frZm4sYID
         wyF6YnL3J4kBLP8rFV9NzS+iiQmy/DR3I5kP+NpDI82a5eisygvFLfkpj5YCyOMUSffL
         mvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xoHOj1xulzu3SD29GS2YKQ7gqDLAbM1bPx44xbkClg=;
        b=GjPVSKne/xXd67ciMGWLlh9BxF12NqQL2jo7F0F0jhbagkzXeavC/MD9YuC5Wyhfl3
         k77qkDu7bQK67Q7jEqgK9tdaggR5abCt3mUIiSUc7C+Eptxe7p1aTYP6D690DMDgKQhN
         zg9DemxBx+5EXWRKHdha2yD6yf/3TQ5EJbnVKhu+7aJjuXhLfs7ShSRcOGJKDJzWE1sz
         shVAmDDtrwXmY0LADEwtH9MjjKUcTysFGahi4aKAzpkv9umYtb6eVbQdB9GT0f1g5WM5
         +UmWVJpQhbTVN1teY4gT4p6t56QYjix5wcj0cnf6I+lrZOipB4laJ3viss1WD+4T87zJ
         ybRA==
X-Gm-Message-State: AOAM533zaOqmEH9TtA/i3eEwwg5Ob/Hfad4BgzeYS/0IDEKnLhzFHCvD
        Rc/Buz3QDbPrdcntxri+GejW72wF89hrnLJauwzJUw==
X-Google-Smtp-Source: ABdhPJw1Rch5C49/vloTHmi2dY/GNe+3O0wK53nKBS9fZMA13PpgfQcEMtkcYegIIDx2qb2wp1k+tGsQ77F5VsPPLIo=
X-Received: by 2002:ad4:5aa4:0:b0:465:2b11:cfd with SMTP id
 u4-20020ad45aa4000000b004652b110cfdmr5204455qvg.55.1654165230535; Thu, 02 Jun
 2022 03:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220601220747.1145095-1-marijn.suijten@somainline.org> <20220601220747.1145095-4-marijn.suijten@somainline.org>
In-Reply-To: <20220601220747.1145095-4-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 2 Jun 2022 13:20:19 +0300
Message-ID: <CAA8EJpomtbN0+ocD2pRbkYriUY4D9OnjgoFzL9qNHhPm3Uz5cQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
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

On Thu, 2 Jun 2022 at 01:07, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Add the devres and non-devres variant of
> clk_hw_register_fixed_factor_parent_hw() for registering a fixed factor
> clock with clk_hw parent pointer instead of parent name.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Two minor comments below. It's up to Stephen to check if they are
correct or not.

> ---
>  drivers/clk/clk-fixed-factor.c | 57 ++++++++++++++++++++++++++++------
>  include/linux/clk-provider.h   |  8 +++++
>  2 files changed, 55 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 54942d758ee6..fabb98d0cdb2 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -78,7 +78,8 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
>
>  static struct clk_hw *
>  __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
> -               const char *name, const char *parent_name, int index,
> +               const char *name, const char *parent_name,
> +               const struct clk_hw *parent_hw, int index,
>                 unsigned long flags, unsigned int mult, unsigned int div,
>                 bool devm)
>  {
> @@ -108,7 +109,9 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
>         init.name = name;
>         init.ops = &clk_fixed_factor_ops;
>         init.flags = flags;
> -       if (parent_name)
> +       if (parent_hw)
> +               init.parent_hws = &parent_hw;
> +       else if (parent_name)
>                 init.parent_names = &parent_name;

If you change the order of if clauses, you won't have to introduce
unnecessary changes.

>         else
>                 init.parent_data = &pdata;
> @@ -148,17 +151,50 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
>                 const char *name, unsigned int index, unsigned long flags,
>                 unsigned int mult, unsigned int div)
>  {
> -       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, index,
> -                                             flags, mult, div, true);
> +       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL,
> +                                             index, flags, mult, div, true);

Here (and several times later) you are inserting an argument and then
moving arguments to the next line. My slight preference would be to
just insert the arg (and maybe break the line if it gets too long) w/o
touching the next lines.

>  }
>  EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
>
> +/**
> + * devm_clk_hw_register_fixed_factor_parent_hw - Register a fixed factor clock with
> + * pointer to parent clock
> + * @dev: device that is registering this clock
> + * @name: name of this clock
> + * @parent_hw: pointer to parent clk
> + * @flags: fixed factor flags
> + * @mult: multiplier
> + * @div: divider
> + *
> + * Return: Pointer to fixed factor clk_hw structure that was registered or
> + * an error pointer.
> + */
> +struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
> +               const char *name, const struct clk_hw *parent_hw,
> +               unsigned long flags, unsigned int mult, unsigned int div)
> +{
> +       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
> +                                             -1, flags, mult, div, true);
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_parent_hw);
> +
> +struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
> +               const char *name, const struct clk_hw *parent_hw,
> +               unsigned long flags, unsigned int mult, unsigned int div)
> +{
> +       return __clk_hw_register_fixed_factor(dev, NULL, name, NULL,
> +                                             parent_hw, -1, flags, mult, div,
> +                                             false);
> +}
> +EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_parent_hw);
> +
>  struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
>                 const char *name, const char *parent_name, unsigned long flags,
>                 unsigned int mult, unsigned int div)
>  {
> -       return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1,
> -                                             flags, mult, div, false);
> +       return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name,
> +                                             NULL, -1, flags, mult, div,
> +                                             false);
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
>
> @@ -204,8 +240,9 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
>                 const char *name, const char *parent_name, unsigned long flags,
>                 unsigned int mult, unsigned int div)
>  {
> -       return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1,
> -                       flags, mult, div, true);
> +       return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name,
> +                                             NULL, -1, flags, mult, div,
> +                                             true);
>  }
>  EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
>
> @@ -240,8 +277,8 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
>         if (of_match_node(set_rate_parent_matches, node))
>                 flags |= CLK_SET_RATE_PARENT;
>
> -       hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, 0,
> -                                           flags, mult, div, false);
> +       hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL,
> +                                           0, flags, mult, div, false);
>         if (IS_ERR(hw)) {
>                 /*
>                  * Clear OF_POPULATED flag so that clock registration can be
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 316c7e082934..94458cb669f0 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -1032,6 +1032,14 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
>  struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
>                 const char *name, unsigned int index, unsigned long flags,
>                 unsigned int mult, unsigned int div);
> +
> +struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
> +               const char *name, const struct clk_hw *parent_hw,
> +               unsigned long flags, unsigned int mult, unsigned int div);
> +
> +struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
> +               const char *name, const struct clk_hw *parent_hw,
> +               unsigned long flags, unsigned int mult, unsigned int div);
>  /**
>   * struct clk_fractional_divider - adjustable fractional divider clock
>   *
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
