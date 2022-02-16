Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D1F4B8DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiBPQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:25:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiBPQZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:25:22 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8672409ED
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:25:09 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bx31so4220675ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6soUOortqGG9JWiIYu0Y9w2Da9q/ypfoQdHky+MaBwo=;
        b=wwTJ4QBCIOPPcqRzhvGwEL9ZdVmhCUs75ZHBBoCxdH5UExbWbIlr73bN16EMO7/pBK
         lEHilo5nNQQQVd5Ga7WsncysZOj0Z7vfu3aLL/icN8oSasYDYKqcESKAHTQucTr/g3ch
         pxP8H+1UDZPY8YaFwaTYNtVCrLkUl79GTtbtQgbFSwAF0q8gmEkKlymGepl0jSae3pnv
         PLw6LSQXvbCpnxKX1dpxbpWvHieFAVge3jG1+V1IQWeQhMIfz3vl5v9UtQ6Lg8SdXXw+
         Kr4YXk9M283Iu96l/JR96Ape4carnXeqmwBTtnd3mZJwo/4YctUINCWJ5R9etZHKZZJC
         MWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6soUOortqGG9JWiIYu0Y9w2Da9q/ypfoQdHky+MaBwo=;
        b=YPJaLnIAdvaqbi0jrWkIO8ojgnZeaIndnvU2RKdIphqGTRzUm6AZjh6Tj181kd3tIU
         kLusCCDPjbJxbY2Z/IwXcBqoDnqD5MsFXqDLnFd4UV0PQhQjppQLHtkdwF5XPY1w6kPv
         Yt8JBmzMpmXMeIf1NT6iJsriZZMnm1cxCQi+gqOI5nCBYtjDbFC+EZzQX9fG77Zvw0Ix
         U3/pMt9MzwuU1pdZZBeHyUpSPZ2iILLQKmGl0O/bdv/Lhjfir7SIwQ5VGgM6OJfic7Wl
         jT0X79ILLfkE3LvcQeemPi+1SRA/+5SNMCtxOYfyAJOFXTYL5MQvaC2AlzMQFqQW1sM+
         SvRQ==
X-Gm-Message-State: AOAM533hwFscOuqbp/Dtil/Ca11i+4cyrkC0FLX7vRbotBH++x1bzXiT
        romgFlFW5RwlPv/ohQ19liCbzxTKP9xa+xOZAYOnXA==
X-Google-Smtp-Source: ABdhPJxb7bBAqNjoQeUjuwBZW+VAQVsb6K/pDq+b29c0dn0ty+gE9FQaqG2TFJ3WOLYWj54nDkEAZYp1neCzzv08QBo=
X-Received: by 2002:a05:651c:1a2a:b0:244:c227:17ae with SMTP id
 by42-20020a05651c1a2a00b00244c22717aemr2600055ljb.273.1645028707407; Wed, 16
 Feb 2022 08:25:07 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
In-Reply-To: <20220130210210.549877-1-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Feb 2022 17:24:30 +0100
Message-ID: <CAPDyKFpDsHJMmwhcs9kBshErNbxH3X5UBMdQxqhDYq3dZ7-4ew@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] powercap/dtpm: Change locking scheme
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The different functions are all called through the
> dtpm_create_hierarchy() which handle the mutex. The different
> functions are used in this context, consequently with the lock always
> held.
>
> Remove all locks taken in the function and add the lock in the
> hierarchy creation function.

I have to admit that the locking scheme looks quite odd in dtpm.c.
It's not really clear to me what the global "dtpm_lock" is there to
protect in the first place (except the global "pct" variable).
Nevertheless, this looks like a step in the right direction.

