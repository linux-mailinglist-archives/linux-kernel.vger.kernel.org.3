Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C55286E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbiEPOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244501AbiEPOXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:23:12 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D593B013;
        Mon, 16 May 2022 07:23:09 -0700 (PDT)
Date:   Mon, 16 May 2022 14:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1652710988;
        bh=VpuPzUmy8azXATgjTkDZFB1+G13PBtCz2A4M2fXlOrg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=cmkmMr/yrS78LEZeSC33FJb4p5RmsjUu8Z7PxX+HUKNTyVl85FDFswevBA/vERRBK
         1MsyAF7jd2eDZRIT5uz+wyWj+pdYIpYpWbGvc8Mi8WaVjgeL/qSILMK8YzB0SPEirf
         cXC+l+vWT+XejYOelC/v1uiqTiTLvcn7szs6UZNM=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phone-devel@vger.kernel.org
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Caleb Connolly <caleb@connolly.tech>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 2/3] arm64: dts: qcom: sdm845-oneplus: add tri-state-key
Message-ID: <20220516142158.1612109-2-caleb@connolly.tech>
In-Reply-To: <20220516142158.1612109-1-caleb@connolly.tech>
References: <20220516142158.1612109-1-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tri-state-key is a 3-state mute slider found on the OnePlus 6.
The default software maps the states to "mute", "vibrate" and "ring",
expose them as generic switch events so that they can be configured
by userspace.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 44 +++++++++++++++++--
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm=
64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 07b729f9fec5..f134c51e17ec 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -7,7 +7,7 @@

 /dts-v1/;

-#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>

 #include "sdm845.dtsi"
@@ -26,7 +26,7 @@ chosen {
 =09=09stdout-path =3D "serial0:115200n8";
 =09};

-=09gpio-keys {
+=09volume-keys {
 =09=09compatible =3D "gpio-keys";
 =09=09label =3D "Volume keys";
 =09=09autorepeat;
@@ -49,6 +49,41 @@ vol-up {
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
+=09=09=09gpios =3D <&tlmm 126 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <50>;
+=09=09=09linux,can-disable;
+=09=09};
+
+=09=09state-middle {
+=09=09=09label =3D "Tri-state key middle";
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_PROG2>;
+=09=09=09gpios =3D <&tlmm 52 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <50>;
+=09=09=09linux,can-disable;
+=09=09};
+
+=09=09state-bottom {
+=09=09=09label =3D "Tri-state key bottom";
+=09=09=09linux,input-type =3D <EV_SW>;
+=09=09=09linux,code =3D <SW_PROG3>;
+=09=09=09gpios =3D <&tlmm 24 GPIO_ACTIVE_LOW>;
+=09=09=09debounce-interval =3D <50>;
+=09=09=09linux,can-disable;
+=09=09};
+=09};
+
 =09reserved-memory {
 =09=09/* The rmtfs_mem needs to be guarded due to "XPU limitations"
 =09=09 * it is otherwise possible for an allocation adjacent to the
@@ -607,9 +642,10 @@ &usb_1_hsphy {
 &tlmm {
 =09gpio-reserved-ranges =3D <0 4>, <81 4>;

-=09tri_state_key_default: tri_state_key_default {
+=09/* The GPIOs have a hardware pullup */
+=09tri_state_key_default: tri-state-pins {
 =09=09mux {
-=09=09=09pins =3D "gpio40", "gpio42", "gpio26";
+=09=09=09pins =3D "gpio126", "gpio52", "gpio24";
 =09=09=09function =3D "gpio";
 =09=09=09drive-strength =3D <2>;
 =09=09=09bias-disable;
--
2.36.1


