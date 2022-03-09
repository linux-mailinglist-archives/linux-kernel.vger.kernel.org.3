Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EE64D2A11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiCIH5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiCIH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4D5164D3B;
        Tue,  8 Mar 2022 23:55:06 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3jHw3JlK4DApFQG0xdprwUvN0McML7ZqT6xOtE2CuE=;
        b=Zrcy7F2E8WYWXihqqh05iak2CEUT2FvDx2h+8psNwnOleb0qxh9tnvy4wTnZWInCWP6z2x
        bz5GUa9Sj5z1LvbwbQf7Ykbjx9+O0pZazCdjhR5a///z8UE3OrGTy/Lq7tIICymkEtVmbq
        i396ctl3RuX71CPFddSrydLG81wRCteKG/NDn1xZbDk187Jiu9HcaeqIMxgOxKsZdlcYyH
        FT1SOlYJnryd3WXvRRSJEqfKh/rBMYg33Cjr9MlVmR1OT5wyuc1k4QBdUdR9jvF4NwlygB
        kzX9OFec2GWHrJtmkvlZCMh5rFJDEXFa9sZk2lJdcSNROsxsdtyHtuHZTXJeFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812505;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3jHw3JlK4DApFQG0xdprwUvN0McML7ZqT6xOtE2CuE=;
        b=nwfsVA9W8yQcgYvRlP2dbX94yx/7yiVtaw+S8OeWECjr7kbHNWMPitHLD+mTzQ067VFUwe
        rRvUnJ1Lij+135Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,crypto: Add ENDBR for the jump-table entries
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.110500806@infradead.org>
References: <20220308154318.110500806@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250431.16921.1083016919469715985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     db76667e784428a927cc86b5a6d0cbade416c9e8
Gitweb:        https://git.kernel.org/tip/db76667e784428a927cc86b5a6d0cbade416c9e8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:31 +01:00

x86/ibt,crypto: Add ENDBR for the jump-table entries

The code does:

	## branch into array
	mov     jump_table(,%rax,8), %bufp
	JMP_NOSPEC bufp

resulting in needing to mark the jump-table entries with ENDBR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.110500806@infradead.org
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 80c0d22..ec35915 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -195,6 +195,7 @@ crc_array:
 .altmacro
 LABEL crc_ %i
 .noaltmacro
+	ENDBR
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
 	crc32q   -i*8(block_2), crc2
@@ -204,6 +205,7 @@ LABEL crc_ %i
 .altmacro
 LABEL crc_ %i
 .noaltmacro
+	ENDBR
 	crc32q   -i*8(block_0), crc_init
 	crc32q   -i*8(block_1), crc1
 # SKIP  crc32  -i*8(block_2), crc2 ; Don't do this one yet
@@ -237,6 +239,7 @@ LABEL crc_ %i
 	################################################################
 
 LABEL crc_ 0
+	ENDBR
 	mov     tmp, len
 	cmp     $128*24, tmp
 	jae     full_block
