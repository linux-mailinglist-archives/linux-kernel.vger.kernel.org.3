Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270974D1E2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbiCHRKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348421AbiCHRKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:10:34 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FFA36E1A;
        Tue,  8 Mar 2022 09:09:37 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id d10so40679852eje.10;
        Tue, 08 Mar 2022 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOdGQeqCpYXaPiv3FTiB/YOqJ4lEo750BpQvbc/UAeI=;
        b=bMbwrDBcaXwa367L6NIq1Dx+ubrnoNm0OZbFllsIFAivPdFLc923Lvjdhdg9Mz7m0P
         vZt2s7jx/4SdeOXuZ53+J/AbTQ2aJuUIdSN+rpNTqdmr0R71la2saasNcju++Ll4SeEz
         7Dzb1wxygwgg7tA1J2GNjyfrj//kkM4AleeFoPI8R/fk/SvpFYxUapLyHicPewphSMoi
         5mQ1/F/dHmklwz4rhozdYGlFDaD67Nn+35oyXwVq0HI7RMIG4s1X15blUfgGjsXFbXT9
         0u83L2R4njw62ySrlwy7p2wNdkSYmyxmJu3HEvXW6n6A1BuuwpKcSm8RrfQGKAvi9NTy
         +ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOdGQeqCpYXaPiv3FTiB/YOqJ4lEo750BpQvbc/UAeI=;
        b=U6Q1ZvXLLn/oTftzdgcd2zsWupBHD9M3aY7Y7lWL2jMXpR91yRHtMusZZPYeGOZDDB
         ph0+rh1kkB6T6KEPbDhWh0z5L8+aiWPSXmrnF5K9Gx40efs5IdEahwE4zSYs2dwCyy7d
         TkcoIJ68DBF07vf9Qt341CHnjqo4C4wBRU4OffnoJN4dgbzX8/LQmr3U7IsIcvcoNwOl
         NGcTZSjDikcQWP+lqYwNBMvPIMZXfcB2ZaGsy9sNhx3iNO2yVVMA4MAnGnVOC3EvWa9J
         7hklsWaHQgFsmmT8vODYJ+WaEQbFKpY16lsPfCGpD6ez5/DfWpMJRWY0DwxH/yNSOTQq
         Qgjw==
X-Gm-Message-State: AOAM531cJ+wyd1BIZmW5qZ35C+HFEKT+BqR29fdvgu1AgmeWePN8wMyE
        tX/J1NyDPWbagiJu6aQCRoDT9Sd+mn8Jwg==
X-Google-Smtp-Source: ABdhPJyeNwSfLyxrgPkLjbw5ubx2q+bLyD0P6+SR9bXANfjYj7eUmKomlYuskiRclYhx/J1WfTiwIA==
X-Received: by 2002:a17:906:2b97:b0:6cd:6d67:ab5d with SMTP id m23-20020a1709062b9700b006cd6d67ab5dmr14406385ejg.723.1646759375991;
        Tue, 08 Mar 2022 09:09:35 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-252-105.77.6.pool.telefonica.de. [77.6.252.105])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b004167d09f418sm443751edd.55.2022.03.08.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 09:09:35 -0800 (PST)
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
Subject: [PATCH v2] selinux: log anon inode class name
Date:   Tue,  8 Mar 2022 18:09:26 +0100
Message-Id: <20220308170928.58040-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217143457.75229-1-cgzones@googlemail.com>
References: <20220217143457.75229-1-cgzones@googlemail.com>
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

    type=AVC msg=audit(02/16/22 22:02:50.585:216) : avc:  granted \
        { create } for  pid=2136 comm=mariadbd anonclass="[io_uring]" \
        scontext=system_u:system_r:mysqld_t:s0 \
        tcontext=system_u:system_r:mysqld_iouring_t:s0 tclass=anon_inode

Add a new LSM audit data type holding the inode and the class name.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v2:
  - drop dev= and name= output for anonymous inodes, and hence simplify
    the common_audit_data union member.
  - drop WARN_ON() on empty name passed to inode_init_security_anon hook
---
 include/linux/lsm_audit.h | 2 ++
 security/lsm_audit.c      | 4 ++++
 security/selinux/hooks.c  | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 17d02eda9538..97a8b21eb033 100644
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
@@ -96,6 +97,7 @@ struct common_audit_data {
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
 		int reason;
+		const char *anonclass;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 1897cbf6fc69..981f6a4e4590 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -433,6 +433,10 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		audit_log_format(ab, " lockdown_reason=\"%s\"",
 				 lockdown_reasons[a->u.reason]);
 		break;
+	case LSM_AUDIT_DATA_ANONINODE:
+		audit_log_format(ab, " anonclass=");
+		audit_log_untrustedstring(ab, a->u.anonclass);
+		break;
 	} /* switch (a->type) */
 }
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b12e14b2797b..49c0abfd2f6a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2965,8 +2965,8 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	 * allowed to actually create this type of anonymous inode.
 	 */
 
-	ad.type = LSM_AUDIT_DATA_INODE;
-	ad.u.inode = inode;
+	ad.type = LSM_AUDIT_DATA_ANONINODE;
+	ad.u.anonclass = name ? (const char *)name->name : "?";
 
 	return avc_has_perm(&selinux_state,
 			    tsec->sid,
-- 
2.35.1

