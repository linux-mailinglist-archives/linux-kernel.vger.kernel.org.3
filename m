Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68EE4AA526
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378760AbiBEAwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:52:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:57599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350118AbiBEAwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644022354;
        bh=wIyL4al0PsasGkNaS8/JAuA3QXn07ABIpg5+HKjlwG8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HsPdQi53TXygor8N6Zr0DctwaMhOCff5ecNGaa2AGIy0X8cVTGt/jGCjpm55VMvZq
         97MlTclckxjK2Q7w0uXbpg5w1Gwg2ZMtQF1NQEmp30Uc5yuNUItf84cqJXj1I18Xqp
         19MljIiPVkm/66eHYRkQhSM/ZmNHcmrq1ZO0VNVM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1mZwwF21yT-00gDkq; Sat, 05
 Feb 2022 01:52:34 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v3 0/4] clk drivers: Terminate clk_div_table with sentinel element
Date:   Sat,  5 Feb 2022 01:52:27 +0100
Message-Id: <20220205005232.772726-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9fScLoBVc1AvLdfroCYbMuG7hAIm23Ktivf4fb2VHwt7qUq1wyV
 P4dVNaVo9hIYZEQm3v3mss2zcKs3XWI/sByMqVsVW42UqnOtT1HIi2vqenx83jMtWPuGcSO
 3DBZKVA2PXS32WtKsAIeqc2/1RdwXo4MMAq1+VDAgCA8P01J3LVSWLbPzRcFZqJGtQfqeDJ
 IgwRZNK5uj+m+s9ONX9Pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GQhVJHbvBWs=:y8CEHFw88CMRjBonKpNunl
 5QlhswsQJR62sWLovD6jKAae6xuBssjfp7SoyYzd/syfutCafTKyQGzKukJalzPNu/Csz6Dxa
 sF2AhHmsJ7HyOsHxVpKziBrZRTNrtInytUOxIn5exNWzyZ18rsXMBdTm+W6QyYy2uAHW83LFV
 pnPBc7L//C4bgYXn5Q/fUl60TomVlYvqmaQNYCUH0KAw3GRbZ1XPjCfdd0Joz3PZddyLx62cr
 u463ylXLs8U6dOLeb1+CisH4DhSeMpXkwwv/BqFw68tcgqPh83LlRkvi+W4+wEOmfxDuLrR7X
 67PP/2iyary1EqLDQhEe19Fth7trhza+D+T/lvIhdhqcslmS+TTiGqB06Q6ZTEMBw9X4jSKmC
 Jc4bUvQpADIRbraENQAE9AXftB6+FH9Os2DlSb7CLDarlstP5qdP2+auTMBjvjiN145+HtVdW
 kq7/04layKpDNBpm5qjDc7+GAHHiJtoQYEioU/jGj7UFqvvGpTuENvnuU2uNjcuXPBYiTUM2z
 zRVZzpQ25OBMS8fhiX3SdF6LKbJha2q9E2QGN+aZxBDHUz6DC16Z67piHK0QDE5jcPRRSnOg7
 TmNLwJSXzNVP5OgbM1vlKDi1vJ7mzWB1uYJLbLYdNo1V34F7TLaey2noVTj1zDT54px9niX35
 /zkQpYXou8z45Qk3KccjnmfupMF8T6Hb2r2/6y2tfOeMLbz7WNI2kP2a/aZ6CSGYpC/R5RIUp
 Wfpb4jzRXjmDgXrQqt54ecurpyMDRZOENEC7VeeDHcxASEH0LgkTQA8pDJsAD3y6JI0FbCKb1
 eDI8PjzIlc8f3JpE3HI0DxMsFHhqR7wFaPg3EQqwN8bDRR7tpO9bHRLoUVkTjEKGbrctD2DJT
 vsR4yDQv1W7eQY+4fY4J1ylRwFlBeBMx6r7rWBqaFf9WgTzv9HnZW7R6MsrYUruZVl9S8Vsce
 Jib0wfCUd0DW80O3nviVppC3Q/vZELdZzZsIyo6yjD2lqfTUW/s+4ipmb8OeAdbrezJfOBaa6
 V58nIFyYc5swbflC/yfDlq6yR7e0K+RRjlezM5xymiQLPBP1DzhnKlEKkuI8vYUuVO3tYq3g6
 S6dNKiD1ZTFk10=
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

v3:
- Change the Actions patch according to Mani's comment

v2:
- Add Fixes tags

Jonathan Neusch=C3=A4fer (4):
  clk: actions: Terminate clk_div_table with sentinel element
  clk: loongson1: Terminate clk_div_table with sentinel element
  clk: hisilicon: Terminate clk_div_table with sentinel element
  clk: clps711x: Terminate clk_div_table with sentinel element

 drivers/clk/actions/owl-s700.c         | 1 +
 drivers/clk/actions/owl-s900.c         | 2 +-
 drivers/clk/clk-clps711x.c             | 2 ++
 drivers/clk/hisilicon/clk-hi3559a.c    | 4 ++--
 drivers/clk/loongson1/clk-loongson1c.c | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

=2D-
2.34.1

