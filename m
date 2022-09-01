Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA4B5A9E42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiIARig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiIARhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:37:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA229C227
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v5-20020a2583c5000000b006964324be8cso4906862ybm.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=e91/L3Bkt1w9DT3T0Co0rdM+lRiTKLDE/Mz2x0qV8w8=;
        b=O6gzuYJNv3OY1tULNg+rSFd+sWkIjQSaV6yE8xAfnZPN1YTVFfR+wvj2NeC2hBY0+k
         GIVWJsEk2y8yIAo13lsMU4IUJIgKbBiJ1vv+1z7dNT8xT+lTOjC6URMO5pLiEVmaefML
         PewWj9g+Vcp5HQ91HsRQ365b/kw+OZnJbC/u2QqpxScDN6oJLilMCO5pf8M9kEkOXKy8
         kK1hF6rXLpQy+lNimDC91Nhhjc7ZyM02kAhq+89cKu94J6/Mxp9HnTyvO1IKLxhNY5UV
         lVIZFG9WwP01TdBwwmdFuCPUOkErkzSY1WgEGRWny4u3kPuzbkYMq5itJGF6CAoS3las
         sKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=e91/L3Bkt1w9DT3T0Co0rdM+lRiTKLDE/Mz2x0qV8w8=;
        b=UKafHBhd6xxq0kXETC0/pS4qYbitY2BWtKw/rh9jqFBq8xNAOI1Heh25ZMcPuPkHS9
         JiWFKQAbMDcQUZziEZB+iPX99ef2YOHM8brLelOhIa0Og1AoMyiAW1a57eLVCW9/UFKc
         rOKhA0LT/w46Ad6fGpO7xCS/VewkFDcZpBpUL4GCb5U2rtlKbfl5eIxJurNm+i0I+AyZ
         sHOou8SVQl1snAEPfgJGLU65Hf2GqG+P3IEAqRaqZNt6GNEWhTg4r3zx4Q74FIs7PfOy
         N6ZVjH+VhKe7Q0g7jcDO2lzwRaFemKSvW+aWGrING29Dk7lucgtvBaUafGFGJ6XQ8xId
         YexA==
X-Gm-Message-State: ACgBeo1zgO7uggOAGsoL92K91KMbqa59Q2E7cKV5Xe6mH1xPp2GQP6VZ
        z84fg3ZiH3XtVVIJcT1WvwVuQ/IgKYo=
X-Google-Smtp-Source: AA6agR6JzhhY8hWMnjFDm/o9DPxBMt9dAFxOiR6uxCkipERPD2P+sojVgosImEy5Q2VS3ZGfPJeoFsIcTII=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a05:6902:154d:b0:695:d8b4:36b2 with SMTP id
 r13-20020a056902154d00b00695d8b436b2mr21142474ybu.599.1662053786750; Thu, 01
 Sep 2022 10:36:26 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:13 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-26-surenb@google.com>
Subject: [RFC PATCH RESEND 25/28] arm64/mm: define ARCH_SUPPORTS_PER_VMA_LOCK
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
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

Set ARCH_SUPPORTS_PER_VMA_LOCK so that the per-VMA lock support can be
compiled on this architecture.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9fb9fff08c94..0747ae1f3b39 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -93,6 +93,7 @@ config ARM64
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
-- 
2.37.2.789.g6183377224-goog

