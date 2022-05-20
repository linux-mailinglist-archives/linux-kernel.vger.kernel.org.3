Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31952F398
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 21:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353165AbiETTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353149AbiETTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 15:00:55 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1E3C738
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:00:54 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v10so8456505pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SLhpiwUzGg74rvz2i9jdfYcoP7QfcAfH5acSfb9UyLk=;
        b=jO5DbYf++IXBnckF9Jhr/d2FabNt9kEG3A6iLrI02P7pvLOocUCGczpyGTaGnFFyoV
         tt5taci3wmuG6vlqbc2f1NDubU4Z7JlSyb/0Lja1QsSEBPchDyprMBtaGg29oJDs7bEo
         qFX9H8I4glYV5tUeGNQj0e4wMAXrC12F8yGe+1C8IVx483u4yG9EQSOqd2M/XunWUeh7
         mhS/kCAgWve2V9kJha5VKgvhaK0mFO9a1jBre+YDm7c+WItxdrYBmrOft0M6QuI40JHF
         p1lfti9VLSryzrD7O5kyFCu+faWj7KciOE14yfNal355Qv0k2R22nIMUFOI59HpIJUDS
         aDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SLhpiwUzGg74rvz2i9jdfYcoP7QfcAfH5acSfb9UyLk=;
        b=ev2KhL+OqEQ4BXEb3FLN1vhbavb2xMaLZaBRROi4RhsnGY05OJEbMYYLUi5uGkP7VN
         fBTx7uJUNcUqS3SXkBk9e3tedrp7/sMPArYNMPAAoRZx555UduPYaB8hZQOMEF1SEirq
         VJcO4Q3KJfB3D8W9uon/481pBcnX1bDZuN7XeaH95KFMUtSL0hKOwR3TUKl6QrUbg+k8
         72xAdmkUeZA1y7aIApLSPG4rWTI9Wf9VcLjIIaE1mU5oqXedVLnQb6vAOy6Odo51ZXri
         Ewr2F9pQt0BBkr5niVehtyVrZNJjeskCyJj/B4fM0+MShaeCwwbWy64wrpBWJtZyXUvZ
         JV0A==
X-Gm-Message-State: AOAM533XLPRhctw7FhIB6ZpW0xeJQpFxHLXEmcQg1wgN3Fv3gBPeVK/b
        9aa+2maduduWQn+3HoyIa3aprA==
X-Google-Smtp-Source: ABdhPJyoldqb08E4bwvPijzVVn1NoOuF1/pWcZHWGeHqjM4mS1FkRMVCGDy315rzZryVv/FRMmq8ow==
X-Received: by 2002:a63:4f4a:0:b0:3f5:d2b1:8dc4 with SMTP id p10-20020a634f4a000000b003f5d2b18dc4mr9722151pgl.106.1653073254001;
        Fri, 20 May 2022 12:00:54 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id bo4-20020a056a000e8400b0050dc76281e2sm2076643pfb.188.2022.05.20.12.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:00:52 -0700 (PDT)
Date:   Fri, 20 May 2022 19:00:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv2 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <YoflYI6AACAqAt9l@google.com>
References: <20220520031316.47722-1-kirill.shutemov@linux.intel.com>
 <20220520031316.47722-4-kirill.shutemov@linux.intel.com>
 <YofUMlc3ORYZ8if7@google.com>
 <20220520184335.oygw2q3rov2go45b@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520184335.oygw2q3rov2go45b@black.fi.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022, Kirill A. Shutemov wrote:
> On Fri, May 20, 2022 at 05:47:30PM +0000, Sean Christopherson wrote:
> > On Fri, May 20, 2022, Kirill A. Shutemov wrote:
> > > @@ -299,6 +301,24 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
> > >  	if (WARN_ON_ONCE(user_mode(regs)))
> > >  		return -EFAULT;
> > >  
> > > +	/*
> > > +	 * load_unaligned_zeropad() relies on exception fixups in case of the
> > > +	 * word being a page-crosser and the second page is not accessible.
> > > +	 *
> > > +	 * In TDX guests, the second page can be shared page and VMM may
> > > +	 * configure it to trigger #VE.
> > > +	 *
> > > +	 * Kernel assumes that #VE on a shared page is MMIO access and tries to
> > > +	 * decode instruction to handle it. In case of load_unaligned_zeropad()
> > > +	 * it may result in confusion as it is not MMIO access.
> > 
> > The guest kernel can't know that it's not "MMIO", e.g. nothing prevents the host
> > from manually serving accesses to some chunk of shared memory instead of backing
> > the shared chunk with host DRAM.
> 
> It would require the guest to access shared memory only with instructions
> that we can deal with. I don't think we have such guarantee.

Ya, it's purely thoereticaly behavior.  But panicking if the kernel can't decode
the instruction is really all the guest can do.

> > > +	 * Check fixup table before trying to handle MMIO.
> > 
> > This ordering is wrong, fixup should be done if and only if the instruction truly
> > "faults".  E.g. if there's an MMIO access lurking in the kernel that is wrapped in
> > exception fixup, then this will break that usage and provide garbage data on a read
> > and drop any write.
> 
> When I tried to trigger the bug, the #VE actually succeed, because
> load_unaligned_zeropad() uses instruction we can decode. But due
> misalignment, the part of that came from non-shared page got overwritten
> with data that came from VMM.

That's a bug in the emulation then.  I.e. it needs to deal with page splits.

> I guess we can try to detect misaligned accesses and handle them
> correctly. But it gets complicated and easer to screw up.

At a minimum, it should reject EPT violation #VEs that split pages (on either side).
That's needed irrespective of fixup, e.g. if there's a bug in there kernel that
results in splitting an MMIO region, then panicking is better than data corruption.

Then the post-failure fixup will work, i.e. the load_unaligned_zeropad() will work
like you intend here, without risking spurious fixup.
 
> Do we ever use exception fixups for MMIO accesses to justify the
> complication?

It's essentially impossible to prove because identifying all the MMIO accesses in
the kernel (and drivers!) is extremely difficult, e.g. see the I/O APIC code which
uses a struct to overlay MMIO.
