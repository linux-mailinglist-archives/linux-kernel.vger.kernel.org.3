Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625D857F105
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiGWS57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGWS5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:57:54 -0400
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AF1658B;
        Sat, 23 Jul 2022 11:57:52 -0700 (PDT)
Date:   Sat, 23 Jul 2022 18:57:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658602670; x=1658861870;
        bh=m8R1HiRlIp9Imo0Yj9VIVGVtSUHR6cnW7lkME/XSDRo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=DV1+t+qXdVU50nQIMWc8T6Jzh7S0g5g4U6/w2tstnOE0yWj0+gO4mUgAZHgbLumCm
         Tj7VQIEGCSUQpVaHYbvJrDeC7U47ys9bUWPmuhknp9na6TxYdidKXfADa6/WdZJ9OO
         IPrqMoBTp1X6w4LqvUs47dXuQC46qA/sI4g42aKvnGDmGLzb9umN/Ognsk3qj8Y/yO
         V16VQdCPmDKDw9g05rqSc9l7vORyn5fhG/RlQ3xjaurmu0rTO8ktXdMbXlUkXeV6vH
         yAwbe0lTpwIJsg35k/zBNCdGCcNXO8dcgXfbcC5f3J3GL56PWqs89+fzK5pG9OheEE
         jqJDV7PbKhxaQ==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, soc@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH v6 0/5] Add Samsung Galaxy E5/E7/Grand Max device trees
Message-ID: <20220723185424.203340-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v6: Rename touchscreen analog regulator for a2015
Use regulator haptic instead of GPIO vibrator
Fix email in Acked-by tag
v5: Fix Error:
arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi:36.2-22 Properti=
es
must precede subnodes
Restore Acked-by tag in the dt-bindings patch
v4: Disable i2c2 until lis2hh12 accelerometer is fixed.
Add GPIO LEDs for Grand Max.
v3: Add a cover letter and changelog
v2: Add dt-bindings documentation

Samsung Galaxy E5, E7 and Grand Max are smartphones using the MSM8916 SoC
released in 2015.

e2015 and a2015 are similar, with some differences in accelerometer,
MUIC and Vibrator. The common parts are shared in
msm8916-samsung-a2015-common.dtsi to reduce duplication.

The three devices (and all other variants of E5/E7/Grand Max released in
2015) are very similar, with some differences in display, touchscreen,
sensors and NFC. The common parts are shared in
msm8916-samsung-e2015-common.dtsi to reduce duplication.

Unfortunately, some E5/E7/Grand Max were released with outdated 32-bit
only firmware and never received any update from Samsung. Since the 32-bit
TrustZone firmware is signed there seems to be no way currently to
actually boot this device tree on arm64 Linux on those variants at the
moment.

However, it is possible to use this device tree by compiling an ARM32
kernel instead. The device tree can be easily built on ARM32 with
an #include and it works really well there. To avoid confusion for others
it is still better to add this device tree on arm64. Otherwise it's easy
to forget to update this one when making some changes that affect all
MSM8916 devices.

Maybe someone finds a way to boot ARM64 Linux on those device at some
point. In this case I expect that this device tree can be simply used
as-is.

