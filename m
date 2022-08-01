Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6C5866BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiHAJPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiHAJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:15:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ADC1DA43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:15:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kb8so4600409ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nB0ZRcjHZMk2tgYdKDIpiNEK8D7kZup7/hRGKDPsck4=;
        b=TbF5k8lyU8bYSJIOuZfc6dx3Pu2cpOLaSdtPvHDtFTEGT1CpqKn5DYiTKT6YjXrbKa
         pGP3AEGJSE59P+Tj6IxfhCLBkb75gBAyOXdEoMu8Uz9snItXHj05Bw/RkjDlcs4HApj7
         /5+Pj0fLBpIfOQnm7ZT//8mWu1EAhkj9WP20V7Tf1wixsGdfiNvbYokNwL9GtKu1XzAk
         CBkVoh2fCOgB6gniZH2xIcKxiv5KXGVJ54irhasRjnP9ucIOdmUkrwQLfhs6KkylN2Rw
         hwgumJxPaiUKuiXVCHByZNqOmWe1bQOqK4Sa1mIvPAW8RBXneUoEN8ImnRpu7cY2an0V
         RYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nB0ZRcjHZMk2tgYdKDIpiNEK8D7kZup7/hRGKDPsck4=;
        b=yFNhi91vVphG2e95fECECSoGNs1cjs8xTiOPCdlwdtyzjGaPyiPhjBDCVn58A4Eekw
         Ga6WjAUwj/BZ8dDyg29wFn3M9aR6wvlA6xPLKbIHXdgViuVQNECHrIwLTTal7AMtvrMj
         Ux84b+LCziusAZpD1RErgkHf3zZ/dBdfe9FMyTYOD0PZI0nKFgaXm4Ve/oDJIeM7bHEb
         MHi8T3MfO8ePGuX0KsiZocWcakoYUlLD0ZQR8rXugXrcRe4XJ8SMf/OICQMyEruqlIg9
         iU6xHvOLoQKsqXnRdKc7upqxQI8Gok59lVO8F8CO3OlkptVLe5J44t25fTY9v9fz/DXq
         aKvQ==
X-Gm-Message-State: AJIora984Geh+HXDWwT+at4tJpad5YCcWNKFAGwQnjh3LY1KWxwdJvXO
        zmy4x6GIjNkXcmHgoYZ06PrQ9dGwwKwVXeBtTiM=
X-Google-Smtp-Source: AGRyM1tdqEZNvEHN17gL0IdChWTy1N9Y3rhfLEmxfsEOT1JID0/U8cF+R1tUlSDF+kQdnPrj2/EPqtjLnReIkf5/h48=
X-Received: by 2002:a17:907:c06:b0:701:eb60:ded with SMTP id
 ga6-20020a1709070c0600b00701eb600dedmr12205508ejc.178.1659345303440; Mon, 01
 Aug 2022 02:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com> <9b9abdf0-7cd5-df51-adbf-2225291f0dd2@redhat.com>
In-Reply-To: <9b9abdf0-7cd5-df51-adbf-2225291f0dd2@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Aug 2022 11:14:26 +0200
Message-ID: <CAHp75VduSG=BerPJo9phXJKWa-yu_uXbP+ifkax=3FUTE7et+Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mfd: intel_soc_pmic: Fix an error handling path
 in intel_soc_pmic_i2c_probe()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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

On Mon, Aug 1, 2022 at 10:43 AM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/31/22 22:12, Andy Shevchenko wrote:

...

> >  err_del_irq_chip:
> > +     pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
> >       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> >       return ret;
>
> Note alternatively we could just move the pwm_add_table() to just before the "return 0",
> there is no strict ordering between adding the mfd devices and the pwm_add_table()
> (the pwm device only becomes available after the pwm-driver has bound to the mfd
> instantiated platform device which happens later).
>
> IMHO that would be a bit cleaner.

Good suggestion!

Since I need to send a v3 anyway, I will fix this accordingly.

-- 
With Best Regards,
Andy Shevchenko
