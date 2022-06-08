Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1912543910
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiFHQbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245518AbiFHQbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:31:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588EF247901
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:29:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z7so27801659edm.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CF/Kh01MJWe4yp2Is0vySqOlQlpzpE6Iwf+B2aga5qA=;
        b=WZut2aN+O7FrQyr6F7fpsB/42jTOj5SEQlDRwGORr63TNRoUveQ9N0JokW5S0THM0n
         F8DUW61yqHq50CCU03HaPUcrLjTTu/0IHCpq4pP6j+1NQnNUcRv5b8RwtWNWrNXQMpMw
         hdRgjDTj7zbu2o7LWBAc4nsBunSZe7jlJW641jT5LqXxPuV/xh/lkFy6rYjMLbqIrUpA
         30xoX/kHVLR10DWZWi/1MDw5xnyqD1E2wTmZ87vLOSuvfvXUMoaW8ugkqsHvjq3Kg0PW
         tvQTQtsyC0Uhbk0l+LUzvHdNGOheS48Uhe3nCLdVAtla+l6dV0hAeCv8t6fDLpOpvssG
         ehqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CF/Kh01MJWe4yp2Is0vySqOlQlpzpE6Iwf+B2aga5qA=;
        b=26R9D31c4tpODgfFFS1G0WtpKS7HauJk9OpQxiV6L+/G6ydwc+PhfVLshoJHhjXNCW
         adev8xlKgSfHymrrH0MWacUjoTszG725PYALO9u1mjkSFiMJKKk9iBjR3bqR8OiJa0JO
         3AMNOBhndiuScxVr5oKRSJu9EVLtCMv2aTKyG0RHzRvHVoQACDCmWRIZLDtSVXC85dMI
         FZdwi5m72+7dAqgKmcOSlCa2gD6S+7+KRIupwN/PXpypsMLV8BO+YeKhhTkedfGsIST1
         /pEXzpCuAMdEU/8Pi8m+g/qwH7sul7vQuVrMsDhRkgWsNStjPq6tfkjCiwrZiKOKrjPA
         ERpw==
X-Gm-Message-State: AOAM5331zFlBJogIT838BVTI6a3m7qepi4R37lIgJinG9mNCCb6ER+bX
        P9VdIMGGg+9ptswHf9LT6JQxLDmUQSxmuuBWad10Vw==
X-Google-Smtp-Source: ABdhPJxeNv5rgHdx+m7eZ866cRzZjSvPsrmu/M2z9+w5zPbzVsqv2NkliNFKahGNvHfQXDOXB3hD5eLC/r9JT2E3w1I=
X-Received: by 2002:a05:6402:3490:b0:42f:b592:f364 with SMTP id
 v16-20020a056402349000b0042fb592f364mr28649668edc.66.1654705784062; Wed, 08
 Jun 2022 09:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-23-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-23-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:29:32 -0700
Message-ID: <CABXOdTeJC2smg31prN6vX3cEhF89_5o8fyDCdW66D5LGTA30cQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/23] platform/chrome: cros_ec_proto: add Kunit test
 for getting wake mask
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

On Wed, Jun 8, 2022 at 4:08 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_get_host_event_wake_mask() expects to receive
> sizeof(struct ec_response_host_event_mask) from send_command().
> The payload is valid only if the return value is positive.
>
> Add Kunit tests for returning 0 from send_command() in
> cros_ec_get_host_event_wake_mask().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No v2.  New and separated from the original series.
>
>  drivers/platform/chrome/cros_ec_proto_test.c | 128 +++++++++++++++++++
>  1 file changed, 128 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index c988ff1e2a5a..6cd136ce9e50 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1408,6 +1408,133 @@ static void cros_ec_proto_test_query_all_default_wake_mask_return_error(struct k
>         }
>  }
>
> +static void cros_ec_proto_test_query_all_default_wake_mask_return0(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +
> +       /* Set some garbage bytes. */
> +       ec_dev->host_event_wake_mask = U32_MAX;
> +
> +       /* For cros_ec_get_proto_info() without passthru. */
> +       {
> +               struct ec_response_get_protocol_info *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, sizeof(*data));
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               /*
> +                * Although it doesn't check the value, provides valid sizes so that
> +                * cros_ec_query_all() allocates din and dout correctly.
> +                */
> +               data = (struct ec_response_get_protocol_info *)mock->o_data;
> +               data->max_request_packet_size = 0xbe;
> +               data->max_response_packet_size = 0xef;
> +       }
> +
> +       /* For cros_ec_get_proto_info() with passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For get_host_event_wake_mask(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       cros_ec_proto_test_query_all_pretest(test);
> +       ret = cros_ec_query_all(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +       /* For cros_ec_get_proto_info() without passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_PROTOCOL_INFO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_protocol_info));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +
> +       /* For cros_ec_get_proto_info() with passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command,
> +                               EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX) |
> +                               EC_CMD_GET_PROTOCOL_INFO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_protocol_info));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for MKBP. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_cmd_versions));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
> +       }
> +
> +       /* For cros_ec_get_host_command_version_mask() for host sleep v1. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_GET_CMD_VERSIONS);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize,
> +                               sizeof(struct ec_response_get_cmd_versions));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
> +       }
> +
> +       /* For get_host_event_wake_mask(). */
> +       {
> +               u32 mask;
> +
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HOST_EVENT_GET_WAKE_MASK);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_host_event_mask));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, 0);
> +
> +               mask = ec_dev->host_event_wake_mask;
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_LID_CLOSED), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_AC_DISCONNECTED), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_LOW), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_CRITICAL), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_PD_MCU), 0);
> +               KUNIT_EXPECT_EQ(test, mask & EC_HOST_EVENT_MASK(EC_HOST_EVENT_BATTERY_STATUS), 0);
> +       }
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -1473,6 +1600,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep_return0),
>         KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
> +       KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return0),
>         {}
>  };
>
> --
> 2.36.1.255.ge46751e96f-goog
>
