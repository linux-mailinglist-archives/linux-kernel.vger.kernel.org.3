Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D3151928E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244469AbiEDAIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244459AbiEDAIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:08:01 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29516433A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:04:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s68-20020a637747000000b003aaff19b95bso9138157pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gNOfQOttyQ9bVdMrdcaVGQzcGPZiZGz3FawVW6e6qqo=;
        b=r1bamZ7/7YEkejVukK6LVq3CiZ+A2M9izekAohqwa+FB57ha2fq+WrXtd7hH+dC+eM
         13L40ZPCJ7MbYJIPBHnucGx0+jSuR6Klo6py8YazOIbgqjzbAFafjzycEiYhPNYOpvub
         338Zq5b1D8ArkuljrgfcDPO7/mNsxLoJVdaDSMRynpo//Ko75zb103HfcQg1v55oWZ7d
         Ay7ghn9fZYhDkPwRoBKQFAjq7BcP2L2UNLgsSPouYgBwI39ZffFfu3Q9m8Hh5SG1+vnL
         pUlUIGOZWUX7cIdGZIiF9lg6/Mmb3Cl3Py4ZOszvYoDFudV7YI8uKIrmnS7Awh7SqCTA
         t2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gNOfQOttyQ9bVdMrdcaVGQzcGPZiZGz3FawVW6e6qqo=;
        b=uoZTBz/PwK3zIeYUbhjSEHOoZWd6kFBTjCDS1xlptmQg7JzkBerTS9bAIqoMGSLpz0
         kW5iH8kOl/ELZQRQp2RNefn+lo7/6MAmape96USGe5ptQi86z12cYp+VbSTjbLCNBfKO
         +Fms0Kffd2zvzPcGtP8HzigZ/K6M6lv0Im3XDQO+eeyzAIdWZTT4XRl6SIlwaeM0vJLK
         kfiBGg14ot0WNPOgblNvajY7tJ9Wp8I5oQHY48Gc7dEykHmk+5Ty6ayVNUHoDlaffi4Q
         wLhrHPg+Nm/2C3Jc1p6r1crGzncahMAQor4ZeCqIlxlj3WWVwDup4yTCKMj6+juZB7Fx
         NP7w==
X-Gm-Message-State: AOAM530Lv5Aa0yvyOL3l9GQSbJcy4Yg1v+qp99ESv6G1QS+Zt0+zDT+Q
        13sZ0G8ur0JlkasIaoQMsWN2QhfX+DhE
X-Google-Smtp-Source: ABdhPJzMqS7AZBrEZnEXn6eaRzkfHjclxm/qy0rBrOu081u0jfBoGWFBDKB5jzuoKh5xrj08ZHLyw/ElYT+g
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1e51])
 (user=yuanchu job=sendgmr) by 2002:a65:4c4e:0:b0:39d:21c4:2381 with SMTP id
 l14-20020a654c4e000000b0039d21c42381mr15913964pgr.566.1651622665163; Tue, 03
 May 2022 17:04:25 -0700 (PDT)
Date:   Wed,  4 May 2022 00:03:57 +0000
In-Reply-To: <f6cc50f0-318f-097f-af13-271a2fb4d645@linuxfoundation.org>
Message-Id: <20220504000358.1174849-1-yuanchu@google.com>
Mime-Version: 1.0
References: <f6cc50f0-318f-097f-af13-271a2fb4d645@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 1/2] selftests/damon: suppress compiler warnings for huge_count_read_write
From:   Yuanchu Xie <yuanchu@google.com>
To:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        SeongJae Park <sj@kernel.org>
Cc:     rientjes@google.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
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

The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
use '__GFP_NOWARN' for user-specified size buffer allocation")
intentionally writes and reads with a large count to cause
allocation failure and check for kernel warnings. We suppress
the compiler warnings for these calls as they work as intended.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 tools/testing/selftests/damon/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 0470c5f3e690..a300b4c5b373 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for damon selftests
 
+CFLAGS += -Wno-stringop-overread
+CFLAGS += -Wno-stringop-overflow
+
 TEST_GEN_FILES += huge_count_read_write
 
 TEST_FILES = _chk_dependency.sh _debugfs_common.sh
-- 
2.36.0.464.gb9c8b46e94-goog

