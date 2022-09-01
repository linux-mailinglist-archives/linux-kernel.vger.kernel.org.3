Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1E25A9B88
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiIAP1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbiIAP0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03874BAE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXJ3eu32792Tz+PNWkqX8ynt0TaLdrtHwSsiZCTO97I=;
        b=Q8qT4cM/YSCwMpZ/Ve7v+i+7nKqEMhxClMNI36Klfgqa7AxMmPXzJf4NVmkGs9I/fasJgt
        zrB0qptmsM4u/XCCvs5xjrfYquuJ7ulDr8PdmKNknNHuAoVMfsZyyc26ysXSg4Nci6YUhI
        NZkdDLr4W9hXRDQ/2zGd4+X8w69lkmY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-632-bxq4Pjz_Nxug6zJsEEQw2A-1; Thu, 01 Sep 2022 11:26:36 -0400
X-MC-Unique: bxq4Pjz_Nxug6zJsEEQw2A-1
Received: by mail-ej1-f71.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso6933811ejb.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xXJ3eu32792Tz+PNWkqX8ynt0TaLdrtHwSsiZCTO97I=;
        b=EQt5Ko0rFQkeqsEKuhhM3+hRaZCViIdM+BlUKlw8DuKdjXYZkjA6KQQssgG+A+SQh1
         sDVeJ/R2xD11jS0Q0O7Rnn3ECsB2GhPx+6zSOL2FJvsepmq9bPuhkOflOusdZUYRx3w/
         hTr5oTmxMJ+q3dBX6g4pcptmCsm3SHs7svMW0TMvcgVxEeZH61vhLoJGJneHwZgdvuGj
         KfADKDm/KiIIe/6Rb5aotou5poy/BgrWF9Se2BDiRhYBWOBwRnUsXKboi/cpWj6opKoS
         TP4Ox4LLHWkGAq2EKGmQJPg8VnIiOX3S374p1YMNuXdpqwYRFsXu+NZpGLs1OH9tWeQg
         4lDw==
X-Gm-Message-State: ACgBeo0O73agQIuNt/sEpEM8m2gpUETu1YbS0izvbiZ9kgcPhSAQw1ud
        MeDTq8aer5hnUQ4jTerIk2HN5mFXBIu7VWz40teAKNkc7rv8AzMUfHKlpbtxGkNcT6Qs3/Z0UEw
        JCvt3/CnM4A9chvQTgqMeTNA4
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr24608315ejy.13.1662045995425;
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5FRde2+0Kq+Aw/cF6maS0iAuZMFCEh7wb5iWZ1StV35X9kMHScj7jMEScvxLEBUmONF9VBmg==
X-Received: by 2002:a17:906:845c:b0:730:bbf1:196a with SMTP id e28-20020a170906845c00b00730bbf1196amr24608307ejy.13.1662045995247;
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 1/2] fs: convert simple_xattrs to RCU list
Date:   Thu,  1 Sep 2022 17:26:31 +0200
Message-Id: <20220901152632.970018-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901152632.970018-1-omosnace@redhat.com>
References: <20220901152632.970018-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the RCU list mechanism instead of a simple lock to access/modify
simple_xattrs. The performance benefit is probably negligible, but it
will help avoid lock nesting concerns for an upcoming patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/xattr.c            | 36 ++++++++++++++++++++++--------------
 include/linux/xattr.h |  1 +
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index a1f4998bc6be..fad2344f1168 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -22,6 +22,8 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
 
 #include <linux/uaccess.h>
 
@@ -1030,8 +1032,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 	struct simple_xattr *xattr;
 	int ret = -ENODATA;
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		if (strcmp(name, xattr->name))
 			continue;
 
@@ -1044,10 +1046,18 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		}
 		break;
 	}
-	spin_unlock(&xattrs->lock);
+	rcu_read_unlock();
 	return ret;
 }
 
+static void simple_xattr_free_rcu(struct rcu_head *rcu)
+{
+	struct simple_xattr *xattr = container_of(rcu, struct simple_xattr, rcu);
+
+	kfree(xattr->name);
+	kvfree(xattr);
+}
+
 /**
  * simple_xattr_set - xattr SET operation for in-memory/pseudo filesystems
  * @xattrs: target simple_xattr list
@@ -1094,11 +1104,11 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 				xattr = new_xattr;
 				err = -EEXIST;
 			} else if (new_xattr) {
-				list_replace(&xattr->list, &new_xattr->list);
+				list_replace_rcu(&xattr->list, &new_xattr->list);
 				if (removed_size)
 					*removed_size = xattr->size;
 			} else {
-				list_del(&xattr->list);
+				list_del_rcu(&xattr->list);
 				if (removed_size)
 					*removed_size = xattr->size;
 			}
@@ -1109,15 +1119,13 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		xattr = new_xattr;
 		err = -ENODATA;
 	} else {
-		list_add(&new_xattr->list, &xattrs->head);
+		list_add_rcu(&new_xattr->list, &xattrs->head);
 		xattr = NULL;
 	}
 out:
 	spin_unlock(&xattrs->lock);
-	if (xattr) {
-		kfree(xattr->name);
-		kvfree(xattr);
-	}
+	if (xattr)
+		call_rcu(&xattr->rcu, simple_xattr_free_rcu);
 	return err;
 
 }
@@ -1169,8 +1177,8 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	}
 #endif
 
-	spin_lock(&xattrs->lock);
-	list_for_each_entry(xattr, &xattrs->head, list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		/* skip "trusted." attributes for unprivileged callers */
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
@@ -1179,7 +1187,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		if (err)
 			break;
 	}
-	spin_unlock(&xattrs->lock);
+	rcu_read_unlock();
 
 	return err ? err : size - remaining_size;
 }
@@ -1191,6 +1199,6 @@ void simple_xattr_list_add(struct simple_xattrs *xattrs,
 			   struct simple_xattr *new_xattr)
 {
 	spin_lock(&xattrs->lock);
-	list_add(&new_xattr->list, &xattrs->head);
+	list_add_rcu(&new_xattr->list, &xattrs->head);
 	spin_unlock(&xattrs->lock);
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 979a9d3e5bfb..3236c469aaac 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -86,6 +86,7 @@ struct simple_xattrs {
 
 struct simple_xattr {
 	struct list_head list;
+	struct rcu_head rcu;
 	char *name;
 	size_t size;
 	char value[];
-- 
2.37.2

