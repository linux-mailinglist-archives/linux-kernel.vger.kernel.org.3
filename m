Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B203536EFB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 02:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiE2Arc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 20:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiE2ArZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 20:47:25 -0400
Received: from p-impout003.msg.pkvw.co.charter.net (p-impout003aa.msg.pkvw.co.charter.net [47.43.26.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FB136B75
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 17:47:24 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id v75WnJjj4R0wIv75XnCgk9; Sun, 29 May 2022 00:47:23 +0000
X-Authority-Analysis: v=2.4 cv=FYAkeby6 c=1 sm=1 tr=0 ts=6292c29b
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17
 a=IkcTkHD0fZMA:10 a=yQdBAQUQAAAA:8 a=JKArFDfnAAAA:8 a=trFUbqFmGWvzTRzaABQA:9
 a=QEXdDO2ut3YA:10 a=SzazLyfi1tnkUD6oumHU:22 a=8HTcXXoeXT8DLsUt73VG:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 1/2] staging: r8188eu: Fix warning of array overflow in ioctl_linux.c
Date:   Sat, 28 May 2022 19:47:10 -0500
Message-Id: <20220529004711.27545-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220529004711.27545-1-Larry.Finger@lwfinger.net>
References: <20220529004711.27545-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNJmB+gcPpnZ8Dr4CUPFbiyGhAvY0LuZZesniX76hpu730ddl8S602W6MZVfRKfTL8ZaBPbXf3lslB14IbqACkFYxzHDdjydHeVonXBuTQYP2BVklI0C
 7dSGdPvsV8vU//rHyUbn8mbynLYQSxNHM6nK5Ugj3TxsX6wRvlCY2PM17cH10WmuRyIdesdkW1G52R4R9n2zLMjhPSnSRbv81gTV1BYy5sfNHirnk1GQuCbJ
 tMlsk/cOwqSSbDwjSpzpIzKkN2CkUXtVMAMJsS+3IYu65dqAHG38OO19/BXTaHaTfuQcWMHI1aTv3FwIfqmN6892ZC1gTJgNUktUZ5fTuFAVOhYq7MCY0bzM
 5xbqz0V5UpXkLMMFbrPClchndm0JzDZtnjTH7aMX/dimAL5xdk36pGlskV2Vvm42e/Mw1lGD
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with -Warray-bounds results in the following warning plus others
related to the same problem:

CC [M]  drivers/staging/r8188eu/os_dep/ioctl_linux.o
In function ‘wpa_set_encryption’,
    inlined from ‘rtw_wx_set_enc_ext’ at drivers/staging/r8188eu/os_dep/ioctl_linux.c:1868:9:
drivers/staging/r8188eu/os_dep/ioctl_linux.c:412:41: warning: array subscript ‘struct ndis_802_11_wep[0]’ is partly outside array bounds of ‘void[25]’ [-Warray-bounds]
  412 |                         pwep->KeyLength = wep_key_len;
      |                         ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
In file included from drivers/staging/r8188eu/os_dep/../include/osdep_service.h:19,
                 from drivers/staging/r8188eu/os_dep/ioctl_linux.c:4:
In function ‘kmalloc’,
    inlined from ‘kzalloc’ at ./include/linux/slab.h:733:9,
    inlined from ‘wpa_set_encryption’ at drivers/staging/r8188eu/os_dep/ioctl_linux.c:408:11,
    inlined from ‘rtw_wx_set_enc_ext’ at drivers/staging/r8188eu/os_dep/ioctl_linux.c:1868:9:
./include/linux/slab.h:605:16: note: object of size [17, 25] allocated by ‘__kmalloc’
  605 |         return __kmalloc(size, flags);
      |                ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/slab.h:600:24: note: object of size [17, 25] allocated by ‘kmem_cache_alloc_trace’
  600 |                 return kmem_cache_alloc_trace(
      |                        ^~~~~~~~~~~~~~~~~~~~~~~
  601 |                                 kmalloc_caches[kmalloc_type(flags)][index],
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  602 |                                 flags, size);
      |                                 ~~~~~~~~~~~~

Although it is unlikely that anyone is still using WEP encryption, the
size of the allocation needs to be increased just in case.

Fixes commit 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")

Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Phillip Potter <phil@philpotter.co.uk>
---
v2 - Get To and Cc right
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index eb9375b0c660..ce3dcfc812e9 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -404,7 +404,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
+			wep_total_len = wep_key_len + sizeof(*pwep);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep)
 				goto exit;
-- 
2.36.1

