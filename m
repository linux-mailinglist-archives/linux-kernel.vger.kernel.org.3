Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4AC5286E9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiEPOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244502AbiEPOXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:23:13 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A383B285;
        Mon, 16 May 2022 07:23:11 -0700 (PDT)
Date:   Mon, 16 May 2022 14:23:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1652710989;
        bh=r0c6Fy6+bDH4824g2iGMHucscG/Y0NMZJhVGiSc6orw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=iy6O0EM5FeLCJHvKD9Tdi+Fhtvy9e/D6djEvwL4apmROygGU2tAaz4pu5qEdgLRx1
         bOyhU7psCO2CwXRbhKhJIheslZYDtjfGASdkAANn07W8UP3vomMJcm+hvx3+w4z/n0
         tTb/CMNPBsHSI+k3wZmDVlYcecx+2gvlSFmTV+kM=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phone-devel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Jami Kettunen <jami.kettunen@somainline.org>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 3/3] arm64: dts: qcom: msm8998-oneplus: add tri-state-key
Message-ID: <20220516142158.1612109-3-caleb@connolly.tech>
In-Reply-To: <20220516142158.1612109-1-caleb@connolly.tech>
References: <20220516142158.1612109-1-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tri-state-key is a 3-state mute slider found on the OnePlus 5.
The default software maps the states to "mute", "vibrate" and "ring",
expose them as generic switch events so that they can be configured
by userspace.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Jami Kettunen <jami.kettunen@somainline.org>
---
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/ar=
m64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 9823d48a91b1..9ae6b3e4fc32 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -94,6 +94,41 @@ vol-up {
 =09=09};
 =09};

+=09tri-state-key {
+=09=09compatible =3D "gpio-keys";
+=09=09label =3D "Tri-state key";
+
+=09=09pinctrl-names =3D "default";
+=09=09pinctrl-0 =3D <&tri_state_key_default>;
+
+=09=09state-top {
+=09=09=09label =3D "Tri-state key top";
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_PROG1>;
+=09=09=09gpios =3D <&tlmm 40 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <50>;
+=09=09=09linux,can-disable;
+=09=09};
+
+=09=09state-middle {
+=09=09=09label =3D "Tri-state key middle";
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_PROG2>;
+=09=09=09gpios =3D <&tlmm 42 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <50>;
+=09=09=09linux,can-disable;
+=09=09};
+
+=09=09state-bottom {
+=09=09=09label =3D "Tri-state key bottom";
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_PROG3>;
+=09=09=09gpios =3D <&tlmm 26 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <50>;
+=09=09=09linux,can-disable;
+=09=09};
+=09};
+
 =09gpio-hall-sensor {
 =09=09compatible =3D "gpio-keys";
 =09=09label =3D "Hall effect sensor";
@@ -441,6 +476,14 @@ vreg_bob: bob {
 &tlmm {
 =09gpio-reserved-ranges =3D <0 4>, <81 4>;

+=09/* The GPIOs have a hardware pullup */
+=09tri_state_key_default: tri-state-pins {
+=09=09=09pins =3D "gpio40", "gpio42", "gpio26";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09};
+
 =09hall_sensor_default: hall-sensor-default {
 =09=09pins =3D "gpio124";
 =09=09function =3D "gpio";
--
2.36.1


