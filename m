Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699453E825
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbiFFQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiFFQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:06:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C73F99F5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:06:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so29894275ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAtCfvEl1lyvl2HOQAT6IS3UmkYl3/k1QXwg0oM1JYQ=;
        b=XXZmNZW3xMi87QDMR8nEBj1CKuCp+BG4Ywz5D7Ad/P1lIZcmbejl1Eo47KvEdOGLXW
         UbWUrXpiKO25dOeLKAGxUzH4Gkhqqys7KECw6DYJYEuqzlLsleyJqSh6S7eAew673SkA
         EcWAFCuyb29x3uWUz76WqLhALhymAi522ZDYu/jTqzuCVYqYJI7KTlRBwD484sS5tacl
         NaIjXdur74sasRFH41seIp2OKGOlS89GCm5qJKogyo3x0/Mnl4BOhwOjPSdn+vK4ADDz
         oXZsOOGg/nV22dyn1qXHSsRGJp9pllD+35HFTUoZEG4RqvsszywChl1udoYeWkdEDOwQ
         62xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAtCfvEl1lyvl2HOQAT6IS3UmkYl3/k1QXwg0oM1JYQ=;
        b=TP5n9zP3REJXxWvQHsHgHGf3FqELAU3phLIHloVkhK4Ntn0jZD76boHzRBjKz1hTxc
         42YMGAFEm/s5bKdQiwxFs0BEwRV1g1TR2IplA5d+zO5OilQ7SDFPvQ0sh3RI1PAEVv4g
         ZSmsPNdRt8w3siJZ+zlqFw7D1bmil2GcuFBdsdxLKn7AlsTkM8H5X1TNr4Q0OxcoB+8j
         KGRgb720ZF2ry+b/5LKr84VeDKqBqmKAMUpRirV9gNIH51VZ02lWi0HHmetJDh2l+PVO
         CDqXslFCdVm0pCRkThkqQ/JwWpCXnbK78yT/eDdo987JlbMvoedDskgwzobh1UUNd0wp
         AlrQ==
X-Gm-Message-State: AOAM533wuBDPjVtyx/8VnwIpl8DKczVudOhPnYvjulU6H3nCBmQZf7aZ
        mzbh5DZxMNu7CcoPAjiAScZJwXRDeL1Tb4W0XHrqDA==
X-Google-Smtp-Source: ABdhPJwLsxAo6HFC0fU1B+20a98Jl7PbB+opdSJcxqqbXe6miPGwB7qN9YvjJIUX/GtKfZv17X0TUuHIHDlNYYhz5D0=
X-Received: by 2002:a17:907:6ea4:b0:711:d106:b93a with SMTP id
 sh36-20020a1709076ea400b00711d106b93amr4782237ejc.189.1654531606488; Mon, 06
 Jun 2022 09:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-9-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-9-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 09:06:35 -0700
Message-ID: <CABXOdTcJiytvKpQhbka5cLySiM+_aUAS-k0COu+xteaAVKqttQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] platform/chrome: cros_ec_proto: separate fill_protocol_info_legacy()
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

On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Rename cros_ec_host_command_proto_query_v2() to
> fill_protocol_info_legacy() and make it responsible for setting `ec_dev`

cros_ec_get_proto_info_legacy() ?

