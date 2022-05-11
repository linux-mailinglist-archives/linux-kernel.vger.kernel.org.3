Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCED522D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbiEKH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiEKH1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:27:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1623DA42
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id bo5so1257067pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPVmCWUy/pAelwn42xkgA5+/zRNQTu28RGMt2EDlrN0=;
        b=PYKMhrwupiX1DKVFHB67nL6xi45Gejxb9M3oWtYgWDpMTbNtlZhy3M9WBRoEc+gFU+
         y9swxYtgp6J09vJYhWRcCAviWIa6waO2YY94BGwT73H0BNP4XDHzroirDB44Fy9c7kXg
         mMXIMrDnYLuq8t2U3f9KuAFPmy7fOA362VFVUk18+JpAna3cjgn3lrrAVH3vvraENPpb
         tr9zIk0WGFBenjThfNM0wy8/ZGmtNVRgTKaaYfVrSjuTI0WD7TMqFFecdA2jVnlF2K7c
         ZdiFVif8AaVTB92CAq46ZTicaV94F5HiwO2W2CJGMXukbWl4hcgOOhDiSqSTaIMcZkt2
         IYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPVmCWUy/pAelwn42xkgA5+/zRNQTu28RGMt2EDlrN0=;
        b=XkuEHWIK1NN6KQXkVp8T5vnuVSZ3Gs/Vtr6zc0OyBe0Bj4U4CUuq+JCQ6Ifn/iDelU
         7F/tLMd41zvr47gYzur25QjD054DuDSKsmLREjI2Nljybw0QHupDq03XhUxGMK2L3iJ0
         /GuJ1VHR506jXSZzGTUKwo5KmHN7d731RMn21r4GFL4YXpWA7b+nh+m2Hku3kUUe97sE
         IbZM00sEFlFbhJ+ZVwmB0rROFlielZywgClDs5M6gLR02eCYdK0FhD5NHnBkj3+nPno7
         o/NlMahfKTn/MKXBa/2wVkiZ3x3EO3XH2+DCmV4+H4nCh29ssaR6oTrIh28d1KRucUqW
         wCqg==
X-Gm-Message-State: AOAM531xs2l4b6LmCgfLqCJIUBjcuKjcI+RGUlK8paouYb+XVKlEQA90
        cQTq4Qcir4VGd/ctRXNsKeSBYuhVmGw=
X-Google-Smtp-Source: ABdhPJzN3XtJyFsowFOS2kEc3mCV/5GAixyocAPpmL7YzPDA3RBzWStn46ECX90OlktJImbSkeEu/g==
X-Received: by 2002:a05:6a00:14ce:b0:50f:ac00:2a8b with SMTP id w14-20020a056a0014ce00b0050fac002a8bmr23519267pfu.36.1652254036178;
        Wed, 11 May 2022 00:27:16 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id s125-20020a637783000000b003c14af5062dsm932739pgc.69.2022.05.11.00.27.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:27:15 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/7] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Wed, 11 May 2022 15:27:43 +0800
Message-Id: <20220511072747.3960-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220511072747.3960-1-jiangshanlai@gmail.com>
References: <20220511072747.3960-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Mark __native_read_cr3() & native_write_cr3() as __always_inline to
ensure they are not instrumentable and in the .entry.text section if
the caller is not instrumentable and in the .entry.text section.

It prepares for __native_read_cr3() and native_write_cr3() to be used
in the C entry code for handling KPTI.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/include/asm/special_insns.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 45b18eb94fa1..dbaee50abb3c 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write_cr2(unsigned long val)
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
-- 
2.19.1.6.gb485710b

