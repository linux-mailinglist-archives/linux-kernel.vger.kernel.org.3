Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC4F59C522
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiHVRkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiHVRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:39:53 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA7140BDB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:39:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a15so8424986qko.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Uv1Q+ndEBe3HTyOw38AbCJJcJ5R32I7V4kRhxrLgtqM=;
        b=aaVljnny2CijbJQw8Eo8kTx5IQbRbBQye01zHb5XIHtWzHfRS3girC4c2pTvy8BKSd
         W/FWga+mevsxN6httb8QvZSqcH2ltMkEzQuJs2DCoaad/UHlhta9hSAa+JgoqonuHvyM
         DLnOEUsJTfLpFQkaxlD07AUwYUWfjWuDlbazo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Uv1Q+ndEBe3HTyOw38AbCJJcJ5R32I7V4kRhxrLgtqM=;
        b=Sf0NDBOBq+zMP2YcKT6rE+kGzFlfkRlYSDDrxz1QwUUXFuF2+YG4nBStUREmlC7U51
         Ruwp83oC/dsQhKpYwoV3kbnGRZW3gGgxGaHnXq8uO3EXL6ovQ46m8GdUPLM+UBlw//6w
         GkQR9t6LrKKCtpEUp9gl49vIk7lIbNLJvtSWLQlNH4QVZpBGIVQxamwb1kQBdNvdCXwa
         xHzHvHprlVqU4mKw0sctaYa4NbJOnTBUdH3+xe3vsHG2bCAZ8dbBd4IKZF5NgEh4E1SV
         Gj5UlH3iXG4pMAHovaWYhaHtPgF1AH1UZotKIwm6o2ZLDgN3TzhDjd8ekHlY5cyXJcNN
         1UoQ==
X-Gm-Message-State: ACgBeo0l+Qg3ywP/9THKBQ/E6NWCVScNPwJ47XedAQS0QjVLU7OJbHQT
        ybceqoV8cx/bGX7lryaImZjXw8kSLyPsAw==
X-Google-Smtp-Source: AA6agR54KoS9uL3g93esKZvxeoC2phfMKBajreNUbjKcgFaitrxFdQj5JPJPSF3A2ayQHCCG7rYQ7Q==
X-Received: by 2002:a05:620a:4f2:b0:6bb:5a52:6df6 with SMTP id b18-20020a05620a04f200b006bb5a526df6mr13237218qkh.715.1661189991520;
        Mon, 22 Aug 2022 10:39:51 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id r17-20020ac85e91000000b00344c29bc045sm2147439qtx.25.2022.08.22.10.39.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:39:51 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id h27so8414572qkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:39:51 -0700 (PDT)
X-Received: by 2002:a05:620a:ecf:b0:6bb:a38:43cb with SMTP id
 x15-20020a05620a0ecf00b006bb0a3843cbmr13064469qkm.742.1661189990763; Mon, 22
 Aug 2022 10:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220822112832.v6.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
In-Reply-To: <20220822112832.v6.1.I55189adfdb8d025fc991a0fa820ec09078619b15@changeid>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 22 Aug 2022 11:39:40 -0600
X-Gmail-Original-Message-ID: <CAHQZ30C=djXVvBt9kftvwDVrBQ2CBukO10aCh1keRZ2fGYtsEw@mail.gmail.com>
Message-ID: <CAHQZ30C=djXVvBt9kftvwDVrBQ2CBukO10aCh1keRZ2fGYtsEw@mail.gmail.com>
Subject: Re: [PATCH v6] platform/chrome: cros_ec_lpc: Move host event to prepare/complete
To:     Tim Van Patten <timvp@google.com>
Cc:     Rob Barnes <robbarnes@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the double email, I forgot to set my original reply to plain text.

On Mon, Aug 22, 2022 at 11:28 AM Tim Van Patten <timvp@google.com> wrote:
>
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> .prepare() and cros_ec_lpc_complete() during .complete(). This moves the
> host event that the AP sends and allows the EC to log entry/exit of AP's
> suspend/resume more accurately.
>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
>
> Changes in v6:
> - Fully restore fixes from v3.
>
> Changes in v5:
> - Restore fixes from v3.
>
> Changes in v4:
> - Update title and description.
>
> Changes in v3:
> - Update cros_ec_lpc_suspend() to cros_ec_lpc_prepare()
> - Update cros_ec_lpc_resume() to cros_ec_lpc_complete()
>
> Changes in v2:
> - Include cros_ec_resume() return value in dev_info() output.
> - Guard setting .prepare/.complete with #ifdef CONFIG_PM_SLEEP.
>
>  drivers/platform/chrome/cros_ec_lpc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 7677ab3c0ead..4158bdeee197 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -530,23 +530,31 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
>  MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
>
>  #ifdef CONFIG_PM_SLEEP
> -static int cros_ec_lpc_suspend(struct device *dev)
> +static int cros_ec_lpc_prepare(struct device *dev)
>  {
>         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
>
> +       dev_info(dev, "Prepare EC suspend\n");
> +
>         return cros_ec_suspend(ec_dev);
>  }
>
> -static int cros_ec_lpc_resume(struct device *dev)
> +static void cros_ec_lpc_complete(struct device *dev)
>  {
>         struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = cros_ec_resume(ec_dev);
>
> -       return cros_ec_resume(ec_dev);
> +       dev_info(dev, "EC resume completed: ret = %d\n", ret);
>  }
>  #endif
>
>  static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
> -       SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend, cros_ec_lpc_resume)
> +#ifdef CONFIG_PM_SLEEP
> +       .prepare = cros_ec_lpc_prepare,
> +       .complete = cros_ec_lpc_complete
> +#endif
>  };
>
>  static struct platform_driver cros_ec_lpc_driver = {
> --
> 2.37.2.609.g9ff673ca1a-goog
>

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
