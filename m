Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822D525989
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376418AbiEMBzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiEMBzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:55:37 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BFD28F1D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fv2so6782755pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPEvVQawtMrkm11guWIbHQuWN48oLPqKEa934UeXixI=;
        b=OUdFnQoy1yYd1NoSRCJk2pyQ6hi1nmqBf7Ib+88jkANZemvtdqmJwGA/SfrQroAfw4
         9UxP4luZJqDZ5cmvLZ2j56eghRdQUhkGW+E6Hpc+Tcc9+SHXBsSc9OrxSCSCzxIWdwM+
         dZOSu3amuVusm6hkP7SjBsfzYDw8AsdnzNRLer8SRtr+sXzkY81yNaQ7bO1RuKszSglb
         brpkXnm9alAjf5imgTqE9yy5kCNzfm3l8jIIO1rOTOOk4ap+bR/W03q1zOD1flfIFCgk
         AJJCowYIRUcM6HxtrRc9W1cz8o5sWDTeWm+NQ+F8TNQnlqkXSK0qhAgRp/oL9xHsymT4
         ltSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPEvVQawtMrkm11guWIbHQuWN48oLPqKEa934UeXixI=;
        b=2vks46dR47Xd5lGIkKwRB3BPvkeuIkDnPGRQBEd4jTgQ+so8u2Cc1zDaK94KeirGEz
         mKro/ZJbzyuRaUe6AGsTwaZl+k42EMR5XWQcfsRrqSAEASkCUOJIpuK4073SS5gFVuJI
         3A7iRlZSIKljoazQXLeogcYDZTI8yQffNeKGjYdkDMCVywxbqGR4nwaIl625mn2ai6Wk
         cE8GdQJrVqTPgf5oD+aaGAbFYBmo8e3o/m5UWvL8/6u/V1mkOFoNYuJDeTvv01fNHq9I
         BMdgpSlxaIACZgIaij7nQ7lO/syh+lK/RsVhAKGJh0Exj4kpC9MXtHP9tscqF5NUX7ng
         JUpQ==
X-Gm-Message-State: AOAM532qq3Pfz3nkLEE8SVegDXnryyEWUcY1K6xjxy93WHi16gLyeJWy
        Eqq3vLaGKxrnrG3/lLigPOe17jwXofjvTQ==
X-Google-Smtp-Source: ABdhPJyuYRag3XQsrMFQtADDv6YxIQZ8NbRFxwO+o2rfR179JSQMBL5GFszFiYmfWeVchkHESt/8Fg==
X-Received: by 2002:a17:903:286:b0:15e:b2f3:56e5 with SMTP id j6-20020a170903028600b0015eb2f356e5mr2574149plr.79.1652406935448;
        Thu, 12 May 2022 18:55:35 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id i1-20020a6561a1000000b003c14af5063fsm365883pgv.87.2022.05.12.18.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 18:55:34 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2  0/3] Miscellaneous fixes for PMU driver
Date:   Thu, 12 May 2022 18:55:19 -0700
Message-Id: <20220513015522.910856-1-atishp@rivosinc.com>
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

This series fixes issues PMU driver code.
PATCH 1 & 3 are fixes for rv32 while PATCH 2 fixes a redundant
user page update issue during counter start.

Changes from v1->v2:
1. Add proper compile time rv32 checks.

Atish Patra (3):
RISC-V: Fix counter restart during overflow for RV32
RISC-V: Update user page mapping only once during start
RISC-V: Fix SBI PMU calls for RV32

drivers/perf/riscv_pmu.c     |  1 -
drivers/perf/riscv_pmu_sbi.c | 16 ++++++++++++++++
2 files changed, 16 insertions(+), 1 deletion(-)

--
2.25.1

