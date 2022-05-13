Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3935262EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380660AbiEMNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346283AbiEMNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:19:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B213915A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:19:42 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m20so16186036ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjtIstNp0c2UwRkZcEawu+Z4HyD/5CYljBC5Qzt7IRw=;
        b=WWk2pKjEr+7luEqweZ/9eom+T6uDwSCVPyeYfsqySNCiNr3TYZnE/B1BbAK1DB+Fxp
         Tgg5/yPIc+xvg5k4UmEXNMXw/QYGqrJUhN9ieV6APZxY7vaDTncml+a2O5RgCtS4tk9c
         vikvS2I4B2s4Mf8tTz7fPsRKxTKRv/lnMJau/cn4zNMWlPYvdzRe8HFtWrlNT3la/Uai
         OHHnT7wLz08r1tAbpaxnfWMInnzxoFkS2p72k1b0QXLuq/0P/K7fZL8PsrGWJJYinyZG
         83S27bsxxY9AzGkh6y/RrOwM91wVaapacoadJnTTZvx5Q5a/QsguKfgViggMU7PQNUF7
         uiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjtIstNp0c2UwRkZcEawu+Z4HyD/5CYljBC5Qzt7IRw=;
        b=ZCJc9gHQuuAAMo7jabPlGRgNDDRI7IrAmFD/aSCvY7WLGNbNqGFQMPbvXq0R195xHS
         OG0/yi6eOf/q5nDsTNzQF3ZbJlCsFX8pVrr5nQNR83ZHhZsrx9YTjai9YFqTLjB4cWTO
         86ksAlm2GYOYgYvmRmvb1t9hpB40vVz5TFJxgBc+Hvbdn7+m8OM1k1wYJVhGmrTicOnf
         k2eGC0uw10O2NLtkEwRq79n4gtHT2+YmspES0R4WWi8psJ6mdLs7EauC3gvZsq5pH586
         GEf/aaFvHcfck1L0s/rZvzehkyS7AgwOqiZdJntk5T5shI3kiF/Z4d1S2SdhIIrq8PcW
         RIGw==
X-Gm-Message-State: AOAM531vBsK8tq+ZSyA2qfz5a5HiXK26qTRhdSfqcnM7CLDVn3KpLWoM
        GAPIcZ+rKaPW40rquS7JG+SvwqPTd/AjNpAEVKXLFA==
X-Google-Smtp-Source: ABdhPJwaBJUMzAtoEjoWsg3b+vhSGBRfFuint0S5WVou5f9UuctJB/8Ka9uB+fQevwQ6yiWp4dWjJlZM91fTtkT4Ptk=
X-Received: by 2002:a17:906:58d4:b0:6f4:cebd:c4b with SMTP id
 e20-20020a17090658d400b006f4cebd0c4bmr4218170ejs.492.1652447980708; Fri, 13
 May 2022 06:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220513044143.1045728-1-tzungbi@kernel.org> <20220513044143.1045728-7-tzungbi@kernel.org>
In-Reply-To: <20220513044143.1045728-7-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 13 May 2022 06:19:29 -0700
Message-ID: <CABXOdTdxZGQb4sLaBQU1eU9qRj_xgA8qrRmuCfavLqXpwG39=g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] platform/chrome: cros_ec_spi: drop unneeded BUG_ON()
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
> In the context, the following conditions are always false:
>
> - `todo` < 0
> Suppose that EC_SPI_FRAME_START is found at the last byte of transfer.
>
> In the case, `ptr` == `end` - 1.  As a result, `todo` must be 0.
>
> - `todo` > `ec_dev->din_size`
> Suppose that there is no preamble bytes.  EC_SPI_FRAME_START is found at
> the first byte of transfer.
>
> In the case, `end` == `ptr` + EC_MSG_PREAMBLE_COUNT.
> As a result, `todo` == EC_MSG_PREAMBLE_COUNT - 1.
> However, it already checked `ec_dev->din_size` < EC_MSG_PREAMBLE_COUNT at
> the beginning of function.
>
> Drop the unneeded BUG_ON().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v1:
> - Separate from the original 6th patch.
> - Drop the BUG_ON() instead of returning -EINVAL.
>
>  drivers/platform/chrome/cros_ec_spi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 589f18e9537d..5264615f46af 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -237,7 +237,6 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
>          * start of our buffer
>          */
>         todo = end - ++ptr;
> -       BUG_ON(todo < 0 || todo > ec_dev->din_size);
>         todo = min(todo, need_len);
>         memmove(ec_dev->din, ptr, todo);
>         ptr = ec_dev->din + todo;
> @@ -345,7 +344,6 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
>          * start of our buffer
>          */
>         todo = end - ++ptr;
> -       BUG_ON(todo < 0 || todo > ec_dev->din_size);
>         todo = min(todo, need_len);
>         memmove(ec_dev->din, ptr, todo);
>         ptr = ec_dev->din + todo;
> --
> 2.36.0.550.gb090851708-goog
>
