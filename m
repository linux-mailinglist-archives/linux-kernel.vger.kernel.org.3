Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB34C0BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiBWFZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiBWFYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:24:54 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B786AA63
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d07ae1145aso162060697b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A2kZT9A4P8bW0lI9YOtf1wQA9jJkQ1koWvhOh//ocUo=;
        b=fbSsueZGuBScgzqcY02VIl0ILFLXpPlKdSo5ctJYl8kSPI7w0kDZ1uGY8ujtC+fl+e
         PEzsS5j+6h2lyRr/UrTBatrXvU4f3NErvUAR7v4X1dzKu33iDdHE2QCAop5cuA3atf5U
         EJ4V1Fx706MmP14iSjNuJdP3U5u2B16C5Fj3e/UoRc8fZC4srXBJUArKZJ67Qxmu0hNA
         BsPOvLUKtyHj9nuWAemSw1G1+wDLXUYyYOFHHc5fb0JSBY7PBPNYf4tS05DMNxCxy6ed
         1VKdWkC7HesYHDOsvNnF5BnhxEmTplkx92VqdXNvb7r03sGqA/SDTfz8vVfIQeADD5L1
         ir/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A2kZT9A4P8bW0lI9YOtf1wQA9jJkQ1koWvhOh//ocUo=;
        b=rUshBPEAU9TvpiLZ7h8fDoROMy9Kmaxns506Fmm2/9httuso15ookwNlK9sghp0vMv
         Kp09GNvoi3uPJWuvX9lZQ7Xs2fCyGAtWr0oxCIKtKC4PVLrGF/PthNsYZChINEt/7E3S
         /SkflYp+oI6s4EM41xa0Ej5odZI0+glT3/E+Xw3SczfRaZKBhYRE09uaV46oSzF7vM++
         +PgeBg71t1TQBBS+cXmk5UGpYKcQLKyD1T6G0ci/xzHh6ZfcHysWWmbBSRwIYzNo03xb
         z4+YvAlNWW5CSK80b08ELQ3KRjzLUnvDmWJKRoP/BCLIDwJ9YbWl1op/F8wfQOdBt/E2
         swZA==
X-Gm-Message-State: AOAM532M3Q8nOg/nO/ZzPR8/VbC9UrAq1RLt89EVEf4tAG4hNmn8uxZX
        YcYiHAY4NV/zx2wQdh+PdD/b2uIjNJwOv4PI+VELO8TEozfgFWzrbi2pfqO3FrPxrAD7fY8SjI4
        h0xtHrWm+eE7sWbPqGRiEnjhf4gvl+kv164PrsEdcxfXjMBBWG5VeckwVlUfosdvDFFua2X6O
X-Google-Smtp-Source: ABdhPJx1fLXJ2Nd+XyAyj3SwtD/6yx9YWclO/RpwDKJJBLCMeXbY/FNMqCpTASogEOd+LsJ96uLWXmi1HY+9
X-Received: from js-desktop.svl.corp.google.com ([2620:15c:2cd:202:ccbe:5d15:e2e6:322])
 (user=junaids job=sendgmr) by 2002:a81:1d8c:0:b0:2cb:da76:5da8 with SMTP id
 d134-20020a811d8c000000b002cbda765da8mr27707177ywd.165.1645593845809; Tue, 22
 Feb 2022 21:24:05 -0800 (PST)
Date:   Tue, 22 Feb 2022 21:21:45 -0800
In-Reply-To: <20220223052223.1202152-1-junaids@google.com>
Message-Id: <20220223052223.1202152-10-junaids@google.com>
Mime-Version: 1.0
References: <20220223052223.1202152-1-junaids@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [RFC PATCH 09/47] mm: Add __PAGEFLAG_FALSE
From:   Junaid Shahid <junaids@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, jmattson@google.com,
        pjt@google.com, oweisse@google.com, alexandre.chartre@oracle.com,
        rppt@linux.ibm.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
        linux-mm@kvack.org
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

__PAGEFLAG_FALSE is a non-atomic equivalent of PAGEFLAG_FALSE.

Signed-off-by: Junaid Shahid <junaids@google.com>


---
 include/linux/page-flags.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b5f14d581113..b90a17e9796d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -390,6 +390,10 @@ static inline int Page##uname(const struct page *page) { return 0; }
 static inline void folio_set_##lname(struct folio *folio) { }		\
 static inline void SetPage##uname(struct page *page) {  }
 
+#define __SETPAGEFLAG_NOOP(uname, lname)				\
+static inline void __folio_set_##lname(struct folio *folio) { }		\
+static inline void __SetPage##uname(struct page *page) {  }
+
 #define CLEARPAGEFLAG_NOOP(uname, lname)				\
 static inline void folio_clear_##lname(struct folio *folio) { }		\
 static inline void ClearPage##uname(struct page *page) {  }
@@ -411,6 +415,9 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
 #define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)	\
 	SETPAGEFLAG_NOOP(uname, lname) CLEARPAGEFLAG_NOOP(uname, lname)
 
+#define __PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)	\
+	__SETPAGEFLAG_NOOP(uname, lname) __CLEARPAGEFLAG_NOOP(uname, lname)
+
 #define TESTSCFLAG_FALSE(uname, lname)					\
 	TESTSETFLAG_FALSE(uname, lname) TESTCLEARFLAG_FALSE(uname, lname)
 
-- 
2.35.1.473.g83b2b277ed-goog

