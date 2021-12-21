Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF84447C4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbhLURPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:15:52 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:54860 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240244AbhLURPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:15:51 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104254125"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 02:15:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7721B40B8DE5;
        Wed, 22 Dec 2021 02:15:49 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] usb: renesas_usbhs: Fix unused variable warning
Date:   Tue, 21 Dec 2021 17:15:32 +0000
Message-Id: <20211221171532.29881-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the below warning:

drivers/usb/renesas_usbhs/mod.c: In function 'usbhs_status_get_each_irq':
drivers/usb/renesas_usbhs/mod.c:195:13: warning: variable 'intenb0'
set but not used [-Wunused-but-set-variable]
  195 |         u16 intenb0, intenb1;
      |

Fixes: 33e4245ee919 ("usb: renesas_usbhs: Use platform_get_irq() to get the interrupt")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/mod.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
index f2ea3e1412d2..3919e350b487 100644
--- a/drivers/usb/renesas_usbhs/mod.c
+++ b/drivers/usb/renesas_usbhs/mod.c
@@ -192,13 +192,12 @@ static int usbhs_status_get_each_irq(struct usbhs_priv *priv,
 				     struct usbhs_irq_state *state)
 {
 	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
-	u16 intenb0, intenb1;
 	unsigned long flags;
+	u16 intenb1;
 
 	/********************  spin lock ********************/
 	usbhs_lock(priv, flags);
 	state->intsts0 = usbhs_read(priv, INTSTS0);
-	intenb0 = usbhs_read(priv, INTENB0);
 
 	if (usbhs_mod_is_host(priv)) {
 		state->intsts1 = usbhs_read(priv, INTSTS1);
-- 
2.17.1

