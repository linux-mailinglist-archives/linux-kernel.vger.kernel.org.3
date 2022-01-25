Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C131F49B601
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387193AbiAYOTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578159AbiAYOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:15:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28417C06176F;
        Tue, 25 Jan 2022 06:15:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m11so63056614edi.13;
        Tue, 25 Jan 2022 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4+R74cF3PNyNmzK5lZ+KVOoV8dO4stgyK6i+ACgdHuY=;
        b=nW3kSEoKjAegBSj/tKBNPyr/I7rHTyjQAB1EXidLRV+VvXS9TDUvFHuRCqIiPLQVw9
         T6JiCi1jAvgT0S4eNWkq8uTqQYXBjenKL1lqYYUWzsVNrXTitKjTcj5FX0GgyEyFp01o
         VD7l9uF/FCjFQJ1RTKKpQzYobpFcHEDWR2+FfporyoprCIYsG0iioS9jkPFIKZoLrhzR
         mhdRABM0JMguoWT9aSA+FmPoutW2vrWalJgCGEKHbi8nnEi5C89fGm1UxlYb/wfIlfxc
         uARigW8ZtjTnAee65n87/qd+qdHS3pRN4+Nd28i52OnYz7PlhcLaONl4URN/ufp+9P7x
         y1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4+R74cF3PNyNmzK5lZ+KVOoV8dO4stgyK6i+ACgdHuY=;
        b=yRFJ+qNEot9qHMjxxoueo6DQzHh+4WBkav8PBOnL+YWO4tIgbLapwDuYhd78S+CILU
         RTtJHp7yE8ly6L6cSuaZzNZwBJ/K0h81O3ywKt8aB9mtR3z3zQPKPeNa4LOOJIWYtuRv
         OUA9WKbSxKMhIYxQkbT/HNDtvrFME3ifsEThPHT3ckv4fBqOgmepIUJUkpWoYtGKFHP+
         bg9xgeB5pWkI0PjG9U94umuK0uRt0u/C4tDiWQQvhvFqExwSD456c9nClFIJw62pPIzl
         3O64D1I1Ro0lITUPSKYjztbu0k548apFMl1cvNpSWgzkaJyF9k9fvnq3Sd02C4RlqlMd
         n41w==
X-Gm-Message-State: AOAM533gFCbCn0LHdQgtHVovMG03hzIbpAaJT7njUwq56U2KHW2VHdYl
        L+VDFv+O//ZTlA1KPJIQXvgKHI068d7RSQ==
X-Google-Smtp-Source: ABdhPJwG4lgvewAKWyiyXxm/wo0J9DWS5+QwQuyJwfNzJpI15e32o+RlpJ65tOnVDfqQaVwy/gMpng==
X-Received: by 2002:a17:906:4e16:: with SMTP id z22mr16359875eju.338.1643120103653;
        Tue, 25 Jan 2022 06:15:03 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-010-144-044.77.10.pool.telefonica.de. [77.10.144.44])
        by smtp.gmail.com with ESMTPSA id lu44sm6292929ejb.145.2022.01.25.06.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:15:03 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Vander Stoep <jeffv@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/9] selinux: check return value of sel_make_avc_files
Date:   Tue, 25 Jan 2022 15:14:20 +0100
Message-Id: <20220125141422.32655-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125141422.32655-1-cgzones@googlemail.com>
References: <20220125141422.32655-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sel_make_avc_files() might fail and return a negative errno value on
memory allocation failures. Re-add the check of the return value,
dropped in 66f8e2f03c02.

Reported by clang-analyzer:

    security/selinux/selinuxfs.c:2129:2: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
            ret = sel_make_avc_files(dentry);
            ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/selinuxfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index e4cd7cb856f3..f2f6203e0fff 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2127,6 +2127,8 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	ret = sel_make_avc_files(dentry);
+	if (ret)
+		goto err;
 
 	dentry = sel_make_dir(sb->s_root, "ss", &fsi->last_ino);
 	if (IS_ERR(dentry)) {
-- 
2.34.1

