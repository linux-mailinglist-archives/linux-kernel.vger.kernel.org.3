Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664AF4DDBAE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiCRObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiCRObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:31:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2E5A096
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c2so5169353pga.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GaABf2FhAaYX7fHVjFklFYbgdZLkCz9CVYEgXadTOI=;
        b=UB/s7/kZkVmWLUOGRm7bH6et+9alTXL5loAN6hOCbKJVARGm3Apx6/O4vNJGCCgtt7
         Q/uAPciwpPksxFzEYFjH7yQjxUKwffr0MRcGVrxAminTQXr3gee58Q3cHMNsZTxrpsh+
         RGx56SXFCpuXgvFyWejBs635Q64ZXoSDSTgpNVDrTmueCUHLAREHLuQaB2njgVKMiHM2
         Qj/AfL7pUjQYBifNYVAcoUF9olckXIjwDR4n71Xqip/bflnp4LWieb56AFaqo3lKz/6V
         scCLZjA0+UPC6hhD8qWk/vxQY/lmuZ/jB4PrhF4Zpck6ugMiBuVgRIf1uqtXWz6OyGxa
         3Y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GaABf2FhAaYX7fHVjFklFYbgdZLkCz9CVYEgXadTOI=;
        b=6spxrbFDEatlmLXDzrfLYI30bqH/llOOy5VxYrEpf++aaewr8/R52sCVWhjhqjRvHy
         VVeu1DzpNdM+rIOqVpaJjyXmT8/fFoXtjdby9FtnphciN5kAB+9RpziMubRBC8nU4Hqz
         CrhURMXoUDJVrSBgXc0s0moJsee62USDJXd0OugM4LHP0jZHsShS01Q0hLcdPyHWTfiy
         V+JBmVJJlLW4DJyPqMRPnx93KaAiqLh1eQ8TsIe+VkMdvQ8u5eKI6lKvrLunpyXm5R4B
         ++ACx+xsrWCHgczTJ2lky3FtkTRHZEsKfk49xon2lPheUIvHyV3wafBsCBW9DP6tAIAI
         krZg==
X-Gm-Message-State: AOAM531RqplNnQIZuG+zICIkOH6mmkmJFjti3XMsmBt38yNu7x2FZL3N
        Oif3JEu5NN7De+65EjEgwMuSBaF9CtM=
X-Google-Smtp-Source: ABdhPJze1CY3rPNfpk71PsO2hS+2RSknDLzAuRnkIbiLvvkePvcFOH1dZU9kIMqLsm0x+/pxmDq6Ig==
X-Received: by 2002:a63:4b1e:0:b0:365:8bc:6665 with SMTP id y30-20020a634b1e000000b0036508bc6665mr8194126pga.445.1647613798292;
        Fri, 18 Mar 2022 07:29:58 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id lb1-20020a17090b4a4100b001bfb76e56d1sm12923865pjb.36.2022.03.18.07.29.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:29:57 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 3/7] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Fri, 18 Mar 2022 22:30:12 +0800
Message-Id: <20220318143016.124387-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220318143016.124387-1-jiangshanlai@gmail.com>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
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

Moving PUSH_AND_CLEAR_REGS out of error_entry doesn't change any
functionality.

It makes error_entry() do not fiddle with the stack.

It will enlarge the size:

size arch/x86/entry/entry_64.o.before:
   text	   data	    bss	    dec	    hex	filename
  17916	    384	      0	  18300	   477c	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.before:
.entry.text                      5528      0
.orc_unwind                      6456      0
.orc_unwind_ip                   4304      0

size arch/x86/entry/entry_64.o.after:
   text	   data	    bss	    dec	    hex	filename
  26868	    384	      0	  27252	   6a74	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.after:
.entry.text                      8200      0
.orc_unwind                     10224      0
.orc_unwind_ip                   6816      0

But .entry.text in x86_64 is 2M aligned, enlarging it to 8.2k doesn't
enlarge the final text size.

The tables .orc_unwind[_ip] are enlarged due to it adds many pushes.

It is prepared for not calling error_entry() from XENPV in later patch
and for future converting the whole error_entry into C code.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8eff3e6b1687..666109d56f6b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -325,6 +325,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -987,8 +990,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

