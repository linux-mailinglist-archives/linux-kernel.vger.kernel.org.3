Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0E4D6933
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351082AbiCKTuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiCKTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:50:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5941D1B45EE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RABIBhFIaklwwduCWghSw0c+OOipsVwUT2sVRxK728c=; b=V87MKzh8WFchR1TeJJI0APaJhp
        XqMDETLLZlcgvWhsIWSyDJvs1CrMlasidnm5MeXbb5jQC4zIObtx3bFmLaz2BTvKZxSx8qat94GpQ
        SYe4LviwJC79Eoq0cQNvhhZkdRC+vZ4KaPd4g+zCmHGsO0aFA1OM4jb4JySCOnk1TCzTGNvDszOxi
        7F35JAK6ERl4F7wB5g1B6zyF8T1Ku9ofMmyO/dUulWrcA37Db4ETX5R3fPCKPKgv/f8jiqBifptkf
        QSwbR5nMd1sF9ut8I+mJ0JMfs2wRCbNjZ4dvFoy9WNW1VuqdsEvXO/GWrJUMbSUlAnQID/s5OJv1G
        aQHD3+jw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSlGD-0007Z5-S7; Fri, 11 Mar 2022 19:49:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH v2] ARM: Spectre-BHB: provide empty stub for non-config
Date:   Fri, 11 Mar 2022 11:49:12 -0800
Message-Id: <20220311194912.26249-1-rdunlap@infradead.org>
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

When CONFIG_GENERIC_CPU_VULNERABILITIES is not set, references
to spectre_v2_update_state() cause a build error, so provide an
empty stub for that function when the Kconfig option is not set.

Fixes this build error:

arm-linux-gnueabi-ld: arch/arm/mm/proc-v7-bugs.o: in function `cpu_v7_bugs_init':
proc-v7-bugs.c:(.text+0x52): undefined reference to `spectre_v2_update_state'
arm-linux-gnueabi-ld: proc-v7-bugs.c:(.text+0x82): undefined reference to `spectre_v2_update_state'

Fixes: b9baf5c8c5c3 ("ARM: Spectre-BHB workaround")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2: add Russell's Ack and suggestion to send directly to Linus.

Linus- Russel King says:

I'd suggest sending this direct to Linus as I've been doing with the
other fixes for Spectre BHB. Trying to fit it now into a pull request
is just going to be very messy.

KernelVersion: v5.17-rc7-205-g79b00034e9dc

 arch/arm/include/asm/spectre.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-next-20220310.orig/arch/arm/include/asm/spectre.h
+++ linux-next-20220310/arch/arm/include/asm/spectre.h
@@ -25,7 +25,13 @@ enum {
 	SPECTRE_V2_METHOD_LOOP8 = BIT(__SPECTRE_V2_METHOD_LOOP8),
 };
 
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
 void spectre_v2_update_state(unsigned int state, unsigned int methods);
+#else
+static inline void spectre_v2_update_state(unsigned int state,
+					   unsigned int methods)
+{}
+#endif
 
 int spectre_bhb_update_vectors(unsigned int method);
 
