Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD549A130
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1850162AbiAXX1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588113AbiAXWb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:31:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A7C047CD4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:55:58 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643057757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ewg7Dhv9g66Ay9i+CemB/iAHIgq8aLwWkreYxw8kj/g=;
        b=lKXSQDPRwtX3JbI5kY4OS0NvZR/TtL6HQvc1pAby9EDjOYmhD5/59olQqxj2uLie0QcmXD
        122jSktPVHZZZXrwOHEgRzWf0nL0CBHeDPrSnDDr8HDOszOc/HBm5rmP9RF+gXhBjXTn5t
        BOt4I8USw4ZZZYWMNLOZPfxrxIWpgrJJfyajfFitSwYv2H6JgoZMgt5ENKQsfH3WtPxwrh
        X891rpgKH/dqXmcZFOicjJ/6jhZv/n7K819/xU9XoTJJJG0UmRxK0IBf2I1GcI+nlIFdYZ
        hcAXac4/1ZFqNnIiV/DS6ITtBOgFtesQaRMiqKByg+iV2ltmyDTXH+IW24cw5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643057757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ewg7Dhv9g66Ay9i+CemB/iAHIgq8aLwWkreYxw8kj/g=;
        b=G3ENNrBjyqKPwM/QWySmB1I+RO6YHoUmLNztYTPsSSISUX2jBvJ6FDZadlS6OF25uukxWG
        XkpauCr0fKJ7TtCA==
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
In-Reply-To: <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com> <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx> <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
Date:   Mon, 24 Jan 2022 21:55:56 +0100
Message-ID: <878rv46eg3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 12:52, Fenghua Yu wrote:
> On Mon, Jan 24, 2022 at 09:36:00PM +0100, Thomas Gleixner wrote:
>> On Mon, Jan 24 2022 at 21:21, Thomas Gleixner wrote:
> Ah. This patch should remove ioasid_get(). So I will change this patch
> as follows:
>
> 1. Remove ioasid_get() because it's not used any more when IOASID's
>    refcount is set to 1 once the IOASID is allocated and is freed on mm exit.
> 2. Change mm_pasid_get() to mm_pasid_set().

Yes. Just resend this one. No need to post the full queue again.

Thanks,

        tglx
