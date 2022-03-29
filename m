Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B89A4EA404
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 02:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiC2AGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 20:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiC2AGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 20:06:03 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B70E14090
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:04:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id o13so13378078pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=etgjqyAwbvR6Km5d+2cDKN373f0iHJRr9ymO9u+KgK4=;
        b=G5YIvVl22ePZITTXQy7vowBlWgCkZizGIGOI6pI2XX9x6vtJv/N8rYqMnVC1NBJmDl
         Xi+sHsYUIN+SJvKP8OhZ+TiWYKsB4cnA6blgTh8kV07ztljdTDT58Zz7wNd5brW8jMKi
         MeGC0zhst3Ze45rOieg8y/L1qR1ehb0uYXPOVkW1do58sPgFqUFnszIPRO9ZxP9E/VDu
         Hg6Vj8ktwcYNsYL0mPC653HM7uXxVOtZT2l2L6hyenJnUzEd16GnIxOc9EHXvkyvvGnf
         OmD5GfIZ3n5oGbfX95H+OgOqSCiAjQRN+aczvRBQ7z8EFIt+C0RkUgE4xiw6oc4aMGhH
         c2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=etgjqyAwbvR6Km5d+2cDKN373f0iHJRr9ymO9u+KgK4=;
        b=pF2UWWhLXmUHFE1EpXbMvWdx+Q5ChG1mfeGqmIFp5BWUCgiPFLuR4pXQwAHinlpvR3
         aT2/EbY+ah5JIPxwM2gvJ6r5YqCXVdGhvVlOt3H5CVJs8Omw7fICXgFSMwp5xiyY79MS
         +Gj7m9+1vTaR/71GhRC0GllWY17ZN80/8oCDqDxuE4tLI5SJS2y3AOiDgbKetRgmOjJj
         ESUX5Bx/feFkaFcccIXz8kv35ooTvZ8YTud7fA1Wg46IGDJgg0zp8FA7B4ItnRVVFYw3
         xyH1kcH5XQwo15S+hNwemYqwUVBtVoTOqrSKsOML+NNE3K79haDWZqJBqxQNUkpwEDW/
         QbmA==
X-Gm-Message-State: AOAM5325LvCzfUunnCZupglVVWn4pDKWqzUQt1xnMxikkFHEzFpeKBtC
        oBM7Qzd9vf3VbdqEA1NIvg4d9A==
X-Google-Smtp-Source: ABdhPJx8yKtkbTnvKDhEF6CrTpFMthUus1w5B4uh8qOQh+zUkITN5OLbQQgaCn3E+3ynmkMH71yJkQ==
X-Received: by 2002:a63:e545:0:b0:382:8dd9:a870 with SMTP id z5-20020a63e545000000b003828dd9a870mr11790668pgj.621.1648512260958;
        Mon, 28 Mar 2022 17:04:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm14336170pgc.50.2022.03.28.17.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:04:20 -0700 (PDT)
Date:   Tue, 29 Mar 2022 00:04:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Nakajima, Jun" <jun.nakajima@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YkJNAPPpdiL24kJF@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <CALCETrWk1Y47JQC=V028A7Tmc9776Oo4AjgwqRtd9K=XDh6=TA@mail.gmail.com>
 <7CCE5220-0ACF-48EE-9366-93CABDA91065@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7CCE5220-0ACF-48EE-9366-93CABDA91065@intel.com>
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

On Mon, Mar 28, 2022, Nakajima, Jun wrote:
> > On Mar 28, 2022, at 1:16 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > 
> > On Thu, Mar 10, 2022 at 6:09 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >> 
> >> This is the v5 of this series which tries to implement the fd-based KVM
> >> guest private memory. The patches are based on latest kvm/queue branch
> >> commit:
> >> 
> >>  d5089416b7fb KVM: x86: Introduce KVM_CAP_DISABLE_QUIRKS2
> > 
> > Can this series be run and a VM booted without TDX?  A feature like
> > that might help push it forward.
> > 
> > —Andy
> 
> Since the userspace VMM (e.g. QEMU) loses direct access to private memory of
> the VM, the guest needs to avoid using the private memory for (virtual) DMA
> buffers, for example. Otherwise, it would need to use bounce buffers, i.e. we
> would need changes to the VM. I think we can try that (i.e. add only bounce
> buffer changes). What do you think?

I would love to be able to test this series and run full-blown VMs without TDX or
SEV hardware.

The other option for getting test coverage is KVM selftests, which don't have an
existing guest that needs to be enlightened.  Vishal is doing work on that front,
though I think it's still in early stages.  Long term, selftests will also be great
for negative testing.
