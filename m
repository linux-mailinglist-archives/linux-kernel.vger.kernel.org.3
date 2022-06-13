Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2C548E94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382073AbiFMOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381694AbiFMOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:09:05 -0400
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 04:41:41 PDT
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187C98756
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 04:41:36 -0700 (PDT)
Received: from mxde.zte.com.cn (unknown [10.35.8.64])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4LM8YB6YRzzK82
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:31:58 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4LM8Xw3xyrzCFQtW
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:31:44 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4LM8Xr2XYTz9tyD7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:31:40 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4LM8Xn00hWz5BNS0;
        Mon, 13 Jun 2022 19:31:36 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 25DBVWvv001928;
        Mon, 13 Jun 2022 19:31:32 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-cloudhost8.zte.com.cn (unknown [10.234.72.110])
        by smtp (Zmail) with SMTP;
        Mon, 13 Jun 2022 19:31:32 +0800
X-Zmail-TransId: 3e8162a7201401b-f9e61
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn
Subject: [PATCH] bitmap: fix a unproper remap when mpol_rebind_nodemask()
Date:   Mon, 13 Jun 2022 19:29:37 +0800
Message-Id: <20220613112937.65428-1-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 2.33.0.rc0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 25DBVWvv001928
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 62A7202D.000 by FangMail milter!
X-FangMail-Envelope: 1655119919/4LM8YB6YRzzK82/62A7202D.000/10.35.8.64/[10.35.8.64]/mxde.zte.com.cn/<wang.yi59@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 62A7202D.000/4LM8YB6YRzzK82
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider one situation:

The app have two vmas which mbind() to node 1 and node3 respectively,
and its cpuset.mems is 0-3, now set its cpuset.mems to 1,3, according
to current bitmap_remap(), we got:

    1 => 3
    3 => 3

This maybe confused because node 1,3 have already in the new settiing
region but both nodes are binded to the same node 3 now.

Actually we found the situation on a very old libvirt and qemu, but
this can be easily reproduced in the current kernel, so we try to fix
it.

A possible fix way is to ignore the bits in @src have already existed
in @new.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 lib/bitmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index b18e31ea6e66..b77bf1b3852e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1006,8 +1006,8 @@ unsigned int bitmap_ord_to_pos(const unsigned long *buf, unsigned int ord, unsig
  * @dst point to the same location, then this routine copies @src
  * to @dst.
  *
- * The positions of unset bits in @old are mapped to themselves
- * (the identify map).
+ * The positions of unset bits in @old or bits in @src have already
+ * existed in @new are mapped to themselves (the identify map).
  *
  * Apply the above specified mapping to @src, placing the result in
  * @dst, clearing any bits previously set in @dst.
@@ -1033,7 +1033,7 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
 	for_each_set_bit(oldbit, src, nbits) {
 		int n = bitmap_pos_to_ord(old, oldbit, nbits);
 
-		if (n < 0 || w == 0)
+		if (n < 0 || w == 0 || test_bit(oldbit, new))
 			set_bit(oldbit, dst);	/* identity map */
 		else
 			set_bit(bitmap_ord_to_pos(new, n % w, nbits), dst);
-- 
2.33.0.rc0.dirty
