Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E347454B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhLNOjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:39:05 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:62960 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhLNOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1639492743; x=1642084743;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EzckGd9Ydqg+0+DJujflO9WgyKd1bNpDeZF5ujGoVhY=;
        b=DqDx2r1oRSO4F6oBrNeuYJ5VJPc5m/wBJaXfPtKlMFkUflqOvEoYTZzDJPkHBSir
        /9TaU84dyMgmFT4qwydtwH0af0uOQYzSeUIso/0BLEbP6bFZSP56eBsJ6WmEu8Ps
        +lsOEvlZ3OIRsHSuzml4OIbL6a8HlEtvWcUfsSGSN+E=;
X-AuditID: c39127d2-4f7337000000426a-e2-61b8ac8745be
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id DA.A3.17002.78CA8B16; Tue, 14 Dec 2021 15:39:03 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021121415390342-2374257 ;
          Tue, 14 Dec 2021 15:39:03 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc:     yuehaibing@huawei.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tsc200x-core - Add axis inversion and swapping support
Date:   Tue, 14 Dec 2021 15:39:03 +0100
Message-Id: <20211214143903.1324122-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.12.2021 15:39:03,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 14.12.2021 15:39:03
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWyRoCBS7d9zY5Eg/u75SwOL3rBaHHz0zdW
        i8u75rBZ3J44mdHiztfnLA6sHjtn3WX3aDnyltWj/6+Bx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        k99sYy04zVvRfusMewPjKu4uRk4OCQETiVuTf7N1MXJxCAlsZZS40rCEBcK5wCjxZf4bZpAq
        NgFFifO337KC2CICVhKzmtsYQWxmgXCJRUuXANkcHMICfhJPTyqAhFkEVCX2HN/FDmLzCphJ
        LFp3mQlimbzEzEvfoeKCEidnPgHbJSFwhVGiae80NogiIYnTi88yQ8zXlli28DXzBEa+WUh6
        ZiFJLWBkWsUolJuZnJ1alJmtV5BRWZKarJeSuokRGHiHJ6pf2sHYN8fjECMTB+MhRgkOZiUR
        3pfWWxOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ897vYUoUEkhPLEnNTk0tSC2CyTJxcEo1MKaZ
        p+x3a20xzKloXrb8bH3/dlb9pWGn70+vS5/X4iYiM715zz4D/9Xv6rh6555bdPH3wpnPru9N
        n+bh4uV8WeW1y57v1VuMel0L7085vJjdM/sne3rYq5OqYhMn+2Wsk/vLOOFE9NGLq5+X1Ikk
        3Lzcf8ojetu/s1tqXx6ZNcdmbWD7j+tZ/ycrsRRnJBpqMRcVJwIAS+TCfyoCAAA=
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

