Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42E848A0C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbiAJUPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiAJUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:15:53 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C0BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:15:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q25so49704199edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEapTfvNdqFS9jG6DA+h63+yWOu3K060tLSEs+AVFko=;
        b=Y8gq6xnRGJFLCoyi+PH1EPWhWtPVgLxIXl8VtSeqtJJiTjBTldk2/K9ymvhPhWmveo
         d9wiPtI8ilLCfSPhDBoZfUDb48mhHT1hILxVmw6KGfiyOss5oU/yXj0fyzg1NrjJmf+M
         DAoNYb4EGK79nCTSUeamaxj+aBZBJ9hCkIxVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEapTfvNdqFS9jG6DA+h63+yWOu3K060tLSEs+AVFko=;
        b=2hvA0u5/dQu8xOqarAqRZ0sQMVWvhMdyw60QTgC0C8afTRK8scgVuH1ItXd5cbXH3N
         lajKJKsoegK+1RFg/yYHnqcoDuHLEGYZpmylTjkiJkUwukvH21FoRdfLt/4rgHSU+QX0
         h75GV9b1raG+2lDXi23y0SwTGOOm3XeAk4iMFGWxgZWfMJsGALqksFWa8vgPR4TTsWKy
         5ghLiGzodtCwVbGbyKQaAWarYLrZnog5Y4rVZZQZSYVwM+0/YDkrcQlRO7zgxjWVcYdq
         s7aVf34jZyr181ch+PAjasg2JyOPaWzCzJ6ciVAjITjuRbMDBkL33cdkHaUN8ZTRsx3v
         8EvQ==
X-Gm-Message-State: AOAM530mr9n+lkVtSkXxtMJd7GjyqqTdiUrVRjKk4AQg4+8s3a9qtWtJ
        SgAUFv8bysXhMtueiVQo1FtvwxO77Txs4xv9whQ=
X-Google-Smtp-Source: ABdhPJzMVNvdYNwxHq6/4MVKw6x79rTXf6/2Nul/k8TsPYDMU/KlB2073zLtUl6/S8yqMD8fUQujqA==
X-Received: by 2002:a17:906:dc8c:: with SMTP id cs12mr1043224ejc.769.1641845751665;
        Mon, 10 Jan 2022 12:15:51 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id u11sm3357384edt.97.2022.01.10.12.15.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 12:15:51 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id e9so27464011wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:15:50 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr1026415wrh.97.1641845750470;
 Mon, 10 Jan 2022 12:15:50 -0800 (PST)
MIME-Version: 1.0
References: <YdwVl0H54fmUIux0@zn.tnic> <CAHk-=wh+UbGrgH4CzKSoTYGPidyv5isiLMxJKAqnV3NFTiRdaQ@mail.gmail.com>
 <Ydx8fUCotPI++UEW@zn.tnic> <265db742-0539-a66f-ff00-2b18cb2add88@intel.com>
In-Reply-To: <265db742-0539-a66f-ff00-2b18cb2add88@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 12:15:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjhf7s91dtCLGbOUWLDNA2vMmSFPWjWtxa8ete=9cLJPQ@mail.gmail.com>
Message-ID: <CAHk-=wjhf7s91dtCLGbOUWLDNA2vMmSFPWjWtxa8ete=9cLJPQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/cpu for v5.17
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 12:10 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> There are four basic options here for TDX:
>
> 1. Paper over the #VE in the #VE handler itself

Ahh, I saw it, but didn't really react to the fact that unlike the
other 'wrmsrl_safe()' cases, it takes #VE instead of #GP.

I do think that perhaps just doing fixup_exception() in the #VE
handler is the most obvious case. It's not like exceptions are meant
to be somehow specific to #GP.

But hey, I don't really care that deeply. I just reacted to this all
looking odd, and I've already done the pull. So it's not like I'm
NAK'ing the whole vendor test, it was just surprising to me.

So I don't want people to feel like they have to do that wrmsrl_safe()
thing, or add a feature flag or anything. I see why it happened now,
and I may think it's a bit odd still, but it's really not a huge deal.

                   Linus
