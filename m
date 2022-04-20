Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66CC508FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381602AbiDTSvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381581AbiDTSvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:51:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF86242EEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso5699197pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=SoH+rXIkHfn2tDchhhZbSJ+crMNxbZGozRfYvpl+XoE=;
        b=juiLZLej55jZaTBjD9xwVIR/YAR4i7cO0bpHr89TY+dz1ORy2ejFFIdrCOQXcP2D8H
         cIxDjtw4zoR/+O/+Cz7gJVkbmHNOFMtnczcO1N4hDW2YNoDdFy7kJvt4NocRNaWc0rrK
         rDxA4wJWcdvspC6ywEgV5rv2Z03Jb9GhkEjoFsHw1t6EhYernuYtCEVUod4KD52lB5iP
         s/aDAOti+/mtT0ZCn/3oAcvuMjjaJ6zzBso+eeSET7y8Nwo2WVkVUSMAt3YlM6JRpRZD
         BvFtCMyG1ZheaQ4dagFcdUGWYCLZ3BHz7skwKmfSnGeYNrdPtlsudMgmLO3FdKIT+CFZ
         SurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=SoH+rXIkHfn2tDchhhZbSJ+crMNxbZGozRfYvpl+XoE=;
        b=Fs4eWquEjfxg5jvWXnqDaf+/UyLa3Za0r1fIiLNtf8edbvCCth053Lsm53zHHT41q1
         UHqMwaSaij2E0p3fAgSs4I6q3B1KtnTMoqElxDq1ZksZsf+schTjX2+eHD21NOr1Nsyo
         n6Xrgh5d3CUV8RZ26nhZYg5DayH3706patihgMLlvmGGQ1XnwMhPuD0VzSDs573RXoKU
         MemJZ+m71qcd//9TfDrdUtnxJsLH/4bp9aw5EYYJoQaTR28aa7c069rp1z9jR0EPtMTs
         jqr9dQtkbEyDTsowGqqsoOR8xo2teukHIB65hBy7soKu6LvSJbRJVS03m7Q0Qh6b9bp1
         S2/w==
X-Gm-Message-State: AOAM531fnw9DNbkIUijkefXlPySpGLHBelG+q7JlA/ngz9/gljQ7zOVi
        uz6GWdUYngXrEs4ND+j2WVwg3w==
X-Google-Smtp-Source: ABdhPJxdrixrp+jfH8hvzdp/Eg4oHxPBPiHlreQAn5N+O4widmijdWQO8V5yAwiXQNEjtkHlm2bdxQ==
X-Received: by 2002:a17:90b:4acb:b0:1d1:efc:39bd with SMTP id mh11-20020a17090b4acb00b001d10efc39bdmr6085138pjb.49.1650480493464;
        Wed, 20 Apr 2022 11:48:13 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id i11-20020a654d0b000000b0039d82c3e68csm20741715pgt.55.2022.04.20.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:48:13 -0700 (PDT)
Subject: [PATCH v2 2/4] RISC-V: ignore xipImage
Date:   Wed, 20 Apr 2022 11:40:54 -0700
Message-Id: <20220420184056.7886-3-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420184056.7886-1-palmer@rivosinc.com>
References: <20220420184056.7886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, vincent.chen@sifive.com, guoren@kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, rdunlap@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This built file shows up in "git status" without an explicit ignore.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/boot/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/.gitignore b/arch/riscv/boot/.gitignore
index 90e66adb7de5..0cea9f7fa9d5 100644
--- a/arch/riscv/boot/.gitignore
+++ b/arch/riscv/boot/.gitignore
@@ -4,3 +4,4 @@ Image.*
 loader
 loader.lds
 loader.bin
+xipImage
-- 
2.34.1

