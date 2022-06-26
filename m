Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9BE55ADCA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiFZA25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiFZA24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:28:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27E51262D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 17:28:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LVsD05Fn4z4xNm;
        Sun, 26 Jun 2022 10:28:48 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3802811f7cf94f730be44688539c01bba3a3b5c0.1654875808.git.christophe.leroy@csgroup.eu>
References: <3802811f7cf94f730be44688539c01bba3a3b5c0.1654875808.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/prom_init: Fix build failure with GCC_PLUGIN_STRUCTLEAK_BYREF_ALL and KASAN
Message-Id: <165620330350.1934578.13931347836016733313.b4-ty@ellerman.id.au>
Date:   Sun, 26 Jun 2022 10:28:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 17:43:43 +0200, Christophe Leroy wrote:
> When CONFIG_KASAN is selected, we expect prom_init to use __memset()
> because it is too early to use memset().
> 
> But with CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, the compiler adds calls
> to memset() to clear objects on stack, hence the following failure:
> 
> 	  PROMCHK arch/powerpc/kernel/prom_init_check
> 	Error: External symbol 'memset' referenced from prom_init.c
> 	make[2]: *** [arch/powerpc/kernel/Makefile:204 : arch/powerpc/kernel/prom_init_check] Erreur 1
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/prom_init: Fix build failure with GCC_PLUGIN_STRUCTLEAK_BYREF_ALL and KASAN
      https://git.kernel.org/powerpc/c/ca5dabcff1df6bc8c413922b5fa63cc602858803

cheers
