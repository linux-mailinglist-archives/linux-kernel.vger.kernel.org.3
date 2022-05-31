Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504F15389A0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbiEaBbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243394AbiEaBbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:31:41 -0400
Received: from p-impout004.msg.pkvw.co.charter.net (p-impout004aa.msg.pkvw.co.charter.net [47.43.26.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39553DF5C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:31:39 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com.com ([24.31.246.181])
        by cmsmtp with ESMTP
        id vqjLnnv0kgPEBvqjSnJB4O; Tue, 31 May 2022 01:31:39 +0000
X-Authority-Analysis: v=2.4 cv=b8OhX/Kx c=1 sm=1 tr=0 ts=62956ffb
 a=cAe/7qmlxnd6JlJqP68I9A==:117 a=cAe/7qmlxnd6JlJqP68I9A==:17
 a=IkcTkHD0fZMA:10 a=yQdBAQUQAAAA:8 a=JKArFDfnAAAA:8 a=yPCof4ZbAAAA:8
 a=trFUbqFmGWvzTRzaABQA:9 a=QEXdDO2ut3YA:10 a=SzazLyfi1tnkUD6oumHU:22
 a=8HTcXXoeXT8DLsUt73VG:22
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 2/2] staging: r8188eu: Fix warning of array overflow in ioctl_linux.c
Date:   Mon, 30 May 2022 20:31:03 -0500
Message-Id: <20220531013103.2175-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531013103.2175-1-Larry.Finger@lwfinger.net>
References: <20220531013103.2175-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHjbCQQ0ilhvUMTInvLkcBR7pz0MsdzmJXh1BoA+6zbxacd/1ou6F06evJku56zwHtSobOO6nNxCwFmZ+TLIYJJ6DGx0YVFo+Aeyt2zBJkP2ZrqxOHH8
 RCGO7L2GpTm9gJSZ90lPPUkCKGAWr5FDGRAzC3pgfd+C5Ll4RaKXFouIbfaMCXLFg4Oh7/d/7XI3SiHJsj6j4BBAXk1vdrRM4zkn6pOcbSiYAwOaH8nx/H8W
 bHzFJlbsmK/cdzRmPWA6qdyrKKc2MrY/bxjRWCalgtJlvcwf+CCJcMS++B9RB4Fwxx1f4FsOpkeR8/ESCtj9JS9LicD5OoJcqN441srWnSj5OdYkHH17BXcJ
 M4jNLHD7cOIwnDmBRC6J87twXoILuPmfiBh7SxcEghBFluVQnzl7XNm5xTAoI4YUc7kwWFTM+l6iVi/tVQf9Vt/KYIU3P7eGYYz4SN3/uRfctRoinnA=
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
Cc: Phillip Potter <phil@philpotter.co.uk>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
v2 - get proper To and Cc
v3 - no changes
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 1b09462ca908..8dd280e2739a 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -403,7 +403,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
-			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
+			wep_total_len = wep_key_len + sizeof(*pwep);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
 			if (!pwep)
 				goto exit;
-- 
2.36.1

