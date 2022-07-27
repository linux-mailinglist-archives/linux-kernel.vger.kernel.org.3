Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA175831BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiG0SO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiG0SOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:14:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0940822BE4;
        Wed, 27 Jul 2022 10:15:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a89so1582087edf.5;
        Wed, 27 Jul 2022 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itvgIbCL8AlCfcLB9DTtKEyVMfAWjYXvrHFZiAXSjJg=;
        b=Bcmb33ExgzjD085FFT10aS3qwRAirdFEfJ39vDABC6q7rHl2PTaaAIy/C1NBIPMpXw
         z2j+wMRGCtX1egbdOJbGI+GWPB0uFOGb+gPnd2VuxOaX4LxooBPkn0zlOXCgOeebr4LF
         D10HTuidi7HVbJkor0ZQLddZUwg73iz03jgt5jMOue/9/iuleHHrltNh0feiIRQMmKie
         4keYy9hJiVnVts4n5ZKcpORvaZ3NXWqkBEHFy4KKzSgh0TVfgzvOyheQHMVra/jmggfC
         i8XTPHIFHWzK1TFxS/ggEVxm+b5wXhEOmyvHEkWSub2A7pUiQSrYrJW3DBCcE+OtH5SN
         DKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itvgIbCL8AlCfcLB9DTtKEyVMfAWjYXvrHFZiAXSjJg=;
        b=61iJ5QlUwBCPmB7NMkVRZuzTcJtLkSYXJfvoUdUE/MsMFe6AXfMeQLTlB1apiSR2pq
         6sFr9Kr3ZZjbIffojfAy6dDRXfJYDQ7IMJE/RsAEqdu8n9/BtM5HULnRmCu2GRIuRoF3
         6DBkebxs1JJDTXWOPDpwrUOuOfGBROBvUarqgQs51R8X3gKPDEGhWa0OQr8zLKDfU5AL
         GBW0mbLIlHMAftLzAIcdx6VHtj6YMw+u2EnmN4TwCB8woC6welYaiV9/9JlO20Y0Ytvd
         uPiaDD0KdKiXJeIgzfReowWWVptuy6RneZPSiK1pUnDOpnW9VaviI/OqX/r+dJqi8uvq
         PxQg==
X-Gm-Message-State: AJIora+Nos+n03AWWTU50otxjRN71sUoZkmerQLbgTLI/Dtsf+cHZ6+G
        NZMKfAHfHNXwQknbbsltU8RBUoklBxEmvKL3qGc=
X-Google-Smtp-Source: AGRyM1vE08GvXI8Seq7fL6E4eE6uDbubhjXI6A38hQXiIuv3wrFyKuSIA6l/+5iEpaT7ExlrM13QBhCbT2WWYntLl1k=
X-Received: by 2002:a05:6402:280b:b0:43b:5d75:fcfa with SMTP id
 h11-20020a056402280b00b0043b5d75fcfamr24007933ede.114.1658942118376; Wed, 27
 Jul 2022 10:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220727164133.973930-1-potin.lai.pt@gmail.com> <20220727164133.973930-3-potin.lai.pt@gmail.com>
In-Reply-To: <20220727164133.973930-3-potin.lai.pt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jul 2022 19:14:40 +0200
Message-ID: <CAHp75VdUHRYcyoRQXMs2OWq6Vke2-7sPEOujZ=dWwiNG80f+1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 6:43 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add manufacturer and device ID checking during probe, and skip the
> checking if chip model not supported.
>
> Supported:
> - HDC1000
> - HDC1010
> - HDC1050
> - HDC1080
>
> Not supported:
> - HDC1008

Almost there!

...

> +static bool is_valid_hdc100x(struct i2c_client *client)
> +{
> +       const struct hdc100x_chip_data *data;
> +       int mfr_id, dev_id;

> +       data = device_get_match_data(&client->dev);
> +       if (!data->support_mfr_check)
> +               return true;

Logically this part does belong to ->probe() and doesn't here (too
wide for this specific helper).

> +       mfr_id = hdc100x_read_mfr_id(client);
> +       dev_id = hdc100x_read_dev_id(client);
> +       if (mfr_id == HDC100X_MFR_ID &&
> +          (dev_id == 0x1000 || dev_id == 0x1050))
> +               return true;
> +
> +       return false;
> +}

...

> +       if (!is_valid_hdc100x(client))
> +               return -EINVAL;

Means here you add

       const struct hdc100x_chip_data *data;
       struct device *dev = &client->dev;
       ...
       data = device_get_match_data(dev);
       if (data->support_mfr_check && !is_valid_hdc100x(client))
               return -EINVAL;

(Introducing a temporary variable for struct device pointer might also
help in future to refactor to make code neater.)

-- 
With Best Regards,
Andy Shevchenko
