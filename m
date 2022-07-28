Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95F584788
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiG1VHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiG1VHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:07:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952774DF4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:07:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 70so2969340pfx.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc;
        bh=20zO2FT2JEdVmGgde/EIUF8PTTirUHSwEDYNPZ44Pgg=;
        b=p5F2+1uekipyQTSPfAX9HTNnh+s8rs4JzMcbfmP2rciMhLOLs/BJ1lT1wlNCW75IaJ
         TeGKO8/VEM62witITuWamrO7mM80bTZFgorffYUiNIT63txY3XDLKmKOGb4ODk8UxcIB
         SAoyzVUd3k8qRJNDBkq+fqiZkEtHAYtOyeRY0uGQAQZLyiu1nv4K1m89/k9M2o/jo2xQ
         UZcoLSRsTl082ii08jfcUVbn8LlcgSLA12uEkLPClKzvZP9R+grPWetSS3FndjOUut3s
         Cbz+RZAsKPZJuTL2dB1V3AOsaKBUOyVqUSlcJXeYHikSzjXltwt9b9gwoiczKJ/zjfwC
         RkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc;
        bh=20zO2FT2JEdVmGgde/EIUF8PTTirUHSwEDYNPZ44Pgg=;
        b=fXC5Q59nBMYmnwtSI8DSXHvvo5DMpXfL3uqjbcI0S0tX7l1jxc0i9yPWH46ygcWG9/
         1RPg65pNBy89H9yeFHJu5TSJ+M/HcFQCwOLzNLfP2YBBrwJwRhXWqIFc8S5LPSZDEF8/
         1x4yZ1oyhelIJAwymJ2RbvdgCshIYWbn/uVUAmcbz+QlsuxtCAWsffaij6HE5PjZG50/
         pd3pLmbaG9l0rHwAsdzSjyR4ld9qkEBZ5uuVhAMz2FjcX7Ot6Wtj3eQRH6FgQvJ2bVZ5
         85dMU/mQ6drooXGeczyUQvIYY6V7NyXTVHcBJydp7YBAWtfQ3HzNbwORFvDpSNpZ5/Wb
         jetQ==
X-Gm-Message-State: AJIora95S+6W+ii8KkdKJFSReuNF6J2S1dOefHSLjimC7D0d1tHpBQ1K
        19ZyTrb6vmUnYLIkwUjM2w4y2w==
X-Google-Smtp-Source: AGRyM1v2M7Q1YpIsy9H18azfAtgYtbvNwBK7Xc1E6c9U2gGjQ5VCipBScMYENZ2vwWNXuW8n8/ceiA==
X-Received: by 2002:a65:5a05:0:b0:41a:ea25:a631 with SMTP id y5-20020a655a05000000b0041aea25a631mr495385pgs.46.1659042460013;
        Thu, 28 Jul 2022 14:07:40 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709026a8300b0016b81679c31sm1704066plk.213.2022.07.28.14.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:07:38 -0700 (PDT)
Subject: [PATCH] doc: RISC-V: Document that misaligned accesses are supported
Date:   Thu, 28 Jul 2022 14:07:15 -0700
Message-Id: <20220728210715.17214-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        bagasdotme@gmail.com, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     corbet@lwn.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The RISC-V ISA manual used to mandate that misaligned accesses were
supported in user mode, but that requirement was removed in 2018 via
riscv-isa-manual commit 61cadb9 ("Provide new description of misaligned
load/store behavior compatible with privileged architecture.").  Since
the Linux uABI was already frozen at that point it's just been demoted
to part of the uABI, but that was never written down.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

We currently rely on either hardware or M-mode to support misaligned
accesses.  It's probably worth supporting the PR_SET_UNALIGN so
userspace can opt out of the emulation routines, but we can't break the
uABI so we're stuck with defaulting to them on for now.  Doing so would
also require some way of informing M-mode that unsupported accesses
shouldn't be emulated.
---
 Documentation/riscv/index.rst | 1 +
 Documentation/riscv/uabi.rst  | 6 ++++++
 2 files changed, 7 insertions(+)
 create mode 100644 Documentation/riscv/uabi.rst

diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index e23b876ad6eb..2e5b18fbb145 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -8,6 +8,7 @@ RISC-V architecture
     boot-image-header
     vm-layout
     patch-acceptance
+    uabi
 
     features
 
diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
new file mode 100644
index 000000000000..21a82cfb6c4d
--- /dev/null
+++ b/Documentation/riscv/uabi.rst
@@ -0,0 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+RISC-V Linux User ABI
+=====================
+
+Misaligned accesses are supported in userspace, but they may perform poorly.
-- 
2.34.1

