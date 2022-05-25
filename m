Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A991534484
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbiEYTsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiEYTsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:48:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C742AC68
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:48:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y13so42984326eje.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmLANCeR2PBZsVZiqw/kJbDCZhiOaUsRlXizangKGuM=;
        b=W45I5obeEI7ajyNaRmK7F98XyvnL8ynngJufR193cH3zV4BNBFW72hd3mnApPZbBnt
         kaniX920OyLHOWeWWyqIfxJ7GWqgvbMCQfrbEypEXciUjKaar6UHJbFV360LJ1SNoEVQ
         cCGkVRoYGALQzapuYDw2sIu/qrzwgxaG0bO1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmLANCeR2PBZsVZiqw/kJbDCZhiOaUsRlXizangKGuM=;
        b=SehUVwjR8cyGRebOx1dh6jTRnxKVJ8w1+c9XxrUu6iHAu/5fzU4xQo00s7QD83nYLj
         8KuTXUmj7+AOIrsKroGkcbzVEa14cIcTG8E+/fF49NCe5VM/oK546Zd6Vzo+MCI/UXS/
         XGW/PvD2tSk2ICCMdUXEQEi1uW3A0TAhpbI+qhHTlF4Brff6TOXIEzOUR+yHIY2lpU24
         FyxM8zaJUVuYmYX51JS2hqWHLfS20GDOTwQ7vrhjYHPrjK4KNZ9pnfvJJ4OVVTD7k36V
         ppL+ubmAx4nbAUnqJ9OliR13I9YN7oULNbfqrX78pOtIlki+SMlL2Ca5ISLGNd3JUQVm
         uxNw==
X-Gm-Message-State: AOAM531ImtaO3ENTEftd7iEvanMcwPEh3rng1BovrelRbhJ+CJocn6qD
        +pCPufEXch9zyXpO1nVFkxh6Qpu6lLoWvhiNoh4=
X-Google-Smtp-Source: ABdhPJymJ5PYJj8qT5NplAGqmpxtbsze0UwWWHLB3XBM4bTdxxLl5hTBcLkk1nMgv7KEU99Ky+wfdg==
X-Received: by 2002:a17:907:3d89:b0:6f9:1fc:ebf3 with SMTP id he9-20020a1709073d8900b006f901fcebf3mr15903781ejc.403.1653508086104;
        Wed, 25 May 2022 12:48:06 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id bs11-20020a056402304b00b0042ad421574esm11052304edb.33.2022.05.25.12.48.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 12:48:05 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id h129-20020a1c2187000000b003975cedb52bso28629wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:48:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id
 l14-20020a05600c4f0e00b003976b947469mr4471173wmq.145.1653508084639; Wed, 25
 May 2022 12:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org> <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
 <Yo6HMpEodz36o4Dc@slm.duckdns.org>
In-Reply-To: <Yo6HMpEodz36o4Dc@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 12:47:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4Q2++KfQ4NhMtjmJF_1bjC-573U61o1acuHfqmsvCKA@mail.gmail.com>
Message-ID: <CAHk-=wj4Q2++KfQ4NhMtjmJF_1bjC-573U61o1acuHfqmsvCKA@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v5.19-rc1
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
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

On Wed, May 25, 2022 at 12:44 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hahaha, yeah, I lost my private key many years ago, so gotta get that sorted
> out first. Will do the signed pull from now on.

You have a pgp key for your kernel.org account, you can just use that. No?

(That way I'll also be able to just pick it up from the pgp key repo
that Konstantin maintains).

                Linus
