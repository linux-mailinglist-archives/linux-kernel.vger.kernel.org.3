Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3EF4C60A7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 02:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiB1Bff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 20:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiB1Bfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 20:35:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BE1CFEC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 17:34:56 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 12so10131901pgd.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 17:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIyffIPE5uW+7x0QzcqrS5Yl2SHZIM7iPbG8g4ek4L0=;
        b=VzwBPjEqgwTF1Ah+XH4V52nxJKktALZxFenncTNxSGH214R6SsV6iRxFO7YG3DmJfm
         lcop8jVN3alvm85emcrertvGyuKJ1QbAjRVAyYO3UeUP377il86Zy4oIca3X4ia6qcD4
         5yBMpUZrfm6iZVebxuq4B8jmdCfp4D6pnuDp7IP1c9kvOmH4/XnMXQGbFL/9dqIiBioS
         fqxG5tQxjOCOkOmFfcPJ06LurzukHToxwcb2rt0fVHCBSjF57HKPxkv9EbogRdKw76eo
         Rn/Bjya0myKa1bmWy7IBuxdUqiezugFWmmOnRurezbPIsjxZnk3SLIFyb3St9x+XGRLX
         QVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIyffIPE5uW+7x0QzcqrS5Yl2SHZIM7iPbG8g4ek4L0=;
        b=yoNV376RMjsm190Drsj1K1wV338RwKFgiE3tNAGHJIl2d3YAZY+dy50wb9ThSIAmD0
         rfkd+qQCTBcfKbUWpdMHBuk1wXkjruiDDCbqA08MBcXUrCV/o+2iNtEWD9j51G7YxECT
         G8xfBSE/ly177IEqtRy0yUbjAB9OMg55eWQG8r//06DF7+oQ7mQlRrJTz7hWP2c3147L
         +3afl/aB8NCZkqt6shSjEk0MoEfCDCzFJvqKXtn0fL3wX2uppsQzLmmri3cuVAnuQVhO
         i73V76w62yHONRFN7MIU305jW6AznVl3jLuFrIoicc3zwLjhlnBGyA4cg+EUjiI9S8wG
         gP5Q==
X-Gm-Message-State: AOAM530JUre66ecp9nDJMLfYXVJqu39GCxA3phEnx7rJQZu72JWzD5PI
        LvjNrUkkVND9vDR5ZuWRLFucEwJDMP+rSI6XAvC1Yg==
X-Google-Smtp-Source: ABdhPJzc/b7f1v8Piat3OAchkgXH/kRvNPSb2weuf8zYOMhurj68Mde00xC48FaDQAatMP2CliEOL8INXUUdh/TQyDM=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr15522256pgb.74.1646012096510; Sun, 27
 Feb 2022 17:34:56 -0800 (PST)
MIME-Version: 1.0
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-30-kirill.shutemov@linux.intel.com> <20220227220526.3rrmy3u7j2xpelcn@treble>
In-Reply-To: <20220227220526.3rrmy3u7j2xpelcn@treble>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 27 Feb 2022 17:34:45 -0800
Message-ID: <CAPcyv4jqHQDhpSE24-Y6amC9Y-z4vVnXy6Lvo1j2hdCvzPACvQ@mail.gmail.com>
Subject: Re: [PATCHv4 29/30] ACPICA: Avoid cache flush on TDX guest
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 2:05 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Feb 24, 2022 at 06:56:29PM +0300, Kirill A. Shutemov wrote:
> > +/*
> > + * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
> > + * It is required to prevent data loss.
> > + *
> > + * While running inside TDX guest, the kernel can bypass cache flushing.
> > + * Changing sleep state in a virtual machine doesn't affect the host system
> > + * sleep state and cannot lead to data loss.
> > + *
> > + * TODO: Is it safe to generalize this from TDX guests to all guest kernels?
> > + */
> > +#define ACPI_FLUSH_CPU_CACHE()                                       \
> > +do {                                                         \
> > +     if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))        \
> > +             wbinvd();                                       \
> > +} while (0)
>
> If it's safe, why not do it for all VMs?  Is there something specific
> about TDX which makes this more obviously known to be safe than for
> regular VMs?
>
> The patch description and the above comment make it sound like "we're
> not really sure this is safe, so we'll just use TDX as a testing ground
> for the idea." Which doesn't really inspire a lot of confidence in the
> stability of TD sleep states.

Agree, why is this marked as "TODO"? The cache flushes associated with
ACPI sleep states are to flush cache before bare metal power loss to
CPU caches and bare metal transition of DDR in self-refresh mode. If a
cache flush is required it is the responsibility of the hypervisor.
Either it is safe for all guests or it is unsafe for all guests, not
TD specific.
