Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72525250F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355807AbiELPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355805AbiELPLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:11:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E76F554B3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:11:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dk23so10848928ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AwmGRZiz5OBa3h7F2JloJbsspAv/u88JHvx56Jj1Qw=;
        b=eSsQw/2koso7HKgPGY+qaB5sAH4bsxeOrb4Hiypsv/qbj9Yua5XDR0oXLO8kLzOwii
         oUFZjt8YDj0Y3S1sTOy9xJwK1yGNmdTBm1o84VgSlmii1GealU4f9wgfZm5hT6docTaM
         F1/QpgsCsWfR5K4dv0xDPRp82d2GhBTzCX+VhI2YVgLtFY4Gkpq34HTZyniCs2rBNPaf
         kjCHxe9F/12Qom2jDIcpUc8u+84s1MbkBVgaxuULnkWwxdXFqR+iCjy8Wa0JwCYkfADw
         jo9lbaqw/yRvIZbeghEq9MkMx/IZ/8VPKszrxp2zJ4iMDuTVoYkZW5CFiOAXl91Y7uvH
         AtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AwmGRZiz5OBa3h7F2JloJbsspAv/u88JHvx56Jj1Qw=;
        b=be5F2h1jJTJPyR5+qGrBY51H8a4y0BoUfA4tg3+y99HEf7i5yRBz2EKTM3vyX9EDak
         lyiEFCLbad96nT0bmqMhWLmMrm08zvv6UWy2YeRZ5H+/zvwcjb8x7FDPRFkNTBNKUluu
         B88HG0wzcNlrwQv45n2RtpXdM/t2VeceZG6REWok9yShzsTYCVyQCUhn1vdKfwNkVCFG
         MN9xcbyaSRlxJldGDU/XgjPjYFntG+dI6q7ooHLez1h4mcWaHMPNjtIgQsLZh6sfL5EU
         JzrBsuAnNOp1MgDV5IsqRdKFr7X55tnGXavQR6TE1pqv0i/TGgjxv0vtJDGqol7SGeDD
         8yQQ==
X-Gm-Message-State: AOAM530W4IBAYdcEX1g7d1yf7W3rzhh+Iyad30GoF5Damk834ZwzHSWW
        uFIGLKcjsEAKNmmpFxGTJXom9VqwFXxMlb8MAFlnmQ==
X-Google-Smtp-Source: ABdhPJz2dDA+OPU/KX/Q+/9cZuuZabKhHqEim53rurCejKAXVoPdzgRMBPGG81WG8lgIKAv/XGbRxv7cltM+5BmnP+U=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr310876ejc.631.1652368287563; Thu, 12
 May 2022 08:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220512083627.885338-1-tzungbi@kernel.org> <20220512083627.885338-3-tzungbi@kernel.org>
In-Reply-To: <20220512083627.885338-3-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 May 2022 08:11:16 -0700
Message-ID: <CABXOdTeZCo-dL8k=1VaGfTycj==USab+hQFvmnyT3uyXkAfOQw@mail.gmail.com>
Subject: Re: [PATCH 2/6] platform/chrome: correct cros_ec_prepare_tx() usage
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

On Thu, May 12, 2022 at 1:36 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_prepare_tx() returns either:
> - >= 0 for number of prepared bytes.
> - < 0 for -errno.
>
> Correct the comment and make sure all callers check the return code.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Makes sense in the context of the next patch.

Reviewed-by: Guenter Roeck <groeck@chromim.org>

> ---
>  drivers/platform/chrome/cros_ec_i2c.c   | 2 ++
>  drivers/platform/chrome/cros_ec_ishtp.c | 4 +++-
>  drivers/platform/chrome/cros_ec_lpc.c   | 2 ++
>  drivers/platform/chrome/cros_ec_proto.c | 2 +-
>  drivers/platform/chrome/cros_ec_rpmsg.c | 2 ++
>  drivers/platform/chrome/cros_ec_spi.c   | 4 ++++
>  6 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index 22feb0fd4ce7..a4f305f1eb0e 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -89,6 +89,8 @@ static int cros_ec_pkt_xfer_i2c(struct cros_ec_device *ec_dev,
>
>         ec_dev->dout++;
>         ret = cros_ec_prepare_tx(ec_dev, msg);
> +       if (ret < 0)
> +               goto done;
>         ec_dev->dout--;
>
>         /* send command to EC and read answer */
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index 4020b8354bae..cb2031cf7106 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -521,7 +521,9 @@ static int cros_ec_pkt_xfer_ish(struct cros_ec_device *ec_dev,
>         out_msg->hdr.status = 0;
>
>         ec_dev->dout += OUT_MSG_EC_REQUEST_PREAMBLE;
> -       cros_ec_prepare_tx(ec_dev, msg);
> +       rv = cros_ec_prepare_tx(ec_dev, msg);
> +       if (rv < 0)
> +               goto end_error;
>         ec_dev->dout -= OUT_MSG_EC_REQUEST_PREAMBLE;
>
>         dev_dbg(dev,
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 8eeef85a96b1..7677ab3c0ead 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -147,6 +147,8 @@ static int cros_ec_pkt_xfer_lpc(struct cros_ec_device *ec,
>         u8 *dout;
>
>         ret = cros_ec_prepare_tx(ec, msg);
> +       if (ret < 0)
> +               goto done;
>
>         /* Write buffer */
>         cros_ec_lpc_ops.write(EC_LPC_ADDR_HOST_PACKET, ret, ec->dout);
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index db1c8ba43171..2d6d3fbfa905 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -164,7 +164,7 @@ static int send_command(struct cros_ec_device *ec_dev,
>   * only SPI uses it. Once LPC uses the same protocol it can start using it.
>   * I2C could use it now, with a refactor of the existing code.
>   *
> - * Return: 0 on success or negative error code.
> + * Return: number of prepared bytes on success or negative error code.
>   */
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>                        struct cros_ec_command *msg)
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index d96d15b8ca94..39d3b50a7c09 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -89,6 +89,8 @@ static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
>
>         ec_msg->result = 0;
>         len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +       if (len < 0)
> +               return len;
>         dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
>
>         reinit_completion(&ec_rpmsg->xfer_ack);
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 8493af0f680e..589f18e9537d 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -401,6 +401,8 @@ static int do_cros_ec_pkt_xfer_spi(struct cros_ec_device *ec_dev,
>         unsigned long delay;
>
>         len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +       if (len < 0)
> +               return len;
>         dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
>
>         /* If it's too soon to do another transaction, wait */
> @@ -544,6 +546,8 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
>         unsigned long delay;
>
>         len = cros_ec_prepare_tx(ec_dev, ec_msg);
> +       if (len < 0)
> +               return len;
>         dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
>
>         /* If it's too soon to do another transaction, wait */
> --
> 2.36.0.512.ge40c2bad7a-goog
>
