Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD054CCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352245AbiFOP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349977AbiFOP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:26:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572A40914;
        Wed, 15 Jun 2022 08:26:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so23954489ejk.5;
        Wed, 15 Jun 2022 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2adNDon461xpHjX+1PUH+oB6KG0+MV4mU/JS/XJ+FXE=;
        b=cI5OkNqkUvBhETcJKKnFnPMebRffRI8MNSUsjU/5HPdeJ+qyxV2mwXQf5HNBp00YgH
         qxv73vbfRHalNNtCGrSHhEXAq0KdZQFChIEpt6DS3TIQoJ3XxMzZi2JIJ005I3WL9udh
         m/5D7DE/A/W+8qQ2/IYBlVtfTam8gq+P7piY8iPaZDvrh2WwaP0UjIfto4WNIvEmOa9x
         6VMT6SpArfe33YeWkA9CBWRAxtoTij55wgy1d6CF5/0LnGfU7JE34tEoDTNChSWYWJrg
         RGmW1N5TFtQT8ZpVNF6ToX1SFiXqVlPFODDGtWM97qCotiSKYCzTOjWvVksLwqhClbJk
         bXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2adNDon461xpHjX+1PUH+oB6KG0+MV4mU/JS/XJ+FXE=;
        b=skCnoy1NXz7xHFmJzdgpe2Bl4XMKRHCOWeF6E2tOvl2SL9VjKlAbBWNGz/ObOXHXhN
         xShEs/I4zOITGZw4WtXd8AffwuXf2uw5LCBBgkKqpnNqLf2Vc33IEtqGdWO4RgYinDRO
         FDAK2gZDJNtXpj0O2qdIN7bUo0U/M00ZSrkWCmO94RKFjF35gL25BLmJAu0Tyz1Reg0i
         itTYoeEe0SwK2YpeeW4ENjVpdCNFkJwew4Pit4wTGo44Uc8Ecyn5ZaYVd8JX9UTOCZGF
         tT4KDAwuHFD+7jlCCw0wGlEDFm79xoPJJgegVYy092OI/cG7oVJCav0Uh5772WZrHpW7
         35SQ==
X-Gm-Message-State: AJIora8t2Uqwq0Dicel/0dzNWuf/jvaa8GDx6Hs6UW6xz+mMip5HFOw5
        5/AnK3A/n4VeZX0khuH5CHrNqWT/0eqsGg==
X-Google-Smtp-Source: AGRyM1ukN4/oxBFQLsgI+zoIm3aEYbu4RNsKlf3W2qX6XOHC2x1Vb+CPICgj/LMSlc1bohCgh5qz0g==
X-Received: by 2002:a17:906:74c6:b0:712:10f2:7c87 with SMTP id z6-20020a17090674c600b0071210f27c87mr337542ejl.416.1655306806961;
        Wed, 15 Jun 2022 08:26:46 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7d9ce000000b0042bc97322desm9501224eds.43.2022.06.15.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:26:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/8] kernel: use new capable_any functionality
Date:   Wed, 15 Jun 2022 17:26:20 +0200
Message-Id: <20220615152623.311223-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615152623.311223-1-cgzones@googlemail.com>
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com>
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

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   rename to capable_any()
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..1665fb4591c7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2104,7 +2104,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = -EAGAIN;
 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
-		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		    !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
 	current->flags &= ~PF_NPROC_EXCEEDED;
-- 
2.36.1

