Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABE949FC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbiA1Oxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiA1Oxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:53:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154DDC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:53:46 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643381623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5w2S5ndYwVItVkiDPg/uT/UFko3VOhpELYHRGKacXU=;
        b=LFOjhaqC5qvgSmaAH2KNicSXyl3qeriZ/Gj0IQOoWMWNe4v28oznoIF43IiHE0hhxjd4pf
        Dp0SDui1xtKckdpveuc/8T8ybHkXnLDZIR6DFQW0s/b1vSLKuIJ9kSTqQ8TBY23jW6LVGt
        DHUEPv55YkuVVdstdaDU13BUaeb1itS4WUj2Pr0XQ3D7Q0wvLxjguI6VYi3F/x4LOvLDYt
        PF4VvIMrXt0sTvyMKURsjt1wlCvm1vmU4AzRXd45wcmaDcjKm7Ce/ZtjpHCHu7Ph9IaiFp
        h+393lQsyi1qViC4Ll9U2p27LHRbZIm3h9sWyqdC9ACvINqSuQdlxLIx/4AluA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643381623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C5w2S5ndYwVItVkiDPg/uT/UFko3VOhpELYHRGKacXU=;
        b=r7H3xY7nCZjmcsVrwvUy6GaO5T8z2QBOTJ/TnVehHwHwFxDF2NmH291HC3ZYSLHtC8DAvx
        AgDGj7XNHAFaklBA==
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YfNVBzN67rSu/QcE@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com> <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx> <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
 <878rv46eg3.ffs@tglx> <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com>
 <87k0em4lu9.ffs@tglx> <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
 <8735la41qb.ffs@tglx> <YfNVBzN67rSu/QcE@otcwcpicx3.sc.intel.com>
Date:   Fri, 28 Jan 2022 15:53:42 +0100
Message-ID: <87zgnf29op.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27 2022 at 18:42, Fenghua Yu wrote:
> On Wed, Jan 26, 2022 at 10:38:04PM +0100, Thomas Gleixner wrote:
>> Against Linus tree please so that the bugfix applies.
>> 
>> > I will fold the following patch into patch #5. The patch #11 (the doc patch)
>> > also needs to remove one paragraph talking about refcount.
>> >
>> > So I will send the whole patch set with the following changes:
>> > 1. One new bug fix patch (the above patch)
>
> When I study your above aux_domain bug fix path, I find more aux_domain bugs.
> But then I find aux_domain will be completely removed because all aux_domain
> related callbacks are not called and are dead code (no wonder there are
> so many bugs in aux_domain). Please see this series: https://lore.kernel.org/linux-iommu/20220124071103.2097118-4-baolu.lu@linux.intel.com/
> For the series, Baolu confirms that he is "pretty sure that should be part
> of v5.18". And I don't find the series calls any IOASID function after
> removing the aux_domain code.
>
> So that means we don't need to fix those issues in the dead aux_domain
> code any more because it will be completely removed in 5.18, right?
>
> If you agree, I will not include the aux_domain fix patch or any other
> aux_domain fix patches in the up-coming v3. Is that OK?

Fair enough.

