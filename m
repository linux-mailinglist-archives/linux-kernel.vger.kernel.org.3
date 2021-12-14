Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B83473FC3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhLNJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhLNJpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:45:35 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AB9C061748
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:45:34 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso16501914edq.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JYcreOWass/O0g4mIovOVIM4ETtWOpNnbMMQBbEG/c4=;
        b=UoV8HI1VlFYbMX06h37FjeMBodXU6/GnOXYoMAYgUJCD41WC9P+YcJ3n8ha93s/NyA
         Qiqq97Woi/wL8lgyfvLdv9sfzQptBuB2xzD7FEMG40riXGqs31l+11n0jdmgF3Ia3qP6
         ZNr1tnv1Uz7xJImbuAVMUFajvQnoXf9beM1Q1iNiZ1EitGS/aI2dnpQQJdyt6EsxpuX0
         oavORWiSvW25qFGGdmjqEmenIlJK5cka2nSevvOVJCyQo8o+T50ZHMVF10zC8yPpi4xv
         JLPoJF5QbzkRbqA2OM/whXvB8GvgQ2vpRtWCRHlns+H47TUrHeXE3AlFX1SsUseo/0Co
         /LxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JYcreOWass/O0g4mIovOVIM4ETtWOpNnbMMQBbEG/c4=;
        b=7lD2ICNA6eCVCz0/xPg83eJsBLk95xgDHl6MyQAQUDPiCTJWpQwoHwM237lD97eh4/
         s3ak46xo/7TblK6warB2hM8JbxjdarAaSiPN4R5zXw5v0WY8Hr16Q88vep7gwsQkKdV/
         um8Z1e8qT5rujSBc0aMCcpYhoPqJdeafSQuAoUWxRuEMVpRnNG3RpuTW93A/+8lTOcsa
         WlpSPjwTqHagTnf6I21fVtsi/vR8tD4VQnS0T20zA+eAvVUgOOO8X3rSBbWMiKwjDyhq
         LGmkQR37DZiP+A38WloXds8pHP4ZdpnDtRsjA8Ra3bwikO1BI0oI4342eJ+9O6Ja92RI
         FuPA==
X-Gm-Message-State: AOAM5333F+73rFjRQ8AUEto6+qaO0/rckoyBJMhHbFUG8fVpFaMhq72r
        8FzLqDvM4ZzAaT28hjpBfxa2dKo+164T
X-Google-Smtp-Source: ABdhPJytufiypJLVS8/CJwhj8n4nqNs9eAWemEDWVEVktfvGo4rnmFlZLe7SCPuEgjCprlrhDpZKLYhxyOVM
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:2dbe:8a64:49c3:7849])
 (user=dvyukov job=sendgmr) by 2002:a17:907:a40b:: with SMTP id
 sg11mr4601636ejc.534.1639475133427; Tue, 14 Dec 2021 01:45:33 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:45:26 +0100
Message-Id: <20211214094526.2442154-1-dvyukov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] tomoyo: Check exceeded quota early in tomoyo_domain_quota_is_ok().
From:   Dmitry Vyukov <dvyukov@google.com>
To:     takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp,
        jmorris@namei.org, serge@hallyn.com
Cc:     nogikh@google.com, Dmitry Vyukov <dvyukov@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tomoyo is used in a testing/fuzzing environment in learning mode,
for lots of domains the quota will be exceeded and stay exceeded
for prolonged periods of time. In such cases it's pointless (and slow)
to walk the whole acl list again and again just to rediscover that
the quota is exceeded. We already have the TOMOYO_DIF_QUOTA_WARNED flag
that notes the overflow condition. Check it early to avoid the slowdown.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 security/tomoyo/util.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/security/tomoyo/util.c b/security/tomoyo/util.c
index 1da2e3722b126..af8cd2af3466d 100644
--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -1051,6 +1051,8 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 		return false;
 	if (!domain)
 		return true;
+	if (READ_ONCE(domain->flags[TOMOYO_DIF_QUOTA_WARNED]))
+		return false;
 	list_for_each_entry_rcu(ptr, &domain->acl_info_list, list,
 				srcu_read_lock_held(&tomoyo_ss)) {
 		u16 perm;
@@ -1096,14 +1098,12 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
 	if (count < tomoyo_profile(domain->ns, domain->profile)->
 	    pref[TOMOYO_PREF_MAX_LEARNING_ENTRY])
 		return true;
-	if (!domain->flags[TOMOYO_DIF_QUOTA_WARNED]) {
-		domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
-		/* r->granted = false; */
-		tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
+	WRITE_ONCE(domain->flags[TOMOYO_DIF_QUOTA_WARNED], true);
+	/* r->granted = false; */
+	tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
 #ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
-		pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
-			domain->domainname->name);
+	pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
+		domain->domainname->name);
 #endif
-	}
 	return false;
 }

base-commit: 5472f14a37421d1bca3dddf33cabd3bd6dbefbbc
-- 
2.34.1.173.g76aa8bc2d0-goog

