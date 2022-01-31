Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81B44A515B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380823AbiAaVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:20:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:49223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380378AbiAaVT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643663982;
        bh=0OoQMhJlkEEiwoOOeHhR3TbqGiB7U4P44mzeiefOj8w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SYLlAFSnow7Dc6BEQwLj/tjkeWS2Q5z4fs7B5ngPr45KsLAeSruh4oiA4At1hD1tW
         z7tDebJ8Gsk/cm1Qa94nREpmRyrqISIaTDBeGKtGJA3bINVDHAc2Fy0d9ygqmTnd1D
         aqa3UtybSjNTSryDGzgu9eMrYdSor/9CvCByFXRw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MPXhK-1mt6nU1D8s-00McQV; Mon, 31 Jan 2022 22:19:42 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] hwmon: (sch56xx-common) Replace msleep() with usleep_range()
Date:   Mon, 31 Jan 2022 22:19:34 +0100
Message-Id: <20220131211935.3656-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131211935.3656-1-W_Armin@gmx.de>
References: <20220131211935.3656-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:keGOqHcPU7isTiMdTtCxhgbByl38KArrEoSwhWJtKvUZ4rvOXzF
 7eDUR87WbFnj1YiJROkfAkI2KYimdk94J6WkW2D223rKJKWKrJWlnlc9CrFwxkK2LUKcqMA
 rt3A2ezbRIb4xj0FYYjQioysNd/nY9qBOeMbhNtRe+R9E3fWX5gVSsYtWw0wGJPwDM+1n7a
 CC5aSFAqlIEU705yLqxAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6u3HBQKHZp4=:26Xqxjgu3dalALeW3pUFTE
 IQ0qf9jBxlBmUTAkZYPBJObJuvZAHBLfmG5OfKeuFL62GpnLozCSaakBOPSdIvqZy1t+XnONK
 WOKVgUOfNcQKJo1vzoDuzkpzuFQ5Q6TA5Ee8jd355pBOJMlJLsTKjJl+cAsQD1Xfq4bM+k7Mr
 66HJiUah+Z4sjnfueAKlv9L9Y/d79i22iicMgkfGLC3nDw5iQDrqzH+P1oVce1IfAx6RZnR2o
 TheBJPSp+ELC4nWjDgz/j2Ad8Z5OqZvRZ8DTuQncxaNtUvyYgZMzRNgRqeFB+129MHf/MGtLX
 uG8u2PYv4tn9BWWPUjkmzeiE0nqO1CdnZNdWuOgDULjNRWMjxh6qFFUcPkgXSgW543e6Y9ShX
 zqtQ4oweKgnHy4x1prXxeagpJNYNEl0NL+K2B5lb98kDPNFwbi4Y96SN9qoQhBaeKvRs5Ez8Q
 C5/95sXPztGLxImZljbA36vqEOe7g65X4pnVdKU+5GI5tjbXQhVi1r4YyY5czDdoTHx/iD5qi
 VHKY+m8xtJhioSI9RsfutkM4KWlCFOtiV8JK+FXCh2yrAo5HyA0JVl/JOrmwSj4EP0GULBZ5W
 bYrKTAbP5MUFuMVs5MmcKaClkkk7hNs411ggSUNxDvFUVSQqMFqJMlaKppIQ3UYLkfoSqfcPy
 fwziqOq7/y6G11SevWkwrFhIQ0gBdABVjzMUi1+/dVMmjqJSeljbJ7nOCWcl9mZiu29AuLIQG
 qn7UYNdQ9+GmhuIdJDEB6GoP0h7goManmFYnKxAtgpK7RNVHa63lKOiYO8hcX5QHS2n1/Sbgq
 s4ObTIrQT//4fPju7ohLwcpuYuzU5uA5rMCJ2FlSUI9hXXpXOqogYNYLGH6RWTI5gvISI+wIA
 x4T6Ln+vupj26gYJeDT8C+XgjGtAGK+jivbUnBe/uv1e0BFERd5rpgVrFjwnJfBaKqGFvOsfW
 6zxudnWfAFUaFG0OIP9P21LGdEaRu7m+QQVusgxxctlKA4qqfzTfM/MLSdPyOBDg7D4X0l6IM
 sbkiKoMBlVR4MXsa7lGjtpko62omR5nPQuVpOSfdJOsMCUweCQgVSoyXy56NKesp0yW838yXD
 GG8H1UaNwZKQzQ=
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
index 0172aa16dc0c..82602b74c7ed 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -139,7 +139,7 @@ static int sch56xx_send_cmd(u16 addr, u8 cmd, u16 reg,=
 u8 v)
 	/* EM Interface Polling "Algorithm" */
 	for (i =3D 0; i < max_busy_polls + max_lazy_polls; i++) {
 		if (i >=3D max_busy_polls)
-			msleep(1);
+			usleep_range(1000, 2000);
 		/* Read Interrupt source Register */
 		val =3D inb(addr + 8);
 		/* Write Clear the interrupt source bits */
=2D-
2.30.2

