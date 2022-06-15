Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238D954CED8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356806AbiFOQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345124AbiFOQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:38:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4021F4B852
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:38:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b8so16967585edj.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8QtN4XzLZnq5FtjqxJGB9A549vBQqdJ3TEES8BQ4Pk=;
        b=gLDfxQrYF5ad8pxzdjcSgxBHN4uNs3qU7vcruYCg3SXx12GaP0gBXG+0+byoa4Hlkq
         5UntpsriemGbdEr2SqszndiEMeO30/PkkdVkK/hvWET7of8v3Fp/FUwTFsKFQuN6n4TC
         D4DZnZRWNqh1BiiSMRMmFMYHkjU7mqrvDtnvE06m+VhHTqY/SMDuoDUuSUNrQP8DtwZY
         xTJXXALyBt4uLZwOb6k1S9dgLPskj62xYafGsrLK4kCBlZGY6NsBNBljuBns9qAy7Nfv
         u1/YaSTAFh9ouS6XnEw26ptMNqspMZPde3YXj7ESCN0E/YjKhD8rtlgkmrYTW2pn6mDb
         DMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8QtN4XzLZnq5FtjqxJGB9A549vBQqdJ3TEES8BQ4Pk=;
        b=BCgxZbLIt6JNUTeZoiipsXfcwjqVyOU0J1zZ7vwhXj9SdEFBcelGV3ZGDbDs7aQf5I
         syMO9BCA3zHUs1/6tissUTHW/rDHL0+hDGlH1MueVRdV9kNTArlf9Cvzx1hA2eCTgn+V
         xnaJrNSALzP7uH5rQBsmcf8E77Fqc4asQPZe3/jX8s3M1zGpr//yTjwbfbPEtauogFAQ
         jAUtDUBxIAch5WHrWTUOmdyfwaRjxkP6M6wOkNaW8+CoMwUuOR20rDkakVqP41uNxeHI
         w9msfCl1otqkwySg1N2B8US/q0EqcQEdcz1YD1b6yYl1PJ82N2Htr/mEltB+R00eYYlB
         54aA==
X-Gm-Message-State: AJIora/uQ0vgRSupNswRsdX1vJRyGZuud1Ujvg9xeGSkg76eSaKBOcgL
        XZMHQf650IVhLYaucUMN3EAKDhzr9Li7Nr6MeXph7A==
X-Google-Smtp-Source: AGRyM1sG1vEw/UsbwTi/KWTo6GKMp/A8na4F6yH3k0aow5UDsoItSAOfMHo1AdK3oVR9x/hkw5pnqy9fPi82lAYhdrI=
X-Received: by 2002:a05:6402:f14:b0:42d:f989:4a21 with SMTP id
 i20-20020a0564020f1400b0042df9894a21mr796749eda.168.1655311101530; Wed, 15
 Jun 2022 09:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220615051248.1628156-1-tzungbi@kernel.org> <20220615051248.1628156-4-tzungbi@kernel.org>
