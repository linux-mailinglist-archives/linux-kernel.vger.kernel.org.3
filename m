Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833D567760
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiGETJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiGETJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:09:18 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBA192A5;
        Tue,  5 Jul 2022 12:09:18 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31c89653790so67679567b3.13;
        Tue, 05 Jul 2022 12:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JqswLzQoEZSVIsyrrNllZL3s3TIO12Xjun48MdZI0E=;
        b=gi/sFeS2eMdWLZs8tiRHbeK/9Nervr/F59eQ+APtEUo46EbwlWiMcR13wx5Qif1SjM
         4Ef4Ulb7R7GVhki7qaK2AbeN52Mq3LwKKvmRcm2OcZVqVyFid7i6vN/kmip90IchC39p
         20jd1cNM+bNsR0hNPjlI9W0naVnLWibkv+8SauIP/E0HnNVMM0mCKUPlt+EbzcK/KR6Z
         +sEu/KwbEGYIs25f505TBPHxoF27OW8NchP6THlXpT9l1eYYGQWhs9Q+7G3NyGDvDRKk
         EHMAUDj6au1JBpXJpVqvn1PLa51fLxICh1q4mm9gZODkJ6p+YcIKgWMNG8XoAoHxeGjN
         pZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JqswLzQoEZSVIsyrrNllZL3s3TIO12Xjun48MdZI0E=;
        b=xXQJ73zvPaj/Jpw0Per7uBFXuAUHnTJ6PPEQYGk6bZrTQwN6GX0Cz0a/MXG0W4zALQ
         k4GXHTM+cN1j3VuAIebYPDfBCeNWNFSzCxyH2ZEweLQdPE7Kv1AHZ6nMdqZzHdPQqdsU
         Nm0PrAilcgXhIN4LAZx7ej3KAaOjCdd/VTIdnk3CASaBAi9q2wwJ4Md01Iu2RvyNX/4Q
         6j+qOpa+SkmLPO23rW0k6tkSj4QrynvLgWsErK+NH4xG6WBJQpPnY/mezQJ3A9A9oWK2
         qAzloKW1GgPaREiMmDrkeXi6z2JXIMqOZw4hUQMwhcfI9OBBLdN47YzQ/atIkih6v13d
         cwwg==
X-Gm-Message-State: AJIora/fC7WKyOX6EWvkjQl2JhUwELFnzvqQLqkM/uc3Dhx6p6PubjYt
        /xsMjwwUx5t20Oaxo4qYLDDNJtjOoYYUeJ4mKQdDHHYgMVtIUQ==
X-Google-Smtp-Source: AGRyM1u3CvRvgwTnQkvKEiDUYmXUwhZCsPABDwImaEbD96LCU8xzeI8v1bvDUnuqeteOchw9ywL//d9KMtXvR0lbDrU=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr16030827ywa.131.1657048157460; Tue, 05
 Jul 2022 12:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <1657038252-31360-1-git-send-email-u0084500@gmail.com> <1657038252-31360-3-git-send-email-u0084500@gmail.com>
In-Reply-To: <1657038252-31360-3-git-send-email-u0084500@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 21:08:40 +0200
Message-ID: <CAHp75VeV6vByZXGLraLes+94Rfs23ZjPXGaXzUf-YY=sb_1=2Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add rtq6056 support
To:     cy_huang <u0084500@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Tue, Jul 5, 2022 at 6:31 PM cy_huang <u0084500@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add Richtek rtq6056 supporting.
>
> It can be used for the system to monitor load current and power with 16-bit
> resolution.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Since you sent a new version:
I said explicitly that the kernel version mustn't be not stable nor developing.

...

> +KernelVersion: 5.15.31

^^^ Wrong

-- 
With Best Regards,
Andy Shevchenko
