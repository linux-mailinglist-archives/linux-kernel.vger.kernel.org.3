Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1297949CCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiAZOzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:55:41 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:43826 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbiAZOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:55:34 -0500
Received: by mail-ua1-f49.google.com with SMTP id 2so43372840uax.10;
        Wed, 26 Jan 2022 06:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TH0bFfUTxCFwO035EK2v1qt5dAANLfsGM9lhFwB4w6Y=;
        b=1eTYo29rO1Wd5aSjB5nHbAMI10HNnuUMtGIhME+IKqJ/IJ2Aa/+jadgjS8kcXG38TX
         4JeEMN3XpQiU6tOHPO5SuXDobdlnf5Q2SQ+V9S60L37xgf7/8D92ST3pq7aS/QMcKNNQ
         8wn/dD1P4T7NqhQfNPf3e4v7ZPgz0yPmXKJZMSovjd6NsHTT7NA9mglF+tOyEJRjNDZF
         zHrpoEpMU939axmxZhcvY8i2vYTnYUiNeR+UuNGEoVeBj92ZsBeTJE8ByGEfNIHWCMuv
         NlQxOQQOmUWqBJoqyggohUaQ4RZYL12+6V1bsZQZZwjZuzFEQTi6O548GQ0OsN3fKrC2
         pd0A==
X-Gm-Message-State: AOAM532bIgmm/PMhXa9/ZEuX93kpbDkKN91Ar97o/YugnOqzeJ1YRIv9
        K0SxCyxbfw2Cd7zP5vcWLgkXXh20UUOKdbnS
X-Google-Smtp-Source: ABdhPJzDucwm/Y9p5URnV3rkG3ftCUPu/eOEEfv9niRN8IE1EttuM99A+wViW2hrK9cwXt+hg8jHDQ==
X-Received: by 2002:a9f:2a8b:: with SMTP id z11mr9411221uai.47.1643208933475;
        Wed, 26 Jan 2022 06:55:33 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id e1sm983356vsh.19.2022.01.26.06.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 06:55:33 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id w21so43280313uan.7;
        Wed, 26 Jan 2022 06:55:33 -0800 (PST)
X-Received: by 2002:a67:b009:: with SMTP id z9mr6352633vse.57.1643208932830;
 Wed, 26 Jan 2022 06:55:32 -0800 (PST)
MIME-Version: 1.0
References: <20220112205205.4082026-1-nikita.yoush@cogentembedded.com>
In-Reply-To: <20220112205205.4082026-1-nikita.yoush@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 15:55:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU0h+VaAbwOqJE5YRK2f69H8JrVgtXsoYNwvNgGJKH7mQ@mail.gmail.com>
Message-ID: <CAMuHMdU0h+VaAbwOqJE5YRK2f69H8JrVgtXsoYNwvNgGJKH7mQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add 9-asix sensor device
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thanks for your patch!

On Wed, Jan 12, 2022 at 9:52 PM Nikita Yushchenko
<nikita.yoush@cogentembedded.com> wrote:
> This adds nodes for lsm9ds0 sensor installed on the KF board.
>
> With this patch, the sensor data becomes available over iio sysfs
> interface.
>
> Interrupt definition is not added yet, because the interrupt lines of
> lsm9ds0 are pulled to VCC on the board, which implies need for
> active-low configuration. But st_sensors drivers currently can't work
> with active-low interrupts on this chip.

That's unfortunate, as DT describes hardware, not limitations of the
software stack.

> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -66,6 +66,13 @@ hdmi_3v3: regulator-hdmi-3v3 {
>                 regulator-max-microvolt = <3300000>;
>         };
>
> +       accel_3v3: regulator-acc-3v3 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "accel-3v3";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +       };
> +
>         hdmi1-out {
>                 compatible = "hdmi-connector";
>                 type = "a";
> @@ -208,6 +215,22 @@ pcm3168a_endpoint_c: endpoint {
>                                         };
>                                 };
>                         };
> +
> +                       lsm9ds0_acc_mag@1d {

Please use standard node names: accelerometer@1d?

> +                               compatible = "st,lsm9ds0-imu";
> +                               reg = <0x1d>;
> +
> +                               vdd-supply = <&accel_3v3>;
> +                               vddio-supply = <&accel_3v3>;

According to the bindings, the supplies are not required, so you can
leave them out? Or are the bindings wrong?
(The bindings also say "interrupts: maxItems 2", while the "interrupts:
 description" says up to three interrupts, doh...)

> +                       };
> +
> +                       lsm9ds0_gyro@6b {

gyroscope@6b?

> +                               compatible = "st,lsm9ds0-gyro";
> +                               reg = <0x6b>;
> +
> +                               vdd-supply = <&accel_3v3>;
> +                               vddio-supply = <&accel_3v3>;
> +                       };
>                 };
>         };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
