Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F155EA91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiF1RD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiF1RCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:02:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7031EAF1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1EB9BCE2190
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04EAC341CA;
        Tue, 28 Jun 2022 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656435761;
        bh=S32FMs79QFdhccYVIsfN0jeTR/UCl/EkVGQ6c7PUe/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKquhmx4PgwAxI9qzdMAd6hTzqjou6Mp9wbsrIxG9MrcTQIz8S0N5qfU8rEhUwMsS
         ZDwGlgYCSawYzZBh/iKkxouLSsicKaiju5HB7A+pe3Ny5B/SUfQwFtkauzlTE9GbTE
         V1aIBruQfWCLpph393iPzJ49/g5Mqcd7mUBnvBCkaad0xJsmEp0iuy3nRkO7bb+AOB
         1STJ9D0SGklLeomYlv/fn6AubEfvJz6DCfKv1qT5gCBeCH4HOLw5WTwI3JnMxEScPz
         iXk1YB5IwvsgsOsc9a/dCZXcbHBQJhQVk9WNAh8VRdGC2CJMBii26enWIVvTFB3ekn
         Xa1ZY9l+XSGZA==
From:   Will Deacon <will@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tong Tiangen <tongtiangen@huawei.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Xie XiuQi <xiexiuqi@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next v6 00/10]arm64: add machine check safe support
Date:   Tue, 28 Jun 2022 18:02:29 +0100
Message-Id: <165641466190.2591451.4767914938130447014.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220621072638.1273594-1-tongtiangen@huawei.com>
References: <20220621072638.1273594-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 07:26:28 +0000, Tong Tiangen wrote:
> With the increase of memory capacity and density, the probability of
> memory error increases. The increasing size and density of server RAM
> in the data center and cloud have shown increased uncorrectable memory
> errors.
> 
> Currently, the kernel has a mechanism to recover from hardware memory
> errors. This patchset provides an new recovery mechanism.
> 
> [...]

Applied first six patches to arm64 (for-next/extable), thanks!

[01/10] arm64: extable: add new extable type EX_TYPE_KACCESS_ERR_ZERO support
        https://git.kernel.org/arm64/c/4953fc3d3270
[02/10] arm64: asm-extable: move data fields
        https://git.kernel.org/arm64/c/5519d7de2f8e
[03/10] arm64: asm-extable: add asm uacess helpers
        https://git.kernel.org/arm64/c/59e8a1ce8f7b
[04/10] arm64: extable: make uaaccess helper use extable type EX_TYPE_UACCESS_ERR_ZERO
        https://git.kernel.org/arm64/c/c4ed0d73ede9
[05/10] arm64: extable: move _cond_extable to _cond_uaccess_extable
        https://git.kernel.org/arm64/c/e4208e80a353
[06/10] arm64: extable: cleanup redundant extable type EX_TYPE_FIXUP
        https://git.kernel.org/arm64/c/bacac637025c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

