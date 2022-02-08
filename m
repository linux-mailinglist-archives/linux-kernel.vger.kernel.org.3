Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6684ADC82
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379910AbiBHPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380046AbiBHPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:23:25 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28BCC0612B8;
        Tue,  8 Feb 2022 07:23:21 -0800 (PST)
Received: from localhost.localdomain (ip5f5aebc2.dynamic.kabel-deutschland.de [95.90.235.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3486761E6478B;
        Tue,  8 Feb 2022 16:23:20 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org,
        Matt Brown <matthew.brown.dev@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] lib/raid6: Include <asm/ppc-opcode.h> for `VPERMXOR`
Date:   Tue,  8 Feb 2022 16:21:50 +0100
Message-Id: <20220208152148.48534-2-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208152148.48534-1-pmenzel@molgen.mpg.de>
References: <20220208152148.48534-1-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Ubuntu 21.10 (ppc64le) building `raid6test` with gcc (Ubuntu
11.2.0-7ubuntu2) 11.2.0 fails with the error below.

    gcc -I.. -I ../../../include -g -O2                      -I../../../arch/powerpc/include -DCONFIG_ALTIVEC -c -o vpermxor1.o vpermxor1.c
    vpermxor1.c: In function ‘raid6_vpermxor1_gen_syndrome_real’:
    vpermxor1.c:64:29: error: expected string literal before ‘VPERMXOR’
       64 |                         asm(VPERMXOR(%0,%1,%2,%3):"=v"(wq0):"v"(gf_high), "v"(gf_low), "v"(wq0));
          |                             ^~~~~~~~
    make: *** [Makefile:58: vpermxor1.o] Error 1

So, include the header `asm/ppc-opcode.h` defining this macro also when
not building the Linux kernel but only this too.

Cc: Matt Brown <matthew.brown.dev@gmail.com>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Resend

 lib/raid6/vpermxor.uc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/raid6/vpermxor.uc b/lib/raid6/vpermxor.uc
index 10475dc423c1..1bfb127fbfe8 100644
--- a/lib/raid6/vpermxor.uc
+++ b/lib/raid6/vpermxor.uc
@@ -24,9 +24,9 @@
 #ifdef CONFIG_ALTIVEC
 
 #include <altivec.h>
+#include <asm/ppc-opcode.h>
 #ifdef __KERNEL__
 #include <asm/cputable.h>
-#include <asm/ppc-opcode.h>
 #include <asm/switch_to.h>
 #endif
 
-- 
2.34.1

