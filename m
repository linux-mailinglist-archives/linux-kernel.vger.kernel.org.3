Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F793525905
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359745AbiEMAl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbiEMAlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:41:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E85FF07
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:41:21 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id ij27-20020a170902ab5b00b0015d41282214so3508310plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PLHfkBps8/NN/F93wiTb1I9xCzDthCPlSjntIH72rDE=;
        b=I8afDsMFlizjC2WkKw9nEOj2vMJgklTATaw1Hsa/SWTOmJqlD7HHRMFbRFXtiK5hKb
         eWR68srOtf34zMu8hRlFofRBQy/Kzvf9bIK5KmrMoPCtMhuNUIreuIDMCS0+HR7A97qA
         4norc+7XY3Ry8c2YsW8H6ig1JhvGZVoetaN6esBwKE9GsFTgHy0aQb6TWGqWqT5+iagi
         u0NOcqhn2xj8lDeq6QVIGMfypdzYQUXj/zwLC7cAmZdjvcQbS1bZDx2o2Swcm1uJ7M+H
         MVP3texpB2djiZrBiw8E2Hcwgk3Wb3yQENmoEoJRD1eEtwku11QHqpbk9WVB9zxfdH3a
         fmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PLHfkBps8/NN/F93wiTb1I9xCzDthCPlSjntIH72rDE=;
        b=58WDPXfm/a6dZXXAlR51CTc68PDBDF3a4gzsPunzxRHDAxezLeZSWW+5UiZN7zAAGD
         38FCs/sico348mXkcehZ/cmVFXp3SKPnDCnZOwDnMesz+xIbs4aTuaKXM5WuTAV/AXS+
         n0wigJxjrHkfKciQyRKY88gq9V6Fw5a88RBvv0L4RR7tLLZqJzi4Tgw6B6AXaDTNbbWv
         jBCUU5rkMZm0jMH/Oe6ZnbAq484FZXBxjmo4VagoQKD15Od4jHRdMAz829ZaRzirwaT7
         IOqurS+V1ruoL5m45baYoGf58a0rOMZeEjMUHlHwWvW8KiqpUB3viM3JpemUO/8gFqw3
         9vhg==
X-Gm-Message-State: AOAM531u2y1SD8NcXhGUemUrTvyLvmMqXrf/2S544u3A8VnOFhibVrfB
        /3x5nSWVtxpVimXtIdNqDnPtqDVn1qWFldXe
X-Google-Smtp-Source: ABdhPJyNqg86E2DPDFz9cP8m9RIs4OnDIdJI8SHawkmDOi6DsBWOzE4x5CksBx4CuyRBczY8XM/fFtpwNsdQ7jWf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:4b42:b0:1dc:15f8:821b with SMTP
 id mi2-20020a17090b4b4200b001dc15f8821bmr13529101pjb.131.1652402480734; Thu,
 12 May 2022 17:41:20 -0700 (PDT)
Date:   Fri, 13 May 2022 00:41:17 +0000
Message-Id: <20220513004117.364577-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH bpf-next] selftests/bpf: fix building bpf selftests statically
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

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6bbc03161544..4eaefc187d5b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -168,14 +168,17 @@ $(OUTPUT)/%:%.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(LINK.c) $^ $(LDLIBS) -o $@
 
+# If the tests are being built statically, exclude dynamic libraries defined
+# in this Makefile and their dependencies.
+DYNAMIC_CFLAGS := $(filter-out -static,$(CFLAGS))
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
 	$(call msg,LIB,,$@)
-	$(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
+	$(Q)$(CC) $(DYNAMIC_CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
 	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c,$^)			       \
-		  liburandom_read.so $(LDLIBS)	       			       \
+	$(Q)$(CC) $(DYNAMIC_CFLAGS) $(LDFLAGS) $(filter %.c,$^)			\
+		  liburandom_read.so $(LDLIBS)					\
 		  -Wl,-rpath=. -Wl,--build-id=sha1 -o $@
 
 $(OUTPUT)/bpf_testmod.ko: $(VMLINUX_BTF) $(wildcard bpf_testmod/Makefile bpf_testmod/*.[ch])
-- 
2.36.0.550.gb090851708-goog

