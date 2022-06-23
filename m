Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513EE558017
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiFWQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiFWQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:40:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CF496A1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:40:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id pk21so19137423ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1UW1A5iTJMy9XUHQDhdeFuCCBbHM+64IpJhXilvfwQ=;
        b=TbWRbkLkwMVYyzfyCVsrhUoZeTEmXG3Jwx8lZ8ny9vilG++0V0vPCbgJYQ0Gj3fRNH
         SGDlItoF7hdJBiqiEbERG0pV0c1OCS8cKZ7q/wF8aeqrOF4V0ti1T6ND5kmWcPgzA73c
         tQwH6N44WdoWO41l+yS2nQjo6/QO+FQ71EnmF5OV4L/ItIuxiEs3xOtCdiJXoujfmJRZ
         avSat2MhTJJugCwM3GiXdfDLNfY5tAFkc1budJZrpKId1fZTf2ACBOwrvQoygtau+zid
         lKu1dl92ry6qTkfiS3LGonHJEjrEsrU2iTnxWx8SL7WeYMVowprR5+PfBml1W4Pw4mqy
         d5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1UW1A5iTJMy9XUHQDhdeFuCCBbHM+64IpJhXilvfwQ=;
        b=lktnvxhd+l+2JGsN5lV142bx6WkeJP6A9/ftip4J0XWf9iushTHHRzNxULP2GbG5fP
         38RW+khwno3DNY2kEbwkLobXPmmUkPEt7ilDXsIl6C/aTB9fq40mWNtOQf5xjzLCdC1r
         X6Cpca0BCNBu5A78Q1iro/gKWcLvGDaY3KluAss+78GXA5DP0eS2FZPyP/rw9JnEa97r
         FCC5zPPrsnhnGXR8+JGve+ia8nM8H17cVFdlQnYxMnRXV8VZv729UCmgXEAu2WwGAkzF
         vGRBQAOhVvxnN0YLxBR/4JUn06tU9IH89OvTcU8Xar0aA5WoZXDJUM6i+8uJsvZp/jx2
         jHyQ==
X-Gm-Message-State: AJIora/Aeih0ZoN/a11txLZBMIl2Oth0ax8dRyEQJxHExajWg0Z5XL/u
        /V0Ws0dNGwdMXGX7f6o4Q8FeOtX3JeSz/OZVGVBZXQ==
X-Google-Smtp-Source: AGRyM1uZfCs+3tcv3oONPrGXLyHDbOIITA35SDt1mjZF4XZ5uphCKoXYKL/A5HjQUZz/Wtd7TrkGZJcg/Nt5jK+Vfps=
X-Received: by 2002:a17:907:72c5:b0:722:e515:fcc6 with SMTP id
 du5-20020a17090772c500b00722e515fcc6mr8761561ejc.533.1656002426525; Thu, 23
 Jun 2022 09:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220622041040.202737-1-tzungbi@kernel.org> <20220622041040.202737-8-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-8-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Jun 2022 09:40:15 -0700
Message-ID: <CABXOdTcQTWMWHyT5=Va1gijyLNsMSM8LQiNU79RWLH-1O4GhCg@mail.gmail.com>
Subject: Re: [PATCH 7/7] platform/chrome: cros_ec_proto: add Kunit test for cros_ec_cmd()
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
> cros_ec_cmd() is a wrapper of cros_ec_cmd_xfer_status().
>
> Add Kunit test for cros_ec_cmd().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 48 ++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 6b26ce3104f4..2ff2783fedfb 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -2592,6 +2592,53 @@ static void cros_ec_proto_test_get_sensor_count_legacy(struct kunit *test)
>         }
>  }
>
> +static void cros_ec_proto_test_ec_cmd(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       u8 out[3], in[2];
> +
> +       ec_dev->max_request = 0xff;
> +       ec_dev->max_response = 0xee;
> +
> +       out[0] = 0xdd;
> +       out[1] = 0xcc;
> +       out[2] = 0xbb;
> +
> +       {
> +               u8 *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_add(test, 2);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +
> +               data = (u8 *)mock->o_data;
> +               data[0] = 0xaa;
> +               data[1] = 0x99;
> +       }
> +
> +       ret = cros_ec_cmd(ec_dev, 0x88, 0x77, out, ARRAY_SIZE(out), in, ARRAY_SIZE(in));
> +       KUNIT_EXPECT_EQ(test, ret, 2);
> +
> +       {
> +               u8 *data;
> +
> +               mock = cros_kunit_ec_xfer_mock_next();
> +               KUNIT_EXPECT_PTR_NE(test, mock, NULL);
> +
> +               KUNIT_EXPECT_EQ(test, mock->msg.version, 0x88);
> +               KUNIT_EXPECT_EQ(test, mock->msg.command, 0x77);
> +               KUNIT_EXPECT_EQ(test, mock->msg.insize, ARRAY_SIZE(in));
> +               KUNIT_EXPECT_EQ(test, mock->msg.outsize, ARRAY_SIZE(out));
> +
> +               data = (u8 *)mock->i_data;
> +               KUNIT_EXPECT_EQ(test, data[0], 0xdd);
> +               KUNIT_EXPECT_EQ(test, data[1], 0xcc);
> +               KUNIT_EXPECT_EQ(test, data[2], 0xbb);
> +       }
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2690,6 +2737,7 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_get_sensor_count_normal),
>         KUNIT_CASE(cros_ec_proto_test_get_sensor_count_xfer_error),
>         KUNIT_CASE(cros_ec_proto_test_get_sensor_count_legacy),
> +       KUNIT_CASE(cros_ec_proto_test_ec_cmd),
>         {}
>  };
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
