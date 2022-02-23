Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70EA4C1C86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiBWTrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiBWTrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:47:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513429803
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NoZnjZiDPKdLXb/l9M3U/YE64GQCSgmcN10HaIIhQUY=; b=qfw88KKbGgnkOtQuodJVvrGdqy
        3dJfQcf+0CAPlGYftpAUNJPzP5yVTEXy0XU8D3cCGqfOJNMco50chwMBgkUVPFYXp62F0jtOMLq9H
        0vKRVoGFnZNKJclrAKOSY6XR8gzlY9OrA1FZ3FnZ+7LjQMMomLRVAOuQUDbHoP74foUfw8xWjWe7/
        dCSv7PvQkj8CHK60OgDXjZ45PUao9VcN92e0P0eJ8V0uXaRigWkpZJQRS95rrcMQgUiUYOg3njo7m
        IF58OsAsKorhy/2byTDDL/kdZdDmrtpUekVl4WBN5HURF33Z3MsTS8N0Pen+UBCJ6JiMQB/2wB+Au
        b+kUi1LQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMxau-00Fv28-5h; Wed, 23 Feb 2022 19:46:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH] arm: mmu: fix returns from early_param() and __setup() functions
Date:   Wed, 23 Feb 2022 11:46:35 -0800
Message-Id: <20220223194635.4044-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

early_param() handlers should return 0 on success.
__setup() handlers should return 1 on success, i.e., the parameter
has been handled. A return of 0 would cause the "option=value" string
to be added to init's environment strings, polluting it.

../arch/arm/mm/mmu.c: In function 'test_early_cachepolicy':
../arch/arm/mm/mmu.c:215:1: error: no return statement in function returning non-void [-Werror=return-type]
../arch/arm/mm/mmu.c: In function 'test_noalign_setup':
../arch/arm/mm/mmu.c:221:1: error: no return statement in function returning non-void [-Werror=return-type]

Fixes: b849a60e0903 ("ARM: make cr_alignment read-only #ifndef CONFIG_CPU_CP15")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: v5.16

 arch/arm/mm/mmu.c |    2 ++
 1 file changed, 2 insertions(+)

--- next-2022-0222.orig/arch/arm/mm/mmu.c
+++ next-2022-0222/arch/arm/mm/mmu.c
@@ -212,12 +212,14 @@ early_param("ecc", early_ecc);
 static int __init early_cachepolicy(char *p)
 {
 	pr_warn("cachepolicy kernel parameter not supported without cp15\n");
+	return 0;
 }
 early_param("cachepolicy", early_cachepolicy);
 
 static int __init noalign_setup(char *__unused)
 {
 	pr_warn("noalign kernel parameter not supported without cp15\n");
+	return 1;
 }
 __setup("noalign", noalign_setup);
 
