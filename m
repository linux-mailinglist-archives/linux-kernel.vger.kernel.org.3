Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF4573C68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiGMSQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiGMSQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:16:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812692E69D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:16:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id t1so5536672ejd.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0/VHpNQ9RNaH4zKX955bl36QOw/Zy/4YbokavoGCgM=;
        b=Ny4Pqz5A/eak6mJZG9FHAhtrBD57iegbQK9b5ZE/Wo0hwEKnlm79zPJSnzf9K7vSov
         iGsKF/twoL/k9zGAafixG9JVJHYDnpRlU7oOtrHiN+3f2PCEgTrVIg33Noggk4brABam
         xrx4O3+I+AaXtWQ3LzUlvCB7HzYgrsstAGI1V3nrQch5fRAFEprCPRXdcGLlw1vhBeLL
         BUt3LwuW8iwiKf4x8bV0RkeSZCq/4JyTfLci4DWKgChMy5fvD6lzU8NAa6rGfo9IoATM
         x6qt/3OYw+Hz64MfOUQE+e1OoU5QpvBrfrrfsWNKCOYOZXZa9s8zdNv0SPhx5ftHQ8KW
         rPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0/VHpNQ9RNaH4zKX955bl36QOw/Zy/4YbokavoGCgM=;
        b=8ERyvXXXvVk0SCA4/ktN+tawyMOtAKCrcXNnib6ydLvSFBHs/k1T5JVA/gEvbAxTrI
         BlOTKlWMqxXfpXNMP/8rGgsidfR88ARL/q37IsFFzSBQR6YU+nEbgatVYMx/XMNKuc8r
         NGDAZ2bXeThFn4twjXoZbX21P1XAqtslzAg977iNN3wygeyGl7NP4kxel9qjF2+NxGnO
         AeSl1R64Zj/QJ86NOTezPwMTtc1DsstacAJLJwaDkdCSQG9oLgFe5S/sUpP683beYvak
         D7duN3EXO+2fE6idP/8kdsrNdizYMpkTOHE4yNkQ8WqSzUGJkpswjbb99Do/b4+BOzKV
         TVkQ==
X-Gm-Message-State: AJIora/nnbPrAufBarsW3v1vrYxToSf7s+hyKcc80+qoHr4ATWMG87m3
        M0RBbDhrH4M5UrLAv1upLIjDa1R6IrS5ZF914cls9SiYpCo=
X-Google-Smtp-Source: AGRyM1uNgzHa05xSrO6VL9KZMSWI81JqTiirpvtPBwCpeY10b3CQqHu3PMPBz/XjB7tlpFaKSWjBXqN6UgZb3TSLAUw=
X-Received: by 2002:a17:907:720a:b0:72b:549e:305a with SMTP id
 dr10-20020a170907720a00b0072b549e305amr4447049ejc.691.1657736158879; Wed, 13
 Jul 2022 11:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220628024913.1755292-1-tzungbi@kernel.org> <20220628024913.1755292-6-tzungbi@kernel.org>
In-Reply-To: <20220628024913.1755292-6-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Jul 2022 11:15:47 -0700
Message-ID: <CABXOdTeC+q-UiPiThqL5MGg-+cGACGW4qLaLKZbmX4M26TvbDg@mail.gmail.com>
Subject: Re: [RESEND PATCH 05/11] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
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

On Mon, Jun 27, 2022 at 7:49 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> EC returns EC_RES_IN_PROGRESS if the host command needs more time to
> complete.  Whenever receives the return code, cros_ec_send_command()
> sends EC_CMD_GET_COMMS_STATUS to query the command status.
>
> Separate cros_ec_wait_until_complete() from cros_ec_send_command().
> It sends EC_CMD_GET_COMMS_STATUS and waits until the previous command
> was completed, or encountered error, or timed out.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 75 ++++++++++++-------------
>  1 file changed, 36 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 0cec013be3d3..466ecb063bd6 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -134,53 +134,50 @@ static int cros_ec_xfer_command(struct cros_ec_device *ec_dev, struct cros_ec_co
>         return ret;
>  }
>
> -static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +static int cros_ec_wait_until_complete(struct cros_ec_device *ec_dev, uint32_t *result)
>  {
> -       int ret = cros_ec_xfer_command(ec_dev, msg);
> +       struct cros_ec_command *msg;
> +       struct ec_response_get_comms_status *status;
> +       int ret = 0, i;
> +
> +       msg = kzalloc(sizeof(*msg) + sizeof(*status), GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;

AFAICS this is always 24 bytes. I would suggest to allocate it on the
stack to reduce overhead.
>
> -       if (msg->result == EC_RES_IN_PROGRESS) {
> -               int i;
> -               struct cros_ec_command *status_msg;
> -               struct ec_response_get_comms_status *status;
> +       msg->command = EC_CMD_GET_COMMS_STATUS;
> +       msg->insize = sizeof(*status);
>
> -               status_msg = kmalloc(sizeof(*status_msg) + sizeof(*status),
> -                                    GFP_KERNEL);
> -               if (!status_msg)
> -                       return -ENOMEM;
> +       status = (struct ec_response_get_comms_status *)msg->data;
>
> -               status_msg->version = 0;
> -               status_msg->command = EC_CMD_GET_COMMS_STATUS;
> -               status_msg->insize = sizeof(*status);
> -               status_msg->outsize = 0;
> +       /* Query the EC's status until it's no longer busy or we encounter an error. */
> +       for (i = 0; i < EC_COMMAND_RETRIES; ++i) {
> +               usleep_range(10000, 11000);
>
> -               /*
> -                * Query the EC's status until it's no longer busy or
> -                * we encounter an error.
> -                */
> -               for (i = 0; i < EC_COMMAND_RETRIES; i++) {
> -                       usleep_range(10000, 11000);
> -
> -                       trace_cros_ec_request_start(status_msg);
> -                       ret = (*xfer_fxn)(ec_dev, status_msg);
> -                       trace_cros_ec_request_done(status_msg, ret);
> -                       if (ret == -EAGAIN)
> -                               continue;
> -                       if (ret < 0)
> -                               break;
> -
> -                       msg->result = status_msg->result;
> -                       if (status_msg->result != EC_RES_SUCCESS)
> -                               break;
> -
> -                       status = (struct ec_response_get_comms_status *)
> -                                status_msg->data;
> -                       if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> -                               break;
> -               }
> +               ret = cros_ec_xfer_command(ec_dev, msg);
> +               if (ret == -EAGAIN)
> +                       continue;
> +               if (ret < 0)
> +                       break;

With the command allocated on the stack, this can return immediately.

> +
> +               *result = msg->result;
> +               if (msg->result != EC_RES_SUCCESS)
> +                       break;

Again, this can return immediately if the command buffer is on the stack.

>
> -               kfree(status_msg);
> +               if (!(status->flags & EC_COMMS_STATUS_PROCESSING))
> +                       break;

Can return immediately.

>         }
>
> +       kfree(msg);
> +       return ret;

What should this return on timeout ?

> +}
> +
> +static int cros_ec_send_command(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +{
> +       int ret = cros_ec_xfer_command(ec_dev, msg);
> +
> +       if (msg->result == EC_RES_IN_PROGRESS)
> +               ret = cros_ec_wait_until_complete(ec_dev, &msg->result);
> +
>         return ret;
>  }
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
