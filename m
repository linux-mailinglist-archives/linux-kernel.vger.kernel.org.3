Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FBD5783CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiGRNf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiGRNf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:35:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE5BE1F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:35:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l23so21279006ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLZfMItbgnFH20Ojb6+L7ZjShSWcxZycIztS3QeVtXU=;
        b=RLtIfACKMzTN0tJfrUf3+G0s3unNigLq9BwxSQ0Sj4fwufYxI/xc9A2oZmv/wiOE+N
         tK0b5hoxVJ+cFZ1H9o82+e4frzQOT+LLX5K54hawsa7IwoD1RBbNZbkAHQoHsatuUsW7
         w+9xZ1N13eivY/xwrBfFY5krHpPnEkXOelWNK44QMDBzP4pyIsCzjtmbN/yV+glWZgpR
         nuxtJdmfG5P6aBUFLnbxLJwW4BMjJHY12RcEtfSc74NvdNEQnikayUjN0/zmgFlSFTzG
         h9W9X/z8z3WSfeI8OaPlsV9Ob6hPd9gKmW0tjQ0dMXDzQsSFjXzJOrHQXZUXBhIH3Y8U
         bMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLZfMItbgnFH20Ojb6+L7ZjShSWcxZycIztS3QeVtXU=;
        b=chbYeSup5J+HmvEF+gePIpo1nqGpvQrxjv5HT0LZKtz1giKx/cd9apkIKQZcM6XjJ3
         /X6beLkr4B7vL9PDsJJMMPeUU4f3duUryWVkDkOjlX6ldPm3I12DPOKm9TL65LEaDC8M
         FotL9vgnExNsuEnymqv7O8orH188mPNfVI8Sh1BXDpfHYse0g4tNdDlLdnJrCcYKvsUZ
         9fFFRJKwoVUmGDrKm6xc249zrPT5ogef0eGyzk+7ioV5zzot4FhkPoP9cFjaOcWbijXs
         fbV9o6LVzkTEQct5E3oLK6b5csZorAbgBfE0MUht6RTgUir6pA6P2hiBb/GFAhZ7u9r9
         GJdQ==
X-Gm-Message-State: AJIora9oG53vPAqlO4eB2yGCAGgJQyAHKMtZax1Mi6CrjL6jQRBCx2V7
        c5tlOacHyEsyBx1LSU6tdfK2Mo6no7CgBB3+WPoBIstrQ34=
X-Google-Smtp-Source: AGRyM1vVcwbBDP2kEY0e/gmWy62ZPHbdF1a6M5U7XHIIbXVOkWsVPLzxeIK/H2PIsBow6eepKC9XPEzZQCPheFA0o5k=
X-Received: by 2002:a17:907:6d12:b0:72b:6e70:8c7d with SMTP id
 sa18-20020a1709076d1200b0072b6e708c7dmr27063567ejc.23.1658151353762; Mon, 18
 Jul 2022 06:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220718050914.2267370-1-tzungbi@kernel.org> <20220718050914.2267370-2-tzungbi@kernel.org>
In-Reply-To: <20220718050914.2267370-2-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 18 Jul 2022 06:35:42 -0700
Message-ID: <CABXOdTfYAGapjkPxRC4SbKMKEwCWmrF46aEDFWvsMBqaTuCzPA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] platform/chrome: cros_kunit_util: add default
 value for `msg->result`
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 10:10 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Add default value for `msg->result` so that it won't be garbage bytes
> when the mock list is empty.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> No v1.  New in the series.
>
>  drivers/platform/chrome/cros_kunit_util.c | 7 ++++++-
>  drivers/platform/chrome/cros_kunit_util.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_kunit_util.c b/drivers/platform/chrome/cros_kunit_util.c
> index e031777dea87..6810d558d462 100644
> --- a/drivers/platform/chrome/cros_kunit_util.c
> +++ b/drivers/platform/chrome/cros_kunit_util.c
> @@ -13,6 +13,8 @@
>  #include "cros_ec.h"
>  #include "cros_kunit_util.h"
>
> +int cros_kunit_ec_xfer_mock_default_result;
> +EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_result);

Is this needed as a global variable and, if so, does it really have to
be exported ?

>  int cros_kunit_ec_xfer_mock_default_ret;
>  EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_default_ret);

Same here, really, only I didn't notice before.

Thanks,
Guenter

>
> @@ -24,8 +26,10 @@ int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_comman
>         struct ec_xfer_mock *mock;
>
>         mock = list_first_entry_or_null(&cros_kunit_ec_xfer_mock_in, struct ec_xfer_mock, list);
> -       if (!mock)
> +       if (!mock) {
> +               msg->result = cros_kunit_ec_xfer_mock_default_result;
>                 return cros_kunit_ec_xfer_mock_default_ret;
> +       }
>
>         list_del(&mock->list);
>
> @@ -89,6 +93,7 @@ EXPORT_SYMBOL_GPL(cros_kunit_ec_xfer_mock_next);
>
>  void cros_kunit_mock_reset(void)
>  {
> +       cros_kunit_ec_xfer_mock_default_result = 0;
>         cros_kunit_ec_xfer_mock_default_ret = 0;
>         INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_in);
>         INIT_LIST_HEAD(&cros_kunit_ec_xfer_mock_out);
> diff --git a/drivers/platform/chrome/cros_kunit_util.h b/drivers/platform/chrome/cros_kunit_util.h
> index 79c4525f873c..79c4f259f2bb 100644
> --- a/drivers/platform/chrome/cros_kunit_util.h
> +++ b/drivers/platform/chrome/cros_kunit_util.h
> @@ -23,6 +23,7 @@ struct ec_xfer_mock {
>         u32 o_data_len;
>  };
>
> +extern int cros_kunit_ec_xfer_mock_default_result;
>  extern int cros_kunit_ec_xfer_mock_default_ret;
>
>  int cros_kunit_ec_xfer_mock(struct cros_ec_device *ec_dev, struct cros_ec_command *msg);
> --
> 2.37.0.170.g444d1eabd0-goog
>
