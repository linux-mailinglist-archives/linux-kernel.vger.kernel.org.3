Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E169B59794E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiHQVzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242411AbiHQVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:55:19 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E99A74EE
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:55:18 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e4so2961qvr.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6iOAwXpxZOVUHXB8pnKV77uAu2dNKxtKOB59ofq3cx0=;
        b=SMi3M2JKawKB04QJLnHqFZ/LmkLSeHzxSm902HdTCR6qJx7da2dOAPvgMCzRPiOkMA
         DIgjwC8LSvDG/blTfZF2wBDICdU0CKy8drmWMJR6qYI5O/NrHSGLpzD/zmpOyDGXeexN
         dt25pbk1PO30HMdnzL4rQ9EGoku5CG4Vb2kO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6iOAwXpxZOVUHXB8pnKV77uAu2dNKxtKOB59ofq3cx0=;
        b=bIJrOzjHAqT7cOQ/m7zn69oYuSyPVCzvNRmxmplEoq67drr2aI8BVLYNFxGnkwwtNo
         srDRJ/2z65xm0BxfWqMl/ikKVK+NSvg73VkSD2wJffncX5uXrKUdn3H9HX07F1yJCcCz
         5VNystADzHpQwXAAF/helIlCaAafSYnWmavmDO+7W98SDGyGbXvsiYvjEXGabns4nEmY
         9hr05b8MFyfACl4VpwwXgF9U8hrkhs8UP3f/W+6ZbQudL+uDIzjxUO2yAQTSkpborqEY
         NWyX+TFiIQWlVGH55U8cuZlLMho14mgI3k+8ATRIEjWfAG5AZhwqHUFEJbJ5cSs2tYKc
         eu7w==
X-Gm-Message-State: ACgBeo3XbNnlgH73J5IyOM0GvGnrEdjMxFgL3hXvGmYlxEcsE9VCA2L1
        FDiqpLFGYgUSLawk5iYrIuGHMg2xYLTvxObr
X-Google-Smtp-Source: AA6agR7exUP0d1itDUTpXNtbKXmJ3Zetu7nNde3rjKx771R97oyIjPNpKZeGUGmRIAaSh5KNiBWv8w==
X-Received: by 2002:a05:6214:f2d:b0:476:f37f:b844 with SMTP id iw13-20020a0562140f2d00b00476f37fb844mr24067758qvb.122.1660773317507;
        Wed, 17 Aug 2022 14:55:17 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006bb83e2e65fsm5915qkb.42.2022.08.17.14.55.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 14:55:17 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id x5so11414914qtv.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:55:16 -0700 (PDT)
X-Received: by 2002:ac8:5fd6:0:b0:343:4b4:1022 with SMTP id
 k22-20020ac85fd6000000b0034304b41022mr237274qta.616.1660773316641; Wed, 17
 Aug 2022 14:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
In-Reply-To: <20220802113957.v3.1.I2c8c550183162e7594309b66d19af696b8d84552@changeid>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 17 Aug 2022 15:55:05 -0600
X-Gmail-Original-Message-ID: <CAHQZ30AXMdqKp0yg7r8ja9SAkRO-e0APqYmZcD_5+nvrEeAycw@mail.gmail.com>
Message-ID: <CAHQZ30AXMdqKp0yg7r8ja9SAkRO-e0APqYmZcD_5+nvrEeAycw@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Tim Van Patten <timvp@google.com>
Cc:     Rob Barnes <robbarnes@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM

On Tue, Aug 2, 2022 at 11:40 AM Tim Van Patten <timvp@google.com> wrote:
>
> Update cros_ec_lpc_pm_ops to call cros_ec_lpc_prepare() during PM
> .prepare() and cros_ec_lpc_complete() during .complete(). This allows the
> EC to log entry/exit of AP's suspend/resume more accurately.
>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
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
> index 7677ab3c0ead9..4158bdeee197b 100644
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
> 2.37.1.455.g008518b4e5-goog
>

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
