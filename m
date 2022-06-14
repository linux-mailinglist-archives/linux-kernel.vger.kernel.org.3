Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC154B2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbiFNORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFNORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:17:06 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D32FE5C;
        Tue, 14 Jun 2022 07:17:04 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id e184so15372116ybf.8;
        Tue, 14 Jun 2022 07:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzJm+lc8uG4MWjlJ9/R6vxASJYsJF02HZHOuRM57po8=;
        b=VpOjaG5ljvpTVOFm7MiB9OeiN6S+DKtUYIKS1xmvndtCySnmrcr05TwLlJR415v2jj
         gGKmG0fmMF05oUa+WAjlmDTNuErM4WjbbJCktcNb1NVoV7r1bjm1wOXNE0bBhBgasFzY
         EqIDFkV5b2cO6QiRQkIhaXitHP3496EXw3EaFervg5Yl4JjK83rK65iWiP92K0u2112q
         ZYSJE627n9jS9IEYBM9TWOno0G0RSXfPoUzJ3osNOTzbaq68lbUnoPikYqgOWMIoiMNP
         fDcnSeKLZ9zH5YyOOpsRWS74PLipvTCceuuEw8koxDch+lZUiQw3Jl7p/5pCXY4QDZT6
         YO2w==
X-Gm-Message-State: AJIora/anQtA4mXKCiw7LWHHOOhh8NnNJQ2U0k8ilUrzqUJF6jZRpodV
        0eieEi+4+kmlY2znTxr0JyDECQ2Xgebbn35emRYUKzOi
X-Google-Smtp-Source: AGRyM1szUqy4ac7OLk1kEVW53j2FXYhM2hvZR6OvD0S75oBYbi+k7ZtJoo2eKW4lGbZvVkjwxU8I5kvEZSC+cPvJAys=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr5417608ybm.153.1655216223200; Tue, 14
 Jun 2022 07:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220527073445.2474380-1-liuke94@huawei.com>
In-Reply-To: <20220527073445.2474380-1-liuke94@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 16:16:52 +0200
Message-ID: <CAJZ5v0hwJAcaggRD9e9+jwn6KtTwsfdutgjSxQz_SMwC-OeSpQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: Directly use ida_alloc()/free()
To:     keliu <liuke94@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, May 27, 2022 at 9:13 AM keliu <liuke94@huawei.com> wrote:
>
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
>
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>  drivers/thermal/thermal_core.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 82654dc8382b..b36c348a110b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -667,7 +667,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>         dev->target = THERMAL_NO_TARGET;
>         dev->weight = weight;
>
> -       result = ida_simple_get(&tz->ida, 0, 0, GFP_KERNEL);
> +       result = ida_alloc(&tz->ida, GFP_KERNEL);
>         if (result < 0)
>                 goto free_mem;
>
> @@ -721,7 +721,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  remove_symbol_link:
>         sysfs_remove_link(&tz->device.kobj, dev->name);
>  release_ida:
> -       ida_simple_remove(&tz->ida, dev->id);
> +       ida_free(&tz->ida, dev->id);
>  free_mem:
>         kfree(dev);
>         return result;
> @@ -768,7 +768,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
>         device_remove_file(&tz->device, &pos->weight_attr);
>         device_remove_file(&tz->device, &pos->attr);
>         sysfs_remove_link(&tz->device.kobj, pos->name);
> -       ida_simple_remove(&tz->ida, pos->id);
> +       ida_free(&tz->ida, pos->id);
>         kfree(pos);
>         return 0;
>  }
> @@ -901,7 +901,7 @@ __thermal_cooling_device_register(struct device_node *np,
>         if (!cdev)
>                 return ERR_PTR(-ENOMEM);
>
> -       ret = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
> +       ret = ida_alloc(&thermal_cdev_ida, GFP_KERNEL);
>         if (ret < 0)
>                 goto out_kfree_cdev;
>         cdev->id = ret;
> @@ -951,7 +951,7 @@ __thermal_cooling_device_register(struct device_node *np,
>         put_device(&cdev->device);
>         cdev = NULL;
>  out_ida_remove:
> -       ida_simple_remove(&thermal_cdev_ida, id);
> +       ida_free(&thermal_cdev_ida, id);
>  out_kfree_cdev:
>         kfree(cdev);
>         return ERR_PTR(ret);
> @@ -1110,7 +1110,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>
>         mutex_unlock(&thermal_list_lock);
>
> -       ida_simple_remove(&thermal_cdev_ida, cdev->id);
> +       ida_free(&thermal_cdev_ida, cdev->id);
>         device_del(&cdev->device);
>         thermal_cooling_device_destroy_sysfs(cdev);
>         kfree(cdev->type);
> @@ -1227,7 +1227,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>         INIT_LIST_HEAD(&tz->thermal_instances);
>         ida_init(&tz->ida);
>         mutex_init(&tz->lock);
> -       id = ida_simple_get(&thermal_tz_ida, 0, 0, GFP_KERNEL);
> +       id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
>         if (id < 0) {
>                 result = id;
>                 goto free_tz;
> @@ -1318,7 +1318,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>         put_device(&tz->device);
>         tz = NULL;
>  remove_id:
> -       ida_simple_remove(&thermal_tz_ida, id);
> +       ida_free(&thermal_tz_ida, id);
>  free_tz:
>         kfree(tz);
>         return ERR_PTR(result);
> @@ -1378,7 +1378,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>         thermal_set_governor(tz, NULL);
>
>         thermal_remove_hwmon_sysfs(tz);
> -       ida_simple_remove(&thermal_tz_ida, tz->id);
> +       ida_free(&thermal_tz_ida, tz->id);
>         ida_destroy(&tz->ida);
>         mutex_destroy(&tz->lock);
>         device_unregister(&tz->device);
> --

Applied as 5.20 material, thanks!
