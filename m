Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F2536E8E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiE1VQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiE1VQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:16:55 -0400
Received: from p-impout004.msg.pkvw.co.charter.net (p-impout004aa.msg.pkvw.co.charter.net [47.43.26.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83DDBC1D
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:16:54 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id v3mLnd6IdgPEBv3mNnEtss; Sat, 28 May 2022 21:15:24 +0000
X-Authority-Analysis: v=2.4 cv=b8OhX/Kx c=1 sm=1 tr=0 ts=629290ec
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17
 a=IkcTkHD0fZMA:10 a=yQdBAQUQAAAA:8 a=ag1SF4gXAAAA:8 a=trFUbqFmGWvzTRzaABQA:9
 a=QEXdDO2ut3YA:10 a=SzazLyfi1tnkUD6oumHU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] staging: r8188eu: Fix warning of array overflow in ioctl_linux.c
Date:   Sat, 28 May 2022 16:14:51 -0500
Message-Id: <20220528211452.32134-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220528211452.32134-1-Larry.Finger@lwfinger.net>
References: <20220528211452.32134-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEjnjlCsUNQ/npLE95r0nZ9hwCv3p+ErZWc3AUtLno9KIFC3X2gscqkS9TaZX4GXD521d2Af1oG1OrDhJVUmGCuvC+I1cHD9dP3x2Lle4S3GAusxjlWq
 mx7PAc+mEjXFxUJ/TWXj0EAaP6S5lPFVUUNtEeUCw0//ThpL34L7klFwB1+FcUcwReJ451VTSbOcTS62BiDQ7tuhopxLPwS8vY4McsqSJffTh1BNQDgCd5+e
 JyBlnGutjb3ivvyu7OD5Kkwpm3Km2LBN37j6Pj+PUzjJ9CD6G/siDJ0f94R02/VB6WUZi8YCfVvZUberTacO1H6V0dct7kEdVIHSyGCRp/3q3ytdTf1TBq2d
 lSLa1d+zzvf+CenM97fyrLS5yE8u8gbeq3wXqPwvhfbuOBHey+o=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

