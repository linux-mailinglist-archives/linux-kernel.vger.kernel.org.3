Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489CB5677F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiGETqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGETqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:46:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D4519C3D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:46:03 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso5495829pjz.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxbTn0CECdrZXETflGt2gGDbEAPGwlDhM6o4bF0C3yE=;
        b=Fdw6fzHTpa73THj5FbnWvsryc9rX9O54EvNLbsmVn8I2OqAr35tJitYbGgkTDKBqwq
         195R0eKEaHXRMxRuYaHFdey6D6R5j8lnecgTglFyJ5u2Sxa3BV4KDrjhCQAvy5hAQg8K
         NnBaFDbUCRr+zIrvGQ+p6HSLSFQaA0+G69is3GhXEycNbYxDTyVmSHm6CKVwEkAAf3W9
         ZXJwspvQ0f/RvRrlmkvyyMdu3f5U+LsH/zsrrmzN7VXBxi7qGUR9D5olyg+R0ZD5o8kg
         69JxKMa050Xl4PspweOy03E95RIAvogwR8rcssCIiTyYyhCItPBpf5TS4xfl8gplnW4F
         g81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxbTn0CECdrZXETflGt2gGDbEAPGwlDhM6o4bF0C3yE=;
        b=UqthwgPC8eB4h16xhjgx+vc7OlvzoK61GOg1UlAEhDP0XdF1j/VQ3uWLq10rd23rNc
         Oi33+ohTpEM8ksOEo/thwebpbfqZhZ7ZBju1IpiukOlw1s5ky/lO/jq0vPVnoG2WlUgY
         YC477UC77RBCQ54fyIk+1yNwZ5fV1DLdU6XluNFiewpxsnnDx3nEx0CLG5X3+ODth5RJ
         0Vd6KS/PHRYbQXR7pYQ43apatFY8Y9T+LTausH3phpBSObz+rinvWKSVYJ/u7M1zMUjP
         GxLhrAOWXhW3U6aIPB9t/TUpYsk9g19Og3XWsfQ0fA4LJaFlSQPBd5z2VTbjEz9GRtRl
         zWaw==
X-Gm-Message-State: AJIora/dmS00CaBaAzLACkqsco8laDxOHokJiBg9B9ugonnvVwCo8UEZ
        773qFkuDjEeZBFEEALr02r6tYiUnfSi8aciqZQTwpmbJ
X-Google-Smtp-Source: AGRyM1vnZOyBKIvJzumKYrmgw1LwXomVfZE8/AO11upfxcNuo8eGdcG5ysjznGDWIIJwoyjStENtCUcgLB4X8pZIVUg=
X-Received: by 2002:a17:902:ab8a:b0:16a:7cf2:a394 with SMTP id
 f10-20020a170902ab8a00b0016a7cf2a394mr41982956plr.26.1657050363017; Tue, 05
 Jul 2022 12:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220616174840.1202070-1-shy828301@gmail.com> <20220703161422.71e0c7316cca0442c682fcaf@linux-foundation.org>
In-Reply-To: <20220703161422.71e0c7316cca0442c682fcaf@linux-foundation.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 5 Jul 2022 12:45:50 -0700
Message-ID: <CAHbLzkp=LnwkYKQKaFyoMc3BgkcuViKdpF2H+Ymq9Q=gKZwRZA@mail.gmail.com>
Subject: Re: [mm-unstable v5 PATCH 0/7] Cleanup transhuge_xxx helpers
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 4:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 16 Jun 2022 10:48:33 -0700 Yang Shi <shy828301@gmail.com> wrote:
>
> > This series is the follow-up of the discussion about cleaning up transhuge_xxx
> > helpers at https://lore.kernel.org/linux-mm/627a71f8-e879-69a5-ceb3-fc8d29d2f7f1@suse.cz/.
> >
> > THP has a bunch of helpers that do VMA sanity check for different paths, they
> > do the similar checks for the most callsites and have a lot duplicate codes.
> > And it is confusing what helpers should be used at what conditions.
> >
> > This series reorganized and cleaned up the code so that we could consolidate
> > all the checks into hugepage_vma_check().
> >
> > The transhuge_vma_enabled(), transparent_hugepage_active() and
> > __transparent_hugepage_enabled() are killed by this series.
>
> I plan to move this into mm-stable later this week, along with two fixups:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-thp-kill-transparent_hugepage_active-fix.patch
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-thp-kill-transparent_hugepage_active-fix-fix.patch

Looks good to me. Thanks for the heads up.
