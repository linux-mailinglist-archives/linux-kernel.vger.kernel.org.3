Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C077E4A4F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376662AbiAaTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:32:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:45995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376730AbiAaTcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643657515;
        bh=mJxsPYb64pkiiR8ddTh3vIBADHaclB5tW+tmgCYuZ4E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lXWI0pCjpj3Qs4A8V8fHHPqclFPzCVDuKh/4Yrbu6Bh7iroyFPyRFzKR3hLuUR1dq
         7qBV1nCgByOjN3imnV/EmnvebzM+Al75xC5N+15lh8np0Tyw901L1qWUzyFQdtUSfk
         SdpC6fZrqe14deMYjsQe/k9BNozSV85cU/qDRgpg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmlXA-1mYNgr0jf4-00jqdT; Mon, 31 Jan 2022 20:31:55 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] hwmon: (sch56xx-common) Replace msleep() with usleep_range()
Date:   Mon, 31 Jan 2022 20:31:36 +0100
Message-Id: <20220131193137.3684-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131193137.3684-1-W_Armin@gmx.de>
References: <20220131193137.3684-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9G+QQoT8RrwqS+i/j4j4JFVKX/Z2VG+dboyDoCr9nNHW2DYgPSX
 Bny4oKqRq/W50sZbkfD1Lm+JPCPLBow4iMnbLZw3M6Os2FvRUChKwfio5dKFgXrsVaxSB9E
 SBjD/08xQl8b72qAqdGj4W6UMWor0fs478zQoCQ7uHEB1oNv/fpywVkn9VAvnn18kW8wCKf
 d4zr931FgSpiYEA0wQvcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VM/N2hPwimw=:TDLn1RP9wce1q2iypMf/xC
 +XIOLkRq3pt0uw5aSER/jYX7sMGogoUaXXZYHFSg1TJD4Kgp+aUePaXb9Wk87pftYBocvB/Ov
 wcaH6OMYazE4WTam/fPQdE/7SJqnUP/jz11I1TE3QiT1Os1k9c3nwjuDUy8bQzCH27PgNwszM
 VcKRPGVIDEnVu4SkPUdlBA4smOupVqlIhyu3jZCDIDxH5S3GQumjFBwdMhiywNiWnimWDCUvv
 XvqavZcMuBkmf5TThX05EeR8UC7p2h2pzYrGOuUEMMn+Hf/D3eAl5Z7QvHHVFxGYYLJfSVc8G
 7mp40W5TN1IjS6Jb3MYkwdkHFcibzYMMq4xkI+7WeRKa7EmX8ao7gQxaNo/wyuGb1382YpPjD
 mOkdCOXhCnbb045tAp17fe6QqZoTGzM3ANpn2nTsn3lszMqoameUOIUl0qqUT8MKzjFtE855N
 s5q6LW5kKLwlpQxVs/Q3wARtWjytqyR8X6Dx1mf2bA55pZaeuo9cpI9MopIOt+cKO+nAAicJT
 we5dg1mi3z8MqYjDIhqhTe5mj9F1+qcFJ6Xo50liJPWpaVz6sb6xAnQDmvdDFJf06FVJ6Edu0
 tR3TmIh1J2v+leFhxs5r+vBJzM26ZyU7GlZnOxzLB/uLdgWey58Nxj6XYUatvLW+ZaSqS5s5l
 lbSCEo8tLmkLBy02rPlfB3ti8GdoqF20dEOJfg1RWM4hLBkg9x/WvnUZnyT4+EZFgIc/BOvMW
 qh/jtly42Lz8u2UvHkPVP3bRh2T+M11D+P0Nj46UcAaIM2DAlHFs1Kzg9OeAqQ85eBtTHH2GV
 03GHXt8zlHqwGJtxcpvcH5qDERjc3xX3uLuesr5h3Nyu78jKI4L8xqUx6B9bjbBB/bPyEo949
 o0Kzsy0P0t6F8dWmGPQA8H6xXol5qkSzGz1FmoXFvvnd+qrAbP6vglCte0sYgId47ky3oN+rs
 S0xBBqu109lz4uif7wV5h105ruVnxLZNj4n602G6cxNnsw1dqNhDLVuMv6axVy+EvFAxYZM+l
 EJIMZikB5S54vYeoF0Pg4+DsOfbKzcy7+xDwaxdxsaoPYAYJmNYS8lg0fzyZMflV2QIO/K8V+
 QbnJb8PbN9HXVQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msleep(1) will often sleep more than 20ms, slowing down sensor
and watchdog reads/writes. Use usleep_range() as recommended
in timers-howto.rst to fix that.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch56xx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index 0172aa16dc0c..f66e1ed4b1aa 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -139,7 +139,7 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg,=
 u8 v)
 	/* EM Interface Polling "Algorithm" */
 	for (i =3D 0; i < max_busy_polls + max_lazy_polls; i++) {
 		if (i >=3D max_busy_polls)
-			msleep(1);
+			usleep_range(1, 2);
 		/* Read Interrupt source Register */
 		val =3D inb(addr + 8);
 		/* Write Clear the interrupt source bits */
=2D-
2.30.2

