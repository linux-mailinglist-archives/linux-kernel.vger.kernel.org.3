Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10274538AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiEaFSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiEaFSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:18:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E43465B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=AISHTQNOXWXhXBPrTXP8HMK36y6k19YKlAeaBaaAUYI=; b=gKD6MQBHVag/ja57KdP9OCrXJt
        JMr7iBjlXGr4ttu0zNTfWZgN3HtOCq8sgYWNQ8Pz5E3CQ46W6vyej4yDaJZjWduO8+JQyplcSOq34
        HuKNg6I0owcO8yBvsgAqj+9mSRkvsbHhQwCM/+mKPsmJ4L1M7yTcVEnchuGQ3p8WQbcdZj5yEjRZb
        uOV4Su6uSerjagYgp9h5qvy3Ggwpz6f27yR+pm8VKAq423eE+60yLieZfse4O88VN7KgV/DyJDVVQ
        +8ADRPvEuRDE6gKffhoZ/JlfK6CUw+Ctr3i2nxQgwYT2bWOztsO0F7f7kJ6EmfoRnZDtEp2ydyuEm
        t2IGHP2g==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvuH4-0054Vg-GT; Tue, 31 May 2022 05:18:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH -next] riscv: errata: T-HEAD depends on !XIP_KERNEL
Date:   Mon, 30 May 2022 22:18:26 -0700
Message-Id: <20220531051826.9317-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
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

Fix kconfig dependency warning:

WARNING: unmet direct dependencies detected for RISCV_ALTERNATIVE
  Depends on [n]: !XIP_KERNEL [=y]
  Selected by [y]:
  - ERRATA_THEAD [=y]

Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/Kconfig.erratas |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -35,6 +35,7 @@ config ERRATA_SIFIVE_CIP_1200
 
 config ERRATA_THEAD
 	bool "T-HEAD errata"
+	depends on !XIP_KERNEL
 	select RISCV_ALTERNATIVE
 	help
 	  All T-HEAD errata Kconfig depend on this Kconfig. Disabling
