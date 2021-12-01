Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79154655E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352049AbhLAS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhLAS61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB65C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:55:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so456310pju.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1ExD0+swPLV06IbML+nCZJEqWUERlwvAbaLR0RlV1zc=;
        b=hPT+ALqXUH21V1OTdW/CVBcm8UuReC0RQCOoVzZAuEuSo7UXydXVha4iByMVdYpzPp
         a52o4jnAAwZQTe8/ecpvLke2XmvpALeHXtUVJX6bh+izeRwW5h6xVxfIdohu6zmKH5cX
         l8mKvxHnOxlgMu8ipJKZFKooxAwMuoRwm/N3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1ExD0+swPLV06IbML+nCZJEqWUERlwvAbaLR0RlV1zc=;
        b=ylgiXYvnAPviyv+SdvxwTj/dl/kEDFMom+vR1W7gISTXTIuJ9LmZ1vI4Q5laLuPeKI
         XHGllfVUmEEf/nylHpVjqagfqder14iz0p8ntEKHAV/pvBNehyqaGZfzU3csR6xpY3Rz
         Xunoq/m1NkzBqucrA6vP7pTknfLzmXGOIHdekIsRpfcFKcfafSIEnxrMjP0/ZYLe1A2J
         nUXXgiBoKMTiGalmwZgQT1qDLmIViFxbQMEUrgXldukhHVzyn4eBbFFd+QGH9Z+eFyFc
         PNWilbdXfRJdXKluOAgghe0aw1+TybrdR9EjuEDSe3QF+Xmwa0U7fOqwj+ZHhZF9OMPu
         mMFA==
X-Gm-Message-State: AOAM530ZL2NUO9l+B4gLH6cv3jyfTfhIOcw+GY1MB/O9fw9c5enXjVUL
        7uKLzt4NUlJMNaUZ077nQPFbEQ==
X-Google-Smtp-Source: ABdhPJxdJgDipzr13GjjKK+mcG6VZupIMvd7jkwDOMulpxoCb5Q+dZ8GKmNt/zAr2B85xjLqNTUxLQ==
X-Received: by 2002:a17:90a:e40f:: with SMTP id hv15mr32741pjb.5.1638384906215;
        Wed, 01 Dec 2021 10:55:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f4sm575538pfj.61.2021.12.01.10.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:05 -0800 (PST)
Date:   Wed, 1 Dec 2021 10:55:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     LEROY Christophe <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Message-ID: <202112011054.B56B09FEF@keescook>
References: <20211118203604.1288379-1-keescook@chromium.org>
 <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
 <87ilwkrbhz.fsf@mpe.ellerman.id.au>
 <202111221247.B385EA2A8@keescook>
 <8735nmquti.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735nmquti.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:08:25AM +1100, Michael Ellerman wrote:
> Kees Cook <keescook@chromium.org> writes:
> > On Mon, Nov 22, 2021 at 04:43:36PM +1100, Michael Ellerman wrote:
> >> LEROY Christophe <christophe.leroy@csgroup.eu> writes:
> >> > Le 18/11/2021 à 21:36, Kees Cook a écrit :
> >> >> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >> >> field bounds checking for memset(), avoid intentionally writing across
> >> >> neighboring fields.
> >> >> 
> >> >> Add a struct_group() for the spe registers so that memset() can correctly reason
> >> >> about the size:
> >> >> 
> >> >>     In function 'fortify_memset_chk',
> >> >>         inlined from 'restore_user_regs.part.0' at arch/powerpc/kernel/signal_32.c:539:3:
> >> >>     >> include/linux/fortify-string.h:195:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >> >>       195 |    __write_overflow_field();
> >> >>           |    ^~~~~~~~~~~~~~~~~~~~~~~~
> >> >> 
> >> >> Reported-by: kernel test robot <lkp@intel.com>
> >> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> >
> >> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> 
> >> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> >
> > Thanks! Should I take this via my tree, or do you want to take it via
> > ppc?
> 
> I don't mind. If it's easier for you to take it as part of an existing
> series then do that, otherwise I can pick it up.

Most of the other patches are going via other maintainers, so I'd love
it if ppc could snag this one too. :)

Thanks!

-Kees

-- 
Kees Cook
