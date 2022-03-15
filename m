Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEE4D9578
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbiCOHlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbiCOHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:40:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529A4B851
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h2so14296743pfh.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTZW2d3yB5B8DbC38GNqbyFxqNMHtItePfoOGslF2jk=;
        b=mq+zMg5Y0ewmVVR1gqqxY755c3OnalZcRpjWYTE+TdrrWHYDOR6Elc0Jah1kopG8nv
         AMvvr9MECUGJm4o//KpujMMtL5KjmwuDrXzgZ1bkkrinkwshNDxrTH1Ftyn8FAC8Urgm
         3MutFxWv4ij79GG6UTIuqRz262OENhcgy5wkycNgh3Q+jogCQVeidS3cTnwDAOPCcgA/
         9w2i17sRx5eyukUC8BbsohdPQ4ybovIswXRjyvoBDZv2KdHub2CUqxvRd82Aw4nsRrRB
         veRBYRyQ+5aAvt8sMTLOyQnWszKjdjJlRiRBtJBtfkV1fle/UDEhAKZtd7xdjcWDMxGy
         gnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTZW2d3yB5B8DbC38GNqbyFxqNMHtItePfoOGslF2jk=;
        b=lhSOkHqXl8Ye3BAYYqmYa8FlonMrzsH0XTJUsk3oKhtjMiCjNtKCVxm/YV+PHAaZnC
         VnntDgfWafPXPUdB7hJ6diBPZ/t+NnIOypZg3UCNYaHUbemq/i3qNa7tbJ8jdmai4ohq
         4G95Y7HHuTLFgsiuizfA+Xs2MFs4n2tBlkz1YXTYxMxP+dIPUEpc6MD4mdTPqpXI3KEa
         ZtVDu8qDT6+3PO4Fe57m8RjgBW3PhsIUlO4bqjuSzU8Ci7xSNQibD/Jsno9m8W0dsSJm
         PAlSZ4kI4B2PKF3eylPkXfv4DG2tmFjG5X/GjGvIbxKglyfoUkCvJ0vDFlik2myyo88A
         b5YQ==
X-Gm-Message-State: AOAM533fKjng52DTFa4fBS8RAy+8NJ12R5ow6H6HY1ial+FDfzBx3iin
        kk+HpNeN/jeg+TuCyfQJ3mBU751fZRU=
X-Google-Smtp-Source: ABdhPJzHVTdtdIpMM5t5w4t0iJJrZA9zZRLjh0DhvYt3ZgCmfQmyNakpfba3S8i5UcwrV3U62ZZx5A==
X-Received: by 2002:a05:6a00:22c1:b0:4f7:3e72:d99b with SMTP id f1-20020a056a0022c100b004f73e72d99bmr27663638pfj.79.1647329981058;
        Tue, 15 Mar 2022 00:39:41 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm1795812pjc.56.2022.03.15.00.39.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:39:40 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 4/7] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Tue, 15 Mar 2022 15:39:46 +0800
Message-Id: <20220315073949.7541-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220315073949.7541-1-jiangshanlai@gmail.com>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
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
index 7768cdd0c7ed..903da9119e7a 100644
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
@@ -1002,8 +1005,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

