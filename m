Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE74E574B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbiCWRU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiCWRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:20:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C9C369C2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:18:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c11so1654837pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUhE442Chh0VE73xSyuaumajE/w5XLbPiioPvB11NGk=;
        b=7pjMO3GVK+ZW7atuxQR6ijXrvohpgOt+NoFs1nGisTNVLrarZcCGq2tgaMGkkMkLRY
         CuIPLaDoebffi7nHz8osTESDZ+gfKymOObyQQX7IOhQG+YOrMW9MKZoKho3adIBED71/
         QIStW4PjAz0uDneoiisP/VjaZBfJuPLqgrOqSlIR9GwH+RQhRKsWlg29R3TR7WijPof/
         KatIfaWoSLxeTPF94f9/YIsFkTCGWY0YNJW5yUgDmR9eN0ZhCAlKQZADrml8qbC5Br7R
         0GSQqyCI58nhVts3KB7gLmjLYLiuN56tYQk49MYjPoRhUfyuakalm1pqnnhodJ2rNEWG
         CmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUhE442Chh0VE73xSyuaumajE/w5XLbPiioPvB11NGk=;
        b=6HP9cUjNSnCH5IVbfXYXT+fVoVlspd0xddrhEVAv5qP4be09reVgCA+XAbSYPIHiue
         U3qLG0ivAmFUmRxYtCtnF3QxFGfULOrCcY05lqKndwjlG4tLNxY+y1xMfgtiUmVZGWp1
         UKhafSFtP4SgvLOlxH2+ZW5AtWeHXIU+HErtBwScFtxdruzk9u9rFdfBD6LmtSZGlo6P
         OM69r/Pyrz4RrRfScWhwPIaMIKGZDJT2vcmR9e512Dj43c2ciW6LViPGNNzRP2bYyQia
         eqZUhC/bQVa1sjDyPU0aID8katYqUE1zPUbLv1j3iI93TRO7Hz3cLgulyz+vceGcuHMD
         QO6w==
X-Gm-Message-State: AOAM530JnUaykXKpomkWMe7Wg656dxF4axhGq7/v2YGIXW+iHtmwk6gX
        1xG/fQBluYGU8n5xccyAa4ZndhwRiQS8CQ==
X-Google-Smtp-Source: ABdhPJwiUO6omSax6cgN0DHF/2aBUy3wNyRywh27FzWP2RZbe9jd0lms0/eROJU0CEYJ9QnJBNtovw==
X-Received: by 2002:a62:1407:0:b0:4fa:6d31:1056 with SMTP id 7-20020a621407000000b004fa6d311056mr775126pfu.7.1648055937273;
        Wed, 23 Mar 2022 10:18:57 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b004e1366dd88esm444524pfp.160.2022.03.23.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:18:56 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        kernel test robot <lkp@intel.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] RISC-V: Declare per cpu boot data as static
Date:   Wed, 23 Mar 2022 10:17:26 -0700
Message-Id: <20220323171726.1303706-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
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

The per cpu boot data is only used within the cpu_ops_sbi.c. It can
be delcared as static.

Fixes: 9a2451f18663 ("RISC-V: Avoid using per cpu array for ordered booting")

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpu_ops_sbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index dae29cbfe550..7f2ad008274f 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -21,7 +21,7 @@ const struct cpu_operations cpu_ops_sbi;
  * be invoked from multiple threads in parallel. Define a per cpu data
  * to handle that.
  */
-DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
+static DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
 
 static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
 			      unsigned long priv)
-- 
2.25.1

