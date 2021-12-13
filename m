Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBD2473009
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbhLMPDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbhLMPDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:03:51 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C852FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:50 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so12677390pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BkdyDQTjWosKw+1xPyRZoTKTkBOFYLk8sapbciwUhgI=;
        b=P/Yxt2RDQWaMYdmZAzRzJZEMt9V8+9Ioh5dKnm3AbOfoKV8FEyJrzGaeY/9z8mjKld
         GUgx+NKIBeiyH7RABn8ASZO17PT+E+N6mCqT985j81RDjF5dYNlblggWnElPlZfhOiYB
         5F2EK7yq8p+Xfec59EsNr7Ba51UxzEydf3tc1ZYv764ZDds8QkAuXpYstbUoMYim1Cu6
         4YUp66qKKGTW44bbxo7uj+swgIcyfYulBNBlK3OtNoEW/1rl+/40aJm4z1vLNTqws7XK
         ywGTHqUfK8xcdkVvvhn4M4XNHS/dp51O//tuGPFVAppR9G7A3vv3uVsl47urvJi/w0+S
         hjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkdyDQTjWosKw+1xPyRZoTKTkBOFYLk8sapbciwUhgI=;
        b=ij2RnbHJLiAvPEi6eyHW8CqFlmkylvPFRoJV6XTPSQvtsmq95TEDC3lAoPVIN+n3AR
         63vzpEKzmTOVSNoaNEUveGAUFZ78463USe2CbLHAxqh7N9uWr7+BDXlZIO2Y+D+J8i2h
         1QejOHs2v/BZFMrBHy2PbHmqcAd/N14ZgbRRA7Xw1ZJRzyoGVg//sA0ED9U9qbkIsyiN
         UKhH4yMoZZYsDA3Zj8PuArttb15ysSBmAaX7e4p5zAhuXAay0HVJ6JfCCfGTyGdkSVCC
         XGkxfz2Z6xfntLYt/9vcaqW7XnYvlH3MXAD4qX80qd+CWLmkTecRWiBbHCFdlwsdHXi4
         nYpA==
X-Gm-Message-State: AOAM532EfWTn8Dy7+eXO6h8K6CaDsPGCS3h7kByqR9Qi64hbgnKeqeKI
        9OqQbsNoMLV+UtJyEwRtmRrunRSiIhj2eg==
X-Google-Smtp-Source: ABdhPJzrV+cdK1bzqHdKOrlNZPbGWX6oS4Pn3Et6TNK46Mvw5uZMIppGpN5jwg9gjogpKxSbCGKjgg==
X-Received: by 2002:a17:902:ea10:b0:142:112d:c0b9 with SMTP id s16-20020a170902ea1000b00142112dc0b9mr95662203plg.35.1639407830182;
        Mon, 13 Dec 2021 07:03:50 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id v10sm12751834pfg.162.2021.12.13.07.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:03:49 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH 3/4] x86/nmi: Use DEFINE_IDTENTRY_NMI for NMI handler
Date:   Mon, 13 Dec 2021 23:03:39 +0800
Message-Id: <20211213150340.9419-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211213150340.9419-1-jiangshanlai@gmail.com>
References: <20211213150340.9419-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

DEFINE_IDTENTRY_NMI is introduced for nmi handler.  It is better to use it
which makes it clear that NMI is special handled.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bce802d25fb..44c3adb68282 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -473,7 +473,7 @@ static DEFINE_PER_CPU(enum nmi_states, nmi_state);
 static DEFINE_PER_CPU(unsigned long, nmi_cr2);
 static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
-DEFINE_IDTENTRY_RAW(exc_nmi)
+DEFINE_IDTENTRY_NMI(exc_nmi)
 {
 	irqentry_state_t irq_state;
 
-- 
2.19.1.6.gb485710b

