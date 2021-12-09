Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58A246E670
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhLIKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhLIKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:19:22 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600ECC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:15:49 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id a23so67046pgm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=uTtDFl4ylvWzOUxVw5Eo9EBEL+buH4qtkFmI+A3VVv0=;
        b=NQ9+kg5KOv5dp8pVp2G3I8lUbNXVG0gGlaVKBRUDptLxHDT3j6LoR5hi005x1rifX+
         uA6bfveQG0dx3f3Pz+tdXHOtl8NoklpAuoTEXZUr+NSdbKoqLQlXdLMULNoJ0k9Rq6ZK
         SSEUIuBrDVN8GOsU/W4YMnlWzJypWUzwT+skDvkedX8UYzrYQHgnOiqAMWnKd0cRvd41
         LM6mLgEdHygyZ72GDyz21c7VxxOdNMpIHcsRXabxpb4b5XhinlJaD+deOAZAo8o4HKKs
         KW2NnFS0VCtV+d/d3qC19MUMo6+woIuBgTEGVoOt7F/LCFRfUQLYO+GyaCpWHXIB2qEu
         Gbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=uTtDFl4ylvWzOUxVw5Eo9EBEL+buH4qtkFmI+A3VVv0=;
        b=nFjplfrV4k/jnNt/Wz0vaFwBd9PKue+z3fOfqEmwKCqT3XtBY2Me1ykrwGRu/g5KIo
         FeeKD3u/6cFxRgfm+R5NYJ8THH437Y26YvMr6IVMnHZSGzxMlkk3L3cZJF5c/g245Rp/
         Law9IJvWJ8nGSqZy4so1EHq8Kve5asPRuTJfEPilcL8UWT7kb5CTDIeKOirW/KC3vqyg
         D/NppjaN3q/a8utnbv3Cc4Q0hiz8sm/KxZnU2WU7yMMsllwYtlDgvH05jf8qLjF14D1C
         WJlwPjv39HkD3WC1usHmQwB+Jv7nd+ELg3L1+Ey6zZFpUor/+gMw/V+2ewiCMwObgPq/
         KNEA==
X-Gm-Message-State: AOAM532r4+q39L9EWdi4b1xyqMOjQQyEOZ5yCdWHNMVUw7eCufRjYfav
        sE1qqj+QYP9YTtDeQ/37Tg4=
X-Google-Smtp-Source: ABdhPJwjI9kxYeG3xjcWudWWgMKJYeADbcpgkvYJNmVIASIiiFf9HmZhYN59I+Cd0HwMP0j9lYkm/w==
X-Received: by 2002:a63:69c6:: with SMTP id e189mr32529626pgc.237.1639044949008;
        Thu, 09 Dec 2021 02:15:49 -0800 (PST)
Received: from localhost (203-219-139-206.static.tpgi.com.au. [203.219.139.206])
        by smtp.gmail.com with ESMTPSA id n6sm6227193pfa.28.2021.12.09.02.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:15:48 -0800 (PST)
Date:   Thu, 09 Dec 2021 20:15:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 09/10] powerpc/mm: Convert to default topdown mmap
 layout
To:     "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1638976228.git.christophe.leroy@csgroup.eu>
        <d2d5510115cba2d56866fa01dab267655a20da71.1638976229.git.christophe.leroy@csgroup.eu>
In-Reply-To: <d2d5510115cba2d56866fa01dab267655a20da71.1638976229.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1639044621.jeow25j0pr.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 9, 2021 3:18 am:
> Select CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT and
> remove arch/powerpc/mm/mmap.c
>=20
> This change provides standard randomisation of mmaps.
>=20
> See commit 8b8addf891de ("x86/mm/32: Enable full randomization on i386
> and X86_32") for all the benefits of mmap randomisation.

The justification seems pretty reasonable.

>=20
> Comparison between powerpc implementation and the generic one:
> - mmap_is_legacy() is identical.
> - arch_mmap_rnd() does exactly the same allthough it's written
> slightly differently.
> - MIN_GAP and MAX_GAP are identical.
> - mmap_base() does the same but uses STACK_RND_MASK which provides
> the same values as stack_maxrandom_size().
> - arch_pick_mmap_layout() is almost identical. The only difference
> is that it also adds the random factor to mm->mmap_base in legacy mode.
>=20
> That last point is what provides the standard randomisation of mmaps.

Thanks for describing it. Could you add random_factor to mmap_base for
the legacy path for powerpc as a 2-line change that adds the legacy
randomisation. And then this bigger patch would be closer to a no-op.

Thanks,
Nick

