Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D54C0C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiBWF2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiBWF0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:26:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16006A06E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:17 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d306e372e5so163264787b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MBcUE/GjgKAOqkE7k3I16nNGFc2xdrG3rcZqdKaqU1M=;
        b=huyqkiXgbsdUUaeO2YcSpDguTaIsD2ZiHBttX5Znp2Wu7SotB1quckmXNNZhq3hhVZ
         CvfghBA5TRiyV7nNwREBXze4Ut4RZl9/dXE69gre6OrHccOhGsM1R39ve/3Fg95dFOoY
         BvDeP6788/BG9zG4uemrkiHvTMwkxVsftUJqZuGB4ivr+/aWtu4qk7dIqmSXEwo1GhxB
         UQrfqBGsjla2ZXhbWoUWiWOKjoE4zvV4OfIuCxJHeuNkl1zKwODoNYWYiaOMSwj9wOKz
         BS0K9yywZ4zV80Is1LL2lLof7xLiZKUcwJTWCzQDyX5SOghoozr2KNat8Mt1uT82lph4
         NHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MBcUE/GjgKAOqkE7k3I16nNGFc2xdrG3rcZqdKaqU1M=;
        b=fadY7nuPGCjs2m8c4anZz0ZNASynst2NWM9WoKFAF/r7bGQFanBdCtVezGRTI8CEPY
         34kHJBWq5HrUHPp7jsBSxkBsoEv/PKqZS2gLO7k0h43gHRZqeC/5te7rMJgIVRvrY9g3
         gBQtPURAyXr6dyYpU67isYyWlObJUvQKCj2CgIEsGhjk67xn3vgUae5ka2hWbdimimVS
         2da3NWWv9m759gbG2kFo9UN0qbH2+8cocjE5V7bWuFVbIII9tZGsOWff0LoxvPqIJGr2
         AJqT5IHXMw8aoQWEjXzbwrL/zYhuPnYcp8qLL7IgnsYxwDrGvxyYGTenJPiU4iPKIY9x
         j+vw==
X-Gm-Message-State: AOAM531v3k0x79rP3cGruSJV4dXneT/qNfNlbQpUMEv4J1aIe6eobO87
        r9wbpU4PFKviCkvtcJ3TMGa3GrvdKF0G6jFhw6vI3lsKilnwpzlfBvYcwFjHgwCZeYJ2iNlR+q7
        uUcYFbWDmcsFi/IwkqDLOlbRYnWgjUq//DnYceEofJG8HxVQJlVIljlIkGv9hX+x2fyyhNTwV
X-Google-Smtp-Source: ABdhPJzeh7uokPy0ce1B9Y+L+/uH+xpWq2sOY5OlnwbNrO2jfXStVDw+VQrszqUGfmnR9pf7y3TYhwx7yyIZ
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a81:7d56:0:b0:2d6:90d9:770c with SMTP id
 y83-20020a817d56000000b002d690d9770cmr26589608ywc.277.1645593908116; Tue, 22
 Feb 2022 21:25:08 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:22:13 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-38-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 37/47] mm: asi: ASI annotation support for static variables.
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Weisse <oweisse@google.com>, kvm@vger.kernel.org,
        pbonzini@redhat.com, jmattson@google.com, pjt@google.com,
        alexandre.chartre@oracle.com, rppt@linux.ibm.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Weisse <oweisse@google.com>

Added the following annotations:

__asi_not_sensitive: for static variables which are considered not
sensitive.

__asi_not_sensitive_readmostly: similar to __read_mostly, for
non-sensitive static variables.

Signed-off-by: Ofir Weisse <oweisse@google.com>


---
 arch/x86/include/asm/asi.h        | 12 ++++++++++++
 include/asm-generic/asi.h         |  6 ++++++
 include/asm-generic/vmlinux.lds.h | 18 +++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index bdb2f70d4f85..6dd9c7c8a2b8 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -177,6 +177,18 @@ static inline pgd_t *asi_pgd(struct asi *asi)
 	return asi->pgd;
 }
 
+/* IMPORTANT: Any modification to the name here should also be applied to
+ * include/asm-generic/vmlinux.lds.h */
+#define ASI_NON_SENSITIVE_SECTION_NAME ".data..asi_non_sensitive"
+#define ASI_NON_SENSITIVE_READ_MOSTLY_SECTION_NAME \
+                       ".data..asi_non_sensitive_readmostly"
+
+#define __asi_not_sensitive \
+    __section(ASI_NON_SENSITIVE_SECTION_NAME)
+
+#define __asi_not_sensitive_readmostly \
+    __section(ASI_NON_SENSITIVE_READ_MOSTLY_SECTION_NAME)
+
 #else	/* CONFIG_ADDRESS_SPACE_ISOLATION */
 
 static inline void asi_intr_enter(void) { }
diff --git a/include/asm-generic/asi.h b/include/asm-generic/asi.h
index fffb323d2a00..d9082267a5dd 100644
--- a/include/asm-generic/asi.h
+++ b/include/asm-generic/asi.h
@@ -121,6 +121,12 @@ void asi_flush_tlb_range(struct asi *asi, void *addr, size_t len) { }
 #define static_asi_enabled() false
 
 
+/* IMPORTANT: Any modification to the name here should also be applied to
+ * include/asm-generic/vmlinux.lds.h */
+
+#define __asi_not_sensitive
+#define __asi_not_sensitive_readmostly
+
 #endif  /* !_ASSEMBLY_ */
 
 #endif /* !CONFIG_ADDRESS_SPACE_ISOLATION */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..c769d939c15f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -374,10 +374,26 @@
 	. = ALIGN(PAGE_SIZE);						\
 	__nosave_end = .;
 
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+#define ASI_NOT_SENSITIVE_DATA(page_align)                              \
+       . = ALIGN(page_align);                                           \
+       __start_asi_nonsensitive = .;                                    \
+       *(.data..asi_non_sensitive)                                      \
+       . = ALIGN(page_align);                                           \
+       __end_asi_nonsensitive = .;                                      \
+       __start_asi_nonsensitive_readmostly = .;                         \
+       *(.data..asi_non_sensitive_readmostly)                           \
+       . = ALIGN(page_align);                                           \
+       __end_asi_nonsensitive_readmostly = .;
+#else
+#define ASI_NOT_SENSITIVE_DATA
+#endif
+
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
 	*(.data..page_aligned)						\
-	. = ALIGN(page_align);
+	. = ALIGN(page_align);                                          \
+        ASI_NOT_SENSITIVE_DATA(page_align)
 
 #define READ_MOSTLY_DATA(align)						\
 	. = ALIGN(align);						\
-- 
2.35.1.473.g83b2b277ed-goog

