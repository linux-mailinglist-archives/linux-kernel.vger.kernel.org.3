Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F023D4EFBE5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352700AbiDAU46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351348AbiDAU4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:56:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EDA1C4B10
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:55:03 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id e22so4563201ioe.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxdKMcfYeDJl9VEeQV5qTQKbRI36bdOnubpQqFT5Dsc=;
        b=VwlCrhVv95bdY6Xvn636FGICBwdC53ZsHE0X8eiAXzNCA8X1yA8mnM+bXTgrnVvm39
         0q3bKePS4uw2NnrV31eBbKglSewWfiWfCo6Ph7+LtBdZcTR2LnDxPxVb2aw2Lo2XS0/C
         RP5s/2T/GI8uCQhVeBHSOCU4dDCmri/fKKHtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxdKMcfYeDJl9VEeQV5qTQKbRI36bdOnubpQqFT5Dsc=;
        b=nEAZ+HKGHcIr+ouue+FrpKA2v7dW/+CSUYt+h2piHGwoqMCWreMJS/F2/CUQiz8hbw
         muXgsm8LuObxgcM1mQeYieIP03fYGzfUArKLIbCgbo4lMU0lr+k3fKpu764mnTg2Gzdl
         cDMCE33bR33WL4ncaYy8mE7XNBA7Jewjg/vqgR8ehHS5mpT3RXHFeDMwkEjnwmc39ye6
         33h14Qb77E1HoQ1IhVq6ZGaE3ETimxzD+sXl20Za7adfI61r0LA27ytyl/ZBixsqFQs7
         6ZimLs7WFVrQHWN/chWU51aozm0ijPHcdSks+yZLn/8gjYXI47sQa11vRscA71JfyTln
         f/7g==
X-Gm-Message-State: AOAM530AUa+aO1Q1CdscIbcJe+pTdoYTnz4JtSSQtLhA9r/0mTsk0wKg
        41Wj15pbdFW2SXy+GysxqpA2sXAkKLnfuWy0EekoTQ==
X-Google-Smtp-Source: ABdhPJxmivihRzSeIJe8SsSHZgn0rvB4pN75ADkEmltV9+C+9ga7+Ptqw3/wvSK7dEe0fAODnxEhRVHBoaTGNDj619M=
X-Received: by 2002:a05:6602:3281:b0:648:d45d:22e with SMTP id
 d1-20020a056602328100b00648d45d022emr657622ioz.7.1648846503250; Fri, 01 Apr
 2022 13:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220331210425.3908278-1-swboyd@chromium.org>
In-Reply-To: <20220331210425.3908278-1-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 1 Apr 2022 13:54:51 -0700
Message-ID: <CAPUE2uvpBaE+YLkg6RXq4CCEFBr5ZFhjS1dXkbse9nyH8C=2Jg@mail.gmail.com>
Subject: Re: [PATCH] iio:proximity:sx_common: Fix device property parsing on
 DT systems
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 2:04 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> After commit 7a3605bef878 ("iio: sx9310: Support ACPI property") we
> started using the 'indio_dev->dev' to extract device properties for
> various register settings in sx9310_get_default_reg(). This broke DT
> based systems because dev_fwnode() used in the device_property*() APIs
> can't find an 'of_node'. That's because the 'indio_dev->dev.of_node'
> pointer isn't set until iio_device_register() is called. Set the pointer
> earlier, next to where the ACPI companion is set, so that the device
> property APIs work on DT systems.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Fixes: 7a3605bef878 ("iio: sx9310: Support ACPI property")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index a7c07316a0a9..8ad814d96b7e 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -521,6 +521,7 @@ int sx_common_probe(struct i2c_client *client,
>                 return dev_err_probe(dev, ret, "error reading WHOAMI\n");
>
>         ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> +       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
>         indio_dev->channels =  data->chip_info->iio_channels;
> --
> https://chromeos.dev
>
