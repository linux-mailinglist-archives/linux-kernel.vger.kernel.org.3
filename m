Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98856CE70
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiGJJpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJJpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:45:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790C12778
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 02:45:38 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff643329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f643:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20AA91EC01B7;
        Sun, 10 Jul 2022 11:45:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657446333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AKJ430ZgN1XdgA7qMu9v4uYf5Spa2vuStLi0ikdoxF8=;
        b=AeuVxxsLezyAJPuEwxsCCYZrP9Nk/A5feET5ToU82yk4sTDb1+ZSwhS6Iy0OpPqDL+ndWh
        MNWh0qrAiNJPHh9oL8XjZ+lZ/RlL6KJNBtQS63Zg/72hGcsfO8RmDWq7BQCd4EOiZ8fYwS
        A1xL2PiZ/Tm6lfJPsvNfc4VRGjRy+vk=
Date:   Sun, 10 Jul 2022 11:45:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
Message-ID: <YsqfuPeB5jhFU9g5@zn.tnic>
References: <20220707000852.523788-1-Jason@zx2c4.com>
 <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com>
 <YslPKbrmwF0uSm7p@zn.tnic>
 <191d8f96-7573-bd0e-9ca4-3fc22c5c9a49@zytor.com>
 <Ysn5uvBKBpcZ4j6m@zn.tnic>
 <8e5eb2db-ce31-3dc8-8f75-3959036686f8@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e5eb2db-ce31-3dc8-8f75-3959036686f8@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 03:41:19PM -0700, H. Peter Anvin wrote:
> In ABI/API terms, that symbol has the semantic of connecting the API version
> to the underlying ABI version; a piece of code that sees an enumeration type
> > SETUP_ENUM_MAX must by definition treat it as an opaque blob. In the
> future, should it become warranted, we may add flags that indicate how
> unaware code should handle them, but I don't think we can engineer that
> right now.

Ok, let's hope it doesn't come to that and userspace behaves... <eyeroll>

So, I'm going to send the below to Linus now so that 5.19 releases fixed
and then queue Jason's patch next week.

Thx.

---

From: Borislav Petkov <bp@suse.de>
Date: Sun, 10 Jul 2022 11:15:47 +0200
Subject: [PATCH] x86/boot: Fix the setup data types max limit

Commit in Fixes forgot to change the SETUP_TYPE_MAX definition which
contains the highest valid setup data type.

Correct that.

Fixes: 5ea98e01ab52 ("x86/boot: Add Confidential Computing type to setup_data")
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com
---
 arch/x86/include/uapi/asm/bootparam.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index bea5cdcdf532..e02a8a8ef23c 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -15,7 +15,7 @@
 #define SETUP_INDIRECT			(1<<31)
 
 /* SETUP_INDIRECT | max(SETUP_*) */
-#define SETUP_TYPE_MAX			(SETUP_INDIRECT | SETUP_JAILHOUSE)
+#define SETUP_TYPE_MAX			(SETUP_INDIRECT | SETUP_CC_BLOB)
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
