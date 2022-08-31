Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A605A885C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiHaVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiHaVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:48:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABC7F61B2;
        Wed, 31 Aug 2022 14:48:43 -0700 (PDT)
Date:   Wed, 31 Aug 2022 21:48:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661982521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ruc15FW8yZ3ad1mAu2TEMPhbmoHkGlGQXyyboBFzGcE=;
        b=OEnH+Rf/IsX43S07eKFxsTUVe8K0QM5NxhumJ4ZcYrg4GR9YTPbwFw5YjgRRN8xUsJqCwB
        BK8QCyqPmc5oo8z8wvHnl8JPGIH+deIMqsvyIt8wXtwdoHN7fr/h6dTtlPk6lbIq7R/xDL
        OhyjEkUkyFr7krEJUg7Orawt3JphndhnKO6QbcahvDwDXYAlT3Vk6FcUObX9sY5q3dK3td
        PW7zuKZgtgJJog0ulFL2IeznO7s8D7eWciMftY7ztka/quNULz7mDJ91gUwkrWLe8qFhwg
        FFELVLh2jv4M6FtPttS0G5M9RU44rabjHYCy2OGSTLJTFFX61Fnj+EKNhanpLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661982521;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ruc15FW8yZ3ad1mAu2TEMPhbmoHkGlGQXyyboBFzGcE=;
        b=z00oK9h8PdChZAosQTs4NmpyrQA5jGCepFTaca07EKEQGSNf3pgOn2TcR+QcIlgYru7K+m
        lusPp5pSOAqdt3Bg==
From:   "tip-bot2 for Stephen Kitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/Kconfig: Specify idle=poll instead of no-hlt
Cc:     Stephen Kitt <steve@sk2.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220713160840.1577569-1-steve@sk2.org>
References: <20220713160840.1577569-1-steve@sk2.org>
MIME-Version: 1.0
Message-ID: <166198252046.401.16177409434472954362.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     7987448ffc34f41590bae5b28cd23ca0b8c93291
Gitweb:        https://git.kernel.org/tip/7987448ffc34f41590bae5b28cd23ca0b8c93291
Author:        Stephen Kitt <steve@sk2.org>
AuthorDate:    Wed, 13 Jul 2022 18:08:40 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 Aug 2022 14:43:36 -07:00

x86/Kconfig: Specify idle=poll instead of no-hlt

Commit 27be45700021 ("x86 idle: remove 32-bit-only "no-hlt" parameter,
hlt_works_ok flag") removed no-hlt, but CONFIG_APM still refers to
it. Suggest "idle=poll" instead, based on the commit message:

> If a user wants to avoid HLT, then "idle=poll"
> is much more useful, as it avoids invocation of HLT
> in idle, while "no-hlt" failed to do so.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220713160840.1577569-1-steve@sk2.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1..83b163a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2569,7 +2569,7 @@ menuconfig APM
 
 	  1) make sure that you have enough swap space and that it is
 	  enabled.
-	  2) pass the "no-hlt" option to the kernel
+	  2) pass the "idle=poll" option to the kernel
 	  3) switch on floating point emulation in the kernel and pass
 	  the "no387" option to the kernel
 	  4) pass the "floppy=nodma" option to the kernel
