Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4A4B0078
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiBIWjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:39:39 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiBIWje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:39:34 -0500
X-Greylist: delayed 394 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 14:39:36 PST
Received: from mickerik.phytec.de (mickerik.phytec.de [195.145.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F52C1DF65E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1644446373; x=1647038373;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EzckGd9Ydqg+0+DJujflO9WgyKd1bNpDeZF5ujGoVhY=;
        b=qM7mIcK1sMFBFze6SBM+fBGFvvENMoIXas46Ttn8BDpyjrJD6OTvQOEEH2/bnuZb
        mNi1CK7CjiDipwfLSbTNXRIicWbMG/kDDU/yRq3o3Y+QXVnHYWIptWy2+EhjvmWe
        jyId/4mCTN6Qd6bqE7sCDPUPC2HHWnnvg+l3jwQ0Frc=;
X-AuditID: c39127d2-9112070000002a63-fc-620442a57246
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FA.82.10851.5A244026; Wed,  9 Feb 2022 23:39:33 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2022020923393376-256579 ;
          Wed, 9 Feb 2022 23:39:33 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     dmitry.torokhov@gmail.com, yuehaibing@huawei.com,
        linux-input@vger.kernel.org
Cc:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Input: tsc200x-core - Add axis inversion and swapping support
Date:   Wed, 9 Feb 2022 23:39:33 +0100
Message-Id: <20220209223933.1672782-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.02.2022 23:39:33,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.02.2022 23:39:33
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWyRoCBS3epE0uSwctXxhaHF71gtLj56Rur
        xeVdc9gsbk+czGhx5+tzFgdWj52z7rJ7tBx5y+rR/9fA4/MmuQCWKC6blNSczLLUIn27BK6M
        yW+2sRac5q1ov3WGvYFxFXcXIyeHhICJxOQjH9i6GLk4hAS2Mkq0TV7MDOGcY5Q49+MCC0gV
        m4CixPnbb1lBbBGBQImD/T1ANgcHs4CDREtfOYgpLBAq8WSBNkgFi4CKxPoZ9xlBbF4BM4kZ
        0zuYIHbJS8y89J0dIi4ocXLmExaQVRICVxgl9kz5wAhRJCRxevFZZhCbWUBbYtnC18wTGPlm
        IemZhSS1gJFpFaNQbmZydmpRZrZeQUZlSWqyXkrqJkZg2B2eqH5pB2PfHI9DjEwcjIcYJTiY
        lUR4T9UzJwnxpiRWVqUW5ccXleakFh9ilOZgURLnvd/DlCgkkJ5YkpqdmlqQWgSTZeLglGpg
        NK06PSd7jsNJ29279jAsiz7y4c6Uq+Yiweu+6BW92JBX2fHo8AdRx7/LGTcpvnE8cm/dyvA0
        QbaJ0/tnKj+T5Ons/ShrEB7kEl17SUzpXM/Cn3u71LdMe1yYwnfq6MKKnymvN54tfrVc+vQp
        4dV7ZGxmRIgdLF1TwsRjrHTje9C9W0/+G4QUvVBiKc5INNRiLipOBADBttksKQIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/input/touchscreen/tsc200x-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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

