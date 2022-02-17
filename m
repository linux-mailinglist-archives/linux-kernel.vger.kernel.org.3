Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E634BA311
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiBQOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:35:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiBQOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:35:23 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262FCC52F;
        Thu, 17 Feb 2022 06:35:08 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so7737569ejc.7;
        Thu, 17 Feb 2022 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHA2XuS0dgOq5n/U8wIiuJf10qw0oyQxE7M7cjtKX8s=;
        b=BJzwn2QblOP2oo5yOQxiMMGcbxrnaeXECDpWnwfqAeX9Yze90RojvT+50kJJ3vPRsL
         4vp7EnwIQx0+Gv66KVLp4aykvbiGk9/M08E4XgOVWj/E/gl7hF5/VDLvg3XHAZvp/Xxq
         M2CKDXsXYGBhzEUoN+eEOAFu7UAz7em/4Ql0QvQ6VH55LOm0xEWY51F1wQiOYZtReV2j
         7kea3qBf+PkhoVH/TAuzpnZL4PWCIWpeWaL18DLW0RkJ7dls6wwZUy1aW19Ul0fRloKE
         2FZZ20ZYfsLPxWyYPMWxuCT7KUjUL11FUz48hCokHkE384/hpVwa+k/fnoeVg0r4owSh
         3EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DHA2XuS0dgOq5n/U8wIiuJf10qw0oyQxE7M7cjtKX8s=;
        b=V2CwXpIeVsPXbl748c9GhL7wk3vnt2tMB10tz/cCuTxfWwuwfW1ZCtPnL1Nm9lMFCd
         Gf0Hp7jwos0qtzmz8UN2qoCf5wIWlRvjF9IEhcr7/6qTWIAM9ErcOdrUXCVcELlmp6Ip
         9yNEWjGYrusfXZEUGzGASsjWmoGPSSkplWCRZPuUfIsgNW0qUrWGWOZHWUWUTlCFN0Ee
         qzci+X5OLBCfcIgyk7hwX5vxfG9O2bB60s5Ez1qyxO9eEAKfuZ8XnMwrAk/uWNRqwrp5
         qKS5WmGnKXPzeFCiZyl1p+r3jZnOgLuZnUk5zfY/rydqzlumTdgTQTxaKVKPxK+I20tN
         KhLg==
X-Gm-Message-State: AOAM531sXYsMA3WVVZI6JTpfNVU3gMsQJhClGwDIx4TO+IbLGrWdGGOO
        WIg9+lRBMnyoUY7OC/S3MrRE6kdpLZrt8w==
X-Google-Smtp-Source: ABdhPJykPmzzIXwvoaaXr4wvTel9Iifi6+mdij3zzeWVxFBGU0mTRrXxWWGZx7feRQbnPWhiFvbOgQ==
X-Received: by 2002:a17:906:414e:b0:6b9:7068:1983 with SMTP id l14-20020a170906414e00b006b970681983mr2609254ejk.752.1645108506934;
        Thu, 17 Feb 2022 06:35:06 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-001-066-240.77.1.pool.telefonica.de. [77.1.66.240])
        by smtp.gmail.com with ESMTPSA id e17sm1260065ejl.68.2022.02.17.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 06:35:06 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Guy Briggs <rgb@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH] selinux: log anon inode class name
Date:   Thu, 17 Feb 2022 15:34:55 +0100
Message-Id: <20220217143457.75229-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Log the anonymous inode class name in the security hook
inode_init_security_anon.  This name is the key for name based type
transitions on the anon_inode security class on creation.  Example:

    type=AVC msg=audit(02/16/22 22:02:50.585:216) : avc:  granted  { create } for  pid=2136 comm=mariadbd anonclass="[io_uring]" dev="anon_inodefs" ino=6871 scontext=system_u:system_r:mysqld_t:s0 tcontext=system_u:system_r:mysqld_iouring_t:s0 tclass=anon_inode

Add a new LSM audit data type holding the inode and the class name.

Also warn if the security hook gets called with no name set; currently
the only caller fs/anon_inodes.c:anon_inode_make_secure_inode() passes
one.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 include/linux/lsm_audit.h |  5 +++++
 security/lsm_audit.c      | 21 +++++++++++++++++++++
 security/selinux/hooks.c  |  7 +++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 17d02eda9538..8135a88d6d82 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -76,6 +76,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_IBENDPORT 14
 #define LSM_AUDIT_DATA_LOCKDOWN 15
 #define LSM_AUDIT_DATA_NOTIFICATION 16
+#define LSM_AUDIT_DATA_ANONINODE	17
 	union 	{
 		struct path path;
 		struct dentry *dentry;
@@ -96,6 +97,10 @@ struct common_audit_data {
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
+		struct {
+			struct inode *inode;
+			const char *anonclass;
+		} anoninode_struct;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 1897cbf6fc69..5545fed35539 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -433,6 +433,27 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		audit_log_format(ab, " lockdown_reason=\"%s\"",
 				 lockdown_reasons[a->u.reason]);
 		break;
+	case LSM_AUDIT_DATA_ANONINODE: {
+		struct dentry *dentry;
+		struct inode *inode;
+
+		rcu_read_lock();
+		inode = a->u.anoninode_struct.inode;
+		dentry = d_find_alias_rcu(inode);
+		if (dentry) {
+			audit_log_format(ab, " name=");
+			spin_lock(&dentry->d_lock);
+			audit_log_untrustedstring(ab, dentry->d_name.name);
+			spin_unlock(&dentry->d_lock);
+		}
+		audit_log_format(ab, " anonclass=");
+		audit_log_untrustedstring(ab, a->u.anoninode_struct.anonclass);
+		audit_log_format(ab, " dev=");
+		audit_log_untrustedstring(ab, inode->i_sb->s_id);
+		audit_log_format(ab, " ino=%lu", inode->i_ino);
+		rcu_read_unlock();
+		break;
+	}
 	} /* switch (a->type) */
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dafabb4dcc64..19c831d94d9b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2932,6 +2932,8 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	if (unlikely(!selinux_initialized(&selinux_state)))
 		return 0;
 
+	WARN_ON(!name);
+
 	isec = selinux_inode(inode);
 
 	/*
@@ -2965,8 +2967,9 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	 * allowed to actually create this type of anonymous inode.
 	 */
 
-	ad.type = LSM_AUDIT_DATA_INODE;
-	ad.u.inode = inode;
+	ad.type = LSM_AUDIT_DATA_ANONINODE;
+	ad.u.anoninode_struct.inode = inode;
+	ad.u.anoninode_struct.anonclass = name ? (const char *)name->name : "unknown(null)";
 
 	return avc_has_perm(&selinux_state,
 			    tsec->sid,
-- 
2.35.1

