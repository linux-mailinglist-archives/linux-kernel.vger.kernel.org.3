Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCA4F979E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiDHOH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiDHOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:07:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E6117C43B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:05:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p15so15260334lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veQUvkDdzWhR8nicSgShJIzbzfet3GlWn/x9JD2dO50=;
        b=aRhq899TwsyNIUbE9EOcdEH8JKGgrvMMUkBisv/L4hk8U0NwLT6ab+jGnruJ8rfPkI
         464VZzLA+PcfQ9oCIFTylRZN1dC/ChrQ+np48nzoay705WLA05KfJxeiACgCTM0/BAbJ
         z2SpZWEuHq4lgRa7cDyPp0voG6v+og2blf5JacRDdB5aSnXV7eetVO7N3Y+Z0OqsPBFG
         5SgTJjdC65h7fKIzu579v72bBkVw+nIksf4hpuYmO7paVBboQx2Nx4/xjN89aLVndNEG
         s3biwn1bNMTaOHcPTigJ6PU1gSaMIcVrUBmMuzhf1TFT++gSwAGk/V1e4cJr8xP41DlG
         6Ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veQUvkDdzWhR8nicSgShJIzbzfet3GlWn/x9JD2dO50=;
        b=yK27mfsd27zg072ubtu/crjqxeBZLfA25mS4uhwt5GmZLwgXauF8SU4+kJI8x/IQ1Z
         w6RCcXxRP2R5fLYoIkZnjMHGRtQx7hgz+AYQsp8aAlM8SIYjnCZ8pMfmItkBJ81AZMyg
         b1vadnIgKXWRfeMhgah+LRcSVcbbPOEovBtd5eAyNv1/pYhMMzTf1xYFU6afv+m5ahqp
         PbIg6PbjRbAjaQu4G6jlX8xi4P7KBNF2LZuhRMNHm8drvj7/n2l9ua+X9w+EIo+NC4Ak
         457VaIUHFoFSoKfj6xpu4A064qqUsfm/t7mHMhzx+Ws2+UsQrgAvhfdQFncUwZa28dvX
         XZig==
X-Gm-Message-State: AOAM532FntSoBESjdjmNqgaJjO6wmglnoiaaoEZB12Kq489zmE1sEe4B
        wlnUzEx1WivNFtVWuFbokK9Y94OQUTZI2ZELxLn+8BwljAwkSw==
X-Google-Smtp-Source: ABdhPJzA2ibYfqWpb3xN2DuDt2LnVxoBWJn6QzJJ3Q+P15fDe8e3G6g0Ok0a2NR4jxmTWyPi7y3cC+TVoPmlWSp4BTA=
X-Received: by 2002:ac2:47e9:0:b0:46a:38a2:b0f4 with SMTP id
 b9-20020ac247e9000000b0046a38a2b0f4mr3523940lfp.71.1649426717296; Fri, 08 Apr
 2022 07:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher>
In-Reply-To: <1836398.tdWV9SEqCh@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 Apr 2022 16:04:41 +0200
Message-ID: <CAPDyKFoop_mtWV0i+fH8GSmaxbPCyCPmOeNi6GuK5Qrj7ZVo1g@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 at 21:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> A PM-runtime device usage count underflow is potentially critical,
> because it may cause a device to be suspended when it is expected to
> be operational.

I get the point. Although, perhaps we should also state that it's a
programming problem that we would like to catch and warn about?

>
> For this reason, (1) make rpm_check_suspend_allowed() return an error
> when the device usage count is negative to prevent devices from being
> suspended in that case, (2) introduce rpm_drop_usage_count() that will
> detect device usage count underflows, warn about them and fix them up,
> and (3) use it to drop the usage count in a few places instead of
> atomic_dec_and_test().
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   44 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -263,7 +263,7 @@ static int rpm_check_suspend_allowed(str
>                 retval = -EINVAL;
>         else if (dev->power.disable_depth > 0)
>                 retval = -EACCES;
> -       else if (atomic_read(&dev->power.usage_count) > 0)
> +       else if (atomic_read(&dev->power.usage_count))
>                 retval = -EAGAIN;
>         else if (!dev->power.ignore_children &&
>                         atomic_read(&dev->power.child_count))
> @@ -1039,13 +1039,33 @@ int pm_schedule_suspend(struct device *d
>  }
>  EXPORT_SYMBOL_GPL(pm_schedule_suspend);
>
> +static int rpm_drop_usage_count(struct device *dev)
> +{
> +       int ret;
> +
> +       ret = atomic_sub_return(1, &dev->power.usage_count);
> +       if (ret >= 0)
> +               return ret;
> +
> +       /*
> +        * Because rpm_resume() does not check the usage counter, it will resume
> +        * the device even if the usage counter is 0 or negative, so it is
> +        * sufficient to increment the usage counter here to reverse the change
> +        * made above.
> +        */
> +       atomic_inc(&dev->power.usage_count);

Rather than this two-step process, couldn't we just do an
"atomic_add_unless(&dev->power.usage_count, -1, 0)" - and check the
return value?

> +       dev_warn(dev, "Runtime PM usage count underflow!\n");
> +       return -EINVAL;
> +}
> +

[...]

Kind regards
Uffe
