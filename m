Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6A4B62C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiBOFaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:30:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiBOFaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:30:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116C1216A9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:30:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyV6454LFz4y3t;
        Tue, 15 Feb 2022 16:30:04 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chen Jingwen <chenjingwen6@huawei.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
In-Reply-To: <20211229035226.59159-1-chenjingwen6@huawei.com>
References: <20211229035226.59159-1-chenjingwen6@huawei.com>
Subject: Re: [PATCH] powerpc/kasan: Fix early region not updated correctly
Message-Id: <164490280217.270256.12753879562641501185.b4-ty@ellerman.id.au>
Date:   Tue, 15 Feb 2022 16:26:42 +1100
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

On Wed, 29 Dec 2021 11:52:26 +0800, Chen Jingwen wrote:
> The shadow's page table is not updated when PTE_RPN_SHIFT is 24
> and PAGE_SHIFT is 12. It not only causes false positives but
> also false negative as shown the following text.
> 
> Fix it by bringing the logic of kasan_early_shadow_page_entry here.
> 
> 1. False Positive:
> ==================================================================
> BUG: KASAN: vmalloc-out-of-bounds in pcpu_alloc+0x508/0xa50
> Write of size 16 at addr f57f3be0 by task swapper/0/1
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kasan: Fix early region not updated correctly
      https://git.kernel.org/powerpc/c/dd75080aa8409ce10d50fb58981c6b59bf8707d3

cheers
