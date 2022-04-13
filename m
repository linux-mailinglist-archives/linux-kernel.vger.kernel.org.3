Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD44FF5AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiDMLbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:31:13 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB622E0E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:28:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r18so1840782ljp.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUUekrDlUbpLzqCYZThT9IACZ/bhP9YbCkxyRYsnt0M=;
        b=V77k8E7Go3c8YgfJi/4I+GJLJ3R1Ys5kruzKXCtk0nFXouJqhvePll1fbbkEYKm4xE
         YZrPlOCZh1vT1ty2JRsb1q3yzq1gS41FCsaSb12OiKKOx4NuZfOFn2tiW3ZyDLpnkLol
         z/5xTZZFsq779P9UL/51P/kj0Yy27y90jD57djNGhrQe4VbfTsbIts3LHe3e10niAfMT
         r4NXtQ2WRuyeH3aB4lkLSnwkQ8N+bbhywkriHTKGY3tA5I7YQkLc724yGbpeFQb7ksL4
         K/dyrtA5OEsrhyOKLjTmBwSt/gJIKYRRmbL097G33skgKs0CTrL8hELIDbRO21I75giq
         DLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUUekrDlUbpLzqCYZThT9IACZ/bhP9YbCkxyRYsnt0M=;
        b=UadJoR5Cs7b0gVnXNYT+oZDbhX8Npp0yTeVeriDFHuzlKujx6F/NMgNd/Xf3D7WWnQ
         xNyI9F+E/3+sDxHk3oZWAHbHYrq90bcVxffzA0IH53yLZA7csL0cAPAtzmxQtG5vJ11a
         ypiwYqTepsSImQK9/jI8tGGamJcmuof5YEDfQDfbTHbHJ0QXBDW08sR2WeY6D4qPBY2s
         YS5zPr2oyWGCAEHlljoNRA4V+RPT7fp59CtA9eLhrsljwA+Cpn0aNmuIL6gygMh0aUHv
         NWe8GmWmcKd6UESOVurmG7JUoeTHWWCRkgK4/EZVfdDhOKs2zpUvKkz1rB6t+38py+zA
         ZDRQ==
X-Gm-Message-State: AOAM533HWcMoUd+LIiZAvuZ3m2vdmWN0Iwkyxq0v+Qa+ECqArwydBlan
        KktMWtWNXS35t3Dch/nvv0z49A==
X-Google-Smtp-Source: ABdhPJxSObsbRGCRh062l829m9u3AS2rxM/okBiCDA0bzG2WiNog7zUZUyoVbejKOKZm5Tmo3sYdQw==
X-Received: by 2002:a2e:b008:0:b0:24b:4ff2:5e09 with SMTP id y8-20020a2eb008000000b0024b4ff25e09mr16404348ljk.28.1649849331196;
        Wed, 13 Apr 2022 04:28:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w14-20020a05651c118e00b0024c80f2b7edsm320995ljo.74.2022.04.13.04.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:28:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4C8F110369B; Wed, 13 Apr 2022 14:30:24 +0300 (+03)
Date:   Wed, 13 Apr 2022 14:30:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
Message-ID: <20220413113024.ycvocn6ynerl3b7m@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
 <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
 <ebf3ccef-e6fe-62d5-74e8-91e30e7c2642@intel.com>
 <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a458c13f-9994-b227-ff61-bfdfec10bc27@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:36:11PM +0200, David Hildenbrand wrote:
> On 12.04.22 18:08, Dave Hansen wrote:
> > On 4/12/22 01:15, David Hildenbrand wrote:
> >> Can we simply automate this using a kthread or smth like that, which
> >> just traverses the free page lists and accepts pages (similar, but
> >> different to free page reporting)?
> > 
> > That's definitely doable.
> > 
> > The downside is that this will force premature consumption of physical
> > memory resources that the guest may never use.  That's a particular
> > problem on TDX systems since there is no way for a VMM to reclaim guest
> > memory short of killing the guest.
> 
> IIRC, the hypervisor will usually effectively populate all guest RAM
> either way right now.

No, it is not usual. By default QEMU/KVM uses anonymous mapping and
fault-in memory on demand.

Yes, there's an option to pre-populate guest memory, but it is not the
default.

> So yes, for hypervisors that might optimize for
> that, that statement would be true. But I lost track how helpful it
> would be in the near future e.g., with the fd-based private guest memory
> -- maybe they already optimize for delayed acceptance of memory, turning
> it into delayed population.
> 
> > 
> > In other words, I can see a good argument either way:
> > 1. The kernel should accept everything to avoid the perf nastiness
> > 2. The kernel should accept only what it needs in order to reduce memory
> >    use
> > 
> > I'm kinda partial to #1 though, if I had to pick only one.
> > 
> > The other option might be to tie this all to DEFERRED_STRUCT_PAGE_INIT.
> >  Have the rule that everything that gets a 'struct page' must be
> > accepted.  If you want to do delayed acceptance, you do it via
> > DEFERRED_STRUCT_PAGE_INIT.
> 
> That could also be an option, yes. At least being able to chose would be
> good. But IIRC, DEFERRED_STRUCT_PAGE_INIT will still make the system get
> stuck during boot and wait until everything was accepted.

Right. It deferred page init has to be done before init.

> I see the following variants:
> 
> 1) Slow boot; after boot, all memory is already accepted.
> 2) Fast boot; after boot, all memory will slowly but steadily get
>    accepted in the background. After a while, all memory is accepted and
>    can be signaled to user space.
> 3) Fast boot; after boot, memory gets accepted on demand. This is what
>    we have in this series.
> 
> I somehow don't quite like 3), but with deferred population in the
> hypervisor, it might just make sense.

Conceptionally, 3 is not different from what happens now. The first time
normal VM touches the page (like on handling __GFP_ZERO) the page gets
allocated on host. It can take very long time if it kicks in direct
reclaim on the host.

The only difference is that it is *usually* slower.

I guest we can make a case for making 1 an option to match pre-populated
use case for normal VMs.

Frankly, I think option 2 is the worst one. You still CPU cycles from the
workload after boot to do the job that may or may not be needed. It is an
half-measure that helps nobody.

-- 
 Kirill A. Shutemov
