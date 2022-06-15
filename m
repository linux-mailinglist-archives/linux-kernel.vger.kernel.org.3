Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1339454CECF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356778AbiFOQfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiFOQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:35:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA602AE20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:35:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y19so24343689ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuwKI4htQEtOz9pCwUYQ1jubfyaQLDpzvXEiVSqRuH8=;
        b=Arz1i89VPLi2VpCoMed3ara5BW835+ZMxyqbwlemZ5yW0Ye7RIbw2KdlTG49nmTrem
         Ri4BMT8Tj12Ilvh3Wv7UB5ft8A3oFaqg43sKKysZfy0Xq0ZQuhzNodWnu9ZTc6Ec7/+y
         HfAuYQRXUEWUvAS2LhsEBsQ2rXPcJJAibYqqAVtSg+Dp31umS9uCi5us3bA44HKhRVbe
         xoxxpfjzVcP8ZEn43+yeBAfySiXyO7mOpiWNvgcXLBI3DadJVtr9V89Vb5ZYFdAsoCtW
         SFzfY7MZwsWN8vJ537fm2vg3SoRWIyn0pYt2+ihNcFPgNrwc/UB5UsO9rz3wn+te6r4u
         JArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuwKI4htQEtOz9pCwUYQ1jubfyaQLDpzvXEiVSqRuH8=;
        b=t3N9c+g5hW6O0h+HBcKOuHs/sbAWBn3lo3bp5tHbM1IVHV1zxQK+p5HkJEVHeHW+KE
         Xk2hceZqor1wVpKxqjooAOYH6DJc0WB+5Xky4gQJOHo38CFUnTPA6OpM4gMIJeAvYMjy
         JgEbW3FirHLveL3IDySg+raHcG56ZlM/KN2ytDHbpg6ZXNaBTasyQAK3d/vjUO9FTVtp
         o5arTi3ex/vksbJMy2fxrzBXetqALUQhMXumO06UvjXMRVw3CoiqBDWtGkfgVK7TJkdc
         AjcPnCzG3EjT/DlgjzBjutUXijKBSc46kWkzXu+VwvzDAe2mAP++W4L5/9lk+5oYyz8H
         u6HQ==
X-Gm-Message-State: AJIora8rx8652pn+GPtFSdyvPY70FMt7gb/Vzl+26kxvd59NIVbm6qlf
        8fA05hjF7xiS5uheFUZ0FPM/FmdJtEVogVMPHMxcqA==
X-Google-Smtp-Source: AGRyM1t2BoOftKTjgDbCucVkUeZDbcDAOV2Omq6kwbYD+emPNsZPZS+YNN2qGI0ywd6e4pkUZOPxjXgplRrpZGdMQ3s=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr558423ejc.631.1655310924246; Wed, 15
 Jun 2022 09:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220615051248.1628156-1-tzungbi@kernel.org> <20220615051248.1628156-3-tzungbi@kernel.org>
In-Reply-To: <20220615051248.1628156-3-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 15 Jun 2022 09:35:12 -0700
Message-ID: <CABXOdTdXSzPMXaUx1qmUcaeeGvrKPeAihBup=u5QD0Z8ye--Qw@mail.gmail.com>
Subject: Re: [PATCH 02/11] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_cmd_xfer()
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
> cros_ec_cmd_xfer() transfers the given command and data if any.  It
> performs some sanity checks and calls cros_ec_send_command().
>
> Add Kunit tests for cros_ec_cmd_xfer().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 149 +++++++++++++++++++
>  1 file changed, 149 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 1e2a1522c288..33721607a5b9 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1535,6 +1535,151 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return0(struct kunit
>         }
>  }
>
> +static void cros_ec_proto_test_cmd_xfer_normal(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct {
> +               struct cros_ec_command msg;
> +               u8 data[0x100];
> +       } __packed buf;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->max_passthru = 0xdd;
> +
> +       buf.msg.version = 0;
> +       buf.msg.command = EC_CMD_HELLO;
> +       buf.msg.insize = 4;
> +       buf.msg.outsize = 2;
> +       buf.data[0] = 0x55;
> +       buf.data[1] = 0xaa;
> +
> +       {
> +               u8 *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, 4);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (u8 *)mock->o_data;
> +               data[0] = 0xaa;
> +               data[1] = 0x55;
> +               data[2] = 0xcc;
> +               data[3] = 0x33;
> +       }
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
> +       KUNIT_EXPECT_EQ(test, ret, 4);
> +
> +       {
> +               u8 *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, 4);
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 2);
> +
> +               data = (u8 *)mock->i_data;
> +               KUNIT_EXPECT_EQ(test, data[0], 0x55);
> +               KUNIT_EXPECT_EQ(test, data[1], 0xaa);
> +
> +               KUNIT_EXPECT_EQ(test, buf.data[0], 0xaa);
> +               KUNIT_EXPECT_EQ(test, buf.data[1], 0x55);
> +               KUNIT_EXPECT_EQ(test, buf.data[2], 0xcc);
> +               KUNIT_EXPECT_EQ(test, buf.data[3], 0x33);
> +       }
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_excess_msg_insize(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct {
> +               struct cros_ec_command msg;
> +               u8 data[0x100];
> +       } __packed buf;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->max_passthru = 0xdd;
> +
> +       buf.msg.version = 0;
> +       buf.msg.command = EC_CMD_HELLO;
> +       buf.msg.insize = 0xee + 1;
> +       buf.msg.outsize = 2;
> +
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0xcc);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
> +       KUNIT_EXPECT_EQ(test, ret, 0xcc);
> +
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, 0xee);
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 2);
> +       }
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +       struct {
> +               struct cros_ec_command msg;
> +               u8 data[0x100];
> +       } __packed buf;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->max_passthru = 0xdd;
> +
> +       buf.msg.version = 0;
> +       buf.msg.command = EC_CMD_HELLO;
> +       buf.msg.insize = 4;
> +       buf.msg.outsize = 0xff + 1;
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +       struct {
> +               struct cros_ec_command msg;
> +               u8 data[0x100];
> +       } __packed buf;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->max_passthru = 0xdd;
> +
> +       buf.msg.version = 0;
> +       buf.msg.command = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) + EC_CMD_HELLO;
> +       buf.msg.insize = 4;
> +       buf.msg.outsize = 0xdd + 1;
> +
> +       ret = cros_ec_cmd_xfer(ec_dev, &buf.msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EMSGSIZE);
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -1601,6 +1746,10 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep_return0),
>         KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
>         KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return0),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_normal),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_insize),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_without_passthru),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_excess_msg_outsize_with_passthru),
>         {}
>  };
>
> --
> 2.36.1.476.g0c4daa206d-goog
>
