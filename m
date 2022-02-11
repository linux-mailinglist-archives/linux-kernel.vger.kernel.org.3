Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE44B2415
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349359AbiBKLRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:17:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349350AbiBKLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:17:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B096E66;
        Fri, 11 Feb 2022 03:17:02 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:16:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644578219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epLaLQKvF19KwptYYUJgoUEUm7OX4ivS5s4r0mEQvNc=;
        b=mh8Niq5AVApUNdlk34px0xCddnErfNmz/S6hY1K9YMboNCHIsvGODvg41PaYDURtS2YeYZ
        OsRpGEeLYI5uoRiaLgFh8RwjK7MlfTr1P/sE7BV4g+hv1aFEi4aL9NqAghNv1/bM4iR+he
        nw6/4bstCKYqgRTtywbYm5lnEO+eZpYGxZuXqdBtmzCeKgwtGfrnurzeKdOqkaInwD0GR0
        LoahEKwiagr4Oy1fOrR1BFzRf9alYs2MwevM32Zf+/b9ojyTrdw4bzelgbdiZ2//kCWnoj
        Oq9SdSymLNAu5i59P9tsqHATpiCh7sQ+PzYz3xoZbVOaV6ejRUkeJWoy3skFEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644578219;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epLaLQKvF19KwptYYUJgoUEUm7OX4ivS5s4r0mEQvNc=;
        b=2nf1oMfTvofom88OCfCUnEkwnRpPx/cXSIBvrja97eAzQYsaIg/w8r4iLSYw7q8QM5WzkL
        CKdHG4Mw+Q/msiCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Enable RT_MUTEXES by default on PREEMPT_RT.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YgKmhjkcuqWXdUjQ@linutronix.de>
References: <YgKmhjkcuqWXdUjQ@linutronix.de>
MIME-Version: 1.0
Message-ID: <164457821855.16921.12710951179676834018.tip-bot2@tip-bot2>
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

Commit-ID:     1c6f9ec0095459b5120a1cb059d442f56d3cb6e7
Gitweb:        https://git.kernel.org/tip/1c6f9ec0095459b5120a1cb059d442f56d3cb6e7
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 08 Feb 2022 18:21:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Feb 2022 12:13:56 +01:00

locking: Enable RT_MUTEXES by default on PREEMPT_RT.

The CONFIG_RT_MUTEXES option is enabled by CONFIG_FUTEX and CONFIG_I2C.
If both are disabled then a CONFIG_PREEMPT_RT build fails to compile.
It is not possible to have a PREEMPT_RT kernel without RT_MUTEX support
because RT_MUTEX based locking is always used.

Enable CONFIG_RT_MUTEXES by default on PREEMPT_RT builds.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YgKmhjkcuqWXdUjQ@linutronix.de
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index e9119bf..beb5b86 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2054,6 +2054,7 @@ source "arch/Kconfig"
 
 config RT_MUTEXES
 	bool
+	default y if PREEMPT_RT
 
 config BASE_SMALL
 	int
