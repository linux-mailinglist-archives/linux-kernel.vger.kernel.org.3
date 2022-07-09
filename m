Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC556C5C9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGIBtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIBtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:49:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E1709BB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aHkveyM+Om9u2IdcFldBf9uD1c2apNFY/SnalVz/8kw=; b=UbHcmh9mUxnQGeVW674eJWgYeo
        P29zhK3BeUIsE3QES2Up8mHl0nWDHapO+/eOdR8iLIJqHKwh5WbDVf2bucZxjIXcIIFK/EONqVu/N
        ybjniFNFbj13lntQzf3R1YM218NE1r858HHZCI5EeF6xmjXYzejWD2tk2CTwqYMrrEji82xCHlEAj
        baQH8uMrP8uDUzp2tyE645adqxVwRwbH5F6pBs9cwNg8fVXajHHnOlHixRBmGhwFs9w54rv4wc9NH
        NhYL30uHz+bWDraLNLU5qNMBP4YY+/qN7xTsv2QKxpADicJQ4ibKZly9uMuQKLpfN+a5tcrzO0fh+
        ZddVrIcw==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9zbD-0041Xe-Cq; Sat, 09 Jul 2022 01:49:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Wei Fu <wefu@redhat.com>,
        Liu Shaohua <liush@allwinnertech.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: fix RISCV_ISA_SVPBMT kconfig dependency warning
Date:   Fri,  8 Jul 2022 18:49:29 -0700
Message-Id: <20220709014929.14221-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.36.1
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

RISCV_ISA_SVPBMT selects RISCV_ALTERNATIVE which depends on !XIP_KERNEL.
Therefore RISCV_ISA_SVPBMT should also depend on !XIP_KERNEL so
quieten this kconfig warning:

WARNING: unmet direct dependencies detected for RISCV_ALTERNATIVE
  Depends on [n]: !XIP_KERNEL [=y]
  Selected by [y]:
  - RISCV_ISA_SVPBMT [=y] && 64BIT [=y] && MMU [=y]

Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wei Fu <wefu@redhat.com>
Cc: Liu Shaohua <liush@allwinnertech.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -362,6 +362,7 @@ config RISCV_ISA_C
 config RISCV_ISA_SVPBMT
 	bool "SVPBMT extension support"
 	depends on 64BIT && MMU
+	depends on !XIP_KERNEL
 	select RISCV_ALTERNATIVE
 	default y
 	help
