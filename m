Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE90A54389B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiFHQOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245202AbiFHQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:14:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2A3114A86
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:14:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v1so31753856ejg.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGn9m0fdkhwA1gpDEF10OhjQq1I10hq7KFiUkQ4pUpk=;
        b=T4vS/t0SbcLTHpxOBi91rhv+zPpSRRFliNYSoVva02OeF1bL0WHk04BFTjGyJvquJY
         1RuR6nTMMkd9axqx6kHFFFeeWvLsI2B4UAWYKZnoABzNfio/TsSQKEYsvu1mF8M7Ck5u
         Kg1j9/jknIETFSZqcFwGWz9brWRjoVAmzfStNV0QinofSu9Vz7v2qhk5PRZRhtH/tuUI
         Xe/KD7tfqFCO0ASaj34jI9eDvOR0RUQXi7FWGKZ/hhs1f9G9ZcqIno/7j+HamT1NkHvl
         d6cvETryqztq1bwlqaYLa3HCV9OkVHSnglLpL5ivNzFF90SrgGPexy+XslYEodbXLvmn
         wXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGn9m0fdkhwA1gpDEF10OhjQq1I10hq7KFiUkQ4pUpk=;
        b=3nQ1i2f/JFafpTgXAuIml45wq6bxSlhZVEOp6rHrTDIs1ReC38zrYumn/ENV/J6QAS
         zEfFoUwpqXPrQEbqcWt7RHDNCHxt9pqTWiRkjN0U38/ibMOFpXLnyJpdpZkZrfkJldMJ
         qyJ+gCUu9LNfZ0NVNT7aVn7tj8QjavyKYj7Unce4ToRGSGpTiGrnG55DRtGH5ItOen81
         Jv8bt7245ueNSmHmtqYgpC/x5wepppi3SWCED20IBqrSkryhWyT0voYFgnxhYBHt2Wn/
         zNAsYfAtuE+srrnlUmLiGFKGZgCISZDLEHLfkTtZ1WkR/bfUDa0QD6k/CeJfZTn4tXqb
         l5Gg==
X-Gm-Message-State: AOAM531tBlIw7GrlWPzQCRNimkrZ4XgohLa3ZCGzImXi3SqJbtoegrLb
        4CfIl1cJga++vEawVAryC0ZV8Rm9nTjOX/w7iY3osw==
X-Google-Smtp-Source: ABdhPJyNz0JikhuzNRq3iN8SYsESldCJB49/x+FVsW7T3w2t/ZNgb/tfLLSZyP1KhGmSDDAN9Q8qgqOrBAnKt7YpwL8=
X-Received: by 2002:a17:906:4d50:b0:70d:afd4:1e63 with SMTP id
 b16-20020a1709064d5000b0070dafd41e63mr28194480ejv.618.1654704871589; Wed, 08
 Jun 2022 09:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220608110734.2928245-1-tzungbi@kernel.org> <20220608110734.2928245-12-tzungbi@kernel.org>
In-Reply-To: <20220608110734.2928245-12-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 8 Jun 2022 09:14:19 -0700
Message-ID: <CABXOdTcg0mThL_rgNWtAs4izk8mWUiQ4+86TpKF8VhvgL3+1sA@mail.gmail.com>
Subject: Re: [PATCH v3 11/23] platform/chrome: cros_ec_proto: add Kunit test
 for getting legacy info
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
> cros_ec_get_proto_info_legacy() expects to receive
> sizeof(struct ec_response_hello) from send_command().  The payload is
> valid only if the return value is positive.
>
> Add a Kunit test for returning 0 from send_command() in
> cros_ec_get_proto_info_legacy().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No v2.  New and separated from the original series.
>
>  drivers/platform/chrome/cros_ec_proto_test.c | 49 ++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 8e47cb70dc8b..63071af81c94 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -751,6 +751,54 @@ static void cros_ec_proto_test_query_all_legacy_data_error(struct kunit *test)
>         }
>  }
>
> +static void cros_ec_proto_test_query_all_legacy_return0(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +
> +       /* For cros_ec_get_proto_info() without passthru. */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, 0, EC_RES_INVALID_COMMAND, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       /* For cros_ec_get_proto_info_legacy(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       cros_ec_proto_test_query_all_pretest(test);
> +       ret = cros_ec_query_all(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, -EPROTO);
> +       KUNIT_EXPECT_EQ(test, ec_dev->proto_version, EC_PROTO_VERSION_UNKNOWN);
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
> +       /* For cros_ec_get_proto_info_legacy(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, EC_CMD_HELLO);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, sizeof(struct ec_response_hello));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, sizeof(struct ec_params_hello));
> +       }
> +}
> +
>  static void cros_ec_proto_test_query_all_no_mkbp(struct kunit *test)
>  {
>         struct cros_ec_proto_test_priv *priv = test->priv;
> @@ -1135,6 +1183,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_query_all_legacy_xfer_error),
>         KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return_error),
>         KUNIT_CASE(cros_ec_proto_test_query_all_legacy_data_error),
> +       KUNIT_CASE(cros_ec_proto_test_query_all_legacy_return0),
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_mkbp),
>         KUNIT_CASE(cros_ec_proto_test_query_all_no_host_sleep),
>         KUNIT_CASE(cros_ec_proto_test_query_all_default_wake_mask_return_error),
> --
> 2.36.1.255.ge46751e96f-goog
>
