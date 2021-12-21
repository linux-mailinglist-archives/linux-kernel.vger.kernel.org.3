Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5493247C1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbhLUOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbhLUOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:49:07 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80D1C061401
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:49:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f5so29878975edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfnPPqaWoNm3lMtGyDvLwMnxD0pEmbsttRDzgpzpB4s=;
        b=gc3IqYYaeIGppwChVF0Fuy7HJQOT0yFKupp1i31H3AhHkBSVFSg/3DAOhGUE+0d+kN
         BSJe+2ZFgaoYciuuknC0GeitJes6T8FgAiiBPQOQHGtY9StpIQUAz30UGNCvLwIgzPI+
         4gyeeCWjzbKq4PuclYJbJVK3wB1e+Pib6Ok1GHporNy84/WOzs7FjiaJ+Zjxbu6VWIzQ
         4Fd7nx/LpPBr9eLcSsd0Kx00XBEg2Ky8DmHA5qPgdLg+TojVlYxGsaN04kf8fNiwPkTC
         SwCD5LYsInKRovQt189/NMWihILb+fTlEa3Etrt8NSL1iwm/VhPg3bgqedOlG7Re5mqc
         Vfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfnPPqaWoNm3lMtGyDvLwMnxD0pEmbsttRDzgpzpB4s=;
        b=LCI8RpOYHZqxvC+i97xlq+FmIBaAEZ4nWFAvHWWQvHJC/+G8cud08dteRev3v78FEb
         HbqkSGNAdvFI6RTXej5a9Ujx2EUS/nxrMG3edQbiqfJFR1Ia5nkkHSV7TNQu6Tlenin0
         VPgMKKiADGzhKHcyMlLvA6ACUffWWTPTbrYQiNlEjR28jpVZShw0CsDUnRVVAkpQvdDh
         WmirCbVm/19GMECY0KAE0e5zMl4E3+ZYPja5NGrg8EC8B3CkJuphA6zzkJizqsf6YAID
         SSF9mup6G2xTd9m6qmLzEkhSJd/6xhsMpOOLzk/lumIwfXGaT0elgJIXUY0D/vmSBs4q
         CE+Q==
X-Gm-Message-State: AOAM531/sreNZnnYKA1lYOqFMmRZOSslWaxWc8sLFoDxlVkt9C+BOyej
        lylBH9F8adpZs7wv75Sp+aiI8HDi5YP8c8GN2lkSAw==
X-Google-Smtp-Source: ABdhPJxfgHYxe+UwAZ19/6k9UIoxcbQOkjsRjy6TzQgI0RlCGAvN0+1w5UJufsmw5Ieh61sIhRT2eW70aIHzSBNmUZc=
X-Received: by 2002:a05:6402:f:: with SMTP id d15mr3579163edu.331.1640098145180;
 Tue, 21 Dec 2021 06:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20211204182314.1470076-1-pasha.tatashin@soleen.com> <c7ee3d19-3365-9aa0-c3ae-762108060cb2@gmail.com>
In-Reply-To: <c7ee3d19-3365-9aa0-c3ae-762108060cb2@gmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 21 Dec 2021 09:48:29 -0500
Message-ID: <CA+CK2bAOv4BoXvQmcA4eoqOnz1zyhg6vZPRvMBn_WpRoF0rQZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] page table check
To:     Fusion Future <qydwhotmail@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fushan,

On Tue, Dec 21, 2021 at 8:09 AM Fusion Future <qydwhotmail@gmail.com> wrote:
>
> I can confirm this patch resolved my issue. My system has been running
> three days with page table check enabled and is very stable.

Thank you for testing!

Pasha
