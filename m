Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729EB567780
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiGETM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiGETMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:12:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC74020F7A;
        Tue,  5 Jul 2022 12:12:40 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id b85so10300327yba.8;
        Tue, 05 Jul 2022 12:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57cUWhF9VaqTVA1734zTG0eBBoeZZWbpzvCVHxEeHsg=;
        b=qgYeHABwiqO25p0BTSmbVdaFuDZo3wWingdIK42NsVZRRyHfNRojZ3lSIqIJsFP7ek
         QsWwbk8Gw2jxnfZru1Xj2c7TcsWbocfl2KRRwkSFwNSVHzz+n95ww4s47QLs2/pS8pEK
         RLIH1iTTayK8I3DKHsSBGDixxFxRp9AtoRHfMMbdVrUhcFkYuKd+IWD/psYCMQ/1ehuW
         QrynLtYB7hEqCmb3YkMIY7BLavlgiSPOuWS1/ay4CDuNJBCfTrnYDP5qwg9LxAyATVtT
         GQn5bmpZd4Fndt6IlqlGIAnyYzWrS5AiVN5zXHT4M16sbZBVZlvZ8/Z0YXYeMO5Lm+nP
         GT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57cUWhF9VaqTVA1734zTG0eBBoeZZWbpzvCVHxEeHsg=;
        b=khhO/7yvkGtqesVBw5y548XOonp7iZHESUV8uItp8FNNjY/yODHOzFCFr7QayvYYbZ
         wl3XlwCIldfo/flT4khahohlEY+QYpNtzDCFswaxCosvlNpr+o2MSM0/RmEW8CVw7KGO
         Rv/IPwGDOM2eM2KxJiRQ701W4wmJZ5mYp8v/rL5B8CnLym7tYD+qBIOWzHvYAtJz0Ns/
         pVwe6YUZsW/BbO7VLQVJgnOPREPINMHvymjmFUr3RnIY91OlLBYnxN/vtzl7AVgZk+B2
         GT/lAg2eGdKakqjKNTGok3JktUGJ4vbsB78QTNZ0NwmfdnXnQdy6U5tyKD4vd6P0/+m+
         k9pw==
X-Gm-Message-State: AJIora8bT35PKmd8ygpmVUNQ9f3XtSJh1yXjDV0B2vTRO9JM8Y88T5ZU
        lafUxUVLOLidfOG6iSNZaDtt5YLMFZ9aUImgr7mQqlkfTtz4yA==
X-Google-Smtp-Source: AGRyM1su+ua32MhJSMzy8VPGelN4ZA+0a9k5ZpXM5XHwIeKL69TkCcG2EspcyfTSny8g0KfHy9W5PDk7RXfaCqmz/oI=
X-Received: by 2002:a25:cbcf:0:b0:66e:8893:a02c with SMTP id
 b198-20020a25cbcf000000b0066e8893a02cmr2851299ybg.460.1657048359433; Tue, 05
 Jul 2022 12:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220705121756.41660-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220705121756.41660-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 21:12:03 +0200
Message-ID: <CAHp75VdnvxhR7yB2sroH4y8VgU3ORnCC3wH4CEKYCX1XSPvMxg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: cm32181: Add PM support
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 2:31 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> The read on in_illuminance_input keeps at 0 after system sleep.
>
> So add proper suspend and resume callback to make the sensor keep
> working after system sleep.

...

> +static int cm32181_resume(struct device *dev)
> +{
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));

Simply device_get_drvdata(dev) ?

> +       return i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
> +                                        cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
> +}

-- 
With Best Regards,
Andy Shevchenko
