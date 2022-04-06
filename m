Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00AC4F5EC6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiDFNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiDFNDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:03:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68C72EBA52
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:31:21 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68EC11EC0426;
        Wed,  6 Apr 2022 11:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649237434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xNgJ94p4O9/k4M97cHEVb1as3sdFhq6bklaCMoaeeII=;
        b=D+gBk2yuR9SEsd0Mv7pdVbeS7OW8wP5r2HdSNg67PqFOGHrMF+/DzjFd/Pq8IG0O5zy7IV
        Ol/u/cWZT9AO/A0GloXQeM+lXzxx4ahCQ7gQ/o0eY2iT7BI6lPqXnuAQ3tA+Z4b87twfSs
        ZgpQ9pnqoLP/toYJxz+T+U7qmAJSz+8=
Date:   Wed, 6 Apr 2022 11:30:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Carroll, Lewis" <Lewis.Carroll@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Rao, Bharata Bhasker" <bharata@amd.com>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "metze@samba.org" <metze@samba.org>,
        "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] x86: Prefer MWAIT over HALT on AMD processors
Message-ID: <Yk1dvBS4BPCPYt+t@zn.tnic>
References: <20220405130021.557880-1-wyes.karny@amd.com>
 <YkxMtx9zdk+nH33r@zn.tnic>
 <MN2PR12MB3949923BCD8B368F8269565BFAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
 <Ykyo00r8aIibvLpP@zn.tnic>
 <MN2PR12MB394969DC4BAF9B91A0E8A560FAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MN2PR12MB394969DC4BAF9B91A0E8A560FAE49@MN2PR12MB3949.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:49:27PM +0000, Carroll, Lewis wrote:
> Just when I thought I was being thorough. Any of the above will block the
> cpuidle driver from loading. As will absence of _CST ACPI methods (add that
> as a fourth cause).

Yah, put that all in the text over prefer_mwait_c1_over_halt() pls.

> We will have to see what we can sanitize. The original performance observation
> (packet loss in a networking application) led to discovery of lots of cycles
> in the various go-to-sleep-via-halt and wake-from-halt-via-IPI functions. Wyes
> collected the raw data on the relative idle+wake-up latency and included that
> in the commit msg. Think of that delta as the root cause of the performance
> regression in this case.

You don't have to write novels - just leave enough breadcrumbs so that
people looking at this in the future know *why* this was done.

> Yes we are saying use MWAIT instead of HLT on all known (as of today) Zen
> uarch CPUs (AMD >= 17h and Hygon).

Wyes in his reply from today says that the logic is not that simple so
you folks need to define clearly which cases are we talking about here:

Zen uarch, MWAIT CPUID bit set/clear, MONITOR bug, <other feature bits>,
etc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
