Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762A64AFE02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiBIUIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:08:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBIUH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:07:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5FE079D0C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:07:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so6241397pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2Zrre00TNTEedxC/ZG0lSRvO9PMNVjhgf6zFope9rg=;
        b=OSs6kNg2PSSA7aVcIkUpDfbe+Qg5Cezsu9BBK4ruy1EEvba5x35rMDkGALUUeHvQu4
         0j7Nay1LsagRugHsqNCRJBJp0u97bnDfw1Vxg/iXKnf/3SxGTEBBAkcEKgfTE9AKHE1L
         Y2wj4NnmpJvWJLY0UyhkNyrzxqYDeYYstEuV4tAX6H0gfrWUgMkqL1F8bowFYXKLyh86
         AQhbcs9E0GlP5ueJdVL/Uj8pqcDBz0ZnWtU3F3eXCCCE/llFm7U5AEZD9UymboV62msZ
         nmm6WBHal3C58wvY4W8IMr+pYTqJOMZ5Pp7rgZdMdKxmOHDQzvV7rIFo1qn0xpL+5jR0
         kVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2Zrre00TNTEedxC/ZG0lSRvO9PMNVjhgf6zFope9rg=;
        b=TYSW/9LNdq+hc0IVqO+iGHGOoSwRZp8HljlKoxHe+iJUKdoQe0kwP0S8MiyfFJFBt9
         Rd2uL2iBO1BnFvv9iZw5n+h+u93jEGgxsoihBnNU4Qxoe5TcEfvuVGN8xjAEboKDzMcb
         h6gTmLa4oWNxnJXDE20NJJeAVTGmVdR/G9A+fD+qFVfpQgmMKnymvfxn2njnWMxhOomu
         XiqPBoF4Wp1zt5rwLHt/npaSIzUDMT3c7/Rd0lCPg8oIL6iErNswHMAdlB6eA4RXCVCP
         SNYD3/fgfRGKKIjAO5TpF6pbYyJLjh39K8sFDQCytaRIpIrO2KVniRf5FPkzwsDt65kn
         /cQA==
X-Gm-Message-State: AOAM5330UHQe5sRZX83Hq4HITdM1+0cAR/JbjcRuvWrw0puYr5TgnGWl
        hZZyUVq8YOxaYKKr9uc7NjYRoA==
X-Google-Smtp-Source: ABdhPJw3MqX0zAdYK1YOj194RLs5MpvuyRtdTTvZ3txUns9HbZyHiO1Ck4eNT+SQfSz4jxAa2OZ33w==
X-Received: by 2002:a17:902:e74e:: with SMTP id p14mr3838573plf.95.1644437276682;
        Wed, 09 Feb 2022 12:07:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id kk17sm7374060pjb.21.2022.02.09.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:07:56 -0800 (PST)
Date:   Wed, 9 Feb 2022 20:07:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <YgQfGKXOemtXnFau@google.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220209235613.652f5720cd196331d7a220ec@intel.com>
 <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgQR/S67Fqz9PanR@zn.tnic>
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

On Wed, Feb 09, 2022, Borislav Petkov wrote:
> On Wed, Feb 09, 2022 at 04:50:08PM +0000, Sean Christopherson wrote:
> > An alternative idea would be to mirror what generic KVM does (virt/kvm/), and do:
> > 
> >   arch/x86/coco/<guest stuff>
> >   arch/x86/virt/<"generic" x86 host virtualization stuff>
> >   arch/x86/virt/coco/<host coco stuff>
> >   arch/x86/virt/kvm/
> > 
> > Though I can already hear the stable trees and downstream kernels crying out in
> > horror at moving arch/x86/kvm :-)
> 
> Hmmm, so I am still thinking about guest-only when we're talking about
> arch/x86/coco/.
> 
> Lemme look at the other virt things:
> 
> the kvm host virt stuff is in:
> 
> arch/x86/kvm/
> 
>  (btw, this is where the SEV host stuff is: arch/x86/kvm/svm/sev.c)
> 
> arch/x86/hyperv/ - looks like hyperv guest stuff
> 
> arch/x86/xen/ - xen guest stuff
> 
> arch/x86/kernel/cpu/vmware.c - vmware guest stuff
> 
> arch/x86/kernel/cpu/acrn.c - Acorn guest stuff
> 
> So we have a real mess. :-(

Don't forget :-)

  arch/x86/kernel/kvm.c - KVM guest stuff

> Not surprised though. So that last thing you're suggesting kinda makes
> sense but lemme tweak it a bit:
> 
> arch/x86/coco/<guest stuff>
> arch/x86/virt/<"generic" x86 host virtualization stuff>
> arch/x86/virt/tdx/ - no need for the "coco" thing - TDX is nothing but coco. TDX host
> stuff
> 
> arch/x86/virt/sev/ - ditto
> 
> and we'll keep arch/x86/kvm because of previous precedents with other
> things I've enumerated above.
> 
> Hmmm?

No objection to omitting "coco".  Though what about using "vmx" and "svm" instead
of "tdx" and "sev".  We lose the more explicit tie to coco, but it would mirror the
sub-directories in arch/x86/kvm/ and would avoid a mess in the scenario where tdx
or sev needs to share code with the non-coco side, e.g. I'm guessing TDX will need
to do VMXON.

  arch/x86/virt/vmx/
  	tdx.c
	vmx.c

  arch/x86/virt/svm/
  	sev.c
	sev-es.c
	sev-snp.c
  	svm.c

