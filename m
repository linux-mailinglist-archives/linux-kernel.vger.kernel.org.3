Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACCA4EDFBD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiCaRgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiCaRgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:36:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C460CC9;
        Thu, 31 Mar 2022 10:34:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o16so737584ljp.4;
        Thu, 31 Mar 2022 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYr4+A2I2sUXVhAjEZBjGiVViPde2R3/QXl/MeRC92k=;
        b=nFEALaQDRJK+KYEsH461dOhzve4fxNfkmMgo2fIBhtDhWjGq0/3pAHjjbmI72dHdKd
         E57CD6qP4N+xshQ6kiTp0V++2vdUEE6yPY+Lwfte6OlmKHuxAP0q4xR8onHZKKbRjnyP
         1X4KLDGOxDAYU8dswNf3x1cXwqYWocH9gPc1Hvgl1js90EDGvkt97oi23edz7BpbetBc
         sBWMo38844VINbgHx5UjWdVta1PoZujZiteBXWSTNYc/+tZW4hFV21oX9M56nu4AhLrX
         ZrAsBxU+N+9XQcFK+nJ8pFa0AIAxNdNlpljSex+gsfl34KTktL8AqKESMI4eXWvY9WEv
         /vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tYr4+A2I2sUXVhAjEZBjGiVViPde2R3/QXl/MeRC92k=;
        b=urf3vcc8Ad+Mky+G1N4IF2msOYIup0M7R6SNKl668Jl1fp9PmlJqmApcw52JpQfoSm
         JwCQc4sJFvNjpLKZ72DCx/1Nu4Rkh7yXySJJkwLf415lx+GGBcANjEfecRxROlFflBdc
         fuOfs6RMTSfL93TZ4CYS9ggfxIybGtnMoOPWq4KDV1pAG3jNNVnkUl3xxQ0RHmLGzsd+
         aXuGMdjm3ac+1tYq0ixMpNm8R3HJ7paXTlbEDBTC69/hAVSVuW/ahlsaBz9FH7/pTy9i
         uzWWBIffFtniOMBd8NKnmIkTsq0THotYhdSff4/KOwmfjlL5INf7ijOiOiuGApelX1PX
         70Bg==
X-Gm-Message-State: AOAM533z8cvoxfwywriNtVV6O7SskMMNtyAnkgEiFgWG+6bvGF0Oh+wA
        13eeoJrvHuOCNOPTSrDdzgc=
X-Google-Smtp-Source: ABdhPJzWR7AdVufxiLU93gc6byk6FCl+NoBdPVzob1NRulTJGAMUnxBz1CXzXgQEFQo/gHGjPZU+cg==
X-Received: by 2002:a2e:9003:0:b0:24a:c3a5:849c with SMTP id h3-20020a2e9003000000b0024ac3a5849cmr11159595ljg.68.1648748061620;
        Thu, 31 Mar 2022 10:34:21 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05651c168a00b00247fe29d83csm2746992ljb.73.2022.03.31.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:34:21 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/5] apparmor: Remove redundant assignments
Date:   Thu, 31 Mar 2022 19:33:54 +0200
Message-Id: <20220331173358.40939-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 security/apparmor/domain.c | 3 +--
 security/apparmor/label.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index a29e69d2c300..77724acd9d8a 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -627,7 +627,6 @@ static struct aa_label *profile_transition(struct aa_profile *profile,
 {
 	struct aa_label *new = NULL;
 	const char *info = NULL, *name = NULL, *target = NULL;
-	unsigned int state = profile->file.start;
 	struct aa_perms perms = {};
 	bool nonewprivs = false;
 	int error = 0;
@@ -661,7 +660,7 @@ static struct aa_label *profile_transition(struct aa_profile *profile,
 	}
 
 	/* find exec permissions for name */
-	state = aa_str_perms(profile->file.dfa, state, name, cond, &perms);
+	aa_str_perms(profile->file.dfa, profile->file.start, name, cond, &perms);
 	if (perms.allow & MAY_EXEC) {
 		/* exec permission determine how to transition */
 		new = x_to_label(profile, bprm, name, perms.xindex, &target,
diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 0b0265da1926..ce9ae9b6b303 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -807,7 +807,7 @@ bool aa_label_replace(struct aa_label *old, struct aa_label *new)
 		struct aa_labelset *ls = labels_set(old);
 
 		write_lock_irqsave(&ls->lock, flags);
-		res = __label_remove(old, new);
+		__label_remove(old, new);
 		if (labels_ns(old) != labels_ns(new)) {
 			write_unlock_irqrestore(&ls->lock, flags);
 			ls = labels_set(new);
-- 
2.25.1

