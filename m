Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25528551F95
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiFTPB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFTPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:01:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B5D2A24E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:26:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C925E1596;
        Mon, 20 Jun 2022 07:26:44 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A803F534;
        Mon, 20 Jun 2022 07:26:41 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:26:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v5 2/8] arm64: extable: make uaaccess helper use
 extable type EX_TYPE_UACCESS_ERR_ZERO
Message-ID: <YrCDnc8ZjgbHAhGU@FVFF77S0Q05N>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
 <20220528065056.1034168-3-tongtiangen@huawei.com>
 <Yqw6TP3MhEqnQ+2o@FVFF77S0Q05N>
 <4371a7c9-8766-9fee-2558-e6f43f06ad19@huawei.com>
 <0da734f3-5743-3df3-3f90-d92e5bd585ce@huawei.com>
 <Yq3HoUyEcnKKk1AY@FVFF77S0Q05N>
 <684f0362-6e58-753d-32e1-112c6ffe6d12@huawei.com>
 <YrA5f44hySky8v5g@FVFF77S0Q05N>
 <908f4c14-b9cb-71f8-7a3c-7569f7c89033@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <908f4c14-b9cb-71f8-7a3c-7569f7c89033@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:13:41PM +0800, Tong Tiangen wrote:
> 
> 
> 在 2022/6/20 17:10, Mark Rutland 写道:
> > On Mon, Jun 20, 2022 at 10:59:12AM +0800, Tong Tiangen wrote:
> > > 在 2022/6/18 20:40, Mark Rutland 写道:
> > > The following errors are reported during compilation:
> > > [...]
> > > arch/arm64/lib/clear_user.S:45: Error: invalid operands (*ABS* and *UND*
> > > sections) for `<<'
> > > [...]
> > 
> > As above, I'm not seeing this.
> > 
> > This suggests that the EX_DATA_REG() macro is going wrong somehow. Assuming the
> > operand types correspond to the LHS and RHS of the expression, this would mean
> > the GPR number is defined, but the REG value is not, and I can't currently see
> > how that can happen.
 
> Now I can compile success, both versions 9.4.0 and 11.2.0.
> 
> I should have made a mistake. There is no problem using your implementation.
> I will send a new version these days.

No problem; thanks for confirming!

Mark.
