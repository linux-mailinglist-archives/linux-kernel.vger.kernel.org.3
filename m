Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60F4CAF47
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiCBUDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbiCBUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:03:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DCABC2E5D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646251338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hn1e9X41jttyWFqKn07DP5DSUPrF8cBnA/ursM1B4+g=;
        b=YmBiEwHCWC94LkG0qxk+9VzYQ347HKeJ4EujXJfT2V82sgXKRg3MyemgBiuy3mGMqtghqc
        NR/6uRlQuiElV7ZN4nVi/P+NYGgCVSZi8J+lApzPKISI7SvGz7KxfMdFJUGHnYxePCQlAW
        DkJCX5JzWdkXM4IwMwglGPcCTGIvSmI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-ThIEuGdjM0-36lGlJEQctA-1; Wed, 02 Mar 2022 15:02:17 -0500
X-MC-Unique: ThIEuGdjM0-36lGlJEQctA-1
Received: by mail-qt1-f198.google.com with SMTP id w15-20020a05622a190f00b002dda0988c11so2102714qtc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hn1e9X41jttyWFqKn07DP5DSUPrF8cBnA/ursM1B4+g=;
        b=Gz7G45WrGMU3iPPAJOe1tCtwPMc8GUz0ehNnVZe8+WxhazXVmhVD1OnVyLDO2bO1ls
         qtzjyp1AkhkPGx9GsZ5FnVdCWbm382TSP894pyKdBuG+t5MDZvuYYkzA5iEkZYf59Ldg
         nDjHcNkdULZkcV3T8U2C/gEEs9Fe94qmnxYupD5j1uFiuxX2Ml3+fJTNj+uGNnvnQnqe
         YfKfeC8a8us6NE3TqoiSkoubU8h8KFjnXHDsD3tDb6IellF49gaKocRK5PyfrANvpoNB
         8N5LhX3q3v+wDD0Y0drZhBaQ80wYuIh2uouk5sLjxu5r52zbJ28A+hBaLjWyfJAb6ED2
         5a5A==
X-Gm-Message-State: AOAM533qGuO8M0dNDEiOSRvfepNwqT7tXKZB2Bo1LrQqBzpl+VtR/oeC
        derAzIoMA015n5EDcFOF6bEdh5QUSnFL8SC8klisbHoqJfdDKOcVB1/Z4YxfiR77np7DWQNvAqN
        s9xdz01P1rjo/w0k0pbmGTQ2c
X-Received: by 2002:a05:622a:138b:b0:2de:29bf:7a09 with SMTP id o11-20020a05622a138b00b002de29bf7a09mr24787293qtk.479.1646251336749;
        Wed, 02 Mar 2022 12:02:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxWY55RST4VgamC5l5bwHQHdjtWFYEboYwzkIdSZF4QYa8WAJslxwICJC1GWpIXwN0l/tZ4Q==
X-Received: by 2002:a05:622a:138b:b0:2de:29bf:7a09 with SMTP id o11-20020a05622a138b00b002de29bf7a09mr24787202qtk.479.1646251335932;
        Wed, 02 Mar 2022 12:02:15 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id u12-20020ae9c00c000000b0047c98aa41casm8391638qkk.94.2022.03.02.12.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:02:15 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:02:10 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCHv5 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
Message-ID: <20220302200210.3f7bprgsoy5xnhdh@treble>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-16-kirill.shutemov@linux.intel.com>
 <20220302174210.q5r6zl2lsa6hut6q@treble>
 <6adfbd21-142d-5fe3-41c9-fb2996c9452a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6adfbd21-142d-5fe3-41c9-fb2996c9452a@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 11:41:53AM -0800, Dave Hansen wrote:
> On 3/2/22 09:42, Josh Poimboeuf wrote:
> > At the very least, please remove the ability for future code to> accidentally bypass 'pio_ops'.  Going forward, are we really expected
> to> just remember to always use pio_ops for i/o?  Or else TDX will just>
> silently break?  That's just not acceptable.
> What did you have in mind here?  The in/out() instruction wrappers could
> be moved to a spot where they're impossible to call directly, for instance.

I guess, though why not just put the pio_ops crud in the inb/outb
wrappers themselves?

> I guess we could get really fancy and use objtool to look for any I/O
> instructions that show up outside of the "official" pio_ops copies.
> That would prevent anyone using inline assembly.

Yeah, there's no easy solution for asm and inline asm.  We would need
something like objtool to enforce the new "non-direct-i/o" policy in
boot code.  But objtool doesn't even validate boot code.

And it looks this patch missed an "outb"?

static inline void io_delay(void)
{
	const u16 DELAY_PORT = 0x80;
	asm volatile("outb %%al,%0" : : "dN" (DELAY_PORT));
}

> In the end, though, TDX *is* a new sub-architecture.  There are lots of
> ways it's going to break silently and nobody will notice on bare metal.
>  SEV is the same way with things like the C (encryption) bit in the page
> tables.  Adding more safeguards sounds like a good idea but, in the end,
> we're going to have to find the non-obvious issues with testing.

Right, but for this case there's no reason to destabilize TDX on
purpose.

-- 
Josh

