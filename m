Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4035B4BEA14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiBUR6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:58:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiBURzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:55:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5738E01C;
        Mon, 21 Feb 2022 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/FM4BeA5AMOBfdTgSAmRLVTFsUL98NQyEY77WysQYVo=; b=zLsc4AXd99f4dJ1kp7KQgopJd4
        Lba1XebLJS2VyOkWL82dRsrs8Px+vwdg+p6JzhnnNMwin/vH14PNSv6da8sCn6SEw5KqZXcj4W1NE
        rpGjemu/JmvZbQ4FnsSFQjOHsF7P5RJk+a6UC3ZNNkzE16sD7wyOZNzbAVzEcJPh/BeD6q2m3BY80
        V/LVHJyFAWDuhDS50atd4v3YaUVAdWQ/gBn3UlWUV6dae3h566RR+AtnD9YA4EFWPzkq9VNRDLQb0
        lfpfP9n7ayTAGlte20sIKjX0L12P+2ZcqjGVC4T0fdHdS0YoK4ddNLU/mpiJ9zcCq3q0rSzo6diK2
        V5+JnLzg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMCpS-006r5a-GS; Mon, 21 Feb 2022 17:50:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: [PATCH] mips: setup: fix setnocoherentio() boolean setting
Date:   Mon, 21 Feb 2022 09:50:29 -0800
Message-Id: <20220221175029.6046-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct a typo/pasto: setnocoherentio() should set
dma_default_coherent to false, not true.

Fixes: 14ac09a65e19 ("MIPS: refactor the runtime coherent vs noncoherent DMA indicators")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220217.orig/arch/mips/kernel/setup.c
+++ linux-next-20220217/arch/mips/kernel/setup.c
@@ -803,7 +803,7 @@ early_param("coherentio", setcoherentio)
 
 static int __init setnocoherentio(char *str)
 {
-	dma_default_coherent = true;
+	dma_default_coherent = false;
 	pr_info("Software DMA cache coherency (command line)\n");
 	return 0;
 }
