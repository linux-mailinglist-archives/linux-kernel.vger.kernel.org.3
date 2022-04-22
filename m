Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FDB50BCD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382805AbiDVQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381784AbiDVQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:26:36 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F05DE70
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:23:38 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 17so10287475lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MuBFrhJUOONLWXDwFhqBNuCDF96+pp+7LO7m7j6HVnc=;
        b=aPyjHIH15/ZlqkdljmCtysFMz1fao4RAeRNcVpZ8TybN4Ud2MluMCY5f73fNrXfypM
         HkZsnBpkUt3gU6bCETZbnfknjtQGlO14szjXMcnQb+BxiWvenyMTWGNt+pidsZwW+hGi
         QplsAf9EP/tHXtgg4EFNDpnvzNPcKezjH53i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MuBFrhJUOONLWXDwFhqBNuCDF96+pp+7LO7m7j6HVnc=;
        b=xxpi4KXTHkZsFqllYiWRgO+VgmKmmswwxu7BG5XS4eSf2RYBzho+ujTyI7RYGXrCcJ
         c0Id+fL8EzodhFNjywo+kwUIFu8tgiO2ecighcpMRz7feK382+8UOgwxtHKh3vjYtcTL
         OK7ezV3viSpqT5vz521hO45aph2XcAHKb2xgfxajOGaA71k0ug/3OYAPc+JUAzNdZbYn
         icSJlmPVxXRaR27HknbW+//0Ya0Ntz02khWk0Dtqh3f99tyAhJcNZjOv4CJiK0RZ6EjN
         iBcVICOg7HCTVIAuMo/qQ5IyC2bFcutz8ogQnekdGApKsp0/NiaoZF6whdYuUZhtKTcG
         Xw8w==
X-Gm-Message-State: AOAM533K9T3kVHyifRzWbbXBnHrYC/SHtc4+kKq01HDymAk8zCbYraaX
        rLVDTbQBRMN42GJlPaHi1rk6S0x2LyJ6KgxUl4A=
X-Google-Smtp-Source: ABdhPJwO/kgFGe1NvEkuvX7o9qvFegxEoMDb9oztz3CRuvIBd8s2cNX6bcBmsmDrE9DT+4+Lc4CVtw==
X-Received: by 2002:a05:651c:1050:b0:24d:cc3c:dd26 with SMTP id x16-20020a05651c105000b0024dcc3cdd26mr3264761ljm.449.1650644617018;
        Fri, 22 Apr 2022 09:23:37 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e8751000000b00244beaacef1sm266628ljj.18.2022.04.22.09.23.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:23:35 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id bj36so10228191ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:23:35 -0700 (PDT)
X-Received: by 2002:a2e:b8d2:0:b0:24e:e19c:5375 with SMTP id
 s18-20020a2eb8d2000000b0024ee19c5375mr3277685ljp.176.1650644614617; Fri, 22
 Apr 2022 09:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220422060107.781512-1-npiggin@gmail.com> <20220422060107.781512-2-npiggin@gmail.com>
In-Reply-To: <20220422060107.781512-2-npiggin@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Apr 2022 09:23:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg09h4_-g6Fc1K5UqA==Zfe1gXQhJcZ6J9Mnopp15gptg@mail.gmail.com>
Message-ID: <CAHk-=wg09h4_-g6Fc1K5UqA==Zfe1gXQhJcZ6J9Mnopp15gptg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/vmalloc: huge vmalloc backing pages should be
 split rather than compound
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:01 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Huge vmalloc higher-order backing pages were allocated with __GFP_COMP
> in order to allow the sub-pages to be refcounted by callers such as
> "remap_vmalloc_page [sic]" (remap_vmalloc_range).
>
> However a similar problem exists for other struct page fields callers
> use, for example fb_deferred_io_fault() takes a vmalloc'ed page and
> not only refcounts it but uses ->lru, ->mapping, ->index. This is not
> compatible with compound sub-pages.
>
> The correct approach is to use split high-order pages for the huge
> vmalloc backing. These allow callers to treat them in exactly the same
> way as individually-allocated order-0 pages.

This patch looks ObviouslyCorrect(tm), and you even reproduced the
fbdev  problem.

Applied.

              Linus
