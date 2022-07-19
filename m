Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA5579FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiGSNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiGSNrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:47:49 -0400
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A721106AD7;
        Tue, 19 Jul 2022 06:01:42 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658235700; x=1658494900;
        bh=7P+TRSgZQQ3LvaC8qZN5cB0Oyl/wz/+ack6RXmvW2zI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=aNHvgozLv1aFm+xkPmI6Vrdwq8bkriactujmDXE3yfL8P7rfqKH6i5GVhRuIHp5U0
         i8CBCnEP8Rjx/BqGYeyFfiOtUQI1PWNx7R4mwJM8ho+WOmCOQXJMAr0yq9awR9GuGi
         6UEDwVtMQgPvwBnV1wmpaGpdZdm9W5lSGOWQvP0ktJmRgZX96FL8ch46lZHRcXNKGt
         Pd960bAoSU4EU6nO4JLBn9xv5JVi9Hibrh6VyhWCzPFumiGCUoxf/eeSZMe1WUuyHP
         vOPpeQ1lQi0GWtFLSdvrmATatIi0c2S/KqcvwaMZR+JEjI/PEnEP2vw3vqSSQgl0hQ
         S44dvTOBW5r+g==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH v3 0/4] Add Samsung Galaxy E5/E7/Grand Max device trees
Message-ID: <20220719125851.54571-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220715102055.3844-1-linmengbo0689@protonmail.com>
References: <20220715102055.3844-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

