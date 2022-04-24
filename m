Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28A850D4DD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiDXTjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiDXTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:39:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3932EF8;
        Sun, 24 Apr 2022 12:36:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p18so11004181edr.7;
        Sun, 24 Apr 2022 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVOHIop480qd4Gr/LYjCSPrgKYLop4lt8wSVfH5qvF0=;
        b=TrUTwR7kbvxcWabpO31VkDST1D26rIHkqeg351cvGg9gtptLAvDealNIt/RGogS5Bh
         d3EhuP5daLZq54Bt2ZPHUdF8SzNbv8BpALtrktPx7wkDMRJQlRXMiNhXiFSeoUAl8OfZ
         1692tOWuiNTLpovvo90VfOT7jQhOslWy8QQgCeFjZjQMRsFbhtyfwxFDwlV6Pe5I+5DX
         c9r6RZaZspORLPC/LRc4aq7gs0cvaGENDsFdNreWwn9U/d+nvF2WV5lrJEjNP2gOYaPW
         Ip8nOiM1SEWXQYSyOTojv/vDxnovsZdX/g5N4uaUqPTkCDgWfIhyHrzo+kLD0AfkQdrD
         OHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVOHIop480qd4Gr/LYjCSPrgKYLop4lt8wSVfH5qvF0=;
        b=d/kx7aL5GbVR7VW6cw+p5APdYTU7uRNJN/0VKSbRftyBOyBINtClJA0AH19NhCljhu
         kWRl+a9NaF6vFwetuaEY0LcHZfE6oDBaTfVpw+niziaRW6xz1Y7W6PLSgpZY0+gH6Yif
         ZnR558PG6cpuehkGiGzFlvXTbVrGj7AAHqopUygY6ZnTFB9kj3WhfsQx2VQo/w4QbLg4
         HxKaYb85Ik68GJSQLJ0nDd/uCMTcd/iMQDkNDbi54qrTTCfyrlQSLrc6icrBsxlFqyKI
         IlAR9ivOD0kfUBzo/WrvfbEafb/f7UDEpBX7g1DBYPW6Zr8QWqA7Y7pxJLStAKB7g7T9
         VleA==
X-Gm-Message-State: AOAM533/JQCuJzDLfmn/XXQrJ8mU0fqszd885cSQiwEPS5f3SpeXAmS0
        hfgSx8+0RjB4uKkxsqcAaE0uIQbVWlVtmNpgo9g=
X-Google-Smtp-Source: ABdhPJzEKN5IOZJlCldmBtOqeOCM2SeHaSYlmVF6btock30J6RluGq7St0OGRGpWdKOxzf5CvxRmm8BGyY/Ea+Dz7/o=
X-Received: by 2002:a50:ed0e:0:b0:425:e476:f4ed with SMTP id
 j14-20020a50ed0e000000b00425e476f4edmr2696289eds.32.1650828983747; Sun, 24
 Apr 2022 12:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FE734C50BC851F2AB5FE1380F833A7E67A0A@qq.com>
 <CAFBinCC=Dp4bXT9sbmT=ZTiVfC1Mj=oRVxeDXfKbDczq45iekQ@mail.gmail.com> <20220423022541.B12F3C385A0@smtp.kernel.org>
In-Reply-To: <20220423022541.B12F3C385A0@smtp.kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 24 Apr 2022 21:36:12 +0200
Message-ID: <CAFBinCB+o1vBECV+q_VnDx8yZW_wg4yQ7d5m68B_iwPO+RzUbQ@mail.gmail.com>
Subject: Re: [PATCH] clk: meson: meson8b: fix a memory leak in meson8b_clkc_init_common()
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     xkernel.wang@foxmail.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, mturquette@baylibre.com,
        khilman@baylibre.com, p.zabel@pengutronix.de,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sat, Apr 23, 2022 at 4:25 AM Stephen Boyd <sboyd@kernel.org> wrote:
[...]
> > Also a note about meson8b_clkc_init_common() itself: failures in that
> > function will result in a non-working system.
> > If we can't register the reset controller then most devices won't
> > probe and CPU SMP cannot work.
> > If registering any clock or the clock controller doesn't work then the
> > system also won't work as clocks are not available to other drivers.
> > So freeing memory in case of an error is good to have, but the end
> > result is still the same: the system won't work.
> >
>
> Can we get far enough to record this fact into either a pstore ramoops
> location or the serial console? That would be ideal to make debugging
> early problems easier.
earlycon shows these messages (as it's enabled by the bootloader)
while "normal" serial console won't come up without the corresponding
clocks.
I never tried ramoops but I expect it to be able to log these errors as well.


Best regards,
Martin
