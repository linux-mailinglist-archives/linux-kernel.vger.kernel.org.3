Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5F555800F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiFWQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiFWQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:39:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96077167C0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:39:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o9so20129855edt.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8CqJoRILL/dve2sT+WdutSeuBTUJjelySjg4TNgewk=;
        b=hjeDCAVUyq2c2N2zMhUW1OVixmztIYgy4ydCOn+R89OsiilOZyWkIi2CCds6CknrSb
         wyFk+2wKRoxbfzdhqPH9NTj93LVSOloSr6Tfnf2+R/WBBZNNGLSxkgyJJ7J4eqzfdTU2
         IvvoJ1ZCVS+Virc4OkimKoWeqLQInhZv2lmpM+5h4nil1oorcT6suS/bho/zZV1cqDkI
         QrLpM8uG49Tx6/LeaVUtyr54pKjGb5KkuFB1NkKQw0pYcxepBN2LIAoLx4YpKNmsN7UL
         4blGUXb4q1BiV3HbS44JPKrsJopW4oxkWuiN68F3S0kthRjSwgfoQpVhE/7MEXKuymfo
         nQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8CqJoRILL/dve2sT+WdutSeuBTUJjelySjg4TNgewk=;
        b=ZjRCwfCGbC5Uk2IOlrGp6IgO8WhRemA2OZKhpB+vlMn1RW4GQCgPCTuT+44Zyhccaj
         jEmSQVQ0QHOp8aIQiduZoU0aEjo7x/h6Ykyzitxpp0LNo2Rbz4EYKNL0tAKTirebUJ14
         Hdi+0IAl9kj3rWNn70uvpHwZU+eKwyIiCtSBy9zmC+7ANlIKnIXcceeP3NyZaOYflRU/
         IhWmSb9I2VUzRRTXi1IKMXn5LwzSaPr7rGV2Sq106HK2oucE/lCHtdistZ65ZKi8QtWX
         dpCFhSc3F0m+uFI3k6QtUk/dZNoZ33n2E5veTF2vB/pydo0BJm6r42SMmn7/dg8AGDU5
         m3PQ==
X-Gm-Message-State: AJIora/XI1JXQU+ZPk8f8RXyEVeBTqfea+dZBQyXkKUW3VI0DsFk9+zJ
        aj5ZXKeV8iFU7M9J3G0C9tzBuxwYbq3ux0+HSP/OOadi+PuOWn3P
X-Google-Smtp-Source: AGRyM1tCH/TvyxXOB2A7V379L6d7opgQwhQuwNpSrSBabVWygvVnu5CjYQVuWV4BD7ZGJdbNym2j6u1vMhjfqJ9ZIP4=
X-Received: by 2002:a05:6402:350e:b0:42f:b2c1:9393 with SMTP id
 b14-20020a056402350e00b0042fb2c19393mr11885456edd.11.1656002340976; Thu, 23
 Jun 2022 09:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220622041040.202737-1-tzungbi@kernel.org> <20220622041040.202737-6-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-6-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Jun 2022 09:38:49 -0700
Message-ID: <CABXOdTdBo=PAsj1r4f0uuqjvcMtBbhSQRF=_ERf4VvSX=SoctA@mail.gmail.com>
Subject: Re: [PATCH 5/7] platform/chrome: cros_ec_proto: add Kunit tests for check_features
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
> cros_ec_check_features() gets EC features if it hasn't had cache, and
> checks whether the given EC_FEATURE_* is supported or not.
>
> Add Kunit tests for cros_ec_check_features().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 77 ++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index dce9fa3b9c8d..93c1700deaef 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -2367,6 +2367,81 @@ static void cros_ec_proto_test_get_host_event_normal(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ret, EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC));
>  }
>
> +static void cros_ec_proto_test_check_features_cached(struct kunit *test)
> +{
> +       int ret, i;
> +       struct cros_ec_dev ec;
> +
> +       ec.features.flags[0] = EC_FEATURE_MASK_0(EC_FEATURE_FINGERPRINT);
> +       ec.features.flags[1] = EC_FEATURE_MASK_0(EC_FEATURE_SCP);
> +
> +       for (i = 0; i < EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK; ++i) {
> +               ret = cros_ec_check_features(&ec, i);
> +               switch (i) {
> +               case EC_FEATURE_FINGERPRINT:
> +               case EC_FEATURE_SCP:
> +                       KUNIT_EXPECT_TRUE(test, ret);
> +                       break;
> +               default:
> +                       KUNIT_EXPECT_FALSE(test, ret);
> +                       break;
> +               }
> +       }
> +}
> +
> +static void cros_ec_proto_test_check_features_not_cached(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret, i;
> +       struct cros_ec_dev ec;
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +       ec.ec_dev = ec_dev;
> +       ec.dev = ec_dev->dev;
> +       ec.cmd_offset = 0;
> +       ec.features.flags[0] = -1;
> +       ec.features.flags[1] = -1;
> +
> +       /* For EC_CMD_GET_FEATURES. */
> +       {
> +               struct ec_response_get_features *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (struct ec_response_get_features *)mock->o_data;
> +               data->flags[0] = EC_FEATURE_MASK_0(EC_FEATURE_FINGERPRINT);
> +               data->flags[1] = EC_FEATURE_MASK_0(EC_FEATURE_SCP);
> +       }
> +
> +       for (i = 0; i < EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK; ++i) {
> +               ret = cros_ec_check_features(&ec, i);
> +               switch (i) {
> +               case EC_FEATURE_FINGERPRINT:
> +               case EC_FEATURE_SCP:
> +                       KUNIT_EXPECT_TRUE(test, ret);
> +                       break;
> +               default:
> +                       KUNIT_EXPECT_FALSE(test, ret);
> +                       break;
> +               }
> +       }
> +
> +       /* For EC_CMD_GET_FEATURES. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_FEATURES);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_get_features));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2460,6 +2535,8 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_get_host_event_not_host_event),
>         KUNIT_CASE(cros_ec_proto_test_get_host_event_wrong_event_size),
>         KUNIT_CASE(cros_ec_proto_test_get_host_event_normal),
> +       KUNIT_CASE(cros_ec_proto_test_check_features_cached),
> +       KUNIT_CASE(cros_ec_proto_test_check_features_not_cached),
>         {}
>  };
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
