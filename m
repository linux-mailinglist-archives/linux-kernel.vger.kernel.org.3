Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEE54CEF9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbiCGCZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiCGCZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:25:56 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1F5C35D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:25:03 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q4so10865661qki.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 18:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wXAl273jyc8bno7QlMupEFOhJHx7+w27PBCoptnCV8=;
        b=L1ztBC0jkbC4z1gvrcVfFa1mvz8MkDwvGxF87Xcp+T62w4k+4b33N4KIw55ZT16rPa
         WkAxoIO8cAbUioLw+SNMPe6sevDASUl+XK0QIJKdEuUFW3v0liv5XK25Y0Tlvjx0aLcz
         HA3/q3yaB81kGDqAvNI0MxIU2AVtb5NmNNxNHsluY5yUbxYPTnQHwZzjtCgn79fccq8T
         7v8xBjhDAV9CJTJHcx6vrBPAmHQ/mIQHq8hdDVFNybWYJEgGdWAu5zhzDULe12BOwRhM
         4KZm3fhL8qU1irKX4tzFqaRUCm9duTqcNh1Q28V6dnrhsmah+dQic8Sn7nxZSZSc5pF7
         YB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9wXAl273jyc8bno7QlMupEFOhJHx7+w27PBCoptnCV8=;
        b=gnjLe1D3TX4K9rZjh8fgEAHbC/D2zMnuZjplRie8f+z2DXoo3esjeaZp6ZXgjLfeGr
         bTM/oBW91bfG7xYcTt1wW5Ya3sHhtWufel//OtDz+9m234M3TWTNabF2sdJ2pVYCGQpr
         ous+54ZeA2VBUfgd9DOt7RucV93JxfcrVgoEPj+VWCULGBwqtDVQ4h6muCOJEIKUquip
         Q6DheRXQsmkNX40HQ/nddWep6RQT0OWLrH90Hk9El+PA+woxFoi7Ev4HVSY5LpwaoRZ9
         Ua6ux5A3DEl86OfPYnzBNOz5DdGmY25IU3tmEd5qlyTvO9HfC9AKiu8kWT8hNa+f/4B8
         nW/A==
X-Gm-Message-State: AOAM5311yEN+PjsAi0vc5LBtvV9lRVtRei9dS/qzMBO5hBNk3mnCzx7n
        Aoo38agQ5/jyOm1dWChF8YY=
X-Google-Smtp-Source: ABdhPJy7rujdHAOicvsuzBN580W/pmRmBNn+5/A2w+p7pJ0rFQAkAFuo5T0MHAMyt13m5gwBQ/hdWA==
X-Received: by 2002:a37:4550:0:b0:47f:55f2:7e86 with SMTP id s77-20020a374550000000b0047f55f27e86mr5780359qka.384.1646619902246;
        Sun, 06 Mar 2022 18:25:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d77-20020ae9ef50000000b00649555ce936sm5672564qkg.83.2022.03.06.18.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 18:25:01 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] xattr: use vmemdup_user make code cleaner
Date:   Mon,  7 Mar 2022 02:24:56 +0000
Message-Id: <20220307022456.2074945-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>

fix coccinelle warning:
./fs/xattr.c +563 WARNING opportunity for vmemdup_user

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
---
 fs/xattr.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..77798f0c76ae 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -560,20 +560,15 @@ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
 	if (size) {
 		if (size > XATTR_SIZE_MAX)
 			return -E2BIG;
-		kvalue = kvmalloc(size, GFP_KERNEL);
-		if (!kvalue)
-			return -ENOMEM;
-		if (copy_from_user(kvalue, value, size)) {
-			error = -EFAULT;
-			goto out;
-		}
+		kvalue = vmemdup_user(value, size);
+		if (IS_ERR(kvalue))
+			return PTR_ERR(kvalue);
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
 			posix_acl_fix_xattr_from_user(mnt_userns, kvalue, size);
 	}
 
 	error = vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
-out:
 	kvfree(kvalue);
 
 	return error;
-- 
2.25.1

