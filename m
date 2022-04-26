Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED350F7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbiDZJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345693AbiDZI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:56:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0930BDC591
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:41:18 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 947631EC04A6;
        Tue, 26 Apr 2022 10:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650962472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WDgzj5odytfvHWYC79oVcVHBLZLoY6i/6Y3HutpD6F4=;
        b=RNjGzXao8IjCAZdnyz+sxuWaGQkZ/vd2mBMQcXkorVlHxF8aZwOhjFv4yzyb07IC1cWtdD
        ULYpgmsRwGJlrKq9s0lT+lGWYaOvYXAN7z6VNXS1lWrwLuV/e11t2Bk/YoGWr2WZKy1VVj
        Dqp/f/bCRwbcGI72KlCyWMGc2WUv3AY=
Date:   Tue, 26 Apr 2022 10:41:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Oleksandr <olekstysh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access
 under Xen
Message-ID: <YmewJaxWS1KGVkTf@zn.tnic>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
 <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
 <YmQsFb36UEH9BUnN@infradead.org>
 <6c5042fe-dafc-eb4f-c1fa-03b0faf252de@gmail.com>
 <abc5d23d-3d38-d198-4646-e886df2e83d4@suse.com>
 <YmZUpua3hkCPdbfx@infradead.org>
 <147f68f6-7d67-1884-bd14-5040639b3396@suse.com>
 <67c7460a-3001-35a6-8e5b-f367270b257a@gmail.com>
 <YmcR5bfaYh1z7VUq@zn.tnic>
 <7d89848a-3a1c-415d-957a-564ffdd3712d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d89848a-3a1c-415d-957a-564ffdd3712d@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 07:16:16AM +0200, Juergen Gross wrote:
> Christoph suggested (rather firmly) this would be the way to go.

Yeah, I saw it but I don't think it is the right way to go.

What happens the next time a guest needs to query the platform
underneath? Misuse these interfaces again?

Because people will see the Xen use and say, hey, look, I will use this
for my funky HV too.

Even worse: what happens if Xen decides to implement SEV/TDX? Then
you're in for a world of fun.

Now, if we want to *extend* the interfaces to have something as generic
as, say, platform_has() and that should be the way for generic kernel
code running in the guest to query the platform capabilities, then sure,
by all means.

> This is needed on guest side at a rather hypervisor independent place.
> 
> So a capability of some sort seems appropriate.
> 
> Another suggestion of mine was to have a callback (or flag) in
> struct x86_hyper_runtime for that purpose.

This becomes an issue if the HV is not x86 - then you need a different
method of querying it, which then underneath will call the arch-specific
interface.

I don't know how much of querying guests need to do and how they've been
doing that so far. Depending on the requirements, we probably should
think about a clean design from the get-go instead of homegrown things.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
