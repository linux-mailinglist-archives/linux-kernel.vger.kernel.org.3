Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3ECE4C354E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiBXTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiBXTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:05:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F011E374A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:04:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d17so2722258pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wPvD9Gbqoy/qSwZ/Jj2R/mlZJWwVO08mdUGWoTeC1ZI=;
        b=P3yON3e2F3MbMPzXGu/EMsX6wlfjxoTboKHsW3S64YsnexcSvFG1ucFfHWL11kWvav
         OiQxfKB7qkoNybQDJd/X2kEKjuxXaJCkwo+4zB1D2+JJMhpDEOYlyfq+dSIR0PANiLXG
         pOGeMFc1nb/FCM/MfkYIjZ92VONRE02wh7SImG9vNCTEdMS8Jvat2p1ovnZ3k+I/nS+V
         ym40djl+vnzXLR+Wgo4GIJHl+Pm/1P7vEc9RbN896G5JpgOOXGi4+U7qexaxBC1KIeet
         mxiOcvdZ0AAdXf6G3hds/0nQCjFdltFtSMxx/V/qul7PZJayxsOjp0dyLm2Il7QsjCtE
         b8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wPvD9Gbqoy/qSwZ/Jj2R/mlZJWwVO08mdUGWoTeC1ZI=;
        b=vqkWF9AJyczHB0cH1vj0ftnjv89F9nMvFOoAM7jLr3N2oD6zFZJJjdU63qCKIyT6pK
         7QLU/f0QlBmigAdXzbTbaQPI8b6wVnyUe483uzOwsYpkCLYmn6rBzmsouPsiwT+FvmMU
         7zmekFo3/VihGoc1984R+6+Xs4Zrf4oorJOBPUc5QzuVoMHa5mHmpkvzyzNgoee/OwCC
         C+AY6l4Y7Ihr9YQtDKa08CpPLFVtWsMYNvdXog6zftxWuqQpvygXFsqGeRuHk9d06Nhk
         KF4/Okze0HR9cDMPVGAHJ4yIzTxjEYzRr9vOqf36qiNKtGAYlpxIliR4dg/+a2+Q6E6G
         6xrg==
X-Gm-Message-State: AOAM530PVdcWOVPObyWkVHURcWkPY5ICG+ALMTMY6UJpIAfg0rvagDxO
        iouaUOMbhBNPLxYMKbpZbGXl3Q==
X-Google-Smtp-Source: ABdhPJxAmvbetZX6uTkPL9i4aCsT2i5ttGl2YHFTLp1XUUlx+jEgiHHhnC0BmaM3LeB4HByu2wdxsw==
X-Received: by 2002:a65:6201:0:b0:369:4a47:aff1 with SMTP id d1-20020a656201000000b003694a47aff1mr3254756pgv.238.1645729476627;
        Thu, 24 Feb 2022 11:04:36 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e2-20020a056a00162200b004e0a8002697sm209500pfc.123.2022.02.24.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:04:35 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:04:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 09/30] x86/tdx: Add MSR support for TDX guests
Message-ID: <YhfWwHE4nZfQWPCl@google.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-10-kirill.shutemov@linux.intel.com>
 <67dfdb0c-c483-ec3c-4fb8-57086ffde9bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67dfdb0c-c483-ec3c-4fb8-57086ffde9bf@intel.com>
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

On Thu, Feb 24, 2022, Dave Hansen wrote:
> On 2/24/22 07:56, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/coco/tdx.c b/arch/x86/coco/tdx.c
> > index 0a2e6be0cdae..89992593a209 100644
> > --- a/arch/x86/coco/tdx.c
> > +++ b/arch/x86/coco/tdx.c
> > @@ -116,6 +116,44 @@ void __cpuidle tdx_safe_halt(void)
> >  		WARN_ONCE(1, "HLT instruction emulation failed\n");
> >  }
> >  
> > +static bool read_msr(struct pt_regs *regs)
> > +{
> > +	struct tdx_hypercall_args args = {
> > +		.r10 = TDX_HYPERCALL_STANDARD,
> > +		.r11 = EXIT_REASON_MSR_READ,
> 
> Just a minor note: these "EXIT_REASON_FOO"'s in r11 are effectively
> *the* hypercall being made, right?
> 
> The hypercall is being made in response to what would have otherwise
> been a MSR read VMEXIT.  But, it's a *bit* goofy to see them here when
> the TDX guest isn't doing any kind of VMEXIT.

But the TDX guest is doing a VM-Exit, that's all TDCALL is, an exit to the host.
r10 states that this is a GHCI-standard hypercall, r11 holds the reason why the
guest is exiting to the host.  The guest could pretty it up by redefining all the
VM-Exit reasons as TDX_REQUEST_MSR_READ or whatever, but IMO diverging from
directly using EXIT_REASON_* will be annoying in the long run, e.g. will make it
more difficult to grep KVM + kernel to understand the end-to-end flow.
