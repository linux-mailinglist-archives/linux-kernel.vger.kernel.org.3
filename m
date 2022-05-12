Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8C524B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352985AbiELLLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiELLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:11:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B83532F0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:11:06 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84EDC1EC0445;
        Thu, 12 May 2022 13:11:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652353861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5C8XNjk61+NvHfhAsvBbiWRgErg4Q9IkuFQ7F4uDckA=;
        b=IURjnoaRNsOcAuXiX8cHJCSSRqFCMzlPSoUwBAkhD7sKhaNTsUXdD8uSg5JZ3xwx14uClU
        QuLRpT5Gp1WOMfBjLvLVfYhn7PnACU9U2ueBEncObpyvnDe8UZXv8h1RIN+R/7/Y2HDBGx
        4WK/aVB6VAK00xWFJCf+tGWSN/BdYq8=
Date:   Thu, 12 May 2022 13:10:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baskov Evgeniy <baskov@ispras.ru>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] x86: Add strlcat() to compressed kernel
Message-ID: <YnzrO8O4Q66SFED0@zn.tnic>
References: <20220505103224.21667-1-baskov@ispras.ru>
 <20220505103224.21667-2-baskov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220505103224.21667-2-baskov@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 01:32:23PM +0300, Baskov Evgeniy wrote:
> Subject: Re: [PATCH v3 1/2] x86: Add strlcat() to compressed kernel

The tip tree preferred format for patch subject prefixes is
'subsys/component:', e.g. 'x86/apic:', 'x86/mm/fault:', 'sched/fair:',
'genirq/core:'. Please do not use file names or complete file paths as
prefix. 'git log path/to/file' should give you a reasonable hint in most
cases.

The condensed patch description in the subject line should start with a
uppercase letter and should be written in imperative tone.

In your case, that would be x86/boot: Add...

> strlcat() simplifies the code of command line
> concatenation and reduces the probability of mistakes.
> 
> Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
> 
> diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
> index 81fc1eaa3229..b0635539b6f6 100644
> --- a/arch/x86/boot/compressed/string.c
> +++ b/arch/x86/boot/compressed/string.c
> @@ -40,6 +40,21 @@ static void *____memcpy(void *dest, const void *src, size_t n)
>  }
>  #endif
>  
> +size_t strlcat(char *dest, const char *src, size_t count)
> +{
> +	size_t dsize = strlen(dest);
> +	size_t len = strlen(src);
> +	size_t res = dsize + len;

You can add the BUG_ON() check from the kernel proper version like this:

diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index b0635539b6f6..643fcd957527 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -46,6 +46,10 @@ size_t strlcat(char *dest, const char *src, size_t count)
 	size_t len = strlen(src);
 	size_t res = dsize + len;
 
+        /* This would be a bug */
+        if (dsize >= count)
+		error("strlcat(): destination too big\n");
+
 	dest += dsize;
 	count -= dsize;
 	if (len >= count)
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 7558139920f8..65f0cedb65ae 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -57,3 +57,4 @@ void purgatory(void)
  * arch/x86/boot/compressed/string.c
  */
 void warn(const char *msg) {}
+void error(char *m) {}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
