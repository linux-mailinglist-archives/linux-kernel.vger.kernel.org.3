Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658CE4E8B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 02:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiC1ALR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 20:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiC1ALN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 20:11:13 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F43DA75;
        Sun, 27 Mar 2022 17:09:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dr20so25349773ejc.6;
        Sun, 27 Mar 2022 17:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGtFfeHHoCREH7oPnpEou0mdCqzp7yMdERm90H7fFG8=;
        b=g0tfSjWvLcZM5EHX5AX9XaBRJqJT+we9Pmn2689AMN19h1jXP0gEM9pJa7C1cFZtOg
         VF+MZcIqwwBW+yAzMryXHdQu1Vk1yKksXBsWfGT8ozjaeIKrayybGznkicff6Hu1XJPf
         QdKL8+xnMoNrFVmNwJx867pZ0OwpWsci0Jejm8Etzj5n4ekZWINPACOlGAiY7OQNFKTO
         rP16XEBmLaIlGZExpBzsziC0VY2peEqsYexkogIg9bfFW/FipxTF9+qgL+gEdj3yPBCL
         sQmDbnDExt6D7QbWIRKa4UOiI9UwTAOVvgj7NDDi/kryYxPAEEegke+c/I/8rKZjdGzS
         NNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGtFfeHHoCREH7oPnpEou0mdCqzp7yMdERm90H7fFG8=;
        b=ukVmQX17rAdwQNKSHwv3rxu9/p9Wp8l3hAwlpRVO334RLT/DM7bceXlnLldBYqbWhj
         nYsfX9GD0XuF48X35uvU1vBU+/u4PzKHXI42b1gYvE8kQdDi4UT3PWiLKLZMJnsHUC2H
         QVDdUexKRYUHPB+F6Y53piV95/YbHZxKp9E5XztunmeHhkZqVCqGbZNI15KwlgLoi7C9
         NKWA7uIEBr4MHHqe63B7JY5RIdSGaY0T4jTii/A7SrX2glXlWrnYsj18LLAQ7GZCiieq
         JDqO7SNcAieBUGjaQglDYMZocQg9/AdJTbf4jU9vqzu3qmt8FMBsPbxboPa9D7VrWJYc
         rRDA==
X-Gm-Message-State: AOAM5336mubOHApp9u86pZ/2Npz7VbwPXtuTC4r2i2MsKMyKTu28FVCW
        1HAoPA4lo8+HpXPWeZ9MJVqF2i6Q7zE=
X-Google-Smtp-Source: ABdhPJxTRU/a3d+w9HLHNy0Ik40ecBY7+BjSRSOtwHWQmtr1GILV52cIwAHyytEglR/wQL0AQNWNeA==
X-Received: by 2002:a17:907:97c7:b0:6e0:defd:342d with SMTP id js7-20020a17090797c700b006e0defd342dmr9229162ejc.231.1648426167668;
        Sun, 27 Mar 2022 17:09:27 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id o3-20020aa7dd43000000b00419db53ae65sm708628edw.7.2022.03.27.17.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 17:09:27 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [RFC PATCH 0/1] Categorize ARM dts directory 
Date:   Mon, 28 Mar 2022 02:09:14 +0200
Message-Id: <20220328000915.15041-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
as the title say, the intention of this ""series"" is to finally categorize
the ARM dts directory in subdirectory for each oem.

The main reason for this is that it became unpractical to handle 2600
dts files and try to even understand/edit/check the situation for a
specific target.

In arm64 we already have this kind of separation and I honestly think
that this was never proposed for ARM due to the fact that there are
2600+ files to sort and the fact that it will be a mess to merge this
entirely but IMHO with a little bit of effort we can finally solve this
problem and have a well organized directory just like arm64.

Some prerequisite on how this work was done:
- This comes entirely from a python script created by me for the task.
  linked here [1]
- I had to manually categorize all the different arch in the makefile
  based on the oem. I searched every arch on the internet trying to
  understand the correct oem. I hope they are correct but I would love
  some comments about them.
- This current ""series"" is all squashed in one big commit to better
  receive comments for this. The final version ideally would have all
  changes in separate commits. The script can already do this, it's just
  commented.

Here is a list of some discoveries while doing all the sorting.
These are totally additional reason why we need this.

While creating the script I discovered some funny things:
- We have orphan dts! There are dts that are never compiled and are
  there just for reference. We would never have noticed this without this
  change and probably nobody noticed it. They are currently all listed
  in the python script.
- We have dtsi shared across different oem. My current solution for them
  is: NOT SORT THEM and leave them in the generic directory and create a
  link in each oem dts that points to these dtsi. This is to try in
  every way possible to skip any additional changes to the dts.
  Current dtsi that suffers from this are only 3. (listed in the script)
- arm64 dts and dtsi reference ARM dts. Obviously this change would cause
  broken include for these special dtsi. The script creates a dependency
  table of the entire arm64 directory and fix every broken dependency
  (hoping they all use a sane include logic... regex is used to parse
  all the different dependency)

So in short the script does the following steps:
1. Enumerate all the action to do... (dts to move, scan dependency for
   the dts...)
2. Generate the arm64 dependency
3. Creates the Makefile
4. Generate the Makefiles for the current oem
5. Move all the related dts and dtsi for the current oem
6. Check broken dependency and fix them by editing the dts and writing
   the correct include (or fix any symbolic link)

This is an output that describes all the things done by the script [2]

I really hope I didn't commit any logic mistake in the script but most
of the work should be done.

Final words/request:
- I would really love if this can be finally fixed. Again having 2600
  files in one directory became very difficult to maintain and we should
  really apply what was done for arm64
- I 99% made some mistake in how each arch is categorized. Feel free to
  point how they should be fixed/organized.
- I hope this is actually doable given the amount of changes and part it
  does touch across ARM and arm64.
- Hint on how to send the final version of this monster. Currently we
  would have 52 commits to send in one series. (one commit for each oem
  + separate commit to fix arm64 dependency after the categorization is
  done) It was advised that for an RFC the best thing would be to send
  this in one commit instead of spamming 52 mail to tons of maintainers.

[1] https://gist.github.com/Ansuel/47c49925ee7ef4b1dd035afc74679ab5
[2] https://gist.github.com/Ansuel/19f61f1e583c49407ce35c10e770fbe0

