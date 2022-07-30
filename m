Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D045858E0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 08:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiG3Gh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiG3Gh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 02:37:56 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A243949B66
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 23:37:54 -0700 (PDT)
Date:   Sat, 30 Jul 2022 06:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurevit.ch;
        s=protonmail; t=1659163072; x=1659422272;
        bh=4b/3s3O3YVmjgF+YOkAU35pIIIgu6wkFPG0NYHRXye4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=QUecaTpIdv7SRYjw+0TR7+ABWTDT8uXZ80Mz8yYRj0hlIhZdlB4o1c9TeOG+TlDcX
         4zWFP4c4uaMt124tFAEhV0TkavZDc+kV/Tk0wOOSXEpR7L/hJyagVX2qWxgyHbdr1+
         A4YOy+XD3G+M1s3a4CmtlDFNa8vq1PhM99A67QRJDqEcHsLjPgI4JXiivaKCTlri75
         IE6A17eDLahrmMF7bLo9dIChYVh5Ua7s0MmASXG9AjWK0njnSDNDgN5QDOHFcvm5Ec
         jqCKnkPG8qwzc6lCJxdtuGRF2ZprOBjbwJW2Lj+bjpDgR3xbMqRSfxaUl+rKERfu+w
         lN2Al3UjZButA==
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
From:   gurevitch <mail@gurevit.ch>
Cc:     "egori@altlinux.org" <egori@altlinux.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: gurevitch <mail@gurevit.ch>
Subject: [PATCH] Input: i8042 - enable dumbkbd quirk for HP 15-dy2xxx and 15s-fq2xxx
Message-ID: <2iAJTwqZV6lQs26cTb38RNYqxvsink6SRmrZ5h0cBUSuf9NT0tZTsf9fEAbbto2maavHJEOP8GA1evlKa6xjKOsaskDhtJWxjcnrgPigzVo=@gurevit.ch>
Feedback-ID: 43922923:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two sets of HP laptops have a long keyboard initialization delay due
to the controller not delivering interrupts correctly as previously
determined by Egor and Vojtech. For the 15-dy2044nr models I have at work
the issue persists even after manually updating the system firmware to the
latest revision from the Microsoft update catalog (15.21.0.0). Egor
submitted a patch for 15s-fq2xxx systems previously but it seems to have
been missed/forgotten, so I've included both here.

Link: https://lore.kernel.org/lkml/20210528154339.GA9116@suse.com/
Link: https://lore.kernel.org/all/20210609073333.8425-1-egori@altlinux.org/

Signed-off-by: gurevitch <mail@gurevit.ch>
---
 drivers/input/serio/i8042-x86ia64io.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8=
042-x86ia64io.h
index 148a7c5fd..a2454d277 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -995,6 +995,24 @@ static const struct dmi_system_id __initconst i8042_dm=
i_kbdreset_table[] =3D {
 =09{ }
 };

+static const struct dmi_system_id __initconst i8042_dmi_dumbkbd_table[] =
=3D {
+=09{
+=09=09/* HP 15-dy2xxx - keyboard */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15-dy2xxx"),
+=09=09},
+=09},
+=09{
+=09=09/* HP 15s-fq2xxx - keyboard */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "HP Laptop 15s-fq2xxx"),
+=09=09},
+=09},
+=09{ }
+};
+
 static const struct dmi_system_id i8042_dmi_probe_defer_table[] __initcons=
t =3D {
 =09{
 =09=09/* ASUS ZenBook UX425UA */
@@ -1333,6 +1351,9 @@ static int __init i8042_platform_init(void)
 =09if (dmi_check_system(i8042_dmi_kbdreset_table))
 =09=09i8042_kbdreset =3D true;

+=09if (dmi_check_system(i8042_dmi_dumbkbd_table))
+=09=09i8042_dumbkbd =3D true;
+
 =09if (dmi_check_system(i8042_dmi_probe_defer_table))
 =09=09i8042_probe_defer =3D true;

--
2.37.1

