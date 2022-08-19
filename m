Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4B59A830
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiHSWPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiHSWPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:15:35 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33096BD167;
        Fri, 19 Aug 2022 15:15:34 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l5so4352404qtv.4;
        Fri, 19 Aug 2022 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=y3tRP3OmOA1Mjqr7eOREwc8KRFICb1q32OjHDh4TJsM=;
        b=jEbPEh9s+cumm1o0L0BA2XOMeUeW80GbpqgaY/cplSKb4S2rWsXib17UTbtpI89SES
         clIH8MPKOmVBV9g14gnrN/p/JJOqJmqBWfcllwDRc4H0HIyCD6d82g98SZpKUYro86Qs
         BpbR+rbl6fJa4E1IFCE8MGtu9ug++tsqPqt7qzHRQgd/CBuUSES+wSSQl2GuERMa9GtZ
         XGz1cdtDMYbR5K0IniawLICMdw1lsBjsRaoXOLGg03b2T3PkrQONZhLeuZhGEXCqQFtz
         JUG4pG9hbGeyhlwycjsgo6R2yI6UvJflAgKbVPzz9JaqYhQxbbM5Zx1kRJVEn7uTJ1zV
         iYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=y3tRP3OmOA1Mjqr7eOREwc8KRFICb1q32OjHDh4TJsM=;
        b=2S+8JTIjwapBRu4nnd57VouFdAP7c0Rg5bO3EzawpbBdbg5XnRkEWUiROhTAKsy6DE
         6Gu3v5pC+XjWrr/FyYTuGasjT6Prd7Z7uDvpN9+JcQYSg+aCQjTKKFnEY1r+b9K1Y7Y3
         hfGGZyVyZjaHebLtqWJPptT/PYYVy5s6WHqaYT9FDRO30TCNtgdoa16qGQF5y5H5rP+Y
         BpvFuP0z1zfCVl8b17CRAprV5aRa17EUXEY/W98DAp6IoqC15aWeSb7qg1Rm/Bsjke+g
         lo3TQlt2B8373+VT4YF45bNE1xyprIacx4IG4KwjpRJxTLngHWPaAGWRwsDruE6WGrsn
         /Yhw==
X-Gm-Message-State: ACgBeo03HDTtxTzq9ZvKR4dNJpBOO0oUj0wxM59bqJaGLb/P3HtauvGr
        +KISX0bgRBkRQwAvP3E9Kn0DyA7JBXFB7chRjlg=
X-Google-Smtp-Source: AA6agR6kyM1K854TsJ/Upt+Nc9BCXWYDX0voNN2Pffr5Q1TJbgolnPk6YUuSu6jd42ppIKjW5hZQjddgMNNm0iHm/08=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr6740137qtx.61.1660947333248; Fri, 19
 Aug 2022 15:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220815091929.130547-1-brgl@bgdev.pl>
In-Reply-To: <20220815091929.130547-1-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 01:14:57 +0300
Message-ID: <CAHp75Vc3dazcM1MLzjzPUmgMGNACUsOZ8aK4uauAJk0hzj9q-w@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: use devres for the clock struct
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>, Yuan Can <yuancan@huawei.com>
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

On Mon, Aug 15, 2022 at 12:26 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> The clock is never released after probe(). Use devres to not leak
> resources.

...

> -       clk = clk_get(&pdev->dev, NULL);
> +       clk = devm_clk_get_enabled(&pdev->dev, NULL);
>         if (IS_ERR(clk)) {
>                 dev_err(&pdev->dev, "Error %ld to get gpio clock\n",
>                         PTR_ERR(clk));
>                 return PTR_ERR(clk);

Shouldn't we fix a potential log saturation issue first (by switching
to use dev_err_probe() helper)?

>         }

-- 
With Best Regards,
Andy Shevchenko
