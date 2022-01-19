Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810BE493400
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbiASERp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiASERo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:17:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D0AC061574;
        Tue, 18 Jan 2022 20:17:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m8-20020a17090a4d8800b001b4f361964fso1373593pjh.3;
        Tue, 18 Jan 2022 20:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=AKF/m4crRjUPKaEVyR47iJWpF9556rhB20qICdT0XMw=;
        b=gAmqQ4rYYDr653fs21as+JGb8WVc3EmyhbYjx0q2IQ5dWwJZKJ4GnqrquUtrvSB9OB
         yrB2KyU4M340MMrv250jTVTm9egqTgMtoitKsWrnZig7xF0hOskKydBZPGefcGE0csbP
         AiWdymunWo98bs9atvLMSPnGTL+cKj+CVfnPBiHWx4Exxb8VTZv3RGeCwPszEkMQiHOl
         7RVADXLKYlCe8CIcbja61x2w0JRXJUjn5z1wkaIVivzwlVoMaedV2Yu12vPxNe4yUID6
         AI9KiKUKOHS2QOSPlOzLqKoMbfHEMjJecKbks82ZSv6NLKRWAaGowwlsYIP1sXYCr2Nk
         XDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=AKF/m4crRjUPKaEVyR47iJWpF9556rhB20qICdT0XMw=;
        b=zZekgZJ11lWQ3RsoWrRewO5IAPPZ2rW7l93c2S51mXNUBf/SkOEAO0Ifb1oOcJezxr
         sOhrtGhLMB2pj4npCxy/52wxrEUJ+UIsiXUHxkTzd5COs2MuIl94nPLmjjd/WZi45ETV
         c68wzD+IuAL8dMBArMiFK88QQ3bkzKLRR+zkZUPzogdK1cjZ5Odp0O7cuKe8SQLRQIPk
         NLhuSs9Y8dKbQ7v3AnAHyh0T2N7VBdTdCfVANJz+2TJrcgEdiCUufOhqmk9ORFYUvSiE
         qkK75qHQYwwRp0rsop+vxczZrFhdvXnOAF00VqDjvx6gx/6ABHMEYu4A9pePTxtJmRpM
         LH4Q==
X-Gm-Message-State: AOAM532/FSglE71MJ8tHlOqviQEQ9a7bNeOFT6fDg9s8dLV7pkmHDsni
        cfsbWwl0eHi+43juY/fyd+Y=
X-Google-Smtp-Source: ABdhPJx3OvhLmFtcmBgPOWtTOgtFz5eNT+qAc0Hg/uqwpDFNuWOOlw66tKXtoYn5ZRQ3+6wnEZ9b/A==
X-Received: by 2002:a17:902:6b89:b0:149:7aa8:d98c with SMTP id p9-20020a1709026b8900b001497aa8d98cmr30797727plk.72.1642565863190;
        Tue, 18 Jan 2022 20:17:43 -0800 (PST)
Received: from localhost (193-116-82-75.tpgi.com.au. [193.116.82.75])
        by smtp.gmail.com with ESMTPSA id n5sm18226822pfo.39.2022.01.18.20.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 20:17:42 -0800 (PST)
Date:   Wed, 19 Jan 2022 14:17:37 +1000
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
        <1642472965.lgfksp6krp.astroid@bobo.none>
        <4488d39f-0698-7bfd-b81c-1e609821818f@intel.com>
In-Reply-To: <4488d39f-0698-7bfd-b81c-1e609821818f@intel.com>
MIME-Version: 1.0
Message-Id: <1642565468.c0jax91tvn.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Dave Hansen's message of January 19, 2022 3:28 am:
> On 1/17/22 6:46 PM, Nicholas Piggin wrote:
>>> This all sounds very fragile to me.  Every time a new architecture woul=
d
>>> get added for huge vmalloc() support, the developer needs to know to go
>>> find that architecture's module_alloc() and add this flag.
>> This is documented in the Kconfig.
>>=20
>>  #
>>  #  Archs that select this would be capable of PMD-sized vmaps (i.e.,
>>  #  arch_vmap_pmd_supported() returns true), and they must make no assum=
ptions
>>  #  that vmalloc memory is mapped with PAGE_SIZE ptes. The VM_NO_HUGE_VM=
AP flag
>>  #  can be used to prohibit arch-specific allocations from using hugepag=
es to
>>  #  help with this (e.g., modules may require it).
>>  #
>>  config HAVE_ARCH_HUGE_VMALLOC
>>          depends on HAVE_ARCH_HUGE_VMAP
>>          bool
>>=20
>> Is it really fair to say it's *very* fragile? Surely it's reasonable to=20
>> read the (not very long) documentation ad understand the consequences fo=
r
>> the arch code before enabling it.
>=20
> Very fragile or not, I think folks are likely to get it wrong.  It would
> be nice to have it default *everyone* to safe and slow and make *sure*

It's not safe to enable though. That's the problem. If it was just=20
modules then you'd have a point but it could be anything.

> they go look at the architecture modules code itself before enabling
> this for modules.

This is required not just for modules for the whole arch code, it
has to be looked at and decided this will work.

> Just from that Kconfig text, I don't think I'd know off the top of my
> head what do do for x86, or what code I needed to go touch.

You have to make sure arch/x86 makes no assumptions that vmalloc memory
is backed by PAGE_SIZE ptes. If you can't do that then you shouldn't=20
enable the option. The option can not explain it any more because any
arch could do anything with its mappings. The module code is an example,
not the recipe.

Thanks,
Nick
