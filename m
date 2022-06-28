Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96A55D273
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345027AbiF1LPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbiF1LPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:15:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDF2DD70
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6313DB81DD4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243BC36AE2;
        Tue, 28 Jun 2022 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414927;
        bh=mvtI/btKWfnTj6WXNoVCJqoXnRiwk3z7k27yaBrHk6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N70eu5enrxm4OiBTiSAzky1+jssaY1i3TRwY+QbOROq19VdriskmFaEvqP85ZzqfP
         6qq/4zdDHuwpse8fQj+G22hgEoNyy+zmmFrhKeIUq6rS2LSzwiewGVn6u0EQWMHAHc
         lQv0de9YCL/4tlYXZnL/5ty4nBMsWSiCPjoLT5NevrNiaC9KcXrZsAeuEeqdCMsMtg
         4nHXglGzIHK2evVEkRuYL9a4ZKsoMckT9CdYW0rohjKedWtBAsZ3xdFu5IN6+EsnF6
         0PrD1rJAs6gNPi9tz+I0vwpVnXTojbzLDaRO/bS+rdTiW5LGU3b9/kZGxu/9Q3gp2Q
         FQJK6B45L/mXg==
Date:   Tue, 28 Jun 2022 12:15:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v6 02/10] arm64: asm-extable: move data fields
Message-ID: <20220628111514.GB23703@willie-the-truck>
References: <20220621072638.1273594-1-tongtiangen@huawei.com>
 <20220621072638.1273594-3-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621072638.1273594-3-tongtiangen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 07:26:30AM +0000, Tong Tiangen wrote:
> In subsequent patches we'll need to fill in extable data fields in
> regular assembly files. In preparation for this, move the definitions of
> the extable data fields earlier in asm-extable.h so that they are
> defined for both assembly and C files.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/arm64/include/asm/asm-extable.h | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

This (and the following) patch should retain Mark's authorship information
as they are taken from his git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/extable/asm-uaccess

I plan to apply the first six patches for now, so I'll fix that up at the
same time.

Will
