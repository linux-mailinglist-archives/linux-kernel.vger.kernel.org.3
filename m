Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EDC4B8E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiBPQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:32:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBPQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:32:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB6DEBB98
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:32:30 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id d23so4803532lfv.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0SSR54dSAjWRErsJpI8MlfAvIJRbSM4iblniUJufvsg=;
        b=L6VF2QHxQLg/7L4Dc9S/krbjtrMYpe7Pqr85w07568jTF69Hs7UFyDcdMGbTAb7f2y
         tgqnEdbvGQrbzkxqREUT8tZoCpOgj4/OKyalWJIGT8havQQXSJM955rNZ9f8+jL7pFaK
         OBgFktZ7S5OepaHypnh+X3tYd6ruIJIprThaAmdyfrz3iUC7UwEF6uB/RajrKEA63l8y
         wZqfQkKwAyvPmbo942N8E1H5TXudX7eD4pqniGtVDz9HI/t4anZY2lSVCQde3mD0PCU8
         JWdbsS6Qt1khHUO4ONHMRSES7wuBN2VdeDq10Tk1chW4BsppQLTxUyElVqHW8O9vBiSU
         x1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0SSR54dSAjWRErsJpI8MlfAvIJRbSM4iblniUJufvsg=;
        b=uqT/CVDYpClLJ+LmDjrmVSO5124TnBZmvWfJWkGOFRo6M/UIfL+abLEBNP2bG1GE2v
         SYfV7LIf87XaD25hco3KVZVzbc0UqZQFXsuCPRjJ7OZnqqkxXbyrju64qFL1+PBpl5Vj
         LnZ4QbjZ8fglekwAB8nilr5Vie3xW2BKlZktIfAPZx1qJYo3BOh+VlHVGjNzwrZ73Msi
         iXYvjFe74ywUkHM9NR+77QSjg+7MFOqdP+gHO8mqQXUopwv89d4eSmiWpQOos8vqqgb4
         fZSK47ugdlpllZAMaA5TcJY01gl749eFZim4O9HbZr/80SETpJLx8HmuVBjiIGVfsvuE
         CGkw==
X-Gm-Message-State: AOAM530I1aNGj4kMa11FXJc27VA0rGbRoYtdm7FePelVaXHU5IvZ4DtR
        8r18/CUG1oHg+EX/inAuvMTld3xSd0DWcKpj8VSiVg==
X-Google-Smtp-Source: ABdhPJy4b5lagoYRgHmnVR/xqPRVmj9JtiRBC/rW4dv/LKg5sH5HlNTgBl1F4rfr49DbhE0saoL+zkPf00Z838qDynA=
X-Received: by 2002:a05:6512:ea5:b0:43b:3603:69d9 with SMTP id
 bi37-20020a0565120ea500b0043b360369d9mr2542630lfb.71.1645029148857; Wed, 16
 Feb 2022 08:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org> <20220130210210.549877-4-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-4-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 17:31:52 +0100
Message-ID: <CAPDyKFp5X7JuhXWSb--FUVwF=r-wtnPW0My9=oG14vHaPxSZFQ@mail.gmail.com>
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

As I kind of indicated in one of the earlier replies, it looks like
dtpm_lock is being used to protect the global "pct". What else?

Rather than doing it like this, couldn't you instead let
dtpm_create_hiearchy() return a handle/cookie for a "dtpm hierarchy".
This handle then needs to be passed to dtpm_destroy_hierarchy().

In this way, the "pct" doesn't need to be protected and you wouldn't
need the global "pct" at all. Although, maybe there would be other
problems with this?

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

Kind regards
Uffe