> fields for EC protocol v2.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c      | 72 +++++++++-----------
>  drivers/platform/chrome/cros_ec_proto_test.c |  4 +-
>  2 files changed, 35 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index f57b4dba95b7..abb30a685567 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -344,51 +344,57 @@ static int fill_protocol_info(struct cros_ec_device *ec_dev, int devidx)
>         return ret;
>  }
>
> -static int cros_ec_host_command_proto_query_v2(struct cros_ec_device *ec_dev)
> +static int fill_protocol_info_legacy(struct cros_ec_device *ec_dev)
>  {
>         struct cros_ec_command *msg;
> -       struct ec_params_hello *hello_params;
> -       struct ec_response_hello *hello_response;
> +       struct ec_params_hello *params;
> +       struct ec_response_hello *response;
>         int ret;
> -       int len = max(sizeof(*hello_params), sizeof(*hello_response));
>
> -       msg = kmalloc(sizeof(*msg) + len, GFP_KERNEL);
> +       ec_dev->proto_version = 2;
> +
> +       msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*response)), GFP_KERNEL);
>         if (!msg)
>                 return -ENOMEM;
>
> -       msg->version = 0;
>         msg->command = EC_CMD_HELLO;
> -       hello_params = (struct ec_params_hello *)msg->data;
> -       msg->outsize = sizeof(*hello_params);
> -       hello_response = (struct ec_response_hello *)msg->data;
> -       msg->insize = sizeof(*hello_response);
> +       msg->insize = sizeof(*response);
> +       msg->outsize = sizeof(*params);
>
> -       hello_params->in_data = 0xa0b0c0d0;
> +       params = (struct ec_params_hello *)msg->data;
> +       params->in_data = 0xa0b0c0d0;
>
>         ret = send_command(ec_dev, msg);
> -
>         if (ret < 0) {
> -               dev_dbg(ec_dev->dev,
> -                       "EC failed to respond to v2 hello: %d\n",
> -                       ret);
> +               dev_dbg(ec_dev->dev, "EC failed to respond to v2 hello: %d\n", ret);
>                 goto exit;
> -       } else if (msg->result != EC_RES_SUCCESS) {
> -               dev_err(ec_dev->dev,
> -                       "EC responded to v2 hello with error: %d\n",
> -                       msg->result);
> -               ret = msg->result;
> +       }
> +
> +       ret = cros_ec_map_error(msg->result);
> +       if (ret) {
> +               dev_err(ec_dev->dev, "EC responded to v2 hello with error: %d\n", msg->result);
>                 goto exit;
> -       } else if (hello_response->out_data != 0xa1b2c3d4) {
> +       }
> +
> +       response = (struct ec_response_hello *)msg->data;
> +       if (response->out_data != 0xa1b2c3d4) {
>                 dev_err(ec_dev->dev,
>                         "EC responded to v2 hello with bad result: %u\n",
> -                       hello_response->out_data);
> +                       response->out_data);
>                 ret = -EBADMSG;
>                 goto exit;
>         }
>
> -       ret = 0;
> +       ec_dev->max_request = EC_PROTO2_MAX_PARAM_SIZE;
> +       ec_dev->max_response = EC_PROTO2_MAX_PARAM_SIZE;
> +       ec_dev->max_passthru = 0;
> +       ec_dev->pkt_xfer = NULL;
> +       ec_dev->din_size = EC_PROTO2_MSG_BYTES;
> +       ec_dev->dout_size = EC_PROTO2_MSG_BYTES;
>
> - exit:
> +       dev_dbg(ec_dev->dev, "falling back to proto v2\n");
> +       ret = 0;
> +exit:
>         kfree(msg);
>         return ret;
>  }
> @@ -460,20 +466,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                 fill_protocol_info(ec_dev, CROS_EC_DEV_PD_INDEX);
>         } else {
>                 /* Try querying with a v2 hello message. */
> -               ec_dev->proto_version = 2;
> -               ret = cros_ec_host_command_proto_query_v2(ec_dev);
> -
> -               if (ret == 0) {
> -                       /* V2 hello succeeded. */
> -                       dev_dbg(ec_dev->dev, "falling back to proto v2\n");
> -
> -                       ec_dev->max_request = EC_PROTO2_MAX_PARAM_SIZE;
> -                       ec_dev->max_response = EC_PROTO2_MAX_PARAM_SIZE;
> -                       ec_dev->max_passthru = 0;
> -                       ec_dev->pkt_xfer = NULL;
> -                       ec_dev->din_size = EC_PROTO2_MSG_BYTES;
> -                       ec_dev->dout_size = EC_PROTO2_MSG_BYTES;
> -               } else {
> +               ret = fill_protocol_info_legacy(ec_dev);
> +               if (ret) {
>                         /*
>                          * It's possible for a test to occur too early when
>                          * the EC isn't listening. If this happens, we'll
> @@ -481,7 +475,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                          */
>                         ec_dev->proto_version = EC_PROTO_VERSION_UNKNOWN;
>                         dev_dbg(ec_dev->dev, "EC query failed: %d\n", ret);
> -                       goto exit;
> +                       return ret;
>                 }
>         }
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index cdedbdfc1885..79150bf511fb 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -418,7 +418,7 @@ static void cros_ec_proto_test_query_all_legacy_normal(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For fill_protocol_info_legacy(). */
>         {
>                 struct ec_response_hello *data;
>
> @@ -445,7 +445,7 @@ static void cros_ec_proto_test_query_all_legacy_normal(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For fill_protocol_info_legacy(). */
>         {
>                 struct ec_params_hello *data;
>
> --
> 2.36.1.255.ge46751e96f-goog
>
