Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3814ACCEC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiBHBFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343686AbiBGXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:48:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC785C06109E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:48:16 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v4so8611486pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DmAjZsfccwaVaNtes6EmfPZ2rG4blpFc0pyFaBFNy/c=;
        b=O48QwLhH9/EyfzfbZFDBuyW7NgAxpUfsKFo77vRIIp/J97PxXdR/Nfj2Q5oBXNcuPo
         Jf+QknfQrGr7pgD1rVD/n/xLnaeB/v8ecoI8tICXQpFrYlc8ZMljeCsh4aBWr+MUr3+G
         Z+isaq63CF1Tym+PBdMK6+axq9i8a6odmcOzGYnYQtwotEiike8g+3qsd0ovrJL+iHr9
         IRWBaGik6wVgAJ2agrzQUCGB/xt89X7wnTl3AQVzdoaewv8FDh3sJaMY7Az0F+paU4cv
         ZGtrP1Ka76pG+mtfqeJGLgKYnsm2YYJsLXjwUbqakndlRzflCo3MlbsGS63DJb4uRxOi
         pbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmAjZsfccwaVaNtes6EmfPZ2rG4blpFc0pyFaBFNy/c=;
        b=vGFAdAyuBbt1HLqzvSVRJstaJlUBfJd2bV/UQgxLB7XjqEmb6g2mbA2gpI8Xa6p/Mb
         UlG+wFeVvHW1llRWMTGl8MgnDDzUTT8qKYj/MFNObv/UZRfyNuPZxxM0zFM5fM8xTXbe
         eblHQU7zzDBo6AaIrGroyMwOK+C983lRG8hUWiQ4rkzp/sPfGvj/GYPp15P1c1cGuEAV
         ylim0WCpEzpYIjaWhxy040HwSaCLqf7HgI0B/7LX+D6ZAf2qMdXKZszEUR14+2ugvEN9
         WbU+LznLwzsVymCF8YzHrp0+EMypPnOUjzeDIDra+yg8lIZ/oRQZ4oH/VS8Vcwp7rvbs
         9wrA==
X-Gm-Message-State: AOAM5321gsSFgNuuwad/tvfOQrzpZiTG3R8htP2HSSML6lnRlNnj/T0a
        0lOyxkH+/EonAlX9PHA+6ZicsA==
X-Google-Smtp-Source: ABdhPJxqxfPIQtuam5GkZBepPAbS7V0Q8IGPcsrc+Vbtsq0AWBZ7iKtmXQsqTlN6H1uGOVjInIYmRw==
X-Received: by 2002:a17:902:d487:: with SMTP id c7mr2089230plg.0.1644277695967;
        Mon, 07 Feb 2022 15:48:15 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u18sm13306160pfk.14.2022.02.07.15.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:48:15 -0800 (PST)
Date:   Mon, 7 Feb 2022 23:48:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 30/43] KVM: SEV: Add documentation for SEV-SNP CPUID
 Enforcement
Message-ID: <YgGvu1BsYP9cihwh@google.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-31-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128171804.569796-31-brijesh.singh@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> Update the documentation with SEV-SNP CPUID enforcement.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  .../virt/kvm/amd-memory-encryption.rst        | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
> index 1c6847fff304..0c72f44cc11a 100644
> --- a/Documentation/virt/kvm/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/amd-memory-encryption.rst

This doc is specifically for KVM's host-side implemenation, whereas the below is
(a) mostly targeted at the guest and (b) has nothing to do with KVM.

Documentation/x86/amd-memory-encryption.rst isn't a great fit either.

Since TDX will need a fair bit of documentation, and SEV-ES could retroactively
use docs as well, what about adding a sub-directory:

	Documentation/virt/confidential_compute

to match the "cc_platform_has" stuffr, and then we can add sev.rst and tdx.rst
there?  Or sev-es.rst, sev-snp.rst, etc... if we want to split things up more.

It might be worth extracting the SEV details from x86/amd-memory-encryption.rst
into virt/ as well.  A big chunk of that file appears to be SEV specific, and it
appears to have gotten a little out-of-whack.  E.g. this section no longer makes
sense as the last paragraph below appears to be talking about SME (bit 23 in MSR
0xc0010010), but walking back "this bit" would reference SEV.  I suspect a
mostly-standalone sev.rst would be easier to follow than an intertwined SME+SEV.

  If support for SME is present, MSR 0xc00100010 (MSR_AMD64_SYSCFG) can be used to
  determine if SME is enabled and/or to enable memory encryption::

          0xc0010010:
                  Bit[23]   0 = memory encryption features are disabled
                            1 = memory encryption features are enabled

  If SEV is supported, MSR 0xc0010131 (MSR_AMD64_SEV) can be used to determine if
  SEV is active::

          0xc0010131:
                  Bit[0]    0 = memory encryption is not active
                            1 = memory encryption is active

  Linux relies on BIOS to set this bit if BIOS has determined that the reduction
  in the physical address space as a result of enabling memory encryption (see
  CPUID information above) will not conflict with the address space resource
  requirements for the system.  If this bit is not set upon Linux startup then
  Linux itself will not set it and memory encryption will not be possible.
