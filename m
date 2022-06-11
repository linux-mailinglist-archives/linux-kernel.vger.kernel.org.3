Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA25547274
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiFKGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiFKGxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:53:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FD74CD58;
        Fri, 10 Jun 2022 23:53:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w27so1361162edl.7;
        Fri, 10 Jun 2022 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zc/ja1DOr+UGSYNswkfus9lzkrP7FkDW/slHx9/IKhM=;
        b=Db8030kntC6z/HKCADKmfWp67SFTAkL977Rd3mAm/AQQQSWW+d6OSVqJjYoRJN8+be
         dZ5H8VU1hpJLBorBdqziN7fYo7ZPMfjibfv7BGTtKAGanOgF8GK53m6mt8X4BTnsfxeI
         Np+bgEM8laZjxd09uHDPm0c8cxHzwyNPFVu91JO3uUsmHczWoQZ6P49dWRbJsto+28ek
         ZYtzgQE5KZDT0lQOqthpozIzwd6SUbcAah4nJql59dD8Bfq15KEIoDzmYkPLuw1/ueiU
         pZMb8tPoNzUFsAv02BIuUonfnphYeYCvSUk3deI7Oa1s84ifD3/d2WQXbV7JTUdTMg8Y
         572g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zc/ja1DOr+UGSYNswkfus9lzkrP7FkDW/slHx9/IKhM=;
        b=nPVE90LKL+xry5tKkyzF9YKhZY/4s4Ipzmim8Thj5iluX4Ydx1Uo8lgq3ppxtbPTmH
         U7nKCA7P5xygeQ68cUWrFDhcRYyHNJEGSlkAfwwu9iv1fD9wQ64+KqWtfDh3jMldrz+e
         Zi03Fc6YXNtL52bsCuE3hsfQq2NAdadzmFDvKvSubsTSVsIo7/R2Rt/u3uSZ0UWhzBL+
         h4ytY1xeiGMigrFNT2aSYHBwDH94mcOmCTgJiNJ3TqECKsJnbmtr/hZNPPg2wMALAHgR
         S1/+g/9J7IvVhpeaQnECYC+E6tnwbb9nSwiyvYU9+nYCVvh3aJoX/o7wXEmShBdmA9Hs
         En5w==
X-Gm-Message-State: AOAM533xGGC/s+Zqbold90potM+xoUvQTNP4RA7Obkd6wClzpn9BcERY
        CqlvH396Y1asRJ1xim4BvH4=
X-Google-Smtp-Source: ABdhPJy2mjZchvrqJCiCFKl1zY7F9clkLHeO6YhJTJcF13tJU2Y1Bw540m7desgHARD+bCdkZ72J3Q==
X-Received: by 2002:a05:6402:5191:b0:42f:b303:ed61 with SMTP id q17-20020a056402519100b0042fb303ed61mr44123860edd.233.1654930397719;
        Fri, 10 Jun 2022 23:53:17 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id v14-20020a056402348e00b0042dc25fdf5bsm874261edc.29.2022.06.10.23.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 23:53:17 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] HDMI Audio on RK356x/Quartz64 Model A
Date:   Sat, 11 Jun 2022 08:52:58 +0200
Message-Id: <20220611065300.885212-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables HDMI audio on Quartz64 Model A, and the RK356x SoC in
general.

i2s0 on the RK356x is connected to HDMI, and only has one DMA. I've
confirmed this with the TRM.

To test this, one needs a video clock, i.e. there is no audio if your
screen is off. The framebuffer console or something else needs to be
running to get audio output.

Changes in v3:
 - rebased onto next-20220610

Changes in v2:
 - reordered nodes in rk356x.dtsi to conform
 - reordered properties in rk356x.dtsi to conform
 - add Michael Riesch's Tested-by to rk356x.dtsi

Nicolas Frattaroli (2):
  arm64: dts: rockchip: rk356x: Add HDMI audio nodes
  arm64: dts: rockchip: Enable HDMI audio on Quartz64 A

 .../boot/dts/rockchip/rk3566-quartz64-a.dts   |  8 +++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 33 +++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
2.36.1