>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/powercap/dtpm.c | 95 ++++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 414826a1509b..0b0121c37a1b 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -51,9 +51,7 @@ static int get_max_power_range_uw(struct powercap_zone *pcz, u64 *max_power_uw)
>  {
>         struct dtpm *dtpm = to_dtpm(pcz);
>
> -       mutex_lock(&dtpm_lock);
>         *max_power_uw = dtpm->power_max - dtpm->power_min;
> -       mutex_unlock(&dtpm_lock);
>
>         return 0;
>  }
> @@ -83,14 +81,7 @@ static int __get_power_uw(struct dtpm *dtpm, u64 *power_uw)
>
>  static int get_power_uw(struct powercap_zone *pcz, u64 *power_uw)
>  {
> -       struct dtpm *dtpm = to_dtpm(pcz);
> -       int ret;
> -
> -       mutex_lock(&dtpm_lock);
> -       ret = __get_power_uw(dtpm, power_uw);
> -       mutex_unlock(&dtpm_lock);
> -
> -       return ret;
> +       return __get_power_uw(to_dtpm(pcz), power_uw);
>  }
>
>  static void __dtpm_rebalance_weight(struct dtpm *dtpm)
> @@ -133,7 +124,16 @@ static void __dtpm_add_power(struct dtpm *dtpm)
>         }
>  }
>
> -static int __dtpm_update_power(struct dtpm *dtpm)
> +/**
> + * dtpm_update_power - Update the power on the dtpm
> + * @dtpm: a pointer to a dtpm structure to update
> + *
> + * Function to update the power values of the dtpm node specified in
> + * parameter. These new values will be propagated to the tree.
> + *
> + * Return: zero on success, -EINVAL if the values are inconsistent
> + */
> +int dtpm_update_power(struct dtpm *dtpm)
>  {
>         int ret;
>
> @@ -155,26 +155,6 @@ static int __dtpm_update_power(struct dtpm *dtpm)
>         return ret;
>  }
>
> -/**
> - * dtpm_update_power - Update the power on the dtpm
> - * @dtpm: a pointer to a dtpm structure to update
> - *
> - * Function to update the power values of the dtpm node specified in
> - * parameter. These new values will be propagated to the tree.
> - *
> - * Return: zero on success, -EINVAL if the values are inconsistent
> - */
> -int dtpm_update_power(struct dtpm *dtpm)
> -{
> -       int ret;
> -
> -       mutex_lock(&dtpm_lock);
> -       ret = __dtpm_update_power(dtpm);
> -       mutex_unlock(&dtpm_lock);
> -
> -       return ret;
> -}
> -
>  /**
>   * dtpm_release_zone - Cleanup when the node is released
>   * @pcz: a pointer to a powercap_zone structure
> @@ -191,20 +171,14 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>         struct dtpm *dtpm = to_dtpm(pcz);
>         struct dtpm *parent = dtpm->parent;
>
> -       mutex_lock(&dtpm_lock);
> -
> -       if (!list_empty(&dtpm->children)) {
> -               mutex_unlock(&dtpm_lock);
> +       if (!list_empty(&dtpm->children))
>                 return -EBUSY;
> -       }
>
>         if (parent)
>                 list_del(&dtpm->sibling);
>
>         __dtpm_sub_power(dtpm);
>
> -       mutex_unlock(&dtpm_lock);
> -
>         if (dtpm->ops)
>                 dtpm->ops->release(dtpm);
>
> @@ -216,23 +190,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
>         return 0;
>  }
>
> -static int __get_power_limit_uw(struct dtpm *dtpm, int cid, u64 *power_limit)
> -{
> -       *power_limit = dtpm->power_limit;
> -       return 0;
> -}
> -
>  static int get_power_limit_uw(struct powercap_zone *pcz,
>                               int cid, u64 *power_limit)
>  {
> -       struct dtpm *dtpm = to_dtpm(pcz);
> -       int ret;
> -
> -       mutex_lock(&dtpm_lock);
> -       ret = __get_power_limit_uw(dtpm, cid, power_limit);
> -       mutex_unlock(&dtpm_lock);
> -
> -       return ret;
> +       *power_limit = to_dtpm(pcz)->power_limit;
> +
> +       return 0;
>  }
>
>  /*
> @@ -292,7 +255,7 @@ static int __set_power_limit_uw(struct dtpm *dtpm, int cid, u64 power_limit)
>
>                         ret = __set_power_limit_uw(child, cid, power);
>                         if (!ret)
> -                               ret = __get_power_limit_uw(child, cid, &power);
> +                               ret = get_power_limit_uw(&child->zone, cid, &power);
>
>                         if (ret)
>                                 break;
> @@ -310,8 +273,6 @@ static int set_power_limit_uw(struct powercap_zone *pcz,
>         struct dtpm *dtpm = to_dtpm(pcz);
>         int ret;
>
> -       mutex_lock(&dtpm_lock);
> -
>         /*
>          * Don't allow values outside of the power range previously
>          * set when initializing the power numbers.
> @@ -323,8 +284,6 @@ static int set_power_limit_uw(struct powercap_zone *pcz,
>         pr_debug("%s: power limit: %llu uW, power max: %llu uW\n",
>                  dtpm->zone.name, dtpm->power_limit, dtpm->power_max);
>
> -       mutex_unlock(&dtpm_lock);
> -
>         return ret;
>  }
>
> @@ -335,11 +294,7 @@ static const char *get_constraint_name(struct powercap_zone *pcz, int cid)
>
>  static int get_max_power_uw(struct powercap_zone *pcz, int id, u64 *max_power)
>  {
> -       struct dtpm *dtpm = to_dtpm(pcz);
> -
> -       mutex_lock(&dtpm_lock);
> -       *max_power = dtpm->power_max;
> -       mutex_unlock(&dtpm_lock);
> +       *max_power = to_dtpm(pcz)->power_max;
>
>         return 0;
>  }
> @@ -442,8 +397,6 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>         if (IS_ERR(pcz))
>                 return PTR_ERR(pcz);
>
> -       mutex_lock(&dtpm_lock);
> -
>         if (parent) {
>                 list_add_tail(&dtpm->sibling, &parent->children);
>                 dtpm->parent = parent;
> @@ -459,8 +412,6 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>         pr_debug("Registered dtpm node '%s' / %llu-%llu uW, \n",
>                  dtpm->zone.name, dtpm->power_min, dtpm->power_max);
>
> -       mutex_unlock(&dtpm_lock);
> -
>         return 0;
>  }
>
> @@ -605,8 +556,12 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
>         struct device_node *np;
>         int i, ret;
>
> -       if (pct)
> -               return -EBUSY;
> +       mutex_lock(&dtpm_lock);
> +
> +       if (pct) {
> +               ret = -EBUSY;
> +               goto out_unlock;
> +       }
>
>         pct = powercap_register_control_type(NULL, "dtpm", NULL);
>         if (IS_ERR(pct)) {
> @@ -648,12 +603,16 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
>                                 dtpm_subsys[i]->name, ret);
>         }
>
> +       mutex_unlock(&dtpm_lock);
> +
>         return 0;
>
>  out_err:
>         powercap_unregister_control_type(pct);
>  out_pct:
>         pct = NULL;
> +out_unlock:
> +       mutex_unlock(&dtpm_lock);
>
>         return ret;
>  }
> --
> 2.25.1
>
