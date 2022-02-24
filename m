Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339494C3178
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiBXQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBXQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:33:18 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B861FE576
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:32:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id f37so4803946lfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zm6gpRYr4dD9b0AAx6gTTzvG8t4EB7U1VrZe7XoIHoo=;
        b=Vr8lT5GTXULpvaAj6TBJpBaLjzUAb1oKHJIgtNBeOdNtV1IJ9MIqVqCvGJnDsX8WT4
         szJ1QHdTeG3k90CYV1dXqqRtcPa94g/9KqT6oTotXzkORo8jHrIyOF02Ult+RLNWJnTa
         lXREQRV8KsewIXf/2/9+mwyxeEuzbfxrYfBUGvXcnHLBJUNGCToLH72Qs3e2QVtf74IS
         GerXzIdJ0lVlmwHZygEcXNV/RSai4fiIoo4Jh5Z4Pr8FZHpsm5UePyf7+FDTT0GxWuKW
         CU4QZCIrCiz7+/nreiUp9hk0Wt1pq41EnIQu0hkTdCUgEW+9QulWxlwlUIwm3JRJut2l
         583A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zm6gpRYr4dD9b0AAx6gTTzvG8t4EB7U1VrZe7XoIHoo=;
        b=okWHA/ReBu49FxVKuHGk+o5SYCcXBcvfx600761VTyuNWGDtp+P6l7L/UjbmUIqSb5
         fL5g3eCuQd8oBJTtIWlMUvbIXMvM0IvVl5l5QvhCp4Ve3PusMiYvXWc9IO5X5s0oZHBx
         kjBPSN8Hk7kK/t//GhwatdwZetlDOBDjIjsFzDl3M0Hbe0LdCfmI1ogKLeQiuby5T7he
         fK/PhEZrHLuAHtaAyE8QtSICBH3cUASfJjVOT2kz/bivwdld5QRuTdhdvUy0WxdRvvwa
         Z6aYV3UunPK8/bHZVoxG16WRnkI1tJ6yn+ig5oRYEZKvHlYn9HtxsL1FLYCsOw5AbyWl
         AuhA==
X-Gm-Message-State: AOAM532O7nsp67oTiVEqzCFTPiZcxZWq4xuJuWBpNyBiG21vv/FCT9UL
        FV+4IkftYc/5LCNwTRpqD3mBvLiSmSFmmA==
X-Google-Smtp-Source: ABdhPJwaoUI9TOQkchwsQbX3+Ug1W4r+DZp5/dG/LnVIgISWE3rcPKdluOkNX3A8dhCkk+X97gQpOw==
X-Received: by 2002:a05:6512:1111:b0:439:6328:c168 with SMTP id l17-20020a056512111100b004396328c168mr2234764lfg.650.1645719758894;
        Thu, 24 Feb 2022 08:22:38 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id e16sm243684lfs.67.2022.02.24.08.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:22:38 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCHv2 3/3] powerpc: lib: sstep: fix build errors
Date:   Thu, 24 Feb 2022 17:22:15 +0100
Message-Id: <20220224162215.3406642-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224162215.3406642-1-anders.roxell@linaro.org>
References: <20220224162215.3406642-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building tinyconfig with gcc (Debian 11.2.0-16) and assembler (Debian
2.37.90.20220207) the following build error shows up:

{standard input}: Assembler messages:
{standard input}:10576: Error: unrecognized opcode: `stbcx.'
{standard input}:10680: Error: unrecognized opcode: `lharx'
{standard input}:10694: Error: unrecognized opcode: `lbarx'

Rework to add assembler directives [1] around the instruction.  The
problem with this might be that we can trick a power6 into
single-stepping through an stbcx. for instance, and it will execute that
in kernel mode.

[1] https://sourceware.org/binutils/docs/as/PowerPC_002dPseudo.html#PowerPC_002dPseudo

Cc: <stable@vger.kernel.org>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/powerpc/lib/sstep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index d2d29243fa6d..f3ed80513a90 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1097,7 +1097,10 @@ NOKPROBE_SYMBOL(emulate_dcbz);
 
 #define __put_user_asmx(x, addr, err, op, cr)		\
 	__asm__ __volatile__(				\
+		".machine push\n"			\
+		".machine power8\n"			\
 		"1:	" op " %2,0,%3\n"		\
+		".machine pop\n"			\
 		"	mfcr	%1\n"			\
 		"2:\n"					\
 		".section .fixup,\"ax\"\n"		\
@@ -1110,7 +1113,10 @@ NOKPROBE_SYMBOL(emulate_dcbz);
 
 #define __get_user_asmx(x, addr, err, op)		\
 	__asm__ __volatile__(				\
+		".machine push\n"			\
+		".machine power8\n"			\
 		"1:	"op" %1,0,%2\n"			\
+		".machine pop\n"			\
 		"2:\n"					\
 		".section .fixup,\"ax\"\n"		\
 		"3:	li	%0,%3\n"		\
-- 
2.34.1

