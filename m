Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA55A2C31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbiHZQVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbiHZQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:21:31 -0400
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F8DD77E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:21:30 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso8564497pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UHxQNac7+y6T8HuGfiFe8GQdrtI4xLbtO21BSRiD3iY=;
        b=OLvxdcq+e9sygai/ODa7nXQFO3vWSFjSqk2uC515dUhqK80k6gD2Rcokg1T0cNSqI0
         XQOHpxv8sLh1+11gYa6bnIw07Cm3+rYAN20O/cCVRxSmBiXUqn4F7dMg1zb577yNHJWR
         ALCk3TuHjRbcjcl0XQpHCa6KmxoFIFZJtqW82+F1y3X12YvwlP7FRo0iXBFuBJZNS5IW
         pmlYH9b9HJXOx3rKcWXPQkTcuHEdT27v9oh1ZFMcqIAl5Bdaagm3NVaHKW6T5OgCJoLC
         IirtG1jP2wt9dyKfEzuPK6JjiAZlvVpieWeR6ph/4hrL4soFNz7ub5CgwxGyd+VOgjLY
         FECg==
X-Gm-Message-State: ACgBeo1a+X8YB8JOWfr99OdnGOfHFVJA14by/HbHsHA/SRix5cKbHy3R
        wEWV9XQxeE8KlFmAEETS95o=
X-Google-Smtp-Source: AA6agR7569BCSuk2CkAI6DTAiTClaYf70CfQxCaRkJFxLbUSlRbdJ16kpGNe4GYk/hwJhFeqWR9qjQ==
X-Received: by 2002:a17:903:134d:b0:172:e199:bb39 with SMTP id jl13-20020a170903134d00b00172e199bb39mr4301800plb.154.1661530889774;
        Fri, 26 Aug 2022 09:21:29 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a12:b4b9:f1b3:ec63])
        by smtp.gmail.com with ESMTPSA id cp7-20020a170902e78700b0016ee328fd61sm1790077plb.198.2022.08.26.09.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:21:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Isabella Basso <isabbasso@riseup.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sander Vanheule <sander@svanheule.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] overflow, tracing: Define the is_signed_type() macro once
Date:   Fri, 26 Aug 2022 09:21:16 -0700
Message-Id: <20220826162116.1050972-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220826162116.1050972-1-bvanassche@acm.org>
References: <20220826162116.1050972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two definitions of the is_signed_type() macro: one in
<linux/overflow.h> and a second definition in <linux/trace_events.h>.

As suggested by Linus Torvalds, move the definition of the
is_signed_type() macro into the <linux/compiler.h> header file. Change
the definition of the is_signed_type() macro to make sure that it does
not trigger any sparse warnings with future versions of sparse for
bitwise types. See also:
https://lore.kernel.org/all/CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Isabella Basso <isabbasso@riseup.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Sander Vanheule <sander@svanheule.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/compiler.h     | 6 ++++++
 include/linux/overflow.h     | 1 -
 include/linux/trace_events.h | 2 --
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 01ce94b58b42..7713d7bcdaea 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -239,6 +239,12 @@ static inline void *offset_to_ptr(const int *off)
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
+/*
+ * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
+ * bool and also pointer types.
+ */
+#define is_signed_type(type) (((type)(-1)) < (__force type)1)
+
 /*
  * This is needed in functions which generate the stack canary, see
  * arch/x86/kernel/smpboot.c::start_secondary() for an example.
diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f1221d11f8e5..0eb3b192f07a 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -30,7 +30,6 @@
  * https://mail-index.netbsd.org/tech-misc/2007/02/05/0000.html -
  * credit to Christian Biere.
  */
-#define is_signed_type(type)       (((type)(-1)) < (type)1)
 #define __type_half_max(type) ((type)1 << (8*sizeof(type) - 1 - is_signed_type(type)))
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index b18759a673c6..8401dec93c15 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -814,8 +814,6 @@ extern int trace_add_event_call(struct trace_event_call *call);
 extern int trace_remove_event_call(struct trace_event_call *call);
 extern int trace_event_get_offsets(struct trace_event_call *call);
 
-#define is_signed_type(type)	(((type)(-1)) < (type)1)
-
 int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 int trace_set_clr_event(const char *system, const char *event, int set);
 int trace_array_set_clr_event(struct trace_array *tr, const char *system,
