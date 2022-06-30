Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B6561223
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 07:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiF3F64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 01:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiF3F6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 01:58:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ACA2FFCB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 22:58:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a4so18283780lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 22:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=ruV4lyXjfC61DA5wyReXMzsX0cqvp2zK/U29Xvr5SFM=;
        b=l7nN17DBcsYdsVthyTe/GatE3JPafzHfBZ2cn9zPJgX+Zj0rczBbbwaKNFmcXs6IJa
         u73Ux9BKCuIkmWg85+KngOck8gzGG8qyfJmGBLqCuUXNe8YGOq1GTjrbTfbXMCkdtUKd
         CJ1Qvo0me4QK/vgoRsFTihIQ8sEVMfZDm4LLavWUeLK6ebCoZ+ZJ8N02oQiJBU4fnhBP
         N6Ul/zmhja8DNAAVYH62IfwmWUUyNhpvUceFXy/xswWCf1H8jCny5kKRCaAO+bqcz0Vq
         Kv91qfaoAty+KqYpt8ayjauiNtv6LJgr7YB6rF840s13XJjZ4TRQAD+WxkSLeiSOfJXm
         /kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=ruV4lyXjfC61DA5wyReXMzsX0cqvp2zK/U29Xvr5SFM=;
        b=8HWHwtFa4xvbYKwrV7C3WXRr2YqB6Rh5r0tM7nXdAtDIX/Rcrym/S/t2sTRNqXWivB
         E7OKfbX2AXk1pEj6Qc7fF5zblUnZsxzNVK6XQAz3wIMukeSzSF6dFiLoCYhU4hvHTf3n
         Gesto8VnkLVL4DVq2g5ostDYLfCCXtyWyq7wMTFA07cOKkQDN3ud2cGC7xJw0ILpr5Uf
         VrlLU3D9GyZr0uMtALuTlct5S32fgVHUpflE0ZJ4epmUENIXY0XDTAsizWMew7MdoEVw
         P6o3645BA7GEL8tzBka2Owm94mjvCnaPt+JzGu/aie5kFOkmk1OPAVg3yXtR2NaB3vU+
         Xo+g==
X-Gm-Message-State: AJIora9DzLA95xZ7x4XkoxFyXIuwPe1v/VQtb0V/7SPek+RGmoF/UFJW
        l3GBDnFyw3UDAbQACe9pfRybDg==
X-Google-Smtp-Source: AGRyM1s7D4i5hXZ0Wigjd2+D+zGWVxq+5MhO57oXXY3Yw8RAzPusiAUYoDzHGYkVuiTfAcNpXKv8gA==
X-Received: by 2002:a05:6512:208c:b0:47f:9ed1:e8e1 with SMTP id t12-20020a056512208c00b0047f9ed1e8e1mr4637273lfr.377.1656568718457;
        Wed, 29 Jun 2022 22:58:38 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s13-20020a05651c200d00b0025a928f3d63sm2390485ljo.61.2022.06.29.22.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 22:58:38 -0700 (PDT)
Message-ID: <85bd8614-9a55-3113-e5a8-b7e73f636135@openvz.org>
Date:   Thu, 30 Jun 2022 08:58:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] x86/fault: ignore RSVD flag in error code if P flag is 0
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com
References: <9bc8de5f-fd80-57fe-0169-0ec942638299@openvz.org>
Content-Language: en-US
In-Reply-To: <9bc8de5f-fd80-57fe-0169-0ec942638299@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some older Intel CPUs have errata:
"Not-Present Page Faults May Set the RSVD Flag in the Error Code

Problem:
An attempt to access a page that is not marked present causes a page
fault. Such a page fault delivers an error code in which both the
P flag (bit 0) and the RSVD flag (bit 3) are 0. Due to this erratum,
not-present page faults may deliver an error code in which the P flag
is 0 but the RSVD flag is 1.

Implication:
Software may erroneously infer that a page fault was due to a
reserved-bit violation when it was actually due to an attempt
to access a not-present page.

Workaround: Page-fault handlers should ignore the RSVD flag in the error
code if the P flag is 0."

This issues was observed on several nodes crashed with messages
httpd: Corrupted page table at address 7f62d5b48e68
PGD 80000002e92bf067 PUD 1c99c5067 PMD 195015067 PTE 7fffffffb78b680
Bad pagetable: 000c [#1] SMP

Let's follow the recommendation and will ignore the RSVD flag in the
error code if the P flag is 0

Link: https://lore.kernel.org/all/aae9c7c6-989c-0261-470a-252537493b53@openvz.org
Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 arch/x86/mm/fault.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fe10c6d76bac..ffc6d6bd2a22 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1481,6 +1481,15 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (unlikely(kmmio_fault(regs, address)))
 		return;
 
+	/*
+	 * Some older Intel CPUs have errata
+	 * "Not-Present Page Faults May Set the RSVD Flag in the Error Code"
+	 * It is recommended to ignore the RSVD flag (bit 3) in the error code
+	 * if the P flag (bit 0) is 0.
+	 */
+	if (unlikely((error_code & X86_PF_RSVD) && !(error_code & X86_PF_PROT)))
+		error_code &= ~X86_PF_RSVD;
+
 	/* Was the fault on kernel-controlled part of the address space? */
 	if (unlikely(fault_in_kernel_space(address))) {
 		do_kern_addr_fault(regs, error_code, address);
-- 
2.36.1

