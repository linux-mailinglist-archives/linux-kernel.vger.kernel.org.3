Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB35326A8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiEXJk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiEXJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:40:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA966C9E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DFEC8CE19E6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE16DC385AA;
        Tue, 24 May 2022 09:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653385209;
        bh=XsiPB+YmgXZsRlXprg01ZA3bkNDDn/VDzc7T4K91VkQ=;
        h=From:To:Cc:Subject:Date:From;
        b=I86vb4PBaO9vScyygfzJ8J4eaAUxqUdt7VKo32RX6XV/TOxkMEZwtuXWPvTR8XawH
         cJdtEIJqjJPQsHGQ4lXTeP3jZXjTM2KWg0JC8TgtO0vxfiae/eAAEPzn24QfYX0mSW
         bdZ7FzX0Kgs+xoXpwknpvubbysG7H8dR1EZFn1WRrGGB3Y8x6ybPgwJkMN6YNSLFjo
         7+OrKyweIoplXE66LAsGUuqo+Kd8jvCoszAcHZBsKc846Y5P7jbL5uYZKjazxfZuxH
         lktWa1+wA1mxXpRwTDcfpWX9BVn34w3o2Wkhfa1sVHdP7Ac1ZNxKkkx4JmS34X5kRr
         HN5mXjfCaK4rQ==
Received: by pali.im (Postfix)
        id 392A09ED; Tue, 24 May 2022 11:40:06 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Date:   Tue, 24 May 2022 11:39:39 +0200
Message-Id: <20220524093939.30927-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc e500 compiler does not support -mcpu=powerpc option. When it is
specified then gcc throws compile error:

  gcc: error: unrecognized argument in option ‘-mcpu=powerpc’
  gcc: note: valid arguments to ‘-mcpu=’ are: 8540 8548 native

So do not set -mcpu=powerpc option when CONFIG_E500 is set. Correct option
-mcpu=8540 for CONFIG_E500 is set few lines below in that Makefile.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/powerpc/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index eb541e730d3c..87f9f29ac9d2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -22,11 +22,16 @@ ifdef CONFIG_PPC32
 # or platform code sets later on the command line, but they are needed
 # to set a sane 32-bit cpu target for the 64-bit cross compiler which
 # may default to the wrong ISA.
+# Never set -mcpu=powerpc option for gcc e500 compiler because this
+# option is unsupported and throws error. The correct option for
+# CONFIG_E500 is -mcpu=8540 and it is set few lines below.
+ifndef CONFIG_E500
 KBUILD_CFLAGS		+= -mcpu=powerpc
 KBUILD_AFLAGS		+= -mcpu=powerpc
 endif
 endif
 endif
+endif
 
 ifdef CONFIG_PPC_BOOK3S_32
 KBUILD_CFLAGS		+= -mcpu=powerpc
-- 
2.20.1

