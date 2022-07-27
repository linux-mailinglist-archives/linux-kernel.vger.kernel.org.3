Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7058331B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbiG0TJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiG0TJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:09:10 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9534D170
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:49:58 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31f56c42ab5so48750637b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anZ8ubpNYVfX+lGtJNiGuX09BswuO+VNMPfy/hAEQuE=;
        b=pPF/J3MGwDPrIJN1OQ46lQw4OjndBN5/rUvG8gbXClIZkks5vpHHgXylHF4Dj4ZZN8
         GL3zrZhDU5A2/S1oeNteZJPsoY5nKALHBccLWkjrFUDbKglBuHAcz5oyLGwWVC1anpeY
         5o/FS6aiLg+Qffm7qcvdkO/OvhD5bRAWOkMEQIsC+o/eSuajBPiUh6FMwY2HgH0PtcUg
         XIW0THvTPWZ0aB6fbU0D0wCyyLB0SMRDBRuhvyiRdmqwK93HOzmmv8hSz6OhjD/KiDDS
         nxn5DLSXy+DFVOE8lfw7/70u4cGcrvzUm1V4ohwakL5HL7XNIYA7p6Btis5YQuazt1oN
         sjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anZ8ubpNYVfX+lGtJNiGuX09BswuO+VNMPfy/hAEQuE=;
        b=i+c64snv4OApfmSOkgGGKYRUzLWygN9zPTBCbpKyUCOEih1TjiVVfvMmgUPINFWz59
         nn312Ms8284Bktoi1tLkPwPJRIlCtM3lkmovLe7SH1NJvAr2svjbWBPtp5bPp9wAzZ89
         LN6Q5c4HRDnFKjdFUb105FulHPMmMH5noEIgxuCADGMPWyIH6PCf9kPOp4YixpX0LD7a
         yHfRKF8dagx504T8lZtjQYv8snQOFHx2GrKsW2S1rVKHZiHFcmsZ9YsFVfm8H29EH+Si
         WUBIzp0//LFFaDf+WM9nMHt5d/E2ORGjexrFRAmsHRyoe/+z+7fjs0u2hMplr8CRwmFd
         1GIA==
X-Gm-Message-State: AJIora/WU+tuvpLmZ/dlu4NVcNdihGT/pP4v9Ezcd6vSHT1MwJqhi7Cl
        SuhAN7jqyKbz1n7wNLtMNztsKPHChD5eh2i4kEAM4A==
X-Google-Smtp-Source: AGRyM1uGY1jCYvf2PBnpbq6hutZYca/PGXO+xEfI02lj4Ab9ipx58Z36alx7V96FIP2hAdQF3lzMQJedR7KZoaeohXs=
X-Received: by 2002:a81:50d4:0:b0:31f:5f85:566a with SMTP id
 e203-20020a8150d4000000b0031f5f85566amr4520468ywb.218.1658947797362; Wed, 27
 Jul 2022 11:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt_cc5SiNv1Vbse=HYY_+uc+9OYPZuJ-x59bROSaLN6fw@mail.gmail.com>
In-Reply-To: <CA+G9fYt_cc5SiNv1Vbse=HYY_+uc+9OYPZuJ-x59bROSaLN6fw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 27 Jul 2022 11:49:21 -0700
Message-ID: <CAGETcx8bGwDkPP=d2MtcY69YmTyckUSa8xAwNVOPOyTR8jPk=A@mail.gmail.com>
Subject: Re: [next] arm: PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:44 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Linux next arm BeagleBoard x15 device boot failed due to the

Can you point me to the dts file that corresponds to this board
please? And if you know which devices are power domains, that'd be
handy too. For now, I'm reverting this patch.

-Saravana

> following commit. The x15 did not event showed any crash log
> on the serial console.
> whereas, Linux mainline kernel boot pass.
>
> Anders bisect this and found the first bad commit is
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Wed Jun 1 00:06:57 2022 -0700
>
>     PM: domains: Delete usage of driver_deferred_probe_check_state()
>
>     Now that fw_devlink=on by default and fw_devlink supports
>     "power-domains" property, the execution will never get to the point
>     where driver_deferred_probe_check_state() is called before the supplier
>     has probed successfully or before deferred probe timeout has expired.
>
>     So, delete the call and replace it with -ENODEV.
>
>     Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>     Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>     Link: https://lore.kernel.org/r/20220601070707.3946847-2-saravanak@google.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 739e52cd4aba..3e86772d5fac 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device
> *dev, struct device *base_dev,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return driver_deferred_probe_check_state(base_dev);
> +               return -ENODEV;
>         }
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
