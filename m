Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283B456277B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiF3X6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiF3X6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:58:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A8D5C968
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:58:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a39so606579ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=bwl9aYy0/sEYA6zVlqa63I8sJGvbXpz0nWprpUmHCn8=;
        b=0RuKsA1tzfF8paPKbGQBBUxk95W958LHfzeBU2KnhDbhywqVNPHrzdLXYGyOyZQStm
         nApR00nOLhfiv+zNb5NERqesnePI4J1iaoR0OOliWJCLZ+phTXOpZlocf7CW/OR23f8q
         NPDW760dcuaTE4MupAoMTOCM1Zdt2XPj0PrT+QdwCR0dsCUmITHpb8zF2tg4EV0PYjsk
         ZZsgp3+/HkomzNcHHBvHuWJj24FG6wkJhkemQB/ppjTuRRyDlUBisxBa1/tm2qirH4hf
         YnfGBAMCXfZ+z2rTFbAA4xQDfBeiqWJPszzImU+79hkumvGPl7xLy0TRS4QYVV4iTQFl
         CRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=bwl9aYy0/sEYA6zVlqa63I8sJGvbXpz0nWprpUmHCn8=;
        b=Tjzd85/i/uOLfay8a1focSRDcKFlyZENHBPlqF5kEgCHQBxDGpQ3czolvPBhfwFre/
         CEuRMC7EiyZk6RdOiu3RI37eicznypHB3SJaeax67inPNvQUkhHpJY8uYYjpkJFjyWEQ
         bankzRgwAs4Fi7jNpQeTTr/NNx1q8+ReP6w0B4E8O8bVEeG/hMjetpL8xWcZOtPaHf32
         OAQlJpm99SaFzJkiGZGDw5dBKGm9uiHbx88DZ5mJdpJ/OJcpigk3otRrztezHJMfgTBI
         /PeJFJigPfQIbaLyRhypXjzCfj3kDRpDewrtYryk8ycQ2+dRx9yCfnJCIfs6TlwkJ8Nb
         ZNsw==
X-Gm-Message-State: AJIora/5AlsQAJLHRPrMMuSow65pt/3MN4XPnA4Z61ajidbqVXNR4KR8
        KFe4gt8upsQ+Q7IxIS+4mbri9g==
X-Google-Smtp-Source: AGRyM1vTZKmK/iFhoqMLadC9vLAIC7Fwp2vwZn7Tg3D3aAWPdBdfQTBC4tCMCsjF2YHjCC9hsnrpYw==
X-Received: by 2002:a2e:730f:0:b0:25b:e1e6:5fca with SMTP id o15-20020a2e730f000000b0025be1e65fcamr6614505ljc.437.1656633481697;
        Thu, 30 Jun 2022 16:58:01 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id a8-20020a056512200800b0047255d210dcsm3347759lfb.11.2022.06.30.16.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 16:58:01 -0700 (PDT)
Message-ID: <2a18d823-1a60-977d-57e8-3d41bef74c0c@openvz.org>
Date:   Fri, 1 Jul 2022 02:58:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v2] x86/fault: ignore RSVD flag in error code if P flag is 0
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com
References: <3e39adad-3b1d-18c0-29d5-e0268c0fa083@intel.com>
Content-Language: en-US
In-Reply-To: <3e39adad-3b1d-18c0-29d5-e0268c0fa083@intel.com>
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

Several older Intel CPUs have this or a similar erratum.
For instance, the "Intel Xeon Processor 5400 Series
Specification Update" [1] has

"AX74. Not-Present Page Faults May Set the RSVD Flag in the Error Code

Problem:
 An attempt to access a page that is not marked present causes
 a page fault. Such a page fault delivers an error code in which
 both the P flag (bit 0) and the RSVD flag (bit 3) are 0.
 Due to this erratum, not-present page faults may deliver
 an error code in which the P flag is 0 but the RSVD flag is 1.

Implication:
 Software may erroneously infer that a page fault was due to
 a reserved-bit violation when it was actually due to an attempt
 to access a not-present page. Intel has not observed this erratum
 with any commercially available software.

Workaround:
 Page-fault handlers should ignore the RSVD flag in the error
 code if the P flag is 0"

This problem has been observed several times on several nodes using
Intel Xeon E5450 processors. These nodes were crashed after
"Bad pagetable: 000c" messages like this:

Corrupted page table at address 7f62d5b48e68
PGD 80000002e92bf067 PUD 1c99c5067 PMD 195015067 PTE 7fffffffb78b680
Bad pagetable: 000c [#1] SMP

Error code here is 0xc, it have set RSVD flag (bit 3), however P flag
(bit 0) is clear.

Let's follow the recommendations and ignore the RSVD flag in the cases
described.

Link: [1] https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-5400-spec-update.pdf
Link: https://lore.kernel.org/all/aae9c7c6-989c-0261-470a-252537493b53@openvz.org
Reported-by: Steve Sipes <steve.sipes@comandsolutions.com>
Signed-off-by: Vasily Averin <vvs@openvz.org>
---
v2: added original reporter
    improved patch description, added link to CPU spec update
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

