Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED74A861B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351121AbiBCOWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:22:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:56763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbiBCOWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643898119;
        bh=Q95YJP28mZgGg0t6civvU1EikTl0r744xu1IfdZHCAk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WqXepv0zrGYmITAccrZjDkqgoJyAwM0+smZ7JTAXMLsV/UeyPl5kBjOM8Wkryjnmf
         fRS9XIqFmWzY7J0+bY3DH9QdW6nUeY+kv9EyxK0CcSFIomUE7+Mu1/EwW3IXWX2p7B
         JMM0qmSxt4s4ztFttQCxavuDcNIwYwHoEXRnNUVA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5vc-1mtZuI3iBE-00M4Sr; Thu, 03
 Feb 2022 15:21:58 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v2 0/4] clk drivers: Terminate clk_div_table with sentinel element
Date:   Thu,  3 Feb 2022 15:21:49 +0100
Message-Id: <20220203142153.260720-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eH8qSdx3Bc59VEMHMpcwL0XOkQsD6fTF5VZ1W4SPuu0K5tdnCbH
 wzXVCXZwq1kE3p8NZ/7alwh0B1MvhS2YTAuJpuMkG08r7oUDlqpuGfWCmGpFkDb69ifwwdB
 FMK+60d/o5+qRWy/ykLMbMgJDV7Xcw6x0UfpwrcER82yIZy9LbE9IHLxyJdVqCE+rpV6NoS
 p1wHA/586wfaNkh+1U7Rw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+X7+i/f8X0=:h+UCp6V0x1YQB0pMr304Y3
 DHgvKps8sqDViEf0mXs9C/1mODKHujVvgbzhnK8qSSPDZc2cE7XcPH7wM0nDk6RVAO9QYyC1O
 Yh6/k1OWuvQC/mpo2KqTlHTkCuXABYaBUBnGivPYEmKRwybIiy81OZK3GRsq9OSxaqXeOOon5
 cjelSzktJeMP8vCGs4ae0cROnm7t67xqo51qxudWVRM1BxUovymG+tIR7+Ad8iT7OwIcU4HYJ
 ihLOfGb53t5mX/6TBr+Ds3c3zG7ysYsVRNtGugjsYtSEdQgWlRAvE5mOnZPRB1AYfTk7abT66
 zNrrQe6gX+5A9T7q1wOuHCrbyxlBU9Q2k8w0dH46LPz3aj9aZTUKFMdLSIOHvx28i2YOGyX81
 /syqe7Aop70Rd8OcDulX6h51Ihr+scUK9PXHfOUbytns+m8KHn6sn2iPwLt/Ah6FG1tvib7ch
 XRGMI6ll9Q2rdmExzOxxzssFco04yl1lvN+8EaX1e950J795WmqIHMPpdFwJptxeQqyq76cCn
 Of6llqQ4xY6zlKtt82QOP7EygfQF+67GJWHBhPyxs0VgKH4QeVssvju+4Hw4p2MhuapvbObpg
 WapRuuUr/PifSJQGF6vGCqxLwKek3mCJ2otadiPMP3x5GUPlReLulB4LWV2zCZpsiYBkPxSsK
 K7bh1yHyadMDUA1XL8JQ+D/eipI/yEdMVqL4OJ3SJdJj5w9N8SXGiuRuEIVbgqO/Z8Cf3v+9U
 LWT8fAHhMcc3eeWSJy4yLnv4VzeX+rOFj3TgJQj8j5LKbkX1FeT+FQAf+HiBMEdhZW2VR7pW4
 TyqJxvloxQHExsc9G4Hp+ljXsZZhpHfSkBhxhBWkvSVwY0tc+l3FUrkGVMp0eojtaciqxHrMh
 giWR/+RrylQKk/8esSHWLR2tmCvL9U0MoclUv4ncB+Mxtv1Mh4EDEehcgRUFgKuFgvIxMsE7q
 VROeuiNHvy6bLJLUC90K4WL4+dd6rco7Yf2Q/EZyoRKxoHYhoJHtuELw065Ryad5NX0/H87WT
 AFbXYrzm6gtpFUK2kcjP0SzER1cuYHInvd9Q9p903npTIknU57yVGU7aY+o1+eGiVSuGyW8SI
 815b535q3a30tk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that some of the clk_div_tables in different drivers are not
terminated with a sentinel element. This may cause the code in
clk-divider.c to read garbage that happens to be beyond the end.

This patchset fixed all instances of this bug that I could find, except
for a case in drivers/phy/ti/phy-j721e-wiz.c that is already fixed in
linux-next:
  https://lore.kernel.org/lkml/20220117110108.4117-1-kishon@ti.com/

v2:
- Add Fixes tags

Jonathan Neusch=C3=A4fer (4):
  clk: actions: Terminate clk_div_table with sentinel element
  clk: loongson1: Terminate clk_div_table with sentinel element
  clk: hisilicon: Terminate clk_div_table with sentinel element
  clk: clps711x: Terminate clk_div_table with sentinel element

 drivers/clk/actions/owl-s700.c         | 1 +
 drivers/clk/actions/owl-s900.c         | 4 ++--
 drivers/clk/clk-clps711x.c             | 2 ++
 drivers/clk/hisilicon/clk-hi3559a.c    | 4 ++--
 drivers/clk/loongson1/clk-loongson1c.c | 1 +
 5 files changed, 8 insertions(+), 4 deletions(-)

=2D-
2.34.1

