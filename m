Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEDD526E6D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiENA6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 20:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiENA6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 20:58:18 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FC232FA00
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:34:44 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id fy8-20020a17090b020800b001d8de2118ccso4637843pjb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CleGR40pCscZ7DX+JE9UL8AwIhXuuwyZAmYy00HxsZE=;
        b=GKcrB79yedOhvremqRqfx2EEtubE/eyN0JrwxnHMy1Nx5PykTiyD7nKel0Omg5vymk
         6XX1h8zMRXwXQMbT9RWJmwqZWKb0uZhG8k4UUQ0NijUkhOsxW4JoBuv4+kVdbrVWp1Y6
         ANGUeQs7HysTo/cvIGwnNRxClRcgw8YP9fFPN/zE24iVnz/Wp1Lu0Blha36/yfJcIYkk
         DUhmk0ld4NSUFFuYCRhJCBYugyyQrSl8xSR4hdwGCx8z1keAmANLb5uj3zhIC262iZ8D
         sPvVId0WqsDtgIV3143I4tddKV9UtH9vVwku4d47YnGCiWKoYt0K2kmN7CiP63D/Bvtw
         o/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CleGR40pCscZ7DX+JE9UL8AwIhXuuwyZAmYy00HxsZE=;
        b=xmYykoCHdhHv4LmyL0EG6OXoH9laxtzgxZCEowk192BJzeaiYR80aUEddgsLgCoQDA
         fxfhdXeJv3APVao6KCIwRuWQ/V4uj7Su1J1GcmLgaRpmsnaeJ3NrVvSn2vFM2WxKvXfy
         dIQGNBrPomseOn8H3A1M6zZvMZ/uVxZ50bnX9MYqnpT54O+06OrVXc+5eaTeES0UOnzc
         K5cvcjRcK8xaom+AYNjDvjM6NKsgeI+fYno/FQzSdm4TlHrd/ndzGZdrtii3GoOL+phK
         jWWFatInqWH+6yJDI0sszBTMyhftxCWoWRqzWfRgASjnO0FhEyDBABOSTNYqUbPBgVww
         hFxA==
X-Gm-Message-State: AOAM532NOBLPW4IS7xDvZTvDThmQtbyetyUY1+tCD3aWpvCawn69bF2V
        mxJ4KdKulH5lB3tAur2koj5X/OLbHiSSFHav
X-Google-Smtp-Source: ABdhPJxywSRLaodpDSsq62D/NbDNNlbxqYbHUFeNFrs/LghHREk6Ui4Slhk+CDu0AZbxFPQdBk8KqU7Oq8cMJvKD
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1d8f:b0:510:9397:65b with SMTP
 id z15-20020a056a001d8f00b005109397065bmr6927932pfw.57.1652487684383; Fri, 13
 May 2022 17:21:24 -0700 (PDT)
Date:   Sat, 14 May 2022 00:21:15 +0000
Message-Id: <20220514002115.1376033-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH bpf-next v2] selftests/bpf: fix building bpf selftests statically
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

bpf selftests can no longer be built with CFLAGS=-static with
liburandom_read.so and its dependent target.

Filter out -static for liburandom_read.so and its dependent target.

When building statically, this leaves urandom_read relying on
system-wide shared libraries.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6bbc03161544..4030dd6cbc34 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -168,13 +168,15 @@ $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
+# Filter out -static for liburandom_read.so and its dependent targets so that static builds
+# do not fail. Static builds leave urandom_read relying on system-wide shared libraries.
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
 	$(call msg,LIB,,$@)
-	$(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
+	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $^ $(LDLIBS) -fPIC -shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c,$^)			       \
+	$(Q)$(CC) $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^)  \
 		  liburandom_read.so $(LDLIBS)	       			       \
 		  -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
-- 
2.36.0.550.gb090851708-goog

