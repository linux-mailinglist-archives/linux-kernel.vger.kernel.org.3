Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF0E525100
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355776AbiELPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344515AbiELPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:14:24 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB08F262709
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:14:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so10899270ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u1HiPt6El83plNrSLkAGuBjrIwscqUyOaYLijW4+kI=;
        b=SGkOEfmBRXouNoqxzf6hPYzUe+KKDSEXHdMYqMrIEyzQFtBEzUh9yE60B9BjPMv1/3
         CAModw8CHTSfruh9dwdt1oia1svoMbOwNkrl9k+Yza4G8NLgXzpfjaUHbQpc3NHCP6lt
         rOgvN9cSwKIobkpbUP4MLiaODRYyX/mFODpHMdGoqo91z6WYKQuo0kaail8HWNLJFm7r
         oEpoQXCcqo78YwnbCfV9c2RI995O0O1Usj61Cwh2Fzr6QkAS5WnNq39piWiv0Bi6GHQ6
         ZdsrIJwijClhQ3OG4QmV8m++5nK0NqSwYLC8B7bbxPTlvhVzYij43k7ccFd2a1pUvoOt
         n8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u1HiPt6El83plNrSLkAGuBjrIwscqUyOaYLijW4+kI=;
        b=dSqgNpp94JgDlKSzJnmcmJNqlrcQYgr3EnIfGliLMtluyjBXPIqaAFF1kCNlQMJeNW
         zSrYL2UmApHpG+hLNbTm6XdV9pCCMuqcLoc5hXKqZhJ2frjIxoThZ4Xq9dIwfh/p1Pv4
         hHhxTET04IJTNsHppWAYVPZoVY6EDw1dylMvkDPT23GTA16uU3WVnUhaJZbeiEpGRse+
         J4Z/QMjKOHw/S7Nxr/4c8CjzXNAT9UtwreEHhWvRI//ja/nY2KAtryY0jXbQUua7YhKO
         YA2yIwS6eBsW70uCwflsnYxPHw57nQsCqH5mIKuLa3+WqteH1ZAiJYyj4VUH8L3GpnJI
         7Mzw==
X-Gm-Message-State: AOAM530+SakjVgqpuCPpLWLKtXpDWz3Z5yKSceqcPXz2X4p/nVXuaNeK
        DV1uDnFucEhgRuRGfX0vwfhQ79JwiyuMHDzpmfWIBA==
X-Google-Smtp-Source: ABdhPJw5m0z/CmdfOhU+dqZxjqaMKJpcftWxfCERbCQDYh902+JstuqmfCHNkwRS3wN+w5yo2i3h7F5TFysGsE9liUo=
X-Received: by 2002:a17:907:8a17:b0:6f4:4b56:f550 with SMTP id
 sc23-20020a1709078a1700b006f44b56f550mr357869ejc.720.1652368461187; Thu, 12
 May 2022 08:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220512083627.885338-1-tzungbi@kernel.org> <20220512083627.885338-7-tzungbi@kernel.org>
In-Reply-To: <20220512083627.885338-7-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 May 2022 08:14:10 -0700
Message-ID: <CABXOdTftq_Gbf5UmYCLEfm00xJusm-ZaWnQt9KEhb7U-mY_1Pw@mail.gmail.com>
Subject: Re: [PATCH 6/6] platform/chrome: cros_ec_spi: drop BUG_ON()
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

On Thu, May 12, 2022 at 1:37 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> It is overkill to crash the kernel if the `din` buffer is going to full
> or overflow.
>
> Drop the BUG_ON() and return -EINVAL instead.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Wonder if the return code should be -EPROTO instead, but I don't have
a strong opinion.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_spi.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 589f18e9537d..0a938f317adc 100644
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
> @@ -237,7 +239,8 @@ static int cros_ec_spi_receive_packet(struct cros_ec_device *ec_dev,
>          * start of our buffer
>          */
>         todo = end - ++ptr;
> -       BUG_ON(todo < 0 || todo > ec_dev->din_size);
> +       if (todo < 0 || todo > ec_dev->din_size)
> +               return -EINVAL;
>         todo = min(todo, need_len);
>         memmove(ec_dev->din, ptr, todo);
>         ptr = ec_dev->din + todo;
> @@ -305,7 +308,8 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
>         unsigned long deadline;
>         int todo;
>
> -       BUG_ON(ec_dev->din_size < EC_MSG_PREAMBLE_COUNT);
> +       if (ec_dev->din_size < EC_MSG_PREAMBLE_COUNT)
> +               return -EINVAL;
>
>         /* Receive data until we see the header byte */
>         deadline = jiffies + msecs_to_jiffies(EC_MSG_DEADLINE_MS);
> @@ -345,7 +349,8 @@ static int cros_ec_spi_receive_response(struct cros_ec_device *ec_dev,
>          * start of our buffer
>          */
>         todo = end - ++ptr;
> -       BUG_ON(todo < 0 || todo > ec_dev->din_size);
> +       if (todo < 0 || todo > ec_dev->din_size)
> +               return -EINVAL;
>         todo = min(todo, need_len);
>         memmove(ec_dev->din, ptr, todo);
>         ptr = ec_dev->din + todo;
> --
> 2.36.0.512.ge40c2bad7a-goog
>
