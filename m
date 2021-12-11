Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48D471338
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 10:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhLKJyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 04:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhLKJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 04:54:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D8C061714;
        Sat, 11 Dec 2021 01:54:13 -0800 (PST)
Date:   Sat, 11 Dec 2021 09:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639216451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GX5PWK66o/pgQhDsT3MwH63pCrCKY58pj7wu38+F2Ig=;
        b=Wx2Td8EHpy3C32+E1iPMowNHvRhVhQ/904dGxAeQkdG7aWHCCzhtFKP93mkcDOSkTrVqiZ
        s7auy0oZvYu7jQBIum5rlFGEWJSrmTQkNnPK3xcwKxxAVPZ4c2ATDv0qpN4r5eYViiPakA
        gbyloKplV36Cxe6khlxZqfI8GnCSwbUr4t7cL5Ifl1wdXQq4Om3H5xFjbtPPobfv6mTAg+
        Qb+iy+vlMWeTMcJI8BL5e3rVYq2xcjb2v+KXNSlTiq5lFfuDWXXMP2XJwRi1ETSenFba9z
        NAB5LJ67NJI+FB1MFLMBmM/PVS2k+3fi+RpdKUnTR+rZEFQ/oIchepr2Cpw/Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639216451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GX5PWK66o/pgQhDsT3MwH63pCrCKY58pj7wu38+F2Ig=;
        b=ji1q9s7Nr9F/TUAsEayhgugBrATPVESuhGNECyHhrwfpp/gQXwUviBvWbPQpI9CEFVFOle
        93eu6uBR7EYAmQDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.16-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20211210133516.664497-1-maz@kernel.org>
References: <20211210133516.664497-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163921644975.23020.1268108084524887170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     b7fd35a0ad976ee8e7d4914e063410686b5fa353
Gitweb:        https://git.kernel.org/tip/b7fd35a0ad976ee8e7d4914e063410686b5fa353
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 11 Dec 2021 10:51:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 11 Dec 2021 10:51:23 +01:00

Merge tag 'irqchip-fixes-5.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

 - Fix Armada-370-XP Multi-MSi allocation to be aligned on the allocation
   size, as required by the PCI spec

 - Fix aspeed-scu interrupt acknowledgement by directly writing to the
   register instead of a read-modify-write sequence

 - Use standard bitfirl helpers in the MIPS GIC driver instead of custom
   constructs

 - Fix the NVIC driver IPR register offset

 - Correctly drop the reference of the device node in the irq-bcm7120-l2
   driver

 - Fix the GICv3 ITS INVALL command by issueing a following SYNC command

 - Add a missing __init attribute to the init function of the Apple AIC
   driver

Link: https://lore.kernel.org/r/20211210133516.664497-1-maz@kernel.org
---
