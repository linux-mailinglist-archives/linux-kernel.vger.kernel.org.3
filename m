Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6E5A37FC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiH0Nqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0Nqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 09:46:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDE2E9DB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 06:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EE57B80108
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 13:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED316C433D7;
        Sat, 27 Aug 2022 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661608001;
        bh=O8gmx9Ap9zIBtCiJLLQVT7q7XPpgT6RZWLM3kJPhSvk=;
        h=From:To:Cc:Subject:Date:From;
        b=r2tQiZE/jvIeD6vjt6YkQzdVBMP/CjgW33BfZqQ8Cld7KkbLWgc12UdtIbfGXLPX/
         kQf/3ymxgAUEB2DZCCbJ9jUMcNo9vLRlgRRLyx2vQI7w3rUiU5mEAaEpKjxtIIaev2
         JM1GtSM97GxDKxLch2o1S29OiIH8CtdfVH47fwu7AxRFcE0xM8FQusxt696LpxeEvM
         TB/XR9NcNd4nYXnqeYgyeTen6mwBbAEePs2J6MR2LKFLbtkxABm1ntwv2VElq784FX
         Pc4gJgNIQI9lW50lf02jiqvWMUphoMrn4lIR0FVOLnVg0ZAkR1rC3B8/OejnbE9of6
         zuSgkBA+9ZgLQ==
Received: by pali.im (Postfix)
        id 239EAC7A; Sat, 27 Aug 2022 15:46:38 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/boot: Explicitly disable usage of SPE instructions
Date:   Sat, 27 Aug 2022 15:44:54 +0200
Message-Id: <20220827134454.17365-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uImage boot wrapper should not use SPE instructions, like kernel itself.
Boot wrapper has already disabled Altivec and VSX instructions but not SPE.
Options -mno-spe and -mspe=no already set when compilation of kernel, but
not when compiling uImage wrapper yet. Fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index f56a5f90a5d8..2247374c4e70 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -34,6 +34,7 @@ endif
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx \
+		 $(call cc-option,-mno-spe) $(call cc-option,-mspe=no) \
 		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 $(LINUXINCLUDE)
 
-- 
2.20.1

