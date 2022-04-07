Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E334F82A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbiDGPSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiDGPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:18:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A34F5677F;
        Thu,  7 Apr 2022 08:16:48 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 628981EC0295;
        Thu,  7 Apr 2022 17:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649344602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwIpGAyzSx79SRpO72HEUFs9bV0pWCXTJl9t8xrA68E=;
        b=po1XFKCCvO06H8/5eOygISIGmVzRCgNayQw5EUOghRJQoG8Q6iFyYZ6N60hgo9znRL6zVN
        5Jh+oRfW0zKR0ZjmnfcwePtTvYAcaJSQZ/CLXnrFOU4VZty7unTp33Lr6KaSopVKP2kgr+
        Px83JV2Knk9AkAshz1nD3boVIefWfRU=
Date:   Thu, 7 Apr 2022 17:16:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Richard Biener <rguenther@suse.de>
Cc:     linux-toolchains@vger.kernel.org, Michael Matz <matz@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: older gccs and case labels producing integer constants
Message-ID: <Yk8AWEgdej5OrJfT@zn.tnic>
References: <YkwQ6+tIH8GQpuct@zn.tnic>
 <7o5nn52-nqn1-oo13-s6o9-59r85r91o768@fhfr.qr>
 <onrq8p1-582o-6rs9-r682-rs9sqoq7sq6p@fhfr.qr>
 <YkwbygWj/C3XooMV@zn.tnic>
 <YkwdtxNCpiERLFGW@zn.tnic>
 <rppnr36-25n9-nors-3p6-3oos06219s8@fhfr.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rppnr36-25n9-nors-3p6-3oos06219s8@fhfr.qr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:41:09PM +0200, Richard Biener wrote:
> As was noted in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=66880
> this is invalid C99+ but compilers are not required to diagnose that
> (you get it diagnosed with -pedantic).  -fsanitize=shift exposes
> it though since the non-integral-constant gets instrumented.

Right, just to close this: I was still unsure which of the cmdline
options would cause it and bisected the kernel (big fat box can build
allmodconfigs in no time :)).

The single change which fixes the whole build is

---
diff --git a/Makefile b/Makefile
index 8c7de9a72ea2..3582089cfeb6 100644
--- a/Makefile
+++ b/Makefile
@@ -523,7 +523,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Werror=return-type -Wno-format-security \
-		   -std=gnu11
+		   -std=gnu89
 KBUILD_CPPFLAGS := -D__KERNEL__
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=

with that

gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]

but as we saw, only -std=gnu11 alone doesn't cause it:

$ gcc -std=gnu11 -o switch.o switch.c
$

And so we had the -fsanitize=shift already enabled since 2020 in the
kernel build and the gnu11 change then triggered the undefined behavior
due to the -fsanitize instrumentation as it was already explained:

$ gcc -std=gnu11 -fsanitize=shift -o switch.o switch.c
switch.c: In function ‘foo’:
switch.c:10:7: error: case label does not reduce to an integer constant
       case (((0xfc08) << 16) | (0x0101)):;
       ^~~~

Ok, now I can sleep at night again.

:-)))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
