Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7A59A980
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiHSXa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiHSXa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:30:57 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7710E7B5;
        Fri, 19 Aug 2022 16:30:56 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c3so5906256vsc.6;
        Fri, 19 Aug 2022 16:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=LhQg0dBzUfX8qQwv1Ow9d0/GZleohvj4+l3TQA47w5Y=;
        b=grDKzBf2Yy4g8lohRV6rBxU8LODwPzYT6FPR95h+8jslj+agyiJAsr6u3bmOO8GhfW
         cUpJJxnSb1ngtqxi/S/R1n1m0JhWxdQWGUYpJwaC47LtBCqSSobz5rjJby0ul8rA2+gV
         0+LbMclJpU0TJplpZXy2yfQ9W6XGLmefNpQ6smCpdf4x7QGQNK9AXqd/eWLuR3qhFVdz
         XVq78PsrYdBhJqDPb1C89y8LgU0SNvihOKpNjmcj2QoqyJt7UwKQ1u3Q2FeoH3E4x1mH
         ohs7C9gH2d0YkKxq4E1WOAr67PSy5OvJpICMDV86dGYjEGk5Esc4FwJoomNQuX1uYAmW
         qGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=LhQg0dBzUfX8qQwv1Ow9d0/GZleohvj4+l3TQA47w5Y=;
        b=IVFQmMsGaB7yJckrUnYWAxupGtgFjtL3BYfi5IjKup+G4lZdCp9VebeRESdN5UrGR9
         hlspOWdisvAqha+sioo3IpuJfZkzcx4sKxbeHPNikDZh5m6jL5amzbqedhuJVsyf0783
         Z3dAybVQhJ7f/SX354K6s0M5t+z4YvfIC2k/RwV6Uu01sCvubrn6MwWtyer1Qj2QY0lu
         UiuDgL1mK4YjT8oOGE9hEeb0soGWtsP+Ge/1+efd2iWJxhmtepK8ehEu1iI2uVAoqrLV
         pkHcxkGryp4xKxSK7Raqx7g4uM4GMdDZCBT2mBOtYoiA7rxoB6dLw0P6aOz8BFE0Fidd
         JS7g==
X-Gm-Message-State: ACgBeo1+TWuf9mWs4IQrcn9gBOCgfVTjTKO/oXIMeDRoJhBrtHbJG5ej
        bWRGLaiEwlT5wmTd0cyVYLdbT5LYiY5BWrSSrVA=
X-Google-Smtp-Source: AA6agR6KTU72WrmouX9reayR9qUb+GX42hDfJz4JzNrthwYAxGd8H1pk34EDI7hzcRHP5OqcYlsuA+r/O1TMlFURrD0=
X-Received: by 2002:a67:e050:0:b0:390:3963:eb5b with SMTP id
 n16-20020a67e050000000b003903963eb5bmr1020894vsl.7.1660951855931; Fri, 19 Aug
 2022 16:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660934107.git.mazziesaccount@gmail.com> <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
In-Reply-To: <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 02:30:19 +0300
Message-ID: <CAHp75VePr790pXZ5AiRnrPmxkOgZ3YKRTbABE6dvk+udQYrXGA@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using devm_regulator_*get_enable()
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
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

On Fri, Aug 19, 2022 at 10:21 PM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
>
> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
> bulk-enable, add-action-to-disable-at-detach - pattern.

...

>  int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
>                       const char *name)
>  {
>         struct bmg160_data *data;
>         struct iio_dev *indio_dev;
>         int ret;
> +       static const char * const regulators[] = {"vdd", "vddio"};

Please, keep this following the "longest line first" rule. Note, in
this case you even can move it out of the function, so we will see
clearly that this is (not a hidden) global variable.

P.S. Same applies for the rest of the similar places in your series.

-- 
With Best Regards,
Andy Shevchenko
