Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711574AE494
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388440AbiBHWc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386195AbiBHTnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:43:39 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E49C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:43:38 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i30so243639pfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/az7RkqUaZSIeoYuZW+qHEklI+WUcZiVSMlf0uKOOFw=;
        b=JOsxju/wOm454arqDgajrlARrWDaVLj0HR7UVryPAnxH7XH7HS8UGf5OS/oLAwCAnd
         yhIdC/jNbcvc8TgSJjnkcLoa4wCNqJd0xR5Ou3Tv7VZ1HwFWoACM9svSynMCHE/yPwRE
         9/cLp0vFcYNRrCPRNTtT+N0Cqn/9QBZnVT83EykUzknVIZhwNfYd7CmYfrZBtLvOZV8/
         nZT1nZCnitQrXPUkF9pOg5bbo0LXk/RmmiAzf3OZftfm19cajiJoZPz09/QUz6Hh7hN1
         XhDXXR3tfcozRmC1cj3Q/1tHicZQnip4coOUaiJiBBgtRMISyd7VVW3vHj1wiK8UuyNz
         nSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/az7RkqUaZSIeoYuZW+qHEklI+WUcZiVSMlf0uKOOFw=;
        b=6yhl3xIyMN3Zzt0v0OT1Xyip3FLYPuXS9hVPGfTOfxFS94vE6k5hw/UtAUiOWXOxDN
         r1A3jyg0TgUzmgGoplmAffbStdxeXLZWBvRMfdo14hz+Ue3qJw/4f2pxaQ0VVqHE4cEI
         oHkCyE4R8BnD3d/PKrqMY1Hs12I+tzMDYO0GaExhodOBb0q1qssRm7EtOkKZzMKM/nDb
         YSLfKH3iDzeD88hGr6J7yeGcQ+WXkqsLEaw0CmsE5q12OWEtzQCB8pij14UjV9ElCIZq
         mMRWLsyEL7Jgmh9oT2cYZakywoHpAUU9QaDynYFGpzQG3UqiHeGJbEVE65++wdnhx9ZF
         3rTw==
X-Gm-Message-State: AOAM532fIvTu9a6gLloKdmfaG7zRlC6oMS4Yz/tvI8UZlSbZ0GynNBOi
        my2bgyoiUlwrrzR1XtY44MM=
X-Google-Smtp-Source: ABdhPJw2un2/IIK5To0WebGHV3SG+FNgAkkT4/lDOq/MmV3Nb41SBSDz0MTtmaYkhZzNNFqr33k7Pg==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr4763109pgb.462.1644349418094;
        Tue, 08 Feb 2022 11:43:38 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:c6f0:347f:e607:176:4358])
        by smtp.gmail.com with ESMTPSA id w11sm16876839pfu.50.2022.02.08.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:43:37 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>
Subject: [PATCH 01/12] locking: Pass correct outer wait type info
Date:   Tue,  8 Feb 2022 11:43:13 -0800
Message-Id: <20220208194324.85333-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208194324.85333-1-namhyung@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lockdep_init_map_wait(), it didn't pass the given outer argument
to lockdep_init_map_type and use LD_WAIT_INV unconditionally.  It
seems like a copy-and-paste bug, let's fix it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 467b94257105..0cc2b338a006 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -192,7 +192,7 @@ static inline void
 lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 		       struct lock_class_key *key, int subclass, u8 inner, u8 outer)
 {
-	lockdep_init_map_type(lock, name, key, subclass, inner, LD_WAIT_INV, LD_LOCK_NORMAL);
+	lockdep_init_map_type(lock, name, key, subclass, inner, outer, LD_LOCK_NORMAL);
 }
 
 static inline void
-- 
2.35.0.263.gb82422642f-goog

