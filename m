Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E656653BE25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbiFBSkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiFBSkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:40:36 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BAFF58F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:40:34 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id f34so9815311ybj.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ftUD2d16d6qZJGmlFN++n87dJ32C177V2ZqTCtrzEw=;
        b=QHB2ygXNu2Uo8ufRapd8ogTKQAzoXsvEA8okkn+gJu7lxaS0Ss8NAogAeESgxfRBqS
         0H3+sW9w9BjMYNpglEgIZjBU/kf00506VJ+um5dbAVZetm7Yxsz+4NBkVSx+PseAEpZ8
         YxXg+jYsgQdb2y2DKZ9HwOStNNjw8RlZoVagY348k38xjEQLyllP1eZxcosvQhjHkdaE
         lXnQb9LaRFNmlZeCFZUIa4RAIihErFJ9/zYYPqWnCmcSmG7+rNcedXHxy6iWQfX1FhEr
         oS0qjniTU/vY6yP2C2PBY6zHMuTQuoLoatiUqbdXVvUZ79vRQ9kyL7tOfQH0Q5BgN4WK
         MxYg==
X-Gm-Message-State: AOAM532iOk2bXcPfDg73SHmwDBZobx0GDiQKiKClO1SQWiNA+VfZsgrc
        3RHS3TI54kSveeDJinR+mCBVQEQliN94ms77Cgk=
X-Google-Smtp-Source: ABdhPJzgNSELFY/ID5JjKvDa9F3UBG8GdmRGvlSRvz2zkFSJFeaTY7U3sUylEoSshggxhkFhrkLgquDCixk0o21liNM=
X-Received: by 2002:a25:8803:0:b0:64e:4a6a:afb9 with SMTP id
 c3-20020a258803000000b0064e4a6aafb9mr6739134ybl.482.1654195234222; Thu, 02
 Jun 2022 11:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220531221102.1112968-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220531221102.1112968-1-dmitry.osipenko@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Jun 2022 20:40:23 +0200
Message-ID: <CAJZ5v0ifhxy-b50TyJdmzkJ_rnYyn7euzRc4-2bG_oxu-juCtw@mail.gmail.com>
Subject: Re: [PATCH v1] kernel/reboot: Use static handler for register_platform_power_off()
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Wed, Jun 1, 2022 at 12:11 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> The register_platform_power_off() fails on m68k platform due to the
> memory allocation error that happens at a very early boot time when
> memory allocator isn't available yet. Fix it by using a static sys-off
> handler for the platform-level power-off handlers.
>
> Fixes: f0f7e5265b3b ("m68k: Switch to new sys-off handler API")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  kernel/reboot.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index a091145ee710..3b19b123efec 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -315,6 +315,37 @@ static int sys_off_notify(struct notifier_block *nb,
>         return handler->sys_off_cb(&data);
>  }
>
> +static struct sys_off_handler platform_sys_off_handler;
> +
> +static struct sys_off_handler *alloc_sys_off_handler(int priority)
> +{
> +       struct sys_off_handler *handler;
> +
> +       /*
> +        * Platforms like m68k can't allocate sys_off handler dynamically
> +        * at the early boot time because memory allocator isn't available yet.
> +        */
> +       if (priority == SYS_OFF_PRIO_PLATFORM) {
> +               handler = &platform_sys_off_handler;
> +               if (handler->cb_data)
> +                       return ERR_PTR(-EBUSY);
> +       } else {
> +               handler = kzalloc(sizeof(*handler), GFP_KERNEL);
> +               if (!handler)
> +                       return ERR_PTR(-ENOMEM);
> +       }
> +
> +       return handler;
> +}
> +
> +static void free_sys_off_handler(struct sys_off_handler *handler)
> +{
> +       if (handler == &platform_sys_off_handler)
> +               memset(handler, 0, sizeof(*handler));
> +       else
> +               kfree(handler);
> +}
> +
>  /**
>   *     register_sys_off_handler - Register sys-off handler
>   *     @mode: Sys-off mode
> @@ -345,9 +376,9 @@ register_sys_off_handler(enum sys_off_mode mode,
>         struct sys_off_handler *handler;
>         int err;
>
> -       handler = kzalloc(sizeof(*handler), GFP_KERNEL);
> -       if (!handler)
> -               return ERR_PTR(-ENOMEM);
> +       handler = alloc_sys_off_handler(priority);
> +       if (IS_ERR(handler))
> +               return handler;
>
>         switch (mode) {
>         case SYS_OFF_MODE_POWER_OFF_PREPARE:
> @@ -364,7 +395,7 @@ register_sys_off_handler(enum sys_off_mode mode,
>                 break;
>
>         default:
> -               kfree(handler);
> +               free_sys_off_handler(handler);
>                 return ERR_PTR(-EINVAL);
>         }
>
> @@ -391,7 +422,7 @@ register_sys_off_handler(enum sys_off_mode mode,
>         }
>
>         if (err) {
> -               kfree(handler);
> +               free_sys_off_handler(handler);
>                 return ERR_PTR(err);
>         }
>
> @@ -422,7 +453,7 @@ void unregister_sys_off_handler(struct sys_off_handler *handler)
>         /* sanity check, shall never happen */
>         WARN_ON(err);
>
> -       kfree(handler);
> +       free_sys_off_handler(handler);
>  }
>  EXPORT_SYMBOL_GPL(unregister_sys_off_handler);
>
> --

Applied now (with the tags from Geert), but if there are any more
followup changes in that area, can you please CC them to linux-pm, so
people who have seen your original series can see them too?

Thanks!
