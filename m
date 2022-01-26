Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9349C843
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbiAZLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbiAZLG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:06:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC55C061744
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:06:26 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id h23so20796238pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVeAFMlelYX7tOY5dDydv687Sysfy98XLePUPfp3n+4=;
        b=iqV0Y1Oo4ZVC/LRdBxUVY+DWQCtN9EwZe16EDDI+ah7IN4Vu4+QJvHYkwMwMS9rPRj
         zksepFiZKbXjUahiuPE4mzkZZ41qSeF94mgFF2PXpn4F/PtAxL70JEoe5xpd78FyK4ib
         O0XWJVhx74oMvbVjpMS9ly9CjBGi3VEue3JeXxRilv28DYl2vlb9miSaS3UB4Wf/iiJO
         6P/dqKECxZyzsemWHECF4KdY3FAKPCBC4GQ4Feww6ZDAmFekb1xVADAoCu8cyDzat0EK
         TWeIU/+djGuIuY0kxB48NdAskmC/TEY+BV3D9VwF4RoccwOu/k9BP6Wofw4ZSc+cwbgi
         LCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wVeAFMlelYX7tOY5dDydv687Sysfy98XLePUPfp3n+4=;
        b=uaLhvm+t8k84RiykcoTOkJyrwB8e/J+UliHvRW9hyS3iZqmFpfL+qZWNCwq3MXZsdC
         AdLUxxcCl3hRXnfd/8s9ojrwOYl6MD4C+3ieAzC8UpQPoLdUbHCIoXa/UqU05v2mFrvp
         KRjB0s2C1YllGMcbwDt8+ESaLWP3b3+dTL7+8YB9V6ZeR2nTeetXvCGDFlAdO8MeB6dB
         q0IH8uRGeNAcJjOPZcGeswcRaa+nqH13bW+sqjctnnJDrXnsxyrCy+7a8GOr8xy/sbfq
         dO82KPZvoxtACOMYid5qgiQF76v4/RGiijGgMiOGVi2Ba+585Ov2UMsOoneS/ccgG149
         ILvQ==
X-Gm-Message-State: AOAM53241qsIo66FzafGt8Ymyu1hz9JZKTXd3mHztJENwD0NwYrzKGMl
        qhbpYPw8OVdmuzZCDVoXNuhsGg==
X-Google-Smtp-Source: ABdhPJzTN8jP0iLPGAsGM1I8G+Bpd70Ujns36T3AIMX2axXRe9kLrfxOT2tnD1+4nMMN15p2XefwNg==
X-Received: by 2002:a63:8949:: with SMTP id v70mr13202922pgd.380.1643195185796;
        Wed, 26 Jan 2022 03:06:25 -0800 (PST)
Received: from sunil-ThinkPad-T490.dc1.ventanamicro.com ([49.206.3.187])
        by smtp.gmail.com with ESMTPSA id r11sm1811792pff.81.2022.01.26.03.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:06:25 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Abner Chang <abner.chang@hpe.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH 0/1] RISCV_EFI_BOOT_PROTOCOL support in linux
Date:   Wed, 26 Jan 2022 16:36:14 +0530
Message-Id: <20220126110615.33371-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for getting the boot hart ID using new
RISCV_EFI_BOOT_PROTOCOL in linux efi stub. While there is an existing solution
of passing the boot hart ID through Device Tree, it doesn't work for ACPI. Hence
an EFI protocol protocol is recommended which works for both DT and ACPI based
platforms.

The latest draft spec of this new protocol is available at
https://github.com/riscv-non-isa/riscv-uefi/releases/download/1.0-rc2/RISCV_UEFI_PROTOCOL-spec.pdf

This linux ptach can be found in:
riscv_boot_protocol_rfc_v1 branch at https://github.com/vlsunil/linux.git

This is tested in qemu with both u-boot and edk2 firmware changes. To test this
patch with u-boot, we need u-boot to support this new protocol which can be
found in:
riscv_boot_protocol_rfc_v1 branch at https://github.com/vlsunil/u-boot.git

Sunil V L (1):
  riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL

 drivers/firmware/efi/libstub/efistub.h    | 15 ++++++++++++
 drivers/firmware/efi/libstub/riscv-stub.c | 28 ++++++++++++++++++++---
 include/linux/efi.h                       |  1 +
 3 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.25.1

