Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96184573A91
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237043AbiGMPui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiGMPue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:50:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5066B4D81C;
        Wed, 13 Jul 2022 08:50:32 -0700 (PDT)
Received: from localhost.localdomain ([37.4.249.155]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M89bP-1oFnUL1MeJ-005Fsj; Wed, 13 Jul 2022 17:50:14 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/3] clk: bcm: rpi: Fixes and improvement
Date:   Wed, 13 Jul 2022 17:49:50 +0200
Message-Id: <20220713154953.3336-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U7LzYBEodTQwQ97iL5wt+8u8EdPOd8vAm98AjNairZGfm4w1nrW
 QPXWQf8ltYdeTPRyu221L7RIWb13qsyenrlrEryiwbX76/uXtNcMlhZzpLAGZq9aifROF/3
 mmpWRYND215PlgMSHEbSNQi1ANz6/kBjFN/J1BxCAbrLR8wwbKRxAGa1yFVb2KmgNVA9gEn
 2BgQ5L/w091AbZwSJBeEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zEb1+peqi5Y=:a6yZyaXV9oNwjUPGdm+G4H
 W7qsVLhBgeR5Fn3Md5vXXCPpNQRowNNTgGzjGKf4O4T+lXCMEk3u6cYrpFulBsa4gdrVrAFu5
 kvXfrg8lhN3eFoiAgioYUxH2DsBFLQVmOztrulnnrz0EC2PIja0PYLVpjJ8e/PjA0CSgaY8bz
 j5XmcK/VQy+zU9IZ9lBtaipBfazyWYkQlQIbcqinwO4O6W7SubHRbLtBBKWzDLIHlEWv3Jzgq
 xSUWzHAVDrAYpSh+9zhRF/xXyTwfRYCly2tG23ggKbMZ2GvUrHSssSPfsruHALgnw6tTwK+9a
 LbB0WvrJGVgCJMPR2xTOSx06j0cCwfQ5PLO0+StfJNtyGE8XYCawHS6GJZoMpa5glJGltlg5f
 bt+FPsJXz1b9w+8vC/ZPyf9FcDSKndDrXzYZ6fryG357gPqTO+MgMyYobQLD30xfyCp107Rs8
 pluyx++UX0+/DVIEWHeH+DGJ2vXZwvry4lQgns8DRuF5TAQLon0lE+nJSDmmViDK9CwcMmNz1
 +J279EoJtss9PpaFcCJ0YTG8GudB3i0M2j78+BjwVx2kY78gy9uCWWFeiIICgclORRk/CQsj2
 FJMY+9hetPWOlsn8TDXjxvmYr29M3sAo3DR8LdqBlEfFgee1CTslZATYxRBmfFsn6kvdKdqAf
 y3iYNKRiKZEhMO2prXtCMlts9wfR9L69Pn9IImBlrL6sI77yY/aWtA/RmncFmm9rS2tztEQ6d
 sKlyMaRn0pXrSBduBnhF/WisldWoO1v9fbYxb3e8NyjjM+2J9ozTTJqmjRM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to fix and improvement the Raspberry Pi firmware clock
driver. This mostly focus on clock discovery mechanism.

Just a note patch #3 depends on patch #2.

Stefan Wahren (3):
  clk: bcm: rpi: Prevent out-of-bounds access
  clk: bcm: rpi: Add missing newline
  clk: bcm: rpi: Show clock id limit in error case

 drivers/clk/bcm/clk-raspberrypi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.25.1

