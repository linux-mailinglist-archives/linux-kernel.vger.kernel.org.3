Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B604694FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242435AbhLFL31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:29:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbhLFL30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:29:26 -0500
Date:   Mon, 6 Dec 2021 12:25:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638789957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLs7YgdFMIcnSazYWZg4jsTq0LGaE/jvcz9Rja/NPMc=;
        b=nAoYk+Ns+6rmT6S9GzrSjhIPCBYjUqfpnGgNgz+swrTZH5Hw/lUwxcA6aKMJq7Q1zV6wb8
        lyNZuLXvJ7mORj0HmC2r9A1REaO6OPTuOtCiJhf4MK6jQvZS22Km7jBifTDhEfnLl0amBK
        LKOsEWmcdXrqg2LxF0mM4c8iJ22mWlKB0hM2uMXvqS1S4wXaJHQyrzN8sTx0C5l77fk0tj
        rX9FyDns92354iLK4whoATvbvW0u1G3rUCCx9LfCZFM2UjgRe43x8C4beJ10j+bdrhHmU+
        rDQqwswK9S41FtMsOXDdIKm1HF133yCuAlr6FysAznUe6Qn4lQo+lYA2435Z1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638789957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XLs7YgdFMIcnSazYWZg4jsTq0LGaE/jvcz9Rja/NPMc=;
        b=doqpd2ejENwBdGZzJ4Idl5tc2F68NpSZ4at5EQ4oLMg2zEZwjKY7pzeUgsuXYAnBVvv0S5
        TSsw8u9yi/SU/hDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, linux-kernel@vger.kernel.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be
 brought up again.
Message-ID: <20211206112555.ubscfwwxnn5bnyte@linutronix.de>
References: <20211122154714.xaoxok3fpk5bgznz@linutronix.de>
 <87y25djhaj.ffs@tglx>
 <4d04ea65-ea74-dcfd-5b0e-984b44f91961@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d04ea65-ea74-dcfd-5b0e-984b44f91961@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-24 21:17:34 [-0500], Boris Ostrovsky wrote:
> 
> On 11/24/21 5:54 PM, Thomas Gleixner wrote:
> > Any comment from XEN folks?
> 
> 
> If memory allocation in cpu_initialize_context() fails we will not be
> able to bring up the VCPU because xen_cpu_initialized_map bit at the
> top of that routine will already have been set. We will BUG in
> xen_pv_cpu_up() on second (presumably successful) attempt because
> nothing for that VCPU would be initialized. This can in principle be
> fixed by moving allocation to the top of the routine and freeing
> context if the bit in the bitmap is already set.
> 
> 
> Having said that, allocation really should not fail: for PV guests we
> first bring max number of VCPUs up and then offline them down to
> however many need to run. I think if we fail allocation during boot we
> are going to have a really bad day anyway.
> 

So can we keep the patch as-is or are some changes needed?

> -boris

Sebastian
