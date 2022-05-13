Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB55262F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380649AbiEMNVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346448AbiEMNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:20:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209D3915A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:20:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id z2so16261514ejj.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD83ziJ2Qho4XkX8bpjsM8c+Xp4pjhuVQvUvmAtS3rE=;
        b=TUxDegrLBh1U0MnPtFzTADDsXSPEGhcUswvbfcvpQuBefZd31V7+cHEyDPsnW3OZ0f
         0xdwW8VJYLh1lAHGUVtCZbqKE3H17sxyE8Jej3wrPitNnrv8cKzUf2Do318YNFvMndhn
         H8HbOgmsH5zA37wRuaZVlGWWTreTM6159bmhDo+zx81D4CWs036ujwfg5IJyWt5IWtLB
         FDpmj4f6QPts3veFDiEqL0GisQF1dI0ITml4FEAD/dTfGyw5czclB+19WIs8wPTT3wrO
         DAfLJ0pbzKTBcQ9OMmsNPuFuQhW8ZVMte89ztEky/fSog+/evVqYW+816VRggyGXa2yK
         Tg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD83ziJ2Qho4XkX8bpjsM8c+Xp4pjhuVQvUvmAtS3rE=;
        b=5P68FvXVnQ4fKscPtHeYOwhxoimRKTKJUDGqhln2hLGPd1ZQLBx7KGpmcFgw+BN4dB
         e3HeW3YyfYTwV6jf+Cj5ffY4Nu+5yR8M6WqXsc1rzxsjHynQ4UZtHoBDGqVC68TfDLQx
         rS9GecZEF/EMhyTAp5C0w0Whh8o7PjUFJIlYF5Uim+fTDmOiSBwrOjhcpTa0aOrq/91b
         xNKvMM7mfhk1Di0egObgpPnIoDS627Xsrgdimm7fU8fitU2lvHlP/BC5w1Jx/ud6lRb7
         ct2e/RPjVKCtTsmOLlPYamfvZNEfOt2tQclk/KyUvrA5nIUPM0oo5ZzaF5gjsWHgxorT
         Vn0w==
X-Gm-Message-State: AOAM5306Q9+Hb5pLvKXG+uOHY2JYiL/WBNSfxfe5XtIkfQDFpN9AlEOp
        TIdfuEdYK7FEG6oSjdqWYV9yI7ZpdraphsKBTpCbHYHW1MHSOw==
X-Google-Smtp-Source: ABdhPJyYK4iU2XE2q/feN2S81RszcBQn11ZAXji1miavcqol3at/RK4ph3hAXXaGtPJjcephZQMoRbvwq5nlbjGz3d4=
X-Received: by 2002:a17:906:58d4:b0:6f4:cebd:c4b with SMTP id
 e20-20020a17090658d400b006f4cebd0c4bmr4222200ejs.492.1652448047829; Fri, 13
 May 2022 06:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220513044143.1045728-1-tzungbi@kernel.org> <20220513044143.1045728-8-tzungbi@kernel.org>
In-Reply-To: <20220513044143.1045728-8-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 13 May 2022 06:20:36 -0700
Message-ID: <CABXOdTft-YJHJNiw2xnigHsySOjJ1dDwFoQwXDiMADN5O2Loog@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] platform/chrome: cros_ec_spi: drop BUG_ON() if
 `din` isn't large enough
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

On Thu, May 12, 2022 at 9:42 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> It is overkill to crash the kernel if the `din` buffer is going to full
> or overflow.
>
> Drop the BUG_ON() and return -EINVAL instead.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v1:
> - Separate from the original 6th patch.
>
>  drivers/platform/chrome/cros_ec_spi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 5264615f46af..7360b3ff6e4f 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -160,7 +160,8 @@ static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
>         struct spi_message msg;
>         int ret;
>
> -       BUG_ON(buf - ec_dev->din + n > ec_dev->din_size);
> +       if (buf - ec_dev->din + n > ec_dev->din_size)
> +               return -EINVAL;
>
>         memset(&trans, 0, sizeof(trans));
>         trans.cs_change = 1;
> @@ -197,7 +198,8 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
>         unsigned long deadline;
>         int todo;
>
> -       BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
> +       if (ec_dev->din_size < EC_MSG_PREAMBLE_COUNT)
> +               return -EINVAL;
>
>         /* Receive data until we see the header byte */
>         deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
> @@ -304,7 +306,8 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
>         unsigned long deadline;
>         int todo;
>
> -       BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
> +       if (ec_dev->din_size < EC_MSG_PREAMBLE_COUNT)
> +               return -EINVAL;
>
>         /* Receive data until we see the header byte */
>         deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
> --
> 2.36.0.550.gb090851708-goog
>
