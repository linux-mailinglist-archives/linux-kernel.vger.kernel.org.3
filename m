Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACD5AF5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiIFU3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiIFU33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:29:29 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AECBC6A;
        Tue,  6 Sep 2022 13:29:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fg1so3746707ejc.2;
        Tue, 06 Sep 2022 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XVGUqqzM3n2D/4jJV0ZKcJTbVHjL4eVdejQAA4KKYRk=;
        b=H7ZInpF2UhWzzqrCBfmLLea7RMaRc0IsqTMdPjIoCV1dXteLuEZBPlQdCtrM6GRXoR
         z5SBRgeL0CsNRhmwTOlQLCTOluaJwA9GbW9p+eMbx3M4UdIS2eNmqyA9acjEis1earyB
         zdzagIbpXgK4GubL47JJjwenXNMMK2GmLT+RzZTqADNemTR9KVZQV0SnXZFH4uTeUSit
         kF50jBT/hTurNyat3APUOfcRLe8s3tFloDtyzmMKuusTxds7H32K89qYfhzsLsth3+hT
         T+umwiaem8KGg4A7Qgb3pFYsTU3xKRBPr+JyQnwVUCL/dECBqxqIHc07rFvExPTiHVBe
         owxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XVGUqqzM3n2D/4jJV0ZKcJTbVHjL4eVdejQAA4KKYRk=;
        b=xiOBqkm51MrH45GHRZZ4kkErrRuSeBSNgiZLK7iDyBF1fNNFrZ+n0S36WbLcZKT3wU
         qGzRq258ccohVfXWoJZUKbM9Ig+kzETDy8mpefuzfpwp1MUCdlolg29qGH4sq63eLq+l
         9pBIUcKgJO9rBVdm4TiZCrxHPquXXrYr5jm6SuODD6I94ej65tW1nPtBB1FxVfIBcM6h
         vAM1NOPtfW/N2M/eFcNd1IidlHnNPvHl2NeD4VHlyTtxCiXSGB8nK0lT76Ey4Gmz9G85
         6GOYUrfKKtgb5AS9bIy1kOsF8vte/vm+tLXTqKEwY4nU9i/oA0G0fHflCwuClDI3Wm87
         ODRQ==
X-Gm-Message-State: ACgBeo2kohxwCJa5tHJIXSdw1ZOfkjOgUtBaM/AFNse7XZSoLT4PG+yg
        p8MJJ1E07ODYDOSACr59jpY=
X-Google-Smtp-Source: AA6agR5FzHvOY7Bnao9g05Gz0yuvtXm27oREQpQ1b11WFGKhTmMQYjJTsyqae2G6XuQedGzvSAP07A==
X-Received: by 2002:a17:906:ef8c:b0:73d:db10:8825 with SMTP id ze12-20020a170906ef8c00b0073ddb108825mr139433ejb.445.1662496162405;
        Tue, 06 Sep 2022 13:29:22 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id da8-20020a056402176800b004477c582ffdsm5585194edb.80.2022.09.06.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:29:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     wens@csie.org, linux-sunxi@lists.linux.dev,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        samuel@sholland.org
