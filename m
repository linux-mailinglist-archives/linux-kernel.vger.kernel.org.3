Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F71C536E90
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiE1VRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiE1VRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:17:00 -0400
Received: from p-impout004.msg.pkvw.co.charter.net (p-impout004aa.msg.pkvw.co.charter.net [47.43.26.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD34BC22
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:16:58 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id v3mLnd6IdgPEBv3mRnEttK; Sat, 28 May 2022 21:15:27 +0000
X-Authority-Analysis: v=2.4 cv=b8OhX/Kx c=1 sm=1 tr=0 ts=629290ef
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17
 a=IkcTkHD0fZMA:10 a=yQdBAQUQAAAA:8 a=ag1SF4gXAAAA:8 a=VTP6l_gzy7p3D2MEsWYA:9
 a=QEXdDO2ut3YA:10 a=SzazLyfi1tnkUD6oumHU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] staging: r8188eu: Fix undersized array in rtw_xmit.c
Date:   Sat, 28 May 2022 16:14:52 -0500
Message-Id: <20220528211452.32134-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220528211452.32134-1-Larry.Finger@lwfinger.net>
References: <20220528211452.32134-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCKOQQzV5sOO9cpih/JLzLJJTp15WGk9mISv+QgUqDYfcYI/tir+unI3M3xTKrn+NhGSR1B9rx2jBSbsr5NgAKU3m8jLxlCQOEMRkdVBjajeSaGfIyUD
 uxTCXA2QXgFpHviPswnrPca6aoa05TOG4Pjaa15BmU0Ut16Q0FSW6O24GRVm8bFJ3JgYBx7iVlaCGhmDKIP4e23ftSK/vBS8D6sbicjAdYIFirRVkINPxBoP
 oyP2Q31ravRqgLCYTZ9k3/wsDQ/W4Jd1WVDc6y8rW40BhngY+5TxiDOeAgLuzzujeRnq9pJDvWnLjZVzTtKCNGMi1o+4i4sUtmDIjVEGYqz+E9yLsHYFBVFS
 yHWhZELH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with -warray-bounds yields the following warning:

drivers/staging/r8188eu/core/rtw_xmit.c: In function ‘rtw_alloc_hwxmits’:
drivers/staging/r8188eu/core/rtw_xmit.c:1493:24: warning: array subscript 4 is outside array bounds of ‘void[64]’ [-Warray-bounds]
 1493 |                 hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
      |                 ~~~~~~~^~~
In file included from drivers/staging/r8188eu/core/../include/osdep_service.h:19,
                 from drivers/staging/r8188eu/core/rtw_xmit.c:6:
In function ‘kmalloc’,
    inlined from ‘kzalloc’ at ./include/linux/slab.h:733:9,
    inlined from ‘rtw_alloc_hwxmits’ at drivers/staging/r8188eu/core/rtw_xmit.c:1484:23:
./include/linux/slab.h:600:24: note: at offset 64 into object of size 64 allocated by ‘kmem_cache_alloc_trace’
  600 |                 return kmem_cache_alloc_trace(
      |                        ^~~~~~~~~~~~~~~~~~~~~~~
  601 |                                 kmalloc_caches[kmalloc_type(flags)][index],
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  602 |                                 flags, size);
      |

This warning arises because macro HWXMIT_ENTRY is too small.

Fixes commit 7884fc0a1473 ("staging: r8188eu: introduce new include dir
for RTL8188eu driver")

Fixes: 7884fc0a1473 ("staging: r8188eu: introduce new include dir for RTL8188eu driver")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/r8188eu/include/rtw_xmit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index b2df1480d66b..27fa536f51ee 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -69,7 +69,7 @@ do {							\
 	dot11txpn.val = dot11txpn.val == 0xffffffffffffULL ? 0 : (dot11txpn.val+1);\
 } while (0)
 
-#define HWXMIT_ENTRY	4
+#define HWXMIT_ENTRY	5
 
 #define TXDESC_SIZE 32
 
-- 
2.36.1

