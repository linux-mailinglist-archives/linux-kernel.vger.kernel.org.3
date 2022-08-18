Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1AA598DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiHRURg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiHRURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:17:33 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C82C8;
        Thu, 18 Aug 2022 13:17:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l18so1980853qvt.13;
        Thu, 18 Aug 2022 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RagohbO1MrRrWCI7FxAgnpHfYGPZGQJMPyq1fVIpdc0=;
        b=elX8w4NRHI1TPrW9IPRlh0Sldko1z5DP2VmIOK9FrwrqgLIBdCVWH+vUv2duAN5KFb
         wXyUEIpMjFbh7RiJ8m3c9e14ccQjxjXlzY+cj0vyza1veRNaOXWwp632qON8YvPCIPGL
         /1kH08HODSgleBSwWJAsiU4nWUrrw9XXwcfKdowh2kNSKmzCVTROqXOn4bBkxHdv/ffp
         HkN8s09GpBRkFH+xMwvpxoUoDMu++JHK1eZVupXrJTQVBRGknkvU6PDMzHwvJNemHfR/
         wy2o/2BU8o1KNJoW4/z28/35B4zSXoRS26NsBT+rinU3uj2dd+kfMMVBcN/1kkmjnVYG
         KyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RagohbO1MrRrWCI7FxAgnpHfYGPZGQJMPyq1fVIpdc0=;
        b=vFIs3sdfpsst0pcjNyTo6KylLLXgpbyVrLpfyIBdD5EaJYE25yWvNBpZyGAPGXCOBZ
         kW1WC6Nb5kvlqy15h+0v5Y/ZehWjzagJledXTWCLUawLuIobLcKjmJCm8rU/N5XZMMKK
         zILQIiHO2jcyXgjz6UsWJe21cumrCbZNT00uD9sjxR5/zs/gZ3oPUxwRYoI+Tah+28E5
         WauoAcFjeim+YxZPo/Ja76g+2o/jMoKQlWV9XkurUsJ1iFeBGNdbNoqSrS4lNf8+u9zP
         t0u+upnYGvM3HlfeClx1McISj4z9vOULKBgCf4kDOLmR+ngN3sMEPe2r0MCMf7pJK7R+
         isTA==
X-Gm-Message-State: ACgBeo3ATccPsJDBkPB6rtLVhSxOE/Y9gZa7tjEtLWqf+X63XMGIA/Zs
        YZCmOQkRnR+rOK2qAbojCtBjo3pm+FYPpJu4U20=
X-Google-Smtp-Source: AA6agR4jiGGNInYimiIdJD7xQgTdH41Rww1FvNd75BjW9IfyKYGQYONby44a1l3nUArt73ZaZVW8JiFSAcvLxedPATc=
X-Received: by 2002:a05:6214:5290:b0:479:5df:e654 with SMTP id
 kj16-20020a056214529000b0047905dfe654mr3842324qvb.97.1660853851615; Thu, 18
 Aug 2022 13:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220815145705.203017-1-eajames@linux.ibm.com> <20220815145705.203017-3-eajames@linux.ibm.com>
In-Reply-To: <20220815145705.203017-3-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 23:16:55 +0300
Message-ID: <CAHp75VegQspJJ9YT=2E3YvKh-hp9-AGincp4z0GdQbA0Vq4Zug@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: pressure: dps310: Reset chip if MEAS_CFG is corrupt
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
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

On Mon, Aug 15, 2022 at 5:57 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> Corruption of the MEAS_CFG register has been observed soon after
> system boot. In order to recover this scenario, check MEAS_CFG if
> measurement isn't ready, and if it's incorrect, reset the DPS310
> and execute the startup procedure.

...

> + * Called with lock held. Returns a negative value on error, a positive value
> + * when the device is not ready, and zero when the device is ready.

Can we have

#define DPS310_DEVICE_NOT_READY  1

(or anonymous enum) and return it instead of abstract 1 or any other
positive number?

...

> +       rc = dps310_check_reset_meas_cfg(data, DPS310_TMP_RDY);
>         if (rc < 0)
>                 goto done;
>
> +       if (rc > 0) {
> +               rate = dps310_get_temp_samp_freq(data);
> +               timeout = DPS310_POLL_TIMEOUT_US(rate);
> +
> +               /*
> +                * Poll for sensor readiness; base the timeout upon the sample
> +                * rate.
> +                */
> +               rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> +                                             ready, ready & DPS310_TMP_RDY,
> +                                             DPS310_POLL_SLEEP_US(timeout),
> +                                             timeout);
> +               if (rc)
> +                       goto done;
> +       }

But have you tried to make a helper that takes a pointer to the
respective function?

-- 
With Best Regards,
Andy Shevchenko
