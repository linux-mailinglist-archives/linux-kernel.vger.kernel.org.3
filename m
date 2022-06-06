Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A753E88F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241542AbiFFQTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241429AbiFFQTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:19:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA11DAF15
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:19:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q21so29972666ejm.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaI0g8cUivOx96ChYxLm99Kiy6nUc3V/ruLcuNQVvVU=;
        b=pDpF4wAUHXj2HlsodBz/+GqJm33nIH6Zvrsv77r1RCrOj6STgjoR7+2GVxwnxUjnQL
         cNWnDA6xDOY8yxHVp0tKjuZpfxdmDGEYk5z8bacYrDMx2XgKFsGFivG3q5AIWNeN/u9+
         ihPdAh1i/1PSQzvuZjbEpv5WvgPO+6JNxA8iNEF3aP9/WV0zoABNvd0JpvtbXuunbctz
         8XMYp6YQrZA6JIAnReLeiG4Jeoz1pGpZQb1oDN3grHB8Vr5lAL/sih5lyzzg6pKzXCwG
         48syNDdXmb6K19hhi7ekwr6jD1VCexjCUKYvWPlNRHtbqzOiLc4uro0lgNt5pG2k7Up+
         eUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaI0g8cUivOx96ChYxLm99Kiy6nUc3V/ruLcuNQVvVU=;
        b=gU0CJ1oswMG1J4Oam+iQxHuYZe1I/+S22j+zD9/qmpf5oetCi0M3Cx5i9VRl9qjkgr
         rPKGDBTBoOJGnl97cIw6pma/RcT+WAaQbIlkTkGOa0v3LJFhVB615IqGav48wI2kwy2W
         5Vk2DQFTXKulc6aV3R4gnMOQV/Q8uqTc88Vr2TtQoSY9JItbZJE5RVLyDYzye77bnwqO
         GJgexz2HZPwWGB8+HdHYtsqe4RB5Gxxxu/LEYuzEEVb6G1HGW0PuQQBDy920UmzVJFRW
         uuNu0o66s21dVW4jL8JWaHW3I1OU2ewp01+CQ6mGLIw8WUb9KKg9QbeY+ozFcNtAf00n
         1l4A==
X-Gm-Message-State: AOAM532abYCMR5QbF19NFojKWVKOHxrlxq4EuO7lxCSW0AIdJegSIXFI
        ddwaly2eece0QK2KIYtHXWs1njmpEVyo/8U5eFAeJw==
X-Google-Smtp-Source: ABdhPJxgrdnu3Q5uPdwC77Uc+wTlcIOC/3m3ouGaWoL9iDpazMz6g9UQ/0XHdqGhTGU+ALRSeSys1aLANW5r3Jt16uQ=
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id
 b16-20020a1709064d5000b0070dafd41e63mr17720036ejv.618.1654532348927; Mon, 06
 Jun 2022 09:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-13-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-13-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 09:18:57 -0700
Message-ID: <CABXOdTe-9gu+mPZp+drKknJysoRS3krO_KSxTfO90+8i2ooWDw@mail.gmail.com>
Subject: Re: [PATCH 12/13] platform/chrome: cros_ec_proto: arrange get_host_event_wake_mask()
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
> - cros_ec_get_host_event_wake_mask() is a private (static) function.
>   Rename it to get_host_event_wake_mask().
>
Same as before - I still prefer to have prefixes. Also, this is a bit
of point-of-view thing, so I'd rather leave function names alone
unless there is a good reason to change them. Otherwise we might end
up with sequences of function-name-rename patches for no good reason
besides someone mot liking the existing names.

Thanks,
Guenter

> - Join multiple lines into one if it can fit in 100 columns.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/platform/chrome/cros_ec_proto.c      | 9 ++++-----
>  drivers/platform/chrome/cros_ec_proto_test.c | 8 ++++----
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 91c945c9911f..1622e24747c9 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -230,7 +230,7 @@ int cros_ec_check_result(struct cros_ec_device *ec_dev,
>  EXPORT_SYMBOL(cros_ec_check_result);
>
>  /*
> - * cros_ec_get_host_event_wake_mask
> + * get_host_event_wake_mask
>   *
>   * Get the mask of host events that cause wake from suspend.
>   *
> @@ -242,7 +242,7 @@ EXPORT_SYMBOL(cros_ec_check_result);
>   * the caller has ec_dev->lock mutex, or the caller knows there is
>   * no other command in progress.
>   */
> -static int cros_ec_get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint32_t *mask)
> +static int get_host_event_wake_mask(struct cros_ec_device *ec_dev, uint32_t *mask)
>  {
>         struct cros_ec_command *msg;
>         struct ec_response_host_event_mask *r;
> @@ -498,7 +498,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         ec_dev->host_sleep_v1 = (ret > 0 && (ver_mask & EC_VER_MASK(1)));
>
>         /* Get host event wake mask. */
> -       ret = cros_ec_get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
> +       ret = get_host_event_wake_mask(ec_dev, &ec_dev->host_event_wake_mask);
>         if (ret < 0) {
>                 /*
>                  * If the EC doesn't support EC_CMD_HOST_EVENT_GET_WAKE_MASK,
> @@ -522,8 +522,7 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>                  * other errors.
>                  */
>                 if (ret != -EOPNOTSUPP)
> -                       dev_err(ec_dev->dev,
> -                               "failed to retrieve wake mask: %d\n", ret);
> +                       dev_err(ec_dev->dev, "failed to retrieve wake mask: %d\n", ret);
>         }
>
>         return 0;
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 7d73aeb99d1d..f63196289f54 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -239,7 +239,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 data->version_mask = BIT(1);
>         }
>
> -       /* For cros_ec_get_host_event_wake_mask(). */
> +       /* For get_host_event_wake_mask(). */
>         {
>                 struct ec_response_host_event_mask *data;
>
> @@ -326,7 +326,7 @@ static void cros_ec_proto_test_query_all_normal(struct kunit *test)
>                 KUNIT_EXPECT_TRUE(test, ec_dev->host_sleep_v1);
>         }
>
> -       /* For cros_ec_get_host_event_wake_mask(). */
> +       /* For get_host_event_wake_mask(). */
>         {
>                 mock = cros_kunit_ec_xfer_mock_next();
>                 KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> @@ -915,7 +915,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>                 KUNIT_ASSERT_PTR_NE(test, mock, NULL);
>         }
>
> -       /* For cros_ec_get_host_event_wake_mask(). */
> +       /* For get_host_event_wake_mask(). */
>         {
>                 mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND,
>                                                     sizeof(struct ec_response_host_event_mask));
> @@ -976,7 +976,7 @@ static void cros_ec_proto_test_query_all_default_wake_mask(struct kunit *test)
>                 KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_get_cmd_versions));
>         }
>
> -       /* For cros_ec_get_host_event_wake_mask(). */
> +       /* For get_host_event_wake_mask(). */
>         {
>                 u32 mask;
>
> --
> 2.36.1.255.ge46751e96f-goog
>
