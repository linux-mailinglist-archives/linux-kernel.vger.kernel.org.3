Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759DF4B7FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbiBPFV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiBPFVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:21:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5165808
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:21:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so5434754pja.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0J8uT/MlG3w0v7/uc2AXa/I1ciUjnfuTE3jIsdWuBE=;
        b=JJpel9mFC6bgnnn5zrLI5AMAFKC+fFMq/rDnPHY6Uk+sFVnXDwtCF4Afqxirozx+JP
         N6GFFvIyePOq6lbDh1rOUS/zRD1ghlUuus9GvKYNy7DQ5i47A1G2J0R+top/bmbvQrZv
         +uftVneozuqWDMWmoZS3iqCISZcUMVMrttiWyPeWehICh3GoumGKs6bfleotEd9bHR9f
         r85jIuOojUPYN2PVrQ93VwL+aC7/NkNhYnjsKiqY4wyWzqaVg/4JP4Lt8BFkaAbE7ruP
         9OG9QHnEqX1wxFBGmD9odkCJBYJOcIRzPNrNP6NTGcAjZzLAQwFMyS5w8RdOE5a49K75
         ueNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0J8uT/MlG3w0v7/uc2AXa/I1ciUjnfuTE3jIsdWuBE=;
        b=cdM8u3Xk3KRpPLtibgX48gyf92W600PRjlYXR1L+3idxEEye91FL8fsZJrMF3PYMhF
         GEZGbbyADELrGq02LIfKHGAhTWpRjZ7MaGn0HJDCz/4JjsoDIyqMn9xN2HP9w4bEfCfN
         QWfLyxhqEQ6RMWQjfcmhJEebcX3FnHUoItYm23VowAE3ZMTO0F1qEN5rREI0wI1reyl9
         qnVGqcEmH9nR7ce96fDaZYFam4vn2s+4P1DWUzpqhqqr1eQC0eOmREmKC/clr6A8ivhn
         0yiBvzSGtjbbFnpIMWaumeWQ7a/LvznAfWGmpNw16qoUD5OdnDuRaslgEDEVUUcYhYFa
         tOLg==
X-Gm-Message-State: AOAM533ptRSJRjTA9UJKrC9SLM54ahew9sMjvqYYBYDFomw3jak0Xn3f
        L4VO8eYMe7xTi4DNQLDHG0mLYQ==
X-Google-Smtp-Source: ABdhPJxxMXyYDDnx9KBGWahCQZUQtvcrz4/zlpVXzpbkNu3KzRnrTuSLbz1zppfd8SdoW4QfqY4puw==
X-Received: by 2002:a17:90b:4a4f:b0:1b8:7240:1a47 with SMTP id lb15-20020a17090b4a4f00b001b872401a47mr8442350pjb.84.1644988901155;
        Tue, 15 Feb 2022 21:21:41 -0800 (PST)
Received: from localhost.localdomain ([117.248.109.221])
        by smtp.gmail.com with ESMTPSA id ot12sm10775259pjb.22.2022.02.15.21.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 21:21:40 -0800 (PST)
From:   Mayuresh Chitale <mchitale@ventanamicro.com>
To:     palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com
Cc:     anup@brainfault.org, atishp@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [RFC PATCH 0/2] Risc-V Svinval support
Date:   Wed, 16 Feb 2022 10:51:08 +0530
Message-Id: <20220216052110.1053665-1-mchitale@ventanamicro.com>
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

This patch adds support for the Svinval extension version 1.0 as defined in the
Risc V Privileged specification. It depends on and needs to be applied on the
following patchsets from Atish and Anup respectively:

https://patchwork.kernel.org/project/linux-riscv/list/?series=613234
https://patchwork.kernel.org/project/linux-riscv/list/?series=609361

The feature was tested with qemu from latest staging branch with following
additional patch:
https://lists.nongnu.org/archive/html/qemu-riscv/2022-02/msg00100.html 

Mayuresh Chitale (2):
  riscv: enum for svinval extension
  riscv: mm: use svinval instructions instead of sfence.vma

 arch/riscv/include/asm/hwcap.h    |  1 +
 arch/riscv/include/asm/tlbflush.h | 14 +++++++
 arch/riscv/kernel/cpu.c           |  1 +
 arch/riscv/kernel/setup.c         |  1 +
 arch/riscv/mm/Makefile            |  1 +
 arch/riscv/mm/tlb.S               | 53 +++++++++++++++++++++++
 arch/riscv/mm/tlbflush.c          | 70 ++++++++++++++++++++++++++++---
 7 files changed, 135 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/mm/tlb.S

-- 
2.25.1

