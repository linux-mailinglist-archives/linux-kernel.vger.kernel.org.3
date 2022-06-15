Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED48A54CED3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356848AbiFOQgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356774AbiFOQgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:36:06 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E7736B51
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:36:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d14so16949443eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxdG4nvp1mL9v47CQ0n2NZ6jB4BK+F4ml55XmGZjxlc=;
        b=aW4eUYpoym+2aS3zwn0yIvdinvpv4nBYcZa0yWHIXMRk4htHFwFuUN587n4WBK2GKW
         t+9ekXMwJeoX4f95TduKbtGnuc2xGVwBdQkMLjR1J35sgCXFVVE73zSmJRWb9d8kWOql
         PaZMGFJZrM4k969lkherPxF/u7g+8v4SetpwtSjEk6sQ1ePpVrFj9VhPlKfafru3gDd7
         WWWrEzKhx7k48t+rlVfiXJnN+OaC91gwGLo81ccyObTXtA37ihTzM6eZmtuvoDCgXq4b
         yRk9wKlfxrc7VSdIyA07IAVog1rX8Lp+HSVGtYYOtGtoyeVvt7zFO6so6moGuHeFvFVb
         8Ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxdG4nvp1mL9v47CQ0n2NZ6jB4BK+F4ml55XmGZjxlc=;
        b=eIuE2fqah2SdDqFm31gBWMsuRiG5j36K5mz5KYwyooIcAj2j9jau80GnmBfj47C+mX
         sqE8tKDxb9Vn9bIM+K6zQa+0J8jKg5MEtJTCrk7KbJqrNhiQSp68hh+sbdMSW7SPIb2Y
         K9aZDDkfZ713DiH5tMN7dpG9o/MPV9vJhiuzRGX9eg3W47V3zI1oXLUtKp84poG3MGzN
         qxBnQ5MJ91c6wDx39V7OsMexX7qjbgkQiH/Cw+tXaPZhbzMeMjE0nVb+/OGOZX72tSZb
         mCbItrrwbrm5F1dT8MBgnRkzo/1lXYWD4ngfawVhzCSjKPz9rZ0FV0n7cD6lHmWy37x2
         M3QQ==
X-Gm-Message-State: AJIora+Grp9JzF1snHX9bHfKB17t0xopX9AgUHwHgIugekCYbQw19445
        3XSNZffIYgNIDUhOjBoBiC97kQqEpeA22E8zAFOc3g==
X-Google-Smtp-Source: AGRyM1sSYb0g1SC7WPMPbaMd7Nx3KmcIHuYDPLUx8zbSDMp27tkyaiNWX33VSGMY//qWrGXFwyjTzYyBdUa05Dnk5Nk=
X-Received: by 2002:a05:6402:f14:b0:42d:f989:4a21 with SMTP id
 i20-20020a0564020f1400b0042df9894a21mr783793eda.168.1655310963717; Wed, 15
 Jun 2022 09:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220615051248.1628156-1-tzungbi@kernel.org> <20220615051248.1628156-5-tzungbi@kernel.org>
In-Reply-To: <20220615051248.1628156-5-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 Jun 2022 09:35:52 -0700
Message-ID: <CABXOdTcnB8cQgWOLm5tTxzoUxAZ2Q5=nv0xirtNNOBf5th2Zyg@mail.gmail.com>
Subject: Re: [PATCH 04/11] platform/chrome: cros_ec_proto: separate cros_ec_xfer_command()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
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

On Tue, Jun 14, 2022 at 10:13 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_send_command() has extra logic to handle EC_RES_IN_PROGRESS.
> Separate the command transfer part into cros_ec_xfer_command() so
> that other functions can re-use it.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index b02fd1414e52..0cec013be3d3 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -107,7 +107,7 @@ static int prepare_tx_legacy(struct cros_ec_device *ec_dev,
>         return EC_MSG_TX_PROTO_BYTES + msg->outsize;
>  }
>
> -static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
>  {
>         int ret;
>         int (*xfer_fxn)(struct cros_ec_device *ec, struct cros_ec_command *msg);
> @@ -123,14 +123,21 @@ static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_co
>                  * the EC is trying to use protocol v2, on an underlying
>                  * communication mechanism that does not support v2.
>                  */
> -               dev_err_once(ec_dev->dev,
> -                            "missing EC transfer API, cannot send command\n");
> +               dev_err_once(ec_dev->dev, "missing EC transfer API, cannot send command\n");
>                 return -EIO;
>         }
>
>         trace_cros_ec_request_start(msg);
>         ret = (*xfer_fxn)(ec_dev, msg);
>         trace_cros_ec_request_done(msg, ret);
> +
> +       return ret;
> +}
> +
> +static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +{
> +       int ret = cros_ec_xfer_command(ec_dev, msg);
> +
>         if (msg->result == EC_RES_IN_PROGRESS) {
>                 int i;
>                 struct cros_ec_command *status_msg;
> --
> 2.36.1.476.g0c4daa206d-goog
>
