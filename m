Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B655E52C050
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiERQ0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240182AbiERQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:26:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A65D50E20
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:26:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c12so3677498eds.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OT9eEBFMeKZroeDVOBWrAfjCYcqI+X5VChXxs9BlrXg=;
        b=Gsl7VPQ9FyK0s5sL1fpz/EjhUZoQKGnGlpYrkZXH8BfbxKlvO5GUZPMlOfQz+y5b0t
         /3+JhrFXrolcoO2X5Onss7j27Lxsb9Ew1AC0L6/7HCsHCwgPBRwWU3FHfyMoIdbMeeqf
         YIDfQCWhi1TCO6M/Sdn6KoljmmkQjNNDN5fst0xkAjc9nj3OHmM4BRHkMKyxlFpU6a1S
         Gaf/zuL0mhBX5ySZz1xCfh6QXNOLHJJONgeNBlxRY3irGcwfekbX9znijLdKWdEU9hBj
         vLdo5SsbDeV1WlQxwvEg6rU9in5kF2p6DcdSMCKg3DNrL3zc/9SKETvhllh/zgiLQ+Zg
         zkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OT9eEBFMeKZroeDVOBWrAfjCYcqI+X5VChXxs9BlrXg=;
        b=W7Wpljn7o/LxvPBM1TkqMENpQM7X1uZAKDZETsMMUUv25FMntTxE9XeuL94aoDRVnc
         PSB0pi6jNTEQ44U9kJxpkjQCk2AAHTZyXLCeWlmVBI9i9jzyLCsTK9zz+PgR0F5Boj6t
         ZkkBQ+FaNtJCCw6R/wdnJTJ4t9gGd0MQsamEJAksTIxn55X67Q+yyNALHoblTjGVF3oj
         QDg9LmPgy5xWNnbLPJJ7VcR9Tm/nmir1uKma87A6+pmIlv8kyTRm9i05PGO5eW0sqq83
         4VgD55jVESW8a80buT4UFYq5zbfpSbMc5xHYFNysgkEqrC4bL3hLds7YMknhyGEQE0pP
         rAKg==
X-Gm-Message-State: AOAM5300O79a/tj+IHYw9xNmHI5EBBYV9lSPTaiyIaibicBiRzgSB//6
        dlvBRZMIWzytyU5PpvJKrB+euqVloGdAd33fUokf/g==
X-Google-Smtp-Source: ABdhPJxhxyt/6HNDWzDngc8o2BdNPg+mRcwwuAQDkoEXX/yMHM4iyhj0NqJ0xgaCR9pwDVqv2xyC5E11gy00UG4FXjM=
X-Received: by 2002:a05:6402:2709:b0:428:3ed9:abe3 with SMTP id
 y9-20020a056402270900b004283ed9abe3mr593155edd.51.1652891184623; Wed, 18 May
 2022 09:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220518091814.2028579-1-tzungbi@kernel.org> <20220518091814.2028579-3-tzungbi@kernel.org>
In-Reply-To: <20220518091814.2028579-3-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 18 May 2022 09:26:13 -0700
Message-ID: <CABXOdTe=K8V762Z3cgXq6qSFLosWKBfVQ1D4sCoZwqKY1RLNqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] platform/chrome: cros_ec_proto: factor legacy out
 from cros_ec_prepare_tx()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
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

On Wed, May 18, 2022 at 2:18 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_prepare_tx() mixed the code for both versions.  To be neat and to
> make it clear, factor the legacy part out as a separate function, rename
> the function, and update the comments.
>
> Specifically,
> - prepare_tx(), for current protocol version (i.e. 3).
> - prepare_tx_legacy(), for protocol version <= 2.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 51 ++++++++++++++-----------
>  1 file changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index ff767dccdf0f..01ab58b3269b 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -52,8 +52,8 @@ static int cros_ec_map_error(uint32_t result)
>         return ret;
>  }
>
> -static int prepare_packet(struct cros_ec_device *ec_dev,
> -                         struct cros_ec_command *msg)
> +static int prepare_tx(struct cros_ec_device *ec_dev,
> +                     struct cros_ec_command *msg)
>  {
>         struct ec_host_request *request;
>         u8 *out;
> @@ -85,6 +85,28 @@ static int prepare_packet(struct cros_ec_device *ec_dev,
>         return sizeof(*request) + msg->outsize;
>  }
>
> +static int prepare_tx_legacy(struct cros_ec_device *ec_dev,
> +                            struct cros_ec_command *msg)
> +{
> +       u8 *out;
> +       u8 csum;
> +       int i;
> +
> +       if (msg->outsize > EC_PROTO2_MAX_PARAM_SIZE)
> +               return -EINVAL;
> +
> +       out = ec_dev->dout;
> +       out[0] = EC_CMD_VERSION0 + msg->version;
> +       out[1] = msg->command;
> +       out[2] = msg->outsize;
> +       csum = out[0] + out[1] + out[2];
> +       for (i = 0; i < msg->outsize; i++)
> +               csum += out[EC_MSG_TX_HEADER_BYTES + i] = msg->data[i];
> +       out[EC_MSG_TX_HEADER_BYTES + msg->outsize] = csum;
> +
> +       return EC_MSG_TX_PROTO_BYTES + msg->outsize;
> +}
> +
>  static int send_command(struct cros_ec_device *ec_dev,
>                         struct cros_ec_command *msg)
>  {
> @@ -161,35 +183,18 @@ static int send_command(struct cros_ec_device *ec_dev,
>   * @ec_dev: Device to register.
>   * @msg: Message to write.
>   *
> - * This is intended to be used by all ChromeOS EC drivers, but at present
> - * only SPI uses it. Once LPC uses the same protocol it can start using it.
> - * I2C could use it now, with a refactor of the existing code.
> + * This is used by all ChromeOS EC drivers to prepare the outgoing message
> + * according to different protocol versions.
>   *
>   * Return: number of prepared bytes on success or negative error code.
>   */
>  int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
>                        struct cros_ec_command *msg)
>  {
> -       u8 *out;
> -       u8 csum;
> -       int i;
> -
>         if (ec_dev->proto_version > 2)
> -               return prepare_packet(ec_dev, msg);
> -
> -       if (msg->outsize > EC_PROTO2_MAX_PARAM_SIZE)
> -               return -EINVAL;
> -
> -       out = ec_dev->dout;
> -       out[0] = EC_CMD_VERSION0 + msg->version;
> -       out[1] = msg->command;
> -       out[2] = msg->outsize;
> -       csum = out[0] + out[1] + out[2];
> -       for (i = 0; i < msg->outsize; i++)
> -               csum += out[EC_MSG_TX_HEADER_BYTES + i] = msg->data[i];
> -       out[EC_MSG_TX_HEADER_BYTES + msg->outsize] = csum;
> +               return prepare_tx(ec_dev, msg);
>
> -       return EC_MSG_TX_PROTO_BYTES + msg->outsize;
> +       return prepare_tx_legacy(ec_dev, msg);
>  }
>  EXPORT_SYMBOL(cros_ec_prepare_tx);
>
> --
> 2.36.0.550.gb090851708-goog
>
