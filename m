Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E84687A8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 22:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355734AbhLDVix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 16:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhLDViw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 16:38:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD5CC061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 13:35:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n12so15434861lfe.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 13:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msUpArhRy8wdm0cKy+shcB9fiwW0FQ4TneJPMUYT/ss=;
        b=YqvFBc4mcIl6uAotVZR2uxM+tlsrr1RraJjIa6qupLo2aXuHdYxbW9tfV7bbuqcn8m
         RnvgN15bRivsuVpZqu/Wm7HBrvV9AJs4+b7iEh1XNQCh2aIxKcP3S7YRo3ixof+u+iK5
         mZYk5jJZpl3MP2RWvc11I8UtShJ/oB6tPpHEstv13FC4dMACTCfhcAXsTFDV77kHV5k2
         Mgt3ss4f/BQ/E2IdCQo83Aordps/YM6fAMWiVoCYXYW2eWYzgJOR5EwZxlitcdY3s1e7
         msrVl9LyEsHAs6jzt9hoxEV827K72b0p+p991rXS3zVeygOlNq/nfSNgl3nvgRBAcxHl
         BlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=msUpArhRy8wdm0cKy+shcB9fiwW0FQ4TneJPMUYT/ss=;
        b=YQ8pzlL54EDH9NAGVS1/o3YPBMKDDeELxaqK+GkoBxwRSTr8cL7c3mP1M3/UUnlwnw
         NlBkWHg0sBlKTPsKvyDIHys41jsiQtGEiclQs+F7wbwv8QiErVhvOngCQPJ1RY6WMzRQ
         IsEHTN5Zr7HE/Y85R+j9Qo/wkNbIJlx49ZC2rpUGAyfIpvvyb3wjqpHsq/tx6gB1eaRZ
         X/y0Vc0E660Xnyw1adXMGPu3RaaHa1au2Rt2T8xg37gmtxMgR8Gd1OQ9HfKvPbFueq47
         dcX4BfCQDiswTYLC3votpUI8uqbwYrWODzYAwz270b9fVEDDzUMLxasjfHCT4i7Dnnak
         ahWw==
X-Gm-Message-State: AOAM53048mJpxkpBt3nYtN+Sbj5RyvFefMaRARVVo+Q6L9jBPNYWwd8O
        tL1VtAiKKeahZPjqjUNZjIc=
X-Google-Smtp-Source: ABdhPJy1foNQC1fgBE39jI5YX063JtAdtVHP0Vv+8WDaFnUy2KJ/0i1ix7+RrnYn6SjeA/Tb6hx43Q==
X-Received: by 2002:a19:e046:: with SMTP id g6mr25638279lfj.176.1638653724763;
        Sat, 04 Dec 2021 13:35:24 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id q24sm873218lfp.103.2021.12.04.13.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 13:35:24 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] KVM: arm64: Constify kvm_io_gic_ops
Date:   Sat,  4 Dec 2021 22:35:18 +0100
Message-Id: <20211204213518.83642-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of kvm_io_gic_ops is to make a comparison with its
address and to pass its address to kvm_iodevice_init() which takes a
pointer to const kvm_io_device_ops as input. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio.c | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index 48c6067fc5ec..7068da080799 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -1050,7 +1050,7 @@ static int dispatch_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *dev,
 	return 0;
 }
 
-struct kvm_io_device_ops kvm_io_gic_ops = {
+const struct kvm_io_device_ops kvm_io_gic_ops = {
 	.read = dispatch_mmio_read,
 	.write = dispatch_mmio_write,
 };
diff --git a/arch/arm64/kvm/vgic/vgic-mmio.h b/arch/arm64/kvm/vgic/vgic-mmio.h
index fefcca2b14dc..3fa696f198a3 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.h
+++ b/arch/arm64/kvm/vgic/vgic-mmio.h
@@ -34,7 +34,7 @@ struct vgic_register_region {
 	};
 };
 
-extern struct kvm_io_device_ops kvm_io_gic_ops;
+extern const struct kvm_io_device_ops kvm_io_gic_ops;
 
 #define VGIC_ACCESS_8bit	1
 #define VGIC_ACCESS_32bit	2
-- 
2.34.1

