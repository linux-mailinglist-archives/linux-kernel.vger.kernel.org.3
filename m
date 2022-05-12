Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880805253BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357094AbiELRdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242790AbiELRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:33:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ACD17493E;
        Thu, 12 May 2022 10:33:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d6so7122576ede.8;
        Thu, 12 May 2022 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GwikIGBuK4bG81kkPIa+hRmyKQvA3ptrXi1rwLFeHc=;
        b=ZAaRdEGDaRO/NW2yXe77gSq0dF7apEh5WRdov42BEAPy8bhDXLKxWP9tzl2J/nYgn3
         pYtRLfAHQeUZekK3Td3knEib+nTPgzy6Rc9AWMGWmCNrJxaTKTKhdbqh1sZuqul1HeIe
         N3tPU5pz7DZ2wThGTb48QonK1TkrKpb0oQ/FtK66d2kizyCgXCUmH/L6MnoSHBvkUtuZ
         D3er1GvyobJbydd9z7FfvxNN9H4mJjpuqePm4XPImgc985lhE1ilZBa0dtOg+tw3iLkK
         T8TP/iX8XA7BlYgHRlBP957aDnP8ENLsb+pind6juwDYzJMpUrFt2N1xtg/qdql9HasI
         j7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GwikIGBuK4bG81kkPIa+hRmyKQvA3ptrXi1rwLFeHc=;
        b=ld9ZtWPZyjRCEIR3SYCRvMuzkFBlB88kQjta/QDjBePqB58rfLLed9J7k/v/mNDfQl
         TZTL+L5kPneuBPA8x6qIs0qZga1Exy69PmDvjdvf5FgMxj5dLOcRzPphN1zWdcQpf1oK
         yNcU+c5NsgCEFXrFfb+tqAq4GyEUlzpiqWsmF15nsvVFlJxxjLDmeomlH0hSVwJ8GErn
         Q2SPsiVwAQjHhMNCuGPKLvbX9b0Hi22xWyednyXA84miMZEdVCN4LOTJLOFFdqqnUd3A
         O/4ff7DyEVKQ/Z2ZTBhbwBnscXYchELUWBF+ypyRyiyu0K1QL4SeVJA0eMuvU3+89F1f
         s1Ow==
X-Gm-Message-State: AOAM530IkqX2ptADeZLC1gy/lSxIx0x/G/gs/tf+YCq4O+iKRePD+zWI
        RZ9ytIMnzAzry0/I/pmADffbAQBecPhUamrGzXo=
X-Google-Smtp-Source: ABdhPJwQ1NcNzQ1+PUh2OZhu8eeOg+1zJPw/V6LLJtk/hQI58fNE6iljtevdytja6TV4O8RxNrkZSIji4ImpvFh2qhg=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr37092088edm.122.1652376796281; Thu, 12
 May 2022 10:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220512160312.3880433-1-Qing-wu.Li@leica-geosystems.com.cn> <20220512160312.3880433-5-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220512160312.3880433-5-Qing-wu.Li@leica-geosystems.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 May 2022 19:32:39 +0200
Message-ID: <CAHp75VdH5qNZ=P_Qg-vy=TgZ==1+b8K4-E_1UL8VKsMeyVm9XA@mail.gmail.com>
Subject: Re: [PATCH V5 4/5] iio: accel: sca3300: Add support for SCL3300
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Melin <tomas.melin@vaisala.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Thu, May 12, 2022 at 6:03 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> Add support for Murata SCL3300, a 3-axis MEMS accelerometer.
> Same as SCA3300, it has the accelerometer and temperature output.

> Datasheet:
> www.murata.com/en-us/products/sensor/inclinometer/overview/lineup/scl3300

Please, make it a proper tag, i.e. put on one line and attach to the
tag block where you currently have a single SoB line.

>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

-- 
With Best Regards,
Andy Shevchenko
