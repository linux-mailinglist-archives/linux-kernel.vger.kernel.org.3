Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA361490A33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiAQOVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiAQOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:21:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:21:39 -0800 (PST)
Date:   Mon, 17 Jan 2022 14:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642429297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzeiKFPvpQ7m+A8DOuIBKCgoDD+P+7sKHN5LSfqJpJ4=;
        b=Rr0kJKnE2OhSx6vbG1G81b7q5sSYSaOrPfyGvJJaIXkIjklSvBrZzBYtHsFdKAfdEp9QHe
        9X6gVagJF8VmQF2gOT55ORawZGE5Ei7MnK06nBRz5SO1anvIgooEQYCIfdzQOjM6Q58OYK
        a3oWx9dvelDVhwfviPNdUzm7az3jzpu0H4hwMGeBA/oBKSPJ3QdcEG68btnodMlavAn9Es
        IyZRhh0Ozr8u7IqirwAVJ3HnF1OkjIiiNUAeAv0B5rsfXMXaoNtd+3lsAZNwCYdgj1P933
        khITfoSy/iCqK7zR4d9o5NGCDVjoNQHIPSbfNA5w20ManrCNxCNYV8dEDcRoCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642429297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzeiKFPvpQ7m+A8DOuIBKCgoDD+P+7sKHN5LSfqJpJ4=;
        b=sVAklS6ankV/HfRN1a7JL4XCE8pDd6Wpcq3O7Os+A6JYoTMDBMALlvZgR9lCKYDPkmscrV
        mCZypUsNXtYHcnBw==
From:   "irqchip-bot for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongson-pch-ms: Use
 bitmap_free() to free bitmap
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C0b982ab54844803049c217b2899baa59602faacd=2E16405?=
 =?utf-8?q?29916=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C0b982ab54844803049c217b2899baa59602faacd=2E164052?=
 =?utf-8?q?9916=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <164242929604.16921.18409641400144291653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     c831d92890e037aafee662e66172d406804e4818
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/c831d92890e037aafee662e66172d406804e4818
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sun, 26 Dec 2021 15:46:21 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 17 Jan 2022 13:16:26 

irqchip/loongson-pch-ms: Use bitmap_free() to free bitmap

kfree() and bitmap_free() are the same. But using the latter is more
consistent when freeing memory allocated with bitmap_zalloc().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/0b982ab54844803049c217b2899baa59602faacd.1640529916.git.christophe.jaillet@wanadoo.fr
---
 drivers/irqchip/irq-loongson-pch-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 32562b7..e3801c4 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -241,7 +241,7 @@ static int pch_msi_init(struct device_node *node,
 	return 0;
 
 err_map:
-	kfree(priv->msi_map);
+	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
 	return ret;
