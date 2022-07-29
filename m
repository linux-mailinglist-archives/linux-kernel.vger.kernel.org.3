Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E0585096
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbiG2NLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 09:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbiG2NKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 09:10:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791813AE69
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 06:10:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSYy5XDWz4xG0;
        Fri, 29 Jul 2022 23:10:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <2ee707512b8b212b079b877f4ceb525a1606a3fb.1656655567.git.christophe.leroy@csgroup.eu>
References: <2ee707512b8b212b079b877f4ceb525a1606a3fb.1656655567.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix boot failure with KASAN + SMP + JUMP_LABEL_FEATURE_CHECK_DEBUG
Message-Id: <165909975339.253830.11928843532091953158.b4-ty@ellerman.id.au>
Date:   Fri, 29 Jul 2022 23:02:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 08:06:15 +0200, Christophe Leroy wrote:
> Since commit 4291d085b0b0 ("powerpc/32s: Make pte_update() non
> atomic on 603 core"), pte_update() has been using
> mmu_has_feature(MMU_FTR_HPTE_TABLE) to avoid a useless atomic
> operation on 603 cores.
> 
> When kasan_early_init() sets up the early zero shadow, it uses
> __set_pte_at(). On book3s/32, __set_pte_at() calls pte_update()
> when CONFIG_SMP is selected in order to ensure the preservation of
> _PAGE_HASHPTE in case of concurrent update of the PTE. But that's
> too early for mmu_has_feature(), so when
> CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG is selected, mmu_has_feature()
> calls printk(). That's too early to call printk() because KASAN
> early zero shadow page is not set up yet. It leads to a deadlock.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Fix boot failure with KASAN + SMP + JUMP_LABEL_FEATURE_CHECK_DEBUG
      https://git.kernel.org/powerpc/c/6042a1652d643d1d34fa89bb314cb102960c0800

cheers
