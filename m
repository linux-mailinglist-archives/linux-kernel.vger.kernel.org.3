Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE34A861C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351156AbiBCOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:22:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:41473 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351137AbiBCOWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643898121;
        bh=Y98HJHV8+2rVxkqGSVZigBWQC8nzfWCAs7dZjAxw0OI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RRg+8V3cTB+jtLehnLPVdDAxHasJXMj1uxdnPDNsoj9X78PAmyy5KH6YW0CujVwJO
         iCtrsUUg5ZFMfICWmqPU7rTulQZbc9bnXUItA2JgdfRh96AmByY6rxtmy5qUR9oGuF
         r65kHs0VoDp0hhf78BM+4+hi9Np3kCA6QJoDf/2U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1mxPel2pxy-00IGFv; Thu, 03
 Feb 2022 15:22:01 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yang Ling <gnaygnil@gmail.com>
Subject: [PATCH v2 2/4] clk: loongson1: Terminate clk_div_table with sentinel element
Date:   Thu,  3 Feb 2022 15:21:51 +0100
Message-Id: <20220203142153.260720-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203142153.260720-1-j.neuschaefer@gmx.net>
References: <20220203142153.260720-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rv+u4jGWT5neCxMqV82upwIemBRJVDHh4dqsB1QqDbsID7nj/ch
 izzM6d8l6xLa5ZRF0vquzrVPAis/7UEDmuLDp68anGxYCkJzt8JjQfYg/fkqEWBsHLsr9WM
 dLYA6P9vSTkvMuJiqb4h0Uf93u1E92Dsz/FlD/KZfKUsV/tgRteLCjjPLPydKv4Ue171gKO
 fS9dcmN1NEPwy0czevU6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+DKrW0uN3Jo=:8rH+2OOMjQ4ZRkdoKCfdd/
 or6T+KQJjCAbI3ZVE1Q87xoE/UEEPYcLwHdBYZCNJPBOQ4J7+Oppf6TVuBjRr7YZmQaFBU7Q1
 HqGCX1Q9cZu0KA708xQYiyOtZAAT6mwO/1BSGYBwJNRY6Y68Aq5VNMMtH+s5W7cvai3PoB2oh
 dd2TW3VHzqzUy6SFVKwKJ7Xs23C5qgHYIheiP3jXQsHXn/Y1bVyWsHTDMXTB/xfWp5jTXEwAu
 J9YX61HFCBgLJJFSnK+54+7u0o/XaoV2OVSFQ9JIiqFBulpBjijiiipWZ49wWdQ0cTJ/bBaCx
 RuPaLMhySRWbhDBWpqRXeclAwL8BXZhjnqBuQSq+d94GksnKP4BdB5SKokRuOzZuirnqYqpNc
 YEo+Ss0+WFuScg7Z6YmsTfIr48SMz04gErGcSCATFnCBtxSIxuKMsDSgR8ZYiBlNFMYryBkKb
 40PE7VZ9ZgQ7GTpF06t1BIMDuk8LA/Wq44V6XRAhk2XTM/cavfX57vadLlSZxZo7+HmCNjXlO
 VpZ+7kz/tM6+rPsLsK4oyYu0jgQZY7PObEpYSbuJyIoEAxiStUE9TcS0jG54JlaLyqhh+NC/4
 L8KLsFYdMJJG5qZKbIHR6bd6iEg3DeFg72DeGAQihbp/b6lnmk7TCNZt8u5AgVqz8jgqipBeQ
 oLgN77jlBeR+a3CnGGXs1+W3/t6qbTtgUa3+HPq2vId4J7mu5MLS6SRslxef1lDLrx+ezMLq8
 noJmqBmrdhApwaqZPagPwgnwtHpdijpH+CQPjgypUA2PCQeJc5dzT1vxwjI4xuoMAoeKbpITU
 TiWBrg69WGfrLq9Zwqli+AX0Nq5yDVquI9EkpJPw1DTzQaoHnpimq7/A21ur48sLAlgPW9ix9
 3Dcu+hJ77534PNQaZLFmhpLeQfu5n8uXxk+aICRVMx1eMJmI7Ad4WOOMvJx8caB5RXHp2VLgo
 yA9Qgt0dhgP/JvE/Qm6T96YHxEN20MZhp+OZYZDNdyElTD/GkthosW4M2NZUV+X0GECYRndxZ
 lLyXkZunnaaY65A2a4FC/0vPOvE6mVKvRs9bV5tvkqUNSrhfRJ2/DnpMVsqm4hsy/p7J/xFWw
 /cBSgsmrTCi9a8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=2D--

v2:
- Add Fixes and R-b tags
- Change sentinel element a bit
=2D--
 drivers/clk/loongson1/clk-loongson1c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson=
1/clk-loongson1c.c
index 703f87622cf5f..a6f9f20fc8b99 100644
=2D-- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] =3D {
 	[1] =3D { .val =3D 1, .div =3D 4 },
 	[2] =3D { .val =3D 2, .div =3D 3 },
 	[3] =3D { .val =3D 3, .div =3D 3 },
+	[4] =3D { /* sentinel */ },
 };

 void __init ls1x_clk_init(void)
=2D-
2.34.1

