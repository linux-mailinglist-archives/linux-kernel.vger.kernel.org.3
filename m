Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8851D6E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391441AbiEFLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387003AbiEFLpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:45:15 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FB560D84
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:41:32 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f7ca2ce255so78032467b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l0caGRAl6tw98ep9A0EoSsPJFbAnWVPHA21Iq4Niy6I=;
        b=SmlsDeNuaHifgGa++k4eP2Y4cdx/p/7EZIENJ+7s92pwcvF2WjC3gxgdsF54R5R5DC
         4PH4Ea/RXCuBKQE7XpREllSwlcRgOF8zh6Mq2T8oFE7nkIJkmgaxbgo0tcPsqfbw8sIY
         cqqw8+SzX/McYAnngsSqWYYMUKuAfyaXUfjnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l0caGRAl6tw98ep9A0EoSsPJFbAnWVPHA21Iq4Niy6I=;
        b=bq5B/D3OwDxv2uW2WHm/eGztpBQ1tlNewk/zU8K5ourDxMaBBwSsM0KuTl1rVpX0Z0
         PMl8S+tC/DZKGPAgqwAJ2PII9s6eyjuprc4JLl0PiujkXLqhji+7AasUnH4uaKMTOqCK
         2jsZ1riJUzFglEpwkEEyVFkUEMS6cl/NkHGXZLsVALKwOG9zpkzwxzBL4aWdkY1DmUNn
         gtRpkbzKRzKBAtRrgw0K2/AIJ7xJyboypoj8xE95wfjjb3utJ3s2KKDD1k7aJDPbbrTd
         kaN5ScGWXlKMZq9C2V92uS5PruP+EvpNh9Er0mv1jTFKE9PGJazL5lSFS9NAed7vzv18
         VfEA==
X-Gm-Message-State: AOAM531I4qoX1pV4Zh3eF0uj6VRF1OWGUE8irTnkGHK/fC08TWSLU06m
        uzX1Dc+1j2TRlRpW/iy+1r8I2n18W65ZwDomayRYbw==
X-Google-Smtp-Source: ABdhPJzbQ+rVlJvom3mfGzvQGXbWH7u6TQrd+Edczzu9Qcicwk8aE3ctLPVfCmRvvhVM+kMa2a1e2gMRNjVctbIkgO4=
X-Received: by 2002:a05:690c:110:b0:2ec:2d79:eee1 with SMTP id
 bd16-20020a05690c011000b002ec2d79eee1mr2266620ywb.21.1651837290727; Fri, 06
 May 2022 04:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220505194550.3094656-1-nfraprado@collabora.com>
In-Reply-To: <20220505194550.3094656-1-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 6 May 2022 19:41:19 +0800
Message-ID: <CAGXv+5Hk2u+1zkVjNEt7wdwAJyoB+-PMAuh7UKWEkDeYxp5zUQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Introduce support for MediaTek MT8192 Google Chromebooks
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Maxim Kutnij <gtk3@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 3:46 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
>
> This series introduces Devicetrees for the MT8192-based Asurada platform
> as well as Asurada Spherion and Asurada Hayato boards.
>
> Support for the boards is added to the extent that is currently enabled
> in the mt8192.dtsi, as to not add any dependencies to this series.
>
> Besides the other dt-binding fixes already on linux-next to avoid new
> warnings by this series, [1] is already merged but not on next yet.
>
> This series was peer-reviewed internally before submission.
>
> [1] https://lore.kernel.org/all/20220429201325.2205799-1-nfraprado@collab=
ora.com/
>
> v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabo=
ra.com/
>
> Changes in v2:
> - Added patches 1-2 for Mediatek board dt-bindings
> - Added patches 13-16 enabling hardware for Asurada that has since been
>   enabled on mt8192.dtsi
>
> N=C3=ADcolas F. R. A. Prado (16):
>   dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-spherion
>   dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-hayato
>   arm64: dts: mediatek: Introduce MT8192-based Asurada board family
>   arm64: dts: mediatek: asurada: Document GPIO names
>   arm64: dts: mediatek: asurada: Add system-wide power supplies
>   arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
>   arm64: dts: mediatek: asurada: Add ChromeOS EC
>   arm64: dts: mediatek: asurada: Add keyboard mapping for the top row
>   arm64: dts: mediatek: asurada: Add Cr50 TPM
>   arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
>   arm64: dts: mediatek: asurada: Add I2C touchscreen
>   arm64: dts: mediatek: spherion: Add keyboard backlight
>   arm64: dts: mediatek: asurada: Enable XHCI
>   arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
>   arm64: dts: mediatek: asurada: Add MT6359 PMIC
>   arm64: dts: mediatek: asurada: Add SPMI regulators

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

I tested all the external peripherals, including touchpad, touchscreen,
keyboard (which needs a fix), USB, WiFi on both models, and the keyboard
backlight and (USB-based) Bluetooth on Spherion.

Could you also enable the SCP? Otherwise the vcodec generates big warnings
when it probes.

And also would like to see MMC. :)


Thanks
ChenYu
