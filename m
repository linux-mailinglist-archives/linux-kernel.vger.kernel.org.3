Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBEC4E2EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351542AbiCURBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbiCURBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:01:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21F62138
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:59:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m3so13633737lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBQk8rHtEPTg6dv9p8Kge/KgK79GOS20rlTmW/7fX9Q=;
        b=bWURaSxEHcwi/MbE/WuU8Lye1Vi23YYhdUI+3MOmVNwDrY5PlMMtW6JuuZL/XPUuXM
         /xIA10lKeFvophAsWTdRVYSAaJzjOTQwuNZdK8oEQD45026nVACp1JOFN83h5QIaWZvB
         hwG7x5qxPqyG6eqPlvpG/oiOPNsZ5g9rTCBZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBQk8rHtEPTg6dv9p8Kge/KgK79GOS20rlTmW/7fX9Q=;
        b=1PnLA/nQiILcHK3lT3Vob5zBsW+QcZF3zDR8TSf2L7GkjeKz7ua4geV0Uogg5yisaU
         4QMI/tSsUeY/3Hndu7fX26/9VaDnQRfgehTg4K+JYb1wef9T57JpI+o3FcVgeawj0DiW
         8HMWo17uzMfrtb/bSl6nR4fZqE5qe37gHoEtLLRuv4oBrItZXiOlWhmJ9ydse9CacfCS
         xrINOFMPXyr0zpEX4YCPratCkX6dPBDAnyt+snos2hPZT6URdCpPJLIwvS/mRhan22Tj
         rmUu1W8cmxZjmFG3aIUebprU8Qu0YBBFwCkolC6S4LLQApqVROhI2OYIjTW1g2zbBdQx
         u87Q==
X-Gm-Message-State: AOAM533iKKCXKK35uLXTu+rPHDizgju+LPYgyO6ph7R1qxTwzWecwgcH
        UBIz6qMj4z5IzBQK3d5TWVZOw4caA6wPd8FAObU=
X-Google-Smtp-Source: ABdhPJyDzA1BSG84z4fZ43UrYR1WflUj6x+FN8nphUjUIndILyLyUs6UC6FF6rq1sUVGSfXSvL3b4w==
X-Received: by 2002:a05:6512:10d4:b0:448:9691:435e with SMTP id k20-20020a05651210d400b004489691435emr14742243lfg.465.1647881975424;
        Mon, 21 Mar 2022 09:59:35 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m28-20020a19711c000000b0044a1fd4133asm746455lfc.215.2022.03.21.09.59.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:59:34 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 5so7434885lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:59:33 -0700 (PDT)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr15608242lfj.449.1647881973238; Mon, 21
 Mar 2022 09:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn> <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com>
In-Reply-To: <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 09:59:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj81Cgjb5xj=ghB0oEA4ronnc=WKZLTPGpJYPUn=QcQ5g@mail.gmail.com>
Message-ID: <CAHk-=wj81Cgjb5xj=ghB0oEA4ronnc=WKZLTPGpJYPUn=QcQ5g@mail.gmail.com>
Subject: Re: [PATCH V8 00/22] arch: Add basic LoongArch support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 4:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> This looks fine to me for the most part [...]

So it looks like this is getting there.. Do we have a way forward for
this to be merged?

I obviously can take the patches, but it would be even nicer to have a
pull request, and you'd be the obvious person since you are - whether
you like it or not - the "odd architecture guy".

Hint hint ;)

            Linus
