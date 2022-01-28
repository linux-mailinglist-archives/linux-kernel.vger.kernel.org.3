Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4A4A0423
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351404AbiA1XKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:10:23 -0500
Received: from mout.gmx.net ([212.227.17.22]:44475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348534AbiA1XKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643411410;
        bh=CLH6h731OtdlnBAYydS1sYh0Khh/6ie3nny30sSumKg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k3XUQ+lGSZl3F0tE/2Qq+YE9K7hGlQ9ZxES6NdAHMO4XzPDbDvL6Vh6CqXPggQBON
         YMF+EqyLuMWg84U25cP9rBtF23uKrJf/IwJ+icgo8Sc9INXS8noq+gHUyQEAXZyCZL
         TqBUd3CN+bdlUoyhp4QFzVqhZjb5fHpYnCA6OIUc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUqF-1n6g6Y3KSl-00D10P; Sat, 29
 Jan 2022 00:10:09 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] clk: clps711x: Terminate clk_div_table with sentinel element
Date:   Sat, 29 Jan 2022 00:09:22 +0100
Message-Id: <20220128230922.2047140-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
References: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LScEnOk2k65rxH4TQblU5JW37I4tPPQ7W424UMr/eNnlYBKFwhy
 iZ7ai1T1javUyuPJqO5pbNzL1/RaVZsQj6YiUIczgpPbOzM4RoYwA4NWswDoCmMDlry2aiE
 o5AyV4Ih8iNFffy7/vcyIhRfyL2r862I0Oc7/D7j0tQ+w05mHdNQbL8UwXDuK9vED6nu038
 mQbc5O1D0/RbhQk4OYOLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6agRB8/MRw=:9OcP+d1uJYI+X71B7my18L
 GJr/h9bzYbRllkjATLvpizfqe17Asa0uqR3ZK9x8Kwy+BNBMlJ09ebKtI1vEFGkC3+MSLje7h
 FkCojFWWUKh8VLmjpUdvsweNO716XJ0niDe/jM3ymgrJ+gpXPa0OkH3KVWwTTeq24aaPtj/Dx
 Wrg5qHsQBnsmll/oA78nvd/zo91x2G6AKbSbIR7bZEvCLy5Zuvn2XgQ2khpHEZ2JnesmYKkbe
 agwh3CndVJTwgJ6aoen7T2MnKjsWw3V8lWsxX2Mr5IWUdz7ijwpaCHFdjBWclWQNWgoX0wquz
 6zN+fJeI5G/CTUfmT4AMJBUsMW9XPYyPnRQfzZZeBlIt8rld1AthAaEqn+aGgUDeBGnarWY3W
 7sZs49HM5CsSYXhX0tE8CnMpH4+u8uw7LjOdECgy63/xQixRUSSsvrYpqw+08iSDm3D7UEyYQ
 Hevi7Px7uVMJWRpny9bW55MsVZCPxGIzXFcIag1qmw0uvD/wADouTJDs53sB75s3O7D6LrSbu
 jR3fmLeA9nJu/IMIrUxOWmM9O6tZ7L/aO6s4nqsynxqJrWbji8Y+nw9jXcX9PHyyaA3JOwxez
 yTfYj5cQ6rrUinUWA8yvv4M4oj38m+3fkXw29Otaa4JnnoTAQ53f/YAh9ajz78Ut8A4mKG5QZ
 sobTAOvac6j75N9q891CAAQguwimbdj1/71quCg0wtZcORm+sPMKP6cunLfgdtYUOMDAnlu7X
 MGLSiRy7s6CYZU0CflE6b4RD1WAxYceIMq1kx50PBvSS4JwYIoQ2Ubj+fcjQg5Ku9Dg4JgP8h
 6ESamslBd7oL+Lq7xcmo8CzWG6VR/CoNkjTB4Och8hP2sLrcf3Kyn2WHm9TGEB7kkrLLBf+YC
 K8FUVoUTMc+VclsxK7JCP6lFs70hvZMcF5m0fMV6oTudB98cdq765s2fpu7UXfwCjSu7vPWbp
 44HV0PXRDOcorWKaiEeSn7MRRj3MKqgGeF/vUX1RXMEU6KWRfQEGcSyqKeoRXoxZKDXqGAAeQ
 PRcQWngK3MFKd2Ycm70WgkcwG58t4fkiVAEfaHt7mhPuAhIHYgtfyGEVX9c1+LpP6e80pZva1
 hNnTLFvXH9jS1A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/clk-clps711x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index a2c6486ef1708..d96d96c8752c7 100644
=2D-- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -28,11 +28,13 @@ static const struct clk_div_table spi_div_table[] =3D =
{
 	{ .val =3D 1, .div =3D 8, },
 	{ .val =3D 2, .div =3D 2, },
 	{ .val =3D 3, .div =3D 1, },
+	{}
 };

 static const struct clk_div_table timer_div_table[] =3D {
 	{ .val =3D 0, .div =3D 256, },
 	{ .val =3D 1, .div =3D 1, },
+	{}
 };

 struct clps711x_clk {
=2D-
2.34.1

