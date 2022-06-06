Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60D253E888
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbiFFOoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbiFFOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5D5007C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so12731150pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QPVmCWUy/pAelwn42xkgA5+/zRNQTu28RGMt2EDlrN0=;
        b=EzHN8U2F/StCuXhufFA3sJ4pReqdTjATzKpSNQpYATgle7+Xx5SwhvaduKMju9mWbW
         Q2rrzMoiOmo5KAkaW9v2Ci3cFVvNopWOcGj1FSWcw3prj7l9T5cD3y7uoFAdIRlBJhFZ
         hB3Tjj6Xgo9KDIRlYoW5torY4HWJLyeOVpmm7U89YGMleBnndBjZ9bZwpPGbF6N7MMhX
         fqkOpA7bJfIpHitAcQ6cQbGpSgddMTjJCeUgr61gipobhiH4d7gMlJMYfDi/PhDv1VYY
         GQ769Wj5w1zo5sMC5xqy/sIrFyLGIoTXAYvf+nt+Il+uS0frxrJJhv4hMaBzjZrTQFbK
         GoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QPVmCWUy/pAelwn42xkgA5+/zRNQTu28RGMt2EDlrN0=;
        b=JpFm9Yxrg8eBvkAyD2nZfXkTkjR0gwUKkLufs9/7GzFqkaq2e3J7cIMgQoAoF+JWJ5
         OKxlAPEe02vT/om5SOgeAhmnnN54iQUKdQ1iXqHkOyEXwE0slKPYnHf49Gf//W5S/SRE
         qyBOXo2nxbBgKGQ/sfRUHN//qsbz7CIiIibOpgawgiLQFWH2n/Ug5DiR5PNdv97LvY8+
         cJgtsJ11xIPe8xqyJAg+dpNhqSa22YYdVSQ+qh/Fnt0Y4UJ8hul17Yu7NFVfxI4Ql4D8
         os4TgYahyzl27kKgeLSjuR8eCP2sIJkeuJWRAC6GV2/f5j+thTnDBZ+TGCH9s+jJF8dT
         nBuw==
X-Gm-Message-State: AOAM5330/kiaX/wPBXKT4lTXjM6WCbIj3RWrPZNOrIjx4h56uFVG0iVJ
        ynMYkdevFM+543kUq4h9HO/jMBbr/UU=
X-Google-Smtp-Source: ABdhPJxqzFYGQCX5s0AGPOo9uaQDZnY9Ixd1ApPz41KU0QnpUFmS5yShfSvUde4QtlcWBdxbi9a+sg==
X-Received: by 2002:a17:90b:947:b0:1e8:9bd0:5420 with SMTP id dw7-20020a17090b094700b001e89bd05420mr217080pjb.32.1654526678292;
        Mon, 06 Jun 2022 07:44:38 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id iy9-20020a170903130900b0015e8d4eb243sm7228775plb.141.2022.06.06.07.44.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:37 -0700 (PDT)
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
Subject: [PATCH V3 3/7] x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
Date:   Mon,  6 Jun 2022 22:45:05 +0800
Message-Id: <20220606144509.617611-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220606144509.617611-1-jiangshanlai@gmail.com>
References: <20220606144509.617611-1-jiangshanlai@gmail.com>
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

