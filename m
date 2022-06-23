Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB6557FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiFWQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiFWQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:36:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7872F48884
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:36:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ej4so25388492edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/lqBcVsfxOKYQ/ByCyoavPTpdHhI26R+jJ+6WpVNfFY=;
        b=GHBY9CCMAqDWxTokSvkIj6qjqb6IC7PLd65SFJbJa8q+W0uj/OzzEO7mnSmKaoyqFk
         gnARvMB4INeNS0CEkyPUnhy1XrGIKmPVwexjgxrsG304XD7NgJ7N782LwJzkhvL2gsHc
         GKNR+autfR1yo293JGOp5lS3Eaz8Dupc/Lc8I8/4ZShQNOPsG4OmQpKg6XY397Rxw3ve
         qnNJkUCYxC8pn7kAVOMLbImRlAqJPuXOo07FARaXqQl8l2vQ81+CQLgfWqLwcQTDDjKF
         On2XrT+0CUZ8f3epypZxbK2KzecWSwzqo9JYvoU4m48WBci6LenYYXBjZ5b+xgSe9Hb9
         IXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/lqBcVsfxOKYQ/ByCyoavPTpdHhI26R+jJ+6WpVNfFY=;
        b=vd1q+aCPF8DpcDIybKkQrAdQylTIpEtsbExvJKJS55d6nDIPmeK+C4I3WIj5yrSu6M
         NmRC+dlqjZLMSncRunzg++Je3atoooTNQsCbnFi+94aPaOGXXBzCqBVk9Clp6vtCXwBg
         ZByByTjHT6DskOAUCxkhgOujmgjQVSkPUpxcu4S1kGTMKq+XeO5HGh0kcKaTzkiwSzlS
         MffgBNZVIPu2P6q73bwxkZQrdLN572qv3dmGjIN+gCAe1G9+7tBV291lK6Fqk2z/zLGK
         JWagxu8lwwQdBcrXc0B7ln2Zt/z6glAxxwcmuYedLvOW3HC1Chr94l5INzg6cDgaAdCF
         EvFA==
X-Gm-Message-State: AJIora9O5J+GblTlbDhKPyRhi32U664YuthVXdQt3YSonjvBonDjziUG
        HVfx2xnfh2Mjbuom7GoNIN5mw+caoOO+/hKy+/syLg==
X-Google-Smtp-Source: AGRyM1vRc2HnzFsusmUvfs2f4IEsojy+FS8mMbAUT5AID6ONZKfbCZjTAcW2H4tEvSRoVeCVg9S4MMd3lGz2HbQdTlw=
X-Received: by 2002:a05:6402:3487:b0:435:b0d2:606e with SMTP id
 v7-20020a056402348700b00435b0d2606emr10787936edc.66.1656002186757; Thu, 23
 Jun 2022 09:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220622041040.202737-1-tzungbi@kernel.org> <20220622041040.202737-2-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-2-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Jun 2022 09:36:15 -0700
Message-ID: <CABXOdTf=G4hWfvS-Pt+mHUnXzX7Sz9Z-LE_TBSBB2rpEwhfMUw@mail.gmail.com>
Subject: Re: [PATCH 1/7] platform/chrome: cros_ec_proto: add Kunit tests for cmd_xfer_status
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
> cros_ec_cmd_xfer_status() calls cros_ec_cmd_xfer() and cros_ec_map_error().
>
> Given that there are already test cases for cros_ec_cmd_xfer(), only add
> basic Kunit tests for cros_ec_cmd_xfer_status().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 42 ++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 7d45e5022221..6464f6101fd3 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -1964,6 +1964,46 @@ static void cros_ec_proto_test_cmd_xfer_in_progress_return0(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, cros_kunit_ec_pkt_xfer_mock_called, 2);
>  }
>
> +static void cros_ec_proto_test_cmd_xfer_status_normal(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       /* For cros_ec_cmd_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_add(test, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       ret = cros_ec_cmd_xfer_status(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static void cros_ec_proto_test_cmd_xfer_status_xfer_error(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       struct ec_xfer_mock *mock;
> +       int ret;
> +       struct cros_ec_command msg;
> +
> +       memset(&msg, 0, sizeof(msg));
> +
> +       /* For cros_ec_cmd_xfer(). */
> +       {
> +               mock = cros_kunit_ec_xfer_mock_addx(test, -EPROTO, EC_RES_SUCCESS, 0);
> +               KUNIT_ASSERT_PTR_NE(test, mock, NULL);
> +       }
> +
> +       ret = cros_ec_cmd_xfer_status(ec_dev, &msg);
> +       KUNIT_EXPECT_EQ(test, ret, -EPROTO);
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2044,6 +2084,8 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_xfer_error),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return_error),
>         KUNIT_CASE(cros_ec_proto_test_cmd_xfer_in_progress_return0),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_normal),
> +       KUNIT_CASE(cros_ec_proto_test_cmd_xfer_status_xfer_error),
>         {}
>  };
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
