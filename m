Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431554D997F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347655AbiCOKsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347409AbiCOKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B725132E;
        Tue, 15 Mar 2022 03:44:16 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5CpjSznTbEEJpHjv2C7LgNb/RksDuKfN9cwrO2N9tjU=;
        b=PZ1PukPdPPl6jAIcuCgXmBbI83bmpW9E6DAIO+XP94l/PJSyS5YRPfxIqU0/qZ8rRtojBy
        4Vb3c+4AIxmadQg0mPRTAnm41cW7FzR49v8nMSMK50JGgCBswVCBpAFcX+YKPAJcG01rH/
        sW7u6Baa4bXMtbrnfV5V7GfTdLCvmZAV9zmCn9YzhlA9DCBULgwRUH8xl4nnNnjzHoZ/GM
        MZD2wlRU3gyNFFbVr3l6AcB9KEtRku+ox9Vhas/5aAjZJ1zyrDx2vdzuOdF6ghPszYAd2J
        lKVcnYJiXmwDioL1crsv0AQFVLGISNS9y3qr1rEvmZJK6YZjfyzfcVGbbxO9vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5CpjSznTbEEJpHjv2C7LgNb/RksDuKfN9cwrO2N9tjU=;
        b=YlP9O/cY7S7yqiZGRGcE7UaIjcjgGB5P4F8APOc67phkXjRI2sIkle5MXa80mTQeYtYPnu
        cpAK/KMswOzdLMDA==
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
Message-ID: <164734105395.16921.7270488938298112869.tip-bot2@tip-bot2>
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

Commit-ID:     5cff2086b01526b8c7deacc86473ffbab0cddfa9
Gitweb:        https://git.kernel.org/tip/5cff2086b01526b8c7deacc86473ffbab0cddfa9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:32 +01:00

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
