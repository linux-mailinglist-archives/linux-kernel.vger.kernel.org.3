Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ACA51C107
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378140AbiEENpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiEENpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026F3B037
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 06:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 659786144D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D69C385A8;
        Thu,  5 May 2022 13:41:51 +0000 (UTC)
Date:   Thu, 5 May 2022 14:41:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
Subject: Re: [PATCH -next v4 4/7] arm64: add copy_{to, from}_user to machine
 check safe
Message-ID: <YnPUHC3GlZs6XHU4@arm.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-5-tongtiangen@huawei.com>
 <YnJU4NIrJmHLawgk@arm.com>
 <7da54d72-e5fa-41b5-67ea-a0b084e4c94a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7da54d72-e5fa-41b5-67ea-a0b084e4c94a@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 02:39:43PM +0800, Tong Tiangen wrote:
> 在 2022/5/4 18:26, Catalin Marinas 写道:
> > On Wed, Apr 20, 2022 at 03:04:15AM +0000, Tong Tiangen wrote:
> > > Add copy_{to, from}_user() to machine check safe.
> > > 
> > > If copy fail due to hardware memory error, only the relevant processes are
> > > affected, so killing the user process and isolate the user page with
> > > hardware memory errors is a more reasonable choice than kernel panic.
> > 
> > Just to make sure I understand - we can only recover if the fault is in
> > a user page. That is, for a copy_from_user(), we can only handle the
> > faults in the source address, not the destination.
> 
> At the beginning, I also thought we can only recover if the fault is in a
> user page.
> After discussion with a Mark[1], I think no matter user page or kernel page,
> as long as it is triggered by the user process, only related processes will
> be affected. According to this
> understanding, it seems that all uaccess can be recovered.
> 
> [1]https://patchwork.kernel.org/project/linux-arm-kernel/patch/20220406091311.3354723-6-tongtiangen@huawei.com/

We can indeed safely skip this copy and return an error just like
pretending there was a user page fault. However, my point was more
around the "isolate the user page with hardware memory errors". If the
fault is on a kernel address, there's not much you can do about. You'll
likely trigger it later when you try to access that address (maybe it
was freed and re-allocated). Do we hope we won't get the same error
again on that kernel address?

-- 
Catalin
