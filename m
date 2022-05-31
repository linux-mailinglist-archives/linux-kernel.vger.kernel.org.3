Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29835538B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244211AbiEaGQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbiEaGQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:16:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D16792D3E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:16:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LC291721gz4xZ9;
        Tue, 31 May 2022 16:16:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1653977782;
        bh=L9W+Ez14jNWPvYxx5g+IS/ySPZL3FBFAy+k2BgakNiM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RwBGNA04uOwOF57bymmd7wH/6woLNPUzxr7lLhrqbAYPZVBm2pPDxLQHQoXjz4BSu
         ssRjypFGaeqU5VyVQ2r1BfagcsNUbrydDSkszrv4Pz6raJKwm4FwZcCP1kDwnzizZQ
         uB8UumwCAYYXqSYYVEcrEmF7viOuv0pk10RQpJbAV6O6tay9ou7BkO6s/fDEHPJ9zn
         7RaMVfMgWJChDOS1MUfJxlPpNg5r8xhdk5lA+nKMyNXsctdauJatym5X/VRvMhldgJ
         w2rgYqtbbg8fb5PRRUtRz7CnaDoYjTpPporpJTQthoRlxnIhyVYuwPp5tmMIWh7LXp
         Mqvin/cVVfnBQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] powerpc/Kconfig: Force THREAD_SHIFT to at least 14 with
 KASAN
In-Reply-To: <cc1190008368a3305d424a98be756fedec6348c1.1653926503.git.christophe.leroy@csgroup.eu>
References: <cc1190008368a3305d424a98be756fedec6348c1.1653926503.git.christophe.leroy@csgroup.eu>
Date:   Tue, 31 May 2022 16:16:19 +1000
Message-ID: <87h756kz0s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Allthough 14 is the default THREAD_SHIFT when KASAN is selected,
> taking an old config may keep 13 when CONFIG_EXPERT is selected.
>
> Force it to 14 as a minimum when KASAN is selected.
>
> Also default to 15 when KASAN on PPC64.
>
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I was thinking of doing it in C, similar to the way arm64 handles it.

Something like below. It means we always double the stack size when
KASAN is enabled. I think it's preferable, as it will always work
regardless of whether the user has an old .config (or is bisectting)?

cheers

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 125328d1b980..c9735f93f8e6 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -14,12 +14,17 @@
 
 #ifdef __KERNEL__
 
-#if defined(CONFIG_VMAP_STACK) && CONFIG_THREAD_SHIFT < PAGE_SHIFT
-#define THREAD_SHIFT		PAGE_SHIFT
+#ifdef CONFIG_KASAN
+#define THREAD_SHIFT		(CONFIG_THREAD_SHIFT + 1)
 #else
 #define THREAD_SHIFT		CONFIG_THREAD_SHIFT
 #endif
 
+#if defined(CONFIG_VMAP_STACK) && THREAD_SHIFT < PAGE_SHIFT
+#undef THREAD_SHIFT
+#define THREAD_SHIFT		PAGE_SHIFT
+#endif
+
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
 /*


