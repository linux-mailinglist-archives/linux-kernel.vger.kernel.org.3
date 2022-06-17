Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B6254F935
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382645AbiFQOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiFQOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:32:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45779BCBC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:32:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id a17so2068613pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=+N/16cyFHOuLupQ+Fk4F91U88SFBJPVf6lD4I/mDTOc=;
        b=V5KGDpPpLv4gKA2kex+nq5K86WkTiTIUPC09l4jO/cjP1ray0Y9Tr7B2ih/Eu/jpl2
         LKuWx2XSlpztoIENI4/C9THP2gsEW8QKc3JDClcSL/kL4btjUNvOJBL9iAzeWXthdNLH
         cDDhrJUtqfywTBaes+SYgeEm8et/TBg6dn1IccAZamdHRbyf4EnaChpBhwd3cBYR/uCm
         dR0Mxuw7PIDS6k67D2uB0ScaaeDaZbRLh4a/CyRUvWy7TFCQLfUJrop1w9uI4H7/SMqR
         /my/yQqVMu8QP2BWtGPmbAYUZIXyikuU3+Wi4Pr8too0nEhEWfoMlEH9Xhnu4QFzDXib
         alrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+N/16cyFHOuLupQ+Fk4F91U88SFBJPVf6lD4I/mDTOc=;
        b=RZuX4aKKGdlGeMiMfOaGU4zQnK71PDasMTjM63K+4MqTmFpWjMeeebLwVSGGUcvg6W
         NCKtq7V1OlK8sB0x175DTnQdjPtAZRCR+599cZMpw8v+Wln9s+ksQTojUlrfGDT3G89E
         b5XR9L5nRaMRwL6tbfU7UGO/j+u/6Q/op3oSYj2xmfL/Tu7upKfM01Uq40RIQ+lzKMD2
         t3Xl+oMiseXt0d5pXBpF+wp0I8M+bb+IaQrUT/a0Hn00D0mAYMLxiy2OdN2RibPkChqU
         yVCkGTgQa6lvfbfVXImAsjh3Rv+j/ZTBBcDqTr8566i668yoQ+4kcYFV2bIQM8R3tUgL
         UppQ==
X-Gm-Message-State: AJIora8SGNGTuEUljH6DlyzDpvjIGcWnmjS5Oz/kS5oWZJusLwC7oFYq
        Z5JXOAGFW5SbNVYzXno38BE=
X-Google-Smtp-Source: AGRyM1v6ZTA/PMfzY6SMN9+Ni8TVJCGyDlXFym+hzhe+n0abVIxkiAK6AA6TlqrqwQX+SuKqMSuWng==
X-Received: by 2002:a17:902:d502:b0:168:faa0:50a0 with SMTP id b2-20020a170902d50200b00168faa050a0mr9964651plg.142.1655476374750;
        Fri, 17 Jun 2022 07:32:54 -0700 (PDT)
Received: from localhost.localdomain ([223.104.160.3])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b00163de9e9342sm3684354plk.17.2022.06.17.07.32.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 07:32:54 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     mhiramat@kernel.org
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        l3b2w1 <l3b2w1@gmail.com>
Subject: [PATCH] kprobes: check the prameter offset in _kprobe_addr()
Date:   Fri, 17 Jun 2022 22:32:45 +0800
Message-Id: <1655476365-21662-1-git-send-email-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: l3b2w1 <l3b2w1@gmail.com>

I encounter a problem when using kprobe.
There is no checkping about the parameter offset in _kprobe_address().

a. execute command with a valid address, it succeed.
echo 'p:km __kmalloc+4099' > kprobe_events
In reality, __kmalloc+4099 points to free_debug_processing+579.

so we end up with:
p:kprobes/kp __kmalloc+4099

b. execute command with an invalid address,
   failing because of addr crossing instruction boundary
echo 'p:km __kmalloc+4096' > kprobe_events
In reality, __kmalloc+4096 points to free_debug_processing+576.

Thus, if not checkping the offset, it could point to anywhere,
may succeed with a valid addr, or fail with an invalid addr.
that's not what we want already.

When registering a kprobe to debug something,
either supplied with a symbol name through the sysfs trace
interface,
or programming kp.addr with a specific value in a module,
that means the target function to be probed by us is determined.

With or whitout an offset(0 or !0),
it should be limited to be whithin the function body.
to avoid ending up with a different and unknown function.

Maybe it's better to check it.

Thank you to review this!

Signed-off-by: l3b2w1 <l3b2w1@gmail.com>
---
 kernel/kprobes.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c..d5b907a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1449,6 +1449,9 @@ static kprobe_opcode_t *
 _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 	     unsigned long offset, bool *on_func_entry)
 {
+	unsigned long addr_offset;
+	unsigned long symbol_size;
+
 	if ((symbol_name && addr) || (!symbol_name && !addr))
 		goto invalid;
 
@@ -1465,14 +1468,20 @@ _kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
 			return ERR_PTR(-ENOENT);
 	}
 
+	if (!kallsyms_lookup_size_offset((unsigned long)addr,
+				&symbol_size, &addr_offset))
+		return ERR_PTR(-ENOENT);
+
+	/* Guarantee probed addr do not step over more than one function */
+	if (offset >= symbol_size || offset >= symbol_size - addr_offset)
+		goto invalid;
+
 	/*
-	 * So here we have @addr + @offset, displace it into a new
-	 * @addr' + @offset' where @addr' is the symbol start address.
+	 * @addr is the symbol start address
+	 * @offset is the real 'offset' relative to start address
 	 */
-	addr = (void *)addr + offset;
-	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
-		return ERR_PTR(-ENOENT);
-	addr = (void *)addr - offset;
+	addr -= addr_offset;
+	offset += addr_offset;
 
 	/*
 	 * Then ask the architecture to re-combine them, taking care of
-- 
2.7.4

