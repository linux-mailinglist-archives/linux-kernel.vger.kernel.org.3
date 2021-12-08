Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0206E46D1A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhLHLMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhLHLMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:37 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7F2C061D5E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:09:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so4094359pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qfk8rEd7OE7FkctKlJZZ9kD8w0vOU1vAluUq/sa8Oc=;
        b=l7nygggwydXZUAu4zkqtbtTRWY39vFf8FLQk4PTAPrhXI+tzr6CLSDOcbjAIFholoR
         ZflKnIP1dr60YP3ogLki0mS5fzvW2s2sJ5JJjEOnEcnqaWFXcDIqGKfbpVG5umYF7IuV
         XbGokOAZ7qo1h+G1Bfk0/lmfvpWFvQF3DWBtRJl8/CnxVy53GK6huw6txhzHw8osD5Bs
         OMUKn0L37dEZLYVTT7lapANuDqunPxOpcQlA+VF0ffqg433s/FhOPxw6l+uZTJK2URXY
         u7aPuRJNHxAhjbmWX/mle+316jDesbf0dAlNAH5fyU9efV13TpPnGDNyw76aFmOqi4by
         5IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qfk8rEd7OE7FkctKlJZZ9kD8w0vOU1vAluUq/sa8Oc=;
        b=IcrPkU8DE1IOlaMRLBaJEToZLrVmLR0lifRSkY1nm8wnLcL8p7m4wmZHEzvmXrGrAS
         hO+zjsVyGNVnz5vtgl2as5XFH8ezveqe/h71A7SKtJzNgilSiFEUaPMBpL71dX7X5x3J
         5Dl90Jfmbz4ZYZf+DhEFmaVfo2ATTJcRmalyDPnJIHJ19WQRxBRXWL2rZyUoRNB6kFm8
         54xtyR338nYZ1LGWHODPt0IKBQuuRaoXtm2W3C2tZ9Fyc3dAjjezvfn7IwtgI5offE8t
         htE6wUKGVJlY3DtmG2wQ9zuZjvK0N1xD19rWF8nqgkAxSByK4ADqwWVPSYRPuwaNUfqL
         7SXQ==
X-Gm-Message-State: AOAM531zbkHL5pGqHQgxMh0OD41NWPIoQz3Eun6MjSubu6UZDdh6iwPI
        PH0e/1IT30sbcpr0435180o4nQwzC3E=
X-Google-Smtp-Source: ABdhPJyX9L5YCir717yBDgGNa36Bhmc2dDItA2/uZBarVsl66m2fKt+O9ZG0+5iKAc//bNxdDvNjmA==
X-Received: by 2002:a17:90b:612:: with SMTP id gb18mr6498365pjb.0.1638961744681;
        Wed, 08 Dec 2021 03:09:04 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id b18sm2455866pjo.31.2021.12.08.03.09.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:09:04 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 07/11] x86/entry: Convert SWAPGS to swapgs in error_entry()
Date:   Wed,  8 Dec 2021 19:08:29 +0800
Message-Id: <20211208110833.65366-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV doesn't use error_entry() anymore, so the pv-aware SWAPGS can be
changed to native swapgs.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 383070aa9272..6100007fd03f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -990,7 +990,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1022,7 +1022,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
@@ -1043,7 +1043,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
-- 
2.19.1.6.gb485710b

