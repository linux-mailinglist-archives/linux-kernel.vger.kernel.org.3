Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA44CD26D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbiCDKbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234383AbiCDKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:31:44 -0500
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7169716BFAC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646389850;
        bh=lWyaumg3DAV6K6mwQJGodMoZXgiEDM6A7q29hCzQNEM=;
        h=From:To:Cc:Subject:Date;
        b=ZxzzA7kk36YTYHZb6KJqWR4mfTA7eV2ol13wKwIKW9cW6/jb7ww+qIVdlHfFMxkMB
         rWTwb+NdPwNVAlZeURtx9r07l5Kautyv6Zdr6Seyw+QuQ2GZ1KsKykNffIu3fycCYc
         ds7eM5+fpJ80tnodLyI7DHouFenvykSt+ZGY9KUw=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id 7AF34219; Fri, 04 Mar 2022 18:30:47 +0800
X-QQ-mid: xmsmtpt1646389847tppgzcpa0
Message-ID: <tencent_5585FF0A904C66C5DC1D8E120AC0F0002507@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIe9JbE8Y6zN8gmAhbqYsL8XRbKtldCSvGqt/3CKmVFBJ9ln5uZzs
         Yi+pXIZ6FswivyrvBbAxbTXGiMBY+ReqstIi1N8etvOmUAOuaTbPzcb/gCdod+tI28/osT+GXToa
         5uzUnwU8RGUwSNS+w7O+V/UPOzmSeMEEZJJ3KPCFnC0xOjZFZjtknX6mk4zwJ4hteofgg9sGDCCS
         +ukl6JoWDID8nwQlN86TPuHQVQ2cZeD9SyUKXyhU51KHjeexKxwB8LaZOrDY6c98WIYwNlS2OjeU
         gI26ew9ON5tTnACbAUs1Fi8Yn5/TRqDFqCRhCp2JEZqiJav+Pl8rrpL4LBIAhbAbV0bGLNOHS/3L
         qrsWEAykVxZSIwRECDsnQCtyJUEHZM1rcYnxrsAd+Sneqo6ZoTskzCA1LKWxZ3egNSr9p7/fj6Jb
         6X/0aHHJ+sR+ssPplqiGqQsx97ijxQ3dPa4LNtWUs11UnQc2E1gznsH+mT43j6vNXElo49em/+6o
         b0QIk2cDvoZOyRh51zlTjJ8qhvL6zCZV5lWZPza+IZrwNiLot0tavUxRkrP24hLtwPMVpjfKrooI
         5usuWvxIGj8PsY29tdsZxl3By4y+tIl2SubvuH6Vde4mWI3Sko7KyQ8D5hxcb/JwurJxnH/gpKFh
         fOKftAJX6IXI7vendijqYvnd8+vR+24qMqLyjJ1YZe7alGAopTilLHRbAEq9ylCve8b3QPkf4s+m
         X7HxpzT9UnPd56qwE/hieFEAQIUSkna+sC0KC6dkMAXh9i5wVwpPd5ySeajuwGkC93ULvE+oZM/I
         vvJ9BmlRpLmhUm8Wppj9hV/gvHX14CooMhnnVO/3CW0d5GdiA6vEF3st66sPaEm1MR5tEDGqQOZx
         hnpVowlpDQ8RsfzmTYpy/iD5Ur1TbiX4VqkZKbOre3HH8v2K8KyO0AhyUeiuYAjAmhxMvtTGPj
From:   xkernel.wang@foxmail.com
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] lkdtm: add checks for the return of memory allocation functions
Date:   Fri,  4 Mar 2022 18:30:35 +0800
X-OQ-MSGID: <20220304103035.5389-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kmalloc() and vmalloc() are all memory allocation functions which can
return NULL when some internal errors happen. So it is better to check
the return value of it for better testing the preset purpose.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/misc/lkdtm/perms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2e..3eabc6f 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -138,6 +138,10 @@ void lkdtm_EXEC_STACK(void)
 void lkdtm_EXEC_KMALLOC(void)
 {
 	u32 *kmalloc_area = kmalloc(EXEC_SIZE, GFP_KERNEL);
+	if (!kmalloc_area) {
+		pr_warn("Failed to allocate memory\n");
+		return;
+	}
 	execute_location(kmalloc_area, CODE_WRITE);
 	kfree(kmalloc_area);
 }
@@ -145,6 +149,10 @@ void lkdtm_EXEC_KMALLOC(void)
 void lkdtm_EXEC_VMALLOC(void)
 {
 	u32 *vmalloc_area = vmalloc(EXEC_SIZE);
+	if (!vmalloc_area) {
+		pr_warn("Failed to allocate memory\n");
+		return;
+	}
 	execute_location(vmalloc_area, CODE_WRITE);
 	vfree(vmalloc_area);
 }
-- 
