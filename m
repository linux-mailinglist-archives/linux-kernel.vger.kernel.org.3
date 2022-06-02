Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4AF53C0FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiFBWsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiFBWr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:47:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2215BCA5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 15:47:56 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h1so5598697plf.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qhaR4e3vQjTLHvjrXQ9re1JFbmDeoxPoZ7W193bvUbU=;
        b=IA3E5PQIq4uDRkPun/Z2gHm34/GwwSEiI+6cTnHaVjb6Jg02RdGH0gZUqxZPUuY8Eq
         +IwTCUfLIKeX+QJfuh13pJurnBjkJFDC21FezD/V+f6FmtnesJ5KTFr4CHsJGJSPYTS9
         MorbPEf8eYpnb6TyefejlvRm+wevB7izJaDF/N7kBAD9xuKBlG0Rc+A0l8EJLeLc0PXd
         jb0GazTVJTj7BDjzIUFAv5SnZoS5UU/fQNXn28MRmGEG6kqbYpPc+7Wbu+P90lPzF+Le
         7tKC6cNZnRMbBHLkx6jtRk9kCfziB0f3NWyUKali6387OvpEPt4DsFLzwo7UOHpVwhIb
         R1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=qhaR4e3vQjTLHvjrXQ9re1JFbmDeoxPoZ7W193bvUbU=;
        b=rD9F/HMw6/azSrHrPWkeAOrJDKN7n3PA/7X3olueROEgG76sgYAEBh6qUXItl04+on
         tOPNohqBAyM2GiOJk9sHB8762AcFWcACaDcXUoptnEF5Xb7xyZPYblNJkMrwzosgGmcQ
         wnUH7+AlP3947+ougFvgB0uh8r2b8kn26iGCFtjcdAdjlxQE9kOAqUI6BWgxGpd8GAo5
         +HhvPGVJZ/K8wN0R9HimuF9blpz8ehyBc4cqu+Wuuh/x5iTw2gMyYUjMsPdplFml6P76
         q+J1FmSqNWS3QL8Rmgl/Rq6ElKS3nsZ+8mvHsObHBtD96IabgtIiy/TVsnd2fQc9RkNL
         VEDg==
X-Gm-Message-State: AOAM532oQzvJl4BeUaMyeDfKIdcPQZqfsfvQnsUAQs0h4WymQshwMka+
        kZqeyatx5kZHqcQ3gQG/nNI=
X-Google-Smtp-Source: ABdhPJzvamBhV69v7cfaRL7jQWcjsTv95DqdPHYhCvPEBjgRtSKS7SC2UlK6KcDuUXVUBh4JsAe2jw==
X-Received: by 2002:a17:902:d491:b0:167:49df:6e00 with SMTP id c17-20020a170902d49100b0016749df6e00mr160292plg.148.1654210076137;
        Thu, 02 Jun 2022 15:47:56 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:84f2:5eb8:b22d:654d])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902cf4300b0015e8d4eb29csm3975062plg.230.2022.06.02.15.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 15:47:55 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        James Morris <jmorris@namei.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] perf/core: Call LSM hook after copying perf_event_attr
Date:   Thu,  2 Jun 2022 15:47:54 -0700
Message-Id: <20220602224754.602074-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
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

It passes the attr struct to the security_perf_event_open() but it's
not initialized yet.

Fixes: da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7858bafffa9d..e035545f624f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12033,12 +12033,12 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (flags & ~PERF_FLAG_ALL)
 		return -EINVAL;
 
-	/* Do we allow access to perf_event_open(2) ? */
-	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
+	err = perf_copy_attr(attr_uptr, &attr);
 	if (err)
 		return err;
 
-	err = perf_copy_attr(attr_uptr, &attr);
+	/* Do we allow access to perf_event_open(2) ? */
+	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
 	if (err)
 		return err;
 
-- 
2.36.1.255.ge46751e96f-goog

