Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7500558008
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiFWQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiFWQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:37:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D7384
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:37:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e2so18417974edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urif6icUUgAlXuOCANYcMX0j+RLbrCUPDFm74EsbEL4=;
        b=m6JX562RT7BX6m5Fsr0cnilPsXHeeJvXSpDc2tlJkyWOe8W2VO3vE7m9X0G1dnXkNW
         bxLWGjy6LV8hK0FVyaYUl3P4smt8JYvDikG+baaL7be8jkYFGFSMYZAcrhpJqi/HQM7Y
         uGXWWmI1C3+l7iIHK0wtKr0pJS0gWh/Qp5UOSurxhdn/gVGqVxcOePyZLxme+fbj+oNl
         n/BddS+d+IR7O026WsjyoyeWJ3XKI1eW5ug/gRTfZSGcG8hSXKaDhLol8isnoPeDzSW0
         9VueC7NutK8MKkbDxNezo3bFeu/PmzB4neOV3reifDsZn7B+EPJxH9SToye+BMmotoWD
         KvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urif6icUUgAlXuOCANYcMX0j+RLbrCUPDFm74EsbEL4=;
        b=OgWXjBr2fzFGiDyGhFUDt+3PUvp6f7AyiolA0SzB63ehur8p415kwJedtfgYsoOAWQ
         z4/v4I9jrWIJYWUxTTb4IXe8muG+uO4EGAm6Sn2enVFjBnb6ksJApYeR+SAOFthbULPd
         r54yFNo53JBFCEZu1zkeCsGirazJVGskqYssjzs+oLH7SBDMehcwQPvBXrzUxBJf0BEE
         pX0KZ14nBQ1ML3e/ZfGLu4xxvZbXWOlTNxQo1j3NBMdK8Asri+GGcm9Ei/wevp/y1bvo
         fYP4WeeipsAv88F2nrlbMquJfyuBSkHTm8kNoCfsFOYjHpjAD3/W3g3zhw1BCSo//d76
         ElwQ==
X-Gm-Message-State: AJIora+nYbxTbHjmOL7fIk/RAbV7q9nUS3S9UW49Nw/A54kwvuXXUsAE
        7nvMGEBngskNEhwoDPgvLKrOHkIR8k6xT8CaQGSBUA==
X-Google-Smtp-Source: AGRyM1vtZ+ojTe6BrkeahfwsAgXcIp6IW0UzSNVENqrAFJQNEUacFTuMaAFKQ+itAuxbOVL/INPy3J4DTRgpNqGh5pI=
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr11878982edd.11.1656002270435; Thu, 23
 Jun 2022 09:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220622041040.202737-1-tzungbi@kernel.org> <20220622041040.202737-4-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-4-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Jun 2022 09:37:39 -0700
