Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88E4C7217
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiB1RDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238038AbiB1RDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85C41DF4B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646067751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bTJs+XJuztigw3GbZ3t30dvbSAKamp+b28u3hPimDdk=;
        b=DJokzQ5c8Iy0OP7UpQSJKS+AOQaLK+/vhMerDM29W9jogHBmD1bTK+9KaUCTOdppPPzc5g
        4ySixw1XMemtxC/NP/6X8GlnSgCala9EzSn3iLWUEIItxQHk3PxF3iPbNC9odHZdTNhhJC
        h3XpIgDjBaSich67qVAaxu4zXbKEpO4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-4-2kcuvXMD6L1z5-gr9s6g-1; Mon, 28 Feb 2022 12:02:30 -0500
X-MC-Unique: 4-2kcuvXMD6L1z5-gr9s6g-1
Received: by mail-qk1-f197.google.com with SMTP id 2-20020a370a02000000b0060df1ac78baso11619359qkk.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bTJs+XJuztigw3GbZ3t30dvbSAKamp+b28u3hPimDdk=;
        b=unzlS1KDt5Y576Mu4EmW82lYIWJRX8c3paTJikgFvBNL88mssuuswa/30nGX5LAnXN
         zjoViSKaG9XCvWNeDx34q8/LEcajhJ+CIznpff1APR10OAqilgTMeLH6iYR5nuXM1j5O
         hCP4gTY8EoXYGf5vN6VNvMzIbOu8UJ4TLX52tEJ6MF2g+lPJXlEZLukpe8AqASdj4rdG
         DlvLNdf+zvuCqs8SfNohHK718YMsjS3a2JFBuGFYE7OXyAvzq0/taqr6x87E2l1nRnBl
         DKN3pK+7temCxmyvZHN09hgQGf0Q+t5jnoAyxAmYulvjPLlpJNMeknwFA3Ucc9GAIkpK
         cOZw==
X-Gm-Message-State: AOAM532BhV+qzuBhzQ739PKWZUnpxbUmf59xlNSCoyG4fCgSD/HXLzaK
        AWS769FelEpJBePnxi8gBqjSEXtIW/ajYyOSztsXtv1LXrMm1bxNuEVKCy3swyn0BMFuV7IBUZt
        ZdzYNibMT3SmSjr3WSeTlVSHc
X-Received: by 2002:a05:622a:13d0:b0:2de:7076:72ef with SMTP id p16-20020a05622a13d000b002de707672efmr16576284qtk.394.1646067749623;
        Mon, 28 Feb 2022 09:02:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygNruTCrsribOVoPoUO6Evv/v5EGaBw/himskSmDc9znLsXDPafPJNecelMcHhqYRswtO/YA==
X-Received: by 2002:a05:622a:13d0:b0:2de:7076:72ef with SMTP id p16-20020a05622a13d000b002de707672efmr16576233qtk.394.1646067749291;
        Mon, 28 Feb 2022 09:02:29 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id i20-20020ac85c14000000b002de4b6004a7sm7048642qti.27.2022.02.28.09.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 09:02:28 -0800 (PST)
Date:   Mon, 28 Feb 2022 09:02:24 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, sdeep@vmware.com,
        Sean Christopherson <seanjc@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 29/30] ACPICA: Avoid cache flush on TDX guest
Message-ID: <20220228170224.igzvf7e3tc6ujrfq@treble>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-30-kirill.shutemov@linux.intel.com>
 <20220227220526.3rrmy3u7j2xpelcn@treble>
 <CAPcyv4jqHQDhpSE24-Y6amC9Y-z4vVnXy6Lvo1j2hdCvzPACvQ@mail.gmail.com>
 <20220228163713.5eewdwcqhmulsp4z@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228163713.5eewdwcqhmulsp4z@black.fi.intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:37:13PM +0300, Kirill A. Shutemov wrote:
> On Sun, Feb 27, 2022 at 05:34:45PM -0800, Dan Williams wrote:
> > On Sun, Feb 27, 2022 at 2:05 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > On Thu, Feb 24, 2022 at 06:56:29PM +0300, Kirill A. Shutemov wrote:
> > > > +/*
> > > > + * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
> > > > + * It is required to prevent data loss.
> > > > + *
> > > > + * While running inside TDX guest, the kernel can bypass cache flushing.
> > > > + * Changing sleep state in a virtual machine doesn't affect the host system
> > > > + * sleep state and cannot lead to data loss.
> > > > + *
> > > > + * TODO: Is it safe to generalize this from TDX guests to all guest kernels?
> > > > + */
> > > > +#define ACPI_FLUSH_CPU_CACHE()                                       \
> > > > +do {                                                         \
> > > > +     if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))        \
> > > > +             wbinvd();                                       \
> > > > +} while (0)
> > >
> > > If it's safe, why not do it for all VMs?  Is there something specific
> > > about TDX which makes this more obviously known to be safe than for
> > > regular VMs?
> > >
> > > The patch description and the above comment make it sound like "we're
> > > not really sure this is safe, so we'll just use TDX as a testing ground
> > > for the idea." Which doesn't really inspire a lot of confidence in the
> > > stability of TD sleep states.
> > 
> > Agree, why is this marked as "TODO"? The cache flushes associated with
> > ACPI sleep states are to flush cache before bare metal power loss to
> > CPU caches and bare metal transition of DDR in self-refresh mode. If a
> > cache flush is required it is the responsibility of the hypervisor.
> > Either it is safe for all guests or it is unsafe for all guests, not
> > TD specific.
> 
> Do we have "any VM" check? I can't find it right away.

X86_FEATURE_HYPERVISOR

-- 
Josh

