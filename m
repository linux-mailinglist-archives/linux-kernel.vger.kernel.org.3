Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EE4DCA06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbiCQPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiCQPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:34:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894C208C2D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:32:50 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n15so4763158plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnPiewiTmn5iKj7tv6YyXKcFYclFsk36ptIecBJ8qYw=;
        b=s/z6/SWEMrGSkgPqxHXiGu4Z5wuN0408LIBkkxWyr/DtH9662uvtRvJ+NeWlGvaUCw
         2Q1NzrDo3uEu3fUgvbSWVxghMV3dALlHH/0ZvvXrthrmkLFAoJokILmuoaHTFRbAZeta
         mj6WETnZnUYPlH10aqh0c7fRRboLZCJMglgtMgYH4YAmK1NTRS5QbdG1spBF69gfodtl
         w3YyT6MssVTsBV+0Ip48QjWAOvzn/25nVJ5yifmWjfFwvz/wMjGhUxxVvzGYWs84ar2Q
         eOBHrYNZ1qTv5HI5OqPwsgeeNqRKtQLEKhrK1uhOzzEMNW3QTUEkqJY029P41mRcuTUn
         Rr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnPiewiTmn5iKj7tv6YyXKcFYclFsk36ptIecBJ8qYw=;
        b=XfNrePSbhOLGBACLZxhAcfMMeaPdRC4lHTugnKcroHkGH0ewNapM5MA3v2YqNkEPJ5
         JL10EH7GcCGB7CykBtgJ14FT/K1RPVpZtyz+HiGycR4Ag/WdjR8D4Gcz+pE3JhOoolzx
         I1qtoHMUK0aScjJnJwOCMapGBEKTZopxpFQRXYueyJv/PbFBdOo4OXHwXs9+awGTUK4I
         97gVfitkEXmEG2iMsnA12VFuFUGLujaKbA7smYzCyf0sfFmNDIpVF0kePu+hZOhQQu59
         EnSHMecQLisyk93Uf5TGW2CxOHcqIv6uf6KjeMtbV43zq7PgTC2KdylefRpSu97Sg6O8
         xFzg==
X-Gm-Message-State: AOAM532LVe2xG5ODPdPUgZcAOdRlCM/XsknU+VTniX4BEnMOq35ZhZoC
        8cs8veLbnnQfj/eIlvM1GezWu+G1p99XaBmolP5IEA==
X-Google-Smtp-Source: ABdhPJz0vY/sonzlwd8zKFAyz+RKh4/TJBEXP4Xs9IlBbNdO7Hih1mT1AbluhuJRxwhy4Dr3EwKWwrVmlQsltRMCiL0=
X-Received: by 2002:a17:902:d504:b0:154:172:3677 with SMTP id
 b4-20020a170902d50400b0015401723677mr1307643plg.147.1647531169689; Thu, 17
 Mar 2022 08:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-30-kirill.shutemov@linux.intel.com> <f60f4310-8a03-2fdb-d495-be2658f08abe@intel.com>
In-Reply-To: <f60f4310-8a03-2fdb-d495-be2658f08abe@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Mar 2022 08:32:39 -0700
Message-ID: <CAPcyv4gfVfCNZKhc3aUU1+TyaSpxSMeuiqVxK1V2i3O6HVspcg@mail.gmail.com>
Subject: Re: [PATCHv6 29/30] ACPICA: Avoid cache flush inside virtual machines
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, sdeep@vmware.com,
        Sean Christopherson <seanjc@google.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 3:13 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 3/15/22 19:08, Kirill A. Shutemov wrote:
> > While running inside virtual machine, the kernel can bypass cache
> > flushing. Changing sleep state in a virtual machine doesn't affect the
> > host system sleep state and cannot lead to data loss.
> >
> > Before entering sleep states, the ACPI code flushes caches to prevent
> > data loss using the WBINVD instruction.  This mechanism is required on
> > bare metal.
> >
> > But, any use WBINVD inside of a guest is worthless.  Changing sleep
> > state in a virtual machine doesn't affect the host system sleep state
> > and cannot lead to data loss, so most hypervisors simply ignore it.
> > Despite this, the ACPI code calls WBINVD unconditionally anyway.
> > It's useless, but also normally harmless.
> >
> > In TDX guests, though, WBINVD stops being harmless; it triggers a
> > virtualization exception (#VE).  If the ACPI cache-flushing WBINVD
> > were left in place, TDX guests would need handling to recover from
> > the exception.
> >
> > Avoid using WBINVD whenever running under a hypervisor.  This both
> > removes the useless WBINVDs and saves TDX from implementing WBINVD
> > handling.
>
> Looks good.  Did you have more acks on this earlier that got removed?  I
> thought I remembered more acks on earlier versions.
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Yeah, my previous reviewed-by still stands:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
