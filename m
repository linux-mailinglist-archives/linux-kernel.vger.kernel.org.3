Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906B854D8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358040AbiFPDUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349947AbiFPDUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:20:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D75AA56
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:20:11 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-316287dc2d2so1824777b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZC94QyGrxl20UVmi6Bbzh0z18nlmSnWSZKrrHOOlIU=;
        b=nHLVhA6zL+rr1952EK4dDV99gYj7eeUWk5vsiO5wZJUyS45PabFeca4mj5gjXNGyLc
         1zJFAAjJvkbtkdYElrt6Zs8VWwCTee9GP375AJDVmzZHPV1WuASUTbZ2dcohWHoDlfdH
         BrdsWLzS/BhNKK4O9esn7kFkseBYhREmF5IqhNjOeT1sTyL9Gdpf5AarECMER4NXc3h/
         hbxuG7PBpvVWc19f3t5qU2lSnef2mJW2q3AB4dCEA1h3x9HBsnFobZyy0Hiqf7lx6zMc
         KTWzzys98kURmMHk2EAoi64fjETZKhn53ZJsIRZhvPM1/zU8M/HboMjrXDMAlHNq+yhU
         9i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZC94QyGrxl20UVmi6Bbzh0z18nlmSnWSZKrrHOOlIU=;
        b=FcmYphVgA0jQ2o3iU1dvfcVSkIuhv96KpFyTgczfDeT1g8q5y04TaCuyTedT6Aoi90
         +MiFY/+hPd4fH0ZTcGg078d6UCGPX9QIyL0nXkXSTfNtsamwD2yGsdootaczJP2GNR7j
         6nkacKgyW24za2OQq3BHSLQJJynebL/Jtvr70ED3ZqDMCjy7OSdKFUVutWfKgBAZS8M0
         q/fKNn012D8L/icvmwq77SSHM1CNNxkN9oAtsAEgjH0zCxrdeHITbS0Zk4b3sePPJw5g
         20ZBHpiRhhZZnvBKAgmujtO7+nTvRGNAydET9mSJkeY7+VBv51qTi9yON3T/8bhbRX5q
         nj3w==
X-Gm-Message-State: AJIora9g5aoze9l6/+IJPLEoJtYMWG/Wr/HjNxZrbll6tYu0nUEZ414s
        myKxWGiVrC0WaY4+vireXH0Bkas6USMfdEtba+vx+w==
X-Google-Smtp-Source: AGRyM1tRDeWpcUh85R6nZJELiK50ZhN1KTNctwS1M4XiRR4sm0BrQ50F4dmy0+hMKWAlzdbrYVLXOGYB6+n3mVA+Xyw=
X-Received: by 2002:a81:7557:0:b0:317:6536:d404 with SMTP id
 q84-20020a817557000000b003176536d404mr2710980ywc.459.1655349610880; Wed, 15
 Jun 2022 20:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220604010101.719508-1-saravanak@google.com>
In-Reply-To: <20220604010101.719508-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Jun 2022 20:19:34 -0700
Message-ID: <CAGETcx_9AxUzmSFou=PqLpAJ6P_k4mq5tjFpt0WOC348RRBF0g@mail.gmail.com>
Subject: Re: [PATCH v2] module: Add support for default value for module async_probe
To:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 6:01 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Add a module.async_probe kernel command line option that allows enabling
> async probing for all modules. When this command line option is used,
> there might still be some modules for which we want to explicitly force
> synchronous probing, so extend <modulename>.async_probe to take an
> optional bool input so that async probing can be disabled for a specific
> module.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> v1->v2:
> - Updated the documentation to capture all the details/changes.

Luis,

Gentle reminder.

-Saravana

>
>  Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++--
>  kernel/module/main.c                            | 11 ++++++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 710b52d87bdd..5174a08e20b0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1147,8 +1147,12 @@
>         nopku           [X86] Disable Memory Protection Keys CPU feature found
>                         in some Intel CPUs.
>
> -       <module>.async_probe [KNL]
> -                       Enable asynchronous probe on this module.
> +       <module>.async_probe[=<bool>] [KNL]
> +                       If no <bool> value is specified or if the value
> +                       specified is not a valid <bool>, enable asynchronous
> +                       probe on this module.  Otherwise, enable/disable
> +                       asynchronous probe on this module as indicated by the
> +                       <bool> value. See also: module.async_probe
>
>         early_ioremap_debug [KNL]
>                         Enable debug messages in early_ioremap support. This
> @@ -3201,6 +3205,15 @@
>                         log everything. Information is printed at KERN_DEBUG
>                         so loglevel=8 may also need to be specified.
>
> +       module.async_probe=<bool>
> +                       [KNL] When set to true, modules will use async probing
> +                       by default. To enable/disable async probing for a
> +                       specific module, use the module specific control that
> +                       is documented under <module>.async_probe. When both
> +                       module.async_probe and <module>.async_probe are
> +                       specified, <module>.async_probe takes precedence for
> +                       the specific module.
> +
>         module.sig_enforce
>                         [KNL] When CONFIG_MODULE_SIG is set, this means that
>                         modules without (valid) signatures will fail to load.
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index fed58d30725d..47085795f037 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2410,6 +2410,12 @@ static void do_free_init(struct work_struct *w)
>         }
>  }
>
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "module."
> +/* Default value for module->async_probe_requested */
> +static bool async_probe;
> +module_param(async_probe, bool, 0644);
> +
>  /*
>   * This is where the real work happens.
>   *
> @@ -2630,7 +2636,8 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
>         int ret;
>
>         if (strcmp(param, "async_probe") == 0) {
> -               mod->async_probe_requested = true;
> +               if (strtobool(val, &mod->async_probe_requested))
> +                       mod->async_probe_requested = true;
>                 return 0;
>         }
>
> @@ -2797,6 +2804,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
>         if (err)
>                 goto bug_cleanup;
>
> +       mod->async_probe_requested = async_probe;
> +
>         /* Module is ready to execute: parsing args may do that. */
>         after_dashes = parse_args(mod->name, mod->args, mod->kp, mod->num_kp,
>                                   -32768, 32767, mod,
> --
> 2.36.1.255.ge46751e96f-goog
>
