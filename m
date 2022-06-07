Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268DB541D49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384239AbiFGWKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378652AbiFGVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:07:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4543212C8B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:50:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x5so19075633edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8c7XviK21D78aKTK2Cw12N8OINsCSGJ3h/K2HP8/hE=;
        b=pICBQz1mVIybEDl/G3L+dmdC4HRSaeRO6lQ1VcLVqAZ6o1+6BKi52O9EzTjqWgsg+/
         M/ZGaVBOBEr1drYZjV+EvQPZCLMtxVL0UI1BGCbM8ZuVtIoxGx8o1X00bnsjpaJtQiRl
         iawaA4VEMwhiOTmtrW+v/tBqQFcUPMjO8yUoEu4Z6zr7p73AH7Hy7V66yU7r8Dk2Qdj3
         SNErw5AFTGEImdVDQL7wgDrXnCpRSwANNDdnUPZHJq3SVz0vk2bGjv0dQsX7zl9Tb/pg
         MhdjPqpkE3/JpZOx32vX3QJOllZbZhJwYzm3otHivev/9DgVcTmKSCrzxmqcdMZENlgF
         gaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8c7XviK21D78aKTK2Cw12N8OINsCSGJ3h/K2HP8/hE=;
        b=LFA1PTf59AkowIyWMa8jLYtle6SxaorgEupZwNeQHVfr20Qtu3u1bwp5UVU0236E46
         aT0kHW3qrQ+kMykDYJDJX6TPUkbRZVbeoPS2lHMC4p3kwkmxIEwzzwzZ37dUJJ6WNXdD
         Y204pX+WH8CiNSnwNTTB62jLBM5Rq2H7coZGA8gRa2NWdsIpd+ED0sTp047K9GtcufHS
         xs3LIC0Cj+Q2KtDWWsARLLIHzkZdGMrjUaWk3JxyaIqvmN0LFc/sH/jXFztov3ZdFSmh
         akh2efnVz/aVo+7nnrQsRHB7rEPsk+JQVECmvshX2jviSaR0eFUvxuTnUnnJX+Bn9VCr
         /vNw==
X-Gm-Message-State: AOAM5302czbBjHITd1qQziSXOzZQmSqJZrPTzwYpNtelkA/z2p0Sulu+
        0rXZZCjqUisW7XlZ4ygtZK6AQEOsCLfOAiC9f1vw8w==
X-Google-Smtp-Source: ABdhPJyOYG+zuoZtsjzyDwfyMmgPIdt9vGdA6yyokIa9vv1x6iUtTx1isMRgtHomYi793FVbBT5TipH8fRvG8j0yDnc=
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr24686982edd.11.1654627845656; Tue, 07
 Jun 2022 11:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220607145639.2362750-1-tzungbi@kernel.org> <20220607145639.2362750-10-tzungbi@kernel.org>
In-Reply-To: <20220607145639.2362750-10-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Jun 2022 11:50:34 -0700
Message-ID: <CABXOdTfErYRQm5TxKGCBp6+kaRwz=5u=uceKzqnE2iBJvojKQw@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] platform/chrome: cros_ec_proto: separate cros_ec_get_proto_info_legacy()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Rename cros_ec_host_command_proto_query_v2() to
> cros_ec_get_proto_info_legacy() and make it responsible for setting
> `ec_dev` fields for EC protocol v2.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> Changes from v1:
> - Preserve the "cros_ec_" prefix.
>
>  drivers/platform/chrome/cros_ec_proto.c      | 72 +++++++++-----------
>  drivers/platform/chrome/cros_ec_proto_test.c | 22 +++---
>  2 files changed, 44 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 6f5be9e5ede4..04b9704ed302 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -351,51 +351,57 @@ static int cros_ec_get_proto_info(struct cros_ec_device *ec_dev, int devidx)
>         return ret;
>  }
>
> -static int cros_ec_host_command_proto_query_v2(struct cros_ec_device *ec_dev)
> +static int cros_ec_get_proto_info_legacy(struct cros_ec_device *ec_dev)
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
> @@ -467,20 +473,8 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                 cros_ec_get_proto_info(ec_dev, CROS_EC_DEV_PD_INDEX);
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
> +               ret = cros_ec_get_proto_info_legacy(ec_dev);
> +               if (ret) {
>                         /*
>                          * It's possible for a test to occur too early when
>                          * the EC isn't listening. If this happens, we'll
> @@ -488,7 +482,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                          */
>                         ec_dev->proto_version = EC_PROTO_VERSION_UNKNOWN;
>                         dev_dbg(ec_dev->dev, "EC query failed: %d\n", ret);
> -                       goto exit;
> +                       return ret;
>                 }
>         }
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 473714964cf2..9f7d9666369f 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -484,7 +484,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct ku
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 struct ec_response_hello *data;
>
> @@ -511,7 +511,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return_error(struct ku
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 struct ec_params_hello *data;
>
> @@ -549,7 +549,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return0(struct kunit *
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 struct ec_response_hello *data;
>
> @@ -576,7 +576,7 @@ static void cros_ec_proto_test_query_all_legacy_normal_v3_return0(struct kunit *
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 struct ec_params_hello *data;
>
> @@ -614,7 +614,7 @@ static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, -EIO, EC_RES_SUCCESS, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -637,7 +637,7 @@ static void cros_ec_proto_test_query_all_legacy_xfer_error(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -662,7 +662,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> @@ -670,7 +670,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
>
>         cros_ec_proto_test_query_all_pretest(test);
>         ret = cros_ec_query_all(ec_dev);
> -       KUNIT_EXPECT_EQ(test, ret, EC_RES_INVALID_COMMAND);
> +       KUNIT_EXPECT_EQ(test, ret, -EOPNOTSUPP);
>         KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
>
>         /* For cros_ec_get_proto_info() without passthru. */
> @@ -685,7 +685,7 @@ static void cros_ec_proto_test_query_all_legacy_return_error(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -710,7 +710,7 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 struct ec_response_hello *data;
>
> @@ -738,7 +738,7 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
>         }
>
> -       /* For cros_ec_host_command_proto_query_v2(). */
> +       /* For cros_ec_get_proto_info_legacy(). */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> --
> 2.36.1.255.ge46751e96f-goog
>
