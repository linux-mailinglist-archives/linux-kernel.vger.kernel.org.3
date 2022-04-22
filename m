Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683A250B539
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391102AbiDVKi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446708AbiDVKiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09A7674;
        Fri, 22 Apr 2022 03:35:09 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPyAV1MQK6vytVePODRh9/qduZaNhbRreAY4EBfrXMo=;
        b=Bk6NK/IZZElXoI7TNmU7qmjKqg167m1LcrY6KFzckexRj1rZQ7PV3vmGhAPM7w9qAiaNDZ
        VgoosgITDn5QEeWgR7IX59ms4ZpzzidDaF0TNvyv/99FM5A3eQkZoVoEb1Yy1m3M7O03Ns
        tk6seCB/2BGjZjyihlHwuMrfQ2eoMc9BcwsefhsGqiZMuhytzjHurhiXDCmYyG0WFku3+r
        SS9QB2Fk9VRrzPSNbgArjFXVSOXE671NY82mETguPOObgV1TEuljKGD83Z2MB0UZw/eIiH
        dYKCCbgPhGw2NrLWmEv37qApszGfCL3X/qkhKKRRwmfQf2rneJu4Kc6ltI02YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPyAV1MQK6vytVePODRh9/qduZaNhbRreAY4EBfrXMo=;
        b=r4fYhqEwlkOMy5Eb5nH/gV6qwLaQNeJ6QOFO1wnNH8aj7msCpdn/c3+GBZE7ldUWQ2IYhW
        3SC3FJxOMZgwjoBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Don't print parentheses in function addresses
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <f2bec70312f62ef4f1ea21c134d9def627182ad3.1650300597.git.jpoimboe@redhat.com>
References: <f2bec70312f62ef4f1ea21c134d9def627182ad3.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370707.4207.3964620644535103680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2bc3dec7055e34c2c2e497f109da6748544c0791
Gitweb:        https://git.kernel.org/tip/2bc3dec7055e34c2c2e497f109da6748544c0791
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:02 +02:00

objtool: Don't print parentheses in function addresses

The parentheses in the "func()+off" address output are inconsistent with
how the kernel prints function addresses, breaking Peter's scripts.
Remove them.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/f2bec70312f62ef4f1ea21c134d9def627182ad3.1650300597.git.jpoimboe@redhat.com
---
 tools/objtool/include/objtool/warn.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index 802cfda..c4bde3e 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -33,11 +33,7 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	}
 
 	str = malloc(strlen(name) + 20);
-
-	if (func)
-		sprintf(str, "%s()+0x%lx", name, name_off);
-	else
-		sprintf(str, "%s+0x%lx", name, name_off);
+	sprintf(str, "%s+0x%lx", name, name_off);
 
 	return str;
 }
