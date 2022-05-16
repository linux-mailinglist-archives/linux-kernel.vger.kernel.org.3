Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696435286E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiEPOXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244456AbiEPOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:23:06 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973051EEF0;
        Mon, 16 May 2022 07:23:03 -0700 (PDT)
Date:   Mon, 16 May 2022 14:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1652710981;
        bh=GkePH7lDmIvIojm6pGTuooS3sc5yfWTWPTLAwIltkVs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=Iu4UUEXzb8YMWcK2+IKaJRgVBCMjowcsik/ivcBKKE9FbKbVTgjgHDLjnbzsLirhI
         7WNisTP4LOFJApvSQ06S8cDZ/F81SAbrmtHRzKGbkTW5nTtwQZ8A3Pr9OT0ZKhMGPN
         /CSpGn5iyaSI2Emx4v/X/t502l2OgCwa2m2ufueA=
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
Subject: [PATCH 1/3] input: add event codes for user programmable switch events
Message-ID: <20220516142158.1612109-1-caleb@connolly.tech>
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

Add SW_PROG{1,2,3,4} for device switches which are handled by userspace.

This can be used for devices with "generic" switches which are intended
to be user-programmable, for example OnePlus phones contain a tri-state
key which can be used for switching between mute/vibrate/ring, or
programmed by the user to perform any arbitrary actions.

These are analogous to the keys KEY_PROG{1,2,3,4} found on some
keyboards.

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
See the next patch in this series for an example usecase.
---
 include/linux/mod_devicetable.h        | 2 +-
 include/uapi/linux/input-event-codes.h | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetabl=
e.h
index 5da5d990ff58..45364fbeaaf7 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -326,7 +326,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_LED_MAX=09=090x0f
 #define INPUT_DEVICE_ID_SND_MAX=09=090x07
 #define INPUT_DEVICE_ID_FF_MAX=09=090x7f
-#define INPUT_DEVICE_ID_SW_MAX=09=090x10
+#define INPUT_DEVICE_ID_SW_MAX=09=090x14
 #define INPUT_DEVICE_ID_PROP_MAX=090x1f

 #define INPUT_DEVICE_ID_MATCH_BUS=091
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/in=
put-event-codes.h
index dff8e7f17074..339153886a13 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -917,7 +917,11 @@
 #define SW_MUTE_DEVICE=09=090x0e  /* set =3D device disabled */
 #define SW_PEN_INSERTED=09=090x0f  /* set =3D pen inserted */
 #define SW_MACHINE_COVER=090x10  /* set =3D cover closed */
-#define SW_MAX=09=09=090x10
+#define SW_PROG1=09=090x11  /* set =3D program 1 (user defined) */
+#define SW_PROG2=09=090x12  /* set =3D program 2 (user defined) */
+#define SW_PROG3=09=090x13  /* set =3D program 3 (user defined) */
+#define SW_PROG4=09=090x14  /* set =3D program 4 (user defined) */
+#define SW_MAX=09=09=090x14
 #define SW_CNT=09=09=09(SW_MAX+1)

 /*
--
2.36.1


