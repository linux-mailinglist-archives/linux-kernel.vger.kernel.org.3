Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE75AA90F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 09:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiIBHrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 03:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiIBHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 03:47:30 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31739A5728
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 00:47:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l5so1248567pjy.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O5drL3tAwNsZuuAws6oA878DUgPxdjCv6y4Z6HAJN3M=;
        b=fKW0bTjhzFkn1V45eoCOxsP+I3Encq3CAoZLyoX9vtjX2mH499OeRTZumtDAgN7z1N
         HaPK4G4jwRyW0/fIHEuwk1sBpvTomwpQ6tSDzcRbqu+bc4i1GnBjfzWN3lrPW519+eg3
         eqUEnHx7R18BlqgwPFdI7QU9fSWmbhzVoANUJpvpUlyuln83vwXk9Ai3uLMEfZe/rQSN
         U2+PpUkAMzQgKAcKnQxkktcKAO94+14oGnP8GCB0j4pqzE3VDnOBX7UvA5NoXJxFDDAq
         pCiz5k1/wRDqaxGHcygDHpmipXcy2ICqDYnLqhW9cm38zPD5QitMxagH0MA7nWT5jPov
         WrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O5drL3tAwNsZuuAws6oA878DUgPxdjCv6y4Z6HAJN3M=;
        b=DUzrAKV0nKju0/AFXlNWPy/azU37DxilaxkCc893h9MA03/STHzlEO40TPuRluUmEe
         eU0AMOdUYpcvvKvi1bYySNB7QsmC/FXwzb5GFBEX3TAnYcvfRDAa/LN2dm1hLuLglM+t
         2HKBaGhvq3vjj5iS0tCVGkKTJ/b+FT5+ubqHSewACyDRlfSMcG/OSBbEcBBunooyuZvL
         OvhC9ocvm3iq+sxCdS42vSBE1T/wlkfh4/ajM2EhjXeOoL/VYUbzKrDFFeK/V24RFmx4
         6jzC/MWfCV+0HHoo8Cxm5WEYTeokxUmQPNAX+4L16CFom4upAAC9fXvQwB1o11tl2YZk
         F71Q==
X-Gm-Message-State: ACgBeo0GoQPFjPqWIphTeH3R5UbOMazWEoLJimzG9JZ/sJC2rRrsNmoW
        m4kvGOSL2Cj8ghjWEzKCI5TBToA9McDLDQ==
X-Google-Smtp-Source: AA6agR7s648bDWnCalW73DXjRaBnJ56sgGVrPDUyZ0yMO2ijyXph3wuS6gIEW6k3MASO44p0na7N7g==
X-Received: by 2002:a17:902:e88d:b0:175:3e0e:168d with SMTP id w13-20020a170902e88d00b001753e0e168dmr12865466plg.160.1662104846716;
        Fri, 02 Sep 2022 00:47:26 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id q3-20020aa78423000000b0052d87b76d12sm964108pfn.68.2022.09.02.00.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 00:47:25 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] arch/x86/kernel: check the return value of insn_decode_kernel()
Date:   Fri,  2 Sep 2022 00:47:06 -0700
Message-Id: <20220902074706.2211252-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

insn_decode() could fail and the insn.length could be invalid. So we
need to check the return value first.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 arch/x86/kernel/jump_label.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f5b8ef02d172..3ecaf0cc71d0 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -20,9 +20,10 @@
 int arch_jump_entry_size(struct jump_entry *entry)
 {
 	struct insn insn = {};
+	int ret;
 
-	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
-	BUG_ON(insn.length != 2 && insn.length != 5);
+	ret = insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
+	BUG_ON(ret < 0 || insn.length != 2 && insn.length != 5);
 
 	return insn.length;
 }
-- 
2.25.1

