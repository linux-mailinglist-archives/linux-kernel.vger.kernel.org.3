Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C60F47AAD1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhLTOAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:00:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhLTOAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:00:51 -0500
Date:   Mon, 20 Dec 2021 14:00:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640008849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ppB7xB4HPOqjXSqkrtYN4R7oyaDk/c0qUqcYGfwM40=;
        b=F0YIXO7LuKYNregTukNcAql3xTeXxem9EivCkaLrV2YSPhnvLNZscNBQCVroWxmjVpFMRJ
        Cn9xCLCEYFxECqfapepqOmnmuAEiBzR8lCGr5/clqEGgjXXbAxT8HjmJP+Jt6fj8u/iNQ1
        Cpz+iMOQFLhzOt2PU4swaELjf0J3kKGFSryS31DlSIjZjD1qbftBUd64IiGxr9cYt4JSTd
        j2QFO6WIg9dh4QyN0FILNDgN9h8hCmisTWgJAkm7twJ7lt+18um04wuTKzrZdw8rnOVnTH
        3rsEAUwxz1Pw0uMyucu1U+wyuNU4IO7lHyjGFhZhQlLOl+J9aIRowRQXjXZ7zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640008849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ppB7xB4HPOqjXSqkrtYN4R7oyaDk/c0qUqcYGfwM40=;
        b=ANOj2yh8kDAhoPR3JuK1/P0Lr2bQFWVt+HUSVfq07qNYLqYRVLivZ0ElHF3kwZOGU3jQLV
        J5hcxilYQyWWVADA==
From:   "irqchip-bot for Rikard Falkeborn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] KVM: arm64: Constify kvm_io_gic_ops
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211204213518.83642-1-rikard.falkeborn@gmail.com>
References: <20211204213518.83642-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Message-ID: <164000884802.23020.11471347198452228590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     636dcd0204599f94680f8f87b46cef7c66034ac0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/636dcd0204599f94680f8f87b46cef7c66034ac0
Author:        Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate:    Sat, 04 Dec 2021 22:35:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 06 Dec 2021 08:34:06 

KVM: arm64: Constify kvm_io_gic_ops

The only usage of kvm_io_gic_ops is to make a comparison with its
address and to pass its address to kvm_iodevice_init() which takes a
pointer to const kvm_io_device_ops as input. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211204213518.83642-1-rikard.falkeborn@gmail.com
---
 arch/arm64/kvm/vgic/vgic-mmio.c | 2 +-
 arch/arm64/kvm/vgic/vgic-mmio.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index 48c6067..7068da0 100644
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
index fefcca2..3fa696f 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.h
+++ b/arch/arm64/kvm/vgic/vgic-mmio.h
@@ -34,7 +34,7 @@ struct vgic_register_region {
 	};
 };
 
-extern struct kvm_io_device_ops kvm_io_gic_ops;
+extern const struct kvm_io_device_ops kvm_io_gic_ops;
 
 #define VGIC_ACCESS_8bit	1
 #define VGIC_ACCESS_32bit	2
