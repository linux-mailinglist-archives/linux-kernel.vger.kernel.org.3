Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C654C534D01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346953AbiEZKLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiEZKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:11:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D28CFEA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cs3-20020a17090af50300b001e0808b5838so1349695pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbrC9viuiEeW+uauQj8WIm89oteJmbW6JLoMguTugSc=;
        b=n1tlol/XpCiFEfS35l5rjijwg4/uYJ7U9MDrjL2y7sQad9b2Gx/Anu2oswESXCWZfd
         DEaLurPWlXY+iTlhl+GwrL2gvQfB5oyIxpPuLHfGaHtU1Y+7arw1Pd6nQf5Aiqi4kqYj
         B6XYxw5p21vJXiPEM8+p8Mu+v0hnX1QCno2lQ8gJK7GoBpS1IvPXapBLJ5//C28agcLN
         LZGHaXJ2tx+8B9l0tqZyYQf+CnRVlEAq76lOoNMXcoarjy0Mt+DtYlpAZrUzIAf9m2g3
         NdrLi7TAmT+9uRXXV+I5T7ha65tXXvT96hGl+LrbG0pbjmovcBsbs/tWDxBFe6/T2dz/
         XvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HbrC9viuiEeW+uauQj8WIm89oteJmbW6JLoMguTugSc=;
        b=JS57zwXK33r3iMggxRI69QIMcXz6rMlGDb6Pr1g7hkqW5VuKPIZetwTT3G3Toy9VyK
         ToCxJEFp/FnS/vtaRQGN08q/uf/9gx2KKD7GPRounJzwuNEyg0tXmBnRNhwO/qwnfX4e
         knopQWtqIxDDHl098VNlQdoXLuvy6lt7RKfjmSkFUp5EyJZVbxEeQpbOoKPRRdI+oT2W
         i9Eqgem02mV0vwnV+yPPzcPFedNFIX81I2MPCKoAuAgDyy8juC4/SzmV0sOwfF8A1VOq
         zxsEGb15AUgyif+wo9xuirCU4xvKNM2Ml1MD5mZWKOkHxihs9nxm0HAUbtT4nX0kf+tB
         1aKA==
X-Gm-Message-State: AOAM533P5A5U5Hp4+iyPMfjwjUVJA6WXZqV7eGg4Wo5JrWXZ99QqmfTg
        ROIlKfPFtN131Sc+DGLGeEW+wg==
X-Google-Smtp-Source: ABdhPJwngscKF0Sla2DrywGR0AnX4WF8e0baEvHwkduL7GDyUFbJRTykeW8a50dtGoiNMzsjjD40GA==
X-Received: by 2002:a17:903:2586:b0:163:5b96:d901 with SMTP id jb6-20020a170903258600b001635b96d901mr7254897plb.151.1653559898794;
        Thu, 26 May 2022 03:11:38 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015f309f14d0sm1114861plf.56.2022.05.26.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:11:38 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V2 0/5] Support for 64bit hartid on RV64 platforms
Date:   Thu, 26 May 2022 15:41:26 +0530
Message-Id: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hartid can be a 64bit value on RV64 platforms. This series updates
the code so that 64bit hartid can be supported on RV64 platforms.

The series has been tested on both RV32 and RV64 qemu platforms.

Changes since V1:
	1) Updated RB tag for PATCH 1 and PATCH3
	2) Type Casting NR_CPUS before comparing with hartid in PATCH 2
	3) Changed commit message of PATCH 2 to provide details about
	   the bug it is fixing.
	4) Updated PATCH 5 for unaligned 64bit read


Sunil V L (5):
  riscv: cpu_ops_sbi: Support for 64bit hartid
  riscv: spinwait: Fix hartid variable type
  riscv: smp: Support for 64bit hartid
  riscv: cpu: Support for 64bit hartid
  riscv/efi_stub: Support for 64bit boot-hartid

 arch/riscv/include/asm/processor.h        |  4 ++--
 arch/riscv/include/asm/smp.h              |  4 ++--
 arch/riscv/kernel/cpu.c                   | 26 +++++++++++++----------
 arch/riscv/kernel/cpu_ops_sbi.c           |  4 ++--
 arch/riscv/kernel/cpu_ops_spinwait.c      |  4 ++--
 arch/riscv/kernel/cpufeature.c            |  6 ++++--
 arch/riscv/kernel/smp.c                   |  4 ++--
 arch/riscv/kernel/smpboot.c               |  9 ++++----
 drivers/clocksource/timer-riscv.c         | 15 +++++++------
 drivers/firmware/efi/libstub/riscv-stub.c | 13 +++++++++---
 drivers/irqchip/irq-riscv-intc.c          |  7 +++---
 drivers/irqchip/irq-sifive-plic.c         |  7 +++---
 12 files changed, 60 insertions(+), 43 deletions(-)

-- 
2.25.1

