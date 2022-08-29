Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1F5A421B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiH2FBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH2FBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:01:04 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373682B601;
        Sun, 28 Aug 2022 22:01:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EFBF232004E7;
        Mon, 29 Aug 2022 01:01:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 01:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1661749260; x=1661835660; bh=t7Mr+gvF/U2yE7cshYpx9FNiT7NXPfbo+hP
        40/AhEyY=; b=X5XZli79rw1n2HAZH0ZcvmcKn8BEiN1PdEMgRN/FO4kOtUD13MD
        p0y+oTKYmD15Bv2eQw1cB8PyER/+EzKlnboAfQNTYKhiwZ/25fsEeu9OkFwQD/Bl
        iT1JwpUXSLwsKRD69izPyoBAuFAxnAL61unRsApMefShcjCZzO7VJfQ1mc9iCSmK
        KZ8xjev/M3F6o+biOfQHdahTN3Si4gsIr+85teVpXJPgTeVcVyZQqVGqzhscbbTw
        z4ZreLim7l6uvLbNfcwmr/RXXp8HoGT+m+R53ftkjwkwEQVNxdv8DXfkLUtG/UzT
        yz7O+dl7zDAc11Hawg2xpB+0PC2hB6xON2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661749260; x=1661835660; bh=t7Mr+gvF/U2yE
        7cshYpx9FNiT7NXPfbo+hP40/AhEyY=; b=TKFUnRnjmv60I09kxk3DjO2Cp9UIq
        fjU8toH9JA5jYTvQavuQn/mCRjLk2tRx3zYSXh4rzVmoHcxd9mKOu9WAw/YBAw7z
        wcn4bAgGiJlmuskYG8M4EYMQOMkcxnYuYjEUABCiuBpFOXRbZUKF5DsWPhTo9lvA
        sy8mcqP8GFGBTeZfhI03+EwI6BZoGA/wh5A24zupGGcW3AOZpkT2kbdaaiEkHwyo
        OLPZ6rpFx2QpyuVEbu6/4xOEJyXngwry/c4nioVOj3zgLPB/OtnuLp1puXdnKv1+
        /hhW4HT845lgrjVwlBdSMegYUSqM/CpheGV62FnJELgw66Eedkv95Ip0A==
X-ME-Sender: <xms:DEgMY_tMjozZJut3Dt6JxUTpnf7V-yl4wrTQnV6WL-NBcU92v-HMqg>
    <xme:DEgMYwdlGpvgJgxyKuRJf59kaK9bZwOdwZFftOT_mcE9ZJgwp44NFZZYz-Ue7_0cy
    NI5s5zprtDAkQ0CQg>
X-ME-Received: <xmr:DEgMYyym1exYx67lwog9cnLBtxLaqym9ecRMtULWvaT5KZ30hjQiuoLm0Zf-3JIW7c3Wv6PdR7N->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdektddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvohhmucfh
    ihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqne
    cuggftrfgrthhtvghrnhepteeffffggfekffdvjeekhfettdfhveettedukeduleduvdev
    ffettdffhfelueevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihht
    iihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:DEgMY-O0tmeTUxsaQx8krT7iNRQZAxrt_yr26MuBPtaU_MM1E9LJ7Q>
    <xmx:DEgMY_-61iaI6uEQn_7fZqLibAUipcKPaMU_i1Gnxfk50Xx2FqZmwQ>
    <xmx:DEgMY-VUaXsG_S-o6d8W6hYZ8kR6RXn9qQA34YyoCqKZgNGaKqd4LA>
    <xmx:DEgMY-Vqwr7ksEd5wvGEB4YtHUbaZQZndEIC7Vo-D4650GFcS8I7Ew>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 01:00:58 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v5 0/1] Add support for the Pine64 PinePhone Pro phone
Date:   Mon, 29 Aug 2022 15:00:39 +1000
Message-Id: <20220829050040.17330-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PinePhone Pro is a RK3399 based phone produced by Pine64.

Add a basic DTS for it. This is a working base that will allow myself and
others to add more nodes.

Relies on "dt-bindings: arm: rockchip: Add PinePhone Pro bindings"[0].

dtbs_check found some violations, but they were all common to the
rk3399.dtsi (and thus occurred on other RK3399 SoC DTs).

0. https://lore.kernel.org/all/20220815123004.252014-2-tom@tom-fitzhenry.me.uk/

Changes since v4:
* Add regulator vcc1v8_codec.
* Un-enable unused regulators for codec and touch.
* Fix voltage ranges on vdd_center and vccio_sd.
* Un-modify unused gpu_opp_table.

Changes since v3:
* Fix regulator min/max voltages, to align with RK3399-T datasheet.
* Re-enable cluster1_opp/opp06, with freq/volts as per RK3399-T datasheet.
* Fix gpu_opp_table voltages to align with RK3399-T datasheet.
* Change regulator names, to align with PinePhone Pro datasheet.
* Use DT Generic Names Recommendation: power -> key-power.
* Remove unused label vcc_wl on regulator.
* Fix code style.

Changes since v2:
* Used rk3399-opp.dtsi (+ disabled) rather than introdu4cing rk3399-t-opp.dtsi
* Removed superfluous comments.
* Followed DT Generic Names Recommendation
* Set 'From:' of DTS patch to be Martijn, the primary contributor to the DT.

Changes since v1:
* Simplified the DT to a minimal base.
* Introduced the RK3399-T OPPs.

Martijn Braam (1):
  arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro

 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 398 ++++++++++++++++++
 2 files changed, 399 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts


base-commit: 2e1170c71ec0c0fb785ce76fca7c682e930af2b8
prerequisite-patch-id: 41a5419f57b2712f7127d5c6cf1dbf062f6570da
-- 
2.37.1

