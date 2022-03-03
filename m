Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1761C4CB591
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiCCDzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCCDzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:55:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C484145626
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:54:19 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o23so3402799pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=484aUuxNZc3KsETq0d0X9kiFjP9VE9iZOfI8FszPlhE=;
        b=eqfYaYtiJAfrMrJum4SkBgX812U6U5MPYDU9P1w7mfqX3sqhPYqFlZIJCrv91imDGz
         2nT2SGfJQUdyE+MEMQBOmqiNiBgihOHyx2+JdHh+3HiwA1Yxei9cXwN1lIvyDGo7ylxK
         PPMRodzVSxZOiHZgLCyj7NYMsT+wUQt7M3xvtLLHvYkcZQem3zTTvNWJwNVD8aa+cCA2
         dBNTyrMV09l5sYU4gOBaOjPL+shG1Sms5Zyb59iVgWnfpf3PmsC1eSUmNPAYGB/v9GzL
         8D5QlQGdJasLdLVtOyx36j9Tvs9QmcrEzIiwSzgK1jrvCBrDFzzdZBjtFzT4xHvdaJRR
         U7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=484aUuxNZc3KsETq0d0X9kiFjP9VE9iZOfI8FszPlhE=;
        b=XclY6DAEQFxVk0vXsoZUGezg58SlfImuZpVmfjuhNZXcOcyr7vPCMh9AvjGn1YZ6RQ
         SCDKJ1ptg4j4QEjOyCXxvEZi5vNmbNhBblI/8kAKK88dNPOw91uKT642It1QVy9+glMF
         bjYuhBrKy92c1ABxVxY1LUujCEBBTky9uSSU5sZO/GguV2vLiyD8N7wKqeWdDJoFcdv3
         bIKn08d+8tjjf1D3GbW0wj3ZjY2sPnJcEDaXna+aJKSBesjpog1FM9u0TBALicOdNxCK
         uJ7TvRayjv7OjbuNQHT0kV39a43zo03lj8vVjU+oWSsnbqSQEBL01EEb1Pjwev4S3cu+
         srug==
X-Gm-Message-State: AOAM533JTJh5GOVCzM1TcFUTczeKwRiaLPGCE3Ionh4CTo/WIN/x6LHp
        0gETXTOW1SbleX64mZ+zfZe/zGnW2Dk=
X-Google-Smtp-Source: ABdhPJwqGNnwLeK/h1YzAuB+fUY8G1SroSa6VKnTnnZks/0u+o2UKlaU8+LDpauD/nfI/8YCGiu9Wg==
X-Received: by 2002:a63:a66:0:b0:373:c36b:e500 with SMTP id z38-20020a630a66000000b00373c36be500mr28700968pgk.419.1646279658821;
        Wed, 02 Mar 2022 19:54:18 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a0018aa00b004e1bf2a3376sm676209pfh.215.2022.03.02.19.54.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:54:18 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 3/7] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Thu,  3 Mar 2022 11:54:30 +0800
Message-Id: <20220303035434.20471-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220303035434.20471-1-jiangshanlai@gmail.com>
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
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
functionality.  It will enlarge the size:

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
index a51cad2b7fff..3ca64bad4697 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -322,6 +322,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
 	ENCODE_FRAME_POINTER
@@ -968,8 +971,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

