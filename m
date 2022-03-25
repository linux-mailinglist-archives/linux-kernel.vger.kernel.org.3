Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B484E7CC8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiCYUxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiCYUxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:53:49 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CDD506F0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:52:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o6so11801536ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XL7fBu7OlctI0zNy/cRZjH1z0Pexf4s0Ro6kC1bg2Jk=;
        b=AjRN4k8UeL2cFoATtOl9IzjPGEPyOHgc88Tmu//hjPBbsK3rLRCNQdg2851c1HEIPC
         xKcH0Ukwii4dYTVeW4/2KYbdP/m0owF7DP4+ATYYsLWBiEKXu27Z/3nvqHCpqgkpX5hl
         KSqxiPB/26Mci+r/n2Q0/Qd+UvhHfRz3ATDek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XL7fBu7OlctI0zNy/cRZjH1z0Pexf4s0Ro6kC1bg2Jk=;
        b=jL8e+GD2Tg3UiEf6mzVrcQv0rhL4ho0SDU0XQvnAnC10HGEIfn7Nu8jesidCy5LN9M
         aDT0CCCSORXdeWrUltzQ1Nf/A7XraN/JU7Mpy6IeQ6+c70oTf/FjNfXW01BKyahOPqmv
         Ly7qNXePSVnVl2mwSQ+eCddFVlZgUmFC6YjtvqkrTkO4X0I5LVta0P90eDnM3azy1ezD
         KkERvhCNZqPOGcVBNzl2SQ4X4r2fDPZnMnm3oXh/UCf+uFcO/FeEzNGp8bw5vtCwsD2g
         etMbOmxX9wG5U0Pos+lQWwHVN1lQwtHTaE1Kq0dqbzrWmXzVTJEZuXRbVlT6ZFX7SD/H
         Xz0Q==
X-Gm-Message-State: AOAM5306AR8vEvinG6dZCpmBV+7kQS0vX/m12s17z6o7WwQS2MUmXobH
        AVhvT144aFuVzPnB8wYUbNDmZJ0hWESeYnkldV4=
X-Google-Smtp-Source: ABdhPJzdMLH+eHzBthtECbnvhHdsAYbhdYeUhAn++P+J2B/tJlOvoVwZFfJ17dUzZMpp/Cvz66eEdA==
X-Received: by 2002:a2e:87d4:0:b0:249:a34a:2532 with SMTP id v20-20020a2e87d4000000b00249a34a2532mr9698635ljj.328.1648241532140;
        Fri, 25 Mar 2022 13:52:12 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w15-20020a05651c118f00b0024957c859dbsm803950ljo.50.2022.03.25.13.52.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 13:52:11 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id bu29so15389597lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:52:11 -0700 (PDT)
X-Received: by 2002:ac2:4f92:0:b0:448:7eab:c004 with SMTP id
 z18-20020ac24f92000000b004487eabc004mr9360717lfs.27.1648241531008; Fri, 25
 Mar 2022 13:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <YjtZAvQnshp1pZIh@zn.tnic> <CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com>
 <Yj4orVIbqcyTQcY7@zn.tnic>
In-Reply-To: <Yj4orVIbqcyTQcY7@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 13:51:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR6pCHwvAWQKZ88D1hBuRJsV66ucEnybBiOHskoPsPxQ@mail.gmail.com>
Message-ID: <CAHk-=whR6pCHwvAWQKZ88D1hBuRJsV66ucEnybBiOHskoPsPxQ@mail.gmail.com>
Subject: Re: [GIT PULL] RAS updates for 5.18
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
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

On Fri, Mar 25, 2022 at 1:40 PM Borislav Petkov <bp@suse.de> wrote:
>
> If I try to make it do a --ff, it still does a merge commit:

Oh, they indeed aren't fast-forwards of each other, they just looked
superficially that way to me because when I did my

   gitk ORIG_HEAD..

after merging, the fact that I had already merged everything else in
both of those branches.

So never mind. It wasn't a pointless fast-forward merge, it's just
that neither of those branches had anything new in them as far as I
was concerned any more.

              Linus
