Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B8B558013
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiFWQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiFWQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:39:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F7340E60
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:39:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ay16so22906267ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HOqbuGc0f6x9tR+0yfA94PilmjI5YMqHeIZhNb7JEk=;
        b=Il6aX5XnfiBoN5/6z3oP/ymABRj2BA2uoxnaLliYWTBPBwdl8eqFAp9ZpjbrjZyupq
         wH8eLjEulpuQGkxplvsnxcmlhAiK56A1WmcFtXzyw0TJZGgMP01Q1Y15ZUS7JpsUF0sj
         dPHMCe8aQRIJhhDjV86FpC8q7iL3GIfFhA5TnxkQLKDQk/ujMr/bWiplBlHzhliAdYKo
         +c8QmZ1nRnM4DQ+CjRjMU87vRDwxfioIOjnYykUk59iaATiu7sRzb9csT9FFZx/qb4A9
         1AQ+SSPtjJCzL6mOsZvJcJsQvjFf2f4rwcjLMD5KBQj6Vy/1m04Ofu7FxtaAY/ATzgbM
         JKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HOqbuGc0f6x9tR+0yfA94PilmjI5YMqHeIZhNb7JEk=;
        b=S3wuriAY310CEb71VhiJLwIEO3sqe3z1ZXLpsqRwiODboiiF0tCl4eTkhESi5UZWVD
         qslMHK4BSVdbSzlpcrjbNRwNImMjZ+HuQACtDJPBbnBwKK62JV1I56eP6OdQXPJwQGLe
         k3OdZQqiZTOWUHeGqXqL67VfQiSQSoHG/cQZPJGOHd8Zf5nJferMeIHFu0Oqq2xk/SVG
         HzYmeMAOWd/0saL3+7SlBjUcH2G3VTD/o8yaSb5bn81e+yKDuSwjuLP6KCdGpsh1CCsB
         qsA6yDFcEI/UbtUUJu2RPmiWJiaTSQ1VCuICR4GIZobL+jcWXoxx+MggrHWTA5ZkOqkT
         tXpQ==
X-Gm-Message-State: AJIora+zUT/a1CE9FYgWT0m3NAtRm2t1vViEy+0S8ztTF4XEwKLiYA+q
        S20FllV18kXT6PXAyhbLVphtRh9pbWwhsrONpq8vDA==
X-Google-Smtp-Source: AGRyM1tWKdVnzorRNk1pbcV2JwtPhWlStbDp0MhxShE77OmEIITnC87yPYKgp2O/R4E8tdNt78Jlvk3MzDbBzgAzgKE=
X-Received: by 2002:a17:907:6ea0:b0:726:2b0e:9e5e with SMTP id
 sh32-20020a1709076ea000b007262b0e9e5emr1985377ejc.189.1656002384514; Thu, 23
 Jun 2022 09:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220622041040.202737-1-tzungbi@kernel.org> <20220622041040.202737-7-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-7-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Jun 2022 09:39:33 -0700
Message-ID: <CABXOdTe=-YCrVz_oL0oS46LiH51+ytX21=dE3j4GqEV0Q3pkUg@mail.gmail.com>
Subject: Re: [PATCH 6/7] platform/chrome: cros_ec_proto: add Kunit tests for get_sensor_count
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

