Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A14E58CC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiCWS6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbiCWS6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:58:08 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF9A6E791
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:56:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 17so3171393ljw.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmPDsJkSrAAbMJykPPwq1s0WUeIHZeMEuSa1hiimVGA=;
        b=Es2M5DgEXhH/Ep7yhueHZTOSKfWO0VITKrgCVguUF39W8tD9s58Od4YEf4VPCUrS4H
         rG27LpUqTC/Zk//LDj97W72IS3O/BFaf5UOC+FT9kohGVCbqp6ywQK5PrSOJJc/n1x/U
         zc2Mwhx4iloaHaobkp7R81DNvXiXnWnahHlJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmPDsJkSrAAbMJykPPwq1s0WUeIHZeMEuSa1hiimVGA=;
        b=Dj+1XkvMjrKiJ2LHerAkUy2NX9qwZVaj0F1ZsLLXnsSPjZ9kTWlFIEZfkCIaSLqVSb
         Al13FTCLBm8HyiMqKqZocxyhCIxR19FJ3s91j1PWcHFkwLXRDVskgT2/irhR2/ietK1n
         Ea10pK7W+kqxyseq8mbSrXrSeWrdqi2FZXdTC4TCltyViao6F3hHfd88fIOI/C4d/pPq
         oP1MEw4HZuOd2AMRtyPfw5VdDZW+9znvvgNFHaPUSNNQ0StPbeh06LUOvZizv9QgFCw0
         kxVkQLfAugishJY+SvEHiHmTbt2bu7HVqt7VGEtSghdoMbPzSsCnHdFukO2i1mpwZrbV
         TF6g==
X-Gm-Message-State: AOAM531Popcpm7Y4xKg3sZDVqE7MuXHb6zNouyGK5AlMLC0UEjwcrV9J
        v1Mqrp8L6KT87eRB+rma+rBSveJal9rGeEA43mM=
X-Google-Smtp-Source: ABdhPJzGfjz8ykvfUUfqYQFhvjfUsNPPHTEcFsw/dxcnkBOSvv1TarHn9Ht7Gu1q3FWiDe+etBGtpg==
X-Received: by 2002:a2e:7a1a:0:b0:246:210:65cd with SMTP id v26-20020a2e7a1a000000b00246021065cdmr1199197ljc.99.1648061796375;
        Wed, 23 Mar 2022 11:56:36 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b21-20020a0565120b9500b0044a2274962asm64418lfv.130.2022.03.23.11.56.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 11:56:35 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h7so4274113lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:56:35 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr932839lfu.531.1648061794745; Wed, 23
 Mar 2022 11:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220321105621.3d4a9bc6@gandalf.local.home>
In-Reply-To: <20220321105621.3d4a9bc6@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 11:56:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3_p98e_oohGZzfkDPaJFLKEW8C6mS9dhuKgLN8PNitg@mail.gmail.com>
Message-ID: <CAHk-=wj3_p98e_oohGZzfkDPaJFLKEW8C6mS9dhuKgLN8PNitg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for 5.18
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Mon, Mar 21, 2022 at 7:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> My tree has a branch called:
>
>   trace-merge-next-20220315
>
> That resolved both of the above issues.

Oh, and that was completely pointless.

That isn't actually a tree that shows the resolution, that's literally
the linux-next tree.

So I did my normal merge, and then after that decided "ok, let's see
how Steven did it" and did my normal

     git checkout -b test-merge HEAD^
     git pull ..yourtree.. trace-merge-next-20220315

but that doesn't work at all because your trace-merge-next-20220315
has not just the tracing tree, but EVERYTHING. So it just conflicts
EVEN MORE.

So that "trace-merge" branch is only pointless noise. For it to be
useful, it should have contained the conflicting stuff, but *only* the
conflicting stuff. Not everything else too, that just causes even more
conflicts.

Anyway, when I actually compare my resolution to what is in
linux-next, it turns out they are fairly different. But I think my
resolution is the correct one in that it actually makes the sockaddr
cases match the other cases, and the original patch that added them.

I'm not particularly happy with my resolution either, but that's
because I'm not super-happy with that code, but whatever.

               Linus
