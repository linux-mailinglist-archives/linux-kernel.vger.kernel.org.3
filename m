Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B9B4E613E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbiCXJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345516AbiCXJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:45:59 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 366EE9BB84
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=gFwebXzeriQdk2MB7g
        qMwaHDx1Y3gMzCD/ItoJDCb3c=; b=oUXoXm/Z0xDSpS1siVo411ccGqKX43npZh
        uChgX+w1x9hl8lNY9GP4cDtiZ0j8CSTvZb/gKM0tKx+TMl4Qw/CKgWnVSfTPtSKE
        T7Y5Llu8iZkOsoisAmiQgZAon+SrGCL6y42xbvZhSOV2L8TsJkDmM36xtoTGPBGa
        1vIbV9kwE=
Received: from localhost (unknown [159.226.95.33])
        by smtp13 (Coremail) with SMTP id EcCowAAn8QJ0PTxieonmIg--.15948S2;
        Thu, 24 Mar 2022 17:44:21 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] lkdtm/fortify: Check for NULL return of kmalloc()
Date:   Thu, 24 Mar 2022 17:44:19 +0800
Message-Id: <1648115059-12026-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EcCowAAn8QJ0PTxieonmIg--.15948S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4xWFW5Kw13tryUAw4fKrg_yoW3XFb_Gw
        4rXr1xJr9xWw1UKw17tFZxZrW0kF1kuFs5u3Zxt3y3Jry7ZF1Iqa40qr98Gw4fGrWkZF9x
        Cr1DAasY9r17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUbgTm5UUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/1tbiXxXNH1153xfsJwAAs-
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory allocation function kmalloc() may return a NULL pointer.
If 'src' is NULL, the strscpy() would copy the string to a NULL address.

Therefore, it is better to check the return value of kmalloc() to avoid the confusion.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/misc/lkdtm/fortify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/lkdtm/fortify.c b/drivers/misc/lkdtm/fortify.c
index ab33bb5..93eeaef 100644
--- a/drivers/misc/lkdtm/fortify.c
+++ b/drivers/misc/lkdtm/fortify.c
@@ -41,6 +41,9 @@ void lkdtm_FORTIFIED_SUBOBJECT(void)
 	char *src;
 
 	src = kmalloc(size, GFP_KERNEL);
+	if (!src)
+		return ;
+
 	strscpy(src, "over ten bytes", size);
 	size = strlen(src) + 1;
 
-- 
2.7.4

