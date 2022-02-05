Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E014AA82D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379809AbiBEKhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:37:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:39983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379768AbiBEKhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057402;
        bh=QROgHSfb3iMEjYa0kRt/e/0z4UVT4OJ4cUBSHkYo0N0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PX5U8pguYOWJhMOMJGyjROg29isAPINrgR0lPeVp/u3k1kD3uP6cYdovKzzyFuZVp
         IaiupbIkaP1ER7aSCfUnT2J19CH74RuneK9XfoRiPQT472Y7TSqrqPMlOtgI6vhlNu
         l+GBarsffXSy9PTGqBUCQ2+I5+5jurN4Q6G8BmMg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIwz4-1mvsxv3sIk-00KPLQ; Sat, 05
 Feb 2022 11:36:42 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v2 4/7] clk: hisilicon: Remove unnecessary cast of mux table to u32 *
Date:   Sat,  5 Feb 2022 11:36:10 +0100
Message-Id: <20220205103613.1216218-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C9ZnEZNM5TEevGBylOfbKYocqhZUTP047OiXTMGozjVJqSDGs6t
 TWdKaDaSg80azhRbojL2OsM61Mlkg2Yh9nHrbF328/ZPVHR4Ow65STx4q5nhLXZxHHrbFvr
 tBPikfsWbrGBEdf8UMA/ckIjlqN3PsQj2PRp9DFHjhXsHKKVXqhPuy6K+HIrtY52ZTq4ZWJ
 78WopYd5OYof47uloKbMQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bICYtb9YPuo=:Tm0/e2XfYu3hqg1eOOZ5YL
 44UGOUbQQczOndFYJhitFgE7iNUweR9JqluTEO9KB+uLddic5cz2o3gFTr+pnCokCps5xjvH4
 qbuDru7JLPfACSEnv4Q/krsyjCjZyhKCujChaZ1BYdHxMBLhD1vxgfYQLApDVFHqrB81zjxj7
 WHBVhkFkE8Z18YRk7EmBQpDGzR1DG337ALNJJG/ct1ISMQAi5F1JYhHb7jy5Z15zG1+rfwCWz
 culH5GvPazHFIWy0TKIl8PgqF5fxevelcuIBheM/N9J0fTLXxYuADN8YYMfZ5XN+unP24ySHM
 a3u6pcObYR+T9SPqYDYOvsKdSm2LOqC7yuH68H/qs5JYW2k7vRHpDhMDwuWhkgQVRJq/oS//H
 6yf2aGEHk3UZxs3+mV0r2PKGg7GWf3+AFdxU6bnfitKZv4dDoUOAZkuAj+B0hy0DxLbGGLkKI
 LsH90RAoXDJYGeaHqS41693l4DIxjyWt2LZgiSMikG3zmK3hvtRFKEMXdPv8DqJbA95bFaMx0
 cSLde8828clCDxihP03gTjDPnoCxJMAK4ht7WIQ/1wABbVD9Q2IZAx1km4LrqmTBRQHVlu3vA
 yrEQ+w3mkY2Us9O+tC0t3gN01kzJUFYAWJ4zoDKS11p5jjdEqkRnBCSGVJ2BFdhpgWjA4tnFm
 rUHta6HqsMrBLfvMeou5VtwvHCjhCIIbQh89GloGJ6ubnP+Qex0Eg39HLLb7XNoBV+I0RQtu4
 OB2Ui1ZjUeu9wYjPL+x4MOwOtFapCFtyNO+8KhXn4m8RTAWjcpw0PaJFMbqDMNbQdBuuKpXTc
 ZQ52nFM3aHdbtaq+7sR+UtoL6leaoYsPDa1+5Yi7zNoDeU3Bff9baWTV6zPVufanJovedYEfX
 qFBbLDbtyWQvPxpVF+4zB43VvMW8fmN3xJS+SaYg90DBcY9iI9m2CZKGXDvsInV9CJh6+rP+t
 m/ZTX9D7sKSFzjCpFs91DN5SKz8ygU90THk3WERzNz/xGm2/vQGle8V17kU2p1JqZNNRV70XV
 DycXrO2yYrhHaxSDROlPE5xOkARB0wynmKgmE6xKVCfZ4Pt19YYnHfjPHNugjhm3kOsQgQ38t
 e9MPkpraj87RW4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we don't need the
cast anymore.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes
=2D--
 drivers/clk/hisilicon/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 9361fba7cd4cf..54d9fdc935990 100644
=2D-- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -162,7 +162,7 @@ int hisi_clk_register_mux(const struct hisi_mux_clock =
*clks,
 					clks[i].num_parents, clks[i].flags,
 					base + clks[i].offset, clks[i].shift,
 					mask, clks[i].mux_flags,
-					(u32 *)clks[i].table, &hisi_clk_lock);
+					clks[i].table, &hisi_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
=2D-
2.34.1

