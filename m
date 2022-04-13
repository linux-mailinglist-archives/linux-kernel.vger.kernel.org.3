Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B964FF2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiDMI5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiDMI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:57:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0EE4AE1A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:54:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id p18so770241wru.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmyPHo1Y68x7jSUi9Pb4BVUEFgwW7a8QvfJOh1mI294=;
        b=AEYs5kcBVf7G9kgn/ZtroKCSb3X2FqywNXTHog48PmdNvnhPr8WSHtcAHBtd+mWHWi
         27k+pys7X8G7Mi5jimZOmdmymAT/Re/tLMJqs3YzaL6jPamQwWmSCCfnteF3ZFUxuklK
         yGb4NnVN+j97MaB8eFjDWK7QVLK4cW/T/Y+3DHVc6ULjT1pX/6R8veFC8/Al1Spv+coB
         IWTZuS3fZmUVHpOVvn3mLYI8HgS5lkWzds8N2qggpQqPu30HadsfWCy8x/RH58cMHsAs
         USN9xqfLq+Ca1hTgfeUtb+t7Xd4FXCIVRc1vWTRi6xOLOgxzi/QtVmwsJcQgLwjvp29T
         NWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wmyPHo1Y68x7jSUi9Pb4BVUEFgwW7a8QvfJOh1mI294=;
        b=cKQ//7eKRRxhCE7S0uoR11UlOat5lensGvOEDF5PJajfMK0JTR5gUmo78huBN05jGp
         1+Gt2GFqkYlW+cuHAHEqyDqwNShkiyANU2vpoNpPpixzQHuiO29M6bsCUptQ1zJ8+hO6
         YWWX/OdA/jetdG6l54evrDcSfmIp60LyquJqryuBr5hKntpf1rY44i0EMShKJSLrfw7S
         xZQmZffUMGMhC+rslucJHeIuTydee6j8cWMRHnKoEXjwxp8qHWhme69RIGiTgybp7LBd
         NC7/meZL4FZXdBcXBghKC/HsUzpMOnbLK59xjOXsUjhOmjX9ffwk47NbroKqMrVw4DMJ
         tKWQ==
X-Gm-Message-State: AOAM532/bcwMbuIfb1D7BnBSWfcXaJpaRLwFm+P+3ZR14QcpctESIRw/
        umsC1yqFos51vcLNJXsIf0o=
X-Google-Smtp-Source: ABdhPJwJRrT3cP8c2aM+zQMORH9xbNommRtYhlfS1BWy0pjwfb85+QWWhewoFRdWyVMn9haC0EiFZA==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr32016314wrf.315.1649840088888;
        Wed, 13 Apr 2022 01:54:48 -0700 (PDT)
Received: from zero.. (host-79-54-81-151.retail.telecomitalia.it. [79.54.81.151])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600002ad00b00207b935e962sm638724wry.37.2022.04.13.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 01:54:48 -0700 (PDT)
From:   Alessandro Astone <ales.astone@gmail.com>
To:     tkjos@android.com, gregkh@linuxfoundation.org, brauner@kernel.org,
        arve@android.com, linux-kernel@vger.kernel.org, maco@android.com
Cc:     Alessandro Astone <ales.astone@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH] binder: Address corner cases in deferred copy and fixup
Date:   Wed, 13 Apr 2022 10:54:27 +0200
Message-Id: <20220413085428.20367-1-ales.astone@gmail.com>
X-Mailer: git-send-email 2.35.1
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

When handling BINDER_TYPE_FDA object we are pushing a parent fixup
with a certain skip_size but no scatter-gather copy object, since
the copy is handled standalone.
If BINDER_TYPE_FDA is the last children the scatter-gather copy
loop will never stop to skip it, thus we are left with an item in
the parent fixup list. This will trigger the BUG_ON().

Furthermore, it is possible to receive BINDER_TYPE_FDA object
with num_fds=0 which will confuse the scatter-gather code.

In the android userspace I could only find these usecases in the
libstagefright OMX implementation, so it might be that they're
doing something very weird, but nonetheless the kernel should not
panic about it.

Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
---
 drivers/android/binder.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..18ad6825ba30 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2295,7 +2295,7 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
 {
 	int ret = 0;
 	struct binder_sg_copy *sgc, *tmpsgc;
-	struct binder_ptr_fixup *pf =
+	struct binder_ptr_fixup *tmppf, *pf =
 		list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
 					 node);
 
@@ -2349,7 +2349,11 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
 		list_del(&sgc->node);
 		kfree(sgc);
 	}
-	BUG_ON(!list_empty(pf_head));
+	list_for_each_entry_safe(pf, tmppf, pf_head, node) {
+		BUG_ON(pf->skip_size == 0);
+		list_del(&pf->node);
+		kfree(pf);
+	}
 	BUG_ON(!list_empty(sgc_head));
 
 	return ret > 0 ? -EINVAL : ret;
@@ -2486,6 +2490,9 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 	struct binder_proc *proc = thread->proc;
 	int ret;
 
+	if (fda->num_fds == 0)
+		return 0;
+
 	fd_buf_size = sizeof(u32) * fda->num_fds;
 	if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
 		binder_user_error("%d:%d got transaction with invalid number of fds (%lld)\n",
-- 
2.35.1

