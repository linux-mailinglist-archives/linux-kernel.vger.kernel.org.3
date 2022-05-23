Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A5531F68
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiEWXwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiEWXvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38295AEE5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:42 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so612503pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9UyEYcwKD0kFoqPtiC6zFdw+15DJUbeiFWT4kHYlps=;
        b=4jx+wUZc3+xuWv62PEZin8KNRLl6jmnL2eMN2NkcWT9wWu7Azpo2N4jCuZy+sVAO7q
         1jbq28+4L/VdxuBNCQLbeUKONE80SZjuQXNLHQFqCam6Nd2RbgI+8O8DS87Tvw5thxxI
         CNsFj3Zy3fjRirWnRtF6eNjs5I9GvT2djuRGHmi82+JQYdlcivJISC3Kv9YZRRougmBx
         rpHXR5czod/RRmf6QezJsViOe/vDo+/ZcqLQTZQBmiYB/8kpEoI052/ciBkHXuD45PRj
         aQ+tGuNpsX9hUDkb/+r8Q4p3DIgHYuQRVOfJeXQwFak3WljtapGldWgfIP2aWY5h96oI
         XaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9UyEYcwKD0kFoqPtiC6zFdw+15DJUbeiFWT4kHYlps=;
        b=ExXFif4JSSMhVCdf6i3or+Zu0C8QGBeBwvJoac5I9T6VIyMYUZW7yy030PL0BFDhmf
         eBoXa6V88Fa3jb9TZV1lrEXDBytmcFIcsxBe9RvgQ1N7BJJRB8g/+urXfQYCxOnJ6V/K
         7pDvYdeHtvK+l2Q5azR47H9awWr47qmVsAcJzDAurfpXcWUhLUrtR90SXVj70zQwNf5n
         paar+Or1pnrDzvG0Zn8vQ6lqFTQPbvpfNdj1OBvTwUISccdJ6sekPgqfHQDHAEsv/s4n
         6NQRLsqO8OkoRlLR+Lyk2CWKYwT58gP42wJ1FCHtJOI6+24tF4LSAtp2k2zahErZSQx6
         GxYw==
X-Gm-Message-State: AOAM530A9aiYMtCQf/IYneV5FNed0fZu4yq1tKJZyHlfqUu5a8AaFynp
        WGobZLONQ9272/1tbkPYnZz/VqQeOaNZGQ==
X-Google-Smtp-Source: ABdhPJwnjxOwSN3VyT0G80P5T4/TkNXbN+PzN+fq0VsOfOYRAn/CC18RT3fjYMERqT54GrTSxmvBaw==
X-Received: by 2002:a17:903:110c:b0:15f:f15:30ec with SMTP id n12-20020a170903110c00b0015f0f1530ecmr25217379plh.162.1653349901900;
        Mon, 23 May 2022 16:51:41 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:41 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 12/12] target/riscv: Update the privilege field for sscofpmf CSRs
Date:   Mon, 23 May 2022 16:50:57 -0700
Message-Id: <20220523235057.123882-13-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523235057.123882-1-atishp@rivosinc.com>
References: <20220523235057.123882-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sscofpmf extension was ratified as a part of priv spec v1.12.
Mark the csr_ops accordingly.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 90 ++++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e229f53c674d..c6105edd7a1a 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -4012,63 +4012,92 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                                                        write_mhpmevent },
 
     [CSR_MHPMEVENT3H]    = { "mhpmevent3h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                          write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT4H]    = { "mhpmevent4h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                          write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT5H]    = { "mhpmevent5h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                          write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT6H]    = { "mhpmevent6h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                          write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT7H]    = { "mhpmevent7h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                          write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT8H]    = { "mhpmevent8h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                          write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT9H]    = { "mhpmevent9h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                          write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT10H]   = { "mhpmevent10h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT11H]   = { "mhpmevent11h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT12H]   = { "mhpmevent12h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT13H]   = { "mhpmevent13h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT14H]   = { "mhpmevent14h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT15H]   = { "mhpmevent15h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT16H]   = { "mhpmevent16h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT17H]   = { "mhpmevent17h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT18H]   = { "mhpmevent18h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT19H]   = { "mhpmevent19h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT20H]   = { "mhpmevent20h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT21H]   = { "mhpmevent21h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT22H]   = { "mhpmevent22h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT23H]   = { "mhpmevent23h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT24H]   = { "mhpmevent24h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT25H]   = { "mhpmevent25h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT26H]   = { "mhpmevent26h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT27H]   = { "mhpmevent27h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT28H]   = { "mhpmevent28h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT29H]   = { "mhpmevent29h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT30H]   = { "mhpmevent30h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
     [CSR_MHPMEVENT31H]   = { "mhpmevent31h",    sscofpmf,  read_mhpmeventh,
-                                                       write_mhpmeventh},
+                                                           write_mhpmeventh,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
     [CSR_HPMCOUNTER3H]   = { "hpmcounter3h",   ctr32,  read_hpmcounterh },
     [CSR_HPMCOUNTER4H]   = { "hpmcounter4h",   ctr32,  read_hpmcounterh },
@@ -4158,7 +4187,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                                                        write_mhpmcounterh },
     [CSR_MHPMCOUNTER31H] = { "mhpmcounter31h", mctr32,  read_hpmcounterh,
                                                        write_mhpmcounterh },
-    [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf },
+    [CSR_SCOUNTOVF]      = { "scountovf", sscofpmf,  read_scountovf,
+                                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
 #endif /* !CONFIG_USER_ONLY */
 };
-- 
2.25.1

