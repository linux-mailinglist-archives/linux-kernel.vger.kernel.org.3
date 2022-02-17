Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC24BA0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbiBQNSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:18:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBQNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:18:50 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E532AE70A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:18:36 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id o9so8280918ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+xr7xNBsi8wIiI/Jw0V8h9snTwnIDwVgxOfWjrWfudU=;
        b=nqZ6Akb6n26cZiMh3G6cHPkIrgsMDjBJ/qGhZo3FHhGFjFr+FXbt3hlMn5+WzemSrW
         TkSgGp3UCDk8qroECeJJx41/C5oK8aZcxb81M9jRAnKBn5CGOjh9HCqRx4yDWEHt8GWw
         dJElMCo04Ez7qoSbiw5ubvJJttz5DHaugU1dDygppm3UMsj32ckH2dLjIgEdaY3Z5Q+X
         KEy+pfBMmQydgVJbh9krHA9XbNtLsv/sn8qfaB7FppOhj6XQ27JYuVPqiFpsoirRO7Zs
         B3o6oEn8+jN09VBF1IVt42lQBpDQbbfp7BTXR5UHnxcPV1mvB3E1rgQLDwTbvhuIczhq
         orwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+xr7xNBsi8wIiI/Jw0V8h9snTwnIDwVgxOfWjrWfudU=;
        b=OaZt0Q2rIZg9RbIFAgYHeqcvpXz8gyN7QX4T3B1KDPxs3ZZvrF1vLRJs+3TLCBIgr/
         RqyNwQNoMJh65QwEgGdN0/clGgivYStnwUvBU+o9ycKs+qUVG27DujRjk7tc7tkGrsry
         UZUjL0tskGb6TDhoQz5U3/RT74TaOSe5bvE0KyM+AvooEvzZkmHN9xUsEmifNJoCJ0rX
         gLEUb/bHz7HPJJdzjg1iA0Uz8RzPvgfNH+IUqdwW0uh33VvVHsfLO6f9cokyiKluizLa
         MSAMEMStcrjIGPwPIe1LcN9ileuu63vcg2HpndanGohZyofKhH5TAhaN6LckJ0B23v+X
         jI8A==
X-Gm-Message-State: AOAM532rbrq9Oj1UP5sHjne7uE57cCqUG6WmYlxADbfgivVdUhEoeQSC
        gPZYyUkY+/KEVZjE7NhGjmCP9vx9OZR2u9XV4HNuIw==
X-Google-Smtp-Source: ABdhPJxCaaWhMQ/BzB84U4eQcyLkBt4GIADqh7ASeCAwP/NvT7LgmmrnKTyM0UIDEVmC9EsUDvlntZU8c5n9ykDqQWU=
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id
 7-20020a05651c00c700b00244f9d77c48mr2317325ljr.300.1645103914894; Thu, 17 Feb
 2022 05:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-4-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-4-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 14:17:58 +0100
Message-ID: <CAPDyKFp00F3o24anjxuebPB=+nVdccF_NDGJLGeS-c0_4N7bsQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] powercap/dtpm: Destroy hierarchy function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The hierarchy creation function exits but without a destroy hierarchy
> function. Due to that, the modules creating the hierarchy can not be
> unloaded properly because they don't have an exit callback.
>
> Provide the dtpm_destroy_hierarchy() function to remove the previously
> created hierarchy.
>
> The function relies on all the release mechanisms implemented by the
> underlying powercap framework.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/powercap/dtpm.c | 43 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/dtpm.h    |  3 +++
>  2 files changed, 46 insertions(+)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 7bddd25a6767..d9d74f981118 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -617,3 +617,46 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(dtpm_create_hierarchy);
> +
> +static void __dtpm_destroy_hierarchy(struct dtpm *dtpm)
> +{
> +       struct dtpm *child, *aux;
> +
> +       list_for_each_entry_safe(child, aux, &dtpm->children, sibling)
> +               __dtpm_destroy_hierarchy(child);
> +
> +       /*
> +        * At this point, we know all children were removed from the
> +        * recursive call before
> +        */
> +       dtpm_unregister(dtpm);
> +}
> +
> +void dtpm_destroy_hierarchy(void)
> +{
> +       int i;
> +
> +       mutex_lock(&dtpm_lock);
> +
> +       if (!pct)
> +               goto out_unlock;
> +
> +       __dtpm_destroy_hierarchy(root);
> +
> +
> +       for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
> +
> +               if (!dtpm_subsys[i]->exit)
> +                       continue;
> +
> +               dtpm_subsys[i]->exit();
> +       }
> +
> +       powercap_unregister_control_type(pct);
> +
> +       pct = NULL;
> +
> +out_unlock:
> +       mutex_unlock(&dtpm_lock);
> +}
> +EXPORT_SYMBOL_GPL(dtpm_destroy_hierarchy);
> diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
> index f7a25c70dd4c..a4a13514b730 100644
> --- a/include/linux/dtpm.h
> +++ b/include/linux/dtpm.h
> @@ -37,6 +37,7 @@ struct device_node;
>  struct dtpm_subsys_ops {
>         const char *name;
>         int (*init)(void);
> +       void (*exit)(void);
>         int (*setup)(struct dtpm *, struct device_node *);
>  };
>
> @@ -67,4 +68,6 @@ void dtpm_unregister(struct dtpm *dtpm);
>  int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent);
>
>  int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table);
> +
> +void dtpm_destroy_hierarchy(void);
>  #endif
> --
> 2.25.1
>
