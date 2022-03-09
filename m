Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F048A4D2A28
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiCIH55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiCIH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE4166A5C;
        Tue,  8 Mar 2022 23:55:16 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812514;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsAIAiCvEF9bhk8WUkO5F1Z9BMt82PYR3uNBs/370GA=;
        b=aVHzrXn6RLA7G87j/8PdnN+GyERQqrNM3q0h+gg2dQ0DSVvc6c8tP0kzJp9CsTtPm7sA4T
        UAV56tMa+2HDoogI4LTBkCXKYbbai7gzLgJx0A1YRtldMyaMaJWr+oOob8VPXm0/HMXLRy
        s11pT8zAXzEr2tVq8Blj29gcq6jgZgg/dOxcHCdcNEVjPDhvG48WTLXS61AARLrdQjZ0/b
        jLaRUmyaXpzgD85Vw22umjmTYtGIoUdUJHLvyVz47gdZq/ozMNB88DPAnonK0lM31kQV4N
        s09ttyS5uNH2mumv0JPWrhAHStIp2Jk4/i0XCcBfBIC/N3cR1Q8Fxouzg7XkZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812514;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsAIAiCvEF9bhk8WUkO5F1Z9BMt82PYR3uNBs/370GA=;
        b=bFbRJR0g05b8ewf+e/XsIFkVRwQq3JgW4pXKR2XbJKlZI5HC9hFCHqKj03HRPC3iIrS5im
        bnfGG0PeY585T0Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Have WARN_FUNC fall back to sym+off
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.461283840@infradead.org>
References: <20220308154317.461283840@infradead.org>
MIME-Version: 1.0
Message-ID: <164681251341.16921.1310664348560537528.tip-bot2@tip-bot2>
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

Commit-ID:     03232d0842453f256c278c377f9646e45eb57d98
Gitweb:        https://git.kernel.org/tip/03232d0842453f256c278c377f9646e45eb57d98
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:27 +01:00

objtool: Have WARN_FUNC fall back to sym+off

Currently WARN_FUNC() either prints func+off and failing that prints
sec+off, add an intermediate sym+off. This is useful when playing
around with entry code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.461283840@infradead.org
---
 tools/objtool/include/objtool/warn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index d99c467..802cfda 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -22,6 +22,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	unsigned long name_off;
 
 	func = find_func_containing(sec, offset);
+	if (!func)
+		func = find_symbol_containing(sec, offset);
 	if (func) {
 		name = func->name;
 		name_off = offset - func->offset;