Subject: Re: Re: [PATCH 00/12] riscv: Allwinner D1 platform support
Date:   Tue, 06 Sep 2022 22:29:20 +0200
Message-ID: <7423117.EvYhyI6sBW@kista>
In-Reply-To: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
References: <mhng-d98d3324-5f4b-4cb0-a116-522b124dcdea@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne =C4=8Detrtek, 01. september 2022 ob 20:10:13 CEST je Palmer Dabbelt nap=
isal(a):
> On Sun, 14 Aug 2022 22:08:03 PDT (-0700), samuel@sholland.org wrote:
> > This series adds the Kconfig/defconfig plumbing and devicetrees for a
> > range of Allwinner D1-based boards. Many features are already enabled,
> > including USB, Ethernet, and WiFi.
> >=20
> > The SoC devicetree uses bindings from the following series which have
> > not yet been merged:
> >=20
> > - SRAM controller:
> >   https://lore.kernel.org/lkml/20220815041248.53268-1-samuel@sholland.o=
rg/
> >=20
> > - NVMEM cell bits property change:
> >   https://lore.kernel.org/lkml/20220814173656.11856-1-samuel@sholland.o=
rg/
> >=20
> > - In-package LDO regulators:
> >   https://lore.kernel.org/lkml/20220815043436.20170-1-samuel@sholland.o=
rg/
> >=20
> > All three of these are required to set the correct I/O domain voltages
> > in the pin controller, which I would consider important to have in the
> > initial version of the devicetree.
> >=20
> > The SoC devicetree does contain one small hack to avoid a dependency on
> > the audio codec binding, since that is not ready yet: the codec node
> > uses a bare "simple-mfd", "syscon" compatible.
> >=20
> > Samuel Holland (12):
> >   MAINTAINERS: Match the sun20i family of Allwinner SoCs
> >   dt-bindings: riscv: Add T-HEAD C906 and C910 compatibles
> >   dt-bindings: vendor-prefixes: Add Allwinner D1 board vendors
> >   dt-bindings: riscv: Add Allwinner D1 board compatibles
> >   riscv: Add the Allwinner SoC family Kconfig option
> >   riscv: dts: allwinner: Add the D1 SoC base devicetree
> >   riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
> >   riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
> >   riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
> >   riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
> >   riscv: dts: allwinner: Add ClockworkPi and DevTerm devicetrees
> >   riscv: defconfig: Enable the Allwinner D1 platform and drivers
> > =20
> >  .../devicetree/bindings/riscv/cpus.yaml       |   2 +
> >  .../devicetree/bindings/riscv/sunxi.yaml      |  64 ++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
> >  MAINTAINERS                                   |   2 +-
> >  arch/riscv/Kconfig.socs                       |   9 +
> >  arch/riscv/boot/dts/Makefile                  |   1 +
> >  arch/riscv/boot/dts/allwinner/Makefile        |  10 +
> >  .../allwinner/sun20i-d1-clockworkpi-v3.14.dts | 242 +++++
> >  .../sun20i-d1-common-regulators.dtsi          |  51 +
> >  .../dts/allwinner/sun20i-d1-devterm-v3.14.dts |  37 +
> >  .../sun20i-d1-dongshan-nezha-stu.dts          | 114 +++
> >  .../sun20i-d1-lichee-rv-86-panel-480p.dts     |  29 +
> >  .../sun20i-d1-lichee-rv-86-panel-720p.dts     |  10 +
> >  .../sun20i-d1-lichee-rv-86-panel.dtsi         |  92 ++
> >  .../allwinner/sun20i-d1-lichee-rv-dock.dts    |  74 ++
> >  .../dts/allwinner/sun20i-d1-lichee-rv.dts     |  84 ++
> >  .../allwinner/sun20i-d1-mangopi-mq-pro.dts    | 128 +++
> >  .../boot/dts/allwinner/sun20i-d1-nezha.dts    | 171 ++++
> >  arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi  | 900 ++++++++++++++++++
> >  arch/riscv/configs/defconfig                  |  23 +-
> >  20 files changed, 2045 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sunxi.yaml
> >  create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
> >  create mode 100644
> >  arch/riscv/boot/dts/allwinner/sun20i-d1-clockworkpi-v3.14.dts create
> >  mode 100644
> >  arch/riscv/boot/dts/allwinner/sun20i-d1-common-regulators.dtsi create
> >  mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
> >  create mode 100644
> >  arch/riscv/boot/dts/allwinner/sun20i-d1-dongshan-nezha-stu.dts create
> >  mode 100644
> >  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-480p.dts
> >  create mode 100644
> >  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel-720p.dts
> >  create mode 100644
> >  arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-86-panel.dtsi create
> >  mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
> >  create mode 100644 arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv.d=
ts
> >  create mode 100644
> >  arch/riscv/boot/dts/allwinner/sun20i-d1-mangopi-mq-pro.dts create mode
> >  100644 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts create mode
> >  100644 arch/riscv/boot/dts/allwinner/sun20i-d1.dtsi
>=20
> I'm assuming these are aimed at the RISC-V tree?  I'm generally OK with
> that, though the DT folks have pointed out a handful of issues that look
> pretty reasonable to me.

DT changes for Allwinner ARM SoCs go trough sunxi tree. Should this be hand=
led=20
differently for RISC-V?

Best regards,
Jernej

>=20
> I can't find a v2, not sure if I missed it.  No rush on my end, just
> want to make sure I'm not dropping the ball on anything.
>=20
> Thanks!


