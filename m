Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EBE53DE82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351615AbiFEWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEWBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:01:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C4E0FC;
        Sun,  5 Jun 2022 15:01:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id v25so16517743eda.6;
        Sun, 05 Jun 2022 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ondmjgAxGqeDp2XUj67mZ5IMErGHUjY8POluActOZu4=;
        b=o15HfI2ya/YqfCZmacZk6vWWDsMjeMvsdoXSdUJUeHBM55SMmT/QL61V1qtYVrjI7l
         HJKmEOMSEapIR0SlBZoJcogMOM8TzSehrSQUhUJpIdVpX7B6vzoqLV/OI/a1YtFyoaGe
         WjP6aAGyD4EkZiwW9CDNhBKkvVZV8NJB161x1jWc/brVZhlsNPqQ0P9JLec0Xqs/tB72
         JD75JIYfLRKop3mcUc3Qf+5xOq6zNbKWYUc5qdWUW9p77SlH6qr9nLO15Ftl5kXHwQj1
         vPGXPJAlNUPwPTrdazKqOhcAazGWqPa3U00bbM3ye8HhsbUZx1V8V+f259OzKPQy8KhQ
         B9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ondmjgAxGqeDp2XUj67mZ5IMErGHUjY8POluActOZu4=;
        b=LeYyp0SlEQtuK/E24Wuxg99lsGLKDmuLvb8L6pML14os43VxppbSSlIdqMYEI6FQlY
         o2VBswcEMTT8U5/D+2+RpfEwyU3PTkPrj7An6Ep+VAHfDaqds9nuScqiZowFIhU+Ne4i
         FkY7fOahl6D6yTkC11tIlU0DXztuaEwzuqSO8znE90u5vLqWLDaHoBbR0d8aUgmCSiUH
         sVidxvaCsU75tDZcyqM0Ogd/e6FA9K58G36336bREjlNph6avfhkzKKpfoAyL7kKWx9I
         zwrqmfQHcpw837IOkeWU3RU4+QPd5sBJ9Z6r2Oj99bpHQkmX02nPZAtTdQhIKjci2gja
         48ug==
X-Gm-Message-State: AOAM531s70spy7E47s6dO3s8JzxXCK/Ih++nGceTEZcE7E9lwV1i+JQR
        s7vyD0pZmepsD99XdHaN7n6lZjgLPTX35bSr0y8=
X-Google-Smtp-Source: ABdhPJw0y2gMZT2vCjg6zrUbB5AGvgtdID/sngMlUbkYXPcY4C4in4ED2eqnJP4rnunQfBbV0b5xYKN7YlS1W1T2jzs=
X-Received: by 2002:a05:6402:1488:b0:431:56cb:bbc5 with SMTP id
 e8-20020a056402148800b0043156cbbbc5mr3353146edv.199.1654466488698; Sun, 05
 Jun 2022 15:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com> <20220603100004.70336-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220603100004.70336-3-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 6 Jun 2022 00:01:17 +0200
Message-ID: <CAFBinCDV4Q9Ma2LHV7gSj+17Do6SZmTMFLr=7D0DvRpRsgSOJA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] iio: adc: meson_saradc: Convert to use dev_err_probe()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
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

On Fri, Jun 3, 2022 at 12:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
