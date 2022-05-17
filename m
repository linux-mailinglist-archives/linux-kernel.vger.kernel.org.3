Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B385A52AB27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352330AbiEQSpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243849AbiEQSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:45:20 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38410FE8;
        Tue, 17 May 2022 11:45:19 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id i15so3340573ilk.5;
        Tue, 17 May 2022 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Y+qkluu9VKepyBlMDfrx+r7tkG/mdYwtfblWpe2z9Y=;
        b=l01OyNeB/A6Q+vxByyTAVu9qpdFA+aYn0Vst3ljF3PdrG+pxPeaVtNZoGSu7FLkowE
         Yv0cCkilWvXuTPTKNaduH7p2F3IXPEF+IpKomUf2I3XNmR82SeOU9cIUja0gC2qsWXLR
         siDaHE4Ysl4MQ5igmKCslQMAPvYKAl/Mw0TslVwfWwH5KOSQU5iDbM6agJBoVx/sBd2g
         Byhqm2GjIY2MTlWkZlPk7kfyjL7mUFtvUzpNAyiNayWscrlKwGOOZ/IrH4IxOWY/6HHk
         5rwiOFR9ninFTSDwXx5K33CyeZwCX3VBFVaHGdAcTNi7+iUZr2dt/OjisLAQqT+r6apD
         JrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Y+qkluu9VKepyBlMDfrx+r7tkG/mdYwtfblWpe2z9Y=;
        b=ivUejRwnZ1QJkYOsK0tbKYn1MVzfopBwkc/MLvX/11bStQvNJyysA3UGB//gcu3VPL
         7d4Sq2TFPwOFlSHEItuWa38ziV7kv358JPym1GAIEC7U/6fIJNPU7z4YmuQtvoACm35x
         hTvP64LEpUxREiOZm1QHky1aVhSB7VOb7RdkisMDbW1tQewJM0fTH3I9Xa0LBDQMZC8G
         UJsutIJu2+CfBQgOCHdhAv6uP0Z1YSykcBq4fNo2c/mZ+y2gAf6lvfoBHCb3L0Ep0ybr
         8rmXLuz9rZB5D9QoCry946alVPLzFnn/QpLA7Ga48ZQvUt2rfX8MmELm0JJf2xhVzR2v
         Je6Q==
X-Gm-Message-State: AOAM532asPJ7tglwgCG2+LGG4oHM2RK+96yAcwcuXF2xaOH8N2A8sp0m
        KXd19fdH0mXz/akX7kBKJnxL/9NTuRyJvDdwvy4=
X-Google-Smtp-Source: ABdhPJzwZftXXY/3Ig3lS+yWjDaVrpZMGecxql4yV/QR4m8oYDw3NDhTzg479ocUa4qwGUyh5cDXiEz4Kdn33DnzV6Q=
X-Received: by 2002:a05:6e02:188a:b0:2cf:7adc:7a86 with SMTP id
 o10-20020a056e02188a00b002cf7adc7a86mr12780302ilu.276.1652813119437; Tue, 17
 May 2022 11:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220515064126.1424-1-linux.amoon@gmail.com> <20220515064126.1424-7-linux.amoon@gmail.com>
 <79b727f8-0631-5a96-fbc6-6e5d637bab7d@linaro.org>
In-Reply-To: <79b727f8-0631-5a96-fbc6-6e5d637bab7d@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 May 2022 00:15:04 +0530
Message-ID: <CANAwSgSY=4zOLjw22GN+a7cc5j=myWWkD7gEQ4_3sgEaTS74Rw@mail.gmail.com>
Subject: Re: [PATCHv2 6/6] thermal: exynos: Add runtime power management for tmu
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
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

Hi Krzysztof,

On Sun, 15 May 2022 at 15:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/05/2022 08:41, Anand Moon wrote:
> > Add runtime power management for exynos thermal driver.
>
> First of all - why? Second, I do not see it being added. Where are the
> runtime callbacks?
>

To control runtime control PMU, did I miss something?
I looked into imx thermal driver # drivers/thermal/imx_thermal.c
to enable run-time power management for exynos driver.

>
> Best regards,
> Krzysztof

Thanks & Regards


-Anand
