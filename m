Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3714E4ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242997AbiCWJC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiCWJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:02:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3013D6EB0D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:00:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m22so1069253pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbfwNZ672/QivizbpxYzAD70C990QzKhms0ROZ5rRjk=;
        b=Ab35ObTt3m/gbH6C1Zds39aaaYWaVb6ZBPHzy4/6PeVpzh1QZXhoWQ1HJPlOfNpnhG
         dBmsIxIV5kPgpN0wxJTkNeUY7wFCjFkhpM39aCLJg5Y8tCqiNVrWrW+GtTf1XU0rz0UI
         5cxPrHkRRSHR4MMW34IXmYArx36xNyNMjQuz4FGTzuVFIwx3zGgmyq11nBQWxbGN298W
         rwep3U21MPSdEZc04u6pRJqo6AQbEgAy74iC+Hm51wTojvjulgzg3dxzfbNlkKLof4QW
         EbJ3ppmOvVFm5N+dQz1r46b5KBoN2hR4lmavmAaklqUArGZudXDO4dv2cUAIg4zSUMDt
         9i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbfwNZ672/QivizbpxYzAD70C990QzKhms0ROZ5rRjk=;
        b=ElAfqbq5b3EAV3E1a/SYGvYdsPHTLb4ioSPLk6hXM9LhTFcgIoP2MLWoni6ldKcUoK
         WY/FUcLz1/GKrOu1tfYdosww5oaUHkSxdhTzxegfL5CP+2rmbvhxQSzAqVnNLArBe/ny
         k9kdo3ZFLt0dbnVBvDK5u6SNRRugrkd+eCA+BKbOrpxIPjMAzQHQpw1dBYpr+j31DmFl
         ctGWQTjaHa7Di4fQzItyeWeQStrUGSwsP5T/XKEHlvYIFVV/OoztlGW+m6zS+D58Hvbp
         w5cBpIjnLeHTCnnexi38V2eK18IvPHCWkG4ZHTOL3Pu0mVyF1QHF05Yoozxx2O1BMhfo
         7zQQ==
X-Gm-Message-State: AOAM530fHo0iJIntNTRNNILMttjAwiipAWck/GiFv0HWHH908Hw4AyYL
        goI/l6M9iJmqkrwzl3ktpbcDIw==
X-Google-Smtp-Source: ABdhPJytP6LLZxBu0sisrxqgLnFnXaLVrohP/INGBzvNNYJQLbSBjeWW4JywHU+xzfySv/O/MnjPEA==
X-Received: by 2002:a17:90a:a594:b0:1bc:5def:a652 with SMTP id b20-20020a17090aa59400b001bc5defa652mr10268506pjq.167.1648026056686;
        Wed, 23 Mar 2022 02:00:56 -0700 (PDT)
Received: from localhost.localdomain ([223.182.250.48])
        by smtp.gmail.com with ESMTPSA id i6-20020a633c46000000b003817d623f72sm19642115pgn.24.2022.03.23.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 02:00:56 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: Enable perf events by default
Date:   Wed, 23 Mar 2022 14:30:25 +0530
Message-Id: <20220323090025.546808-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let us enable perf events by default in RV32 and RV64 defconfigs
so that we can use RISC-V PMU drivers on various RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f120fcc43d0a..57aaedc7cf74 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_PERF_EVENTS=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 8b56a7f1eb06..21d422e740d5 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_PERF_EVENTS=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
-- 
2.25.1

