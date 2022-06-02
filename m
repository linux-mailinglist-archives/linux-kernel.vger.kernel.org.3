Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5364853BA10
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiFBNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiFBNqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:46:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97762997BB;
        Thu,  2 Jun 2022 06:46:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id rq11so10099724ejc.4;
        Thu, 02 Jun 2022 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TjLXjWL9wqYYrtKcARcm1yup8NwPPFc5xmJR2d2VRXw=;
        b=T+ezoU9lVT3i7sGNy4W449w7TEAZt24NYm16K1PLU5pcAYWEW43c36fO4PrbEqDlkl
         iK42SBU/2IoTfkudAPfvHOpKGAJJgxfd8TvfyDNNKOvc5HO6ekcqLOQ/bPjO2YCkD8tr
         oTZZtSN8nbdbp/CYpXCrfigymVN+WVrOiVgTyEzpIfxgYpgTo8qt42zDSI0mdfaAVFLQ
         N7aK0dSl7ahVe/vBbovmDUmWtdbtwC4fBVKRMVdomVzXjHgyg160KCgmBs3mYAt8S/MH
         JZEhHEOXulHgSgwfq7WPhbgWhPf41o0NRUjmCo/yfZPmtw5VZIIDur12wbOMHEwRB+GN
         J2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TjLXjWL9wqYYrtKcARcm1yup8NwPPFc5xmJR2d2VRXw=;
        b=BR2TfyOXKkfymQbuiNlkcYdve2/0ZzDe8eLMORQkdSVty4p4ZlSUlZTlvZXFiasLot
         cpS4QsdpE9giBFOPp53290TPqpFsBNzSYhXoySh2ekOdPglFlBZApfn6phAsfkeKB/vx
         0XiGUHb/8Eh5gs27AFUeiSa/Ui+zqejDtxb4iOFDL7HSOUe6g076onaSOXxJnO8rvheU
         xjZuvgABkNUaF5/cGBa39rErJlsABaMM0ZvQ0F6ZJ2vhXgSuqSyDDyYH/tb3UxdNS/KT
         j5F9m5t1QAulHqImZQ7mwejM9YbVGq7P39w3943EyxSFd05NjYal0sOr7k60V7Yt5ozk
         KMOw==
X-Gm-Message-State: AOAM5315vLi6FLcucaODHnJgb+W1qwyiQJ2UX/SPE2LUquxPFyst0W9e
        Ovu8/iJJtx/uTz+oXvpo49/Nerxw8JlGCuyVYBs=
X-Google-Smtp-Source: ABdhPJwHAbggTcvlbjWNHP4pPg0l413e0ilaz6KDRuL60a/o7cOFJG5BNCUysdDQJLe4TShUAov5x2g/NSwOsZ0m0wg=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr4273032ejc.579.1654177563309; Thu, 02
 Jun 2022 06:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220602114241.12601-1-andriy.shevchenko@linux.intel.com>
 <20220602114241.12601-3-andriy.shevchenko@linux.intel.com> <ad3af033-97f1-3aad-d082-c6ed56185b59@metafoo.de>
In-Reply-To: <ad3af033-97f1-3aad-d082-c6ed56185b59@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Jun 2022 15:45:27 +0200
Message-ID: <CAHp75VcSFr+E7_woyw6jx7e9wCeFUUouV_7xJXYO26_y6=fwTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: meson_saradc: Use temporary variable for
 struct device
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Thu, Jun 2, 2022 at 2:08 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 6/2/22 13:42, Andy Shevchenko wrote:

...

> > -     priv->adc_clk = devm_clk_register(&indio_dev->dev, &priv->clk_gate.hw);
> > +     priv->adc_clk = devm_clk_register(idev, &priv->clk_gate.hw);
>
> You are not changing anything here.

The scope of patch is supposed not to change the current behaviour :-)

> But we shouldn't be devm'ing on the
> IIO device. It will get freed eventually, but only when the last
> reference to the iio device has been dropped, which might be long after
> the platform device has been removed. devm'ing should happen on the
> platform_device's device. Might be worth fixing.

Thanks for confirming my suspicions (as I mentioned to Martin, using
an IIO device there feels wrong).
I will add another patch to v3.

-- 
With Best Regards,
Andy Shevchenko
