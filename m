Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7AD528ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiEPTtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiEPTn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:43:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACD3ED35
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:42:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l14so4510216pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hj5kYkQm+5pJCHACOG/iSMHm84jLQAzCIMv4tchrLiw=;
        b=ZFlMXIq+IQUeeyDt6fafn2sjvdLxHOAjmD8mb8sFvqASHoEehVDVTCYMkCf1ElZy1X
         p7FthQqGWMKsLygocu8Bd6oL/O7B6yP+HcMJxPBPO+3rCHhrFqtjaATafc7avEsv06QF
         T81J0wbb5LOe3xLJDV/e9aH44Z65F/Iu+buYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hj5kYkQm+5pJCHACOG/iSMHm84jLQAzCIMv4tchrLiw=;
        b=L5RV5X73Zezb0I/lcpR8fc3zyg4kd6Dx6arTkrZF+Mlh/VYmj5EJ0a8rOoIKKXHqG+
         pbXVH0bNAuL1lw7jrd4v0wBehbfxt0gQIOhlesBRSGVRfcE/cK84721/i0OhTmLSRNzr
         R81nZOXcA60xnGNEeMxoSekZBA85zGMJymrIxSnWz5qi1Mg38okshf5BF7lSX16ui7Z6
         eZgBhxYszVpTTGwtuCMU2IaKWIjQu+0KbAlqUakdrEaaDahq3CXKo1kzHSdKFU+iyXoJ
         vPuSmLx5heQjf1GNFDaznSodmQAF8zC64XCFOGiMe/ap3pmakTwHJx6Q8phCKk9VWmG+
         ZzQA==
X-Gm-Message-State: AOAM532XXqz/PIyNjyfyLVXg6Pf2x53fkwfCo/uz3bErbj493b8d66aR
        C2+ibke2Hfdz736DTkTqM6Hacw==
X-Google-Smtp-Source: ABdhPJy3Phtyoud6QuxnsCWAs2iVhdOIMa8wMQ852qGwOtvl+AjbMvDwUeZxRW8GzRvrrn9NebJA3A==
X-Received: by 2002:a17:902:d483:b0:15e:9e44:8a07 with SMTP id c3-20020a170902d48300b0015e9e448a07mr19046812plg.77.1652730171655;
        Mon, 16 May 2022 12:42:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h125-20020a62de83000000b0050dc7628173sm7282259pfg.77.2022.05.16.12.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:42:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] sched/core: Do not treat class list boundary markers as arrays
Date:   Mon, 16 May 2022 12:42:41 -0700
Message-Id: <20220516194241.3064242-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; h=from:subject; bh=UUhCQXF+TJsScoULeerZiaeI/lJVAC/bHGDo6ByIWx0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBigqkx7kVZ/e0yr2DdH/3zd4rgBLL7WPMgcNF3paNW LbCFk0CJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoKpMQAKCRCJcvTf3G3AJiHPD/ 9lSb4utJjgIxavP3rGUgfkcC0PXcXc8Ps6ff/Rq75RS5jqff9QLpLrdgE/KbWOycSznvbAkWw2tZxe VX+xsllAAyK9NrZjrtIqfnwcYMe90VBDv98fdMgHdprktFx81hmnDKGJ6n6ulxTEM+54ADkxlcehTg PP+pQoptZI4EAYl3mtPMTdK1HXikH4gqegkilEl0DzGCfTBbuLjanKQ1+w0RqsNIhA0q8znQxVOVJC rHdEWa+1wm5nh6TT6sXVfCIAUVICqOQ5cpQcQ9cCODvFbi9pxKjOBzHPA7VKbT0uRltVcyWYDkDQn/ mrRO1JdlDi3qL2Te6q2lxcOoqjvjo0NySWt9dOBjvYWMW07Sev95E3OFyBWkYnOagSAjOFi76I1eIZ rZXEPnSy1eTAhpYyI6WyD58OVIxWkl9eXMVWfvpQgFCUyYYypEsroaxgoblsq1L1JYJgO1YP66XhFI iPiyrvyg8hYTA6GZxhxn6LFL/9pIW502TB1g+rlRT4DuDb/kVu4bi9hPPbTlhef7HybRsN+r7ZLtyb mcfMtMVr+EUTkEb2n1m3FiOdMlq2ZDUAEajMs3EYQUvEFyprvi1CYLmIfdHjVJKX1ZY/so/0VqCfHA u2jQBC8KUHUfiYlMb3Z5dmJXiuLGWpHhxL5uJdRJGLJOSWSZCq0wzQNxH+7Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 is very sensitive about array checking, and views all negative
array accesses as unsafe (a not unreasonable position). Avoid the
warnings about __begin_sched_classes being accessed via negative bounds
by converting them to the pointers they actually are. Silences this
warning:

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

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Link: https://lore.kernel.org/lkml/20220414150855.2407137-2-dinechin@redhat.com/
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
 kernel/sched/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..3d31ed9d33fa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2190,8 +2190,8 @@ const struct sched_class name##_sched_class \
 	__section("__" #name "_sched_class")
 
 /* Defined in include/asm-generic/vmlinux.lds.h */
-extern struct sched_class __begin_sched_classes[];
-extern struct sched_class __end_sched_classes[];
+extern struct sched_class *__begin_sched_classes;
+extern struct sched_class *__end_sched_classes;
 
 #define sched_class_highest (__end_sched_classes - 1)
 #define sched_class_lowest  (__begin_sched_classes - 1)
-- 
2.32.0