Ansuel Smith (1):
  ARM/arm64: categorize dts in arm dir and fix dependency in arm64

 arch/arm/boot/dts/Makefile                    | 1616 +----------------
 arch/arm/boot/dts/actions/Makefile            |    7 +
 .../{ => actions}/owl-s500-cubieboard6.dts    |    0
 .../owl-s500-guitar-bb-rev-b.dts              |    0
 .../dts/{ => actions}/owl-s500-guitar.dtsi    |    0
 .../owl-s500-labrador-base-m.dts              |    0
 .../{ => actions}/owl-s500-labrador-v2.dtsi   |    0
 .../{ => actions}/owl-s500-roseapplepi.dts    |    0
 .../dts/{ => actions}/owl-s500-sparky.dts     |    0
 arch/arm/boot/dts/{ => actions}/owl-s500.dtsi |    0
 arch/arm/boot/dts/airoha/Makefile             |    3 +
 arch/arm/boot/dts/{ => airoha}/en7523-evb.dts |    0
 arch/arm/boot/dts/{ => airoha}/en7523.dtsi    |    0
 arch/arm/boot/dts/allwinner/Makefile          |  155 ++
 arch/arm/boot/dts/{ => allwinner}/axp152.dtsi |    0
 arch/arm/boot/dts/{ => allwinner}/axp209.dtsi |    0
 arch/arm/boot/dts/{ => allwinner}/axp223.dtsi |    0
 arch/arm/boot/dts/{ => allwinner}/axp22x.dtsi |    0
 arch/arm/boot/dts/{ => allwinner}/axp809.dtsi |    0
 arch/arm/boot/dts/{ => allwinner}/axp81x.dtsi |    0
 .../dts/{ => allwinner}/sun4i-a10-a1000.dts   |    0
 .../{ => allwinner}/sun4i-a10-ba10-tvbox.dts  |    0
 .../sun4i-a10-chuwi-v7-cw0825.dts             |    0
 .../{ => allwinner}/sun4i-a10-cubieboard.dts  |    0
 .../sun4i-a10-dserve-dsrv9703c.dts            |    0
 .../{ => allwinner}/sun4i-a10-gemei-g9.dts    |    0
 .../{ => allwinner}/sun4i-a10-hackberry.dts   |    0
 .../sun4i-a10-hyundai-a7hd.dts                |    0
 .../dts/{ => allwinner}/sun4i-a10-inet1.dts   |    0
 .../{ => allwinner}/sun4i-a10-inet97fv2.dts   |    0
 .../sun4i-a10-inet9f-rev03.dts                |    0
 .../sun4i-a10-itead-iteaduino-plus.dts        |    0
 .../{ => allwinner}/sun4i-a10-jesurun-q5.dts  |    0
 .../{ => allwinner}/sun4i-a10-marsboard.dts   |    0
 .../{ => allwinner}/sun4i-a10-mini-xplus.dts  |    0
 .../dts/{ => allwinner}/sun4i-a10-mk802.dts   |    0
 .../dts/{ => allwinner}/sun4i-a10-mk802ii.dts |    0
 .../sun4i-a10-olinuxino-lime.dts              |    0
 .../dts/{ => allwinner}/sun4i-a10-pcduino.dts |    0
 .../{ => allwinner}/sun4i-a10-pcduino2.dts    |    0
 .../sun4i-a10-pov-protab2-ips9.dts            |    0
 .../sun4i-a10-topwise-a721.dts                |    0
 .../boot/dts/{ => allwinner}/sun4i-a10.dtsi   |    0
 .../sun5i-a10s-auxtek-t003.dts                |    0
 .../sun5i-a10s-auxtek-t004.dts                |    0
 .../dts/{ => allwinner}/sun5i-a10s-mk802.dts  |    0
 .../sun5i-a10s-olinuxino-micro.dts            |    0
 .../sun5i-a10s-r7-tv-dongle.dts               |    0
 .../{ => allwinner}/sun5i-a10s-wobo-i5.dts    |    0
 .../boot/dts/{ => allwinner}/sun5i-a10s.dtsi  |    0
 .../sun5i-a13-difrnce-dit4350.dts             |    0
 .../sun5i-a13-empire-electronix-d709.dts      |    0
 .../sun5i-a13-empire-electronix-m712.dts      |    0
 .../{ => allwinner}/sun5i-a13-hsg-h702.dts    |    0
 .../sun5i-a13-inet-98v-rev2.dts               |    0
 .../sun5i-a13-licheepi-one.dts                |    0
 .../sun5i-a13-olinuxino-micro.dts             |    0
 .../{ => allwinner}/sun5i-a13-olinuxino.dts   |    0
 .../sun5i-a13-pocketbook-touch-lux-3.dts      |    0
 .../{ => allwinner}/sun5i-a13-q8-tablet.dts   |    0
 .../{ => allwinner}/sun5i-a13-utoo-p66.dts    |    0
 .../boot/dts/{ => allwinner}/sun5i-a13.dtsi   |    0
 .../{ => allwinner}/sun5i-gr8-chip-pro.dts    |    0
 .../dts/{ => allwinner}/sun5i-gr8-evb.dts     |    0
 .../boot/dts/{ => allwinner}/sun5i-gr8.dtsi   |    0
 .../dts/{ => allwinner}/sun5i-r8-chip.dts     |    0
 .../boot/dts/{ => allwinner}/sun5i-r8.dtsi    |    0
 .../sun5i-reference-design-tablet.dtsi        |    0
 arch/arm/boot/dts/{ => allwinner}/sun5i.dtsi  |    0
 .../{ => allwinner}/sun6i-a31-app4-evb1.dts   |    0
 .../{ => allwinner}/sun6i-a31-colombus.dts    |    0
 .../{ => allwinner}/sun6i-a31-hummingbird.dts |    0
 .../boot/dts/{ => allwinner}/sun6i-a31-i7.dts |    0
 .../boot/dts/{ => allwinner}/sun6i-a31-m9.dts |    0
 .../sun6i-a31-mele-a1000g-quad.dts            |    0
 .../boot/dts/{ => allwinner}/sun6i-a31.dtsi   |    0
 .../sun6i-a31s-colorfly-e708-q1.dts           |    0
 .../dts/{ => allwinner}/sun6i-a31s-cs908.dts  |    0
 .../{ => allwinner}/sun6i-a31s-inet-q972.dts  |    0
 .../{ => allwinner}/sun6i-a31s-primo81.dts    |    0
 .../sun6i-a31s-sina31s-core.dtsi              |    0
 .../{ => allwinner}/sun6i-a31s-sina31s.dts    |    0
 .../sun6i-a31s-sinovoip-bpi-m2.dts            |    0
 .../sun6i-a31s-yones-toptech-bs1078-v2.dts    |    0
 .../boot/dts/{ => allwinner}/sun6i-a31s.dtsi  |    0
 .../sun6i-reference-design-tablet.dtsi        |    0
 .../sun7i-a20-bananapi-m1-plus.dts            |    0
 .../{ => allwinner}/sun7i-a20-bananapi.dts    |    0
 .../{ => allwinner}/sun7i-a20-bananapro.dts   |    0
 .../{ => allwinner}/sun7i-a20-cubieboard2.dts |    0
 .../{ => allwinner}/sun7i-a20-cubietruck.dts  |    0
 .../sun7i-a20-haoyu-marsboard.dts             |    0
 .../{ => allwinner}/sun7i-a20-hummingbird.dts |    0
 .../{ => allwinner}/sun7i-a20-i12-tvbox.dts   |    0
 .../{ => allwinner}/sun7i-a20-icnova-swac.dts |    0
 .../{ => allwinner}/sun7i-a20-itead-ibox.dts  |    0
 .../{ => allwinner}/sun7i-a20-lamobo-r1.dts   |    0
 .../sun7i-a20-linutronix-testbox-v2.dts       |    0
 .../boot/dts/{ => allwinner}/sun7i-a20-m3.dts |    0
 .../dts/{ => allwinner}/sun7i-a20-mk808c.dts  |    0
 .../sun7i-a20-olimex-som-evb-emmc.dts         |    0
 .../sun7i-a20-olimex-som-evb.dts              |    0
 .../sun7i-a20-olimex-som204-evb-emmc.dts      |    0
 .../sun7i-a20-olimex-som204-evb.dts           |    0
 .../sun7i-a20-olinuxino-lime-emmc.dts         |    0
 .../sun7i-a20-olinuxino-lime.dts              |    0
 .../sun7i-a20-olinuxino-lime2-emmc.dts        |    0
 .../sun7i-a20-olinuxino-lime2.dts             |    0
 .../sun7i-a20-olinuxino-micro-emmc.dts        |    0
 .../sun7i-a20-olinuxino-micro.dts             |    0
 .../sun7i-a20-orangepi-mini.dts               |    0
 .../{ => allwinner}/sun7i-a20-orangepi.dts    |    0
 .../sun7i-a20-pcduino3-nano.dts               |    0
 .../{ => allwinner}/sun7i-a20-pcduino3.dts    |    0
 .../sun7i-a20-wexler-tab7200.dts              |    0
 .../sun7i-a20-wits-pro-a20-dkt.dts            |    0
 .../boot/dts/{ => allwinner}/sun7i-a20.dtsi   |    0
 .../dts/{ => allwinner}/sun8i-a23-a33.dtsi    |    0
 .../dts/{ => allwinner}/sun8i-a23-evb.dts     |    0
 .../{ => allwinner}/sun8i-a23-gt90h-v4.dts    |    0
 .../{ => allwinner}/sun8i-a23-inet86dz.dts    |    0
 .../sun8i-a23-ippo-q8h-v1.2.dts               |    0
 .../{ => allwinner}/sun8i-a23-ippo-q8h-v5.dts |    0
 .../sun8i-a23-polaroid-mid2407pxe03.dts       |    0
 .../sun8i-a23-polaroid-mid2809pxe04.dts       |    0
 .../{ => allwinner}/sun8i-a23-q8-tablet.dts   |    0
 .../boot/dts/{ => allwinner}/sun8i-a23.dtsi   |    0
 .../{ => allwinner}/sun8i-a33-et-q8-v1.6.dts  |    0
 .../{ => allwinner}/sun8i-a33-ga10h-v1.1.dts  |    0
 .../sun8i-a33-inet-d978-rev2.dts              |    0
 .../sun8i-a33-ippo-q8h-v1.2.dts               |    0
 .../{ => allwinner}/sun8i-a33-olinuxino.dts   |    0
 .../{ => allwinner}/sun8i-a33-q8-tablet.dts   |    0
 .../sun8i-a33-sinlinx-sina33.dts              |    0
 .../boot/dts/{ => allwinner}/sun8i-a33.dtsi   |    0
 .../sun8i-a83t-allwinner-h8homlet-v2.dts      |    0
 .../sun8i-a83t-bananapi-m3.dts                |    0
 .../sun8i-a83t-cubietruck-plus.dts            |    0
 .../{ => allwinner}/sun8i-a83t-tbs-a711.dts   |    0
 .../boot/dts/{ => allwinner}/sun8i-a83t.dtsi  |    0
 .../sun8i-h2-plus-bananapi-m2-zero.dts        |    0
 .../sun8i-h2-plus-libretech-all-h3-cc.dts     |    0
 .../sun8i-h2-plus-orangepi-r1.dts             |    0
 .../sun8i-h2-plus-orangepi-zero.dts           |    0
 .../sun8i-h3-bananapi-m2-plus-v1.2.dts        |    0
 .../sun8i-h3-bananapi-m2-plus.dts             |    0
 .../{ => allwinner}/sun8i-h3-beelink-x2.dts   |    0
 .../sun8i-h3-emlid-neutis-n5h3-devboard.dts   |    0
 .../sun8i-h3-emlid-neutis-n5h3.dtsi           |    0
 .../sun8i-h3-libretech-all-h3-cc.dts          |    0
 .../sun8i-h3-mapleboard-mp130.dts             |    0
 .../{ => allwinner}/sun8i-h3-nanopi-duo2.dts  |    0
 .../sun8i-h3-nanopi-m1-plus.dts               |    0
 .../{ => allwinner}/sun8i-h3-nanopi-m1.dts    |    0
 .../sun8i-h3-nanopi-neo-air.dts               |    0
 .../{ => allwinner}/sun8i-h3-nanopi-neo.dts   |    0
 .../{ => allwinner}/sun8i-h3-nanopi-r1.dts    |    0
 .../dts/{ => allwinner}/sun8i-h3-nanopi.dtsi  |    0
 .../{ => allwinner}/sun8i-h3-orangepi-2.dts   |    0
 .../sun8i-h3-orangepi-lite.dts                |    0
 .../{ => allwinner}/sun8i-h3-orangepi-one.dts |    0
 .../sun8i-h3-orangepi-pc-plus.dts             |    0
 .../{ => allwinner}/sun8i-h3-orangepi-pc.dts  |    0
 .../sun8i-h3-orangepi-plus.dts                |    0
 .../sun8i-h3-orangepi-plus2e.dts              |    0
 .../sun8i-h3-orangepi-zero-plus2.dts          |    0
 .../sun8i-h3-rervision-dvk.dts                |    0
 .../dts/{ => allwinner}/sun8i-h3-zeropi.dts   |    0
 .../boot/dts/{ => allwinner}/sun8i-h3.dtsi    |    0
 .../dts/{ => allwinner}/sun8i-q8-common.dtsi  |    0
 .../sun8i-r16-bananapi-m2m.dts                |    0
 .../sun8i-r16-nintendo-nes-classic.dts        |    0
 .../sun8i-r16-nintendo-super-nes-classic.dts  |    0
 .../dts/{ => allwinner}/sun8i-r16-parrot.dts  |    0
 .../sun8i-r40-bananapi-m2-ultra.dts           |    0
 .../{ => allwinner}/sun8i-r40-feta40i.dtsi    |    0
 .../{ => allwinner}/sun8i-r40-oka40i-c.dts    |    0
 .../boot/dts/{ => allwinner}/sun8i-r40.dtsi   |    0
 .../sun8i-reference-design-tablet.dtsi        |    0
 .../sun8i-s3-elimo-impetus.dtsi               |    0
 .../sun8i-s3-elimo-initium.dts                |    0
 .../sun8i-s3-lichee-zero-plus.dts             |    0
 .../dts/{ => allwinner}/sun8i-s3-pinecube.dts |    0
 .../{ => allwinner}/sun8i-t3-cqa3t-bv3.dts    |    0
 .../{ => allwinner}/sun8i-v3-sl631-imx179.dts |    0
 .../dts/{ => allwinner}/sun8i-v3-sl631.dtsi   |    0
 .../boot/dts/{ => allwinner}/sun8i-v3.dtsi    |    0
 .../sun8i-v3s-licheepi-zero-dock.dts          |    0
 .../sun8i-v3s-licheepi-zero.dts               |    0
 .../boot/dts/{ => allwinner}/sun8i-v3s.dtsi   |    0
 .../sun8i-v40-bananapi-m2-berry.dts           |    0
 .../{ => allwinner}/sun9i-a80-cubieboard4.dts |    0
 .../dts/{ => allwinner}/sun9i-a80-optimus.dts |    0
 .../boot/dts/{ => allwinner}/sun9i-a80.dtsi   |    0
 .../suniv-f1c100s-licheepi-nano.dts           |    0
 .../dts/{ => allwinner}/suniv-f1c100s.dtsi    |    0
 .../sunxi-bananapi-m2-plus-v1.2.dtsi          |    0
 .../sunxi-bananapi-m2-plus.dtsi               |    0
 .../sunxi-common-regulators.dtsi              |    0
 .../sunxi-h3-h5-emlid-neutis.dtsi             |    0
 .../boot/dts/{ => allwinner}/sunxi-h3-h5.dtsi |    0
 .../sunxi-itead-core-common.dtsi              |    0
 .../sunxi-libretech-all-h3-cc.dtsi            |    0
 .../sunxi-libretech-all-h3-it.dtsi            |    0
 .../sunxi-reference-design-tablet.dtsi        |    0
 arch/arm/boot/dts/alphascale/Makefile         |    3 +
 .../alphascale-asm9260-devkit.dts             |    0
 .../{ => alphascale}/alphascale-asm9260.dtsi  |    0
 arch/arm/boot/dts/amlogic/Makefile            |    9 +
 arch/arm/boot/dts/{ => amlogic}/meson.dtsi    |    0
 .../boot/dts/{ => amlogic}/meson6-atv1200.dts |    0
 arch/arm/boot/dts/{ => amlogic}/meson6.dtsi   |    0
 .../dts/{ => amlogic}/meson8-minix-neo-x8.dts |    0
 arch/arm/boot/dts/{ => amlogic}/meson8.dtsi   |    0
 .../boot/dts/{ => amlogic}/meson8b-ec100.dts  |    0
 .../boot/dts/{ => amlogic}/meson8b-mxq.dts    |    0
 .../dts/{ => amlogic}/meson8b-odroidc1.dts    |    0
 arch/arm/boot/dts/{ => amlogic}/meson8b.dtsi  |    0
 .../dts/{ => amlogic}/meson8m2-mxiii-plus.dts |    0
 arch/arm/boot/dts/{ => amlogic}/meson8m2.dtsi |    0
 arch/arm/boot/dts/annapurna/Makefile          |    3 +
 .../boot/dts/{ => annapurna}/alpine-db.dts    |    0
 arch/arm/boot/dts/{ => annapurna}/alpine.dtsi |    0
 arch/arm/boot/dts/arm/Makefile                |   17 +
 arch/arm/boot/dts/arm/armv7-m.dtsi            |    1 +
 arch/arm/boot/dts/{ => arm}/integrator.dtsi   |    0
 .../dts/{ => arm}/integratorap-im-pd1.dts     |    0
 arch/arm/boot/dts/{ => arm}/integratorap.dts  |    0
 arch/arm/boot/dts/{ => arm}/integratorcp.dts  |    0
 arch/arm/boot/dts/{ => arm}/mps2-an385.dts    |    0
 arch/arm/boot/dts/{ => arm}/mps2-an399.dts    |    0
 arch/arm/boot/dts/{ => arm}/mps2.dtsi         |    0
 .../boot/dts/{ => arm}/versatile-ab-ib2.dts   |    0
 arch/arm/boot/dts/{ => arm}/versatile-ab.dts  |    0
 arch/arm/boot/dts/{ => arm}/versatile-pb.dts  |    0
 .../boot/dts/{ => arm}/vexpress-v2m-rs1.dtsi  |    0
 arch/arm/boot/dts/{ => arm}/vexpress-v2m.dtsi |    0
 .../dts/{ => arm}/vexpress-v2p-ca15-tc1.dts   |    0
 .../dts/{ => arm}/vexpress-v2p-ca15_a7.dts    |    0
 .../boot/dts/{ => arm}/vexpress-v2p-ca5s.dts  |    0
 .../boot/dts/{ => arm}/vexpress-v2p-ca9.dts   |    0
 arch/arm/boot/dts/aspeed/Makefile             |   56 +
 .../dts/{ => aspeed}/aspeed-ast2500-evb.dts   |    0
 .../{ => aspeed}/aspeed-ast2600-evb-a1.dts    |    0
 .../dts/{ => aspeed}/aspeed-ast2600-evb.dts   |    0
 .../{ => aspeed}/aspeed-bmc-amd-ethanolx.dts  |    0
 .../{ => aspeed}/aspeed-bmc-ampere-mtjade.dts |    0
 .../aspeed-bmc-arm-centriq2400-rep.dts        |    0
 .../aspeed-bmc-arm-stardragon4800-rep2.dts    |    0
 .../aspeed-bmc-asrock-e3c246d4i.dts           |    0
 .../aspeed-bmc-asrock-romed8hm3.dts           |    0
 .../aspeed-bmc-bytedance-g220a.dts            |    0
 .../aspeed-bmc-facebook-bletchley.dts         |    0
 .../aspeed-bmc-facebook-cloudripper.dts       |    0
 .../{ => aspeed}/aspeed-bmc-facebook-cmm.dts  |    0
 .../aspeed-bmc-facebook-elbert.dts            |    0
 .../{ => aspeed}/aspeed-bmc-facebook-fuji.dts |    0
 .../aspeed-bmc-facebook-galaxy100.dts         |    0
 .../aspeed-bmc-facebook-minipack.dts          |    0
 .../aspeed-bmc-facebook-tiogapass.dts         |    0
 .../aspeed-bmc-facebook-wedge100.dts          |    0
 .../aspeed-bmc-facebook-wedge40.dts           |    0
 .../aspeed-bmc-facebook-wedge400.dts          |    0
 .../{ => aspeed}/aspeed-bmc-facebook-yamp.dts |    0
 .../aspeed-bmc-facebook-yosemitev2.dts        |    0
 .../{ => aspeed}/aspeed-bmc-ibm-everest.dts   |    0
 .../aspeed-bmc-ibm-rainier-1s4u.dts           |    0
 .../aspeed-bmc-ibm-rainier-4u.dts             |    0
 .../{ => aspeed}/aspeed-bmc-ibm-rainier.dts   |    0
 .../aspeed-bmc-inspur-fp5280g2.dts            |    0
 .../aspeed-bmc-inspur-nf5280m6.dts            |    0
 .../aspeed-bmc-inspur-on5263m5.dts            |    0
 .../{ => aspeed}/aspeed-bmc-intel-s2600wf.dts |    0
 .../aspeed-bmc-inventec-transformers.dts      |    0
 .../{ => aspeed}/aspeed-bmc-lenovo-hr630.dts  |    0
 .../aspeed-bmc-lenovo-hr855xg2.dts            |    0
 .../aspeed-bmc-microsoft-olympus.dts          |    0
 .../{ => aspeed}/aspeed-bmc-opp-lanyang.dts   |    0
 .../{ => aspeed}/aspeed-bmc-opp-mihawk.dts    |    0
 .../{ => aspeed}/aspeed-bmc-opp-mowgli.dts    |    0
 .../{ => aspeed}/aspeed-bmc-opp-nicole.dts    |    0
 .../{ => aspeed}/aspeed-bmc-opp-palmetto.dts  |    0
 .../{ => aspeed}/aspeed-bmc-opp-romulus.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-swift.dts |    0
 .../{ => aspeed}/aspeed-bmc-opp-tacoma.dts    |    0
 .../{ => aspeed}/aspeed-bmc-opp-vesnin.dts    |    0
 .../aspeed-bmc-opp-witherspoon.dts            |    0
 .../dts/{ => aspeed}/aspeed-bmc-opp-zaius.dts |    0
 .../aspeed-bmc-portwell-neptune.dts           |    0
 .../{ => aspeed}/aspeed-bmc-quanta-q71l.dts   |    0
 .../{ => aspeed}/aspeed-bmc-quanta-s6q.dts    |    0
 .../aspeed-bmc-supermicro-x11spi.dts          |    0
 .../{ => aspeed}/aspeed-bmc-tyan-s7106.dts    |    0
 .../{ => aspeed}/aspeed-bmc-tyan-s8036.dts    |    0
 .../{ => aspeed}/aspeed-bmc-vegman-n110.dts   |    0
 .../{ => aspeed}/aspeed-bmc-vegman-rx20.dts   |    0
 .../{ => aspeed}/aspeed-bmc-vegman-sx20.dts   |    0
 .../dts/{ => aspeed}/aspeed-bmc-vegman.dtsi   |    0
 arch/arm/boot/dts/{ => aspeed}/aspeed-g4.dtsi |    0
 arch/arm/boot/dts/{ => aspeed}/aspeed-g5.dtsi |    0
 .../dts/{ => aspeed}/aspeed-g6-pinctrl.dtsi   |    0
 arch/arm/boot/dts/{ => aspeed}/aspeed-g6.dtsi |    0
 .../ast2400-facebook-netbmc-common.dtsi       |    0
 .../ast2500-facebook-netbmc-common.dtsi       |    0
 .../ast2600-facebook-netbmc-common.dtsi       |    0
 .../facebook-bmc-flash-layout-128.dtsi        |    0
 .../facebook-bmc-flash-layout.dtsi            |    0
 .../dts/{ => aspeed}/ibm-power9-dual.dtsi     |    0
 .../openbmc-flash-layout-128.dtsi             |    0
 .../openbmc-flash-layout-64-alt.dtsi          |    0
 .../{ => aspeed}/openbmc-flash-layout-64.dtsi |    0
 .../{ => aspeed}/openbmc-flash-layout.dtsi    |    0
 arch/arm/boot/dts/axix/Makefile               |    3 +
 .../boot/dts/{ => axix}/artpec6-devboard.dts  |    0
 arch/arm/boot/dts/{ => axix}/artpec6.dtsi     |    0
 arch/arm/boot/dts/axxia/Makefile              |    3 +
 .../boot/dts/{ => axxia}/axm5516-amarillo.dts |    0
 .../boot/dts/{ => axxia}/axm5516-cpus.dtsi    |    0
 arch/arm/boot/dts/{ => axxia}/axm55xx.dtsi    |    0
 arch/arm/boot/dts/broadcom/Makefile           |   94 +
 .../dts/{ => broadcom}/bcm-cygnus-clock.dtsi  |    0
 .../boot/dts/{ => broadcom}/bcm-cygnus.dtsi   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm-hr2.dtsi |    0
 .../boot/dts/{ => broadcom}/bcm-nsp-ax.dtsi   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm-nsp.dtsi |    0
 .../arm/boot/dts/{ => broadcom}/bcm11351.dtsi |    0
 .../dts/{ => broadcom}/bcm21664-garnet.dts    |    0
 .../arm/boot/dts/{ => broadcom}/bcm21664.dtsi |    0
 .../dts/{ => broadcom}/bcm23550-sparrow.dts   |    0
 .../arm/boot/dts/{ => broadcom}/bcm23550.dtsi |    0
 .../dts/{ => broadcom}/bcm2711-rpi-4-b.dts    |    0
 .../dts/{ => broadcom}/bcm2711-rpi-400.dts    |    0
 .../dts/{ => broadcom}/bcm2711-rpi-cm4-io.dts |    0
 .../dts/{ => broadcom}/bcm2711-rpi-cm4.dtsi   |    0
 .../boot/dts/{ => broadcom}/bcm2711-rpi.dtsi  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2711.dtsi |    0
 .../boot/dts/{ => broadcom}/bcm28155-ap.dts   |    0
 .../dts/{ => broadcom}/bcm2835-common.dtsi    |    0
 .../dts/{ => broadcom}/bcm2835-rpi-a-plus.dts |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-a.dts |    0
 .../dts/{ => broadcom}/bcm2835-rpi-b-plus.dts |    0
 .../dts/{ => broadcom}/bcm2835-rpi-b-rev2.dts |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi-b.dts |    0
 .../{ => broadcom}/bcm2835-rpi-cm1-io1.dts    |    0
 .../dts/{ => broadcom}/bcm2835-rpi-cm1.dtsi   |    0
 .../{ => broadcom}/bcm2835-rpi-common.dtsi    |    0
 .../dts/{ => broadcom}/bcm2835-rpi-zero-w.dts |    0
 .../dts/{ => broadcom}/bcm2835-rpi-zero.dts   |    0
 .../boot/dts/{ => broadcom}/bcm2835-rpi.dtsi  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2835.dtsi |    0
 .../dts/{ => broadcom}/bcm2836-rpi-2-b.dts    |    0
 .../boot/dts/{ => broadcom}/bcm2836-rpi.dtsi  |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2836.dtsi |    0
 .../{ => broadcom}/bcm2837-rpi-3-a-plus.dts   |    0
 .../{ => broadcom}/bcm2837-rpi-3-b-plus.dts   |    0
 .../dts/{ => broadcom}/bcm2837-rpi-3-b.dts    |    0
 .../{ => broadcom}/bcm2837-rpi-cm3-io3.dts    |    0
 .../dts/{ => broadcom}/bcm2837-rpi-cm3.dtsi   |    0
 .../{ => broadcom}/bcm2837-rpi-zero-2-w.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm2837.dtsi |    0
 .../{ => broadcom}/bcm283x-rpi-lan7515.dtsi   |    0
 .../{ => broadcom}/bcm283x-rpi-smsc9512.dtsi  |    0
 .../{ => broadcom}/bcm283x-rpi-smsc9514.dtsi  |    0
 .../{ => broadcom}/bcm283x-rpi-usb-host.dtsi  |    0
 .../{ => broadcom}/bcm283x-rpi-usb-otg.dtsi   |    0
 .../bcm283x-rpi-usb-peripheral.dtsi           |    0
 .../{ => broadcom}/bcm283x-rpi-wifi-bt.dtsi   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm283x.dtsi |    0
 .../{ => broadcom}/bcm4708-asus-rt-ac56u.dts  |    0
 .../{ => broadcom}/bcm4708-asus-rt-ac68u.dts  |    0
 .../bcm4708-buffalo-wzr-1750dhp.dts           |    0
 .../bcm4708-linksys-ea6300-v1.dts             |    0
 .../bcm4708-linksys-ea6500-v2.dts             |    0
 .../{ => broadcom}/bcm4708-luxul-xap-1510.dts |    0
 .../{ => broadcom}/bcm4708-luxul-xwc-1000.dts |    0
 .../{ => broadcom}/bcm4708-netgear-r6250.dts  |    0
 .../bcm4708-netgear-r6300-v2.dts              |    0
 .../bcm4708-smartrg-sr400ac.dts               |    0
 arch/arm/boot/dts/{ => broadcom}/bcm4708.dtsi |    0
 .../{ => broadcom}/bcm47081-asus-rt-n18u.dts  |    0
 .../bcm47081-buffalo-wzr-600dhp2.dts          |    0
 .../bcm47081-buffalo-wzr-900dhp.dts           |    0
 .../bcm47081-luxul-xap-1410.dts               |    0
 .../bcm47081-luxul-xwr-1200.dts               |    0
 .../bcm47081-tplink-archer-c5-v2.dts          |    0
 .../arm/boot/dts/{ => broadcom}/bcm47081.dtsi |    0
 .../{ => broadcom}/bcm4709-asus-rt-ac87u.dts  |    0
 .../bcm4709-buffalo-wxr-1900dhp.dts           |    0
 .../{ => broadcom}/bcm4709-linksys-ea9200.dts |    0
 .../{ => broadcom}/bcm4709-netgear-r7000.dts  |    0
 .../{ => broadcom}/bcm4709-netgear-r8000.dts  |    0
 .../bcm4709-tplink-archer-c9-v1.dts           |    0
 arch/arm/boot/dts/{ => broadcom}/bcm4709.dtsi |    0
 .../{ => broadcom}/bcm47094-asus-rt-ac88u.dts |    0
 .../bcm47094-dlink-dir-885l.dts               |    0
 .../bcm47094-linksys-panamera.dts             |    0
 .../bcm47094-luxul-abr-4500.dts               |    0
 .../bcm47094-luxul-xap-1610.dts               |    0
 .../bcm47094-luxul-xbr-4500.dts               |    0
 .../bcm47094-luxul-xwc-2000.dts               |    0
 .../bcm47094-luxul-xwr-3100.dts               |    0
 .../bcm47094-luxul-xwr-3150-v1.dts            |    0
 .../{ => broadcom}/bcm47094-netgear-r8500.dts |    0
 .../{ => broadcom}/bcm47094-phicomm-k3.dts    |    0
 .../arm/boot/dts/{ => broadcom}/bcm47094.dtsi |    0
 .../bcm47189-luxul-xap-1440.dts               |    0
 .../{ => broadcom}/bcm47189-luxul-xap-810.dts |    0
 .../dts/{ => broadcom}/bcm47189-tenda-ac9.dts |    0
 .../{ => broadcom}/bcm53016-meraki-mr32.dts   |    0
 .../bcm5301x-nand-cs0-bch1.dtsi               |    0
 .../bcm5301x-nand-cs0-bch4.dtsi               |    0
 .../bcm5301x-nand-cs0-bch8.dtsi               |    0
 .../dts/{ => broadcom}/bcm5301x-nand-cs0.dtsi |    0
 .../arm/boot/dts/{ => broadcom}/bcm5301x.dtsi |    0
 .../bcm53340-ubnt-unifi-switch8.dts           |    0
 .../arm/boot/dts/{ => broadcom}/bcm53573.dtsi |    0
 .../arm/boot/dts/{ => broadcom}/bcm59056.dtsi |    0
 .../arm/boot/dts/{ => broadcom}/bcm63138.dtsi |    0
 .../{ => broadcom}/bcm7445-bcm97445svmb.dts   |    0
 arch/arm/boot/dts/{ => broadcom}/bcm7445.dtsi |    0
 .../dts/{ => broadcom}/bcm911360_entphn.dts   |    0
 .../boot/dts/{ => broadcom}/bcm911360k.dts    |    0
 arch/arm/boot/dts/{ => broadcom}/bcm94708.dts |    0
 arch/arm/boot/dts/{ => broadcom}/bcm94709.dts |    0
 .../dts/{ => broadcom}/bcm947189acdbmr.dts    |    0
 .../boot/dts/{ => broadcom}/bcm953012er.dts   |    0
 .../boot/dts/{ => broadcom}/bcm953012hr.dts   |    0
 .../boot/dts/{ => broadcom}/bcm953012k.dts    |    0
 .../boot/dts/{ => broadcom}/bcm958300k.dts    |    0
 .../boot/dts/{ => broadcom}/bcm958305k.dts    |    0
 .../boot/dts/{ => broadcom}/bcm958522er.dts   |    0
 .../boot/dts/{ => broadcom}/bcm958525er.dts   |    0
 .../boot/dts/{ => broadcom}/bcm958525xmc.dts  |    0
 .../boot/dts/{ => broadcom}/bcm958622hr.dts   |    0
 .../boot/dts/{ => broadcom}/bcm958623hr.dts   |    0
 .../bcm958625-meraki-alamo.dtsi               |    0
 .../bcm958625-meraki-kingpin.dtsi             |    0
 .../bcm958625-meraki-mx64-a0.dts              |    0
 .../{ => broadcom}/bcm958625-meraki-mx64.dts  |    0
 .../bcm958625-meraki-mx64w-a0.dts             |    0
 .../{ => broadcom}/bcm958625-meraki-mx64w.dts |    0
 .../{ => broadcom}/bcm958625-meraki-mx65.dts  |    0
 .../{ => broadcom}/bcm958625-meraki-mx65w.dts |    0
 .../bcm958625-meraki-mx6x-common.dtsi         |    0
 .../boot/dts/{ => broadcom}/bcm958625hr.dts   |    0
 .../boot/dts/{ => broadcom}/bcm958625k.dts    |    0
 .../boot/dts/{ => broadcom}/bcm963138dvt.dts  |    0
 .../boot/dts/{ => broadcom}/bcm988312hr.dts   |    0
 .../boot/dts/{ => broadcom}/bcm9hmidc.dtsi    |    0
 arch/arm/boot/dts/cirrus/Makefile             |    3 +
 arch/arm/boot/dts/{ => cirrus}/ep7209.dtsi    |    0
 .../boot/dts/{ => cirrus}/ep7211-edb7211.dts  |    0
 arch/arm/boot/dts/{ => cirrus}/ep7211.dtsi    |    0
 arch/arm/boot/dts/conexant/Makefile           |    3 +
 arch/arm/boot/dts/{ => conexant}/cx92755.dtsi |    0
 .../dts/{ => conexant}/cx92755_equinox.dts    |    0
 arch/arm/boot/dts/cortina/Makefile            |   12 +
 .../{ => cortina}/gemini-dlink-dir-685.dts    |    0
 .../{ => cortina}/gemini-dlink-dns-313.dts    |    0
 .../dts/{ => cortina}/gemini-nas4220b.dts     |    0
 .../boot/dts/{ => cortina}/gemini-ns2502.dts  |    0
 .../boot/dts/{ => cortina}/gemini-rut1xx.dts  |    0
 .../dts/{ => cortina}/gemini-sl93512r.dts     |    0
 .../boot/dts/{ => cortina}/gemini-sq201.dts   |    0
 .../boot/dts/{ => cortina}/gemini-ssi1328.dts |    0
 .../boot/dts/{ => cortina}/gemini-wbd111.dts  |    0
 .../boot/dts/{ => cortina}/gemini-wbd222.dts  |    0
 arch/arm/boot/dts/{ => cortina}/gemini.dtsi   |    0
 arch/arm/boot/dts/dove/Makefile               |    8 +
 .../arm/boot/dts/{ => dove}/dove-cm-a510.dtsi |    0
 .../arm/boot/dts/{ => dove}/dove-cubox-es.dts |    0
 arch/arm/boot/dts/{ => dove}/dove-cubox.dts   |    0
 arch/arm/boot/dts/{ => dove}/dove-d2plug.dts  |    0
 arch/arm/boot/dts/{ => dove}/dove-d3plug.dts  |    0
 arch/arm/boot/dts/{ => dove}/dove-dove-db.dts |    0
 .../arm/boot/dts/{ => dove}/dove-sbc-a510.dts |    0
 arch/arm/boot/dts/{ => dove}/dove.dtsi        |    0
 arch/arm/boot/dts/edac/Makefile               |    4 +
 arch/arm/boot/dts/{ => edac}/ecx-2000.dts     |    0
 arch/arm/boot/dts/{ => edac}/ecx-common.dtsi  |    0
 arch/arm/boot/dts/{ => edac}/highbank.dts     |    0
 arch/arm/boot/dts/exynos/Makefile             |   42 +
 .../{ => exynos}/cros-adc-thermistors.dtsi    |    0
 .../arm/boot/dts/exynos/cros-ec-keyboard.dtsi |    1 +
 .../exynos-mfc-reserved-memory.dtsi           |    0
 .../{ => exynos}/exynos-syscon-restart.dtsi   |    0
 .../{ => exynos}/exynos3250-artik5-eval.dts   |    0
 .../dts/{ => exynos}/exynos3250-artik5.dtsi   |    0
 .../boot/dts/{ => exynos}/exynos3250-monk.dts |    0
 .../dts/{ => exynos}/exynos3250-pinctrl.dtsi  |    0
 .../dts/{ => exynos}/exynos3250-rinato.dts    |    0
 .../arm/boot/dts/{ => exynos}/exynos3250.dtsi |    0
 .../dts/{ => exynos}/exynos4-cpu-thermal.dtsi |    0
 arch/arm/boot/dts/{ => exynos}/exynos4.dtsi   |    0
 .../dts/{ => exynos}/exynos4210-i9100.dts     |    0
 .../dts/{ => exynos}/exynos4210-origen.dts    |    0
 .../dts/{ => exynos}/exynos4210-pinctrl.dtsi  |    0
 .../dts/{ => exynos}/exynos4210-smdkv310.dts  |    0
 .../dts/{ => exynos}/exynos4210-trats.dts     |    0
 .../exynos4210-universal_c210.dts             |    0
 .../arm/boot/dts/{ => exynos}/exynos4210.dtsi |    0
 .../{ => exynos}/exynos4412-galaxy-s3.dtsi    |    0
 .../dts/{ => exynos}/exynos4412-i9300.dts     |    0
 .../dts/{ => exynos}/exynos4412-i9305.dts     |    0
 .../{ => exynos}/exynos4412-itop-elite.dts    |    0
 .../exynos4412-itop-scp-core.dtsi             |    0
 .../dts/{ => exynos}/exynos4412-midas.dtsi    |    0
 .../dts/{ => exynos}/exynos4412-n710x.dts     |    0
 .../exynos4412-odroid-common.dtsi             |    0
 .../dts/{ => exynos}/exynos4412-odroidu3.dts  |    0
 .../dts/{ => exynos}/exynos4412-odroidx.dts   |    0
 .../dts/{ => exynos}/exynos4412-odroidx2.dts  |    0
 .../dts/{ => exynos}/exynos4412-origen.dts    |    0
 .../{ => exynos}/exynos4412-p4note-n8010.dts  |    0
 .../dts/{ => exynos}/exynos4412-p4note.dtsi   |    0
 .../dts/{ => exynos}/exynos4412-pinctrl.dtsi  |    0
 .../{ => exynos}/exynos4412-ppmu-common.dtsi  |    0
 .../dts/{ => exynos}/exynos4412-prime.dtsi    |    0
 .../dts/{ => exynos}/exynos4412-smdk4412.dts  |    0
 .../dts/{ => exynos}/exynos4412-tiny4412.dts  |    0
 .../dts/{ => exynos}/exynos4412-trats2.dts    |    0
 .../arm/boot/dts/{ => exynos}/exynos4412.dtsi |    0
 arch/arm/boot/dts/{ => exynos}/exynos5.dtsi   |    0
 .../dts/{ => exynos}/exynos5250-arndale.dts   |    0
 .../dts/{ => exynos}/exynos5250-pinctrl.dtsi  |    0
 .../dts/{ => exynos}/exynos5250-smdk5250.dts  |    0
 .../{ => exynos}/exynos5250-snow-common.dtsi  |    0
 .../dts/{ => exynos}/exynos5250-snow-rev5.dts |    0
 .../boot/dts/{ => exynos}/exynos5250-snow.dts |    0
 .../dts/{ => exynos}/exynos5250-spring.dts    |    0
 .../arm/boot/dts/{ => exynos}/exynos5250.dtsi |    0
 .../dts/{ => exynos}/exynos5260-pinctrl.dtsi  |    0
 .../dts/{ => exynos}/exynos5260-xyref5260.dts |    0
 .../arm/boot/dts/{ => exynos}/exynos5260.dtsi |    0
 .../dts/{ => exynos}/exynos5410-odroidxu.dts  |    0
 .../dts/{ => exynos}/exynos5410-pinctrl.dtsi  |    0
 .../dts/{ => exynos}/exynos5410-smdk5410.dts  |    0
 .../arm/boot/dts/{ => exynos}/exynos5410.dtsi |    0
 .../{ => exynos}/exynos5420-arndale-octa.dts  |    0
 .../{ => exynos}/exynos5420-chagall-wifi.dts  |    0
 .../dts/{ => exynos}/exynos5420-cpus.dtsi     |    0
 .../exynos5420-galaxy-tab-common.dtsi         |    0
 .../{ => exynos}/exynos5420-klimt-wifi.dts    |    0
 .../dts/{ => exynos}/exynos5420-peach-pit.dts |    0
 .../dts/{ => exynos}/exynos5420-pinctrl.dtsi  |    0
 .../dts/{ => exynos}/exynos5420-smdk5420.dts  |    0
 .../{ => exynos}/exynos5420-trip-points.dtsi  |    0
 .../arm/boot/dts/{ => exynos}/exynos5420.dtsi |    0
 .../dts/{ => exynos}/exynos5422-cpus.dtsi     |    0
 .../{ => exynos}/exynos5422-odroid-core.dtsi  |    0
 .../dts/{ => exynos}/exynos5422-odroidhc1.dts |    0
 .../exynos5422-odroidxu3-audio.dtsi           |    0
 .../exynos5422-odroidxu3-common.dtsi          |    0
 .../exynos5422-odroidxu3-lite.dts             |    0
 .../dts/{ => exynos}/exynos5422-odroidxu3.dts |    0
 .../dts/{ => exynos}/exynos5422-odroidxu4.dts |    0
 .../exynos54xx-odroidxu-leds.dtsi             |    0
 .../arm/boot/dts/{ => exynos}/exynos54xx.dtsi |    0
 .../dts/{ => exynos}/exynos5800-peach-pi.dts  |    0
 .../arm/boot/dts/{ => exynos}/exynos5800.dtsi |    0
 arch/arm/boot/dts/freescale/Makefile          |  373 ++++
 arch/arm/boot/dts/{ => freescale}/e60k02.dtsi |    0
 arch/arm/boot/dts/{ => freescale}/e70k02.dtsi |    0
 .../arm/boot/dts/{ => freescale}/imx1-ads.dts |    0
 .../boot/dts/{ => freescale}/imx1-apf9328.dts |    0
 .../boot/dts/{ => freescale}/imx1-pinfunc.h   |    0
 arch/arm/boot/dts/{ => freescale}/imx1.dtsi   |    0
 .../boot/dts/{ => freescale}/imx23-evk.dts    |    0
 .../dts/{ => freescale}/imx23-olinuxino.dts   |    0
 .../boot/dts/{ => freescale}/imx23-pinfunc.h  |    0
 .../boot/dts/{ => freescale}/imx23-sansa.dts  |    0
 .../{ => freescale}/imx23-stmp378x_devb.dts   |    0
 .../boot/dts/{ => freescale}/imx23-xfi3.dts   |    0
 arch/arm/boot/dts/{ => freescale}/imx23.dtsi  |    0
 .../imx25-eukrea-cpuimx25.dtsi                |    0
 ...25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts |    0
 ...25-eukrea-mbimxsd25-baseboard-dvi-svga.dts |    0
 ...x25-eukrea-mbimxsd25-baseboard-dvi-vga.dts |    0
 .../imx25-eukrea-mbimxsd25-baseboard.dts      |    0
 .../dts/{ => freescale}/imx25-karo-tx25.dts   |    0
 .../boot/dts/{ => freescale}/imx25-pdk.dts    |    0
 .../boot/dts/{ => freescale}/imx25-pinfunc.h  |    0
 arch/arm/boot/dts/{ => freescale}/imx25.dtsi  |    0
 .../boot/dts/{ => freescale}/imx27-apf27.dts  |    0
 .../dts/{ => freescale}/imx27-apf27dev.dts    |    0
 .../imx27-eukrea-cpuimx27.dtsi                |    0
 .../imx27-eukrea-mbimxsd27-baseboard.dts      |    0
 .../boot/dts/{ => freescale}/imx27-pdk.dts    |    0
 .../imx27-phytec-phycard-s-rdk.dts            |    0
 .../imx27-phytec-phycard-s-som.dtsi           |    0
 .../imx27-phytec-phycore-rdk.dts              |    0
 .../imx27-phytec-phycore-som.dtsi             |    0
 .../boot/dts/{ => freescale}/imx27-pinfunc.h  |    0
 arch/arm/boot/dts/{ => freescale}/imx27.dtsi  |    0
 .../boot/dts/{ => freescale}/imx28-apf28.dts  |    0
 .../dts/{ => freescale}/imx28-apf28dev.dts    |    0
 .../dts/{ => freescale}/imx28-apx4devkit.dts  |    0
 .../dts/{ => freescale}/imx28-cfa10036.dts    |    0
 .../dts/{ => freescale}/imx28-cfa10037.dts    |    0
 .../dts/{ => freescale}/imx28-cfa10049.dts    |    0
 .../dts/{ => freescale}/imx28-cfa10055.dts    |    0
 .../dts/{ => freescale}/imx28-cfa10056.dts    |    0
 .../dts/{ => freescale}/imx28-cfa10057.dts    |    0
 .../dts/{ => freescale}/imx28-cfa10058.dts    |    0
 .../{ => freescale}/imx28-duckbill-2-485.dts  |    0
 .../imx28-duckbill-2-enocean.dts              |    0
 .../{ => freescale}/imx28-duckbill-2-spi.dts  |    0
 .../dts/{ => freescale}/imx28-duckbill-2.dts  |    0
 .../dts/{ => freescale}/imx28-duckbill.dts    |    0
 .../imx28-eukrea-mbmx283lc.dts                |    0
 .../imx28-eukrea-mbmx287lc.dts                |    0
 .../imx28-eukrea-mbmx28lc.dtsi                |    0
 .../boot/dts/{ => freescale}/imx28-evk.dts    |    0
 .../boot/dts/{ => freescale}/imx28-lwe.dtsi   |    0
 .../boot/dts/{ => freescale}/imx28-m28.dtsi   |    0
 .../boot/dts/{ => freescale}/imx28-m28cu3.dts |    0
 .../boot/dts/{ => freescale}/imx28-m28evk.dts |    0
 .../boot/dts/{ => freescale}/imx28-pinfunc.h  |    0
 .../boot/dts/{ => freescale}/imx28-sps1.dts   |    0
 .../boot/dts/{ => freescale}/imx28-ts4600.dts |    0
 .../boot/dts/{ => freescale}/imx28-tx28.dts   |    0
 .../boot/dts/{ => freescale}/imx28-xea.dts    |    0
 arch/arm/boot/dts/{ => freescale}/imx28.dtsi  |    0
 .../boot/dts/{ => freescale}/imx31-bug.dts    |    0
 .../boot/dts/{ => freescale}/imx31-lite.dts   |    0
 arch/arm/boot/dts/{ => freescale}/imx31.dtsi  |    0
 .../imx35-eukrea-cpuimx35.dtsi                |    0
 .../imx35-eukrea-mbimxsd35-baseboard.dts      |    0
 .../boot/dts/{ => freescale}/imx35-pdk.dts    |    0
 .../boot/dts/{ => freescale}/imx35-pinfunc.h  |    0
 arch/arm/boot/dts/{ => freescale}/imx35.dtsi  |    0
 .../boot/dts/{ => freescale}/imx50-evk.dts    |    0
 .../dts/{ => freescale}/imx50-kobo-aura.dts   |    0
 .../boot/dts/{ => freescale}/imx50-pinfunc.h  |    0
 arch/arm/boot/dts/{ => freescale}/imx50.dtsi  |    0
 .../boot/dts/{ => freescale}/imx51-apf51.dts  |    0
 .../dts/{ => freescale}/imx51-apf51dev.dts    |    0
 .../dts/{ => freescale}/imx51-babbage.dts     |    0
 .../imx51-digi-connectcore-jsk.dts            |    0
 .../imx51-digi-connectcore-som.dtsi           |    0
 .../imx51-eukrea-cpuimx51.dtsi                |    0
 .../imx51-eukrea-mbimxsd51-baseboard.dts      |    0
 .../boot/dts/{ => freescale}/imx51-pinfunc.h  |    0
 .../boot/dts/{ => freescale}/imx51-ts4800.dts |    0
 .../dts/{ => freescale}/imx51-zii-rdu1.dts    |    0
 .../{ => freescale}/imx51-zii-scu2-mezz.dts   |    0
 .../{ => freescale}/imx51-zii-scu3-esb.dts    |    0
 arch/arm/boot/dts/{ => freescale}/imx51.dtsi  |    0
 .../boot/dts/{ => freescale}/imx53-ard.dts    |    0
 .../boot/dts/{ => freescale}/imx53-cx9020.dts |    0
 .../boot/dts/{ => freescale}/imx53-kp-ddc.dts |    0
 .../boot/dts/{ => freescale}/imx53-kp-hsc.dts |    0
 .../boot/dts/{ => freescale}/imx53-kp.dtsi    |    0
 .../boot/dts/{ => freescale}/imx53-m53.dtsi   |    0
 .../boot/dts/{ => freescale}/imx53-m53evk.dts |    0
 .../dts/{ => freescale}/imx53-m53menlo.dts    |    0
 .../boot/dts/{ => freescale}/imx53-mba53.dts  |    0
 .../boot/dts/{ => freescale}/imx53-pinfunc.h  |    0
 .../boot/dts/{ => freescale}/imx53-ppd.dts    |    0
 .../dts/{ => freescale}/imx53-qsb-common.dtsi |    0
 .../boot/dts/{ => freescale}/imx53-qsb.dts    |    0
 .../boot/dts/{ => freescale}/imx53-qsrb.dts   |    0
 .../boot/dts/{ => freescale}/imx53-smd.dts    |    0
 .../dts/{ => freescale}/imx53-tqma53.dtsi     |    0
 .../dts/{ => freescale}/imx53-tx53-x03x.dts   |    0
 .../dts/{ => freescale}/imx53-tx53-x13x.dts   |    0
 .../boot/dts/{ => freescale}/imx53-tx53.dtsi  |    0
 .../dts/{ => freescale}/imx53-usbarmory.dts   |    0
 .../dts/{ => freescale}/imx53-voipac-bsb.dts  |    0
 .../{ => freescale}/imx53-voipac-dmm-668.dtsi |    0
 arch/arm/boot/dts/{ => freescale}/imx53.dtsi  |    0
 .../imx6-logicpd-baseboard.dtsi               |    0
 .../dts/{ => freescale}/imx6-logicpd-som.dtsi |    0
 .../dts/{ => freescale}/imx6dl-alti6p.dts     |    0
 .../dts/{ => freescale}/imx6dl-apf6dev.dts    |    0
 .../imx6dl-aristainetos2_4.dts                |    0
 .../imx6dl-aristainetos2_7.dts                |    0
 .../{ => freescale}/imx6dl-aristainetos_4.dts |    0
 .../{ => freescale}/imx6dl-aristainetos_7.dts |    0
 .../dts/{ => freescale}/imx6dl-b105pv2.dts    |    0
 .../dts/{ => freescale}/imx6dl-b105v2.dts     |    0
 .../dts/{ => freescale}/imx6dl-b125pv2.dts    |    0
 .../dts/{ => freescale}/imx6dl-b125v2.dts     |    0
 .../dts/{ => freescale}/imx6dl-b155v2.dts     |    0
 .../dts/{ => freescale}/imx6dl-b1x5pv2.dtsi   |    0
 .../dts/{ => freescale}/imx6dl-b1x5v2.dtsi    |    0
 .../imx6dl-colibri-eval-v3.dts                |    0
 .../imx6dl-colibri-v1_1-eval-v3.dts           |    0
 .../imx6dl-cubox-i-emmc-som-v15.dts           |    0
 .../imx6dl-cubox-i-som-v15.dts                |    0
 .../dts/{ => freescale}/imx6dl-cubox-i.dts    |    0
 .../{ => freescale}/imx6dl-dfi-fs700-m60.dts  |    0
 .../{ => freescale}/imx6dl-dhcom-picoitx.dts  |    0
 .../imx6dl-eckelmann-ci4x10.dts               |    0
 .../{ => freescale}/imx6dl-emcon-avari.dts    |    0
 .../dts/{ => freescale}/imx6dl-gw51xx.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw52xx.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw53xx.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw54xx.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw551x.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw552x.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw553x.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw560x.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw5903.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw5904.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw5907.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw5910.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw5912.dts     |    0
 .../dts/{ => freescale}/imx6dl-gw5913.dts     |    0
 .../imx6dl-hummingboard-emmc-som-v15.dts      |    0
 .../imx6dl-hummingboard-som-v15.dts           |    0
 .../{ => freescale}/imx6dl-hummingboard.dts   |    0
 .../imx6dl-hummingboard2-emmc-som-v15.dts     |    0
 .../imx6dl-hummingboard2-som-v15.dts          |    0
 .../{ => freescale}/imx6dl-hummingboard2.dts  |    0
 .../dts/{ => freescale}/imx6dl-icore-mipi.dts |    0
 .../dts/{ => freescale}/imx6dl-icore-rqs.dts  |    0
 .../boot/dts/{ => freescale}/imx6dl-icore.dts |    0
 .../imx6dl-kontron-samx6i.dtsi                |    0
 .../dts/{ => freescale}/imx6dl-lanmcu.dts     |    0
 .../boot/dts/{ => freescale}/imx6dl-mamoj.dts |    0
 .../boot/dts/{ => freescale}/imx6dl-mba6.dtsi |    0
 .../boot/dts/{ => freescale}/imx6dl-mba6a.dts |    0
 .../boot/dts/{ => freescale}/imx6dl-mba6b.dts |    0
 .../dts/{ => freescale}/imx6dl-nit6xlite.dts  |    0
 .../dts/{ => freescale}/imx6dl-nitrogen6x.dts |    0
 .../imx6dl-phytec-mira-rdk-nand.dts           |    0
 .../{ => freescale}/imx6dl-phytec-pbab01.dts  |    0
 .../{ => freescale}/imx6dl-phytec-pfla02.dtsi |    0
 .../dts/{ => freescale}/imx6dl-pico-dwarf.dts |    0
 .../{ => freescale}/imx6dl-pico-hobbit.dts    |    0
 .../dts/{ => freescale}/imx6dl-pico-nymph.dts |    0
 .../dts/{ => freescale}/imx6dl-pico-pi.dts    |    0
 .../boot/dts/{ => freescale}/imx6dl-pinfunc.h |    0
 .../dts/{ => freescale}/imx6dl-plybas.dts     |    0
 .../dts/{ => freescale}/imx6dl-plym2m.dts     |    0
 .../dts/{ => freescale}/imx6dl-prtmvt.dts     |    0
 .../dts/{ => freescale}/imx6dl-prtrvt.dts     |    0
 .../dts/{ => freescale}/imx6dl-prtvt7.dts     |    0
 .../boot/dts/{ => freescale}/imx6dl-qmx6.dtsi |    0
 .../dts/{ => freescale}/imx6dl-rex-basic.dts  |    0
 .../dts/{ => freescale}/imx6dl-riotboard.dts  |    0
 .../dts/{ => freescale}/imx6dl-sabreauto.dts  |    0
 .../dts/{ => freescale}/imx6dl-sabrelite.dts  |    0
 .../dts/{ => freescale}/imx6dl-sabresd.dts    |    0
 .../{ => freescale}/imx6dl-savageboard.dts    |    0
 .../{ => freescale}/imx6dl-skov-revc-lt2.dts  |    0
 .../{ => freescale}/imx6dl-skov-revc-lt6.dts  |    0
 .../dts/{ => freescale}/imx6dl-solidsense.dts |    0
 .../dts/{ => freescale}/imx6dl-tqma6a.dtsi    |    0
 .../dts/{ => freescale}/imx6dl-tqma6b.dtsi    |    0
 .../dts/{ => freescale}/imx6dl-ts4900.dts     |    0
 .../dts/{ => freescale}/imx6dl-ts7970.dts     |    0
 .../{ => freescale}/imx6dl-tx6dl-comtft.dts   |    0
 .../{ => freescale}/imx6dl-tx6s-8034-mb7.dts  |    0
 .../dts/{ => freescale}/imx6dl-tx6s-8034.dts  |    0
 .../{ => freescale}/imx6dl-tx6s-8035-mb7.dts  |    0
 .../dts/{ => freescale}/imx6dl-tx6s-8035.dts  |    0
 .../dts/{ => freescale}/imx6dl-tx6u-801x.dts  |    0
 .../{ => freescale}/imx6dl-tx6u-8033-mb7.dts  |    0
 .../dts/{ => freescale}/imx6dl-tx6u-8033.dts  |    0
 .../{ => freescale}/imx6dl-tx6u-80xx-mb7.dts  |    0
 .../dts/{ => freescale}/imx6dl-tx6u-811x.dts  |    0
 .../{ => freescale}/imx6dl-tx6u-81xx-mb7.dts  |    0
 .../boot/dts/{ => freescale}/imx6dl-udoo.dts  |    0
 .../dts/{ => freescale}/imx6dl-victgo.dts     |    0
 .../dts/{ => freescale}/imx6dl-vicut1.dts     |    0
 .../imx6dl-wandboard-revb1.dts                |    0
 .../imx6dl-wandboard-revd1.dts                |    0
 .../dts/{ => freescale}/imx6dl-wandboard.dts  |    0
 .../{ => freescale}/imx6dl-yapp4-common.dtsi  |    0
 .../{ => freescale}/imx6dl-yapp4-draco.dts    |    0
 .../{ => freescale}/imx6dl-yapp4-hydra.dts    |    0
 .../{ => freescale}/imx6dl-yapp4-orion.dts    |    0
 .../dts/{ => freescale}/imx6dl-yapp4-ursa.dts |    0
 arch/arm/boot/dts/{ => freescale}/imx6dl.dtsi |    0
 .../dts/{ => freescale}/imx6q-apalis-eval.dts |    0
 .../imx6q-apalis-ixora-v1.1.dts               |    0
 .../{ => freescale}/imx6q-apalis-ixora.dts    |    0
 .../dts/{ => freescale}/imx6q-apf6dev.dts     |    0
 .../boot/dts/{ => freescale}/imx6q-arm2.dts   |    0
 .../boot/dts/{ => freescale}/imx6q-b450v3.dts |    0
 .../boot/dts/{ => freescale}/imx6q-b650v3.dts |    0
 .../boot/dts/{ => freescale}/imx6q-b850v3.dts |    0
 .../boot/dts/{ => freescale}/imx6q-ba16.dtsi  |    0
 .../dts/{ => freescale}/imx6q-bx50v3.dtsi     |    0
 .../boot/dts/{ => freescale}/imx6q-cm-fx6.dts |    0
 .../imx6q-cubox-i-emmc-som-v15.dts            |    0
 .../{ => freescale}/imx6q-cubox-i-som-v15.dts |    0
 .../dts/{ => freescale}/imx6q-cubox-i.dts     |    0
 .../{ => freescale}/imx6q-dfi-fs700-m60.dts   |    0
 .../dts/{ => freescale}/imx6q-dhcom-pdk2.dts  |    0
 .../imx6q-display5-tianma-tm070-1280x768.dts  |    0
 .../dts/{ => freescale}/imx6q-display5.dtsi   |    0
 .../dts/{ => freescale}/imx6q-dmo-edmqmx6.dts |    0
 .../dts/{ => freescale}/imx6q-dms-ba16.dts    |    0
 .../arm/boot/dts/{ => freescale}/imx6q-ds.dts |    0
 .../dts/{ => freescale}/imx6q-emcon-avari.dts |    0
 .../boot/dts/{ => freescale}/imx6q-evi.dts    |    0
 .../boot/dts/{ => freescale}/imx6q-gk802.dts  |    0
 .../boot/dts/{ => freescale}/imx6q-gw51xx.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw52xx.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw53xx.dts |    0
 .../dts/{ => freescale}/imx6q-gw5400-a.dts    |    0
 .../boot/dts/{ => freescale}/imx6q-gw54xx.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw551x.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw552x.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw553x.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw560x.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw5903.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw5904.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw5907.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw5910.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw5912.dts |    0
 .../boot/dts/{ => freescale}/imx6q-gw5913.dts |    0
 .../boot/dts/{ => freescale}/imx6q-h100.dts   |    0
 .../imx6q-hummingboard-emmc-som-v15.dts       |    0
 .../imx6q-hummingboard-som-v15.dts            |    0
 .../{ => freescale}/imx6q-hummingboard.dts    |    0
 .../imx6q-hummingboard2-emmc-som-v15.dts      |    0
 .../imx6q-hummingboard2-som-v15.dts           |    0
 .../{ => freescale}/imx6q-hummingboard2.dts   |    0
 .../dts/{ => freescale}/imx6q-icore-mipi.dts  |    0
 .../{ => freescale}/imx6q-icore-ofcap10.dts   |    0
 .../{ => freescale}/imx6q-icore-ofcap12.dts   |    0
 .../dts/{ => freescale}/imx6q-icore-rqs.dts   |    0
 .../boot/dts/{ => freescale}/imx6q-icore.dts  |    0
 .../{ => freescale}/imx6q-kontron-samx6i.dtsi |    0
 .../boot/dts/{ => freescale}/imx6q-kp-tpc.dts |    0
 .../boot/dts/{ => freescale}/imx6q-kp.dtsi    |    0
 .../dts/{ => freescale}/imx6q-logicpd.dts     |    0
 .../dts/{ => freescale}/imx6q-marsboard.dts   |    0
 .../boot/dts/{ => freescale}/imx6q-mba6.dtsi  |    0
 .../boot/dts/{ => freescale}/imx6q-mba6a.dts  |    0
 .../boot/dts/{ => freescale}/imx6q-mba6b.dts  |    0
 .../dts/{ => freescale}/imx6q-mccmon6.dts     |    0
 .../{ => freescale}/imx6q-nitrogen6_max.dts   |    0
 .../{ => freescale}/imx6q-nitrogen6_som2.dts  |    0
 .../dts/{ => freescale}/imx6q-nitrogen6x.dts  |    0
 .../boot/dts/{ => freescale}/imx6q-novena.dts |    0
 .../imx6q-phytec-mira-rdk-emmc.dts            |    0
 .../imx6q-phytec-mira-rdk-nand.dts            |    0
 .../{ => freescale}/imx6q-phytec-pbab01.dts   |    0
 .../{ => freescale}/imx6q-phytec-pfla02.dtsi  |    0
 .../dts/{ => freescale}/imx6q-pico-dwarf.dts  |    0
 .../dts/{ => freescale}/imx6q-pico-hobbit.dts |    0
 .../dts/{ => freescale}/imx6q-pico-nymph.dts  |    0
 .../dts/{ => freescale}/imx6q-pico-pi.dts     |    0
 .../boot/dts/{ => freescale}/imx6q-pinfunc.h  |    0
 .../dts/{ => freescale}/imx6q-pistachio.dts   |    0
 .../boot/dts/{ => freescale}/imx6q-prti6q.dts |    0
 .../boot/dts/{ => freescale}/imx6q-prtwd2.dts |    0
 .../dts/{ => freescale}/imx6q-rex-pro.dts     |    0
 .../dts/{ => freescale}/imx6q-sabreauto.dts   |    0
 .../dts/{ => freescale}/imx6q-sabrelite.dts   |    0
 .../dts/{ => freescale}/imx6q-sabresd.dts     |    0
 .../dts/{ => freescale}/imx6q-savageboard.dts |    0
 .../boot/dts/{ => freescale}/imx6q-sbc6x.dts  |    0
 .../{ => freescale}/imx6q-skov-revc-lt2.dts   |    0
 .../{ => freescale}/imx6q-skov-revc-lt6.dts   |    0
 .../imx6q-skov-reve-mi1010ait-1cp1.dts        |    0
 .../dts/{ => freescale}/imx6q-solidsense.dts  |    0
 .../dts/{ => freescale}/imx6q-tbs2910.dts     |    0
 .../dts/{ => freescale}/imx6q-tqma6a.dtsi     |    0
 .../dts/{ => freescale}/imx6q-tqma6b.dtsi     |    0
 .../boot/dts/{ => freescale}/imx6q-ts4900.dts |    0
 .../boot/dts/{ => freescale}/imx6q-ts7970.dts |    0
 .../imx6q-tx6q-1010-comtft.dts                |    0
 .../dts/{ => freescale}/imx6q-tx6q-1010.dts   |    0
 .../imx6q-tx6q-1020-comtft.dts                |    0
 .../dts/{ => freescale}/imx6q-tx6q-1020.dts   |    0
 .../{ => freescale}/imx6q-tx6q-1036-mb7.dts   |    0
 .../dts/{ => freescale}/imx6q-tx6q-1036.dts   |    0
 .../{ => freescale}/imx6q-tx6q-10x0-mb7.dts   |    0
 .../dts/{ => freescale}/imx6q-tx6q-1110.dts   |    0
 .../{ => freescale}/imx6q-tx6q-11x0-mb7.dts   |    0
 .../boot/dts/{ => freescale}/imx6q-udoo.dts   |    0
 .../dts/{ => freescale}/imx6q-utilite-pro.dts |    0
 .../imx6q-var-dt6customboard.dts              |    0
 .../boot/dts/{ => freescale}/imx6q-vicut1.dts |    0
 .../{ => freescale}/imx6q-wandboard-revb1.dts |    0
 .../{ => freescale}/imx6q-wandboard-revd1.dts |    0
 .../dts/{ => freescale}/imx6q-wandboard.dts   |    0
 .../dts/{ => freescale}/imx6q-yapp4-crux.dts  |    0
 .../dts/{ => freescale}/imx6q-zii-rdu2.dts    |    0
 arch/arm/boot/dts/{ => freescale}/imx6q.dtsi  |    0
 .../dts/{ => freescale}/imx6qdl-apalis.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-apf6.dtsi     |    0
 .../dts/{ => freescale}/imx6qdl-apf6dev.dtsi  |    0
 .../{ => freescale}/imx6qdl-aristainetos.dtsi |    0
 .../imx6qdl-aristainetos2.dtsi                |    0
 .../imx6qdl-colibri-v1_1-uhs.dtsi             |    0
 .../dts/{ => freescale}/imx6qdl-colibri.dtsi  |    0
 .../dts/{ => freescale}/imx6qdl-cubox-i.dtsi  |    0
 .../imx6qdl-dfi-fs700-m60.dtsi                |    0
 .../{ => freescale}/imx6qdl-dhcom-drc02.dtsi  |    0
 .../{ => freescale}/imx6qdl-dhcom-pdk2.dtsi   |    0
 .../imx6qdl-dhcom-picoitx.dtsi                |    0
 .../{ => freescale}/imx6qdl-dhcom-som.dtsi    |    0
 .../boot/dts/{ => freescale}/imx6qdl-ds.dtsi  |    0
 .../{ => freescale}/imx6qdl-emcon-avari.dtsi  |    0
 .../dts/{ => freescale}/imx6qdl-emcon.dtsi    |    0
 .../dts/{ => freescale}/imx6qdl-gw51xx.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw52xx.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw53xx.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw54xx.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw551x.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw552x.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw553x.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw560x.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw5903.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw5904.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw5907.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw5910.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw5912.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-gw5913.dtsi   |    0
 .../{ => freescale}/imx6qdl-hummingboard.dtsi |    0
 .../imx6qdl-hummingboard2-emmc.dtsi           |    0
 .../imx6qdl-hummingboard2.dtsi                |    0
 .../{ => freescale}/imx6qdl-icore-1.5.dtsi    |    0
 .../{ => freescale}/imx6qdl-icore-rqs.dtsi    |    0
 .../dts/{ => freescale}/imx6qdl-icore.dtsi    |    0
 .../imx6qdl-kontron-samx6i.dtsi               |    0
 .../dts/{ => freescale}/imx6qdl-mba6.dtsi     |    0
 .../dts/{ => freescale}/imx6qdl-mba6a.dtsi    |    0
 .../dts/{ => freescale}/imx6qdl-mba6b.dtsi    |    0
 .../{ => freescale}/imx6qdl-nit6xlite.dtsi    |    0
 .../imx6qdl-nitrogen6_max.dtsi                |    0
 .../imx6qdl-nitrogen6_som2.dtsi               |    0
 .../{ => freescale}/imx6qdl-nitrogen6x.dtsi   |    0
 .../imx6qdl-phytec-mira-peb-av-02.dtsi        |    0
 .../imx6qdl-phytec-mira-peb-eval-01.dtsi      |    0
 .../imx6qdl-phytec-mira-peb-wlbt-05.dtsi      |    0
 .../{ => freescale}/imx6qdl-phytec-mira.dtsi  |    0
 .../imx6qdl-phytec-pbab01.dtsi                |    0
 .../imx6qdl-phytec-pfla02.dtsi                |    0
 .../imx6qdl-phytec-phycore-som.dtsi           |    0
 .../{ => freescale}/imx6qdl-pico-dwarf.dtsi   |    0
 .../{ => freescale}/imx6qdl-pico-hobbit.dtsi  |    0
 .../{ => freescale}/imx6qdl-pico-nymph.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-pico-pi.dtsi  |    0
 .../dts/{ => freescale}/imx6qdl-pico.dtsi     |    0
 .../dts/{ => freescale}/imx6qdl-prti6q.dtsi   |    0
 .../boot/dts/{ => freescale}/imx6qdl-rex.dtsi |    0
 .../{ => freescale}/imx6qdl-sabreauto.dtsi    |    0
 .../{ => freescale}/imx6qdl-sabrelite.dtsi    |    0
 .../dts/{ => freescale}/imx6qdl-sabresd.dtsi  |    0
 .../{ => freescale}/imx6qdl-savageboard.dtsi  |    0
 .../imx6qdl-skov-cpu-revc.dtsi                |    0
 .../dts/{ => freescale}/imx6qdl-skov-cpu.dtsi |    0
 .../imx6qdl-skov-revc-lt2.dtsi                |    0
 .../{ => freescale}/imx6qdl-solidsense.dtsi   |    0
 .../{ => freescale}/imx6qdl-sr-som-brcm.dtsi  |    0
 .../{ => freescale}/imx6qdl-sr-som-emmc.dtsi  |    0
 .../{ => freescale}/imx6qdl-sr-som-ti.dtsi    |    0
 .../dts/{ => freescale}/imx6qdl-sr-som.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-tqma6.dtsi    |    0
 .../dts/{ => freescale}/imx6qdl-tqma6a.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-tqma6b.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-ts4900.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-ts7970.dtsi   |    0
 .../dts/{ => freescale}/imx6qdl-tx6-lcd.dtsi  |    0
 .../dts/{ => freescale}/imx6qdl-tx6-lvds.dtsi |    0
 .../dts/{ => freescale}/imx6qdl-tx6-mb7.dtsi  |    0
 .../boot/dts/{ => freescale}/imx6qdl-tx6.dtsi |    0
 .../dts/{ => freescale}/imx6qdl-udoo.dtsi     |    0
 .../dts/{ => freescale}/imx6qdl-var-dart.dtsi |    0
 .../dts/{ => freescale}/imx6qdl-vicut1.dtsi   |    0
 .../imx6qdl-wandboard-revb1.dtsi              |    0
 .../imx6qdl-wandboard-revc1.dtsi              |    0
 .../imx6qdl-wandboard-revd1.dtsi              |    0
 .../{ => freescale}/imx6qdl-wandboard.dtsi    |    0
 .../dts/{ => freescale}/imx6qdl-zii-rdu2.dtsi |    0
 .../arm/boot/dts/{ => freescale}/imx6qdl.dtsi |    0
 .../boot/dts/{ => freescale}/imx6qp-mba6b.dts |    0
 .../{ => freescale}/imx6qp-nitrogen6_max.dts  |    0
 .../{ => freescale}/imx6qp-nitrogen6_som2.dts |    0
 .../imx6qp-phytec-mira-rdk-nand.dts           |    0
 .../dts/{ => freescale}/imx6qp-prtwd3.dts     |    0
 .../dts/{ => freescale}/imx6qp-sabreauto.dts  |    0
 .../dts/{ => freescale}/imx6qp-sabresd.dts    |    0
 .../dts/{ => freescale}/imx6qp-tqma6b.dtsi    |    0
 .../{ => freescale}/imx6qp-tx6qp-8037-mb7.dts |    0
 .../dts/{ => freescale}/imx6qp-tx6qp-8037.dts |    0
 .../{ => freescale}/imx6qp-tx6qp-8137-mb7.dts |    0
 .../dts/{ => freescale}/imx6qp-tx6qp-8137.dts |    0
 .../dts/{ => freescale}/imx6qp-vicutp.dts     |    0
 .../imx6qp-wandboard-revd1.dts                |    0
 .../imx6qp-yapp4-crux-plus.dts                |    0
 .../dts/{ => freescale}/imx6qp-zii-rdu2.dts   |    0
 arch/arm/boot/dts/{ => freescale}/imx6qp.dtsi |    0
 .../dts/{ => freescale}/imx6s-dhcom-drc02.dts |    0
 .../boot/dts/{ => freescale}/imx6sl-evk.dts   |    0
 .../boot/dts/{ => freescale}/imx6sl-pinfunc.h |    0
 .../imx6sl-tolino-shine2hd.dts                |    0
 .../{ => freescale}/imx6sl-tolino-shine3.dts  |    0
 .../{ => freescale}/imx6sl-tolino-vision5.dts |    0
 .../boot/dts/{ => freescale}/imx6sl-warp.dts  |    0
 arch/arm/boot/dts/{ => freescale}/imx6sl.dtsi |    0
 .../boot/dts/{ => freescale}/imx6sll-evk.dts  |    0
 .../{ => freescale}/imx6sll-kobo-clarahd.dts  |    0
 .../{ => freescale}/imx6sll-kobo-librah2o.dts |    0
 .../dts/{ => freescale}/imx6sll-pinfunc.h     |    0
 .../arm/boot/dts/{ => freescale}/imx6sll.dtsi |    0
 .../{ => freescale}/imx6sx-nitrogen6sx.dts    |    0
 .../boot/dts/{ => freescale}/imx6sx-pinfunc.h |    0
 .../dts/{ => freescale}/imx6sx-sabreauto.dts  |    0
 .../dts/{ => freescale}/imx6sx-sdb-mqs.dts    |    0
 .../dts/{ => freescale}/imx6sx-sdb-reva.dts   |    0
 .../dts/{ => freescale}/imx6sx-sdb-sai.dts    |    0
 .../boot/dts/{ => freescale}/imx6sx-sdb.dts   |    0
 .../boot/dts/{ => freescale}/imx6sx-sdb.dtsi  |    0
 .../imx6sx-softing-vining-2000.dts            |    0
 .../{ => freescale}/imx6sx-udoo-neo-basic.dts |    0
 .../imx6sx-udoo-neo-extended.dts              |    0
 .../{ => freescale}/imx6sx-udoo-neo-full.dts  |    0
 .../dts/{ => freescale}/imx6sx-udoo-neo.dtsi  |    0
 arch/arm/boot/dts/{ => freescale}/imx6sx.dtsi |    0
 .../dts/{ => freescale}/imx6ul-14x14-evk.dts  |    0
 .../dts/{ => freescale}/imx6ul-14x14-evk.dtsi |    0
 .../imx6ul-ccimx6ulsbcexpress.dts             |    0
 .../{ => freescale}/imx6ul-ccimx6ulsbcpro.dts |    0
 .../{ => freescale}/imx6ul-ccimx6ulsom.dtsi   |    0
 .../boot/dts/{ => freescale}/imx6ul-geam.dts  |    0
 .../imx6ul-imx6ull-opos6ul.dtsi               |    0
 .../imx6ul-imx6ull-opos6uldev.dtsi            |    0
 .../dts/{ => freescale}/imx6ul-isiot-emmc.dts |    0
 .../dts/{ => freescale}/imx6ul-isiot-nand.dts |    0
 .../dts/{ => freescale}/imx6ul-isiot.dtsi     |    0
 .../imx6ul-kontron-n6310-s-43.dts             |    0
 .../imx6ul-kontron-n6310-s.dts                |    0
 .../imx6ul-kontron-n6310-som.dtsi             |    0
 .../imx6ul-kontron-n6311-s.dts                |    0
 .../imx6ul-kontron-n6311-som.dtsi             |    0
 .../imx6ul-kontron-n6x1x-s.dtsi               |    0
 .../imx6ul-kontron-n6x1x-som-common.dtsi      |    0
 .../dts/{ => freescale}/imx6ul-liteboard.dts  |    0
 .../dts/{ => freescale}/imx6ul-litesom.dtsi   |    0
 .../dts/{ => freescale}/imx6ul-opos6ul.dtsi   |    0
 .../dts/{ => freescale}/imx6ul-opos6uldev.dts |    0
 .../imx6ul-phytec-phycore-som.dtsi            |    0
 .../imx6ul-phytec-segin-ff-rdk-emmc.dts       |    0
 .../imx6ul-phytec-segin-ff-rdk-nand.dts       |    0
 .../imx6ul-phytec-segin-peb-av-02.dtsi        |    0
 .../imx6ul-phytec-segin-peb-eval-01.dtsi      |    0
 .../imx6ul-phytec-segin-peb-wlbt-05.dtsi      |    0
 .../{ => freescale}/imx6ul-phytec-segin.dtsi  |    0
 .../dts/{ => freescale}/imx6ul-pico-dwarf.dts |    0
 .../{ => freescale}/imx6ul-pico-hobbit.dts    |    0
 .../dts/{ => freescale}/imx6ul-pico-pi.dts    |    0
 .../boot/dts/{ => freescale}/imx6ul-pico.dtsi |    0
 .../boot/dts/{ => freescale}/imx6ul-pinfunc.h |    0
 .../dts/{ => freescale}/imx6ul-prti6g.dts     |    0
 .../dts/{ => freescale}/imx6ul-tx6ul-0010.dts |    0
 .../dts/{ => freescale}/imx6ul-tx6ul-0011.dts |    0
 .../imx6ul-tx6ul-mainboard.dts                |    0
 .../dts/{ => freescale}/imx6ul-tx6ul.dtsi     |    0
 arch/arm/boot/dts/{ => freescale}/imx6ul.dtsi |    0
 .../dts/{ => freescale}/imx6ull-14x14-evk.dts |    0
 .../imx6ull-colibri-emmc-eval-v3.dts          |    0
 .../imx6ull-colibri-emmc-nonwifi.dtsi         |    0
 .../imx6ull-colibri-eval-v3.dts               |    0
 .../imx6ull-colibri-eval-v3.dtsi              |    0
 .../imx6ull-colibri-nonwifi.dtsi              |    0
 .../imx6ull-colibri-wifi-eval-v3.dts          |    0
 .../{ => freescale}/imx6ull-colibri-wifi.dtsi |    0
 .../dts/{ => freescale}/imx6ull-colibri.dtsi  |    0
 .../dts/{ => freescale}/imx6ull-jozacp.dts    |    0
 .../imx6ull-kontron-n6411-s.dts               |    0
 .../imx6ull-kontron-n6411-som.dtsi            |    0
 .../imx6ull-myir-mys-6ulx-eval.dts            |    0
 .../imx6ull-myir-mys-6ulx.dtsi                |    0
 .../dts/{ => freescale}/imx6ull-opos6ul.dtsi  |    0
 .../{ => freescale}/imx6ull-opos6uldev.dts    |    0
 .../imx6ull-phytec-phycore-som.dtsi           |    0
 .../imx6ull-phytec-segin-ff-rdk-emmc.dts      |    0
 .../imx6ull-phytec-segin-ff-rdk-nand.dts      |    0
 .../imx6ull-phytec-segin-lc-rdk-nand.dts      |    0
 .../imx6ull-phytec-segin-peb-av-02.dtsi       |    0
 .../imx6ull-phytec-segin-peb-eval-01.dtsi     |    0
 .../imx6ull-phytec-segin-peb-wlbt-05.dtsi     |    0
 .../{ => freescale}/imx6ull-phytec-segin.dtsi |    0
 .../{ => freescale}/imx6ull-pinfunc-snvs.h    |    0
 .../dts/{ => freescale}/imx6ull-pinfunc.h     |    0
 .../arm/boot/dts/{ => freescale}/imx6ull.dtsi |    0
 .../dts/{ => freescale}/imx6ulz-14x14-evk.dts |    0
 .../{ => freescale}/imx6ulz-bsh-smm-m2.dts    |    0
 .../arm/boot/dts/{ => freescale}/imx6ulz.dtsi |    0
 .../{ => freescale}/imx7-colibri-aster.dtsi   |    0
 .../{ => freescale}/imx7-colibri-eval-v3.dtsi |    0
 .../dts/{ => freescale}/imx7-colibri.dtsi     |    0
 .../boot/dts/{ => freescale}/imx7-mba7.dtsi   |    0
 .../boot/dts/{ => freescale}/imx7-tqma7.dtsi  |    0
 .../dts/{ => freescale}/imx7d-cl-som-imx7.dts |    0
 .../{ => freescale}/imx7d-colibri-aster.dts   |    0
 .../imx7d-colibri-emmc-aster.dts              |    0
 .../imx7d-colibri-emmc-eval-v3.dts            |    0
 .../{ => freescale}/imx7d-colibri-emmc.dtsi   |    0
 .../{ => freescale}/imx7d-colibri-eval-v3.dts |    0
 .../dts/{ => freescale}/imx7d-colibri.dtsi    |    0
 .../imx7d-flex-concentrator-mfg.dts           |    0
 .../imx7d-flex-concentrator.dts               |    0
 .../boot/dts/{ => freescale}/imx7d-mba7.dts   |    0
 .../dts/{ => freescale}/imx7d-meerkat96.dts   |    0
 .../dts/{ => freescale}/imx7d-nitrogen7.dts   |    0
 .../dts/{ => freescale}/imx7d-pico-dwarf.dts  |    0
 .../dts/{ => freescale}/imx7d-pico-hobbit.dts |    0
 .../dts/{ => freescale}/imx7d-pico-nymph.dts  |    0
 .../dts/{ => freescale}/imx7d-pico-pi.dts     |    0
 .../boot/dts/{ => freescale}/imx7d-pico.dtsi  |    0
 .../boot/dts/{ => freescale}/imx7d-pinfunc.h  |    0
 .../dts/{ => freescale}/imx7d-remarkable2.dts |    0
 .../dts/{ => freescale}/imx7d-sbc-imx7.dts    |    0
 .../dts/{ => freescale}/imx7d-sdb-reva.dts    |    0
 .../dts/{ => freescale}/imx7d-sdb-sht11.dts   |    0
 .../boot/dts/{ => freescale}/imx7d-sdb.dts    |    0
 .../boot/dts/{ => freescale}/imx7d-tqma7.dtsi |    0
 .../dts/{ => freescale}/imx7d-zii-rmu2.dts    |    0
 .../dts/{ => freescale}/imx7d-zii-rpu2.dts    |    0
 arch/arm/boot/dts/{ => freescale}/imx7d.dtsi  |    0
 .../{ => freescale}/imx7s-colibri-aster.dts   |    0
 .../{ => freescale}/imx7s-colibri-eval-v3.dts |    0
 .../dts/{ => freescale}/imx7s-colibri.dtsi    |    0
 .../boot/dts/{ => freescale}/imx7s-mba7.dts   |    0
 .../boot/dts/{ => freescale}/imx7s-tqma7.dtsi |    0
 .../boot/dts/{ => freescale}/imx7s-warp.dts   |    0
 arch/arm/boot/dts/{ => freescale}/imx7s.dtsi  |    0
 .../boot/dts/{ => freescale}/imx7ulp-com.dts  |    0
 .../boot/dts/{ => freescale}/imx7ulp-evk.dts  |    0
 .../dts/{ => freescale}/imx7ulp-pinfunc.h     |    0
 .../arm/boot/dts/{ => freescale}/imx7ulp.dtsi |    0
 .../dts/{ => freescale}/imxrt1050-pinfunc.h   |    0
 .../boot/dts/{ => freescale}/mxs-pinfunc.h    |    0
 arch/arm/boot/dts/hisilicon/Makefile          |   13 +
 .../boot/dts/{ => hisilicon}/hi3519-demb.dts  |    0
 arch/arm/boot/dts/{ => hisilicon}/hi3519.dtsi |    0
 .../dts/{ => hisilicon}/hi3620-hi4511.dts     |    0
 arch/arm/boot/dts/{ => hisilicon}/hi3620.dtsi |    0
 .../boot/dts/{ => hisilicon}/hip01-ca9x2.dts  |    0
 arch/arm/boot/dts/{ => hisilicon}/hip01.dtsi  |    0
 .../boot/dts/{ => hisilicon}/hip04-d01.dts    |    0
 arch/arm/boot/dts/{ => hisilicon}/hip04.dtsi  |    0
 .../dts/{ => hisilicon}/hisi-x5hd2-dkb.dts    |    0
 .../boot/dts/{ => hisilicon}/hisi-x5hd2.dtsi  |    0
 arch/arm/boot/dts/{ => hisilicon}/sd5203.dts  |    0
 arch/arm/boot/dts/intel/Makefile              |   16 +
 arch/arm/boot/dts/{ => intel}/socfpga.dtsi    |    0
 .../boot/dts/{ => intel}/socfpga_arria10.dtsi |    0
 .../socfpga_arria10_mercury_aa1.dts           |    0
 .../{ => intel}/socfpga_arria10_socdk.dtsi    |    0
 .../socfpga_arria10_socdk_nand.dts            |    0
 .../socfpga_arria10_socdk_qspi.dts            |    0
 .../socfpga_arria10_socdk_sdmmc.dts           |    0
 .../boot/dts/{ => intel}/socfpga_arria5.dtsi  |    0
 .../dts/{ => intel}/socfpga_arria5_socdk.dts  |    0
 .../dts/{ => intel}/socfpga_cyclone5.dtsi     |    0
 .../socfpga_cyclone5_chameleon96.dts          |    0
 .../socfpga_cyclone5_de0_nano_soc.dts         |    0
 .../dts/{ => intel}/socfpga_cyclone5_mcv.dtsi |    0
 .../{ => intel}/socfpga_cyclone5_mcvevk.dts   |    0
 .../{ => intel}/socfpga_cyclone5_socdk.dts    |    0
 .../{ => intel}/socfpga_cyclone5_sockit.dts   |    0
 .../{ => intel}/socfpga_cyclone5_socrates.dts |    0
 .../{ => intel}/socfpga_cyclone5_sodia.dts    |    0
 .../socfpga_cyclone5_vining_fpga.dts          |    0
 arch/arm/boot/dts/{ => intel}/socfpga_vt.dts  |    0
 arch/arm/boot/dts/kirkwood/Makefile           |   80 +
 .../dts/{ => kirkwood}/kirkwood-6192.dtsi     |    0
 .../dts/{ => kirkwood}/kirkwood-6281.dtsi     |    0
 .../dts/{ => kirkwood}/kirkwood-6282.dtsi     |    0
 .../dts/{ => kirkwood}/kirkwood-98dx4122.dtsi |    0
 .../boot/dts/{ => kirkwood}/kirkwood-b3.dts   |    0
 .../kirkwood-blackarmor-nas220.dts            |    0
 .../dts/{ => kirkwood}/kirkwood-c200-v1.dts   |    0
 .../dts/{ => kirkwood}/kirkwood-cloudbox.dts  |    0
 .../dts/{ => kirkwood}/kirkwood-d2net.dts     |    0
 .../{ => kirkwood}/kirkwood-db-88f6281.dts    |    0
 .../{ => kirkwood}/kirkwood-db-88f6282.dts    |    0
 .../boot/dts/{ => kirkwood}/kirkwood-db.dtsi  |    0
 .../dts/{ => kirkwood}/kirkwood-dir665.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-dns320.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-dns325.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-dnskw.dtsi    |    0
 .../dts/{ => kirkwood}/kirkwood-dockstar.dts  |    0
 .../dts/{ => kirkwood}/kirkwood-dreamplug.dts |    0
 .../dts/{ => kirkwood}/kirkwood-ds109.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds110jv10.dts |    0
 .../dts/{ => kirkwood}/kirkwood-ds111.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds112.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds209.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds210.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds212.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds212j.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-ds409.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds409slim.dts |    0
 .../dts/{ => kirkwood}/kirkwood-ds411.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-ds411j.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-ds411slim.dts |    0
 .../dts/{ => kirkwood}/kirkwood-goflexnet.dts |    0
 .../kirkwood-guruplug-server-plus.dts         |    0
 .../dts/{ => kirkwood}/kirkwood-ib62x0.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-iconnect.dts  |    0
 .../kirkwood-iomega_ix2_200.dts               |    0
 .../boot/dts/{ => kirkwood}/kirkwood-is2.dts  |    0
 .../{ => kirkwood}/kirkwood-km_common.dtsi    |    0
 .../{ => kirkwood}/kirkwood-km_fixedeth.dts   |    0
 .../{ => kirkwood}/kirkwood-km_kirkwood.dts   |    0
 .../boot/dts/{ => kirkwood}/kirkwood-l-50.dts |    0
 .../dts/{ => kirkwood}/kirkwood-laplug.dts    |    0
 .../kirkwood-linkstation-6282.dtsi            |    0
 .../kirkwood-linkstation-duo-6281.dtsi        |    0
 .../kirkwood-linkstation-lsqvl.dts            |    0
 .../kirkwood-linkstation-lsvl.dts             |    0
 .../kirkwood-linkstation-lswsxl.dts           |    0
 .../kirkwood-linkstation-lswvl.dts            |    0
 .../kirkwood-linkstation-lswxl.dts            |    0
 .../{ => kirkwood}/kirkwood-linkstation.dtsi  |    0
 .../{ => kirkwood}/kirkwood-linksys-viper.dts |    0
 .../dts/{ => kirkwood}/kirkwood-lschlv2.dts   |    0
 .../dts/{ => kirkwood}/kirkwood-lsxhl.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-lsxl.dtsi     |    0
 .../dts/{ => kirkwood}/kirkwood-mplcec4.dts   |    0
 .../kirkwood-mv88f6281gtw-ge.dts              |    0
 .../dts/{ => kirkwood}/kirkwood-nas2big.dts   |    0
 .../dts/{ => kirkwood}/kirkwood-net2big.dts   |    0
 .../dts/{ => kirkwood}/kirkwood-net5big.dts   |    0
 .../kirkwood-netgear_readynas_duo_v2.dts      |    0
 .../kirkwood-netgear_readynas_nv+_v2.dts      |    0
 .../dts/{ => kirkwood}/kirkwood-netxbig.dtsi  |    0
 .../{ => kirkwood}/kirkwood-ns2-common.dtsi   |    0
 .../boot/dts/{ => kirkwood}/kirkwood-ns2.dts  |    0
 .../dts/{ => kirkwood}/kirkwood-ns2lite.dts   |    0
 .../dts/{ => kirkwood}/kirkwood-ns2max.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-ns2mini.dts   |    0
 .../dts/{ => kirkwood}/kirkwood-nsa310.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-nsa310a.dts   |    0
 .../dts/{ => kirkwood}/kirkwood-nsa320.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-nsa325.dts    |    0
 .../kirkwood-nsa3x0-common.dtsi               |    0
 .../{ => kirkwood}/kirkwood-openblocks_a6.dts |    0
 .../{ => kirkwood}/kirkwood-openblocks_a7.dts |    0
 .../{ => kirkwood}/kirkwood-openrd-base.dts   |    0
 .../{ => kirkwood}/kirkwood-openrd-client.dts |    0
 .../kirkwood-openrd-ultimate.dts              |    0
 .../dts/{ => kirkwood}/kirkwood-openrd.dtsi   |    0
 .../dts/{ => kirkwood}/kirkwood-pogo_e02.dts  |    0
 .../kirkwood-pogoplug-series-4.dts            |    0
 .../dts/{ => kirkwood}/kirkwood-rd88f6192.dts |    0
 .../{ => kirkwood}/kirkwood-rd88f6281-a.dts   |    0
 .../{ => kirkwood}/kirkwood-rd88f6281-z0.dts  |    0
 .../{ => kirkwood}/kirkwood-rd88f6281.dtsi    |    0
 .../dts/{ => kirkwood}/kirkwood-rs212.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-rs409.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-rs411.dts     |    0
 .../kirkwood-sheevaplug-common.dtsi           |    0
 .../kirkwood-sheevaplug-esata.dts             |    0
 .../{ => kirkwood}/kirkwood-sheevaplug.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-synology.dtsi |    0
 .../dts/{ => kirkwood}/kirkwood-t5325.dts     |    0
 .../dts/{ => kirkwood}/kirkwood-topkick.dts   |    0
 .../{ => kirkwood}/kirkwood-ts219-6281.dts    |    0
 .../{ => kirkwood}/kirkwood-ts219-6282.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-ts219.dtsi    |    0
 .../{ => kirkwood}/kirkwood-ts419-6281.dts    |    0
 .../{ => kirkwood}/kirkwood-ts419-6282.dts    |    0
 .../dts/{ => kirkwood}/kirkwood-ts419.dtsi    |    0
 .../arm/boot/dts/{ => kirkwood}/kirkwood.dtsi |    0
 arch/arm/boot/dts/layerscape/Makefile         |    6 +
 .../ls1021a-moxa-uc-8410a.dts                 |    0
 .../boot/dts/{ => layerscape}/ls1021a-qds.dts |    0
 .../boot/dts/{ => layerscape}/ls1021a-tsn.dts |    0
 .../boot/dts/{ => layerscape}/ls1021a-twr.dts |    0
 .../boot/dts/{ => layerscape}/ls1021a.dtsi    |    0
 arch/arm/boot/dts/marvell/Makefile            |   86 +
 .../dts/{ => marvell}/armada-370-c200-v2.dts  |    0
 .../boot/dts/{ => marvell}/armada-370-db.dts  |    0
 .../armada-370-dlink-dns327l.dts              |    0
 .../dts/{ => marvell}/armada-370-mirabox.dts  |    0
 .../armada-370-netgear-rn102.dts              |    0
 .../armada-370-netgear-rn104.dts              |    0
 .../boot/dts/{ => marvell}/armada-370-rd.dts  |    0
 .../armada-370-seagate-nas-2bay.dts           |    0
 .../armada-370-seagate-nas-4bay.dts           |    0
 .../armada-370-seagate-nas-xbay.dtsi          |    0
 ...armada-370-seagate-personal-cloud-2bay.dts |    0
 .../armada-370-seagate-personal-cloud.dts     |    0
 .../armada-370-seagate-personal-cloud.dtsi    |    0
 .../armada-370-synology-ds213j.dts            |    0
 .../boot/dts/{ => marvell}/armada-370-xp.dtsi |    0
 .../boot/dts/{ => marvell}/armada-370.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-375-db.dts  |    0
 .../boot/dts/{ => marvell}/armada-375.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-380.dtsi    |    0
 .../armada-381-netgear-gs110emx.dts           |    0
 .../armada-382-rd-ac3x-48g4x2xl.dts           |    0
 .../dts/{ => marvell}/armada-385-atl-x530.dts |    0
 .../armada-385-clearfog-gtr-l8.dts            |    0
 .../armada-385-clearfog-gtr-s4.dts            |    0
 .../armada-385-clearfog-gtr.dtsi              |    0
 .../armada-385-db-88f6820-amc.dts             |    0
 .../dts/{ => marvell}/armada-385-db-ap.dts    |    0
 .../armada-385-linksys-caiman.dts             |    0
 .../armada-385-linksys-cobra.dts              |    0
 .../armada-385-linksys-rango.dts              |    0
 .../armada-385-linksys-shelby.dts             |    0
 .../dts/{ => marvell}/armada-385-linksys.dtsi |    0
 .../armada-385-synology-ds116.dts             |    0
 .../{ => marvell}/armada-385-turris-omnia.dts |    0
 .../boot/dts/{ => marvell}/armada-385.dtsi    |    0
 .../armada-388-clearfog-base.dts              |    0
 .../{ => marvell}/armada-388-clearfog-pro.dts |    0
 .../dts/{ => marvell}/armada-388-clearfog.dts |    0
 .../{ => marvell}/armada-388-clearfog.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-388-db.dts  |    0
 .../boot/dts/{ => marvell}/armada-388-gp.dts  |    0
 .../dts/{ => marvell}/armada-388-helios4.dts  |    0
 .../boot/dts/{ => marvell}/armada-388-rd.dts  |    0
 .../boot/dts/{ => marvell}/armada-388.dtsi    |    0
 .../armada-38x-solidrun-microsom.dtsi         |    0
 .../boot/dts/{ => marvell}/armada-38x.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-390-db.dts  |    0
 .../boot/dts/{ => marvell}/armada-390.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-395-gp.dts  |    0
 .../boot/dts/{ => marvell}/armada-395.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-398-db.dts  |    0
 .../boot/dts/{ => marvell}/armada-398.dtsi    |    0
 .../boot/dts/{ => marvell}/armada-39x.dtsi    |    0
 .../dts/{ => marvell}/armada-xp-98dx3236.dtsi |    0
 .../dts/{ => marvell}/armada-xp-98dx3336.dtsi |    0
 .../dts/{ => marvell}/armada-xp-98dx4251.dtsi |    0
 .../dts/{ => marvell}/armada-xp-axpwifiap.dts |    0
 .../armada-xp-crs305-1g-4s-bit.dts            |    0
 .../{ => marvell}/armada-xp-crs305-1g-4s.dts  |    0
 .../{ => marvell}/armada-xp-crs305-1g-4s.dtsi |    0
 .../armada-xp-crs326-24g-2s-bit.dts           |    0
 .../{ => marvell}/armada-xp-crs326-24g-2s.dts |    0
 .../armada-xp-crs326-24g-2s.dtsi              |    0
 .../armada-xp-crs328-4c-20s-4s-bit.dts        |    0
 .../armada-xp-crs328-4c-20s-4s.dts            |    0
 .../armada-xp-crs328-4c-20s-4s.dtsi           |    0
 .../dts/{ => marvell}/armada-xp-db-dxbc2.dts  |    0
 .../{ => marvell}/armada-xp-db-xc3-24g4xg.dts |    0
 .../boot/dts/{ => marvell}/armada-xp-db.dts   |    0
 .../boot/dts/{ => marvell}/armada-xp-gp.dts   |    0
 .../armada-xp-lenovo-ix4-300d.dts             |    0
 .../{ => marvell}/armada-xp-linksys-mamba.dts |    0
 .../dts/{ => marvell}/armada-xp-matrix.dts    |    0
 .../dts/{ => marvell}/armada-xp-mv78230.dtsi  |    0
 .../dts/{ => marvell}/armada-xp-mv78260.dtsi  |    0
 .../dts/{ => marvell}/armada-xp-mv78460.dtsi  |    0
 .../armada-xp-netgear-rn2120.dts              |    0
 .../armada-xp-openblocks-ax3-4.dts            |    0
 .../armada-xp-synology-ds414.dts              |    0
 .../arm/boot/dts/{ => marvell}/armada-xp.dtsi |    0
 .../{ => marvell}/berlin2-sony-nsz-gs7.dts    |    0
 arch/arm/boot/dts/{ => marvell}/berlin2.dtsi  |    0
 .../berlin2cd-google-chromecast.dts           |    0
 .../berlin2cd-valve-steamlink.dts             |    0
 .../arm/boot/dts/{ => marvell}/berlin2cd.dtsi |    0
 .../{ => marvell}/berlin2q-marvell-dmp.dts    |    0
 arch/arm/boot/dts/{ => marvell}/berlin2q.dtsi |    0
 .../dts/{ => marvell}/mmp2-brownstone.dts     |    0
 .../dts/{ => marvell}/mmp2-olpc-xo-1-75.dts   |    0
 arch/arm/boot/dts/{ => marvell}/mmp2.dtsi     |    0
 .../dts/{ => marvell}/mmp3-dell-ariel.dts     |    0
 arch/arm/boot/dts/{ => marvell}/mmp3.dtsi     |    0
 .../{ => marvell}/mvebu-linkstation-fan.dtsi  |    0
 .../mvebu-linkstation-gpio-simple.dtsi        |    0
 .../dts/{ => marvell}/orion5x-kuroboxpro.dts  |    0
 .../orion5x-lacie-d2-network.dts              |    0
 .../orion5x-lacie-ethernet-disk-mini-v2.dts   |    0
 .../orion5x-linkstation-lschl.dts             |    0
 .../orion5x-linkstation-lsgl.dts              |    0
 .../orion5x-linkstation-lswtgl.dts            |    0
 .../{ => marvell}/orion5x-linkstation.dtsi    |    0
 .../boot/dts/{ => marvell}/orion5x-lswsgl.dts |    0
 .../orion5x-maxtor-shared-storage-2.dts       |    0
 .../dts/{ => marvell}/orion5x-mv88f5181.dtsi  |    0
 .../dts/{ => marvell}/orion5x-mv88f5182.dtsi  |    0
 .../{ => marvell}/orion5x-netgear-wnr854t.dts |    0
 .../{ => marvell}/orion5x-rd88f5182-nas.dts   |    0
 arch/arm/boot/dts/{ => marvell}/orion5x.dtsi  |    0
 .../dts/{ => marvell}/pxa168-aspenite.dts     |    0
 arch/arm/boot/dts/{ => marvell}/pxa168.dtsi   |    0
 arch/arm/boot/dts/{ => marvell}/pxa25x.dtsi   |    0
 arch/arm/boot/dts/{ => marvell}/pxa27x.dtsi   |    0
 arch/arm/boot/dts/{ => marvell}/pxa2xx.dtsi   |    0
 .../{ => marvell}/pxa300-raumfeld-common.dtsi |    0
 .../pxa300-raumfeld-connector.dts             |    0
 .../pxa300-raumfeld-controller.dts            |    0
 .../pxa300-raumfeld-speaker-l.dts             |    0
 .../pxa300-raumfeld-speaker-m.dts             |    0
 .../pxa300-raumfeld-speaker-one.dts           |    0
 .../pxa300-raumfeld-speaker-s.dts             |    0
 .../pxa300-raumfeld-tuneable-clock.dtsi       |    0
 arch/arm/boot/dts/{ => marvell}/pxa3xx.dtsi   |    0
 .../arm/boot/dts/{ => marvell}/pxa910-dkb.dts |    0
 arch/arm/boot/dts/{ => marvell}/pxa910.dtsi   |    0
 arch/arm/boot/dts/mediatek/Makefile           |   14 +
 .../boot/dts/{ => mediatek}/mt2701-evb.dts    |    0
 .../boot/dts/{ => mediatek}/mt2701-pinfunc.h  |    0
 arch/arm/boot/dts/{ => mediatek}/mt2701.dtsi  |    0
 arch/arm/boot/dts/{ => mediatek}/mt6323.dtsi  |    0
 .../boot/dts/{ => mediatek}/mt6580-evbp1.dts  |    0
 arch/arm/boot/dts/{ => mediatek}/mt6580.dtsi  |    0
 .../mt6582-prestigio-pmt5008-3g.dts           |    0
 arch/arm/boot/dts/{ => mediatek}/mt6582.dtsi  |    0
 .../dts/{ => mediatek}/mt6589-aquaris5.dts    |    0
 .../{ => mediatek}/mt6589-fairphone-fp1.dts   |    0
 arch/arm/boot/dts/{ => mediatek}/mt6589.dtsi  |    0
 .../boot/dts/{ => mediatek}/mt6592-evb.dts    |    0
 arch/arm/boot/dts/{ => mediatek}/mt6592.dtsi  |    0
 arch/arm/boot/dts/{ => mediatek}/mt7623.dtsi  |    0
 .../dts/{ => mediatek}/mt7623a-rfb-emmc.dts   |    0
 .../dts/{ => mediatek}/mt7623a-rfb-nand.dts   |    0
 arch/arm/boot/dts/{ => mediatek}/mt7623a.dtsi |    0
 .../mt7623n-bananapi-bpi-r2.dts               |    0
 .../dts/{ => mediatek}/mt7623n-rfb-emmc.dts   |    0
 arch/arm/boot/dts/{ => mediatek}/mt7623n.dtsi |    0
 .../boot/dts/{ => mediatek}/mt7629-rfb.dts    |    0
 arch/arm/boot/dts/{ => mediatek}/mt7629.dtsi  |    0
 .../boot/dts/{ => mediatek}/mt8127-moose.dts  |    0
 arch/arm/boot/dts/{ => mediatek}/mt8127.dtsi  |    0
 .../boot/dts/{ => mediatek}/mt8135-evbp1.dts  |    0
 arch/arm/boot/dts/{ => mediatek}/mt8135.dtsi  |    0
 arch/arm/boot/dts/microchip/Makefile          |   76 +
 arch/arm/boot/dts/{ => microchip}/aks-cdu.dts |    0
 .../boot/dts/{ => microchip}/animeo_ip.dts    |    0
 .../boot/dts/{ => microchip}/at91-ariag25.dts |    0
 .../dts/{ => microchip}/at91-ariettag25.dts   |    0
 .../boot/dts/{ => microchip}/at91-cosino.dtsi |    0
 .../{ => microchip}/at91-cosino_mega2560.dts  |    0
 .../dts/{ => microchip}/at91-dvk_som60.dts    |    0
 .../{ => microchip}/at91-dvk_su60_somc.dtsi   |    0
 .../at91-dvk_su60_somc_lcm.dtsi               |    0
 .../boot/dts/{ => microchip}/at91-foxg20.dts  |    0
 .../boot/dts/{ => microchip}/at91-gatwick.dts |    0
 .../boot/dts/{ => microchip}/at91-kizbox.dts  |    0
 .../dts/{ => microchip}/at91-kizbox2-2.dts    |    0
 .../{ => microchip}/at91-kizbox2-common.dtsi  |    0
 .../dts/{ => microchip}/at91-kizbox3-hs.dts   |    0
 .../{ => microchip}/at91-kizbox3_common.dtsi  |    0
 .../{ => microchip}/at91-kizboxmini-base.dts  |    0
 .../at91-kizboxmini-common.dtsi               |    0
 .../{ => microchip}/at91-kizboxmini-mb.dts    |    0
 .../{ => microchip}/at91-kizboxmini-rd.dts    |    0
 .../boot/dts/{ => microchip}/at91-linea.dtsi  |    0
 .../boot/dts/{ => microchip}/at91-lmu5000.dts |    0
 .../boot/dts/{ => microchip}/at91-natte.dtsi  |    0
 .../{ => microchip}/at91-nattis-2-natte-2.dts |    0
 .../boot/dts/{ => microchip}/at91-q5xr5.dts   |    0
 .../dts/{ => microchip}/at91-qil_a9260.dts    |    0
 .../dts/{ => microchip}/at91-sam9_l9260.dts   |    0
 .../dts/{ => microchip}/at91-sam9x60ek.dts    |    0
 .../{ => microchip}/at91-sama5d27_som1.dtsi   |    0
 .../{ => microchip}/at91-sama5d27_som1_ek.dts |    0
 .../{ => microchip}/at91-sama5d27_wlsom1.dtsi |    0
 .../at91-sama5d27_wlsom1_ek.dts               |    0
 .../dts/{ => microchip}/at91-sama5d2_icp.dts  |    0
 .../{ => microchip}/at91-sama5d2_ptc_ek.dts   |    0
 .../{ => microchip}/at91-sama5d2_xplained.dts |    0
 .../at91-sama5d3_ksz9477_evb.dts              |    0
 .../{ => microchip}/at91-sama5d3_xplained.dts |    0
 .../{ => microchip}/at91-sama5d4_ma5d4.dtsi   |    0
 .../{ => microchip}/at91-sama5d4_ma5d4evk.dts |    0
 .../{ => microchip}/at91-sama5d4_xplained.dts |    0
 .../dts/{ => microchip}/at91-sama5d4ek.dts    |    0
 .../dts/{ => microchip}/at91-sama7g5ek.dts    |    0
 .../dts/{ => microchip}/at91-smartkiz.dts     |    0
 .../boot/dts/{ => microchip}/at91-som60.dtsi  |    0
 .../dts/{ => microchip}/at91-tse850-3.dts     |    0
 .../boot/dts/{ => microchip}/at91-vinco.dts   |    0
 .../boot/dts/{ => microchip}/at91-wb45n.dts   |    0
 .../boot/dts/{ => microchip}/at91-wb45n.dtsi  |    0
 .../boot/dts/{ => microchip}/at91-wb50n.dts   |    0
 .../boot/dts/{ => microchip}/at91-wb50n.dtsi  |    0
 .../boot/dts/{ => microchip}/at91rm9200.dtsi  |    0
 .../dts/{ => microchip}/at91rm9200_pqfp.dtsi  |    0
 .../boot/dts/{ => microchip}/at91rm9200ek.dts |    0
 .../boot/dts/{ => microchip}/at91sam9260.dtsi |    0
 .../dts/{ => microchip}/at91sam9260ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9261.dtsi |    0
 .../dts/{ => microchip}/at91sam9261ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9263.dtsi |    0
 .../dts/{ => microchip}/at91sam9263ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9g15.dtsi |    0
 .../dts/{ => microchip}/at91sam9g15ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9g20.dtsi |    0
 .../dts/{ => microchip}/at91sam9g20ek.dts     |    0
 .../{ => microchip}/at91sam9g20ek_2mmc.dts    |    0
 .../{ => microchip}/at91sam9g20ek_common.dtsi |    0
 .../at91sam9g25-gardena-smart-gateway.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9g25.dtsi |    0
 .../dts/{ => microchip}/at91sam9g25ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9g35.dtsi |    0
 .../dts/{ => microchip}/at91sam9g35ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9g45.dtsi |    0
 .../dts/{ => microchip}/at91sam9m10g45ek.dts  |    0
 .../boot/dts/{ => microchip}/at91sam9n12.dtsi |    0
 .../dts/{ => microchip}/at91sam9n12ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9rl.dtsi  |    0
 .../boot/dts/{ => microchip}/at91sam9rlek.dts |    0
 .../boot/dts/{ => microchip}/at91sam9x25.dtsi |    0
 .../dts/{ => microchip}/at91sam9x25ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9x35.dtsi |    0
 .../dts/{ => microchip}/at91sam9x35ek.dts     |    0
 .../boot/dts/{ => microchip}/at91sam9x5.dtsi  |    0
 .../dts/{ => microchip}/at91sam9x5_can.dtsi   |    0
 .../dts/{ => microchip}/at91sam9x5_isi.dtsi   |    0
 .../dts/{ => microchip}/at91sam9x5_lcd.dtsi   |    0
 .../dts/{ => microchip}/at91sam9x5_macb0.dtsi |    0
 .../dts/{ => microchip}/at91sam9x5_macb1.dtsi |    0
 .../{ => microchip}/at91sam9x5_usart3.dtsi    |    0
 .../dts/{ => microchip}/at91sam9x5cm.dtsi     |    0
 .../dts/{ => microchip}/at91sam9x5dm.dtsi     |    0
 .../dts/{ => microchip}/at91sam9x5ek.dtsi     |    0
 .../boot/dts/{ => microchip}/at91sam9xe.dtsi  |    0
 .../boot/dts/{ => microchip}/ethernut5.dts    |    0
 .../arm/boot/dts/{ => microchip}/evk-pro3.dts |    0
 .../boot/dts/{ => microchip}/ge863-pro3.dtsi  |    0
 .../dts/{ => microchip}/lan966x-pcb8291.dts   |    0
 .../arm/boot/dts/{ => microchip}/lan966x.dtsi |    0
 arch/arm/boot/dts/{ => microchip}/mpa1600.dts |    0
 arch/arm/boot/dts/{ => microchip}/pm9g45.dts  |    0
 .../arm/boot/dts/{ => microchip}/sam9x60.dtsi |    0
 .../dts/{ => microchip}/sama5d2-pinfunc.h     |    0
 .../arm/boot/dts/{ => microchip}/sama5d2.dtsi |    0
 .../boot/dts/{ => microchip}/sama5d29.dtsi    |    0
 .../arm/boot/dts/{ => microchip}/sama5d3.dtsi |    0
 .../boot/dts/{ => microchip}/sama5d31.dtsi    |    0
 .../boot/dts/{ => microchip}/sama5d31ek.dts   |    0
 .../boot/dts/{ => microchip}/sama5d33.dtsi    |    0
 .../boot/dts/{ => microchip}/sama5d33ek.dts   |    0
 .../boot/dts/{ => microchip}/sama5d34.dtsi    |    0
 .../boot/dts/{ => microchip}/sama5d34ek.dts   |    0
 .../boot/dts/{ => microchip}/sama5d35.dtsi    |    0
 .../boot/dts/{ => microchip}/sama5d35ek.dts   |    0
 .../boot/dts/{ => microchip}/sama5d36.dtsi    |    0
 .../boot/dts/{ => microchip}/sama5d36ek.dts   |    0
 .../dts/{ => microchip}/sama5d36ek_cmp.dts    |    0
 .../boot/dts/{ => microchip}/sama5d3_can.dtsi |    0
 .../dts/{ => microchip}/sama5d3_emac.dtsi     |    0
 .../dts/{ => microchip}/sama5d3_gmac.dtsi     |    0
 .../boot/dts/{ => microchip}/sama5d3_lcd.dtsi |    0
 .../dts/{ => microchip}/sama5d3_mci2.dtsi     |    0
 .../dts/{ => microchip}/sama5d3_tcb1.dtsi     |    0
 .../dts/{ => microchip}/sama5d3_uart.dtsi     |    0
 .../boot/dts/{ => microchip}/sama5d3xcm.dtsi  |    0
 .../dts/{ => microchip}/sama5d3xcm_cmp.dtsi   |    0
 .../boot/dts/{ => microchip}/sama5d3xdm.dtsi  |    0
 .../boot/dts/{ => microchip}/sama5d3xmb.dtsi  |    0
 .../dts/{ => microchip}/sama5d3xmb_cmp.dtsi   |    0
 .../dts/{ => microchip}/sama5d3xmb_emac.dtsi  |    0
 .../dts/{ => microchip}/sama5d3xmb_gmac.dtsi  |    0
 .../arm/boot/dts/{ => microchip}/sama5d4.dtsi |    0
 .../dts/{ => microchip}/sama7g5-pinfunc.h     |    0
 .../arm/boot/dts/{ => microchip}/sama7g5.dtsi |    0
 .../boot/dts/{ => microchip}/tny_a9260.dts    |    0
 .../dts/{ => microchip}/tny_a9260_common.dtsi |    0
 .../boot/dts/{ => microchip}/tny_a9263.dts    |    0
 .../boot/dts/{ => microchip}/tny_a9g20.dts    |    0
 .../boot/dts/{ => microchip}/usb_a9260.dts    |    0
 .../dts/{ => microchip}/usb_a9260_common.dtsi |    0
 .../boot/dts/{ => microchip}/usb_a9263.dts    |    0
 .../{ => microchip}/usb_a9g20-dab-mmx.dtsi    |    0
 .../boot/dts/{ => microchip}/usb_a9g20.dts    |    0
 .../dts/{ => microchip}/usb_a9g20_common.dtsi |    0
 .../dts/{ => microchip}/usb_a9g20_lpw.dts     |    0
 arch/arm/boot/dts/moxart/Makefile             |    3 +
 .../boot/dts/{ => moxart}/moxart-uc7112lx.dts |    0
 arch/arm/boot/dts/{ => moxart}/moxart.dtsi    |    0
 arch/arm/boot/dts/mstart/Makefile             |   10 +
 .../mstar-infinity-breadbee-common.dtsi       |    0
 .../mstar-infinity-msc313-breadbee_crust.dts  |    0
 .../{ => mstart}/mstar-infinity-msc313.dtsi   |    0
 .../boot/dts/{ => mstart}/mstar-infinity.dtsi |    0
 .../mstar-infinity2m-ssd201-som2d01.dtsi      |    0
 ...nfinity2m-ssd202d-100ask-dongshanpione.dts |    0
 .../mstar-infinity2m-ssd202d-miyoo-mini.dts   |    0
 .../mstar-infinity2m-ssd202d-ssd201htv2.dts   |    0
 .../mstar-infinity2m-ssd202d-unitv2.dts       |    0
 ...sd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts |    0
 ...ity2m-ssd202d-wirelesstag-ido-som2d01.dtsi |    0
 .../mstar-infinity2m-ssd202d.dtsi             |    0
 .../mstar-infinity2m-ssd20xd.dtsi             |    0
 .../dts/{ => mstart}/mstar-infinity2m.dtsi    |    0
 .../mstar-infinity3-msc313e-breadbee.dts      |    0
 .../{ => mstart}/mstar-infinity3-msc313e.dtsi |    0
 .../dts/{ => mstart}/mstar-infinity3.dtsi     |    0
 .../mstar-mercury5-ssc8336n-midrived08.dts    |    0
 .../{ => mstart}/mstar-mercury5-ssc8336n.dtsi |    0
 .../boot/dts/{ => mstart}/mstar-mercury5.dtsi |    0
 arch/arm/boot/dts/{ => mstart}/mstar-v7.dtsi  |    0
 arch/arm/boot/dts/nuvoton/Makefile            |    9 +
 .../{ => nuvoton}/nuvoton-common-npcm7xx.dtsi |    0
 .../dts/{ => nuvoton}/nuvoton-npcm730-gbs.dts |    0
 .../nuvoton-npcm730-gsj-gpio.dtsi             |    0
 .../dts/{ => nuvoton}/nuvoton-npcm730-gsj.dts |    0
 .../{ => nuvoton}/nuvoton-npcm730-kudo.dts    |    0
 .../dts/{ => nuvoton}/nuvoton-npcm730.dtsi    |    0
 .../dts/{ => nuvoton}/nuvoton-npcm750-evb.dts |    0
 .../nuvoton-npcm750-pincfg-evb.dtsi           |    0
 ...nuvoton-npcm750-runbmc-olympus-pincfg.dtsi |    0
 .../nuvoton-npcm750-runbmc-olympus.dts        |    0
 .../dts/{ => nuvoton}/nuvoton-npcm750.dtsi    |    0
 .../nuvoton-wpcm450-supermicro-x9sci-ln4f.dts |    0
 .../dts/{ => nuvoton}/nuvoton-wpcm450.dtsi    |    0
 arch/arm/boot/dts/nvidia/Makefile             |   43 +
 .../arm/boot/dts/nvidia/cros-ec-keyboard.dtsi |    1 +
 .../dts/{ => nvidia}/tegra114-asus-tf701t.dts |    0
 .../dts/{ => nvidia}/tegra114-dalmore.dts     |    0
 .../boot/dts/{ => nvidia}/tegra114-roth.dts   |    0
 .../boot/dts/{ => nvidia}/tegra114-tn7.dts    |    0
 arch/arm/boot/dts/{ => nvidia}/tegra114.dtsi  |    0
 .../dts/{ => nvidia}/tegra124-apalis-emc.dtsi |    0
 .../dts/{ => nvidia}/tegra124-apalis-eval.dts |    0
 .../tegra124-apalis-v1.2-eval.dts             |    0
 .../{ => nvidia}/tegra124-apalis-v1.2.dtsi    |    0
 .../dts/{ => nvidia}/tegra124-apalis.dtsi     |    0
 .../{ => nvidia}/tegra124-jetson-tk1-emc.dtsi |    0
 .../dts/{ => nvidia}/tegra124-jetson-tk1.dts  |    0
 .../{ => nvidia}/tegra124-nyan-big-emc.dtsi   |    0
 .../{ => nvidia}/tegra124-nyan-big-fhd.dts    |    0
 .../dts/{ => nvidia}/tegra124-nyan-big.dts    |    0
 .../{ => nvidia}/tegra124-nyan-blaze-emc.dtsi |    0
 .../dts/{ => nvidia}/tegra124-nyan-blaze.dts  |    0
 .../boot/dts/{ => nvidia}/tegra124-nyan.dtsi  |    0
 .../tegra124-peripherals-opp.dtsi             |    0
 .../dts/{ => nvidia}/tegra124-venice2.dts     |    0
 arch/arm/boot/dts/{ => nvidia}/tegra124.dtsi  |    0
 .../tegra20-acer-a500-picasso.dts             |    0
 .../dts/{ => nvidia}/tegra20-asus-tf101.dts   |    0
 .../{ => nvidia}/tegra20-colibri-eval-v3.dts  |    0
 .../dts/{ => nvidia}/tegra20-colibri-iris.dts |    0
 .../dts/{ => nvidia}/tegra20-colibri.dtsi     |    0
 .../tegra20-cpu-opp-microvolt.dtsi            |    0
 .../dts/{ => nvidia}/tegra20-cpu-opp.dtsi     |    0
 .../boot/dts/{ => nvidia}/tegra20-harmony.dts |    0
 .../dts/{ => nvidia}/tegra20-medcom-wide.dts  |    0
 .../boot/dts/{ => nvidia}/tegra20-paz00.dts   |    0
 .../{ => nvidia}/tegra20-peripherals-opp.dtsi |    0
 .../boot/dts/{ => nvidia}/tegra20-plutux.dts  |    0
 .../dts/{ => nvidia}/tegra20-seaboard.dts     |    0
 .../dts/{ => nvidia}/tegra20-tamonten.dtsi    |    0
 .../arm/boot/dts/{ => nvidia}/tegra20-tec.dts |    0
 .../dts/{ => nvidia}/tegra20-trimslice.dts    |    0
 .../boot/dts/{ => nvidia}/tegra20-ventana.dts |    0
 arch/arm/boot/dts/{ => nvidia}/tegra20.dtsi   |    0
 .../dts/{ => nvidia}/tegra30-apalis-eval.dts  |    0
 .../{ => nvidia}/tegra30-apalis-v1.1-eval.dts |    0
 .../dts/{ => nvidia}/tegra30-apalis-v1.1.dtsi |    0
 .../boot/dts/{ => nvidia}/tegra30-apalis.dtsi |    0
 .../tegra30-asus-lvds-display.dtsi            |    0
 .../tegra30-asus-nexus7-grouper-E1565.dts     |    0
 .../tegra30-asus-nexus7-grouper-PM269.dts     |    0
 .../tegra30-asus-nexus7-grouper-common.dtsi   |    0
 ...egra30-asus-nexus7-grouper-maxim-pmic.dtsi |    0
 ...30-asus-nexus7-grouper-memory-timings.dtsi |    0
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi  |    0
 .../tegra30-asus-nexus7-grouper.dtsi          |    0
 .../tegra30-asus-nexus7-tilapia-E1565.dts     |    0
 ...30-asus-nexus7-tilapia-memory-timings.dtsi |    0
 .../tegra30-asus-nexus7-tilapia.dtsi          |    0
 .../dts/{ => nvidia}/tegra30-asus-tf201.dts   |    0
 .../dts/{ => nvidia}/tegra30-asus-tf300t.dts  |    0
 .../dts/{ => nvidia}/tegra30-asus-tf300tg.dts |    0
 .../dts/{ => nvidia}/tegra30-asus-tf700t.dts  |    0
 .../tegra30-asus-transformer-common.dtsi      |    0
 .../boot/dts/{ => nvidia}/tegra30-beaver.dts  |    0
 .../dts/{ => nvidia}/tegra30-cardhu-a02.dts   |    0
 .../dts/{ => nvidia}/tegra30-cardhu-a04.dts   |    0
 .../boot/dts/{ => nvidia}/tegra30-cardhu.dtsi |    0
 .../{ => nvidia}/tegra30-colibri-eval-v3.dts  |    0
 .../dts/{ => nvidia}/tegra30-colibri.dtsi     |    0
 .../tegra30-cpu-opp-microvolt.dtsi            |    0
 .../dts/{ => nvidia}/tegra30-cpu-opp.dtsi     |    0
 .../boot/dts/{ => nvidia}/tegra30-ouya.dts    |    0
 .../{ => nvidia}/tegra30-pegatron-chagall.dts |    0
 .../{ => nvidia}/tegra30-peripherals-opp.dtsi |    0
 arch/arm/boot/dts/{ => nvidia}/tegra30.dtsi   |    0
 arch/arm/boot/dts/nxp/Makefile                |    9 +
 arch/arm/boot/dts/nxp/armv7-m.dtsi            |    1 +
 arch/arm/boot/dts/{ => nxp}/lpc18xx.dtsi      |    0
 .../arm/boot/dts/{ => nxp}/lpc3250-ea3250.dts |    0
 .../boot/dts/{ => nxp}/lpc3250-phy3250.dts    |    0
 arch/arm/boot/dts/{ => nxp}/lpc32xx.dtsi      |    0
 arch/arm/boot/dts/{ => nxp}/lpc4337-ciaa.dts  |    0
 .../boot/dts/{ => nxp}/lpc4350-hitex-eval.dts |    0
 arch/arm/boot/dts/{ => nxp}/lpc4350.dtsi      |    0
 .../dts/{ => nxp}/lpc4357-ea4357-devkit.dts   |    0
 .../dts/{ => nxp}/lpc4357-myd-lpc4357.dts     |    0
 arch/arm/boot/dts/{ => nxp}/lpc4357.dtsi      |    0
 arch/arm/boot/dts/oxnas/Makefile              |    4 +
 .../boot/dts/{ => oxnas}/ox810se-wd-mbwe.dts  |    0
 arch/arm/boot/dts/{ => oxnas}/ox810se.dtsi    |    0
 .../ox820-cloudengines-pogoplug-series-3.dts  |    0
 arch/arm/boot/dts/{ => oxnas}/ox820.dtsi      |    0
 arch/arm/boot/dts/qcom/Makefile               |   37 +
 .../boot/dts/{ => qcom}/qcom-apq8016-sbc.dts  |    0
 .../dts/{ => qcom}/qcom-apq8026-lg-lenok.dts  |    0
 .../{ => qcom}/qcom-apq8060-dragonboard.dts   |    0
 .../qcom-apq8064-asus-nexus7-flo.dts          |    0
 .../dts/{ => qcom}/qcom-apq8064-cm-qs600.dts  |    0
 .../dts/{ => qcom}/qcom-apq8064-ifc6410.dts   |    0
 .../dts/{ => qcom}/qcom-apq8064-pins.dtsi     |    0
 .../qcom-apq8064-sony-xperia-yuga.dts         |    0
 .../dts/{ => qcom}/qcom-apq8064-v2.0.dtsi     |    0
 .../arm/boot/dts/{ => qcom}/qcom-apq8064.dtsi |    0
 .../{ => qcom}/qcom-apq8074-dragonboard.dts   |    0
 .../dts/{ => qcom}/qcom-apq8084-ifc6540.dts   |    0
 .../boot/dts/{ => qcom}/qcom-apq8084-mtp.dts  |    0
 .../arm/boot/dts/{ => qcom}/qcom-apq8084.dtsi |    0
 .../{ => qcom}/qcom-ipq4018-ap120c-ac-bit.dts |    0
 .../dts/{ => qcom}/qcom-ipq4018-ap120c-ac.dts |    0
 .../{ => qcom}/qcom-ipq4018-ap120c-ac.dtsi    |    0
 .../dts/{ => qcom}/qcom-ipq4018-jalapeno.dts  |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk01.1-c1.dts  |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk01.1.dtsi    |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk04.1-c1.dts  |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk04.1-c3.dts  |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk04.1.dtsi    |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk07.1-c1.dts  |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk07.1-c2.dts  |    0
 .../{ => qcom}/qcom-ipq4019-ap.dk07.1.dtsi    |    0
 .../arm/boot/dts/{ => qcom}/qcom-ipq4019.dtsi |    0
 .../dts/{ => qcom}/qcom-ipq8064-ap148.dts     |    0
 .../dts/{ => qcom}/qcom-ipq8064-rb3011.dts    |    0
 .../dts/{ => qcom}/qcom-ipq8064-v1.0.dtsi     |    0
 .../arm/boot/dts/{ => qcom}/qcom-ipq8064.dtsi |    0
 .../qcom-mdm9615-wp8548-mangoh-green.dts      |    0
 .../dts/{ => qcom}/qcom-mdm9615-wp8548.dtsi   |    0
 .../arm/boot/dts/{ => qcom}/qcom-mdm9615.dtsi |    0
 .../qcom-msm8226-samsung-s3ve3g.dts           |    0
 .../arm/boot/dts/{ => qcom}/qcom-msm8226.dtsi |    0
 .../boot/dts/{ => qcom}/qcom-msm8660-surf.dts |    0
 .../arm/boot/dts/{ => qcom}/qcom-msm8660.dtsi |    0
 .../qcom-msm8916-samsung-serranove.dts        |    0
 .../boot/dts/{ => qcom}/qcom-msm8916-smp.dtsi |    0
 .../boot/dts/{ => qcom}/qcom-msm8960-cdp.dts  |    0
 .../arm/boot/dts/{ => qcom}/qcom-msm8960.dtsi |    0
 .../{ => qcom}/qcom-msm8974-fairphone-fp2.dts |    0
 .../qcom-msm8974-lge-nexus5-hammerhead.dts    |    0
 .../{ => qcom}/qcom-msm8974-samsung-klte.dts  |    0
 .../qcom-msm8974-sony-xperia-amami.dts        |    0
 .../qcom-msm8974-sony-xperia-castor.dts       |    0
 .../qcom-msm8974-sony-xperia-honami.dts       |    0
 .../arm/boot/dts/{ => qcom}/qcom-msm8974.dtsi |    0
 .../boot/dts/{ => qcom}/qcom-msm8974pro.dtsi  |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pm8226.dtsi |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pm8841.dtsi |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pm8941.dtsi |    0
 .../arm/boot/dts/{ => qcom}/qcom-pma8084.dtsi |    0
 arch/arm/boot/dts/{ => qcom}/qcom-pmx55.dtsi  |    0
 .../boot/dts/{ => qcom}/qcom-sdx55-mtp.dts    |    0
 .../boot/dts/{ => qcom}/qcom-sdx55-t55.dts    |    0
 .../{ => qcom}/qcom-sdx55-telit-fn980-tlb.dts |    0
 arch/arm/boot/dts/{ => qcom}/qcom-sdx55.dtsi  |    0
 .../boot/dts/{ => qcom}/qcom-sdx65-mtp.dts    |    0
 arch/arm/boot/dts/{ => qcom}/qcom-sdx65.dtsi  |    0
 arch/arm/boot/dts/rda/Makefile                |    4 +
 .../{ => rda}/rda8810pl-orangepi-2g-iot.dts   |    0
 .../dts/{ => rda}/rda8810pl-orangepi-i96.dts  |    0
 arch/arm/boot/dts/{ => rda}/rda8810pl.dtsi    |    0
 arch/arm/boot/dts/realtek/Makefile            |    4 +
 .../dts/{ => realtek}/rtd1195-horseradish.dts |    0
 .../dts/{ => realtek}/rtd1195-mele-x1000.dts  |    0
 arch/arm/boot/dts/{ => realtek}/rtd1195.dtsi  |    0
 arch/arm/boot/dts/realview/Makefile           |   14 +
 .../arm-realview-eb-11mp-bbrevd-ctrevb.dts    |    0
 .../arm-realview-eb-11mp-bbrevd.dts           |    0
 .../arm-realview-eb-11mp-ctrevb.dts           |    0
 .../{ => realview}/arm-realview-eb-11mp.dts   |    0
 .../arm-realview-eb-a9mp-bbrevd.dts           |    0
 .../{ => realview}/arm-realview-eb-a9mp.dts   |    0
 .../{ => realview}/arm-realview-eb-bbrevd.dts |    0
 .../arm-realview-eb-bbrevd.dtsi               |    0
 .../{ => realview}/arm-realview-eb-mp.dtsi    |    0
 .../dts/{ => realview}/arm-realview-eb.dts    |    0
 .../dts/{ => realview}/arm-realview-eb.dtsi   |    0
 .../{ => realview}/arm-realview-pb1176.dts    |    0
 .../{ => realview}/arm-realview-pb11mp.dts    |    0
 .../dts/{ => realview}/arm-realview-pba8.dts  |    0
 .../{ => realview}/arm-realview-pbx-a9.dts    |    0
 .../dts/{ => realview}/arm-realview-pbx.dtsi  |    0
 arch/arm/boot/dts/renasas/Makefile            |   33 +
 .../boot/dts/{ => renasas}/emev2-kzm9d.dts    |    0
 arch/arm/boot/dts/{ => renasas}/emev2.dtsi    |    0
 .../gr-peach-audiocamerashield.dtsi           |    0
 .../dts/{ => renasas}/iwg20d-q7-common.dtsi   |    0
 .../dts/{ => renasas}/iwg20d-q7-dbcm-ca.dtsi  |    0
 .../dts/{ => renasas}/r7s72100-genmai.dts     |    0
 .../dts/{ => renasas}/r7s72100-gr-peach.dts   |    0
 .../dts/{ => renasas}/r7s72100-rskrza1.dts    |    0
 arch/arm/boot/dts/{ => renasas}/r7s72100.dtsi |    0
 .../dts/{ => renasas}/r7s9210-rza2mevb.dts    |    0
 arch/arm/boot/dts/{ => renasas}/r7s9210.dtsi  |    0
 .../dts/{ => renasas}/r8a73a4-ape6evm.dts     |    0
 arch/arm/boot/dts/{ => renasas}/r8a73a4.dtsi  |    0
 .../{ => renasas}/r8a7740-armadillo800eva.dts |    0
 arch/arm/boot/dts/{ => renasas}/r8a7740.dtsi  |    0
 .../r8a7742-iwg21d-q7-dbcm-ca.dts             |    0
 .../r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi |    0
 .../r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi |    0
 .../dts/{ => renasas}/r8a7742-iwg21d-q7.dts   |    0
 .../dts/{ => renasas}/r8a7742-iwg21m.dtsi     |    0
 arch/arm/boot/dts/{ => renasas}/r8a7742.dtsi  |    0
 .../r8a7743-iwg20d-q7-dbcm-ca.dts             |    0
 .../dts/{ => renasas}/r8a7743-iwg20d-q7.dts   |    0
 .../dts/{ => renasas}/r8a7743-iwg20m.dtsi     |    0
 .../dts/{ => renasas}/r8a7743-sk-rzg1m.dts    |    0
 arch/arm/boot/dts/{ => renasas}/r8a7743.dtsi  |    0
 .../r8a7744-iwg20d-q7-dbcm-ca.dts             |    0
 .../dts/{ => renasas}/r8a7744-iwg20d-q7.dts   |    0
 .../dts/{ => renasas}/r8a7744-iwg20m.dtsi     |    0
 arch/arm/boot/dts/{ => renasas}/r8a7744.dtsi  |    0
 .../r8a7745-iwg22d-sodimm-dbhd-ca.dts         |    0
 .../{ => renasas}/r8a7745-iwg22d-sodimm.dts   |    0
 .../dts/{ => renasas}/r8a7745-iwg22m.dtsi     |    0
 .../dts/{ => renasas}/r8a7745-sk-rzg1e.dts    |    0
 arch/arm/boot/dts/{ => renasas}/r8a7745.dtsi  |    0
 .../dts/{ => renasas}/r8a77470-iwg23s-sbc.dts |    0
 arch/arm/boot/dts/{ => renasas}/r8a77470.dtsi |    0
 .../boot/dts/{ => renasas}/r8a7778-bockw.dts  |    0
 arch/arm/boot/dts/{ => renasas}/r8a7778.dtsi  |    0
 .../boot/dts/{ => renasas}/r8a7779-marzen.dts |    0
 arch/arm/boot/dts/{ => renasas}/r8a7779.dtsi  |    0
 .../boot/dts/{ => renasas}/r8a7790-lager.dts  |    0
 .../boot/dts/{ => renasas}/r8a7790-stout.dts  |    0
 arch/arm/boot/dts/{ => renasas}/r8a7790.dtsi  |    0
 .../dts/{ => renasas}/r8a7791-koelsch.dts     |    0
 .../boot/dts/{ => renasas}/r8a7791-porter.dts |    0
 arch/arm/boot/dts/{ => renasas}/r8a7791.dtsi  |    0
 .../dts/{ => renasas}/r8a7792-blanche.dts     |    0
 .../boot/dts/{ => renasas}/r8a7792-wheat.dts  |    0
 arch/arm/boot/dts/{ => renasas}/r8a7792.dtsi  |    0
 .../boot/dts/{ => renasas}/r8a7793-gose.dts   |    0
 arch/arm/boot/dts/{ => renasas}/r8a7793.dtsi  |    0
 .../boot/dts/{ => renasas}/r8a7794-alt.dts    |    0
 .../boot/dts/{ => renasas}/r8a7794-silk.dts   |    0
 arch/arm/boot/dts/{ => renasas}/r8a7794.dtsi  |    0
 .../r8a77xx-aa104xd12-panel.dtsi              |    0
 .../r8a77xx-aa121td01-panel.dtsi              |    0
 .../{ => renasas}/r9a06g032-rzn1d400-db.dts   |    0
 .../arm/boot/dts/{ => renasas}/r9a06g032.dtsi |    0
 .../boot/dts/{ => renasas}/sh73a0-kzm9g.dts   |    0
 arch/arm/boot/dts/{ => renasas}/sh73a0.dtsi   |    0
 arch/arm/boot/dts/rockchip/Makefile           |   40 +
 .../boot/dts/rockchip/cros-ec-keyboard.dtsi   |    1 +
 .../boot/dts/{ => rockchip}/cros-ec-sbs.dtsi  |    0
 .../boot/dts/{ => rockchip}/rk3036-evb.dts    |    0
 .../boot/dts/{ => rockchip}/rk3036-kylin.dts  |    0
 arch/arm/boot/dts/{ => rockchip}/rk3036.dtsi  |    0
 .../dts/{ => rockchip}/rk3066a-bqcurie2.dts   |    0
 .../dts/{ => rockchip}/rk3066a-marsboard.dts  |    0
 .../boot/dts/{ => rockchip}/rk3066a-mk808.dts |    0
 .../dts/{ => rockchip}/rk3066a-rayeager.dts   |    0
 arch/arm/boot/dts/{ => rockchip}/rk3066a.dtsi |    0
 .../dts/{ => rockchip}/rk3188-bqedison2qc.dts |    0
 .../dts/{ => rockchip}/rk3188-px3-evb.dts     |    0
 .../dts/{ => rockchip}/rk3188-radxarock.dts   |    0
 arch/arm/boot/dts/{ => rockchip}/rk3188.dtsi  |    0
 .../boot/dts/{ => rockchip}/rk3228-evb.dts    |    0
 .../boot/dts/{ => rockchip}/rk3229-evb.dts    |    0
 .../boot/dts/{ => rockchip}/rk3229-xms6.dts   |    0
 arch/arm/boot/dts/{ => rockchip}/rk3229.dtsi  |    0
 arch/arm/boot/dts/{ => rockchip}/rk322x.dtsi  |    0
 .../dts/{ => rockchip}/rk3288-evb-act8846.dts |    0
 .../dts/{ => rockchip}/rk3288-evb-rk808.dts   |    0
 .../boot/dts/{ => rockchip}/rk3288-evb.dtsi   |    0
 .../{ => rockchip}/rk3288-firefly-beta.dts    |    0
 .../rk3288-firefly-reload-core.dtsi           |    0
 .../{ => rockchip}/rk3288-firefly-reload.dts  |    0
 .../dts/{ => rockchip}/rk3288-firefly.dts     |    0
 .../dts/{ => rockchip}/rk3288-firefly.dtsi    |    0
 .../boot/dts/{ => rockchip}/rk3288-miqi.dts   |    0
 .../dts/{ => rockchip}/rk3288-phycore-rdk.dts |    0
 .../{ => rockchip}/rk3288-phycore-som.dtsi    |    0
 .../dts/{ => rockchip}/rk3288-popmetal.dts    |    0
 .../boot/dts/{ => rockchip}/rk3288-r89.dts    |    0
 .../dts/{ => rockchip}/rk3288-rock-pi-n8.dts  |    0
 .../dts/{ => rockchip}/rk3288-rock2-som.dtsi  |    0
 .../{ => rockchip}/rk3288-rock2-square.dts    |    0
 .../dts/{ => rockchip}/rk3288-tinker-s.dts    |    0
 .../boot/dts/{ => rockchip}/rk3288-tinker.dts |    0
 .../dts/{ => rockchip}/rk3288-tinker.dtsi     |    0
 .../rk3288-veyron-analog-audio.dtsi           |    0
 .../{ => rockchip}/rk3288-veyron-brain.dts    |    0
 .../rk3288-veyron-broadcom-bluetooth.dtsi     |    0
 .../rk3288-veyron-chromebook.dtsi             |    0
 .../dts/{ => rockchip}/rk3288-veyron-edp.dtsi |    0
 .../{ => rockchip}/rk3288-veyron-fievel.dts   |    0
 .../dts/{ => rockchip}/rk3288-veyron-jaq.dts  |    0
 .../{ => rockchip}/rk3288-veyron-jerry.dts    |    0
 .../{ => rockchip}/rk3288-veyron-mickey.dts   |    0
 .../{ => rockchip}/rk3288-veyron-mighty.dts   |    0
 .../{ => rockchip}/rk3288-veyron-minnie.dts   |    0
 .../{ => rockchip}/rk3288-veyron-pinky.dts    |    0
 .../{ => rockchip}/rk3288-veyron-sdmmc.dtsi   |    0
 .../{ => rockchip}/rk3288-veyron-speedy.dts   |    0
 .../{ => rockchip}/rk3288-veyron-tiger.dts    |    0
 .../dts/{ => rockchip}/rk3288-veyron.dtsi     |    0
 .../dts/{ => rockchip}/rk3288-vmarc-som.dtsi  |    0
 .../boot/dts/{ => rockchip}/rk3288-vyasa.dts  |    0
 arch/arm/boot/dts/{ => rockchip}/rk3288.dtsi  |    0
 arch/arm/boot/dts/{ => rockchip}/rk3xxx.dtsi  |    0
 .../rockchip-radxa-dalang-carrier.dtsi        |    0
 .../dts/{ => rockchip}/rv1108-elgin-r1.dts    |    0
 .../boot/dts/{ => rockchip}/rv1108-evb.dts    |    0
 arch/arm/boot/dts/{ => rockchip}/rv1108.dtsi  |    0
 arch/arm/boot/dts/rockchip/tps65910.dtsi      |    1 +
 arch/arm/boot/dts/samsung/Makefile            |   14 +
 .../dts/{ => samsung}/s3c2416-pinctrl.dtsi    |    0
 .../dts/{ => samsung}/s3c2416-smdk2416.dts    |    0
 arch/arm/boot/dts/{ => samsung}/s3c2416.dtsi  |    0
 arch/arm/boot/dts/{ => samsung}/s3c24xx.dtsi  |    0
 arch/arm/boot/dts/{ => samsung}/s3c6400.dtsi  |    0
 .../dts/{ => samsung}/s3c6410-mini6410.dts    |    0
 .../dts/{ => samsung}/s3c6410-smdk6410.dts    |    0
 arch/arm/boot/dts/{ => samsung}/s3c6410.dtsi  |    0
 .../dts/{ => samsung}/s3c64xx-pinctrl.dtsi    |    0
 arch/arm/boot/dts/{ => samsung}/s3c64xx.dtsi  |    0
 .../boot/dts/{ => samsung}/s5pv210-aquila.dts |    0
 .../boot/dts/{ => samsung}/s5pv210-aries.dtsi |    0
 .../dts/{ => samsung}/s5pv210-fascinate4g.dts |    0
 .../dts/{ => samsung}/s5pv210-galaxys.dts     |    0
 .../boot/dts/{ => samsung}/s5pv210-goni.dts   |    0
 .../dts/{ => samsung}/s5pv210-pinctrl.dtsi    |    0
 .../dts/{ => samsung}/s5pv210-smdkc110.dts    |    0
 .../dts/{ => samsung}/s5pv210-smdkv210.dts    |    0
 .../dts/{ => samsung}/s5pv210-torbreck.dts    |    0
 arch/arm/boot/dts/{ => samsung}/s5pv210.dtsi  |    0
 arch/arm/boot/dts/socionext/Makefile          |   12 +
 .../dts/{ => socionext}/milbeaut-m10v-evb.dts |    0
 .../dts/{ => socionext}/milbeaut-m10v.dtsi    |    0
 .../dts/{ => socionext}/uniphier-ld4-ref.dts  |    0
 .../dts/{ => socionext}/uniphier-ld4.dtsi     |    0
 .../dts/{ => socionext}/uniphier-ld6b-ref.dts |    0
 .../dts/{ => socionext}/uniphier-ld6b.dtsi    |    0
 .../dts/{ => socionext}/uniphier-pinctrl.dtsi |    0
 .../dts/{ => socionext}/uniphier-pro4-ace.dts |    0
 .../dts/{ => socionext}/uniphier-pro4-ref.dts |    0
 .../{ => socionext}/uniphier-pro4-sanji.dts   |    0
 .../dts/{ => socionext}/uniphier-pro4.dtsi    |    0
 .../dts/{ => socionext}/uniphier-pro5.dtsi    |    0
 .../{ => socionext}/uniphier-pxs2-gentil.dts  |    0
 .../{ => socionext}/uniphier-pxs2-vodka.dts   |    0
 .../dts/{ => socionext}/uniphier-pxs2.dtsi    |    0
 .../uniphier-ref-daughter.dtsi                |    0
 .../dts/{ => socionext}/uniphier-sld8-ref.dts |    0
 .../dts/{ => socionext}/uniphier-sld8.dtsi    |    0
 .../uniphier-support-card.dtsi                |    0
 arch/arm/boot/dts/st/Makefile                 |   11 +
 arch/arm/boot/dts/{ => st}/spear1310-evb.dts  |    0
 arch/arm/boot/dts/{ => st}/spear1310.dtsi     |    0
 arch/arm/boot/dts/{ => st}/spear1340-evb.dts  |    0
 arch/arm/boot/dts/{ => st}/spear1340.dtsi     |    0
 arch/arm/boot/dts/{ => st}/spear13xx.dtsi     |    0
 arch/arm/boot/dts/{ => st}/spear300-evb.dts   |    0
 arch/arm/boot/dts/{ => st}/spear300.dtsi      |    0
 arch/arm/boot/dts/{ => st}/spear310-evb.dts   |    0
 arch/arm/boot/dts/{ => st}/spear310.dtsi      |    0
 arch/arm/boot/dts/{ => st}/spear320-evb.dts   |    0
 arch/arm/boot/dts/{ => st}/spear320-hmi.dts   |    0
 arch/arm/boot/dts/{ => st}/spear320.dtsi      |    0
 arch/arm/boot/dts/{ => st}/spear320s.dtsi     |    0
 arch/arm/boot/dts/{ => st}/spear3xx.dtsi      |    0
 arch/arm/boot/dts/{ => st}/spear600-evb.dts   |    0
 arch/arm/boot/dts/{ => st}/spear600.dtsi      |    0
 arch/arm/boot/dts/st_ericsson/Makefile        |   17 +
 .../dts/{ => st_ericsson}/ste-ab8500.dtsi     |    0
 .../dts/{ => st_ericsson}/ste-ab8505.dtsi     |    0
 .../dts/{ => st_ericsson}/ste-db8500.dtsi     |    0
 .../dts/{ => st_ericsson}/ste-db8520.dtsi     |    0
 .../dts/{ => st_ericsson}/ste-db9500.dtsi     |    0
 .../{ => st_ericsson}/ste-dbx5x0-pinctrl.dtsi |    0
 .../dts/{ => st_ericsson}/ste-dbx5x0.dtsi     |    0
 .../{ => st_ericsson}/ste-href-ab8500.dtsi    |    0
 .../ste-href-family-pinctrl.dtsi              |    0
 .../dts/{ => st_ericsson}/ste-href-stuib.dtsi |    0
 .../ste-href-tvk1281618-r2.dtsi               |    0
 .../ste-href-tvk1281618-r3.dtsi               |    0
 .../boot/dts/{ => st_ericsson}/ste-href.dtsi  |    0
 .../dts/{ => st_ericsson}/ste-href520-tvk.dts |    0
 .../ste-hrefprev60-stuib.dts                  |    0
 .../{ => st_ericsson}/ste-hrefprev60-tvk.dts  |    0
 .../dts/{ => st_ericsson}/ste-hrefprev60.dtsi |    0
 .../ste-hrefv60plus-stuib.dts                 |    0
 .../{ => st_ericsson}/ste-hrefv60plus-tvk.dts |    0
 .../{ => st_ericsson}/ste-hrefv60plus.dtsi    |    0
 .../{ => st_ericsson}/ste-nomadik-nhk15.dts   |    0
 .../ste-nomadik-pinctrl.dtsi                  |    0
 .../{ => st_ericsson}/ste-nomadik-s8815.dts   |    0
 .../ste-nomadik-stn8815.dtsi                  |    0
 .../dts/{ => st_ericsson}/ste-snowball.dts    |    0
 .../ste-ux500-samsung-codina.dts              |    0
 .../ste-ux500-samsung-gavini.dts              |    0
 .../ste-ux500-samsung-golden.dts              |    0
 .../ste-ux500-samsung-janice.dts              |    0
 .../ste-ux500-samsung-kyle.dts                |    0
 .../ste-ux500-samsung-skomer.dts              |    0
 arch/arm/boot/dts/stm/Makefile                |   37 +
 arch/arm/boot/dts/stm/armv7-m.dtsi            |    1 +
 arch/arm/boot/dts/{ => stm}/st-pincfg.h       |    0
 arch/arm/boot/dts/{ => stm}/stih407-b2120.dts |    0
 .../arm/boot/dts/{ => stm}/stih407-clock.dtsi |    0
 .../boot/dts/{ => stm}/stih407-family.dtsi    |    0
 .../boot/dts/{ => stm}/stih407-pinctrl.dtsi   |    0
 arch/arm/boot/dts/{ => stm}/stih407.dtsi      |    0
 arch/arm/boot/dts/{ => stm}/stih410-b2120.dts |    0
 arch/arm/boot/dts/{ => stm}/stih410-b2260.dts |    0
 .../arm/boot/dts/{ => stm}/stih410-clock.dtsi |    0
 .../boot/dts/{ => stm}/stih410-pinctrl.dtsi   |    0
 arch/arm/boot/dts/{ => stm}/stih410.dtsi      |    0
 arch/arm/boot/dts/{ => stm}/stih418-b2199.dts |    0
 arch/arm/boot/dts/{ => stm}/stih418-b2264.dts |    0
 .../arm/boot/dts/{ => stm}/stih418-clock.dtsi |    0
 arch/arm/boot/dts/{ => stm}/stih418.dtsi      |    0
 .../arm/boot/dts/{ => stm}/stihxxx-b2120.dtsi |    0
 .../arm/boot/dts/{ => stm}/stm32429i-eval.dts |    0
 .../arm/boot/dts/{ => stm}/stm32746g-eval.dts |    0
 .../boot/dts/{ => stm}/stm32f4-pinctrl.dtsi   |    0
 .../boot/dts/{ => stm}/stm32f429-disco.dts    |    0
 .../boot/dts/{ => stm}/stm32f429-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => stm}/stm32f429.dtsi    |    0
 .../boot/dts/{ => stm}/stm32f469-disco.dts    |    0
 .../boot/dts/{ => stm}/stm32f469-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => stm}/stm32f469.dtsi    |    0
 .../boot/dts/{ => stm}/stm32f7-pinctrl.dtsi   |    0
 .../boot/dts/{ => stm}/stm32f746-disco.dts    |    0
 .../boot/dts/{ => stm}/stm32f746-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => stm}/stm32f746.dtsi    |    0
 .../boot/dts/{ => stm}/stm32f769-disco.dts    |    0
 .../boot/dts/{ => stm}/stm32f769-pinctrl.dtsi |    0
 .../boot/dts/{ => stm}/stm32h7-pinctrl.dtsi   |    0
 arch/arm/boot/dts/{ => stm}/stm32h743.dtsi    |    0
 .../boot/dts/{ => stm}/stm32h743i-disco.dts   |    0
 .../boot/dts/{ => stm}/stm32h743i-eval.dts    |    0
 arch/arm/boot/dts/{ => stm}/stm32h750.dtsi    |    0
 .../boot/dts/{ => stm}/stm32h750i-art-pi.dts  |    0
 .../boot/dts/{ => stm}/stm32mp13-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => stm}/stm32mp131.dtsi   |    0
 arch/arm/boot/dts/{ => stm}/stm32mp133.dtsi   |    0
 arch/arm/boot/dts/{ => stm}/stm32mp135.dtsi   |    0
 .../arm/boot/dts/{ => stm}/stm32mp135f-dk.dts |    0
 arch/arm/boot/dts/{ => stm}/stm32mp13xc.dtsi  |    0
 arch/arm/boot/dts/{ => stm}/stm32mp13xf.dtsi  |    0
 .../boot/dts/{ => stm}/stm32mp15-pinctrl.dtsi |    0
 arch/arm/boot/dts/{ => stm}/stm32mp151.dtsi   |    0
 arch/arm/boot/dts/{ => stm}/stm32mp153.dtsi   |    0
 .../dts/{ => stm}/stm32mp153c-dhcom-drc02.dts |    0
 arch/arm/boot/dts/{ => stm}/stm32mp157.dtsi   |    0
 .../dts/{ => stm}/stm32mp157a-avenger96.dts   |    0
 .../{ => stm}/stm32mp157a-dhcor-avenger96.dts |    0
 .../boot/dts/{ => stm}/stm32mp157a-dk1.dts    |    0
 ...tm32mp157a-icore-stm32mp1-ctouch2-of10.dts |    0
 .../stm32mp157a-icore-stm32mp1-ctouch2.dts    |    0
 .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |    0
 .../{ => stm}/stm32mp157a-icore-stm32mp1.dtsi |    0
 .../dts/{ => stm}/stm32mp157a-iot-box.dts     |    0
 ...157a-microgea-stm32mp1-microdev2.0-of7.dts |    0
 ...32mp157a-microgea-stm32mp1-microdev2.0.dts |    0
 .../stm32mp157a-microgea-stm32mp1.dtsi        |    0
 .../dts/{ => stm}/stm32mp157a-stinger96.dts   |    0
 .../dts/{ => stm}/stm32mp157a-stinger96.dtsi  |    0
 .../dts/{ => stm}/stm32mp157c-dhcom-pdk2.dts  |    0
 .../{ => stm}/stm32mp157c-dhcom-picoitx.dts   |    0
 .../boot/dts/{ => stm}/stm32mp157c-dk2.dts    |    0
 .../boot/dts/{ => stm}/stm32mp157c-ed1.dts    |    0
 .../dts/{ => stm}/stm32mp157c-emsbc-argon.dts |    0
 .../{ => stm}/stm32mp157c-emstamp-argon.dtsi  |    0
 .../boot/dts/{ => stm}/stm32mp157c-ev1.dts    |    0
 .../dts/{ => stm}/stm32mp157c-lxa-mc1.dts     |    0
 .../{ => stm}/stm32mp157c-odyssey-som.dtsi    |    0
 .../dts/{ => stm}/stm32mp157c-odyssey.dts     |    0
 arch/arm/boot/dts/{ => stm}/stm32mp15xc.dtsi  |    0
 .../{ => stm}/stm32mp15xx-dhcom-drc02.dtsi    |    0
 .../dts/{ => stm}/stm32mp15xx-dhcom-pdk2.dtsi |    0
 .../{ => stm}/stm32mp15xx-dhcom-picoitx.dtsi  |    0
 .../dts/{ => stm}/stm32mp15xx-dhcom-som.dtsi  |    0
 .../stm32mp15xx-dhcor-avenger96.dtsi          |    0
 .../{ => stm}/stm32mp15xx-dhcor-io1v8.dtsi    |    0
 .../dts/{ => stm}/stm32mp15xx-dhcor-som.dtsi  |    0
 .../boot/dts/{ => stm}/stm32mp15xx-dkx.dtsi   |    0
 .../boot/dts/{ => stm}/stm32mp15xx-osd32.dtsi |    0
 .../dts/{ => stm}/stm32mp15xxaa-pinctrl.dtsi  |    0
 .../dts/{ => stm}/stm32mp15xxab-pinctrl.dtsi  |    0
 .../dts/{ => stm}/stm32mp15xxac-pinctrl.dtsi  |    0
 .../dts/{ => stm}/stm32mp15xxad-pinctrl.dtsi  |    0
 arch/arm/boot/dts/ti/Makefile                 |  164 ++
 .../dts/{ => ti}/am335x-baltos-ir2110.dts     |    0
 .../dts/{ => ti}/am335x-baltos-ir3220.dts     |    0
 .../dts/{ => ti}/am335x-baltos-ir5221.dts     |    0
 .../boot/dts/{ => ti}/am335x-baltos-leds.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am335x-baltos.dtsi |    0
 .../arm/boot/dts/{ => ti}/am335x-base0033.dts |    0
 .../boot/dts/{ => ti}/am335x-bone-common.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am335x-bone.dts    |    0
 .../dts/{ => ti}/am335x-boneblack-common.dtsi |    0
 .../dts/{ => ti}/am335x-boneblack-hdmi.dtsi   |    0
 .../{ => ti}/am335x-boneblack-wireless.dts    |    0
 .../boot/dts/{ => ti}/am335x-boneblack.dts    |    0
 .../arm/boot/dts/{ => ti}/am335x-boneblue.dts |    0
 .../dts/{ => ti}/am335x-bonegreen-common.dtsi |    0
 .../{ => ti}/am335x-bonegreen-wireless.dts    |    0
 .../boot/dts/{ => ti}/am335x-bonegreen.dts    |    0
 .../boot/dts/{ => ti}/am335x-chiliboard.dts   |    0
 .../boot/dts/{ => ti}/am335x-chilisom.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/am335x-cm-t335.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-evm.dts     |    0
 arch/arm/boot/dts/{ => ti}/am335x-evmsk.dts   |    0
 .../arm/boot/dts/{ => ti}/am335x-guardian.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-icev2.dts   |    0
 .../boot/dts/{ => ti}/am335x-igep0033.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/am335x-lxm.dts     |    0
 .../{ => ti}/am335x-moxa-uc-2100-common.dtsi  |    0
 .../boot/dts/{ => ti}/am335x-moxa-uc-2101.dts |    0
 .../{ => ti}/am335x-moxa-uc-8100-common.dtsi  |    0
 .../dts/{ => ti}/am335x-moxa-uc-8100-me-t.dts |    0
 .../dts/{ => ti}/am335x-myirtech-myc.dtsi     |    0
 .../boot/dts/{ => ti}/am335x-myirtech-myd.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-nano.dts    |    0
 .../dts/{ => ti}/am335x-netcan-plus-1xx.dts   |    0
 .../dts/{ => ti}/am335x-netcom-plus-2xx.dts   |    0
 .../dts/{ => ti}/am335x-netcom-plus-8xx.dts   |    0
 .../dts/{ => ti}/am335x-osd3358-sm-red.dts    |    0
 .../dts/{ => ti}/am335x-osd335x-common.dtsi   |    0
 .../arm/boot/dts/{ => ti}/am335x-pcm-953.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am335x-pdu001.dts  |    0
 arch/arm/boot/dts/{ => ti}/am335x-pepper.dts  |    0
 .../boot/dts/{ => ti}/am335x-phycore-rdk.dts  |    0
 .../boot/dts/{ => ti}/am335x-phycore-som.dtsi |    0
 .../boot/dts/{ => ti}/am335x-pocketbeagle.dts |    0
 .../boot/dts/{ => ti}/am335x-regor-rdk.dts    |    0
 arch/arm/boot/dts/{ => ti}/am335x-regor.dtsi  |    0
 .../{ => ti}/am335x-sancloud-bbe-common.dtsi  |    0
 .../am335x-sancloud-bbe-extended-wifi.dts     |    0
 .../dts/{ => ti}/am335x-sancloud-bbe-lite.dts |    0
 .../boot/dts/{ => ti}/am335x-sancloud-bbe.dts |    0
 .../arm/boot/dts/{ => ti}/am335x-sbc-t335.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-shc.dts     |    0
 arch/arm/boot/dts/{ => ti}/am335x-sl50.dts    |    0
 .../arm/boot/dts/{ => ti}/am335x-wega-rdk.dts |    0
 arch/arm/boot/dts/{ => ti}/am335x-wega.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/am33xx-clocks.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am33xx-l4.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/am33xx.dtsi        |    0
 .../boot/dts/{ => ti}/am3517-craneboard.dts   |    0
 arch/arm/boot/dts/{ => ti}/am3517-evm-ui.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am3517-evm.dts     |    0
 arch/arm/boot/dts/{ => ti}/am3517-som.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/am3517.dtsi        |    0
 .../boot/dts/{ => ti}/am3517_mt_ventoux.dts   |    0
 arch/arm/boot/dts/{ => ti}/am35xx-clocks.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am3703.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/am3715.dtsi        |    0
 .../arm/boot/dts/{ => ti}/am3874-iceboard.dts |    0
 arch/arm/boot/dts/{ => ti}/am4372.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/am437x-cm-t43.dts  |    0
 arch/arm/boot/dts/{ => ti}/am437x-gp-evm.dts  |    0
 arch/arm/boot/dts/{ => ti}/am437x-idk-evm.dts |    0
 arch/arm/boot/dts/{ => ti}/am437x-l4.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/am437x-sbc-t43.dts |    0
 arch/arm/boot/dts/{ => ti}/am437x-sk-evm.dts  |    0
 arch/arm/boot/dts/{ => ti}/am43x-epos-evm.dts |    0
 arch/arm/boot/dts/{ => ti}/am43xx-clocks.dtsi |    0
 arch/arm/boot/dts/{ => ti}/am57-pruss.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/am5718.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/am571x-idk.dts     |    0
 arch/arm/boot/dts/{ => ti}/am5728.dtsi        |    0
 .../boot/dts/{ => ti}/am5729-beagleboneai.dts |    0
 .../boot/dts/{ => ti}/am572x-idk-common.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/am572x-idk.dts     |    0
 arch/arm/boot/dts/{ => ti}/am5748.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/am574x-idk.dts     |    0
 .../{ => ti}/am57xx-beagle-x15-common.dtsi    |    0
 .../dts/{ => ti}/am57xx-beagle-x15-revb1.dts  |    0
 .../dts/{ => ti}/am57xx-beagle-x15-revc.dts   |    0
 .../boot/dts/{ => ti}/am57xx-beagle-x15.dts   |    0
 .../boot/dts/{ => ti}/am57xx-cl-som-am57x.dts |    0
 .../dts/{ => ti}/am57xx-commercial-grade.dtsi |    0
 .../boot/dts/{ => ti}/am57xx-idk-common.dtsi  |    0
 .../dts/{ => ti}/am57xx-industrial-grade.dtsi |    0
 .../boot/dts/{ => ti}/am57xx-sbc-am57x.dts    |    0
 .../boot/dts/{ => ti}/compulab-sb-som.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/da850-enbw-cmc.dts |    0
 arch/arm/boot/dts/{ => ti}/da850-evm.dts      |    0
 arch/arm/boot/dts/{ => ti}/da850-lcdk.dts     |    0
 arch/arm/boot/dts/{ => ti}/da850-lego-ev3.dts |    0
 arch/arm/boot/dts/{ => ti}/da850.dtsi         |    0
 arch/arm/boot/dts/{ => ti}/dm3725.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/dm8148-evm.dts     |    0
 arch/arm/boot/dts/{ => ti}/dm8148-t410.dts    |    0
 arch/arm/boot/dts/{ => ti}/dm814x-clocks.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dm814x.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/dm8168-evm.dts     |    0
 arch/arm/boot/dts/{ => ti}/dm816x-clocks.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dm816x.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/dra62x-clocks.dtsi |    0
 .../boot/dts/{ => ti}/dra62x-j5eco-evm.dts    |    0
 arch/arm/boot/dts/{ => ti}/dra62x.dtsi        |    0
 .../dts/{ => ti}/dra7-dspeve-thermal.dtsi     |    0
 .../boot/dts/{ => ti}/dra7-evm-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/dra7-evm.dts       |    0
 .../dts/{ => ti}/dra7-ipu-dsp-common.dtsi     |    0
 .../boot/dts/{ => ti}/dra7-iva-thermal.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/dra7-l4.dtsi       |    0
 .../boot/dts/{ => ti}/dra7-mmc-iodelay.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/dra7.dtsi          |    0
 arch/arm/boot/dts/{ => ti}/dra71-evm.dts      |    0
 arch/arm/boot/dts/{ => ti}/dra71x.dtsi        |    0
 .../boot/dts/{ => ti}/dra72-evm-common.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/dra72-evm-revc.dts |    0
 .../boot/dts/{ => ti}/dra72-evm-tps65917.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra72-evm.dts      |    0
 .../boot/dts/{ => ti}/dra72x-mmc-iodelay.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra72x.dtsi        |    0
 .../dts/{ => ti}/dra74-ipu-dsp-common.dtsi    |    0
 .../boot/dts/{ => ti}/dra74x-mmc-iodelay.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra74x-p.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/dra74x.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/dra76-evm.dts      |    0
 .../boot/dts/{ => ti}/dra76x-mmc-iodelay.dtsi |    0
 arch/arm/boot/dts/{ => ti}/dra76x.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/dra7xx-clocks.dtsi |    0
 .../boot/dts/{ => ti}/elpida_ecb240abacn.dtsi |    0
 .../boot/dts/{ => ti}/keystone-clocks.dtsi    |    0
 .../dts/{ => ti}/keystone-k2e-clocks.dtsi     |    0
 .../boot/dts/{ => ti}/keystone-k2e-evm.dts    |    0
 .../boot/dts/{ => ti}/keystone-k2e-netcp.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2e.dtsi  |    0
 .../boot/dts/{ => ti}/keystone-k2g-evm.dts    |    0
 .../boot/dts/{ => ti}/keystone-k2g-ice.dts    |    0
 .../boot/dts/{ => ti}/keystone-k2g-netcp.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2g.dtsi  |    0
 .../dts/{ => ti}/keystone-k2hk-clocks.dtsi    |    0
 .../boot/dts/{ => ti}/keystone-k2hk-evm.dts   |    0
 .../dts/{ => ti}/keystone-k2hk-netcp.dtsi     |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2hk.dtsi |    0
 .../dts/{ => ti}/keystone-k2l-clocks.dtsi     |    0
 .../boot/dts/{ => ti}/keystone-k2l-evm.dts    |    0
 .../boot/dts/{ => ti}/keystone-k2l-netcp.dtsi |    0
 arch/arm/boot/dts/{ => ti}/keystone-k2l.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/keystone.dtsi      |    0
 .../{ => ti}/logicpd-som-lv-35xx-devkit.dts   |    0
 .../{ => ti}/logicpd-som-lv-37xx-devkit.dts   |    0
 .../{ => ti}/logicpd-som-lv-baseboard.dtsi    |    0
 .../arm/boot/dts/{ => ti}/logicpd-som-lv.dtsi |    0
 .../{ => ti}/logicpd-torpedo-35xx-devkit.dts  |    0
 .../logicpd-torpedo-37xx-devkit-28.dts        |    0
 .../{ => ti}/logicpd-torpedo-37xx-devkit.dts  |    0
 .../{ => ti}/logicpd-torpedo-baseboard.dtsi   |    0
 .../dts/{ => ti}/logicpd-torpedo-som.dtsi     |    0
 .../dts/{ => ti}/motorola-cpcap-mapphone.dtsi |    0
 .../{ => ti}/motorola-mapphone-common.dtsi    |    0
 .../arm/boot/dts/{ => ti}/nspire-classic.dtsi |    0
 arch/arm/boot/dts/{ => ti}/nspire-clp.dts     |    0
 arch/arm/boot/dts/{ => ti}/nspire-cx.dts      |    0
 arch/arm/boot/dts/{ => ti}/nspire-tp.dts      |    0
 arch/arm/boot/dts/{ => ti}/nspire.dtsi        |    0
 .../boot/dts/{ => ti}/omap-gpmc-smsc911x.dtsi |    0
 .../boot/dts/{ => ti}/omap-gpmc-smsc9221.dtsi |    0
 .../boot/dts/{ => ti}/omap-zoom-common.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/omap2.dtsi         |    0
 .../boot/dts/{ => ti}/omap2420-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap2420-h4.dts    |    0
 arch/arm/boot/dts/{ => ti}/omap2420-n800.dts  |    0
 .../boot/dts/{ => ti}/omap2420-n810-wimax.dts |    0
 arch/arm/boot/dts/{ => ti}/omap2420-n810.dts  |    0
 .../dts/{ => ti}/omap2420-n8x0-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap2420.dtsi      |    0
 .../boot/dts/{ => ti}/omap2430-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap2430-sdp.dts   |    0
 arch/arm/boot/dts/{ => ti}/omap2430.dtsi      |    0
 .../boot/dts/{ => ti}/omap24xx-clocks.dtsi    |    0
 .../boot/dts/{ => ti}/omap3-beagle-ab4.dts    |    0
 .../boot/dts/{ => ti}/omap3-beagle-xm-ab.dts  |    0
 .../arm/boot/dts/{ => ti}/omap3-beagle-xm.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-beagle.dts   |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3517.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3530.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3730.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-cm-t3x.dtsi  |    0
 .../arm/boot/dts/{ => ti}/omap3-cm-t3x30.dtsi |    0
 .../boot/dts/{ => ti}/omap3-cpu-thermal.dtsi  |    0
 .../dts/{ => ti}/omap3-devkit8000-common.dtsi |    0
 .../{ => ti}/omap3-devkit8000-lcd-common.dtsi |    0
 .../dts/{ => ti}/omap3-devkit8000-lcd43.dts   |    0
 .../dts/{ => ti}/omap3-devkit8000-lcd70.dts   |    0
 .../boot/dts/{ => ti}/omap3-devkit8000.dts    |    0
 arch/arm/boot/dts/{ => ti}/omap3-echo.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-evm-37xx.dts |    0
 .../boot/dts/{ => ti}/omap3-evm-common.dtsi   |    0
 .../{ => ti}/omap3-evm-processor-common.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/omap3-evm.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04a3.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04a4.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap3-gta04a5.dts  |    0
 .../boot/dts/{ => ti}/omap3-gta04a5one.dts    |    0
 .../boot/dts/{ => ti}/omap3-ha-common.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap3-ha-lcd.dts   |    0
 arch/arm/boot/dts/{ => ti}/omap3-ha.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap3-igep.dtsi    |    0
 .../dts/{ => ti}/omap3-igep0020-common.dtsi   |    0
 .../dts/{ => ti}/omap3-igep0020-rev-f.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-igep0020.dts |    0
 .../dts/{ => ti}/omap3-igep0030-common.dtsi   |    0
 .../dts/{ => ti}/omap3-igep0030-rev-g.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-igep0030.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-ldp.dts      |    0
 .../boot/dts/{ => ti}/omap3-lilly-a83x.dtsi   |    0
 .../boot/dts/{ => ti}/omap3-lilly-dbb056.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap3-n9.dts       |    0
 arch/arm/boot/dts/{ => ti}/omap3-n900.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap3-n950-n9.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap3-n950.dts     |    0
 .../{ => ti}/omap3-overo-alto35-common.dtsi   |    0
 .../boot/dts/{ => ti}/omap3-overo-alto35.dts  |    0
 .../boot/dts/{ => ti}/omap3-overo-base.dtsi   |    0
 .../omap3-overo-chestnut43-common.dtsi        |    0
 .../dts/{ => ti}/omap3-overo-chestnut43.dts   |    0
 .../dts/{ => ti}/omap3-overo-common-dvi.dtsi  |    0
 .../{ => ti}/omap3-overo-common-lcd35.dtsi    |    0
 .../{ => ti}/omap3-overo-common-lcd43.dtsi    |    0
 .../omap3-overo-common-peripherals.dtsi       |    0
 .../{ => ti}/omap3-overo-gallop43-common.dtsi |    0
 .../dts/{ => ti}/omap3-overo-gallop43.dts     |    0
 .../{ => ti}/omap3-overo-palo35-common.dtsi   |    0
 .../boot/dts/{ => ti}/omap3-overo-palo35.dts  |    0
 .../{ => ti}/omap3-overo-palo43-common.dtsi   |    0
 .../boot/dts/{ => ti}/omap3-overo-palo43.dts  |    0
 .../dts/{ => ti}/omap3-overo-storm-alto35.dts |    0
 .../{ => ti}/omap3-overo-storm-chestnut43.dts |    0
 .../{ => ti}/omap3-overo-storm-gallop43.dts   |    0
 .../dts/{ => ti}/omap3-overo-storm-palo35.dts |    0
 .../dts/{ => ti}/omap3-overo-storm-palo43.dts |    0
 .../dts/{ => ti}/omap3-overo-storm-summit.dts |    0
 .../dts/{ => ti}/omap3-overo-storm-tobi.dts   |    0
 .../{ => ti}/omap3-overo-storm-tobiduo.dts    |    0
 .../boot/dts/{ => ti}/omap3-overo-storm.dtsi  |    0
 .../{ => ti}/omap3-overo-summit-common.dtsi   |    0
 .../boot/dts/{ => ti}/omap3-overo-summit.dts  |    0
 .../dts/{ => ti}/omap3-overo-tobi-common.dtsi |    0
 .../boot/dts/{ => ti}/omap3-overo-tobi.dts    |    0
 .../{ => ti}/omap3-overo-tobiduo-common.dtsi  |    0
 .../boot/dts/{ => ti}/omap3-overo-tobiduo.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-overo.dtsi   |    0
 .../boot/dts/{ => ti}/omap3-pandora-1ghz.dts  |    0
 .../dts/{ => ti}/omap3-pandora-600mhz.dts     |    0
 .../dts/{ => ti}/omap3-pandora-common.dtsi    |    0
 .../omap3-panel-sharp-ls037v7dw01.dtsi        |    0
 arch/arm/boot/dts/{ => ti}/omap3-sb-t35.dtsi  |    0
 .../arm/boot/dts/{ => ti}/omap3-sbc-t3517.dts |    0
 .../arm/boot/dts/{ => ti}/omap3-sbc-t3530.dts |    0
 .../arm/boot/dts/{ => ti}/omap3-sbc-t3730.dts |    0
 arch/arm/boot/dts/{ => ti}/omap3-sniper.dts   |    0
 arch/arm/boot/dts/{ => ti}/omap3-tao3530.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap3-thunder.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap3-zoom3.dts    |    0
 arch/arm/boot/dts/{ => ti}/omap3.dtsi         |    0
 arch/arm/boot/dts/{ => ti}/omap3430-sdp.dts   |    0
 .../boot/dts/{ => ti}/omap3430es1-clocks.dtsi |    0
 .../{ => ti}/omap34xx-omap36xx-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap34xx.dtsi      |    0
 ...map36xx-am35xx-omap3430es2plus-clocks.dtsi |    0
 .../boot/dts/{ => ti}/omap36xx-clocks.dtsi    |    0
 .../omap36xx-omap3430es2plus-clocks.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/omap36xx.dtsi      |    0
 .../boot/dts/{ => ti}/omap3xxx-clocks.dtsi    |    0
 .../boot/dts/{ => ti}/omap4-cpu-thermal.dtsi  |    0
 .../dts/{ => ti}/omap4-droid-bionic-xt875.dts |    0
 .../boot/dts/{ => ti}/omap4-droid4-xt894.dts  |    0
 .../dts/{ => ti}/omap4-duovero-parlor.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap4-duovero.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap4-kc1.dts      |    0
 arch/arm/boot/dts/{ => ti}/omap4-l4-abe.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/omap4-l4.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/omap4-mcpdm.dtsi   |    0
 arch/arm/boot/dts/{ => ti}/omap4-panda-a4.dts |    0
 .../boot/dts/{ => ti}/omap4-panda-common.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap4-panda-es.dts |    0
 arch/arm/boot/dts/{ => ti}/omap4-panda.dts    |    0
 .../boot/dts/{ => ti}/omap4-sdp-es23plus.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap4-sdp.dts      |    0
 .../boot/dts/{ => ti}/omap4-var-dvk-om44.dts  |    0
 .../{ => ti}/omap4-var-om44customboard.dtsi   |    0
 .../dts/{ => ti}/omap4-var-som-om44-wlan.dtsi |    0
 .../boot/dts/{ => ti}/omap4-var-som-om44.dtsi |    0
 .../boot/dts/{ => ti}/omap4-var-stk-om44.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap4.dtsi         |    0
 .../boot/dts/{ => ti}/omap443x-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/omap443x.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/omap4460.dtsi      |    0
 .../boot/dts/{ => ti}/omap446x-clocks.dtsi    |    0
 .../boot/dts/{ => ti}/omap44xx-clocks.dtsi    |    0
 .../boot/dts/{ => ti}/omap5-board-common.dtsi |    0
 arch/arm/boot/dts/{ => ti}/omap5-cm-t54.dts   |    0
 .../boot/dts/{ => ti}/omap5-core-thermal.dtsi |    0
 .../boot/dts/{ => ti}/omap5-gpu-thermal.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/omap5-igep0050.dts |    0
 arch/arm/boot/dts/{ => ti}/omap5-l4-abe.dtsi  |    0
 arch/arm/boot/dts/{ => ti}/omap5-l4.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/omap5-sbc-t54.dts  |    0
 arch/arm/boot/dts/{ => ti}/omap5-uevm.dts     |    0
 arch/arm/boot/dts/{ => ti}/omap5.dtsi         |    0
 .../boot/dts/{ => ti}/omap54xx-clocks.dtsi    |    0
 arch/arm/boot/dts/{ => ti}/tps6507x.dtsi      |    0
 arch/arm/boot/dts/{ => ti}/tps65217.dtsi      |    0
 arch/arm/boot/dts/ti/tps65910.dtsi            |    1 +
 arch/arm/boot/dts/{ => ti}/twl4030.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/twl4030_omap3.dtsi |    0
 arch/arm/boot/dts/{ => ti}/twl6030.dtsi       |    0
 arch/arm/boot/dts/{ => ti}/twl6030_omap4.dtsi |    0
 arch/arm/boot/dts/via/Makefile                |    7 +
 arch/arm/boot/dts/{ => via}/vt8500-bv07.dts   |    0
 arch/arm/boot/dts/{ => via}/vt8500.dtsi       |    0
 arch/arm/boot/dts/{ => via}/wm8505-ref.dts    |    0
 arch/arm/boot/dts/{ => via}/wm8505.dtsi       |    0
 arch/arm/boot/dts/{ => via}/wm8650-mid.dts    |    0
 arch/arm/boot/dts/{ => via}/wm8650.dtsi       |    0
 .../arm/boot/dts/{ => via}/wm8750-apc8750.dts |    0
 arch/arm/boot/dts/{ => via}/wm8750.dtsi       |    0
 arch/arm/boot/dts/{ => via}/wm8850-w70v2.dts  |    0
 arch/arm/boot/dts/{ => via}/wm8850.dtsi       |    0
 arch/arm/boot/dts/virtual/Makefile            |    3 +
 arch/arm/boot/dts/{ => virtual}/xenvm-4.2.dts |    0
 arch/arm/boot/dts/vybrid/Makefile             |   16 +
 arch/arm/boot/dts/vybrid/armv7-m.dtsi         |    1 +
 .../dts/{ => vybrid}/vf-colibri-eval-v3.dtsi  |    0
 .../arm/boot/dts/{ => vybrid}/vf-colibri.dtsi |    0
 .../{ => vybrid}/vf500-colibri-eval-v3.dts    |    0
 .../boot/dts/{ => vybrid}/vf500-colibri.dtsi  |    0
 arch/arm/boot/dts/{ => vybrid}/vf500.dtsi     |    0
 arch/arm/boot/dts/{ => vybrid}/vf610-bk4.dts  |    0
 .../{ => vybrid}/vf610-colibri-eval-v3.dts    |    0
 .../boot/dts/{ => vybrid}/vf610-colibri.dtsi  |    0
 .../boot/dts/{ => vybrid}/vf610-cosmic.dts    |    0
 .../arm/boot/dts/{ => vybrid}/vf610-pinfunc.h |    0
 arch/arm/boot/dts/{ => vybrid}/vf610-twr.dts  |    0
 .../boot/dts/{ => vybrid}/vf610-zii-cfu1.dts  |    0
 .../dts/{ => vybrid}/vf610-zii-dev-rev-b.dts  |    0
 .../dts/{ => vybrid}/vf610-zii-dev-rev-c.dts  |    0
 .../boot/dts/{ => vybrid}/vf610-zii-dev.dtsi  |    0
 .../dts/{ => vybrid}/vf610-zii-scu4-aib.dts   |    0
 .../boot/dts/{ => vybrid}/vf610-zii-spb4.dts  |    0
 .../dts/{ => vybrid}/vf610-zii-ssmb-dtu.dts   |    0
 .../dts/{ => vybrid}/vf610-zii-ssmb-spu3.dts  |    0
 arch/arm/boot/dts/{ => vybrid}/vf610.dtsi     |    0
 .../boot/dts/{ => vybrid}/vf610m4-colibri.dts |    0
 .../boot/dts/{ => vybrid}/vf610m4-cosmic.dts  |    0
 arch/arm/boot/dts/{ => vybrid}/vf610m4.dtsi   |    0
 arch/arm/boot/dts/{ => vybrid}/vfxxx.dtsi     |    0
 arch/arm/boot/dts/xilinx/Makefile             |   17 +
 arch/arm/boot/dts/{ => xilinx}/zynq-7000.dtsi |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-cc108.dts |    0
 .../boot/dts/{ => xilinx}/zynq-ebaz4205.dts   |    0
 .../boot/dts/{ => xilinx}/zynq-microzed.dts   |    0
 .../boot/dts/{ => xilinx}/zynq-parallella.dts |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zc702.dts |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zc706.dts |    0
 .../dts/{ => xilinx}/zynq-zc770-xm010.dts     |    0
 .../dts/{ => xilinx}/zynq-zc770-xm011.dts     |    0
 .../dts/{ => xilinx}/zynq-zc770-xm012.dts     |    0
 .../dts/{ => xilinx}/zynq-zc770-xm013.dts     |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zed.dts   |    0
 .../dts/{ => xilinx}/zynq-zturn-common.dtsi   |    0
 .../boot/dts/{ => xilinx}/zynq-zturn-v5.dts   |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zturn.dts |    0
 .../boot/dts/{ => xilinx}/zynq-zybo-z7.dts    |    0
 arch/arm/boot/dts/{ => xilinx}/zynq-zybo.dts  |    0
 arch/arm/boot/dts/xscale/Makefile             |   19 +
 .../{ => xscale}/intel-ixp42x-adi-coyote.dts  |    0
 .../intel-ixp42x-arcom-vulcan.dts             |    0
 .../intel-ixp42x-dlink-dsm-g600.dts           |    0
 .../intel-ixp42x-freecom-fsg-3.dts            |    0
 .../intel-ixp42x-gateway-7001.dts             |    0
 .../intel-ixp42x-gateworks-gw2348.dts         |    0
 .../intel-ixp42x-goramo-multilink.dts         |    0
 .../intel-ixp42x-iomega-nas100d.dts           |    0
 .../dts/{ => xscale}/intel-ixp42x-ixdp425.dts |    0
 .../{ => xscale}/intel-ixp42x-ixdpg425.dts    |    0
 .../intel-ixp42x-linksys-nslu2.dts            |    0
 .../intel-ixp42x-linksys-wrv54g.dts           |    0
 .../intel-ixp42x-netgear-wg302v1.dts          |    0
 .../intel-ixp42x-welltech-epbx100.dts         |    0
 .../boot/dts/{ => xscale}/intel-ixp42x.dtsi   |    0
 .../intel-ixp43x-gateworks-gw2358.dts         |    0
 .../{ => xscale}/intel-ixp43x-kixrp435.dts    |    0
 .../boot/dts/{ => xscale}/intel-ixp43x.dtsi   |    0
 .../dts/{ => xscale}/intel-ixp45x-ixp46x.dtsi |    0
 .../dts/{ => xscale}/intel-ixp46x-ixdp465.dts |    0
 .../intel-ixp4xx-reference-design.dtsi        |    0
 .../boot/dts/{ => xscale}/intel-ixp4xx.dtsi   |    0
 .../sun50i-h5-bananapi-m2-plus-v1.2.dts       |    2 +-
 .../allwinner/sun50i-h5-bananapi-m2-plus.dts  |    2 +-
 .../allwinner/sun50i-h5-emlid-neutis-n5.dtsi  |    2 +-
 .../sun50i-h5-libretech-all-h3-cc.dts         |    2 +-
 .../sun50i-h5-libretech-all-h3-it.dts         |    2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |    2 +-
 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi |    2 +-
 .../boot/dts/broadcom/bcm2711-rpi-4-b.dts     |    2 +-
 .../boot/dts/broadcom/bcm2711-rpi-400.dts     |    2 +-
 .../boot/dts/broadcom/bcm2711-rpi-cm4-io.dts  |    2 +-
 .../dts/broadcom/bcm2837-rpi-3-a-plus.dts     |    2 +-
 .../dts/broadcom/bcm2837-rpi-3-b-plus.dts     |    2 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-b.dts     |    2 +-
 .../boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts |    2 +-
 .../dts/broadcom/bcm2837-rpi-zero-2-w.dts     |    2 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi       |    2 +-
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |    2 +-
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |    2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |    2 +-
 .../qcom/sc7280-herobrine-herobrine-r0.dts    |    2 +-
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |    2 +-
 .../arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi |    2 +-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  |    2 +-
 .../dts/rockchip/rk3399pro-rock-pi-n10.dts    |    2 +-
 .../boot/dts/socionext/uniphier-pinctrl.dtsi  |    2 +-
 .../dts/socionext/uniphier-ref-daughter.dtsi  |    2 +-
 .../dts/socionext/uniphier-support-card.dtsi  |    2 +-
 2521 files changed, 1701 insertions(+), 1596 deletions(-)
 create mode 100644 arch/arm/boot/dts/actions/Makefile
 rename arch/arm/boot/dts/{ => actions}/owl-s500-cubieboard6.dts (100%)
 rename arch/arm/boot/dts/{ => actions}/owl-s500-guitar-bb-rev-b.dts (100%)
 rename arch/arm/boot/dts/{ => actions}/owl-s500-guitar.dtsi (100%)
 rename arch/arm/boot/dts/{ => actions}/owl-s500-labrador-base-m.dts (100%)
 rename arch/arm/boot/dts/{ => actions}/owl-s500-labrador-v2.dtsi (100%)
 rename arch/arm/boot/dts/{ => actions}/owl-s500-roseapplepi.dts (100%)
 rename arch/arm/boot/dts/{ => actions}/owl-s500-sparky.dts (100%)
 rename arch/arm/boot/dts/{ => actions}/owl-s500.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/airoha/Makefile
 rename arch/arm/boot/dts/{ => airoha}/en7523-evb.dts (100%)
 rename arch/arm/boot/dts/{ => airoha}/en7523.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/allwinner/Makefile
 rename arch/arm/boot/dts/{ => allwinner}/axp152.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/axp209.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/axp223.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/axp22x.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/axp809.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/axp81x.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-a1000.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-ba10-tvbox.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-chuwi-v7-cw0825.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-cubieboard.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-dserve-dsrv9703c.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-gemei-g9.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-hackberry.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-hyundai-a7hd.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-inet1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-inet97fv2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-inet9f-rev03.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-itead-iteaduino-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-jesurun-q5.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-marsboard.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-mini-xplus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-mk802.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-mk802ii.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-olinuxino-lime.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-pcduino.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-pcduino2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-pov-protab2-ips9.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10-topwise-a721.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun4i-a10.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a10s-auxtek-t003.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a10s-auxtek-t004.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a10s-mk802.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a10s-olinuxino-micro.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a10s-r7-tv-dongle.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a10s-wobo-i5.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a10s.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-difrnce-dit4350.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-empire-electronix-d709.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-empire-electronix-m712.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-hsg-h702.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-inet-98v-rev2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-licheepi-one.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-olinuxino-micro.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-olinuxino.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-pocketbook-touch-lux-3.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-q8-tablet.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13-utoo-p66.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-a13.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-gr8-chip-pro.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-gr8-evb.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-gr8.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-r8-chip.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-r8.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i-reference-design-tablet.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun5i.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31-app4-evb1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31-colombus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31-hummingbird.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31-i7.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31-m9.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31-mele-a1000g-quad.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-colorfly-e708-q1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-cs908.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-inet-q972.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-primo81.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-sina31s-core.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-sina31s.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-sinovoip-bpi-m2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s-yones-toptech-bs1078-v2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-a31s.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun6i-reference-design-tablet.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-bananapi-m1-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-bananapi.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-bananapro.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-cubieboard2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-cubietruck.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-haoyu-marsboard.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-hummingbird.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-i12-tvbox.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-icnova-swac.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-itead-ibox.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-lamobo-r1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-linutronix-testbox-v2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-m3.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-mk808c.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olimex-som-evb-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olimex-som-evb.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olimex-som204-evb-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olimex-som204-evb.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olinuxino-lime-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olinuxino-lime.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olinuxino-lime2-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olinuxino-lime2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olinuxino-micro-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-olinuxino-micro.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-orangepi-mini.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-orangepi.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-pcduino3-nano.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-pcduino3.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-wexler-tab7200.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20-wits-pro-a20-dkt.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun7i-a20.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-a33.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-evb.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-gt90h-v4.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-inet86dz.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-ippo-q8h-v1.2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-ippo-q8h-v5.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-polaroid-mid2407pxe03.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-polaroid-mid2809pxe04.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23-q8-tablet.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a23.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33-et-q8-v1.6.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33-ga10h-v1.1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33-inet-d978-rev2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33-ippo-q8h-v1.2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33-olinuxino.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33-q8-tablet.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33-sinlinx-sina33.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a33.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a83t-allwinner-h8homlet-v2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a83t-bananapi-m3.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a83t-cubietruck-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a83t-tbs-a711.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-a83t.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h2-plus-bananapi-m2-zero.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h2-plus-libretech-all-h3-cc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h2-plus-orangepi-r1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h2-plus-orangepi-zero.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-bananapi-m2-plus-v1.2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-bananapi-m2-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-beelink-x2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-emlid-neutis-n5h3-devboard.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-emlid-neutis-n5h3.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-libretech-all-h3-cc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-mapleboard-mp130.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-nanopi-duo2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-nanopi-m1-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-nanopi-m1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-nanopi-neo-air.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-nanopi-neo.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-nanopi-r1.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-nanopi.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-lite.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-one.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-pc-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-pc.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-plus2e.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-orangepi-zero-plus2.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-rervision-dvk.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3-zeropi.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-h3.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-q8-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r16-bananapi-m2m.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r16-nintendo-nes-classic.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r16-nintendo-super-nes-classic.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r16-parrot.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r40-bananapi-m2-ultra.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r40-feta40i.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r40-oka40i-c.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-r40.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-reference-design-tablet.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-s3-elimo-impetus.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-s3-elimo-initium.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-s3-lichee-zero-plus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-s3-pinecube.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-t3-cqa3t-bv3.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-v3-sl631-imx179.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-v3-sl631.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-v3.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-v3s-licheepi-zero-dock.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-v3s-licheepi-zero.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-v3s.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun8i-v40-bananapi-m2-berry.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun9i-a80-cubieboard4.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun9i-a80-optimus.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sun9i-a80.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/suniv-f1c100s-licheepi-nano.dts (100%)
 rename arch/arm/boot/dts/{ => allwinner}/suniv-f1c100s.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-bananapi-m2-plus-v1.2.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-bananapi-m2-plus.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-common-regulators.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-h3-h5-emlid-neutis.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-h3-h5.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-itead-core-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-libretech-all-h3-cc.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-libretech-all-h3-it.dtsi (100%)
 rename arch/arm/boot/dts/{ => allwinner}/sunxi-reference-design-tablet.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/alphascale/Makefile
 rename arch/arm/boot/dts/{ => alphascale}/alphascale-asm9260-devkit.dts (100%)
 rename arch/arm/boot/dts/{ => alphascale}/alphascale-asm9260.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/amlogic/Makefile
 rename arch/arm/boot/dts/{ => amlogic}/meson.dtsi (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson6-atv1200.dts (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson6.dtsi (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8-minix-neo-x8.dts (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8.dtsi (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8b-ec100.dts (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8b-mxq.dts (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8b-odroidc1.dts (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8b.dtsi (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8m2-mxiii-plus.dts (100%)
 rename arch/arm/boot/dts/{ => amlogic}/meson8m2.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/annapurna/Makefile
 rename arch/arm/boot/dts/{ => annapurna}/alpine-db.dts (100%)
 rename arch/arm/boot/dts/{ => annapurna}/alpine.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/arm/Makefile
 create mode 120000 arch/arm/boot/dts/arm/armv7-m.dtsi
 rename arch/arm/boot/dts/{ => arm}/integrator.dtsi (100%)
 rename arch/arm/boot/dts/{ => arm}/integratorap-im-pd1.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/integratorap.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/integratorcp.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/mps2-an385.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/mps2-an399.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/mps2.dtsi (100%)
 rename arch/arm/boot/dts/{ => arm}/versatile-ab-ib2.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/versatile-ab.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/versatile-pb.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/vexpress-v2m-rs1.dtsi (100%)
 rename arch/arm/boot/dts/{ => arm}/vexpress-v2m.dtsi (100%)
 rename arch/arm/boot/dts/{ => arm}/vexpress-v2p-ca15-tc1.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/vexpress-v2p-ca15_a7.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/vexpress-v2p-ca5s.dts (100%)
 rename arch/arm/boot/dts/{ => arm}/vexpress-v2p-ca9.dts (100%)
 create mode 100644 arch/arm/boot/dts/aspeed/Makefile
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-ast2500-evb.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-ast2600-evb-a1.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-ast2600-evb.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-amd-ethanolx.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-ampere-mtjade.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-arm-centriq2400-rep.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-arm-stardragon4800-rep2.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-asrock-e3c246d4i.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-asrock-romed8hm3.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-bytedance-g220a.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-bletchley.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-cloudripper.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-cmm.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-elbert.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-fuji.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-galaxy100.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-minipack.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-tiogapass.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-wedge100.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-wedge40.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-wedge400.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-yamp.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-facebook-yosemitev2.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-ibm-everest.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-ibm-rainier-1s4u.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-ibm-rainier-4u.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-ibm-rainier.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-inspur-fp5280g2.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-inspur-nf5280m6.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-inspur-on5263m5.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-intel-s2600wf.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-inventec-transformers.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-lenovo-hr630.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-lenovo-hr855xg2.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-microsoft-olympus.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-lanyang.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-mihawk.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-mowgli.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-nicole.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-palmetto.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-romulus.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-swift.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-tacoma.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-vesnin.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-witherspoon.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-opp-zaius.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-portwell-neptune.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-quanta-q71l.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-quanta-s6q.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-supermicro-x11spi.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-tyan-s7106.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-tyan-s8036.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-vegman-n110.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-vegman-rx20.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-vegman-sx20.dts (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-bmc-vegman.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-g4.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-g5.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-g6-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/aspeed-g6.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/ast2400-facebook-netbmc-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/ast2500-facebook-netbmc-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/ast2600-facebook-netbmc-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/facebook-bmc-flash-layout-128.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/facebook-bmc-flash-layout.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/ibm-power9-dual.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/openbmc-flash-layout-128.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/openbmc-flash-layout-64-alt.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/openbmc-flash-layout-64.dtsi (100%)
 rename arch/arm/boot/dts/{ => aspeed}/openbmc-flash-layout.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/axix/Makefile
 rename arch/arm/boot/dts/{ => axix}/artpec6-devboard.dts (100%)
 rename arch/arm/boot/dts/{ => axix}/artpec6.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/axxia/Makefile
 rename arch/arm/boot/dts/{ => axxia}/axm5516-amarillo.dts (100%)
 rename arch/arm/boot/dts/{ => axxia}/axm5516-cpus.dtsi (100%)
 rename arch/arm/boot/dts/{ => axxia}/axm55xx.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/broadcom/Makefile
 rename arch/arm/boot/dts/{ => broadcom}/bcm-cygnus-clock.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm-cygnus.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm-hr2.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm-nsp-ax.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm-nsp.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm11351.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm21664-garnet.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm21664.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm23550-sparrow.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm23550.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2711-rpi-4-b.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2711-rpi-400.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2711-rpi-cm4-io.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2711-rpi-cm4.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2711-rpi.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2711.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm28155-ap.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-a-plus.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-a.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-b-plus.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-b-rev2.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-b.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-cm1-io1.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-cm1.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-zero-w.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi-zero.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835-rpi.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2835.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2836-rpi-2-b.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2836-rpi.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2836.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2837-rpi-3-a-plus.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2837-rpi-3-b-plus.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2837-rpi-3-b.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2837-rpi-cm3-io3.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2837-rpi-cm3.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2837-rpi-zero-2-w.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm2837.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x-rpi-lan7515.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x-rpi-smsc9512.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x-rpi-smsc9514.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x-rpi-usb-host.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x-rpi-usb-otg.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x-rpi-usb-peripheral.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x-rpi-wifi-bt.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm283x.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-asus-rt-ac56u.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-asus-rt-ac68u.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-buffalo-wzr-1750dhp.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-linksys-ea6300-v1.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-linksys-ea6500-v2.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-luxul-xap-1510.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-luxul-xwc-1000.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-netgear-r6250.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-netgear-r6300-v2.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708-smartrg-sr400ac.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4708.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47081-asus-rt-n18u.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47081-buffalo-wzr-600dhp2.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47081-buffalo-wzr-900dhp.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47081-luxul-xap-1410.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47081-luxul-xwr-1200.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47081-tplink-archer-c5-v2.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47081.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4709-asus-rt-ac87u.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4709-buffalo-wxr-1900dhp.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4709-linksys-ea9200.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4709-netgear-r7000.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4709-netgear-r8000.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4709-tplink-archer-c9-v1.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm4709.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-asus-rt-ac88u.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-dlink-dir-885l.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-linksys-panamera.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-luxul-abr-4500.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-luxul-xap-1610.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-luxul-xbr-4500.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-luxul-xwc-2000.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-luxul-xwr-3100.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-luxul-xwr-3150-v1.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-netgear-r8500.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094-phicomm-k3.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47094.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47189-luxul-xap-1440.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47189-luxul-xap-810.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm47189-tenda-ac9.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm53016-meraki-mr32.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm5301x-nand-cs0-bch1.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm5301x-nand-cs0-bch4.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm5301x-nand-cs0-bch8.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm5301x-nand-cs0.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm5301x.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm53340-ubnt-unifi-switch8.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm53573.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm59056.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm63138.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm7445-bcm97445svmb.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm7445.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm911360_entphn.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm911360k.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm94708.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm94709.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm947189acdbmr.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm953012er.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm953012hr.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm953012k.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958300k.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958305k.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958522er.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958525er.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958525xmc.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958622hr.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958623hr.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-alamo.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-kingpin.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-mx64-a0.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-mx64.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-mx64w-a0.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-mx64w.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-mx65.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-mx65w.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625-meraki-mx6x-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625hr.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm958625k.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm963138dvt.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm988312hr.dts (100%)
 rename arch/arm/boot/dts/{ => broadcom}/bcm9hmidc.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/cirrus/Makefile
 rename arch/arm/boot/dts/{ => cirrus}/ep7209.dtsi (100%)
 rename arch/arm/boot/dts/{ => cirrus}/ep7211-edb7211.dts (100%)
 rename arch/arm/boot/dts/{ => cirrus}/ep7211.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/conexant/Makefile
 rename arch/arm/boot/dts/{ => conexant}/cx92755.dtsi (100%)
 rename arch/arm/boot/dts/{ => conexant}/cx92755_equinox.dts (100%)
 create mode 100644 arch/arm/boot/dts/cortina/Makefile
 rename arch/arm/boot/dts/{ => cortina}/gemini-dlink-dir-685.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-dlink-dns-313.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-nas4220b.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-ns2502.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-rut1xx.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-sl93512r.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-sq201.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-ssi1328.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-wbd111.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini-wbd222.dts (100%)
 rename arch/arm/boot/dts/{ => cortina}/gemini.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/dove/Makefile
 rename arch/arm/boot/dts/{ => dove}/dove-cm-a510.dtsi (100%)
 rename arch/arm/boot/dts/{ => dove}/dove-cubox-es.dts (100%)
 rename arch/arm/boot/dts/{ => dove}/dove-cubox.dts (100%)
 rename arch/arm/boot/dts/{ => dove}/dove-d2plug.dts (100%)
 rename arch/arm/boot/dts/{ => dove}/dove-d3plug.dts (100%)
 rename arch/arm/boot/dts/{ => dove}/dove-dove-db.dts (100%)
 rename arch/arm/boot/dts/{ => dove}/dove-sbc-a510.dts (100%)
 rename arch/arm/boot/dts/{ => dove}/dove.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/edac/Makefile
 rename arch/arm/boot/dts/{ => edac}/ecx-2000.dts (100%)
 rename arch/arm/boot/dts/{ => edac}/ecx-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => edac}/highbank.dts (100%)
 create mode 100644 arch/arm/boot/dts/exynos/Makefile
 rename arch/arm/boot/dts/{ => exynos}/cros-adc-thermistors.dtsi (100%)
 create mode 120000 arch/arm/boot/dts/exynos/cros-ec-keyboard.dtsi
 rename arch/arm/boot/dts/{ => exynos}/exynos-mfc-reserved-memory.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos-syscon-restart.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos3250-artik5-eval.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos3250-artik5.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos3250-monk.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos3250-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos3250-rinato.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos3250.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4-cpu-thermal.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4210-i9100.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4210-origen.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4210-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4210-smdkv310.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4210-trats.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4210-universal_c210.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4210.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-galaxy-s3.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-i9300.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-i9305.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-itop-elite.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-itop-scp-core.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-midas.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-n710x.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-odroid-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-odroidu3.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-odroidx.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-odroidx2.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-origen.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-p4note-n8010.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-p4note.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-ppmu-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-prime.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-smdk4412.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-tiny4412.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412-trats2.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos4412.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250-arndale.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250-smdk5250.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250-snow-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250-snow-rev5.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250-snow.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250-spring.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5250.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5260-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5260-xyref5260.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5260.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5410-odroidxu.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5410-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5410-smdk5410.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5410.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-arndale-octa.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-chagall-wifi.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-cpus.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-galaxy-tab-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-klimt-wifi.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-peach-pit.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-smdk5420.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420-trip-points.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5420.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-cpus.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-odroid-core.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-odroidhc1.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-odroidxu3-audio.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-odroidxu3-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-odroidxu3-lite.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-odroidxu3.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5422-odroidxu4.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos54xx-odroidxu-leds.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos54xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5800-peach-pi.dts (100%)
 rename arch/arm/boot/dts/{ => exynos}/exynos5800.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/freescale/Makefile
 rename arch/arm/boot/dts/{ => freescale}/e60k02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/e70k02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx1-ads.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx1-apf9328.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx1-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx1.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx23-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx23-olinuxino.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx23-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx23-sansa.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx23-stmp378x_devb.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx23-xfi3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx23.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-eukrea-cpuimx25.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-eukrea-mbimxsd25-baseboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-karo-tx25.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-pdk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx25.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-apf27.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-apf27dev.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-eukrea-cpuimx27.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-eukrea-mbimxsd27-baseboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-pdk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-phytec-phycard-s-rdk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-phytec-phycard-s-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-phytec-phycore-rdk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-phytec-phycore-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx27.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-apf28.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-apf28dev.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-apx4devkit.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-cfa10036.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-cfa10037.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-cfa10049.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-cfa10055.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-cfa10056.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-cfa10057.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-cfa10058.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-duckbill-2-485.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-duckbill-2-enocean.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-duckbill-2-spi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-duckbill-2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-duckbill.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-eukrea-mbmx283lc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-eukrea-mbmx287lc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-eukrea-mbmx28lc.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-lwe.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-m28.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-m28cu3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-m28evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-sps1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-ts4600.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-tx28.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28-xea.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx28.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx31-bug.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx31-lite.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx31.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx35-eukrea-cpuimx35.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx35-eukrea-mbimxsd35-baseboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx35-pdk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx35-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx35.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx50-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx50-kobo-aura.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx50-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx50.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-apf51.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-apf51dev.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-babbage.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-digi-connectcore-jsk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-digi-connectcore-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-eukrea-cpuimx51.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-eukrea-mbimxsd51-baseboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-ts4800.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-zii-rdu1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-zii-scu2-mezz.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51-zii-scu3-esb.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx51.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-ard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-cx9020.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-kp-ddc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-kp-hsc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-kp.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-m53.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-m53evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-m53menlo.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-mba53.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-ppd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-qsb-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-qsb.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-qsrb.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-smd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-tqma53.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-tx53-x03x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-tx53-x13x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-tx53.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-usbarmory.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-voipac-bsb.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53-voipac-dmm-668.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx53.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6-logicpd-baseboard.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6-logicpd-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-alti6p.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-apf6dev.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-aristainetos2_4.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-aristainetos2_7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-aristainetos_4.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-aristainetos_7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-b105pv2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-b105v2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-b125pv2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-b125v2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-b155v2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-b1x5pv2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-b1x5v2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-colibri-v1_1-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-cubox-i-emmc-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-cubox-i-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-cubox-i.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-dfi-fs700-m60.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-dhcom-picoitx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-eckelmann-ci4x10.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-emcon-avari.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw51xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw52xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw53xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw54xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw551x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw552x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw553x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw560x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw5903.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw5904.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw5907.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw5910.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw5912.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-gw5913.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-hummingboard-emmc-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-hummingboard-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-hummingboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-hummingboard2-emmc-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-hummingboard2-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-hummingboard2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-icore-mipi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-icore-rqs.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-icore.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-kontron-samx6i.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-lanmcu.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-mamoj.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-mba6.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-mba6a.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-mba6b.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-nit6xlite.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-nitrogen6x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-phytec-mira-rdk-nand.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-phytec-pbab01.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-phytec-pfla02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-pico-dwarf.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-pico-hobbit.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-pico-nymph.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-pico-pi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-plybas.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-plym2m.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-prtmvt.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-prtrvt.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-prtvt7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-qmx6.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-rex-basic.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-riotboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-sabreauto.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-sabrelite.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-sabresd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-savageboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-skov-revc-lt2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-skov-revc-lt6.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-solidsense.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tqma6a.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tqma6b.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-ts4900.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-ts7970.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6dl-comtft.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6s-8034-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6s-8034.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6s-8035-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6s-8035.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6u-801x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6u-8033-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6u-8033.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6u-80xx-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6u-811x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-tx6u-81xx-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-udoo.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-victgo.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-vicut1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-wandboard-revb1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-wandboard-revd1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-wandboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-yapp4-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-yapp4-draco.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-yapp4-hydra.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-yapp4-orion.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl-yapp4-ursa.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6dl.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-apalis-eval.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-apalis-ixora-v1.1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-apalis-ixora.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-apf6dev.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-arm2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-b450v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-b650v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-b850v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-ba16.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-bx50v3.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-cm-fx6.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-cubox-i-emmc-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-cubox-i-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-cubox-i.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-dfi-fs700-m60.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-dhcom-pdk2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-display5-tianma-tm070-1280x768.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-display5.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-dmo-edmqmx6.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-dms-ba16.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-ds.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-emcon-avari.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-evi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gk802.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw51xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw52xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw53xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw5400-a.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw54xx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw551x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw552x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw553x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw560x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw5903.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw5904.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw5907.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw5910.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw5912.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-gw5913.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-h100.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-hummingboard-emmc-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-hummingboard-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-hummingboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-hummingboard2-emmc-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-hummingboard2-som-v15.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-hummingboard2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-icore-mipi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-icore-ofcap10.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-icore-ofcap12.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-icore-rqs.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-icore.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-kontron-samx6i.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-kp-tpc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-kp.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-logicpd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-marsboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-mba6.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-mba6a.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-mba6b.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-mccmon6.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-nitrogen6_max.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-nitrogen6_som2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-nitrogen6x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-novena.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-phytec-mira-rdk-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-phytec-mira-rdk-nand.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-phytec-pbab01.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-phytec-pfla02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-pico-dwarf.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-pico-hobbit.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-pico-nymph.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-pico-pi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-pistachio.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-prti6q.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-prtwd2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-rex-pro.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-sabreauto.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-sabrelite.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-sabresd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-savageboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-sbc6x.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-skov-revc-lt2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-skov-revc-lt6.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-skov-reve-mi1010ait-1cp1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-solidsense.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tbs2910.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tqma6a.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tqma6b.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-ts4900.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-ts7970.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-1010-comtft.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-1010.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-1020-comtft.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-1020.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-1036-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-1036.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-10x0-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-1110.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-tx6q-11x0-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-udoo.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-utilite-pro.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-var-dt6customboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-vicut1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-wandboard-revb1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-wandboard-revd1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-wandboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-yapp4-crux.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q-zii-rdu2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6q.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-apalis.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-apf6.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-apf6dev.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-aristainetos.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-aristainetos2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-colibri-v1_1-uhs.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-cubox-i.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-dfi-fs700-m60.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-dhcom-drc02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-dhcom-pdk2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-dhcom-picoitx.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-dhcom-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-ds.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-emcon-avari.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-emcon.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw51xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw52xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw53xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw54xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw551x.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw552x.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw553x.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw560x.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw5903.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw5904.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw5907.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw5910.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw5912.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-gw5913.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-hummingboard.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-hummingboard2-emmc.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-hummingboard2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-icore-1.5.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-icore-rqs.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-icore.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-kontron-samx6i.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-mba6.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-mba6a.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-mba6b.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-nit6xlite.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-nitrogen6_max.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-nitrogen6_som2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-nitrogen6x.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-phytec-mira-peb-av-02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-phytec-mira-peb-eval-01.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-phytec-mira-peb-wlbt-05.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-phytec-mira.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-phytec-pbab01.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-phytec-pfla02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-phytec-phycore-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-pico-dwarf.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-pico-hobbit.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-pico-nymph.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-pico-pi.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-pico.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-prti6q.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-rex.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-sabreauto.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-sabrelite.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-sabresd.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-savageboard.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-skov-cpu-revc.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-skov-cpu.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-skov-revc-lt2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-solidsense.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-sr-som-brcm.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-sr-som-emmc.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-sr-som-ti.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-sr-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-tqma6.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-tqma6a.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-tqma6b.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-ts4900.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-ts7970.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-tx6-lcd.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-tx6-lvds.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-tx6-mb7.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-tx6.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-udoo.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-var-dart.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-vicut1.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-wandboard-revb1.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-wandboard-revc1.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-wandboard-revd1.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-wandboard.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl-zii-rdu2.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qdl.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-mba6b.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-nitrogen6_max.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-nitrogen6_som2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-phytec-mira-rdk-nand.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-prtwd3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-sabreauto.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-sabresd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-tqma6b.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-tx6qp-8037-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-tx6qp-8037.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-tx6qp-8137-mb7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-tx6qp-8137.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-vicutp.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-wandboard-revd1.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-yapp4-crux-plus.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp-zii-rdu2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6qp.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6s-dhcom-drc02.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sl-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sl-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sl-tolino-shine2hd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sl-tolino-shine3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sl-tolino-vision5.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sl-warp.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sl.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sll-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sll-kobo-clarahd.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sll-kobo-librah2o.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sll-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sll.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-nitrogen6sx.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-sabreauto.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-sdb-mqs.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-sdb-reva.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-sdb-sai.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-sdb.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-sdb.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-softing-vining-2000.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-udoo-neo-basic.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-udoo-neo-extended.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-udoo-neo-full.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx-udoo-neo.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6sx.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-14x14-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-14x14-evk.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-ccimx6ulsbcexpress.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-ccimx6ulsbcpro.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-ccimx6ulsom.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-geam.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-imx6ull-opos6ul.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-imx6ull-opos6uldev.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-isiot-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-isiot-nand.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-isiot.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-kontron-n6310-s-43.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-kontron-n6310-s.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-kontron-n6310-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-kontron-n6311-s.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-kontron-n6311-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-kontron-n6x1x-s.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-kontron-n6x1x-som-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-liteboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-litesom.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-opos6ul.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-opos6uldev.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-phytec-phycore-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-phytec-segin-ff-rdk-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-phytec-segin-ff-rdk-nand.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-phytec-segin-peb-av-02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-phytec-segin-peb-eval-01.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-phytec-segin-peb-wlbt-05.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-phytec-segin.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-pico-dwarf.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-pico-hobbit.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-pico-pi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-pico.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-prti6g.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-tx6ul-0010.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-tx6ul-0011.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-tx6ul-mainboard.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul-tx6ul.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ul.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-14x14-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri-emmc-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri-emmc-nonwifi.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri-eval-v3.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri-nonwifi.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri-wifi-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri-wifi.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-jozacp.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-kontron-n6411-s.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-kontron-n6411-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-myir-mys-6ulx-eval.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-myir-mys-6ulx.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-opos6ul.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-opos6uldev.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-phycore-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-segin-ff-rdk-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-segin-ff-rdk-nand.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-segin-lc-rdk-nand.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-segin-peb-av-02.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-segin-peb-eval-01.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-segin-peb-wlbt-05.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-phytec-segin.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-pinfunc-snvs.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ull.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ulz-14x14-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ulz-bsh-smm-m2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx6ulz.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7-colibri-aster.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7-colibri-eval-v3.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7-mba7.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7-tqma7.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-cl-som-imx7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-colibri-aster.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-colibri-emmc-aster.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-colibri-emmc-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-colibri-emmc.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-flex-concentrator-mfg.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-flex-concentrator.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-mba7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-meerkat96.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-nitrogen7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-pico-dwarf.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-pico-hobbit.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-pico-nymph.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-pico-pi.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-pico.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-remarkable2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-sbc-imx7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-sdb-reva.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-sdb-sht11.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-sdb.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-tqma7.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-zii-rmu2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d-zii-rpu2.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7d.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7s-colibri-aster.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7s-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7s-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7s-mba7.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7s-tqma7.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7s-warp.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7s.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7ulp-com.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7ulp-evk.dts (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7ulp-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/imx7ulp.dtsi (100%)
 rename arch/arm/boot/dts/{ => freescale}/imxrt1050-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => freescale}/mxs-pinfunc.h (100%)
 create mode 100644 arch/arm/boot/dts/hisilicon/Makefile
 rename arch/arm/boot/dts/{ => hisilicon}/hi3519-demb.dts (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hi3519.dtsi (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hi3620-hi4511.dts (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hi3620.dtsi (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hip01-ca9x2.dts (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hip01.dtsi (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hip04-d01.dts (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hip04.dtsi (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hisi-x5hd2-dkb.dts (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/hisi-x5hd2.dtsi (100%)
 rename arch/arm/boot/dts/{ => hisilicon}/sd5203.dts (100%)
 create mode 100644 arch/arm/boot/dts/intel/Makefile
 rename arch/arm/boot/dts/{ => intel}/socfpga.dtsi (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria10.dtsi (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria10_mercury_aa1.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria10_socdk.dtsi (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria10_socdk_nand.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria10_socdk_qspi.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria10_socdk_sdmmc.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria5.dtsi (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_arria5_socdk.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5.dtsi (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_chameleon96.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_de0_nano_soc.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_mcv.dtsi (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_mcvevk.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_socdk.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_sockit.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_socrates.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_sodia.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_cyclone5_vining_fpga.dts (100%)
 rename arch/arm/boot/dts/{ => intel}/socfpga_vt.dts (100%)
 create mode 100644 arch/arm/boot/dts/kirkwood/Makefile
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-6192.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-6281.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-6282.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-98dx4122.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-b3.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-blackarmor-nas220.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-c200-v1.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-cloudbox.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-d2net.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-db-88f6281.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-db-88f6282.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-db.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-dir665.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-dns320.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-dns325.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-dnskw.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-dockstar.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-dreamplug.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds109.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds110jv10.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds111.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds112.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds209.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds210.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds212.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds212j.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds409.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds409slim.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds411.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds411j.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ds411slim.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-goflexnet.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-guruplug-server-plus.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ib62x0.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-iconnect.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-iomega_ix2_200.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-is2.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-km_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-km_fixedeth.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-km_kirkwood.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-l-50.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-laplug.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation-6282.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation-duo-6281.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation-lsqvl.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation-lsvl.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation-lswsxl.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation-lswvl.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation-lswxl.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linkstation.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-linksys-viper.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-lschlv2.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-lsxhl.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-lsxl.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-mplcec4.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-mv88f6281gtw-ge.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-nas2big.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-net2big.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-net5big.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-netgear_readynas_duo_v2.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-netgear_readynas_nv+_v2.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-netxbig.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ns2-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ns2.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ns2lite.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ns2max.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ns2mini.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-nsa310.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-nsa310a.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-nsa320.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-nsa325.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-nsa3x0-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-openblocks_a6.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-openblocks_a7.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-openrd-base.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-openrd-client.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-openrd-ultimate.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-openrd.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-pogo_e02.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-pogoplug-series-4.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-rd88f6192.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-rd88f6281-a.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-rd88f6281-z0.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-rd88f6281.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-rs212.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-rs409.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-rs411.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-sheevaplug-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-sheevaplug-esata.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-sheevaplug.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-synology.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-t5325.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-topkick.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ts219-6281.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ts219-6282.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ts219.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ts419-6281.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ts419-6282.dts (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood-ts419.dtsi (100%)
 rename arch/arm/boot/dts/{ => kirkwood}/kirkwood.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/layerscape/Makefile
 rename arch/arm/boot/dts/{ => layerscape}/ls1021a-moxa-uc-8410a.dts (100%)
 rename arch/arm/boot/dts/{ => layerscape}/ls1021a-qds.dts (100%)
 rename arch/arm/boot/dts/{ => layerscape}/ls1021a-tsn.dts (100%)
 rename arch/arm/boot/dts/{ => layerscape}/ls1021a-twr.dts (100%)
 rename arch/arm/boot/dts/{ => layerscape}/ls1021a.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/marvell/Makefile
 rename arch/arm/boot/dts/{ => marvell}/armada-370-c200-v2.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-db.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-dlink-dns327l.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-mirabox.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-netgear-rn102.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-netgear-rn104.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-rd.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-seagate-nas-2bay.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-seagate-nas-4bay.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-seagate-nas-xbay.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-seagate-personal-cloud-2bay.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-seagate-personal-cloud.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-seagate-personal-cloud.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-synology-ds213j.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370-xp.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-370.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-375-db.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-375.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-380.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-381-netgear-gs110emx.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-382-rd-ac3x-48g4x2xl.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-atl-x530.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-clearfog-gtr-l8.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-clearfog-gtr-s4.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-clearfog-gtr.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-db-88f6820-amc.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-db-ap.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-linksys-caiman.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-linksys-cobra.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-linksys-rango.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-linksys-shelby.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-linksys.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-synology-ds116.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385-turris-omnia.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-385.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-clearfog-base.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-clearfog-pro.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-clearfog.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-clearfog.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-db.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-gp.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-helios4.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388-rd.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-388.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-38x-solidrun-microsom.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-38x.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-390-db.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-390.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-395-gp.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-395.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-398-db.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-398.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-39x.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-98dx3236.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-98dx3336.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-98dx4251.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-axpwifiap.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs305-1g-4s-bit.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs305-1g-4s.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs305-1g-4s.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs326-24g-2s-bit.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs326-24g-2s.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs326-24g-2s.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs328-4c-20s-4s-bit.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs328-4c-20s-4s.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-crs328-4c-20s-4s.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-db-dxbc2.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-db-xc3-24g4xg.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-db.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-gp.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-lenovo-ix4-300d.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-linksys-mamba.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-matrix.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-mv78230.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-mv78260.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-mv78460.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-netgear-rn2120.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-openblocks-ax3-4.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp-synology-ds414.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/armada-xp.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/berlin2-sony-nsz-gs7.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/berlin2.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/berlin2cd-google-chromecast.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/berlin2cd-valve-steamlink.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/berlin2cd.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/berlin2q-marvell-dmp.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/berlin2q.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/mmp2-brownstone.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/mmp2-olpc-xo-1-75.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/mmp2.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/mmp3-dell-ariel.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/mmp3.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/mvebu-linkstation-fan.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/mvebu-linkstation-gpio-simple.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-kuroboxpro.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-lacie-d2-network.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-lacie-ethernet-disk-mini-v2.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-linkstation-lschl.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-linkstation-lsgl.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-linkstation-lswtgl.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-linkstation.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-lswsgl.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-maxtor-shared-storage-2.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-mv88f5181.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-mv88f5182.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-netgear-wnr854t.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x-rd88f5182-nas.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/orion5x.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa168-aspenite.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa168.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa25x.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa27x.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa2xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-connector.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-controller.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-speaker-l.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-speaker-m.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-speaker-one.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-speaker-s.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa300-raumfeld-tuneable-clock.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa3xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa910-dkb.dts (100%)
 rename arch/arm/boot/dts/{ => marvell}/pxa910.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/mediatek/Makefile
 rename arch/arm/boot/dts/{ => mediatek}/mt2701-evb.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt2701-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt2701.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6323.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6580-evbp1.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6580.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6582-prestigio-pmt5008-3g.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6582.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6589-aquaris5.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6589-fairphone-fp1.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6589.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6592-evb.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt6592.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7623.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7623a-rfb-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7623a-rfb-nand.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7623a.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7623n-bananapi-bpi-r2.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7623n-rfb-emmc.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7623n.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7629-rfb.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt7629.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt8127-moose.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt8127.dtsi (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt8135-evbp1.dts (100%)
 rename arch/arm/boot/dts/{ => mediatek}/mt8135.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/microchip/Makefile
 rename arch/arm/boot/dts/{ => microchip}/aks-cdu.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/animeo_ip.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-ariag25.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-ariettag25.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-cosino.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-cosino_mega2560.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-dvk_som60.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-dvk_su60_somc.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-dvk_su60_somc_lcm.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-foxg20.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-gatwick.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizbox.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizbox2-2.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizbox2-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizbox3-hs.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizbox3_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizboxmini-base.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizboxmini-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizboxmini-mb.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-kizboxmini-rd.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-linea.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-lmu5000.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-natte.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-nattis-2-natte-2.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-q5xr5.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-qil_a9260.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sam9_l9260.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sam9x60ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d27_som1.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d27_som1_ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d27_wlsom1.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d27_wlsom1_ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d2_icp.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d2_ptc_ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d2_xplained.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d3_ksz9477_evb.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d3_xplained.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d4_ma5d4.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d4_ma5d4evk.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d4_xplained.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama5d4ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-sama7g5ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-smartkiz.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-som60.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-tse850-3.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-vinco.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-wb45n.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-wb45n.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-wb50n.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91-wb50n.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91rm9200.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91rm9200_pqfp.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91rm9200ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9260.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9260ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9261.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9261ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9263.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9263ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g15.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g15ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g20.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g20ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g20ek_2mmc.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g20ek_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g25-gardena-smart-gateway.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g25.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g25ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g35.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g35ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9g45.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9m10g45ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9n12.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9n12ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9rl.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9rlek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x25.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x25ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x35.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x35ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5_can.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5_isi.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5_lcd.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5_macb0.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5_macb1.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5_usart3.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5cm.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5dm.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9x5ek.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/at91sam9xe.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/ethernut5.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/evk-pro3.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/ge863-pro3.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/lan966x-pcb8291.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/lan966x.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/mpa1600.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/pm9g45.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/sam9x60.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d2-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d2.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d29.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d31.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d31ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d33.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d33ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d34.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d34ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d35.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d35ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d36.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d36ek.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d36ek_cmp.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3_can.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3_emac.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3_gmac.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3_lcd.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3_mci2.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3_tcb1.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3_uart.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3xcm.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3xcm_cmp.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3xdm.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3xmb.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3xmb_cmp.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3xmb_emac.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d3xmb_gmac.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama5d4.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama7g5-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => microchip}/sama7g5.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/tny_a9260.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/tny_a9260_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/tny_a9263.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/tny_a9g20.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/usb_a9260.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/usb_a9260_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/usb_a9263.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/usb_a9g20-dab-mmx.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/usb_a9g20.dts (100%)
 rename arch/arm/boot/dts/{ => microchip}/usb_a9g20_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => microchip}/usb_a9g20_lpw.dts (100%)
 create mode 100644 arch/arm/boot/dts/moxart/Makefile
 rename arch/arm/boot/dts/{ => moxart}/moxart-uc7112lx.dts (100%)
 rename arch/arm/boot/dts/{ => moxart}/moxart.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/mstart/Makefile
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity-breadbee-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity-msc313-breadbee_crust.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity-msc313.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd201-som2d01.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd202d-100ask-dongshanpione.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd202d-miyoo-mini.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd202d-ssd201htv2.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd202d-unitv2.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd202d.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m-ssd20xd.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity2m.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity3-msc313e-breadbee.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity3-msc313e.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-infinity3.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-mercury5-ssc8336n-midrived08.dts (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-mercury5-ssc8336n.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-mercury5.dtsi (100%)
 rename arch/arm/boot/dts/{ => mstart}/mstar-v7.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/nuvoton/Makefile
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-common-npcm7xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm730-gbs.dts (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm730-gsj-gpio.dtsi (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm730-gsj.dts (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm730-kudo.dts (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm730.dtsi (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm750-evb.dts (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm750-pincfg-evb.dtsi (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm750-runbmc-olympus-pincfg.dtsi (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm750-runbmc-olympus.dts (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-npcm750.dtsi (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts (100%)
 rename arch/arm/boot/dts/{ => nuvoton}/nuvoton-wpcm450.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/nvidia/Makefile
 create mode 120000 arch/arm/boot/dts/nvidia/cros-ec-keyboard.dtsi
 rename arch/arm/boot/dts/{ => nvidia}/tegra114-asus-tf701t.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra114-dalmore.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra114-roth.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra114-tn7.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra114.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-apalis-emc.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-apalis-eval.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-apalis-v1.2-eval.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-apalis-v1.2.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-apalis.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-jetson-tk1-emc.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-jetson-tk1.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-nyan-big-emc.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-nyan-big-fhd.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-nyan-big.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-nyan-blaze-emc.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-nyan-blaze.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-nyan.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-peripherals-opp.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124-venice2.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra124.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-acer-a500-picasso.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-asus-tf101.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-colibri-iris.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-cpu-opp-microvolt.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-cpu-opp.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-harmony.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-medcom-wide.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-paz00.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-peripherals-opp.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-plutux.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-seaboard.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-tamonten.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-tec.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-trimslice.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20-ventana.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra20.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-apalis-eval.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-apalis-v1.1-eval.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-apalis-v1.1.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-apalis.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-lvds-display.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-grouper-E1565.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-grouper-PM269.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-grouper-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-grouper-memory-timings.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-grouper-ti-pmic.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-grouper.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-tilapia-E1565.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-tilapia-memory-timings.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-nexus7-tilapia.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-tf201.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-tf300t.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-tf300tg.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-tf700t.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-asus-transformer-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-beaver.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-cardhu-a02.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-cardhu-a04.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-cardhu.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-cpu-opp-microvolt.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-cpu-opp.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-ouya.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-pegatron-chagall.dts (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30-peripherals-opp.dtsi (100%)
 rename arch/arm/boot/dts/{ => nvidia}/tegra30.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/nxp/Makefile
 create mode 120000 arch/arm/boot/dts/nxp/armv7-m.dtsi
 rename arch/arm/boot/dts/{ => nxp}/lpc18xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc3250-ea3250.dts (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc3250-phy3250.dts (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc32xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc4337-ciaa.dts (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc4350-hitex-eval.dts (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc4350.dtsi (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc4357-ea4357-devkit.dts (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc4357-myd-lpc4357.dts (100%)
 rename arch/arm/boot/dts/{ => nxp}/lpc4357.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/oxnas/Makefile
 rename arch/arm/boot/dts/{ => oxnas}/ox810se-wd-mbwe.dts (100%)
 rename arch/arm/boot/dts/{ => oxnas}/ox810se.dtsi (100%)
 rename arch/arm/boot/dts/{ => oxnas}/ox820-cloudengines-pogoplug-series-3.dts (100%)
 rename arch/arm/boot/dts/{ => oxnas}/ox820.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/qcom/Makefile
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8016-sbc.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8026-lg-lenok.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8060-dragonboard.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8064-asus-nexus7-flo.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8064-cm-qs600.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8064-ifc6410.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8064-pins.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8064-sony-xperia-yuga.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8064-v2.0.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8064.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8074-dragonboard.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8084-ifc6540.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8084-mtp.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-apq8084.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4018-ap120c-ac-bit.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4018-ap120c-ac.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4018-ap120c-ac.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4018-jalapeno.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk01.1-c1.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk01.1.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk04.1-c1.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk04.1-c3.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk04.1.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk07.1-c1.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk07.1-c2.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019-ap.dk07.1.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq4019.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq8064-ap148.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq8064-rb3011.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq8064-v1.0.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-ipq8064.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-mdm9615-wp8548-mangoh-green.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-mdm9615-wp8548.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-mdm9615.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8226-samsung-s3ve3g.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8226.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8660-surf.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8660.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8916-samsung-serranove.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8916-smp.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8960-cdp.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8960.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974-fairphone-fp2.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974-lge-nexus5-hammerhead.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974-samsung-klte.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974-sony-xperia-amami.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974-sony-xperia-castor.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974-sony-xperia-honami.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-msm8974pro.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-pm8226.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-pm8841.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-pm8941.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-pma8084.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-pmx55.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-sdx55-mtp.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-sdx55-t55.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-sdx55-telit-fn980-tlb.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-sdx55.dtsi (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-sdx65-mtp.dts (100%)
 rename arch/arm/boot/dts/{ => qcom}/qcom-sdx65.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/rda/Makefile
 rename arch/arm/boot/dts/{ => rda}/rda8810pl-orangepi-2g-iot.dts (100%)
 rename arch/arm/boot/dts/{ => rda}/rda8810pl-orangepi-i96.dts (100%)
 rename arch/arm/boot/dts/{ => rda}/rda8810pl.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/realtek/Makefile
 rename arch/arm/boot/dts/{ => realtek}/rtd1195-horseradish.dts (100%)
 rename arch/arm/boot/dts/{ => realtek}/rtd1195-mele-x1000.dts (100%)
 rename arch/arm/boot/dts/{ => realtek}/rtd1195.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/realview/Makefile
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-11mp-bbrevd-ctrevb.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-11mp-bbrevd.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-11mp-ctrevb.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-11mp.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-a9mp-bbrevd.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-a9mp.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-bbrevd.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-bbrevd.dtsi (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb-mp.dtsi (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-eb.dtsi (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-pb1176.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-pb11mp.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-pba8.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-pbx-a9.dts (100%)
 rename arch/arm/boot/dts/{ => realview}/arm-realview-pbx.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/renasas/Makefile
 rename arch/arm/boot/dts/{ => renasas}/emev2-kzm9d.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/emev2.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/gr-peach-audiocamerashield.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/iwg20d-q7-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/iwg20d-q7-dbcm-ca.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r7s72100-genmai.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r7s72100-gr-peach.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r7s72100-rskrza1.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r7s72100.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r7s9210-rza2mevb.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r7s9210.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a73a4-ape6evm.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a73a4.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7740-armadillo800eva.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7740.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7742-iwg21d-q7-dbcm-ca.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7742-iwg21d-q7-dbcm-ov7725-single.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7742-iwg21d-q7.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7742-iwg21m.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7742.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7743-iwg20d-q7-dbcm-ca.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7743-iwg20d-q7.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7743-iwg20m.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7743-sk-rzg1m.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7743.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7744-iwg20d-q7-dbcm-ca.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7744-iwg20d-q7.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7744-iwg20m.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7744.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7745-iwg22d-sodimm-dbhd-ca.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7745-iwg22d-sodimm.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7745-iwg22m.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7745-sk-rzg1e.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7745.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a77470-iwg23s-sbc.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a77470.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7778-bockw.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7778.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7779-marzen.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7779.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7790-lager.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7790-stout.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7790.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7791-koelsch.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7791-porter.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7791.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7792-blanche.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7792-wheat.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7792.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7793-gose.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7793.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7794-alt.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7794-silk.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a7794.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a77xx-aa104xd12-panel.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r8a77xx-aa121td01-panel.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/r9a06g032-rzn1d400-db.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/r9a06g032.dtsi (100%)
 rename arch/arm/boot/dts/{ => renasas}/sh73a0-kzm9g.dts (100%)
 rename arch/arm/boot/dts/{ => renasas}/sh73a0.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/rockchip/Makefile
 create mode 120000 arch/arm/boot/dts/rockchip/cros-ec-keyboard.dtsi
 rename arch/arm/boot/dts/{ => rockchip}/cros-ec-sbs.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3036-evb.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3036-kylin.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3036.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3066a-bqcurie2.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3066a-marsboard.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3066a-mk808.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3066a-rayeager.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3066a.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3188-bqedison2qc.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3188-px3-evb.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3188-radxarock.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3188.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3228-evb.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3229-evb.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3229-xms6.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3229.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk322x.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-evb-act8846.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-evb-rk808.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-evb.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-firefly-beta.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-firefly-reload-core.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-firefly-reload.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-firefly.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-firefly.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-miqi.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-phycore-rdk.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-phycore-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-popmetal.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-r89.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-rock-pi-n8.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-rock2-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-rock2-square.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-tinker-s.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-tinker.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-tinker.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-analog-audio.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-brain.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-broadcom-bluetooth.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-chromebook.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-edp.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-fievel.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-jaq.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-jerry.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-mickey.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-mighty.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-minnie.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-pinky.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-sdmmc.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-speedy.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron-tiger.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-veyron.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-vmarc-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288-vyasa.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3288.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rk3xxx.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rockchip-radxa-dalang-carrier.dtsi (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rv1108-elgin-r1.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rv1108-evb.dts (100%)
 rename arch/arm/boot/dts/{ => rockchip}/rv1108.dtsi (100%)
 create mode 120000 arch/arm/boot/dts/rockchip/tps65910.dtsi
 create mode 100644 arch/arm/boot/dts/samsung/Makefile
 rename arch/arm/boot/dts/{ => samsung}/s3c2416-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c2416-smdk2416.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c2416.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c24xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c6400.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c6410-mini6410.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c6410-smdk6410.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c6410.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c64xx-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s3c64xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-aquila.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-aries.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-fascinate4g.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-galaxys.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-goni.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-smdkc110.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-smdkv210.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210-torbreck.dts (100%)
 rename arch/arm/boot/dts/{ => samsung}/s5pv210.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/socionext/Makefile
 rename arch/arm/boot/dts/{ => socionext}/milbeaut-m10v-evb.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/milbeaut-m10v.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-ld4-ref.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-ld4.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-ld6b-ref.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-ld6b.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pro4-ace.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pro4-ref.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pro4-sanji.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pro4.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pro5.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pxs2-gentil.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pxs2-vodka.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-pxs2.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-ref-daughter.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-sld8-ref.dts (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-sld8.dtsi (100%)
 rename arch/arm/boot/dts/{ => socionext}/uniphier-support-card.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/st/Makefile
 rename arch/arm/boot/dts/{ => st}/spear1310-evb.dts (100%)
 rename arch/arm/boot/dts/{ => st}/spear1310.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear1340-evb.dts (100%)
 rename arch/arm/boot/dts/{ => st}/spear1340.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear13xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear300-evb.dts (100%)
 rename arch/arm/boot/dts/{ => st}/spear300.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear310-evb.dts (100%)
 rename arch/arm/boot/dts/{ => st}/spear310.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear320-evb.dts (100%)
 rename arch/arm/boot/dts/{ => st}/spear320-hmi.dts (100%)
 rename arch/arm/boot/dts/{ => st}/spear320.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear320s.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear3xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => st}/spear600-evb.dts (100%)
 rename arch/arm/boot/dts/{ => st}/spear600.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/st_ericsson/Makefile
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ab8500.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ab8505.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-db8500.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-db8520.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-db9500.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-dbx5x0-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-dbx5x0.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-ab8500.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-family-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-stuib.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-tvk1281618-r2.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-tvk1281618-r3.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-href.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-href520-tvk.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefprev60-stuib.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefprev60-tvk.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefprev60.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefv60plus-stuib.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefv60plus-tvk.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefv60plus.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-nhk15.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-s8815.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-stn8815.dtsi (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-snowball.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-codina.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-gavini.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-golden.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-janice.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-kyle.dts (100%)
 rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-skomer.dts (100%)
 create mode 100644 arch/arm/boot/dts/stm/Makefile
 create mode 120000 arch/arm/boot/dts/stm/armv7-m.dtsi
 rename arch/arm/boot/dts/{ => stm}/st-pincfg.h (100%)
 rename arch/arm/boot/dts/{ => stm}/stih407-b2120.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stih407-clock.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih407-family.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih407-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih407.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih410-b2120.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stih410-b2260.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stih410-clock.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih410-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih410.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih418-b2199.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stih418-b2264.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stih418-clock.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stih418.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stihxxx-b2120.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32429i-eval.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32746g-eval.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f4-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f429-disco.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f429-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f429.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f469-disco.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f469-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f469.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f7-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f746-disco.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f746-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f746.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f769-disco.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32f769-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32h7-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32h743.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32h743i-disco.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32h743i-eval.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32h750.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32h750i-art-pi.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp13-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp131.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp133.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp135.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp135f-dk.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp13xc.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp13xf.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp151.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp153.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp153c-dhcom-drc02.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-avenger96.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-dhcor-avenger96.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-dk1.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1-ctouch2.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1-edimm2.2.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-iot-box.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-microgea-stm32mp1-microdev2.0.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-microgea-stm32mp1.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-stinger96.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157a-stinger96.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-dhcom-pdk2.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-dhcom-picoitx.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-dk2.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-ed1.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-emsbc-argon.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-emstamp-argon.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-ev1.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-lxa-mc1.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-odyssey-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp157c-odyssey.dts (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xc.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-drc02.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-pdk2.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-picoitx.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcor-avenger96.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcor-io1v8.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcor-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dkx.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-osd32.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xxaa-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xxab-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xxac-pinctrl.dtsi (100%)
 rename arch/arm/boot/dts/{ => stm}/stm32mp15xxad-pinctrl.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/ti/Makefile
 rename arch/arm/boot/dts/{ => ti}/am335x-baltos-ir2110.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-baltos-ir3220.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-baltos-ir5221.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-baltos-leds.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-baltos.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-base0033.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-bone-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-bone.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-boneblack-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-boneblack-hdmi.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-boneblack-wireless.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-boneblack.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-boneblue.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-bonegreen-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-bonegreen-wireless.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-bonegreen.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-chiliboard.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-chilisom.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-cm-t335.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-evmsk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-guardian.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-icev2.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-igep0033.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-lxm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-moxa-uc-2100-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-moxa-uc-2101.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-moxa-uc-8100-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-moxa-uc-8100-me-t.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-myirtech-myc.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-myirtech-myd.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-nano.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-netcan-plus-1xx.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-netcom-plus-2xx.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-netcom-plus-8xx.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-osd3358-sm-red.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-osd335x-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-pcm-953.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-pdu001.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-pepper.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-phycore-rdk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-phycore-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-pocketbeagle.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-regor-rdk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-regor.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-sancloud-bbe-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-sancloud-bbe-extended-wifi.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-sancloud-bbe-lite.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-sancloud-bbe.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-sbc-t335.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-shc.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-sl50.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-wega-rdk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am335x-wega.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am33xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am33xx-l4.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am33xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am3517-craneboard.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am3517-evm-ui.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am3517-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am3517-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am3517.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am3517_mt_ventoux.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am35xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am3703.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am3715.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am3874-iceboard.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am4372.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am437x-cm-t43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am437x-gp-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am437x-idk-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am437x-l4.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am437x-sbc-t43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am437x-sk-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am43x-epos-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am43xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am57-pruss.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am5718.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am571x-idk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am5728.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am5729-beagleboneai.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am572x-idk-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am572x-idk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am5748.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am574x-idk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-beagle-x15-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-beagle-x15-revb1.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-beagle-x15-revc.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-beagle-x15.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-cl-som-am57x.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-commercial-grade.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-idk-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-industrial-grade.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/am57xx-sbc-am57x.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/compulab-sb-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/da850-enbw-cmc.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/da850-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/da850-lcdk.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/da850-lego-ev3.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/da850.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dm3725.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dm8148-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dm8148-t410.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dm814x-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dm814x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dm8168-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dm816x-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dm816x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra62x-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra62x-j5eco-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dra62x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7-dspeve-thermal.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7-evm-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7-ipu-dsp-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7-iva-thermal.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7-l4.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7-mmc-iodelay.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra71-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dra71x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra72-evm-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra72-evm-revc.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dra72-evm-tps65917.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra72-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dra72x-mmc-iodelay.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra72x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra74-ipu-dsp-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra74x-mmc-iodelay.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra74x-p.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra74x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra76-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/dra76x-mmc-iodelay.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra76x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/dra7xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/elpida_ecb240abacn.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2e-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2e-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2e-netcp.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2e.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2g-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2g-ice.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2g-netcp.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2g.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2hk-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2hk-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2hk-netcp.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2hk.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2l-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2l-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2l-netcp.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone-k2l.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/keystone.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-som-lv-35xx-devkit.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-som-lv-37xx-devkit.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-som-lv-baseboard.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-som-lv.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-torpedo-35xx-devkit.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-torpedo-37xx-devkit-28.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-torpedo-37xx-devkit.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-torpedo-baseboard.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/logicpd-torpedo-som.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/motorola-cpcap-mapphone.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/motorola-mapphone-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/nspire-classic.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/nspire-clp.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/nspire-cx.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/nspire-tp.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/nspire.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap-gpmc-smsc911x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap-gpmc-smsc9221.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap-zoom-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2420-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2420-h4.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2420-n800.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2420-n810-wimax.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2420-n810.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2420-n8x0-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2420.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2430-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2430-sdp.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap2430.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap24xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-beagle-ab4.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-beagle-xm-ab.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-beagle-xm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-beagle.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-cm-t3517.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-cm-t3530.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-cm-t3730.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-cm-t3x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-cm-t3x30.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-cpu-thermal.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-devkit8000-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-devkit8000-lcd-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-devkit8000-lcd43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-devkit8000-lcd70.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-devkit8000.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-echo.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-evm-37xx.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-evm-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-evm-processor-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-evm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-gta04.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-gta04a3.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-gta04a4.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-gta04a5.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-gta04a5one.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-ha-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-ha-lcd.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-ha.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-igep.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-igep0020-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-igep0020-rev-f.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-igep0020.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-igep0030-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-igep0030-rev-g.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-igep0030.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-ldp.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-lilly-a83x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-lilly-dbb056.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-n9.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-n900.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-n950-n9.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-n950.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-alto35-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-alto35.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-base.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-chestnut43-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-chestnut43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-common-dvi.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-common-lcd35.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-common-lcd43.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-common-peripherals.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-gallop43-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-gallop43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-palo35-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-palo35.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-palo43-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-palo43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-alto35.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-chestnut43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-gallop43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-palo35.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-palo43.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-summit.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-tobi.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm-tobiduo.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-storm.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-summit-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-summit.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-tobi-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-tobi.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-tobiduo-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo-tobiduo.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-overo.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-pandora-1ghz.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-pandora-600mhz.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-pandora-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-panel-sharp-ls037v7dw01.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-sb-t35.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-sbc-t3517.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-sbc-t3530.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-sbc-t3730.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-sniper.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-tao3530.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-thunder.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3-zoom3.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3430-sdp.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3430es1-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap34xx-omap36xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap34xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap36xx-am35xx-omap3430es2plus-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap36xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap36xx-omap3430es2plus-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap36xx.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap3xxx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-cpu-thermal.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-droid-bionic-xt875.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-droid4-xt894.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-duovero-parlor.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-duovero.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-kc1.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-l4-abe.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-l4.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-mcpdm.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-panda-a4.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-panda-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-panda-es.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-panda.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-sdp-es23plus.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-sdp.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-var-dvk-om44.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-var-om44customboard.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-var-som-om44-wlan.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-var-som-om44.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4-var-stk-om44.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap443x-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap443x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap4460.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap446x-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap44xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-board-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-cm-t54.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-core-thermal.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-gpu-thermal.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-igep0050.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-l4-abe.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-l4.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-sbc-t54.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5-uevm.dts (100%)
 rename arch/arm/boot/dts/{ => ti}/omap5.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/omap54xx-clocks.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/tps6507x.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/tps65217.dtsi (100%)
 create mode 120000 arch/arm/boot/dts/ti/tps65910.dtsi
 rename arch/arm/boot/dts/{ => ti}/twl4030.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/twl4030_omap3.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/twl6030.dtsi (100%)
 rename arch/arm/boot/dts/{ => ti}/twl6030_omap4.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/via/Makefile
 rename arch/arm/boot/dts/{ => via}/vt8500-bv07.dts (100%)
 rename arch/arm/boot/dts/{ => via}/vt8500.dtsi (100%)
 rename arch/arm/boot/dts/{ => via}/wm8505-ref.dts (100%)
 rename arch/arm/boot/dts/{ => via}/wm8505.dtsi (100%)
 rename arch/arm/boot/dts/{ => via}/wm8650-mid.dts (100%)
 rename arch/arm/boot/dts/{ => via}/wm8650.dtsi (100%)
 rename arch/arm/boot/dts/{ => via}/wm8750-apc8750.dts (100%)
 rename arch/arm/boot/dts/{ => via}/wm8750.dtsi (100%)
 rename arch/arm/boot/dts/{ => via}/wm8850-w70v2.dts (100%)
 rename arch/arm/boot/dts/{ => via}/wm8850.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/virtual/Makefile
 rename arch/arm/boot/dts/{ => virtual}/xenvm-4.2.dts (100%)
 create mode 100644 arch/arm/boot/dts/vybrid/Makefile
 create mode 120000 arch/arm/boot/dts/vybrid/armv7-m.dtsi
 rename arch/arm/boot/dts/{ => vybrid}/vf-colibri-eval-v3.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf500-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf500-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf500.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-bk4.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-colibri-eval-v3.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-colibri.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-cosmic.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-pinfunc.h (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-twr.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-cfu1.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-dev-rev-b.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-dev-rev-c.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-dev.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-scu4-aib.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-spb4.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-ssmb-dtu.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610-zii-ssmb-spu3.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610m4-colibri.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610m4-cosmic.dts (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vf610m4.dtsi (100%)
 rename arch/arm/boot/dts/{ => vybrid}/vfxxx.dtsi (100%)
 create mode 100644 arch/arm/boot/dts/xilinx/Makefile
 rename arch/arm/boot/dts/{ => xilinx}/zynq-7000.dtsi (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-cc108.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-ebaz4205.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-microzed.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-parallella.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zc702.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zc706.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zc770-xm010.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zc770-xm011.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zc770-xm012.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zc770-xm013.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zed.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zturn-common.dtsi (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zturn-v5.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zturn.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zybo-z7.dts (100%)
 rename arch/arm/boot/dts/{ => xilinx}/zynq-zybo.dts (100%)
 create mode 100644 arch/arm/boot/dts/xscale/Makefile
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-adi-coyote.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-arcom-vulcan.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-dlink-dsm-g600.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-freecom-fsg-3.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-gateway-7001.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-gateworks-gw2348.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-goramo-multilink.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-iomega-nas100d.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-ixdp425.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-ixdpg425.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-linksys-nslu2.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-linksys-wrv54g.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-netgear-wg302v1.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x-welltech-epbx100.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp42x.dtsi (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp43x-gateworks-gw2358.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp43x-kixrp435.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp43x.dtsi (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp45x-ixp46x.dtsi (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp46x-ixdp465.dts (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp4xx-reference-design.dtsi (100%)
 rename arch/arm/boot/dts/{ => xscale}/intel-ixp4xx.dtsi (100%)

-- 
2.34.1

