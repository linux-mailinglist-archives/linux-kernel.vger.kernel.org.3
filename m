Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE894B09DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbiBJJss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:48:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239027AbiBJJsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:48:45 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [195.145.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26628138
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1644486523; x=1647078523;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F7rkKagQJXYHpGW0Cswqt02zkInNBCau3cLLv2x4iGE=;
        b=qjDX5pwL2cUshiK9roLKnDxFhbBnPLxCDNF9sAVSPegmj0A3roW0f8J3dnqKhWwi
        iswrwqP+A8NoO/k7Qhkz69QgA2PXSwJ5NooURZSJGablqJD+WGOEkehc71kKHrk5
        J3R8m041H8cZrjJUQnPtcBRlodXFaqxwg3skwYd1jeU=;
X-AuditID: c39127d2-9112070000002a63-db-6204df7befae
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D7.36.10851.B7FD4026; Thu, 10 Feb 2022 10:48:43 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2022021010484333-259562 ;
          Thu, 10 Feb 2022 10:48:43 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     dmitry.torokhov@gmail.com, yuehaibing@huawei.com,
        linux-input@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] Input: tsc200x-core - Add axis inversion and swapping support
Date:   Thu, 10 Feb 2022 10:48:43 +0100
Message-Id: <20220210094843.1889881-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 10.02.2022 10:48:43,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 10.02.2022 10:48:43
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWyRoCBS7f6PkuSwa6nGhaHF71gtLj56Rur
        xeVdc9gsbk+czGhx5+tzFgdWj52z7rJ7tBx5y+rR/9fA4/MmuQCWKC6blNSczLLUIn27BK6M
        E0/3sBWcE6548/4ZcwPjYYEuRk4OCQETibk79jN3MXJxCAlsZZTY8es6E4RznlFi467j7CBV
        bAKKEudvv2UFsUUEAiUO9vcA2RwczAIOEi195SBhYYEIiSMblzCC2CwCqhKH+neClfMKmEk8
        O/WSCWKZvMTMS9/ZIeKCEidnPmEB2SUhcIVR4sDsj2wQRUISpxefZQaxmQW0JZYtfM08gZFv
        FpKeWUhSCxiZVjEK5WYmZ6cWZWbrFWRUlqQm66WkbmIEBt7hieqXdjD2zfE4xMjEwXiIUYKD
        WUmE91Q9c5IQb0piZVVqUX58UWlOavEhRmkOFiVx3vs9TIlCAumJJanZqakFqUUwWSYOTqkG
        Ri3vh1qzUxi4ntabSXOu8/ffNMGkRuREXs+Zb4VmDUkfJy6dEN2WZPHuSojcFUXla8Zv80z2
        TnH/JX6LV/D7mdi3n0MiPqpM0/qxTffUhiDt9OJqIbUMPY5tj+KOzXE5tSIq8phTfIZ7ouq/
        yTM7M39YVd1IvHuk7K1P+emj2Qce7CvaWbtrixJLcUaioRZzUXEiAMR0ATIqAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Commit ed7c9870c9bc ("Input: of=5Ftouchscreen - add support for
inverted / swapped axes"), the of=5Ftouchscreen interface supports axis
inverting and swapping through Devicetree properties. Make use of this
feature.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
Changes in v2:
- Added additional properties to documentation
---
 .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 3 +++
 drivers/input/touchscreen/tsc200x-core.c                   | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005=
.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
index 938aab016cc2..166a254c8472 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
@@ -54,6 +54,9 @@ properties:
   touchscreen-max-pressure: true
   touchscreen-size-x: true
   touchscreen-size-y: true
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-swapped-x-y: true
=20
 allOf:
   - $ref: touchscreen.yaml#
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touch=
screen/tsc200x-core.c
index 27810f6c69f6..72c7258b93a5 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -88,6 +88,8 @@ struct tsc200x {
 	int                     in=5Fz1;
 	int			in=5Fz2;
=20
+	struct touchscreen=5Fproperties prop;
+
 	spinlock=5Ft		lock;
 	struct timer=5Flist	penup=5Ftimer;
=20
@@ -113,8 +115,7 @@ static void tsc200x=5Fupdate=5Fpen=5Fstate(struct tsc20=
0x *ts,
 				     int x, int y, int pressure)
 {
 	if (pressure) {
-		input=5Freport=5Fabs(ts->idev, ABS=5FX, x);
-		input=5Freport=5Fabs(ts->idev, ABS=5FY, y);
+		touchscreen=5Freport=5Fpos(ts->idev, &ts->prop, x, y, false);
 		input=5Freport=5Fabs(ts->idev, ABS=5FPRESSURE, pressure);
 		if (!ts->pen=5Fdown) {
 			input=5Freport=5Fkey(ts->idev, BTN=5FTOUCH, !!pressure);
@@ -533,7 +534,7 @@ int tsc200x=5Fprobe(struct device *dev, int irq, const =
struct input=5Fid *tsc=5Fid,
 	input=5Fset=5Fabs=5Fparams(input=5Fdev, ABS=5FPRESSURE,
 			     0, MAX=5F12BIT, TSC200X=5FDEF=5FP=5FFUZZ, 0);
=20
-	touchscreen=5Fparse=5Fproperties(input=5Fdev, false, NULL);
+	touchscreen=5Fparse=5Fproperties(input=5Fdev, false, &ts->prop);
=20
 	/* Ensure the touchscreen is off */
 	tsc200x=5Fstop=5Fscan(ts);
--=20
2.25.1

