Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587BE58AA2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiHELcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHELcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:32:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E831A808;
        Fri,  5 Aug 2022 04:32:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m41-20020a05600c3b2900b003a4e094256eso1182552wms.0;
        Fri, 05 Aug 2022 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qNoWZJdxKVVEwFk/7zUUPQn8nhtmRlSYmnr02okBx1Y=;
        b=ESvJKXlQEXUIWf5pmCGO3WO7e9NM4dPHOzTviWdHVMZr6Et2W9iySs6g8fAZnQGk62
         IgIUjYYaE5eJP5+J5mOb6bVNWSZJy3JWXCbB/3mTe9ZUb3N3u176h7t0lUYJRIEyE1N0
         UEx/TTkEFl8lSB5VcliXDneL0PsSobKtgZdBNmEZtAj3dj/giwyyAUo4eGxWQxR7JOSu
         Ym0RAj9mmRQcEj7Pcxh3UQpTmVX5TGVXAd2GJjynd6vBgAZj91mFuUUXkRqoY1uPhb1e
         8KAA0DV7Byy4tBU5iQE7LgbnraGhvmWR+F4K+I5YVzK9gx2m91xWmIYZ3q/CqJFvC9ED
         SDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qNoWZJdxKVVEwFk/7zUUPQn8nhtmRlSYmnr02okBx1Y=;
        b=7b4ogD1XNRbYt/+t+JFtxngKcuyJO9R94Ia6mWi6VVEDPYZwlLcR2FDu7ITTOeqWkt
         6COBNKuPr7Tc31p/fKvyyTgCuXEvxOBTy2qsOV0x0CRFzK04+C9VYnwfmRnEqMDq3ezX
         5DI4EIOxkYGEedaN+JxWhitj1MPf5vdf3lvjnpsZafver/lsdCQf/w6+f+JpgFz18SKx
         M6Wzn6RKwjdMCt6X8/QxzAw9ZxpXir07F+Wwh87Zn4VA5sk8+Ua9amyGwwZ0JMu4liyS
         dpjyX27CJLhGx9w/20M8u3mMB0q0lo94hI0dlMA7brxM7VJJB66BWnNdCIkus97RyCZ0
         TK6g==
X-Gm-Message-State: ACgBeo36WCMn9io+h83P7y15OuhuVf67DE/AnLucN3Zq6aRCquOrTQHm
        GFZZsDLA07xA2u9LIXTpkWw=
X-Google-Smtp-Source: AA6agR4dBa/UE3vHdxVFqhoAY9xuBNTNITH/se2ZbETiQg5G0HiwdAqOO5AT/We6wRETAocCNKmAeg==
X-Received: by 2002:a05:600c:42ca:b0:3a4:e56c:1d39 with SMTP id j10-20020a05600c42ca00b003a4e56c1d39mr9101689wme.183.1659699135750;
        Fri, 05 Aug 2022 04:32:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003a305c0ab06sm11087748wmq.31.2022.08.05.04.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 04:32:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: message: fusion: remove redundant variable iocnum
Date:   Fri,  5 Aug 2022 12:32:14 +0100
Message-Id: <20220805113214.2339022-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable iocnum is assigned a value that is never read, the assignment
and hence the variable are redundant can be removed. Also update the
the comment to reflect the correct name of the variable being updated.

Cleans up clang-scan warning:
drivers/message/fusion/mptctl.c:641:8: warning: Although the value stored
to 'iocnum' is used in the enclosing expression, the value is never
actually read from 'iocnum' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/message/fusion/mptctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index f9ee957072c3..673145c8936b 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -620,7 +620,6 @@ __mptctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	mpt_ioctl_header __user *uhdr = (void __user *) arg;
 	mpt_ioctl_header	 khdr;
-	int iocnum;
 	unsigned iocnumX;
 	int nonblock = (file->f_flags & O_NONBLOCK);
 	int ret;
@@ -634,12 +633,11 @@ __mptctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 	ret = -ENXIO;				/* (-6) No such device or address */
 
-	/* Verify intended MPT adapter - set iocnum and the adapter
+	/* Verify intended MPT adapter - set iocnumX and the adapter
 	 * pointer (iocp)
 	 */
 	iocnumX = khdr.iocnum & 0xFF;
-	if (((iocnum = mpt_verify_adapter(iocnumX, &iocp)) < 0) ||
-	    (iocp == NULL))
+	if ((mpt_verify_adapter(iocnumX, &iocp) < 0) || (iocp == NULL))
 		return -ENODEV;
 
 	if (!iocp->active) {
-- 
2.35.3

