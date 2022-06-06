Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2053EA43
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241458AbiFFQEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbiFFQEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:04:24 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470EC152406
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:04:22 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c2so19449899edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWGXBfl5se4wp7KrN7wL12Xs7rq9qbdgkQhRaY9GU8k=;
        b=oTOjhh1RJEKaX+Qs3cMsD4RMvyp25Gx8tqm0DGapHv/pgtDvU5md877GgRji8Y8l6j
         F6Zj1dlr2seLm1abILw7hbEaB5kN0cphmVqElfOi3wfmyAiFqgUD80fXDYpxk05vjylz
         hUABSZOmoCkEvUFxOaZNLWb/PmwhtdCK+ErdqJCgrq9yaoAbHf+j+NKHYMOQTMAUnUB6
         Jjkq9uu96Frsn4ou3RMMXgR4KKfa5tTssBFne8+rvY6DJo//Gx8y4XxiL5gtPQYiEEVU
         VJaW2h2kOKfRl/4G4+aUFVQ0Qo2TBY2qKteqSsa1t2UYN/sMFfj+/vnt5Qv8sLZJNfj9
         b8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWGXBfl5se4wp7KrN7wL12Xs7rq9qbdgkQhRaY9GU8k=;
        b=QbuFY5WTqmL5o2dEY4kNQDmZrS4v0zGYSKTaWjE0BWGvkwy6qy+4MvqT7v7qdqBuFn
         YXandKNl3f3wMr8c2MqD6FQhnnvuBRYn419WiA4daBes5a4W/XL876Z5vQswTNvOTQba
         +4wVYo/auuUxz+d83QaSzAVdgmzUPGSTqUsEEXznPDtG3kz9C9hcqLvPQZfwnbccRpPt
         cTMxgo5O6wnTkZV+TKk02dO/Yu6kdWnfm9N5IguikD24V+u2Qvu+Ej4jQdsNpO2lF2/K
         SwfDR5fV3dz8wDp7PpfCeR+rDVW6nxcC3a9NOcqmJAxg/c+DoJktu+3yDSxzwEzxCvFx
         1x0A==
X-Gm-Message-State: AOAM532ebFg0sBdjnNirDtmbUnXmlTnHdi+PddFtz4dZRLnbK+lerW/j
        BiItn5u4tXnSPlHM+W5GUgXLB/giFBmqFMF6VJo2RQ==
X-Google-Smtp-Source: ABdhPJw0AtNFpuEuBurgDLof8QHrKCzrB1fD2ibq74tZyCTRpMqSFYqd9Fuk1ASQ2onL3N7iWvYnRwXQFNm+uEtD/ZY=
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr17270359edd.11.1654531460569; Mon, 06
 Jun 2022 09:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-10-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-10-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 09:04:09 -0700
Message-ID: <CABXOdTcjHR281zr=yo-Gx0eLZMKX2MvrYwL1SGY4=Kk5376iuw@mail.gmail.com>
Subject: Re: [PATCH 09/13] platform/chrome: cros_ec_proto: use devm_krealloc()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Use devm_krealloc() to re-allocate `din` and `dout`.
>
> Also remove the unneeded devm_kfree() in error handling path as they are
> device managed memory.
>

Problem with that is that the callers don't always handle error
returns from calls to cros_ec_query_all(), that the call isn't
typically from the probe function, and that the release function would
not be called after partial allocation failures until the driver is
unloaded. This would result in memory leaks, making the memory
situation even worse. I am not sure if using devm_ functions to
allocate the memory really makes sense here.

Guenter

> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c      | 25 ++++++--------------
>  drivers/platform/chrome/cros_ec_proto_test.c |  3 +--
>  2 files changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index abb30a685567..5f4414f05d66 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -479,21 +479,13 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                 }
>         }
>
> -       devm_kfree(dev, ec_dev->din);
> -       devm_kfree(dev, ec_dev->dout);
> -
> -       ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
> -       if (!ec_dev->din) {
> -               ret = -ENOMEM;
> -               goto exit;
> -       }
> +       ec_dev->din = devm_krealloc(dev, ec_dev->din, ec_dev->din_size, GFP_KERNEL | __GFP_ZERO);
> +       if (!ec_dev->din)
> +               return -ENOMEM;
>
> -       ec_dev->dout = devm_kzalloc(dev, ec_dev->dout_size, GFP_KERNEL);
> -       if (!ec_dev->dout) {
> -               devm_kfree(dev, ec_dev->din);
> -               ret = -ENOMEM;
> -               goto exit;
> -       }
> +       ec_dev->dout = devm_krealloc(dev, ec_dev->dout, ec_dev->dout_size, GFP_KERNEL | __GFP_ZERO);
> +       if (!ec_dev->dout)
> +               return -ENOMEM;
>
>         /* Probe if MKBP event is supported */
>         ret = cros_ec_get_host_command_version_mask(ec_dev,
> @@ -542,10 +534,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                                 "failed to retrieve wake mask: %d\n", ret);
>         }
>
> -       ret = 0;
> -
> -exit:
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL(cros_ec_query_all);
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 79150bf511fb..22f9322787f4 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -180,8 +180,7 @@ static void cros_ec_proto_test_query_all_pretest(struct kunit *test)
>
>         /*
>          * cros_ec_query_all() will free din and dout and allocate them again to fit the usage by
> -        * calling devm_kfree() and devm_kzalloc().  Set them to NULL as they aren't managed by
> -        * ec_dev->dev.
> +        * calling devm_krealloc().  Set them to NULL as they aren't managed by ec_dev->dev.
>          */
>         ec_dev->din = NULL;
>         ec_dev->dout = NULL;
> --
> 2.36.1.255.ge46751e96f-goog
>
