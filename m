Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60464894FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243280AbiAJJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242724AbiAJJMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E4BC061756;
        Mon, 10 Jan 2022 01:12:16 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso21771817pje.0;
        Mon, 10 Jan 2022 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKTMUEDPmhQm52YOgdwkcpYTtV0KPgGhD+PMcaIjPHo=;
        b=i8Lo0Yw1U8tKhsezqg+GEtufsEuozr5Xsl3OySgcCoXxFzRoFHOwxGT9wyvEeaymVs
         GWDs/N6TUlNfrFfU/3uCybGeCeRYPHAvsnRt9FI8ELikS2W68ccrDert0r58e28Ic/nP
         24n9sT4BCgqrO7337rwgp7sBmKvK2rwr97NWW/M1YzwUV23EZMT/ILzv9/PMvMs8lto8
         KyMXV53IAsbmmu86sTEj0QIt5yoZRGLSm7Xi8IYN/6isqfM44Q+iFMuO6KSxf2qFHsx5
         zrHenpPDRJZGR2+XncacuRkcI3WCwkVBONesHznbVGmansTWS7m3k8Tt86gjpm0mBkaK
         tX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKTMUEDPmhQm52YOgdwkcpYTtV0KPgGhD+PMcaIjPHo=;
        b=1mRC5mKL2TzQHIjQuSapxmVZYB+Pm89tJIYalxG4bKf4VJwXBTukFoua45z67Hb06V
         fxEeIlta/1Jy2bBfXTmsl1sjGPNE0d+WCh0NNULyRxOCfo9cwL6gaYjUhcoP40gRYiJP
         YGatHSnxzh7eG9rJc52Ld5bPLM4RjRUEStZGhe2k4Wf+Dcxma+iscXf4gtFeTbdG8CC3
         dumE6n6yonv4LRmWCd/dwjfpPEQKx33J3+FUfs5W1c0h20Qq1vO34Fa8YHkIZi3MyHRq
         F4fMbw28C5QSM9bFUbctZJW0qB42t4fRRfC3/L/xetjVnJHh4FIj0oAzrfnbc8hU0PXZ
         D5eg==
X-Gm-Message-State: AOAM531Ua32qr2aECEBHYBbM/z+UcrIROKo/8T0+/XpiV0sgbmUthcoN
        0W5NJ0BcIfFkafdrU8MJON4=
X-Google-Smtp-Source: ABdhPJxkPQeT/5kSNCySOOU6xiXE6T4y8PsZtgghWGm9d/n6HyyARjeVFsxfXNFusu+/510EGjgTDQ==
X-Received: by 2002:a17:90b:4a48:: with SMTP id lb8mr476251pjb.54.1641805936211;
        Mon, 10 Jan 2022 01:12:16 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:15 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] cgroup: export following two interfaces
Date:   Mon, 10 Jan 2022 17:10:37 +0800
Message-Id: <20220110091046.17010-5-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110091046.17010-1-jianchao.wan9@gmail.com>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jianchao <wangjianchao@kuaishou.com>

This is a preparation for making blk-rq-qos modular, there is no
functional change, but just export interfaces pr_cont_cgroup_path
and cgroup_parse_float.

Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
---
 include/linux/cgroup.h | 5 +----
 kernel/cgroup/cgroup.c | 7 +++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 75c151413fda..1a67b0db00db 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -666,10 +666,7 @@ static inline void pr_cont_cgroup_name(struct cgroup *cgrp)
 	pr_cont_kernfs_name(cgrp->kn);
 }
 
-static inline void pr_cont_cgroup_path(struct cgroup *cgrp)
-{
-	pr_cont_kernfs_path(cgrp->kn);
-}
+void pr_cont_cgroup_path(struct cgroup *cgrp);
 
 static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194de39c8..f358d5122033 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6597,6 +6597,13 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
 	*v = whole * power_of_ten(dec_shift) + frac;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cgroup_parse_float);
+
+void pr_cont_cgroup_path(struct cgroup *cgrp)
+{
+	pr_cont_kernfs_path(cgrp->kn);
+}
+EXPORT_SYMBOL_GPL(pr_cont_cgroup_path);
 
 /*
  * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
-- 
2.17.1