On Tue, Jun 21, 2022 at 9:11 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_get_sensor_count() gets number of MEMS sensors.
>
> Add Kunit tests for cros_ec_get_sensor_count().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 153 +++++++++++++++++++
>  drivers/platform/chrome/cros_kunit_util.c    |  22 +++
>  drivers/platform/chrome/cros_kunit_util.h    |   7 +
>  3 files changed, 182 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 93c1700deaef..6b26ce3104f4 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -2442,6 +2442,156 @@ static void cros_ec_proto_test_check_features_not_cached(struct kunit *test)
>         }
>  }
>
> +static void cros_ec_proto_test_get_sensor_count_normal(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_dev ec;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec.ec_dev = ec_dev;
> +       ec.dev = ec_dev->dev;
> +       ec.cmd_offset = 0;
> +
> +       /* For EC_CMD_MOTION_SENSE_CMD. */
> +       {
> +               struct ec_response_motion_sense *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (struct ec_response_motion_sense *)mock->o_data;
> +               data->dump.sensor_count = 0xbf;
> +       }
> +
> +       ret = cros_ec_get_sensor_count(&ec);
> +       KUNIT_EXPECT_EQ(test, ret, 0xbf);
> +
> +       /* For EC_CMD_MOTION_SENSE_CMD. */
> +       {
> +               struct ec_params_motion_sense *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_motion_sense));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
> +
> +               data = (struct ec_params_motion_sense *)mock->i_data;
> +               KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
> +       }
> +}
> +
> +static void cros_ec_proto_test_get_sensor_count_xfer_error(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_dev ec;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec.ec_dev = ec_dev;
> +       ec.dev = ec_dev->dev;
> +       ec.cmd_offset = 0;
> +
> +       /* For EC_CMD_MOTION_SENSE_CMD. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, -EPROTO, EC_RES_SUCCESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       ret = cros_ec_get_sensor_count(&ec);
> +       KUNIT_EXPECT_EQ(test, ret, -EPROTO);
> +
> +       /* For EC_CMD_MOTION_SENSE_CMD. */
> +       {
> +               struct ec_params_motion_sense *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_motion_sense));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
> +
> +               data = (struct ec_params_motion_sense *)mock->i_data;
> +               KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
> +       }
> +}
> +
> +static void cros_ec_proto_test_get_sensor_count_legacy(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret, i;
> +       struct cros_ec_dev ec;
> +       struct {
> +               u8 readmem_data;
> +               int expected_result;
> +       } test_data[] = {
> +               { 0, 0 },
> +               { EC_MEMMAP_ACC_STATUS_PRESENCE_BIT, 2 },
> +       };
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->cmd_readmem = cros_kunit_readmem_mock;
> +       ec.ec_dev = ec_dev;
> +       ec.dev = ec_dev->dev;
> +       ec.cmd_offset = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
> +               /* For EC_CMD_MOTION_SENSE_CMD. */
> +               {
> +                       mock = cros_kunit_ec_xfer_mock_addx(test, -EPROTO, EC_RES_SUCCESS, 0);
> +                       KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +               }
> +
> +               /* For readmem. */
> +               {
> +                       cros_kunit_readmem_mock_data = kunit_kzalloc(test, 1, GFP_KERNEL);
> +                       KUNIT_ASSERT_PTR_NE(test, cros_kunit_readmem_mock_data, NULL);
> +                       cros_kunit_readmem_mock_data[0] = test_data[i].readmem_data;
> +
> +                       cros_kunit_ec_xfer_mock_default_ret = 1;
> +               }
> +
> +               ret = cros_ec_get_sensor_count(&ec);
> +               KUNIT_EXPECT_EQ(test, ret, test_data[i].expected_result);
> +
> +               /* For EC_CMD_MOTION_SENSE_CMD. */
> +               {
> +                       struct ec_params_motion_sense *data;
> +
> +                       mock = cros_kunit_ec_xfer_mock_next();
> +                       KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +                       KUNIT_EXPECT_EQ(test, mock->msg.version, 1);
> +                       KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MOTION_SENSE_CMD);
> +                       KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                                       sizeof(struct ec_response_motion_sense));
> +                       KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(*data));
> +
> +                       data = (struct ec_params_motion_sense *)mock->i_data;
> +                       KUNIT_EXPECT_EQ(test, data->cmd, MOTIONSENSE_CMD_DUMP);
> +               }
> +
> +               /* For readmem. */
> +               {
> +                       KUNIT_EXPECT_EQ(test, cros_kunit_readmem_mock_offset, EC_MEMMAP_ACC_STATUS);
> +               }
> +       }
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2537,6 +2687,9 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_get_host_event_normal),
>         KUNIT_CASE(cros_ec_proto_test_check_features_cached),
>         KUNIT_CASE(cros_ec_proto_test_check_features_not_cached),
> +       KUNIT_CASE(cros_ec_proto_test_get_sensor_count_normal),
> +       KUNIT_CASE(cros_ec_proto_test_get_sensor_count_xfer_error),
> +       KUNIT_CASE(cros_ec_proto_test_get_sensor_count_legacy),
>         {}
>  };
>
> diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
> index 3ede971e82ee..d37c334b416d 100644
> --- a/drivers/platform/chrome/cros_kunit_util.c
> +++ b/drivers/platform/chrome/cros_kunit_util.c
> @@ -105,6 +105,24 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void)
>  }
>  EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
>
> +int cros_kunit_readmem_mock_offset;
> +EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_offset);
> +u8 *cros_kunit_readmem_mock_data;
> +EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_data);
> +int cros_kunit_readmem_mock_ret;
> +EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock_ret);
> +
> +int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
> +                           unsigned int bytes, void *dest)
> +{
> +       cros_kunit_readmem_mock_offset = offset;
> +
> +       memcpy(dest, cros_kunit_readmem_mock_data, bytes);
> +
> +       return cros_kunit_readmem_mock_ret;
> +}
> +EXPORT_SYMBOL_GPL(cros_kunit_readmem_mock);
> +
>  void cros_kunit_mock_reset(void)
>  {
>         cros_kunit_ec_xfer_mock_default_ret = 0;
> @@ -112,6 +130,10 @@ void cros_kunit_mock_reset(void)
>         cros_kunit_ec_pkt_xfer_mock_called = 0;
>         INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_in);
>         INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_out);
> +
> +       cros_kunit_readmem_mock_offset = 0;
> +       cros_kunit_readmem_mock_data = NULL;
> +       cros_kunit_readmem_mock_ret = 0;
>  }
>  EXPORT_SYMBOL_GPL(cros_kunit_mock_reset);
>
> diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
> index ae4080cb13f1..88134c9f1acf 100644
> --- a/drivers/platform/chrome/cros_kunit_util.h
> +++ b/drivers/platform/chrome/cros_kunit_util.h
> @@ -35,6 +35,13 @@ struct ec_xfer_mock *cros_kunit_ec_xfer_mock_addx(struct kunit *test,
>                                                   int ret, int result, size_t size);
>  struct ec_xfer_mock *cros_kunit_ec_xfer_mock_next(void);
>
> +extern int cros_kunit_readmem_mock_offset;
> +extern u8 *cros_kunit_readmem_mock_data;
> +extern int cros_kunit_readmem_mock_ret;
> +
> +int cros_kunit_readmem_mock(struct cros_ec_device *ec_dev, unsigned int offset,
> +                           unsigned int bytes, void *dest);
> +
>  void cros_kunit_mock_reset(void);
>
>  #endif
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