Message-ID: <CABXOdTcudqnZ-SWpZ+BY9FVsqzSzNdfaUVRVgDO--NWA9v=HNA@mail.gmail.com>
Subject: Re: [PATCH 3/7] platform/chrome: cros_ec_proto: add Kunit tests for get_next_event
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
> cros_ec_get_next_event() gets events from EC.  It consists of 3
> versions of event retrieval:
>
> 1. No MKBP event.
> 2. MKBP event version 0.
> 3. MKBP event version >0.
>
> Add Kunit tests for cros_ec_get_next_event().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 266 +++++++++++++++++++
>  1 file changed, 266 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index be3ac77abdf9..64c4b79f7a0c 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -5,6 +5,7 @@
>
>  #include <kunit/test.h>
>
> +#include <asm-generic/unaligned.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
>
> @@ -2052,6 +2053,265 @@ static void cros_ec_proto_test_cmd_xfer_status_return_error(struct kunit *test)
>         }
>  }
>
> +static void cros_ec_proto_test_get_next_event_no_mkbp_event(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       bool wake_event, more_events;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->mkbp_event_supported = 0;
> +
> +       /* Set some garbage bytes. */
> +       wake_event = false;
> +       more_events = true;
> +
> +       /* For get_keyboard_state_event(). */
> +       {
> +               union ec_response_get_next_data_v1 *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (union ec_response_get_next_data_v1 *)mock->o_data;
> +               data->host_event = 0xbeef;
> +       }
> +
> +       ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
> +       KUNIT_EXPECT_EQ(test, ret, sizeof(union ec_response_get_next_data_v1));
> +
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_KEY_MATRIX);
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.host_event, 0xbeef);
> +
> +       KUNIT_EXPECT_TRUE(test, wake_event);
> +       KUNIT_EXPECT_FALSE(test, more_events);
> +
> +       /* For get_keyboard_state_event(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_MKBP_STATE);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(union ec_response_get_next_data_v1));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +}
> +
> +static void cros_ec_proto_test_get_next_event_mkbp_event_ec_suspended(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +
> +       ec_dev->mkbp_event_supported = 1;
> +       ec_dev->suspended = true;
> +
> +       ret = cros_ec_get_next_event(ec_dev, NULL, NULL);
> +       KUNIT_EXPECT_EQ(test, ret, -EHOSTDOWN);
> +}
> +
> +static void cros_ec_proto_test_get_next_event_mkbp_event_version0(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       bool wake_event, more_events;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->mkbp_event_supported = 1;
> +
> +       /* Set some garbage bytes. */
> +       wake_event = true;
> +       more_events = false;
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               struct ec_response_get_next_event *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (struct ec_response_get_next_event *)mock->o_data;
> +               data->event_type = EC_MKBP_EVENT_SENSOR_FIFO | EC_MKBP_HAS_MORE_EVENTS;
> +               data->data.sysrq = 0xbeef;
> +       }
> +
> +       ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
> +       KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_next_event));
> +
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_SENSOR_FIFO);
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.sysrq, 0xbeef);
> +
> +       KUNIT_EXPECT_FALSE(test, wake_event);
> +       KUNIT_EXPECT_TRUE(test, more_events);
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_get_next_event));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +}
> +
> +static void cros_ec_proto_test_get_next_event_mkbp_event_version2(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       bool wake_event, more_events;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->mkbp_event_supported = 3;
> +
> +       /* Set some garbage bytes. */
> +       wake_event = false;
> +       more_events = true;
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               struct ec_response_get_next_event_v1 *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (struct ec_response_get_next_event_v1 *)mock->o_data;
> +               data->event_type = EC_MKBP_EVENT_FINGERPRINT;
> +               data->data.sysrq = 0xbeef;
> +       }
> +
> +       ret = cros_ec_get_next_event(ec_dev, &wake_event, &more_events);
> +       KUNIT_EXPECT_EQ(test, ret, sizeof(struct ec_response_get_next_event_v1));
> +
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_FINGERPRINT);
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.data.sysrq, 0xbeef);
> +
> +       KUNIT_EXPECT_TRUE(test, wake_event);
> +       KUNIT_EXPECT_FALSE(test, more_events);
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_next_event_v1));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +}
> +
> +static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       bool wake_event;
> +       struct ec_response_get_next_event_v1 *data;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->mkbp_event_supported = 3;
> +       ec_dev->host_event_wake_mask = U32_MAX;
> +
> +       /* Set some garbage bytes. */
> +       wake_event = true;
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test,
> +                                                  sizeof(data->event_type) +
> +                                                  sizeof(data->data.host_event));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (struct ec_response_get_next_event_v1 *)mock->o_data;
> +               data->event_type = EC_MKBP_EVENT_HOST_EVENT;
> +               put_unaligned_le32(EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC), &data->data.host_event);
> +       }
> +
> +       ret = cros_ec_get_next_event(ec_dev, &wake_event, NULL);
> +       KUNIT_EXPECT_EQ(test, ret, sizeof(data->event_type) + sizeof(data->data.host_event));
> +
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_HOST_EVENT);
> +
> +       KUNIT_EXPECT_FALSE(test, wake_event);
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_next_event_v1));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +}
> +
> +static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       bool wake_event;
> +       struct ec_response_get_next_event_v1 *data;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec_dev->mkbp_event_supported = 3;
> +       ec_dev->host_event_wake_mask = U32_MAX & ~EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED);
> +
> +       /* Set some garbage bytes. */
> +       wake_event = true;
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test,
> +                                                  sizeof(data->event_type) +
> +                                                  sizeof(data->data.host_event));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (struct ec_response_get_next_event_v1 *)mock->o_data;
> +               data->event_type = EC_MKBP_EVENT_HOST_EVENT;
> +               put_unaligned_le32(EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED),
> +                                  &data->data.host_event);
> +       }
> +
> +       ret = cros_ec_get_next_event(ec_dev, &wake_event, NULL);
> +       KUNIT_EXPECT_EQ(test, ret, sizeof(data->event_type) + sizeof(data->data.host_event));
> +
> +       KUNIT_EXPECT_EQ(test, ec_dev->event_data.event_type, EC_MKBP_EVENT_HOST_EVENT);
> +
> +       KUNIT_EXPECT_FALSE(test, wake_event);
> +
> +       /* For get_next_event_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 2);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_NEXT_EVENT);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_next_event_v1));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2135,6 +2395,12 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_normal),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_xfer_error),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_return_error),
> +       KUNIT_CASE(cros_ec_proto_test_get_next_event_no_mkbp_event),
> +       KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_ec_suspended),
> +       KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_version0),
> +       KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_version2),
> +       KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc),
> +       KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked),
>         {}
>  };
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
