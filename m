Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A346E6D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhLIKrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLIKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:47:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE64C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 02:43:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id a23so129205pgm.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=2Qjk1kLBchBn6nu4RyDNGi/pft6RyBtffqzm5RXD6rQ=;
        b=J3fgveQOyktHd0Ho6etVh+aiABFsCMbits+i4+iiw3mPGq0uV+cwoX51PQxUyX1m/u
         guVf+Yy/AALjrRYousf5AWBJOSXjBdfIruQ+12bnfDkQtkrkGptAGDly7UT4e+Qf9/A6
         ZG6y06qVmUF8U/9C0WnBuCeYTnrQT0Ll4AxFXzvcHBUGOeALFrwANDwwkk2cSazA8fQT
         JitIEB2WLroaNlv5sDxN5F3yqb6MnIP+xPFJ28c694sFturpNEL5t5AEuTZTC5UTWqjO
         PVOfPEZ45ZkQYpmOLCeVh8/99r2cqZObZSVqnFBxaEuoX6PyxaJMyUWwq+JlrGlkQQCe
         lsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=2Qjk1kLBchBn6nu4RyDNGi/pft6RyBtffqzm5RXD6rQ=;
        b=SwRu+g+7G9DpZCh8nrRlujj3FnePOrZpZWfP9T+O/8uMUBgLKsHLN/Fh2L8p/VNMqo
         xmAfq8komGuNnzOe1LMlm9eD0yGhzP2Rkvz8eQLRZ9fsP4fXVFoc0+YQCbqXVMY22nhA
         UjcRFnKGGTH9phbZkm/boc/eQ4rmcx27tGC52TfsJchgHOLUh3Vi+3xtuKXvia2b2WCS
         NKgRdn7Uw9VX7HnnDrHN99nH7ZmwHlJIqGKyn8JnK8XqxTvtawqbO3AyD90fXMapi/MU
         cYSaee9LKzehBiIpszLq3FUqoHHmAXrirafULepWtjVuhndhvighPNNHGuhT75ny+U1g
         nXVA==
X-Gm-Message-State: AOAM532jMJyOs9FMn6W2OWsJ1k4ioCapgIHg39PYrI6wwIXmqi/a749D
        yXBW2WP4lDCVh5z+SO1LoZM=
X-Google-Smtp-Source: ABdhPJwHG5S78XCRdMnXjjsXRAdUoVQkNZBPVctW89B41UUPc1LLj2IYRqJKX0ugAkxryonyH8Gm6Q==
X-Received: by 2002:a63:b60e:: with SMTP id j14mr33497418pgf.554.1639046618557;
        Thu, 09 Dec 2021 02:43:38 -0800 (PST)
Received: from localhost (203-219-139-206.static.tpgi.com.au. [203.219.139.206])
        by smtp.gmail.com with ESMTPSA id h8sm5230340pgj.26.2021.12.09.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:43:38 -0800 (PST)
Date:   Thu, 09 Dec 2021 20:43:32 +1000
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
        <1639044621.jeow25j0pr.astroid@bobo.none>
        <360e2a3e-63c6-3ce2-f481-695ad0ec4880@csgroup.eu>
In-Reply-To: <360e2a3e-63c6-3ce2-f481-695ad0ec4880@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1639046542.qkwu4mjtew.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of December 9, 2021 8:22 pm:
>=20
>=20
> Le 09/12/2021 =C3=A0 11:15, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of December 9, 2021 3:18 am:
>>> Select CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT and
>>> remove arch/powerpc/mm/mmap.c
>>>
>>> This change provides standard randomisation of mmaps.
>>>
>>> See commit 8b8addf891de ("x86/mm/32: Enable full randomization on i386
>>> and X86_32") for all the benefits of mmap randomisation.
>>=20
>> The justification seems pretty reasonable.
>>=20
>>>
>>> Comparison between powerpc implementation and the generic one:
>>> - mmap_is_legacy() is identical.
>>> - arch_mmap_rnd() does exactly the same allthough it's written
>>> slightly differently.
>>> - MIN_GAP and MAX_GAP are identical.
>>> - mmap_base() does the same but uses STACK_RND_MASK which provides
>>> the same values as stack_maxrandom_size().
>>> - arch_pick_mmap_layout() is almost identical. The only difference
>>> is that it also adds the random factor to mm->mmap_base in legacy mode.
>>>
>>> That last point is what provides the standard randomisation of mmaps.
>>=20
>> Thanks for describing it. Could you add random_factor to mmap_base for
>> the legacy path for powerpc as a 2-line change that adds the legacy
>> randomisation. And then this bigger patch would be closer to a no-op.
>>=20
>=20
> You mean you would like to see the following patch before doing the=20
> convert ?
>=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/7dabf1cbde67a346a=
187881d4f0bd17347e0334a.1533732583.git.christophe.leroy@c-s.fr/

Yes.

Thanks,
Nick
