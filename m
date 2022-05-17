Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC452979D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239606AbiEQDAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiEQDA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:00:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6046660
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:00:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v11so15722478pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oDXyhpDBl0Jo1eKHOlaQtjHRyKXTitgCILk3NSE03E=;
        b=j9UiWFe1CcVfL56kGJWu7qwlU1Mywa1IA9wK5YAICPea5uh55XHx6L9AjyfE8mcOpz
         r4UQfo3+vsT7qJo6Jx444VhMIppCts6xbWsfAiqCbG58MjQIqYrLkOoZ2kZjqxSjZktt
         FrJTfkMXrxalLarfnB+EuV5li2wOibdCJtYXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6oDXyhpDBl0Jo1eKHOlaQtjHRyKXTitgCILk3NSE03E=;
        b=fsaVXHyhM4t7tU9ovCwdd290A2ILTFLCsAWIdjJDnpUGpKJ+L4NBuoXYf0NbK76Zrr
         FTvb6bh6F/3heyZgwNu2iUP4DF66oTlqfChW84t+NBU2Y8VSJrQaovsmfyeonBTmPXfz
         GH886ZFq6RZGDgtig0hehJAEGNJ+O13w/eIv6wCzNIgtc5zTiVA7j6g/SM97tTIcLtsv
         LMmeij72BLlBmdsGDManpS1zZ/rHnFq2+QgDmdzjbB9ENNLazusP+jczdZOUq+Y6rZtg
         8kY9hUeWEahCUIUiml3ZevhSpz48NXf0Pf1shUM/v/LW0x7RYPNQmFpGja35JCN2IHhV
         v68Q==
X-Gm-Message-State: AOAM533hNw2fmBNHkIWAXRvMGwd1q2amr65DGMAqDi2uJKN5EWPCMbRZ
        +RmaYNQsA3yO7EdvewdDAnM16nE9UnzmTA==
X-Google-Smtp-Source: ABdhPJyrTrHLcfZFlpWOxDT98h0VjkyGtAzB1+zKS0LgpTJyDE4ZwFrXoUoWaKks5naQsOotVEv2sw==
X-Received: by 2002:a05:6a00:2985:b0:510:66a4:375d with SMTP id cj5-20020a056a00298500b0051066a4375dmr20573420pfb.18.1652756426526;
        Mon, 16 May 2022 20:00:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db8200b001616b71e5e6sm3715010pld.175.2022.05.16.20.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:00:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] sched/core: Address classes via __begin_sched_classes
Date:   Mon, 16 May 2022 20:00:23 -0700
Message-Id: <20220517030024.3388355-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6031; h=from:subject; bh=KdhucHycTGYVE+04wzrP136yo4J21OP5siXew/NO9Gs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBigw/HvIcI28VIr/wNNWf8zJHdhh2HUCa9vv4KX+DN mLxfvOuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoMPxwAKCRCJcvTf3G3AJpeuD/ 9ZD0w/FM2zL6lsnv54UU34zEJXcEN97d6Rj/+GYy7vHWIej8WPerxmsmvjxCWVbNZ7jO0lY+XHMHyZ InccVpDnPmrPwhSQLV7+XsnxkauuAP5lNFR3E11U4zSnK8B8zX2t8XYusXYM/YhJwvhqL5f6Qh8jGx 97hSeORGq4cLZXnZmL9qBCtHe8ukotmPxwn1RD1cUUb7RPfYexRMZBZ19wU1AnI6HeGNqaj+Gyfc8d HHwNHN1mD02QwwMR6I0kJ5x5jeOPRK/tekqY9bbAtfqz/N/igkC8v8AZ9djo3vgAYgV1oBgUaMVOhY 3Q9CJHyo7R1lXNftAfP3/tIFh9BE0uT3FdAESryQsA5mUpeF6bXZ51ssUp28ECTEBlyww2euZMyzuS pd0nZ1cEWBdkwVDrXbIyyI59w+hL+AtJ4h4X+z5lNxhRT9MgScqz1ZHEobseR1mrMjXMWeE0YPzReS LrMss9UaCsutL7fECp0w8yY+hfq+feyrVO/YQbdMxzzOQFkIoGSGs6jnjvwJd0E4t5UvqFHGVkyWqP VblMGXtpdYbF113Ycvo0MCK8GhR4JEzAk9/XTV8i4J4IF3Nx3UzAYvhjmpB9Y8JJU1cxJ2/F4MFGDB krxZkSo0nwPJtmKXIo7xmaezgwiB/CK8rpKubpyMZmBr1KgCD+dCDpwAGXiQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 is very sensitive about array checking, and views all negative
array accesses as unsafe (a not unreasonable position). Redefine
sched_class_highest in terms of its location from __begin_sched_classes,
and redefine sched_class_lowest to the actual lowest sched class instead
of one lower. This also means the for_class_range() must be redefined to
be inclusive, which means its 1 caller must be adjusted to have its
"lowest" argument bumped up one position. Silences this warning:

In file included from kernel/sched/core.c:81:
kernel/sched/core.c: In function ‘set_rq_online.part.0’:
kernel/sched/sched.h:2197:52: error: array subscript -1 is outside array bounds of ‘struct sched_class[44343134792571037]’
 [-Werror=array-bounds]
 2197 | #define sched_class_lowest  (__begin_sched_classes - 1)
      |                                                    ^
kernel/sched/sched.h:2200:41: note: in definition of macro ‘for_class_range’
 2200 |         for (class = (_from); class != (_to); class--)
      |                                         ^~~
kernel/sched/sched.h:2203:53: note: in expansion of macro ‘sched_class_lowest’
 2203 |for_class_range(class, sched_class_highest, sched_class_lowest)
      |                                            ^~~~~~~~~~~~~~~~~~
kernel/sched/core.c:9115:17: note: in expansion of macro ‘for_each_class’
 9115 |                 for_each_class(class) {
      |                 ^~~~~~~~~~~~~~
kernel/sched/sched.h:2193:27: note: at offset -208 into object ‘__begin_sched_classes’ of size [0, 9223372036854775807]
 2193 | extern struct sched_class __begin_sched_classes[];
      |                           ^~~~~~~~~~~~~~~~~~~~~

The introduce and use of sched_class_higher() could just be a bare "+ 1",
but this code's backwards walking and non-inclusive for loop was weird
enough, it seemed back to explicitly describe the manipulation
happening.

These can't just be object pointers because GCC still sees it as an
address of a single struct.

The resulting instruction output is identical to before except that one
less register is used in set_rq_online(), where an immediate can now
be used, resulting in a small instruction count savings:

│  set_rq_online():
│ -	push   %r12
│  	push   %rbp
│  	push   %rbx
│  	mov    0x9a0(%rdi),%rax
│  	mov    0xa10(%rdi),%edx
│  	lock bts %rdx,0x20(%rax)
│  	movabs $0x0,%rbx
│   R_X86_64_64	__end_sched_classes-0xd0
│ -	movabs $0x0,%r12
│ - R_X86_64_64	__begin_sched_classes-0xd0
│  	movl   $0x1,0xa14(%rdi)
│ -	cmp    %r12,%rbx
│ -	je     31ea <set_rq_online.part.0+0x5a>
│ -	mov    %rdi,%rbp
│ +	cmp    $0x0,%rbx
│ + R_X86_64_32S	__begin_sched_classes
│ +	jb     31e6 <set_rq_online.part.0+0x56>
│ +	mov    %rdi,%rbp
│  	mov    0x70(%rbx),%rax
│  	test   %rax,%rax
│ -	je     31de <set_rq_online.part.0+0x4e>
│ +	je     31d6 <set_rq_online.part.0+0x46>
│  	mov    %rbp,%rdi
│ -	call   31de <set_rq_online.part.0+0x4e>
│ +	call   31d6 <set_rq_online.part.0+0x46>
│   R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
│  	sub    $0xd0,%rbx
│ -	cmp    %r12,%rbx
│ -	jne    31cd <set_rq_online.part.0+0x3d>
│ +	cmp    $0x0,%rbx
│ + R_X86_64_32S	__begin_sched_classes
│ +	jae    31c5 <set_rq_online.part.0+0x35>
│  	pop    %rbx
│  	pop    %rbp
│ -	pop    %r12
│  	retq

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Link: https://lore.kernel.org/lkml/20220414150855.2407137-2-dinechin@redhat.com/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220516194241.3064242-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220517000630.3383144-1-keescook@chromium.org
v3:
 - Add missing increment to the one for_class_range() user
 - Provide instruction sequence change analysis in commit log
---
 kernel/sched/core.c  |  3 ++-
 kernel/sched/sched.h | 11 ++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d58c0389eb23..f2bcc7f15381 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5665,7 +5665,8 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * We can terminate the balance pass as soon as we know there is
 	 * a runnable task of @class priority or higher.
 	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
+	for_class_range(class, prev->sched_class,
+			sched_class_higher(&idle_sched_class)) {
 		if (class->balance(rq, prev, rf))
 			break;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..c757bd26b01a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2193,11 +2193,16 @@ const struct sched_class name##_sched_class \
 extern struct sched_class __begin_sched_classes[];
 extern struct sched_class __end_sched_classes[];
 
-#define sched_class_highest (__end_sched_classes - 1)
-#define sched_class_lowest  (__begin_sched_classes - 1)
+#define sched_class_higher(class) ((class) + 1)
 
+#define sched_class_highest (&__begin_sched_classes[__end_sched_classes     \
+						    - __begin_sched_classes \
+						    - 1])
+#define sched_class_lowest  (&__begin_sched_classes[0])
+
+/* For each class, inclusive from _from down to _to. */
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class--)
+	for (class = (_from); class >= (_to); class--)
 
 #define for_each_class(class) \
 	for_class_range(class, sched_class_highest, sched_class_lowest)
-- 
2.32.0

