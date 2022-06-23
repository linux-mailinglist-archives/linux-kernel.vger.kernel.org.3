Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7EB557FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiFWQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiFWQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:37:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C345AFA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:37:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c65so6312207edf.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzrLxDpEBSWeooyKGwQ+hzBdc/h09H6UYXx0nMqWJH0=;
        b=DfzUZzFWpDuUns+JvgHrc0XwVd1yNntKXiNmtX6RtXgU4We7pxItOhoADnR+8GkFbw
         bUAJuYUThK4+Ak6oGmxRHP1uM5Hmo5D/GjQNfuqRwXGH30WUVKeFMQ0y46GU4o6qFwB4
         /jub9DQw1HZhhy7GULlsoyqsixD9lRftjXgoz3MeBFySfzxfWllfYD+MVqb+6fn/APBe
         HB6Ncp5E1RSvMM4ChDPQ3YTbKh53VcAbeLXj27J7itakJeSuLWB+MWYY9XwzYk9iVpBh
         sGzK7lFcspWcvPUF2Et+yEVpAOSCIjOgajranJZn/yKWC/9Jk1MVJrqoT8202Yb2MeeM
         hTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzrLxDpEBSWeooyKGwQ+hzBdc/h09H6UYXx0nMqWJH0=;
        b=JIJUrWaEASUXFZ8gSZicibDTDzV/Fk3JZZf+aG5YeAgRINaqc5bmtVdMx5mwYTIELU
         wFLoBxOL03gJxX43GV/amW6H1OJx3MqxVqyeu/M/3GmxL83uOXWNVS/ogCSj5d1pNXZB
         /SA7fJ2w0r1DluUyYRIkEg8mcPGR8RWsEVd5BP+GFjOKulCyW9OJh8F/Dgi6gtkQmULG
         552G54UyJD+lZVgOLOo7j2JcvFRl9wVvYmPif2DYzjmnsQcyYmKw7CS8GVGERcOhV3QI
         EUB6Jg/PP8bEix0Txt1O1VxfkKu+go19hSzEUfxPOqwj2bw7EiLhPIXOnQ7L9oSXomJV
         GhOw==
X-Gm-Message-State: AJIora/IAtxU8ncSfvuzb+IIIVqd2E7dJfksbP6wDbAzMa/XsG0Q72OA
        pCgGeaaOVoxwlMq5Jglzs7jlxRoBwB2wGzMgOxknzg==
X-Google-Smtp-Source: AGRyM1svggQmC7sw5XFvqlEGsD+NCcmKEbeiYU9YGFcHJdYW4oUjo+c1INRC0jZfmwxuaCBEhRzXJq6Q4VMJoP2pvj0=
X-Received: by 2002:a05:6402:2687:b0:430:328f:e46b with SMTP id
 w7-20020a056402268700b00430328fe46bmr11939484edd.33.1656002227128; Thu, 23
 Jun 2022 09:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220622041040.202737-1-tzungbi@kernel.org> <20220622041040.202737-3-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-3-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Jun 2022 09:36:56 -0700
Message-ID: <CABXOdTeeNSwG-79+h4NGQiPjGsBr7hrQ+eijKFzVNTxpw1Eytw@mail.gmail.com>
Subject: Re: [PATCH 2/7] platform/chrome: cros_ec_proto: add Kunit test for cros_ec_map_error()
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
> cros_ec_cmd_xfer_status() is the only exported function that calls
> static function cros_ec_map_error().
>
> Add Kunit test for cros_ec_map_error() through calling
> cros_ec_cmd_xfer_status().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 49 ++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 6464f6101fd3..be3ac77abdf9 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -2004,6 +2004,54 @@ static void cros_ec_proto_test_cmd_xfer_status_xfer_error(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ret, -EPROTO);
>  }
>
> +static void cros_ec_proto_test_cmd_xfer_status_return_error(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret, i;
> +       struct cros_ec_command msg;
> +       static const int map[] = {
> +               [EC_RES_SUCCESS] = 0,
> +               [EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> +               [EC_RES_ERROR] = -EIO,
> +               [EC_RES_INVALID_PARAM] = -EINVAL,
> +               [EC_RES_ACCESS_DENIED] = -EACCES,
> +               [EC_RES_INVALID_RESPONSE] = -EPROTO,
> +               [EC_RES_INVALID_VERSION] = -ENOPROTOOPT,
> +               [EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> +               /*
> +                * EC_RES_IN_PROGRESS is special because cros_ec_send_command() has extra logic to
> +                * handle it.  Note that default cros_kunit_ec_xfer_mock_default_ret == 0 thus
> +                * cros_ec_xfer_command() in cros_ec_wait_until_complete() returns 0.  As a result,
> +                * it returns -EPROTO without calling cros_ec_map_error().
> +                */
> +               [EC_RES_IN_PROGRESS] = -EPROTO,
> +               [EC_RES_UNAVAILABLE] = -ENODATA,
> +               [EC_RES_TIMEOUT] = -ETIMEDOUT,
> +               [EC_RES_OVERFLOW] = -EOVERFLOW,
> +               [EC_RES_INVALID_HEADER] = -EBADR,
> +               [EC_RES_REQUEST_TRUNCATED] = -EBADR,
> +               [EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> +               [EC_RES_BUS_ERROR] = -EFAULT,
> +               [EC_RES_BUSY] = -EBUSY,
> +               [EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> +               [EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> +               [EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> +               [EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> +       };
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       for (i = 0; i < ARRAY_SIZE(map); ++i) {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, i, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               ret = cros_ec_cmd_xfer_status(ec_dev, &msg);
> +               KUNIT_EXPECT_EQ(test, ret, map[i]);
> +       }
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2086,6 +2134,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return0),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_normal),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_xfer_error),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_return_error),
>         {}
>  };
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