In-Reply-To: <20220615051248.1628156-4-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 Jun 2022 09:38:10 -0700
Message-ID: <CABXOdTdMWjXAUNz2jdZNjgbBnm-RpSHKxGJ_XEJoXUycBdTscQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_send_command()
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
> cros_ec_cmd_xfer() is the only exported function that calls static
> function cros_ec_send_command().
>
> Add Kunit tests for cros_ec_send_command() through calling
> cros_ec_cmd_xfer().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 265 +++++++++++++++++++
>  drivers/platform/chrome/cros_kunit_util.c    |  20 ++
>  drivers/platform/chrome/cros_kunit_util.h    |   4 +
>  3 files changed, 289 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 33721607a5b9..64100fd81c6a 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1680,6 +1680,262 @@ static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru(struct
>         KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
>  }
>
> +static void cros_ec_proto_test_cmd_xfer_protocol_v3_normal(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->proto_version = 3;
> +       ec_dev->cmd_xfer = cros_kunit_ec_cmd_xfer_mock;
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_cmd_xfer_mock_called, 0);
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 1);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_protocol_v3_no_op(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->proto_version = 3;
> +       ec_dev->cmd_xfer = cros_kunit_ec_cmd_xfer_mock;
> +       ec_dev->pkt_xfer = NULL;
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EIO);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_protocol_v2_normal(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->proto_version = 2;
> +       ec_dev->cmd_xfer = cros_kunit_ec_cmd_xfer_mock;
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_cmd_xfer_mock_called, 1);
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 0);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_protocol_v2_no_op(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->proto_version = 2;
> +       ec_dev->cmd_xfer = NULL;
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EIO);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_in_progress_normal(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       /* For the first host command to return EC_RES_IN_PROGRESS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For EC_CMD_GET_COMMS_STATUS. */
> +       {
> +               struct ec_response_get_comms_status *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (struct ec_response_get_comms_status *)mock->o_data;
> +               data->flags = 0;
> +       }
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_comms_status));
> +
> +       KUNIT_EXPECT_EQ(test, msg.result, EC_RES_SUCCESS);
> +
> +       /* For the first host command to return EC_RES_IN_PROGRESS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For EC_CMD_GET_COMMS_STATUS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_COMMS_STATUS);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_comms_status));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_in_progress_retries_eagain(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       /* For the first host command to return EC_RES_IN_PROGRESS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
> +       cros_kunit_ec_xfer_mock_default_ret = -EAGAIN;
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
> +
> +       /* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 51);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       /* For the first host command to return EC_RES_IN_PROGRESS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
> +       {
> +               struct ec_response_get_comms_status *data;
> +               int i;
> +
> +               for (i = 0; i < 50; ++i) {
> +                       mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +                       KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +                       data = (struct ec_response_get_comms_status *)mock->o_data;
> +                       data->flags |= EC_COMMS_STATUS_PROCESSING;
> +               }
> +       }
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_comms_status));
> +
> +       KUNIT_EXPECT_EQ(test, msg.result, EC_RES_SUCCESS);
> +
> +       /* For EC_CMD_GET_COMMS_STATUS EC_COMMAND_RETRIES times. */
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 51);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_in_progress_xfer_error(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       /* For the first host command to return EC_RES_IN_PROGRESS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For EC_CMD_GET_COMMS_STATUS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, -EIO, EC_RES_SUCCESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EIO);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_in_progress_return_error(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       ec_dev->pkt_xfer = cros_kunit_ec_pkt_xfer_mock;
> +
> +       /* For the first host command to return EC_RES_IN_PROGRESS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_IN_PROGRESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For EC_CMD_GET_COMMS_STATUS. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +       KUNIT_EXPECT_EQ(test, msg.result, EC_RES_INVALID_COMMAND);
> +
> +       KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -1750,6 +2006,15 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_insize),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v3_normal),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v3_no_op),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v2_normal),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_protocol_v2_no_op),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_normal),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_retries_eagain),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_retries_status_processing),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_xfer_error),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return_error),
>         {}
>  };
>
> diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
> index e031777dea87..3ede971e82ee 100644
> --- a/drivers/platform/chrome/cros_kunit_util.c
> +++ b/drivers/platform/chrome/cros_kunit_util.c
> @@ -15,6 +15,10 @@
>
>  int cros_kunit_ec_xfer_mock_default_ret;
>  EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);
> +int cros_kunit_ec_cmd_xfer_mock_called;
> +EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock_called);
> +int cros_kunit_ec_pkt_xfer_mock_called;
> +EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock_called);
>
>  static struct list_head cros_kunit_ec_xfer_mock_in;
>  static struct list_head cros_kunit_ec_xfer_mock_out;
> @@ -46,6 +50,20 @@ int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_comman
>  }
>  EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock);
>
> +int cros_kunit_ec_cmd_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +{
> +       ++cros_kunit_ec_cmd_xfer_mock_called;
> +       return cros_kunit_ec_xfer_mock(ec_dev, msg);
> +}
> +EXPORT_SYMBOL_GPL(cros_kunit_ec_cmd_xfer_mock);
> +
> +int cros_kunit_ec_pkt_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg)
> +{
> +       ++cros_kunit_ec_pkt_xfer_mock_called;
> +       return cros_kunit_ec_xfer_mock(ec_dev, msg);
> +}
> +EXPORT_SYMBOL_GPL(cros_kunit_ec_pkt_xfer_mock);
> +
>  struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size)
>  {
>         return cros_kunit_ec_xfer_mock_addx(test, size, EC_RES_SUCCESS, size);
> @@ -90,6 +108,8 @@ EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
>  void cros_kunit_mock_reset(void)
>  {
>         cros_kunit_ec_xfer_mock_default_ret = 0;
> +       cros_kunit_ec_cmd_xfer_mock_called = 0;
> +       cros_kunit_ec_pkt_xfer_mock_called = 0;
>         INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_in);
>         INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_out);
>  }
> diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
> index 79c4525f873c..ae4080cb13f1 100644
> --- a/drivers/platform/chrome/cros_kunit_util.h
> +++ b/drivers/platform/chrome/cros_kunit_util.h
> @@ -24,8 +24,12 @@ struct ec_xfer_mock {
>  };
>
>  extern int cros_kunit_ec_xfer_mock_default_ret;
> +extern int cros_kunit_ec_cmd_xfer_mock_called;
> +extern int cros_kunit_ec_pkt_xfer_mock_called;
>
>  int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
> +int cros_kunit_ec_cmd_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
> +int cros_kunit_ec_pkt_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
>  struct ec_xfer_mock *cros_kunit_ec_xfer_mock_add(struct kunit *test, size_t size);
>  struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
>                                                   int ret, int result, size_t size);
> --
> 2.36.1.476.g0c4daa206d-goog
>
