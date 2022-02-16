Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD434B8049
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344645AbiBPFo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:44:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344632AbiBPFo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:44:29 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF6CF3AC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:44:17 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id bt13so2843622ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUX2gGb4q9RgsXc3hYoQEWgo8mO0FjMCfMCTy48wb2A=;
        b=Fq9iZVWr63JMbE4z8EIABfFdWg0dyQriiZLYFIKOJZ6xrinA11J6PENKZGLYRg04QL
         oyqWm6vyEnuBsdPe51WISG/16IpBQLP79ADh0Eci4SHAJddUNiBArnIoPAl9JcgFs5/o
         KXdfG0r657HQHrSc3ZGRAyXOWBAdJqB8bpq1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUX2gGb4q9RgsXc3hYoQEWgo8mO0FjMCfMCTy48wb2A=;
        b=3a5XHmZi+sd1L7FnOE1JuuID02e6RaAnIujY1bqg52N8/WGYbKJDT6TqOtamDzcCbS
         rcf5dTjy2SsifSgQKfxYzbt9KibxfyF/BEf85cVjTdpszZ9eZfvJy9fd1KLMHIqwg3oT
         7ldqcSUSnRBSNlJTYlLvXYI+UU0Yzb+TcUpCtCh2QBCyZ7A+koyNj7d7Oo5TAH3IouWS
         Y1F4YALRmUK825vYoIHNWk7FiaHS8bRl9HDzL+lRMXmr2dwx7fJnBvWbLLJ0XjE2fijH
         bh3DSpp9izY0MccnnzxKLTmIJprHLsqXvw4cXPvFzE86ZXmcsyzeCAePfZG2fLiw9VRB
         5Tpg==
X-Gm-Message-State: AOAM533zEDBIEgmXCSSRrnfFfR9vWPs56DT8Kqldrk7dYKirPZ1APL6w
        NJ+X2NP+W1DX5/u+fg+xUegu9ujs7slsRnlxPE3RlhE0dgw=
X-Google-Smtp-Source: ABdhPJyoOBHj9aERFjBzPOp1qqIBoody04TpuQ+ZpLJwZI51SkYZMQ9SWxhiNxqsT77IcJJ+z4ZNJfVKFtjlXr0fMjc=
X-Received: by 2002:a05:6902:108:b0:621:165e:5c1e with SMTP id
 o8-20020a056902010800b00621165e5c1emr931384ybh.204.1644990256845; Tue, 15 Feb
 2022 21:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20220216043639.3839185-1-tzungbi@google.com> <20220216043639.3839185-2-tzungbi@google.com>
In-Reply-To: <20220216043639.3839185-2-tzungbi@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 15 Feb 2022 21:44:05 -0800
Message-ID: <CACeCKacUDgBHfcb+7rCibhUgJfM-a6kBYrGQdgF9u002tDBVOQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] platform/chrome: cros_ec: fix error handling in cros_ec_register()
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 8:36 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> Fix cros_ec_register() to unregister platform devices if
> blocking_notifier_chain_register() fails.
>
> Also use the single exit path to handle the platform device
> unregistration.
>
> Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW")
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
> Changes from v3:
> (https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-2-tzungbi@google.com/)
> - Simplify by initializing the variables at the beginning.
>
> Changes from v2:
> (https://patchwork.kernel.org/project/chrome-platform/patch/20220209045035.380615-2-tzungbi@google.com/)
> - Fix grammar error in commit message.
> - Change the code that don't rely on zeroed memory.
> - Remove unnecessary `if` checks before calling platform_device_unregister().
>
> Changes from v1:
> (https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
> - Use imperative mood in commit message.
> - Use IS_ERR_OR_NULL() in 1st patch.
>
>  drivers/platform/chrome/cros_ec.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index fc5aa1525d13..ff2a24b0c611 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -189,6 +189,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         ec_dev->max_request = sizeof(struct ec_params_hello);
>         ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
>         ec_dev->max_passthru = 0;
> +       ec_dev->ec = NULL;
> +       ec_dev->pd = NULL;
>
>         ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
>         if (!ec_dev->din)
> @@ -245,18 +247,16 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 if (IS_ERR(ec_dev->pd)) {
>                         dev_err(ec_dev->dev,
>                                 "Failed to create CrOS PD platform device\n");
> -                       platform_device_unregister(ec_dev->ec);
> -                       return PTR_ERR(ec_dev->pd);
> +                       err = PTR_ERR(ec_dev->pd);
> +                       goto exit;
>                 }
>         }
>
>         if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
>                 err = devm_of_platform_populate(dev);
>                 if (err) {
> -                       platform_device_unregister(ec_dev->pd);
> -                       platform_device_unregister(ec_dev->ec);
>                         dev_err(dev, "Failed to register sub-devices\n");
> -                       return err;
> +                       goto exit;
>                 }
>         }
>
> @@ -278,7 +278,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 err = blocking_notifier_chain_register(&ec_dev->event_notifier,
>                                                       &ec_dev->notifier_ready);
>                 if (err)
> -                       return err;
> +                       goto exit;
>         }
>
>         dev_info(dev, "Chrome EC device registered\n");
> @@ -291,6 +291,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>                 cros_ec_irq_thread(0, ec_dev);
>
>         return 0;
> +exit:
> +       platform_device_unregister(ec_dev->ec);
> +       platform_device_unregister(ec_dev->pd);
> +       return err;
>  }
>  EXPORT_SYMBOL(cros_ec_register);
>
> --
> 2.35.1.265.g69c8d7142f-goog
>
