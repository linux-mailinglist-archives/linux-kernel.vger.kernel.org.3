Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF30B583A75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiG1Ijm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiG1Ijd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:39:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C43062A4C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:39:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v5so583951wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:subject:date:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=jIAL/NtinFiIoUs1seDVkZQ5Lk2NmjX9+zgQPi+IvjA=;
        b=igCNHyQ+4L6hHGHtmQg+2CD+K5Lvfdlh+ACqtzyHI+0w3RvK2lZlpDBROkddBN9MaY
         RsVkQtpd2iBAqUrYrvuxJsJcMkolsL+ZY1MFOdQuU4vQd+zBp/vI2sL5UUn/o0khNJnm
         Tr4/ynuvnx3cxODsOm30vkD8XGxrYBipeO2GpFZiq8aE5kjO5hAdh5p8ScJQDEjSiyJY
         lUOgKCpLWfVBzsvUEReXVJ6OwDyOWtoNh71AlIKCOKh2DIdJpw1NRrhEuOnerCgCSBM5
         MZZRz+sXHYM3frimQR/+CoQ7D8PHkDVAkXilylaD+9GXtYkLZaFlaDAqXBsyKcXicvsf
         fVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jIAL/NtinFiIoUs1seDVkZQ5Lk2NmjX9+zgQPi+IvjA=;
        b=VO8hlK4pcRn9xFB5eT5sv9/vPAH/lTQypEk24aJZCrflk+VVSQT8HxzhG4zfb0YyA1
         F/DUQPdJpA/BbfJSuMabyPDB02vrdTvZ8h5SEs3guNsGfdU3SKT3SPGU5V+lbvMCW1Lh
         xjouqpNLsAPi5jXgeF4bUYvoYqTM50LleHMZmP8JTQRSVZ4Wm1qB/C2ekCl1o1R8Ab7G
         jnkjvapJKlgBlQgFcSAXsGWAepH9SAita1m49d3ViAvqnBbxgqB/lP9iiRY5H7e2WfUL
         521CTBcyJsTf+KVkjbQkOuZ5E7Uiw4DxLnE0CjjSJ0GEriq8wQUTOK7/hbJ6/yZJnTrX
         /eWg==
X-Gm-Message-State: AJIora/ZYYY1Kpzk7vwow/NrbMhyqPpWZxPW/oIcn74wkuk6IC1OSqMU
        bqNJqwGuzChzro8wd7RQDWJdnA==
X-Google-Smtp-Source: AGRyM1uM91GvDx6P1GRpKHAV4YFnCfa9JW4xCzK7+51rXTwVChFIWKbdxZIbjGm98XgIPJ4Z2/8p4A==
X-Received: by 2002:a1c:7503:0:b0:3a3:2db1:d37e with SMTP id o3-20020a1c7503000000b003a32db1d37emr5730471wmc.47.1658997570007;
        Thu, 28 Jul 2022 01:39:30 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z16-20020adfe550000000b002185631adf0sm363872wrm.23.2022.07.28.01.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 01:39:29 -0700 (PDT)
References: <20220728054202.6981-1-yu.tu@amlogic.com>
 <1j8rodhfn9.fsf@starbuckisacylon.baylibre.com>
 <032b3c3f-f899-bf53-ecbb-35191d39392b@amlogic.com>
User-agent: mu4e 1.8.6; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V2 0/3] Add S4 SoC clock controller driver
Date:   Thu, 28 Jul 2022 10:27:00 +0200
In-reply-to: <032b3c3f-f899-bf53-ecbb-35191d39392b@amlogic.com>
Message-ID: <1j4jz1hbr5.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 28 Jul 2022 at 16:06, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi JB=EF=BC=8C
>
> On 2022/7/28 15:08, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>=20
>> On Thu 28 Jul 2022 at 13:41, Yu Tu <yu.tu@amlogic.com> wrote:
>>=20
>>> 1. Add clock controller driver for S4 SOC.
>>>
>>> Yu Tu (3):
>>>    dt-bindings: clk: meson: add S4 SoC clock controller bindings
>>>    arm64: dts: meson: add S4 Soc clock controller in DT
>>>    clk: meson: s4: add s4 SoC clock controller driver
>>>
>>> V1 -> V2: Change format as discussed in the email.
>>>
>>> Link:https://lore.kernel.org/linux-amlogic/20220708062757.3662-1-yu.tu@=
amlogic.com/
>>>
>>>   .../bindings/clock/amlogic,gxbb-clkc.txt      |    1 +
>>>   MAINTAINERS                                   |    1 +
>>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   11 +
>>>   drivers/clk/meson/Kconfig                     |   15 +
>>>   drivers/clk/meson/Makefile                    |    1 +
>>>   drivers/clk/meson/s4.c                        | 4732 +++++++++++++++++
>>>   drivers/clk/meson/s4.h                        |  296 ++
>>>   include/dt-bindings/clock/s4-clkc.h           |  146 +
>>>   8 files changed, 5203 insertions(+)
>>>   create mode 100644 drivers/clk/meson/s4.c
>>>   create mode 100644 drivers/clk/meson/s4.h
>>>   create mode 100644 include/dt-bindings/clock/s4-clkc.h
>>>
>>>
>>> base-commit: b293bc9286ee21824e93f0fcfed3b78fdfee01e6
>> Please don't post until you have addressed *ALL* the comments from the
>> previous version.
> The last email asked you to adopt A1 method, but you did not reply?
>
>> At first glance, I can see that this is still a single driver for
>> what is obviously 2 controllers with 2 register spaces. Simple comments
>> like the "<< 2" in the register declaration have not been addressed eith=
er.
> I understand that this should be a controller, just two address
> descriptions. One is the various PLL registers and one is the clock for=20
> the peripherals. And PLL is to provide a clock source for various
> peripheral clocks. So a clock controller is reasonable. I think you got=20
> it wrong.

I don't think I do. This looks exactly like the A1.
The post of that controller are still in the  archive and I am sure your
colleagues can give you the history.

You clearly have register regions providing clock, separated by
0x8000. Claiming that as one big region is bad design.

There has been several remarks about using a big syscon on V1,
unaddressed too.

CCF has everything necessary in place to handle each register region
separately, properly and pass clock around.

You can handle it as a single controller, claiming the two regions
individually but:
# 1 - handling 2 different regmaps in the controller is going to be
      bigger mess than you think
# 2 - I am far from convinced there is any reason to do so


>
> Ok, if you insist on using two clock controllers,, please provide your the
> reason and example code?
>
>> Seeing that, I have not reviewed this version further.
>> I won't until all the comments from v1 are either addressed or answer
>> Regards
>> Jerome
>> .

