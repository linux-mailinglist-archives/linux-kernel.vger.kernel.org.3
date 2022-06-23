Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B83F558007
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiFWQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiFWQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:38:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE08740E60
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:38:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c13so24888157eds.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAlxQgMTHS8WASi4S9BFRIXGatijsC0zjEnIxlEzU0o=;
        b=c2Opogx1Bd/U//9VL4xN3Ue/JcsrrLE/FiXi6Nbwp8mDyOyTL6h8z0ZwfClfqhlC9Z
         2E8Hecn/mkFBg/hGr9QnGk1foO5bOUbdW3QdCgYDxP4XNFppRM5x/z7uI1xK/cBIZftA
         JdMVGpjr50DGlgPiSrNX7Wb7Epu27mlZZCddPUprefJtNP1Fowd+wYwfaA1spO66tkuY
         XShc1+xoXPbCCYcWko7bva5VYupOwlJaBYwLVKLdYdJiwmGrNN+j0iOUwRZ6sFOVmu3c
         asBSS0K4EnJmQiTIQIkvXYnn1VnttUK4OK4Oq/ZIQByORMqVzlzVPDLNo4zXiQ1xRzD7
         e/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAlxQgMTHS8WASi4S9BFRIXGatijsC0zjEnIxlEzU0o=;
        b=T9o/X0E0ZVf17pqo7BXvUrKW384qOntTbTuXfghsD/cjcLabYx+f8Z90XMEBD6yLce
         5lv0x5BTmilDVL8h/rZk3IVBsfl3+ty0wKmcBjepXsDLUsWZ5wcDZ/aHdgYJsfI4MvR5
         claPnoBH+nyFDpA7/nLjaVH3f1mw37AjNt9cjXcgkeJU2LQ1Sg/31jFoTXWsmRFeLS7i
         nJd5YDWIg0UkI3JUE0GOFPpVvtosYCe/5YzkzAKoVY91YuAcrXJ1rR+JWnC9xmS/b6+G
         23NiRVa5LZahiO6tnrwfRTKme5eepHmEp2hemlz0ZooBM1jSgxg8A4waNljhGVe8UfME
         4hAw==
X-Gm-Message-State: AJIora/AFQXbqsYQQdkcy9RnDKMUQPZp0u7GFq8qbqfBqXhQpsGTZd8L
        3rACvOQAI7tf7PRwxl7as05h/eoro1MridY7qStQ1Njq8enBEWJm
X-Google-Smtp-Source: AGRyM1uox2maQgIrsXGHPliPlOMPr+sIaCyTcwN2FF3VUu3js79EX3dVQ/MjttufXm+TNlb7eGKNZpVY6G4fdztUikc=
X-Received: by 2002:a05:6402:5193:b0:435:9a5f:50a8 with SMTP id
 q19-20020a056402519300b004359a5f50a8mr12033999edd.212.1656002302254; Thu, 23
 Jun 2022 09:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220622041040.202737-1-tzungbi@kernel.org> <20220622041040.202737-5-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-5-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 23 Jun 2022 09:38:10 -0700
Message-ID: <CABXOdTfuiVan-Rascq1X-hrvf-68FPu636G1T-v6fA-kUhMArg@mail.gmail.com>
Subject: Re: [PATCH 4/7] platform/chrome: cros_ec_proto: add Kunit tests for get_host_event
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
> cros_ec_get_host_event() performs some sanity checks, parses
> `ec_dev->event_data.data.host_event`, and returns bitmap of
> EC_HOST_EVENT_*.
>
> Add Kunit tests for cros_ec_get_host_event().
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_proto_test.c | 59 ++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
> index 64c4b79f7a0c..dce9fa3b9c8d 100644
> --- a/drivers/platform/chrome/cros_ec_proto_test.c
> +++ b/drivers/platform/chrome/cros_ec_proto_test.c
> @@ -2312,6 +2312,61 @@ static void cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked(struc
>         }
>  }
>
> +static void cros_ec_proto_test_get_host_event_no_mkbp_event(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +
> +       ec_dev->mkbp_event_supported = 0;
> +
> +       ret = cros_ec_get_host_event(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static void cros_ec_proto_test_get_host_event_not_host_event(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +
> +       ec_dev->mkbp_event_supported = 1;
> +       ec_dev->event_data.event_type = EC_MKBP_EVENT_FINGERPRINT;
> +
> +       ret = cros_ec_get_host_event(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static void cros_ec_proto_test_get_host_event_wrong_event_size(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +
> +       ec_dev->mkbp_event_supported = 1;
> +       ec_dev->event_data.event_type = EC_MKBP_EVENT_HOST_EVENT;
> +       ec_dev->event_size = 0xff;
> +
> +       ret = cros_ec_get_host_event(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, 0);
> +}
> +
> +static void cros_ec_proto_test_get_host_event_normal(struct kunit *test)
> +{
> +       struct cros_ec_proto_test_priv *priv = test->priv;
> +       struct cros_ec_device *ec_dev = &priv->ec_dev;
> +       int ret;
> +
> +       ec_dev->mkbp_event_supported = 1;
> +       ec_dev->event_data.event_type = EC_MKBP_EVENT_HOST_EVENT;
> +       ec_dev->event_size = sizeof(ec_dev->event_data.data.host_event);
> +       put_unaligned_le32(EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC),
> +                          &ec_dev->event_data.data.host_event);
> +
> +       ret = cros_ec_get_host_event(ec_dev);
> +       KUNIT_EXPECT_EQ(test, ret, EC_HOST_EVENT_MASK(EC_HOST_EVENT_RTC));
> +}
> +
>  static void cros_ec_proto_test_release(struct device *dev)
>  {
>  }
> @@ -2401,6 +2456,10 @@ static struct kunit_case cros_ec_proto_test_cases[] = {
>         KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_version2),
>         KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_host_event_rtc),
>         KUNIT_CASE(cros_ec_proto_test_get_next_event_mkbp_event_host_event_masked),
> +       KUNIT_CASE(cros_ec_proto_test_get_host_event_no_mkbp_event),
> +       KUNIT_CASE(cros_ec_proto_test_get_host_event_not_host_event),
> +       KUNIT_CASE(cros_ec_proto_test_get_host_event_wrong_event_size),
> +       KUNIT_CASE(cros_ec_proto_test_get_host_event_normal),
>         {}
>  };
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
