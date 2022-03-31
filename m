Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C653D4EDFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiCaRgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiCaRgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:36:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A960D90;
        Thu, 31 Mar 2022 10:34:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so422239lfg.7;
        Thu, 31 Mar 2022 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGpI0S583UU/uYnq20CAy/qk3XmWiJWZUHQ3a1WXMdM=;
        b=PYSG8ddN405RCUgLDBXXCtCIC6HpTYluXuPt/057e2V4DclMUqXQwQvJ0zMbZvfFyr
         aAm/PuvMFBfbtSrsvGUc2lHct1QOsEFwfq27OlMtn1ImHgMdPZQFrwWqsuyt4gPuCSgD
         g82mLZH8LMMC4oBTmrxinWyAqshonbOqJAsrcaa69OwwsB3ec8O2SHYBv54oD45/77uu
         qapIbXjqKW3jTv13KLf0DfBWoItNI6OgItAEQI/DRV71d7Ck8pEvzrTrydLLX1/mLUI7
         bg8YVAzg8KBNzs4Awq2Aw6lpjpg/CuTtzqfwQ/mF9qHR5DmVi3EbO38PuKPazR3/a3fO
         m38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGpI0S583UU/uYnq20CAy/qk3XmWiJWZUHQ3a1WXMdM=;
        b=6KlnOnwJ6xZkiJB+PuFJEjL7yY6CTU1Rdemox+Z+B3kMi/2DleTlYkqrCOMw/jlEhX
         7Xbw3fPElfWKYNLGmQp+seM7m7th23CoI0UOezLceTSFnPFoIN5CYaQ2XUsKgVGDzVJJ
         tpmogzJlm5JijX4BP2nSNFIEBZajk9k3jY7p+EJor0xj5lXiEUZsc8QX72ntg+Y37UnM
         hfeu86Rcv5HGTMSyNHbZicVTPlAKuQo03wspbAU/m3imLeR9r9OBKNyYS2vN9VlS+jlX
         Qced4gDxULmJSX3Btijh83wkWPzuJ5F1xTTFV87fvm9d9O5SAxzd85EOqcTkaVDlCgPv
         Gnkw==
X-Gm-Message-State: AOAM530O6YbPaC6/TUU6KumvMScT2oH2KuCUpzf6ql8OSkPpl315au0S
        H5ZMYQnNRas5RF1HtGkukA4=
X-Google-Smtp-Source: ABdhPJzoCjHE9997aLT2xV1HstS47RUvZQXYjAqGmUzjBaX4scHX8SyADAAdRpFMv7hEnouPfjryZw==
X-Received: by 2002:a05:6512:3186:b0:44a:c200:61e1 with SMTP id i6-20020a056512318600b0044ac20061e1mr6120837lfe.534.1648748077558;
        Thu, 31 Mar 2022 10:34:37 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05651c168a00b00247fe29d83csm2746992ljb.73.2022.03.31.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:34:37 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 4/5] selinux: Remove redundant assignments
Date:   Thu, 31 Mar 2022 19:33:57 +0200
Message-Id: <20220331173358.40939-4-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331173358.40939-1-michalorzel.eng@gmail.com>
References: <20220331173358.40939-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 security/selinux/avc.c         | 4 ++--
 security/selinux/hooks.c       | 1 -
 security/selinux/ss/services.c | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index abcd9740d10f..874c1c6fe10b 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1059,7 +1059,7 @@ int avc_has_extended_perms(struct selinux_state *state,
 
 	node = avc_lookup(state->avc, ssid, tsid, tclass);
 	if (unlikely(!node)) {
-		node = avc_compute_av(state, ssid, tsid, tclass, &avd, xp_node);
+		avc_compute_av(state, ssid, tsid, tclass, &avd, xp_node);
 	} else {
 		memcpy(&avd, &node->ae.avd, sizeof(avd));
 		xp_node = node->ae.xp_node;
@@ -1151,7 +1151,7 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 
 	node = avc_lookup(state->avc, ssid, tsid, tclass);
 	if (unlikely(!node))
-		node = avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
+		avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
 	else
 		memcpy(avd, &node->ae.avd, sizeof(*avd));
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e9e959343de9..f792835b3fb6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6487,7 +6487,6 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 			goto abort_change;
 
 		/* Only allow single threaded processes to change context */
-		error = -EPERM;
 		if (!current_is_single_threaded()) {
 			error = security_bounded_transition(&selinux_state,
 							    tsec->sid, sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 6901dc07680d..802a80648c6c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2980,7 +2980,6 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	}
 
 retry:
-	rc = 0;
 	rcu_read_lock();
 	policy = rcu_dereference(state->policy);
 	policydb = &policy->policydb;
-- 
2.25.1

