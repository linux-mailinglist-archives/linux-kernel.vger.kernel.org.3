Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7795AFB94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIGFO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGFOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:14:25 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38057386
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:14:22 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3452214cec6so74211637b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XvX4d4lHGdhmKH0oBQwXf1eY3JxPJlcnylOzEMhTpjw=;
        b=HDlMGE1Dtzvgl4sx6psOG95eCP5fJubOQx5rXOyJx1TDazhk2aqRufACacOJcEYT0r
         osZ3Lo1Z8fPPZoaylkaghbAM0BQaZlBz1gP+hMcBo5QZ8uGeCzStYKrifJmkD25k/DiH
         lr7m3LWSVEvxQsKpef0k4kDU4xiwqz9lTMxviETiwgfIWuISK2zTacUHozdB4J3nXS9e
         F9TMLHMGlC1abNichKH/KwH+iUF/G7XgcKsT6byuUtzTCS35n5mgoqQHWBIs3qPwr01+
         aBahQ5C+5fH4hUaf2XYXq92ziiDceVipoSwAWu2HLa44wmTacL94ihW+OhBWGzAAfqfC
         QwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XvX4d4lHGdhmKH0oBQwXf1eY3JxPJlcnylOzEMhTpjw=;
        b=HWWIbx35Q04Plt1pT2IltM7sDNlCY/gKZwP/qQS6wB1Di9oXGTky1Y3PjPZOwRm70l
         Vc1CUBqEoXmoXRKaVG5n6KTjglEQ7GK+7RVspzCCK7qFcdm9rlCLcEcDagOEMpeKDAUJ
         Vuurq9MojwPky7+pIW79kIM8eL2Yo8soiVAXWoQmHn0bN+YosI5SQ7UrD/lYL2BQDQUm
         xFWWH8X2qeFZE69o3bgDbqfBFFNXVhk2u26lZW6PrmaMwM98SKSL5/9HLXdmFeVHRWbT
         U38v1rQJBiVBzI8H0MKZKqeIeFj1Sesg5trLP8ho0bC919qch/qG/JpddOd4pbDgr1Pn
         UUdg==
X-Gm-Message-State: ACgBeo2rdEVUy10fy8pO3vtj0Yn9GGOniYYrbk3v+mHnywAJXgzpCMeO
        kG4oLgikmjmgKp07aFnVNL0kEbhSn4a8L0zXCPzlYA==
X-Google-Smtp-Source: AA6agR4QILULoRsfdqtrSc/wO0dJ6FfgSjfGPULmGUF02/SC0+lfUh/gUzPfZ6OXZMwCh+VWaeeVJ4k7hm0bh5AhRgc=
X-Received: by 2002:a81:66c5:0:b0:345:3b1c:26 with SMTP id a188-20020a8166c5000000b003453b1c0026mr1857526ywc.156.1662527661285;
 Tue, 06 Sep 2022 22:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655761627.git.ashish.kalra@amd.com> <0ecb0a4781be933fcadeb56a85070818ef3566e7.1655761627.git.ashish.kalra@amd.com>
 <YvKRjxgipxLSNCLe@zn.tnic> <YxcgAk7AHWZVnSCJ@kernel.org> <CAA03e5FgiLoixmqpKtfNOXM_0P5Y7LQzr3_oQe+2Z=GJ6kw32g@mail.gmail.com>
 <SN6PR12MB2767ABA4CEFE4591F87968AD8E7E9@SN6PR12MB2767.namprd12.prod.outlook.com>
 <20220906150635.mhfvtl2xgdbzr7a5@amd.com> <SN6PR12MB276774A14FEBFF4E98AC07238E7E9@SN6PR12MB2767.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB276774A14FEBFF4E98AC07238E7E9@SN6PR12MB2767.namprd12.prod.outlook.com>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 6 Sep 2022 22:14:10 -0700
Message-ID: <CAA03e5ETjW-apRwDa-27YrcLUPy_QxJXu9zDKWOBHa1ZVJUfwg@mail.gmail.com>
Subject: Re: [PATCH Part2 v6 09/49] x86/fault: Add support to handle the RMP
 fault for user address
To:     "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc:     "Roth, Michael" <Michael.Roth@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Alper Gun <alpergun@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

> >> >But I believe Jarkko's version calculates the correct mask (below), incorporating all 18 offset bits into the 1G page.
> >> >>> hex(262144 -1)
> >> >'0x3ffff'
> >>
> >> We can get this simply by doing (page_per_hpage(level)-1), but as I mentioned above this is not what we need.
>
> >If we actually want the 4K page, I think we would want to use the 0x3ffff mask as Marc suggested to get to the specific 4K RMP entry, which I don't think the current code is trying to do. But maybe that *should* be what we should be doing.
>
> Ok, I agree to get to the specific 4K RMP entry.

Thanks, Michael, for a thorough and complete reply! I have to admit,
there was some nuance I missed in my earlier reply. But after reading
through what you wrote, I agree, always going to the 4k-entry to get
the "assigned" bit and also leveraging the implementation of
snp_lookup_rmpentry() to lookup the size bit in the 2M-aligned entry
seems like an elegant way to code this up. Assuming this suggestion
becomes the consensus, we might consider a comment in the source code
to capture this discussion. Otherwise, I think I'll forget all of this
the next time I'm reading this code :-). Something like:

/*
 * The guest-assigned bit is always propagated to the paddr's respective 4k RMP
 * entry -- regardless of the actual RMP page size. In contrast, the RMP page
 * size, handled in snp_lookup_rmpentry(), is indicated by the 2M-aligned RMP
 * entry.
 */
