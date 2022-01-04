Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11022484A34
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 22:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiADVnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 16:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiADVno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 16:43:44 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D24C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 13:43:44 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id k27so62635777ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VlyYekp2oj/MkvkvX6Ay1MnkMaZXRB1aMd6yZZPObxg=;
        b=FB42VyHKTobzOeaP4gUSV6P6ReZLYkYHUoGFUaidmRZkPqcaL1gU1PiqCIQSDsIyP3
         G2dMmKIGbwCwZxL5Q6Geo0D+hbdN1rmrn3hKm7ibL56t4pBENhJw6uVIIkoQrlQVoWPl
         zgAQWzAnmn6OnNonVWgzgy8Lz5doKmYmIOf/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlyYekp2oj/MkvkvX6Ay1MnkMaZXRB1aMd6yZZPObxg=;
        b=mRwZ6PS6bOskjzf2hHAnSdyyRNPBRbCddvBlcTir421Q7IfWFnCwCSKLv2ck3Mup1D
         y3BkRUPCVDy4AY7gK+PfHF677WiwHTtwuhGmwPYFfiO46BtJd2cFXgkT6ADUpMyQPD6k
         FhbrDsyPbXBiSfuwq7toGe7kZVs3pUWY+R+nv/1KCNsZTDFgFWU+sXKf6clBsPlF2zHP
         3cLovTi25tkhiJrjZ3Ujfs5jegHLBLgOK7XbvMVsK1j4aKT/hI2OzTj6XwU4y/TN5DdM
         ifx997xqRjKkGpbHU2GuPSgkirEdRDLhbIWBPfPfwYaaqBv6BlsHGkGhrHOoCNsCkP1H
         GyEQ==
X-Gm-Message-State: AOAM531hINAfKBKncZwPdZmghGf/hEVwGodkBcfkY1JHNtxg7f8t+kWw
        P74tgWw3gEnT67WRaN3wUwELO9FxKEDSq6Qa5rA=
X-Google-Smtp-Source: ABdhPJwmOclXbGDYffYF5fEbmASewmPj1+ayR4A4rLYJl751LFsH8Q6N8t/N/sed7ptyKXXEB2c2eg==
X-Received: by 2002:a2e:b711:: with SMTP id j17mr42761591ljo.279.1641332622476;
        Tue, 04 Jan 2022 13:43:42 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c22sm3335472ljd.137.2022.01.04.13.43.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 13:43:41 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id h7so40071683lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 13:43:41 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr10486476wrh.97.1641332609879;
 Tue, 04 Jan 2022 13:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <YdSuSHa/Vjl6bPkg@google.com>
In-Reply-To: <YdSuSHa/Vjl6bPkg@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jan 2022 13:43:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whMbX+GUBY=Fyxo3r-XVvfNyFA+4hUJS7UxgYDxf9Wbcw@mail.gmail.com>
Message-ID: <CAHk-=whMbX+GUBY=Fyxo3r-XVvfNyFA+4hUJS7UxgYDxf9Wbcw@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 12:30 PM Yu Zhao <yuzhao@google.com> wrote:
>
> My goal is to get it merged asap so that users can reap the benefits
> and I can push the sequels. Please examine the data provided -- I
> think the unprecedented coverage and the magnitude of the improvements
> warrant a green light.

I'll leave this to Andrew. I had some stylistic nits, but all the
actual complexity is in that aging and eviction, and while I looked at
the patches, I certainly couldn't make much of a judgement on them.

The proof is in the numbers, and they look fine, but who knows what
happens when others test it. I don't see anything that looks worrisome
per se, I just see the silly small things that made me go "Eww".

             Linus
