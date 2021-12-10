Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D70470378
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242635AbhLJPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhLJPIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:08:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4DC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:04:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1CA76CE2B82
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB2CC00446;
        Fri, 10 Dec 2021 15:04:48 +0000 (UTC)
Date:   Fri, 10 Dec 2021 15:04:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        broonie@kernel.org, dave.hansen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        mingo@redhat.com, tabba@google.com, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [RFC PATCH 0/6] linkage: better symbol aliasing
Message-ID: <YbNsjU2n2uXlg3fc@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:47:09PM +0000, Mark Rutland wrote:
> This series aims to make symbol aliasing simpler and more consistent.
> The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
> SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
> that e.g.
> 
>     SYM_FUNC_START(func)
>     SYM_FUNC_START_ALIAS(alias1)
>     SYM_FUNC_START_ALIAS(alias2)
>         ... asm insns ...
>     SYM_FUNC_END(func)
>     SYM_FUNC_END_ALIAS(alias1)
>     SYM_FUNC_END_ALIAS(alias2)
>     EXPORT_SYMBOL(alias1)
>     EXPORT_SYMBOL(alias2)
> 
> ... can become:
> 
>     SYM_FUNC_START(name)
>         ... asm insns ...
>     SYM_FUNC_END(name)
> 
>     SYM_FUNC_ALIAS(alias1, func)
>     EXPORT_SYMBOL(alias1)
> 
>     SYM_FUNC_ALIAS(alias2, func)
>     EXPORT_SYMBOL(alias2)
> 
> This avoids repetition and hopefully make it easier to ensure
> consistency (e.g. so each function has a single canonical name and
> associated metadata).
> 
> I'm sending this as an RFC since I want to check:
> 
> a) People are happy with the idea in principle.
> 
> b) People are happy with the implementation within <linux/linkage.h>.
> 
> ... and I haven't yet converted the headers under tools/, which is
> largely a copy+paste job.

I'm happy with the approach and acked the arm64 patches for the record.
Not sure how/when this series will get into mainline.

-- 
Catalin
