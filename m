Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02180491C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349492AbiARDNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350973AbiARC5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:57:49 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F100C061369;
        Mon, 17 Jan 2022 18:46:08 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i129so11790039pfe.13;
        Mon, 17 Jan 2022 18:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=G7afKiI+gE5BvcSZZNsZkHZKk4Ry06NGlI7r6RoEIKE=;
        b=Rc1D2DDu80wX82f3gReKMipNgtke5Ezoh5+9wP1vhbdzaMaDpuqodjUEIPM3EEkN6e
         LgXUN0zYcVseRq4Frignh/DJoa5B+ejI/R86K6gVUs4KSmZonAsG8E+ISC0wxiWbybhF
         sFXificRMOC2xpZ7KtIqyN2K0aiCO/s3go8noGaQHXcR+uqcDSh1kZsVYezqUxmq0/qz
         OL7tPvDnqbGNxHrMNvu+qIsoAgVc3qknGLNJvsmigTagPY6FxXNh9CcCOocBbit0S/bj
         QPOQoHItg72E/0+7MKT2m9nJCpmvz86e5RNpYYVLdt6+9paqz1AbJhAaBBdVWxJ7Li6P
         etFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=G7afKiI+gE5BvcSZZNsZkHZKk4Ry06NGlI7r6RoEIKE=;
        b=bGo1MGEhM1ChG7I/K76Gp4/BUvW/FjLe7eZcnMH6s/XPM6BzSJEGNMtU9vmxWGr1k5
         TtXt1wSw9lByS5vR7k9he7Dslk2r06ih5MGpcA23vmqWfZEuGNIC3RpD9A5QT97W6hc3
         Tpd2aA2qN70xQggEaA9hhKf5Q26fcLKedL07p1mvtbDCHSyQqr3uzq6xdjv3dp5M497e
         xEWvrBquoWmwLyewvv9ycWnVt0ZMZCtrfNPQjlIhIr93tUrYaz/kvtaUiJINN89TpD8S
         0lDoiB9Rxm89YE+dx59G0C6jAh6drUfYQiwUplE6kOJrS4X+V/qiEum1ky6jU2SE9Q0V
         lQlQ==
X-Gm-Message-State: AOAM533RomxH7em7w8/g6A6gcxdpWUnGkfiDGB32jeXb/Imyj73kQtPH
        sDXWf8Ze5cCYxt8CpJqivS8=
X-Google-Smtp-Source: ABdhPJwaTkO88Si8cY9Mt/mQhv8ZpVANJ2CdFYnmVifrVKXyLg/EiyceiwxjR12ycsrWtesBCh7+Uw==
X-Received: by 2002:a63:8c57:: with SMTP id q23mr21680397pgn.625.1642473968155;
        Mon, 17 Jan 2022 18:46:08 -0800 (PST)
Received: from localhost (124-171-74-95.tpgi.com.au. [124.171.74.95])
        by smtp.gmail.com with ESMTPSA id i123sm12180204pfe.13.2022.01.17.18.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 18:46:07 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:46:01 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/3] x86: Support huge vmalloc mappings
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>, x86@kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20211227145903.187152-1-wangkefeng.wang@huawei.com>
        <20211227145903.187152-4-wangkefeng.wang@huawei.com>
        <70ff58bc-3a92-55c2-2da8-c5877af72e44@intel.com>
        <3858de1f-cdbc-ff52-2890-4254d0f48b0a@huawei.com>
        <31a75f95-6e6e-b640-2d95-08a95ea8cf51@intel.com>
In-Reply-To: <31a75f95-6e6e-b640-2d95-08a95ea8cf51@intel.com>
MIME-Version: 1.0
Message-Id: <1642472965.lgfksp6krp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Dave Hansen's message of December 29, 2021 2:14 am:
> On 12/28/21 2:26 AM, Kefeng Wang wrote:
>>>> There are some disadvantages about this feature[2], one of the main
>>>> concerns is the possible memory fragmentation/waste in some scenarios,
>>>> also archs must ensure that any arch specific vmalloc allocations that
>>>> require PAGE_SIZE mappings(eg, module alloc with STRICT_MODULE_RWX)
>>>> use the VM_NO_HUGE_VMAP flag to inhibit larger mappings.
>>> That just says that x86 *needs* PAGE_SIZE allocations.=C2=A0 But, what
>>> happens if VM_NO_HUGE_VMAP is not passed (like it was in v1)?=C2=A0 Wil=
l the
>>> subsequent permission changes just fragment the 2M mapping?
>>=20
>> Yes, without VM_NO_HUGE_VMAP, it could fragment the 2M mapping.
>>=20
>> When module alloc with STRICT_MODULE_RWX on x86, it calls
>> __change_page_attr()
>>=20
>> from set_memory_ro/rw/nx which will split large page, so there is no
>> need to make
>>=20
>> module alloc with HUGE_VMALLOC.
>=20
> This all sounds very fragile to me.  Every time a new architecture would
> get added for huge vmalloc() support, the developer needs to know to go
> find that architecture's module_alloc() and add this flag.

This is documented in the Kconfig.

 #
 #  Archs that select this would be capable of PMD-sized vmaps (i.e.,
 #  arch_vmap_pmd_supported() returns true), and they must make no assumpti=
ons
 #  that vmalloc memory is mapped with PAGE_SIZE ptes. The VM_NO_HUGE_VMAP =
flag
 #  can be used to prohibit arch-specific allocations from using hugepages =
to
 #  help with this (e.g., modules may require it).
 #
 config HAVE_ARCH_HUGE_VMALLOC
         depends on HAVE_ARCH_HUGE_VMAP
         bool

Is it really fair to say it's *very* fragile? Surely it's reasonable to=20
read the (not very long) documentation ad understand the consequences for
the arch code before enabling it.

> They next
> guy is going to forget, just like you did.

The miss here could just be a simple oversight or thinko, and caught by=20
review, as happens to a lot of things.

>=20
> Considering that this is not a hot path, a weak function would be a nice
> choice:
>=20
> /* vmalloc() flags used for all module allocations. */
> unsigned long __weak arch_module_vm_flags()
> {
> 	/*
> 	 * Modules use a single, large vmalloc().  Different
> 	 * permissions are applied later and will fragment
> 	 * huge mappings.  Avoid using huge pages for modules.
> 	 */
> 	return VM_NO_HUGE_VMAP;
> }
>=20
> Stick that in some the common module code, next to:

Then they have to think about it even less, so I don't know if that's an=20
improvement. I don't know what else an arch might be doing with these
allocations, at least modules will blow up pretty quickly, who knows=20
what other rare code relies on 4k vmalloc mappings?

The huge vmalloc option is not supposed to be easy to enable. This is=20
the same problem Andy was having with the TLB shootdown patches, he=20
didn't read the documentation and thought it was supposed to be a=20
trivial thing anybody could enable without thinking about it, and was
dutifully pointing out the the nasty "bugs" the feature has in it if
x86 were to enable it improperly.

Thanks,
Nick

>=20
>> void * __weak module_alloc(unsigned long size)
>> {
>>         return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> ...
>=20
> Then, put arch_module_vm_flags() in *all* of the module_alloc()
> implementations, including the generic one.  That way (even with a new
> architecture) whoever copies-and-pastes their module_alloc()
> implementation is likely to get it right.  The next guy who just does a
> "select HAVE_ARCH_HUGE_VMALLOC" will hopefully just work.
>=20
> VM_FLUSH_RESET_PERMS could probably be dealt with in the same way.
>=20
