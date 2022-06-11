Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9312C5475AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiFKOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbiFKOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:37:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9B5F38;
        Sat, 11 Jun 2022 07:37:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x17so1940419wrg.6;
        Sat, 11 Jun 2022 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=U+7z+8/xgg10xWxRPhbi3WGpQiB60QSiW36x8QTx7jE=;
        b=WIV7Zq0uf/A7eE0Z5CJ/uTQdRV0m1t1HeFitWTM1hz7Y/hA8sCH/R/cR2SbSMaKij4
         Hn7SyX7OJTnJdM7NQtWP0PgSEVikgB5HtGrjKSruHFvBIkSnxllC4ixWWvzQ9w4k6JjP
         ZlFSfTebRCHmRSTBJlcQeqgsDoiZj64HuTJXv/GEVoIk8rVwkcF80659MTv//v4kR96g
         IxRJ8JOYa1GFFXGSE2ivD3DhKupKCbnGKjkXJF1dwqiY8EswO7aafUL2viuFO1q/L1A7
         GxFlqCwnWBB7MZ6PkqDLUbXcnriweJ/AY+SrM/MPU/XOUop30u5IrnDyprM21Vs9mkgH
         fekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=U+7z+8/xgg10xWxRPhbi3WGpQiB60QSiW36x8QTx7jE=;
        b=VvsrSPjtzUATceH8ekJPEh1VAUBkwob6stfItc8T3UtI1b0aEcOaOrArrrpU7MhlKW
         PyUhZ3jdnSmEXZ87v1EWk01DTV9RXExClLXILSi4ElVK6XwvdnPSD7id97Fy2hutBsk5
         NYXUCpIiGuYjm7RYr1noD3HeBzkEcLnQtg5Y53DMOJ8tXyBmdSwFbXSrQeppnYn++p39
         tnpcmQjPD+A2S+WIFjbQQwM7tcPvKExnBBwY/NElv3nrPsFSWq9NvEQuzdKtteXmvLCU
         oVRzAYuxV69TphTakbeR0e68GbKMM+om2bpdccnz/90WmqyJKlx157fs0Nw7YG+ohx1E
         mcUg==
X-Gm-Message-State: AOAM533apizcBndAPlm0MBPeF3WAHSwZuPuDwj7ggdLDTE8eEpYjvwfP
        UrDvxjekWKGFFLjyGy5UXZw=
X-Google-Smtp-Source: ABdhPJzkFiboyg49EPAhvRTWwUCyjNTM/CCfAb5+uvxv+KgZjk60A8KIOfJE79iRGqtzv4et9jAU6Q==
X-Received: by 2002:a05:6000:1acf:b0:218:5a30:9067 with SMTP id i15-20020a0560001acf00b002185a309067mr21253301wry.48.1654958259463;
        Sat, 11 Jun 2022 07:37:39 -0700 (PDT)
Received: from localhost (92.40.203.210.threembb.co.uk. [92.40.203.210])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b00397342bcfb7sm2628648wmf.46.2022.06.11.07.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 07:37:38 -0700 (PDT)
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-2-aidanmacdonald.0x0@gmail.com>
 <20220609163920.GA7420@quicinc.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 01/17] regmap-irq: Use sub_irq_reg() to calculate
 unmask register address
Date:   Sat, 11 Jun 2022 15:32:22 +0100
In-reply-to: <20220609163920.GA7420@quicinc.com>
Message-ID: <V6MQEsBelMvjoBF1C6KDbaHcQIWzvqhC@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Guru Das Srinagesh <quic_gurus@quicinc.com> writes:

> On Tue, Jun 07, 2022 at 04:53:08PM +0100, Aidan MacDonald wrote:
>> Call sub_irq_reg() instead of calculating the offset of the register
>> to avoid relying on the fact that sub_irq_reg() is a linear function.
>
> Seems like unmask_reg is the only register whose address is not calculated
> using sub_irq_reg(). Switching to using sub_irq_reg() will bring it in line
> with the other calculations.
>
> Could you please incorporate this info in your commit message as well? This
> should be the rationale for this change; that it allows for the get_irq_reg()
> patch should be secondary.

I'll note that in v3, thanks.

>
> The change seems okay to me, but I'd ideally like someone to pick this up and
> test it out just to make sure it doesn't break existing behaviour for them.
>
> Thank you.
>
> Guru Das.
