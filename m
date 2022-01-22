Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E54496E4B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 00:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiAVXk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 18:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiAVXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 18:40:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59734C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+gXQH3ALH4LYdIHoBa7Tkg7RviZom2y8b9WvEFeHe6U=; b=LfpAmKQkAEdl4V0rv4MxuIZy/s
        rvNDvu4/JXEds4Wfr8B9ouFS/+BF9Bi6bt6qUBIn7etor3lxdm1R1fTepvJTdtez4AzG66THkgG59
        mPcDDZSb0BumUgNUGxugiyPRb4t1fbo+92kyMNbfVn+Tu3em32o45WN/q7UQt3fT/F9xTVTGfAhs4
        DQ/22U7i2ftHhhtIMADnX/PDTxaEM+ssAMhr8n67Pouwiy98ip1+qIUX2qT/ubUxg7XNidFxoQLqP
        nKjcvOc+1rPm6niBWb9/jwo5oljSzMjLLTSLNhvJ4jNc2n9FLQtUfRYpk3bhseDsNAUBWFSdPwi1/
        qKC4htBw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBQ08-0007hm-1E; Sat, 22 Jan 2022 23:40:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH -next] irqchip/gic-v3-its: protect reference to cpus_booted_once_mask
Date:   Sat, 22 Jan 2022 15:40:55 -0800
Message-Id: <20220122234055.647-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_SMP is not set/enabled, the reference in irq-gic-v3-its.c
to 'cpus_booted_once_mask' causes a build error. Fix this by
first checking for !CONFIG_SMP in the 'if' test.

Fixes this build error:

arm-linux-gnueabi-ld: drivers/irqchip/irq-gic-v3-its.o: in function `its_cpu_memreserve_lpi':
irq-gic-v3-its.c:(.text+0x45d0): undefined reference to `cpus_booted_once_mask'

Fixes: 835f442fdbce3 ("irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20220121.orig/drivers/irqchip/irq-gic-v3-its.c
+++ linux-next-20220121/drivers/irqchip/irq-gic-v3-its.c
@@ -5241,7 +5241,8 @@ static int its_cpu_memreserve_lpi(unsign
 
 out:
 	/* Last CPU being brought up gets to issue the cleanup */
-	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
+	if (!IS_ENABLED(CONFIG_SMP) ||
+	    cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
 		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
 
 	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;
