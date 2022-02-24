Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFC4C23A8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiBXFkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiBXFkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:40:41 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC5254560
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:40:13 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h125so869425pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUrjnSR2O207wl/KgPF4WFxzn/5+qyXjBbdrgpn74ec=;
        b=Zcva9b79EO27FMwaZqhkQmi2C3qXN1cjHhc6RAFneX/fNCPfxov3sHq6b7HNY1rauX
         6dLQXz99cSK5012k50Rn4vOaEFKP1Zw9ZynrshJkBNT2ZZiKVundssVvLLFocPhqce9p
         gys42g6Uz9gOskZuIs896Iv1zCZThSQLt7d0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUrjnSR2O207wl/KgPF4WFxzn/5+qyXjBbdrgpn74ec=;
        b=BXJjuVvE5r480768HJ8IasYsjbpZtuzeq/gKPrUYfH8ZDZMUX7oNarTz47zsN06oZz
         TsmGa86e30pwY+vowArkMFePKqONSFMxDyljpfDNWTNB5+1+rX3THL6BRbDgHMUSf8VX
         ixFoVxPq11yE9ZrP9M1yjYR/Me7VHvuzGLVGuTGcXPmf3UvRxgAaHSCoJ9UhwbVA4B8F
         iLD52o6/bUawug+wooBKwnfZ6U2W+mm2nf9NJXrys6aECovVACmj/NLPRXB5SoMsmKak
         UqrFN3X/F0GBzvNv25uxjPITPHDEGO5PPmEXJrtVmfzJvH/HXmmNlm0XjB7quondzSHZ
         eASg==
X-Gm-Message-State: AOAM5303KJ2crw50cr0Px8Pyj7H4dAQ5zQu/3zkFm4Z1f7G36bXvCXcb
        FxGwtyjxBsDyOVrm4/PhlZTqZw==
X-Google-Smtp-Source: ABdhPJyJTZwbrBYIgzpKU3TSYvloJombRvUFLeu3xy1uW0E6d/GTsYL7IVSSKPu2DJeUDlfClhY1Lw==
X-Received: by 2002:a05:6a00:148f:b0:4bc:fb2d:4b6f with SMTP id v15-20020a056a00148f00b004bcfb2d4b6fmr1213264pfu.62.1645681212842;
        Wed, 23 Feb 2022 21:40:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm1448848pfu.79.2022.02.23.21.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:40:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ELF: Properly redefine PT_GNU_* in terms of PT_LOOS
Date:   Wed, 23 Feb 2022 21:40:11 -0800
Message-Id: <20220224054011.1852264-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; h=from:subject; bh=YPig1YOT1VAMyQwHwKMHLoGk8gDQ7+8i5Oupd/upzAI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFxo6UL94HlohdKVbWsom4kOiCRaxulVCwE/ewmxB IK6bY2+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcaOgAKCRCJcvTf3G3AJuw5EA CHaz3ExoZEfKFLE5GrkSqVhaiRerpzFFMZsQCgfdu/v5FyREohk7aJLs6wlN2QTfF4KJSgyWPHjZTE ypwcVnsGs19FUCVge376LOqDNQ/oaCdPIgOzcEnIT8dGvMtJjCljG1MTs6cbA/EvYeQjIN0xOB1obx aSiHROgTHk/M0ICsMsDQ1iCAEWzZIQ3pPHwqQBPKQUHKoTDWiCq6uIgjUzWbiedr4f39NHEQnohiVi Ec4K3KIdKDLMiVHeTlTmBzf+TlciIJjKeDwlpiItZJR6ycacCU0AaYO+slSe1j7ui1fdmOASjEXh7a GbjxKvXwRX2mBv1rgAvRnMoEQHq6xyIOPWo/19NG0YCymkRdfBCKJvpYaGPibsHZiQjY9siVRDRtuP kGNNRLoBrrnVcl2Y7pwt1zBbTYRjFNzbFUNJHnptJjHoUBmsgBmnXnR7gyYGtqpJ/ho8GPBTryAIrw EmsYyEAlfFjinmAidjZnsAaCIFzFOq12AJb/kwya8XbeVkcphs1rCZ9svlXnA9RRHs7Bspoi6tv+4+ 9LI7OE0HSqjWlTXrxA8r226/3HpMmhRNbn8LV+AWtqHU8TXajNJ8CeHL/0AkVsYF2jmG5NPsJIMPBu +S/pg8iXlt6zhnUPhwXyO/hI7Z1vGoXz5KY5k51PAHkPsnoDjr5Sf4rBmTwA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PT_GNU_* program header types are actually offsets from PT_LOOS,
so redefine them as such, reorder them, and add the missing PT_GNU_RELRO.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/elf.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..6438d55529bf 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -35,10 +35,11 @@ typedef __s64	Elf64_Sxword;
 #define PT_HIOS    0x6fffffff      /* OS-specific */
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
-#define PT_GNU_EH_FRAME		0x6474e550
-#define PT_GNU_PROPERTY		0x6474e553
-
+#define PT_GNU_EH_FRAME	(PT_LOOS + 0x474e550)
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
+#define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
+#define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
+
 
 /*
  * Extended Numbering
-- 
2.30.2

