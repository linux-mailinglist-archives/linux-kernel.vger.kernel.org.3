Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F346D19C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhLHLMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhLHLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABE5C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:08:48 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id g16so1795239pgi.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RcBSE4oPibzeIhyf2Qp5YqTgR/bF+VmAeF/brxTC5FU=;
        b=D0KfkWiPHhKhRJUZdR5kq7I4HpNBJdRwa55sv9BMfhZ3vbJVIPNqKGnE1ONGnrlI34
         2uQvzZB8c1W/Hzmk9lJIBvPuBZIZBDzlhZ6uIuU9VZOKqWnOAHB9aMyyXNK8KcmbcQV/
         bQjVtI9HtkySFmOwWp9onHdlvBxih0vvgFOJHMQjs9U8tAoDeS0Tt29U9Ye6sau5kAxz
         J/DeQH5dwbfQl7bRYn+aIrOkMti5RoJtWalneYj8OgUE/4cpA9PctgdhPmFe30GA+AfV
         HgbSnUq6EfLPRCS7X+q0+QvEnT3ZXqXLMRNwgKgKcUcvvo/VDdu5ix0k/Mo8225S/GHA
         bJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RcBSE4oPibzeIhyf2Qp5YqTgR/bF+VmAeF/brxTC5FU=;
        b=5oDK+0WIlByCkmqEGzFYy+aIxoKR7kAD39YQwJcny9W78I5INr6o4DBaRIRXRNtN6D
         paUrAlSTkZT3ewFpXUA8w9BjXLPIe6qU+OGSvu2JyrI3iu1jVRdyGVx3J/0BMBKk/ONj
         k+xOujcOpOlJP1XqNuJV2YmFaESCseZnoqAFKvUFVoU3zyLemc/pNiCuKNVAJ7wuZpgs
         XUfNmnYE+eeT7elTxTa+IhEYoF/aexfPfpfq5AD5hcWstgjNMn2GwtjrLa5gQTMCwcXa
         iNMQ4k5FjxcixNbJTXZsJIA+23BGM5HNZZ6WqQmUNrFa5aup3jeJcdk7CvOafD50WAIN
         9lvg==
X-Gm-Message-State: AOAM533yI9ZQbz+JhN2fKsOb6tlCXwXqd5Wqk0TR0Z06XYg6xe/WAvOi
        indny3XkV70UmUzxSElnO05aYo/3cKs=
X-Google-Smtp-Source: ABdhPJwB9xEYc6yaPMgbaAjXzRhRbjCMiDT7xaBXucJ4jA6rNMMEh2pDhUz6bzCHuWkJVnkpO7Wxhg==
X-Received: by 2002:a05:6a00:1a8e:b0:49f:a4a9:8f1e with SMTP id e14-20020a056a001a8e00b0049fa4a98f1emr4890452pfv.67.1638961727985;
        Wed, 08 Dec 2021 03:08:47 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id p17sm3404857pfh.86.2021.12.08.03.08.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:08:47 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 04/11] x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
Date:   Wed,  8 Dec 2021 19:08:26 +0800
Message-Id: <20211208110833.65366-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

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

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6baa7413f7eb..72ceb4b70822 100644
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
@@ -969,8 +972,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

