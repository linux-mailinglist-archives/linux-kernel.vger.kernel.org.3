Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE1451409E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 04:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiD2Cfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 22:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiD2Cfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 22:35:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F1381AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:32:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p12so5833950pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 19:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ey+hAYJ8b1gAtpUUBtom01OH0kHsMue41xJt9D1Saw8=;
        b=hQCmFc9HDJRwhG9gQ1Vbv+tSejruJwt4RobOFksZ+dI/oL1Tq+m1tv3ETsjFo11iGw
         /NPti3BAyl2VLAin3uQEDNNnJXnsbO03gT4aEVOVWbMMHxTwNYr5Uf5PHYXEYi9Q3yjV
         23Y3JqC6JRwjttlovciTqKItWGlg9iaW1eBsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ey+hAYJ8b1gAtpUUBtom01OH0kHsMue41xJt9D1Saw8=;
        b=mt5PAr2nvhzKdHRTslqyCxs4VCTeWYO3ShP4LGw/nNyLe3Frf4GN+KkNXmk0JJGCnJ
         bVPLATgN/whkd4RJtpsLrLdrmwpfQOhVDQv6EXepchmhfBwR5RWxNScLDmNFMxStLenZ
         R95WijjQsqRz+bTaTWQmrIEsYoH8z7Cl0VjvBXkNqoB0JvzgZ4KCMvpbD7XGE2tnl5M+
         +8LdfDO0BFCQPTtY8X1O9Ng32YFJBoZee2I2KBwmqdAjGg2pXabcezxOKeJXzFHYmG4Q
         GymmVt9HyO3y5If65G8PFxaG/yUqYOKCQY2rwr1MH1QFknWmlE3i42VjkglwLU+AFXXU
         QyFw==
X-Gm-Message-State: AOAM5308pQoq7ryUKYhEAPvcrVwZYMDY72eIdJ1Fi4StIvj4ufMSHFHk
        4Y++Q2MZ5Ax0rINWIPM/En7hcQ==
X-Google-Smtp-Source: ABdhPJwAz/cuJOu5q1oNFDbHh2N1ZxuqnUZcyZSqgdtZOF+7GNpdG8Oiozx3+C23eXcyZpd369nDdg==
X-Received: by 2002:a63:7702:0:b0:3ab:4d62:b68b with SMTP id s2-20020a637702000000b003ab4d62b68bmr19734877pgc.452.1651199542559;
        Thu, 28 Apr 2022 19:32:22 -0700 (PDT)
Received: from localhost.localdomain (99-0-82-137.lightspeed.sntcca.sbcglobal.net. [99.0.82.137])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090a640500b001cd4989ff53sm8201125pjj.26.2022.04.28.19.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 19:32:21 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alban Crequy <alban@kinvolk.io>
Subject: [PATCH v3 0/2] Handle seccomp notification preemption
Date:   Thu, 28 Apr 2022 19:31:11 -0700
Message-Id: <20220429023113.74993-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses a race condition we've dealt with recently with
seccomp. Specifically programs interrupting syscalls while they're in
progress. This was exacerbated by Golang's[1] recent adoption of
"Non-cooperative goroutine preemption", in which they try to interrupt any
syscall that's been running for more than 10ms. During certain syscalls,
it's non-trivial to write them in a reetrant manner in userspace (mount).

It allows a per-filter flag to be set that makes it so that the notifying
process will switch to "TASK_KILLABLE" as opposed to returning to userspace
on non-fatal signals.

Changes since v2[3]:
 * Split out addfd patches
 * Move the flag to be per-filter (as opposed to per notification)

Changes since v1[2]:
 * Fix some documentation
 * Add Rata's patches to allow for direct return from addfd

[1]: https://github.com/golang/proposal/blob/master/design/24543-non-cooperative-preemption.md
[2]: https://lore.kernel.org/lkml/20210220090502.7202-1-sargun@sargun.me/
[3]: https://lore.kernel.org/all/20210426180610.2363-1-sargun@sargun.me/

Sargun Dhillon (2):
  seccomp: Add wait_killable semantic to seccomp user notifier
  selftests/seccomp: Add test for wait killable notifier

 .../userspace-api/seccomp_filter.rst          |   8 +
 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/seccomp.h                  |   2 +
 kernel/seccomp.c                              |  42 ++-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 240 ++++++++++++++++++
 5 files changed, 292 insertions(+), 3 deletions(-)

-- 
2.25.1

