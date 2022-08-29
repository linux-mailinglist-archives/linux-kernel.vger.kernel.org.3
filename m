Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8255A5623
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiH2V1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiH2V0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161459E881
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:14 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id by13-20020a056a00400d00b0052ec5a1cd4dso3623103pfb.21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=MrRcKlTR7zCSrJMQg2Z93mfggQWMfDwWeAi691n34gQ=;
        b=cVg/tOxX8sxsAXVi/E7ByEF0x14KVPhZxGLvuX25A7I6HfsUpP9Yw5fhBx8ozeM60j
         nuDrEi09QA9+LTKC8GajK7CQiyi7gN9srLPx+SGJoGK9+OesuSLiR+9oEBujQJz23p/X
         P3t9ZdRyZDRuaF1wtpM+xaufjpbccFTUx81s4naxMNNB/ygFAADiWbtKwBK4coZj6Khw
         l+lkYHWl+iss5qkPjBxcVIZuDHxj8lggM4wnCJgOdoiaVpSSSGOBOp9823YRpnW7UBz5
         1Wlgpr7ZzU0IbMK3CpPADXeW2X4v/4Fep7gHMya9NlwRNw5kCRaApBpvKmaw4X2L8jbG
         4C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=MrRcKlTR7zCSrJMQg2Z93mfggQWMfDwWeAi691n34gQ=;
        b=ICsr0sx9qYmw2ydEzrTVu9NK8yud1dQVIMO3+EY5E4JGncbrctJt+d6ZJ6LS4S7qSV
         EfE1804kHStW+qRVq/hQvhPGZOnCuyaAVTkZ0EcGmhaokFY6+U3mbg7b4paAwR+AcW6b
         Py0UjO2pUvjAVdoM9Ys2Zu84xyuF4aGSgwxwEQspDra4wv6WxZLJikutl+5ciCZxMEJb
         xgWAfECr6nrWhksF6bGe3hPJOF/C7ui6C2Pwb6EjLCN+3kXFygB6ugbtrFrNHjjbxWE3
         hOSCfbrMvhxvpcV4fu6SoXAGfp9eCR+KOGmTYsHyoDGLLlQAhoOV8Nmv+iO0ESvHPUds
         iUAA==
X-Gm-Message-State: ACgBeo1MOD9E5o9ANDH9O/mW4KSsNMar21IdORL23XidO/QNUfYrluVx
        RkSQTbAOY1yFFAHoJkYJ8PwusqXofkU=
X-Google-Smtp-Source: AA6agR6U/5CcVqFo3qhw78HCsOiNZ4QUVwqc0LtUdoOd4ifUOM6ozQmoAsAgpNZOBFg7UV9Y6fDIpWBGaXE=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:aa7:8742:0:b0:537:ee75:601a with SMTP id
 g2-20020aa78742000000b00537ee75601amr12578569pfo.37.1661808368234; Mon, 29
 Aug 2022 14:26:08 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:21 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-19-surenb@google.com>
Subject: [RFC PATCH 18/28] mm: add FAULT_FLAG_VMA_LOCK flag
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag to distinguish page faults handled under protection of
per-vma lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0d9c1563c354..7c3190eaabd7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -466,7 +466,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a03f59c1e78..36562e702baf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -886,6 +886,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_VMA_LOCK =		1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.37.2.672.g94769d06f0-goog

