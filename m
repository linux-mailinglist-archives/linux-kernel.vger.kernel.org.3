Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA452C028
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbiERQbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240272AbiERQbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:31:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D883366AC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:31:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ck4so613924ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1oLO7O64SDRDNcmae9yhgZmG0/o3ZbaE07wdLh2WFQ=;
        b=d3ftFDSE2RnvF12jRgGG+txqJyBd/ppy2FzGUzh8ZdS5XsqYp41rNlyyk0uGlh1kG8
         8+ipFezXKpEJqt0FbB9RD9nE01cndrmo9l3Z4xO6xhaHoNPhZ6+lHIAAQONJBRnL0XGz
         jAlRAlMGYgQyvsL7A4D0ExDfDOr4R8T/uMR/R0uZE/X2XsQh4ILJ6XhT11Ve/GNdcrry
         64MapQem4AuA/rXiRqKblOHsX6Odiz6FjT1AJCslR14QCpdbWGfEfAOFsxcs+rOFpitC
         uFaSkhgLaE57WMDFBIZHHtJGWCeC5mkKS40RjuiB9x2QpvERtyH1dY6/MuK2JQcqq0sN
         CGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1oLO7O64SDRDNcmae9yhgZmG0/o3ZbaE07wdLh2WFQ=;
        b=If/36NDw/tBe0X6X9JpKALblSbsdiE+xb+cg5qQrQ1TRioqv3oSBwqprrCi7QXrVtF
         6DQTzWENt6ttik8G9UnaHeNEouKzUAxAlN8DfGgMsK0ofmNzzD8ss7yP0B1Hea18fTY1
         pqZNBng51nonDAGR5D0Mneqpe9/QxYY8484epNJpgKlXH4F1+sZNst8mE2b2ch+Kwz4r
         +T/WAddECpgm99L/z0V2mPhy1hK/K4NeygZIK/Q9Q8PSC99Og3J5bvd7adQ9bRuB04T6
         PYWRovl+UGPZh9FRGPuzsCL267n15GiNGFEkEp6WvRhXs5PKCpuNz18Epa44ELCevKRy
         RVlg==
X-Gm-Message-State: AOAM531YAklrZhyPgzIcuLrHsK2AU7qQbeqV5JpIzLazALAxSGHqA5Bu
        pPRbf96kwNmjog2MP1z3TaV2lEPcZxrJSikaiJZ4DJXHaq8=
X-Google-Smtp-Source: ABdhPJxeTSwGbl7FGSVnCs22tbEzqpLymMjcjO0LZv2ZWelzkkszQjknqK4mMIFHEeBmZVCFBtcARPNbd052uiFrKNw=
X-Received: by 2002:a17:907:6ea2:b0:6fe:6da9:5d2a with SMTP id
 sh34-20020a1709076ea200b006fe6da95d2amr377345ejc.189.1652891492792; Wed, 18
 May 2022 09:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220518091814.2028579-1-tzungbi@kernel.org> <20220518091814.2028579-5-tzungbi@kernel.org>
In-Reply-To: <20220518091814.2028579-5-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 18 May 2022 09:31:21 -0700
Message-ID: <CABXOdTdUtP+7CLHfpUh+zJ7ho+MduEiMYRtMK5JNnzaY8bCWdw@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_check_result()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
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

On Wed, May 18, 2022 at 2:18 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> cros_ec_check_result() is used to check if the EC communication success but
> EC responded EC_RES_IN_PROGRESS.  It should return 0 even if EC wasn't
> happy about the host command.
>
> Add Kunit tests for cros_ec_check_result().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 41 ++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 61abb18ac00b..25c4fca5c165 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -132,6 +132,46 @@ static void cros_ec_proto_test_prepare_tx_bad_msg_outsize(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, ret, -EINVAL);
>  }
>
> +static void cros_ec_proto_test_check_result(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct cros_ec_command *msg = priv->msg;
> +       int ret, i;
> +       static enum ec_status status[] = {
> +               EC_RES_SUCCESS,
> +               EC_RES_INVALID_COMMAND,
> +               EC_RES_ERROR,
> +               EC_RES_INVALID_PARAM,
> +               EC_RES_ACCESS_DENIED,
> +               EC_RES_INVALID_RESPONSE,
> +               EC_RES_INVALID_VERSION,
> +               EC_RES_INVALID_CHECKSUM,
> +               EC_RES_UNAVAILABLE,
> +               EC_RES_TIMEOUT,
> +               EC_RES_OVERFLOW,
> +               EC_RES_INVALID_HEADER,
> +               EC_RES_REQUEST_TRUNCATED,
> +               EC_RES_RESPONSE_TOO_BIG,
> +               EC_RES_BUS_ERROR,
> +               EC_RES_BUSY,
> +               EC_RES_INVALID_HEADER_VERSION,
> +               EC_RES_INVALID_HEADER_CRC,
> +               EC_RES_INVALID_DATA_CRC,
> +               EC_RES_DUP_UNAVAILABLE,
> +       };
> +
> +       for (i = 0; i < ARRAY_SIZE(status); ++i) {
> +               msg->result = status[i];
> +               ret = cros_ec_check_result(ec_dev, msg);
> +               KUNIT_EXPECT_EQ(test, ret, 0);
> +       }
> +
> +       msg->result = EC_RES_IN_PROGRESS;
> +       ret = cros_ec_check_result(ec_dev, msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EAGAIN);
> +}
> +
>  static int cros_ec_proto_test_init(struct kunit *test)
>  {
>         struct cros_ec_proto_test_priv *priv;
> @@ -159,6 +199,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_prepare_tx_legacy_bad_msg_outsize),
>         KUNIT_CASE(cros_ec_proto_test_prepare_tx_normal),
>         KUNIT_CASE(cros_ec_proto_test_prepare_tx_bad_msg_outsize),
> +       KUNIT_CASE(cros_ec_proto_test_check_result),
>         {}
>  };
>
> --
> 2.36.0.550.gb090851708-goog
>
