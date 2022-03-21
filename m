Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC84E225E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiCUIo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbiCUIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:44:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D978CD95;
        Mon, 21 Mar 2022 01:43:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h13so16944932ede.5;
        Mon, 21 Mar 2022 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc0R1Y6JS6B1hLN+ckj3xVfEy5Qs/cD0pZ/QidEGHTI=;
        b=ijeogGnXfrmhhtDBoTsX8HuPqwl8EUCg2SEdYUzxrQfpXmbo+FJy0FTii1SWVanejo
         DezuSf8kz0LaaVUJYnj520KAi8T2+/5LhW8ptyA8j1Yh+9xsTemB4UzOpEidHccTl0H8
         miax7F/8atD3aQL9oGYG+IqL/G7sxntmG6At8UNoepOhTT1X4yZmtaSBpvjtBsniIdkQ
         Hpvdmtv4+h+r4uX5LoHIlxWgGk7WXniwDytE5e2dBKvBS9yrofzmPxBkDQAJ2z2+vryL
         whsV36KYYrbdXF0SI90s/PdYfjog4S+jG9qYB3icQE5vsrdNlmMRghOgfd4vpmapCDhX
         cMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc0R1Y6JS6B1hLN+ckj3xVfEy5Qs/cD0pZ/QidEGHTI=;
        b=4fuN3Bt2EhTwMwtiSuBDiOlxbKt96oe0QS0XPByrnx7n6hDoY7DoyvtSi0fuMe/GTw
         OgyRYsm9sS6wUdqdRJCmciIub8iVBr4b54mg4uDq6nhQDJCr2quCdR4rPEyTQ2ydhnwv
         zUqJc2JgUeFJlprr1npSF73V0ibhdBOOJFNvf59xXGo9+CBcrKnjhtVtPVGawa4aFuux
         Mrb/g+//phRGQ922C4ziRUp/Sf0VgLz+t0Qc5a8Th3D2INdAsLXteBMSqgTBAeaT1Kcc
         pEtXvoZWF0JTNUOn6h5IAI5aslYx2wPyDmqETGlBnC71U2i/mXMRwrvECGGcRQsuCzMN
         dzYQ==
X-Gm-Message-State: AOAM53212i4GXmK9gr8KSNCDFjrVq1ItX1ppaSEfthkbQ0WZN5j2WDsu
        a1K7gRklZkjl5t9/RA2giF1M1MoCqQvHa3OqL/MilSPBCOM=
X-Google-Smtp-Source: ABdhPJxT971muxfFm8Ki8jh+Sc9Hsirwi6LKUYRRKequQo0JzJALUsM8RvG3beGXqJMOpJ0WUUHZ2+Y2l/hoPga9YN0=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr21659318edu.29.1647852210010; Mon, 21
 Mar 2022 01:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220319181023.8090-1-jagathjog1996@gmail.com> <20220319181023.8090-5-jagathjog1996@gmail.com>
In-Reply-To: <20220319181023.8090-5-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 10:42:19 +0200
Message-ID: <CAHp75Ve9cJ9+UuimxD33h-2oDz0ESx640=-0rPbjnk0AVvFfeQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] iio: accel: bma400: Add separate channel for step counter
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added channel for step counter which can be enable or disable
> through the sysfs interface.

...

> +       u32 steps_raw;

I would expect this to be u8 ...[3].

...

> +                       ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
> +                                              &steps_raw, 3 * sizeof(u8));

sizeof(&steps_raw);

...

> +                       *val = steps_raw & 0x00FFFFFF;

And here it seems to be be24_to_cpu() like Jonathan mentioned,


-- 
With Best Regards,
Andy Shevchenko
