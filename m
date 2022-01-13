Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F15948DA30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiAMOzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:55:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36154 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbiAMOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:55:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47DEEB822C5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246B3C36AEB;
        Thu, 13 Jan 2022 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642085740;
        bh=nhGgQpHuVYTJnnvXSGHNQdeZfoMwRaxVMjpD7fGDKgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJtTnLl7rH0VTmBGJMpYfLHcAqaDFa3Z7qrZ+nxXaY2gxuMA9e+iUyU/asYbk7x1Q
         ihkQjM9yKw225xthXuBn7G1K0Av0d2vRnfMQcIF3NyVdAocYSPBTWxTcQ6gYOylbFo
         qGqcsOB5qmNAIgu1FdadCCH52nQblKSLFishSYcGwZE7wmZezARLRJ2JQEmk+rIert
         yxvFT4/eXk24JyAmbBtjWPUxInBiv2vHoTlMCMZjHYXJ4Xhrj7IP5mdY/w3uOJ18aC
         TjPGy2yoVAyRyd2U6VLvvOnSHXmuTG5vr/fcZ+Ijw5AW1oiBFrg+VlSXnObA2wrQ9L
         XfUsY4AsrmIvg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianhua Liu <jianhua.ljh@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 1/3] ARM: kprobes: Count MAX_OPTINSN_SIZE in kprobe_opcode_t
Date:   Thu, 13 Jan 2022 23:55:37 +0900
Message-Id: <164208573722.1590449.5826836279460018409.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164208572899.1590449.14007562142219520042.stgit@devnote2>
References: <164208572899.1590449.14007562142219520042.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Count the MAX_OPTINSN_SIZE in 'kprobe_opcode_t' instead
of in byte. On arm, the sizeof(kprobe_opcode_t) is u32,
thus the current code consumes 4 times larger memory for
trampoline buffer.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Reported-by: Jianhua Liu <jianhua.ljh@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
---
 arch/arm/include/asm/kprobes.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index e26a278d301a..092263a89102 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -56,8 +56,7 @@ extern __visible kprobe_opcode_t optprobe_template_restore_end[];
 
 #define MAX_OPTIMIZED_LENGTH	4
 #define MAX_OPTINSN_SIZE				\
-	((unsigned long)optprobe_template_end -	\
-	 (unsigned long)optprobe_template_entry)
+	(unsigned long)(optprobe_template_end - optprobe_template_entry)
 #define RELATIVEJUMP_SIZE	4
 
 struct arch_optimized_insn {

