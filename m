Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395B4BA8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiBQS4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:56:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbiBQS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:56:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87AB5F8F;
        Thu, 17 Feb 2022 10:56:27 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1x40Q606L/Q8pQl/NnBIrSRpFV95c5ypcmxhLSLAO1Q=;
        b=uB1Bm1sdpcp0/GgYAqmc9hdRq2VwlxJFz0xzdK7WAVPQ6TjaNXLnsOQVAtDhj3LjF7SOHr
        PL/IDXTjlHJ+xHY/dK8J4TKTL/+oGhuvTE4YX4lGbdxL+HCw4MvHVZV7oOs+RAP+TI1kov
        HbEU7VeyoL723xXXtHESdaidUJ+3UZj7/IKCokQyDKiI5ABrv0J6oaR1ue5/uCGj3V6a7L
        3s9GXmpdvZl9SF83ehXkyAExVFH0ox01TO3TEg23foNe9ddgUQF255fAAQbgOFAA2uYnF3
        D6N1mfWgNQEx8SuxnEYsi5nEx44FkzUS+qhCi7EDHEVfmTnVKiYQq48dNJy0YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124185;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1x40Q606L/Q8pQl/NnBIrSRpFV95c5ypcmxhLSLAO1Q=;
        b=/J/N2Bw88y3rCuluSmkMYYRRPiq9mPZf2EAuHkqj1RK4Lo1/T4f6KrbExkDPBRpN0M0nW5
        1zIzFG69YLWHFWCg==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] jump_label: Avoid unneeded casts in
 STATIC_KEY_INIT_{TRUE,FALSE}
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220213165717.2354046-1-masahiroy@kernel.org>
References: <20220213165717.2354046-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <164512418472.16921.4231263161341190140.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fe65deb56e552a8c9bf7f27860dbdeac12a36116
Gitweb:        https://git.kernel.org/tip/fe65deb56e552a8c9bf7f27860dbdeac12a36116
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Mon, 14 Feb 2022 01:57:16 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:58 +01:00

jump_label: Avoid unneeded casts in STATIC_KEY_INIT_{TRUE,FALSE}

Commit 3821fd35b58d ("jump_label: Reduce the size of struct static_key")
introduced the union to struct static_key.

It is more natual to set JUMP_TYPE_* to the .type field without casting.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220213165717.2354046-1-masahiroy@kernel.org
---
 include/linux/jump_label.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 48b9b2a..6924e68 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -251,10 +251,10 @@ extern void static_key_disable_cpuslocked(struct static_key *key);
  */
 #define STATIC_KEY_INIT_TRUE					\
 	{ .enabled = { 1 },					\
-	  { .entries = (void *)JUMP_TYPE_TRUE } }
+	  { .type = JUMP_TYPE_TRUE } }
 #define STATIC_KEY_INIT_FALSE					\
 	{ .enabled = { 0 },					\
-	  { .entries = (void *)JUMP_TYPE_FALSE } }
+	  { .type = JUMP_TYPE_FALSE } }
 
 #else  /* !CONFIG_JUMP_LABEL */
 
