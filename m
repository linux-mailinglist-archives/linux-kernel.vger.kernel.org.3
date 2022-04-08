Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC04F8DE8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiDHFAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiDHE7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:59:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5500F1CB01
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:57:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id i19-20020a17090adc1300b001ca70b4a71aso4107618pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 21:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gA8fl4VBLSIuPoY/kPZyFR8DNphzGSE/geYX3/dgg00=;
        b=Pcpd2Rbrapa7M7Za73CnE1bEFC5wI7dwEloVVr2sNZaIVqKCy5cB4naL+d9PVU9Kq9
         o27VPMESu81Lm/IKCtpsqDvuaOrAbNZ4Z3JlkNVWBzI0rgkIQUh8AgXWl+jQU788ZJmX
         l6A6jyeZdEjndJ2j2ErDuXmLudkDIPIY2lKK43CSnl2C6npVfgu2m4i619MVJM7BRrwk
         AY/5jLUI62lflwZYHGLXDAiENTVnD5dnA32uP1ue3g0CVNMJg6oMYm2jAGzmng8hs1ih
         0Riamlr+TJ4j2W4TmwXqsgJmdKZCloPwc1OqNvr5som55EVUiCPihm0xB908z/cfbhad
         eBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gA8fl4VBLSIuPoY/kPZyFR8DNphzGSE/geYX3/dgg00=;
        b=5Ll9efbHNHtvYPwtTZIgYpvtV8rcPxx9Gh4TUNmZVK2GzumZsZTaQkFzSotS1vDprn
         z5TgUmc7v/84Tqjjnou6daJzkTgA3dDaBQO3SCvhTLYN0W5MhnHE4y0OHUKkm2TjedE2
         SrQngkok52GzV+0Y4pBaLihRvGb9IW+D2D6R43gz8djjhuURO8Jqp5oIajHe/v+HG5WI
         fwp7eMqjrUtEV5ms/nIdcwsVcIw3esop976Z1YfZvNj8x5m9hjYE6XWgRhMu/ZoeV8NI
         H7sAToIxJQitcnKYOKsejQMQ7TmVNJE3MP3Zdc/868hpmiOX34RRJoBcfXXRPWEAfAFr
         qHag==
X-Gm-Message-State: AOAM531x3CsWbd04U7etcbw0uNr7/tEX55OSZrtaxM7r+QG+ifDaIBMR
        A1lMp+jK0ZaEB3Sv/lMmuEpKm0hMui/ax11h
X-Google-Smtp-Source: ABdhPJwveDjBEYrVRy38w4adlQ9PbmM5YsL9jL+O+3mQ7Gci02SY9egKz08a0oG2xCNWEbJ8Q67ORfFnzPtKwKxT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:6bc4:b0:154:6b3d:a720 with SMTP
 id m4-20020a1709026bc400b001546b3da720mr17230778plt.104.1649393870424; Thu,
 07 Apr 2022 21:57:50 -0700 (PDT)
Date:   Fri,  8 Apr 2022 04:57:42 +0000
In-Reply-To: <20220408045743.1432968-1-yosryahmed@google.com>
Message-Id: <20220408045743.1432968-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220408045743.1432968-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v3 3/4] selftests: cgroup: fix alloc_anon_noexit() instantly
 freeing memory
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
the allocated memory. alloc_anon_noexit() is usually used with
cg_run_nowait() to run a process in the background that allocates
memory. It makes sense for the background process to keep the memory
allocated and not instantly free it (otherwise there is no point of
running it in the background).

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 36ccf2322e21..f2ffb3a30194 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -211,13 +211,17 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
 static int alloc_anon_noexit(const char *cgroup, void *arg)
 {
 	int ppid = getppid();
+	size_t size = (unsigned long)arg;
+	char *buf, *ptr;
 
-	if (alloc_anon(cgroup, arg))
-		return -1;
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
 
 	while (getppid() == ppid)
 		sleep(1);
 
+	free(buf);
 	return 0;
 }
 
-- 
2.35.1.1178.g4f1659d476-goog

