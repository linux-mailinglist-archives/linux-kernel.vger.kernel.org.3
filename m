Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A115251BFE0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378174AbiEEMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378324AbiEEMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:55:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCC3562C8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:51:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvD915p86z4ySp;
        Thu,  5 May 2022 22:51:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1651755093;
        bh=ubB6SgfDI+P/k0hjAXWGeJL0PaKlzbLWzO8P81xOKRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UT76O0MVOxgFBUcqfS+zazksdH1WlzfSxD9DLhoC8ByPMcfUoMgpr87iGkGfjrKCd
         +9abcqvXbSs4zO4Dywl7DiSOoS1M/gGuZMEWjZN6SILB2Xvmixiv6lMdaWij74v5q2
         XwJXjOjeKGUwzS1UIJsh+uN0XvWGzkmIc0wkbJFyA03xNBRVynRVf3QQNgpPTsWeSe
         PW9lhIRoDlCTLyNHqFVp8zCEvtqE5eXwRIKukVnqMCezRrCMRcE+igexH0wn1QobtB
         fEfnKKfPfjIO5LlxkMrvG6mHsqErhh2wo1ocoPEYvyIqAcxN2TngT1Cw14sVrbaAxS
         7AqF2QtIMDwrg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arch/Kconfig: Drop references to powerpc PAGE_SIZE symbols
Date:   Thu,  5 May 2022 22:51:23 +1000
Message-Id: <20220505125123.2088143-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505125123.2088143-1-mpe@ellerman.id.au>
References: <20220505125123.2088143-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous commit powerpc added PAGE_SIZE related config symbols
using the generic names.

So there's no need to refer to them in the definition of
PAGE_SIZE_LESS_THAN_64KB etc, the negative dependency on the generic
symbol is sufficient (in this case !PAGE_SIZE_64KB).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4ba..d235c9089d17 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1007,12 +1007,10 @@ config PAGE_SIZE_LESS_THAN_64KB
 	depends on !IA64_PAGE_SIZE_64KB
 	depends on !PAGE_SIZE_64KB
 	depends on !PARISC_PAGE_SIZE_64KB
-	depends on !PPC_64K_PAGES
 	depends on PAGE_SIZE_LESS_THAN_256KB
 
 config PAGE_SIZE_LESS_THAN_256KB
 	def_bool y
-	depends on !PPC_256K_PAGES
 	depends on !PAGE_SIZE_256KB
 
 # This allows to use a set of generic functions to determine mmap base
-- 
2.35.1

