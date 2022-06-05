Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52AC53DE7F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbiFEWAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEWAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:00:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80230E0D5;
        Sun,  5 Jun 2022 15:00:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so12615251ejb.11;
        Sun, 05 Jun 2022 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nXs+dOt3qtz5Rfpk6unyzsXwut+ijWDQ38kRxpMpj8=;
        b=FcC3JidIshj4EA0fVIOWBbVSVLLqvUJhH+YNW/bHu2KmUkSoxIe1SiHDeWStNnFxWG
         VkdC1Or2gXV72tgxnPZWIssM4auPVUoWiLkaF0RaSx+DkuldZ3Akk2LrcDkLE7WcWkEG
         ZExQG9TRkZzCcVeVoDuE+jtspC+Scd4mlMGXQGD8WpIkrMGlogGjxemSj95k38/rUi9S
         zU2tjWXA96GXVY0DAXczJ61XiHSH+o7LUSrkgHpB2PuYXQBgDtTJmbVJYd384AR9+O80
         cX3QvrIwHkY8t59KX7+bQzfUM8u3FqFMrN9XZTOGKjDsr3nwwRB7Yw3rfz3Ey2NL0OJE
         0j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nXs+dOt3qtz5Rfpk6unyzsXwut+ijWDQ38kRxpMpj8=;
        b=OTi5XHtWdxZVWDBYACMC/cuPCi6/cOvbR3YPvTfaQv7lcJ/q2lAnc4LFBhqX9cCEcQ
         8tACti6dEiCymnzbYTNhv6JAU73xNRj5t1Tqvg0URh/F4gxMKC9I0Gh5FIusjgvtyHCJ
         fgs1CFqsFeeOG1n7WWeoIb3tfcXXvls9jm8bXjfFwmIDUgFfAY/kh3vgunMbgyapiWVF
         iTzRJzhubDz4r4j8JMjET22PvhmNbO7qL+VDQ3ZADnCGCKYl8lf/t5aVBUBHfXpn/J/O
         aEm8b3Hrzjxn5trLHmHOM3EOUI/+HhqF3CuSyHLHTXAZj1dQaavcZ7MYR9SX7Uz+8uM0
         2Mog==
X-Gm-Message-State: AOAM533HQKkFIOwD5f5JG0NKKZlGQFQSUPaSNg7Al3YOp+57oE72bo/Q
        6MRAGoiD+Gan/VwtkmpMUeudEUAG1c+l19SwMl0=
X-Google-Smtp-Source: ABdhPJyEym4B73mVP1FoOMoa0kohLjIHNbohmdWKyDfl/jaxeraMjTh9uFMTqi4GbH8CzsbLtA8iHTi0XfsHx4wnEUU=
X-Received: by 2002:a17:907:7f21:b0:6ff:10b:9cee with SMTP id
 qf33-20020a1709077f2100b006ff010b9ceemr18764852ejc.302.1654466403949; Sun, 05
 Jun 2022 15:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com> <20220603100004.70336-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220603100004.70336-6-andriy.shevchenko@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 5 Jun 2022 23:59:53 +0200
Message-ID: <CAFBinCD1cn19uf0pyUF-Af7_thP81Ehih+X4F9+rO8tzeUm+Ow@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/6] iio: adc: meson_saradc: Use
 regmap_read_poll_timeout() for busy wait
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
> Simplify busy wait stages by using regmap_read_poll_timeout().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> v3: new patch, but RFC, not always the read_poll_timeout() can be used, would
>     be nice to have it tested.
and also:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # GXM VIM2
