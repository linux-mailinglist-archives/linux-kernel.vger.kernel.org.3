Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4146A91E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350071AbhLFVLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLFVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:11:45 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C27C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 13:08:16 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z8so11621068ilu.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 13:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIBC6uZiK3qw8zipA5+LmK5bPUNLM9r4EQ+nUCy7/lw=;
        b=INmG1BwTmj3+cLahz2Xuw59SFmU2O7hk4q8DxKCvFawc/lbK2rXo6XlOH03eaPjJ4r
         BkDoSUJcr+fAOGsor2ZV2CbxjFT3X26JcoCou1+1uSpvNOQEQ1e9KooYEIyeKSD2XVgA
         /DlU+Uz1n/6XV5VuQ7ZHCzAtjDtYyuiyQQDVnPKbEYxP2rgLtMFPbjnu/j7LPlk/OG1D
         etunBOsfbZvM5gNAGTw7RasfrrC1MgYuR9BGvNrAoE6DqXpY9QGxYzamtjR/gWj6g9bM
         FY/UaLBaBdKlmP1HU9jx4XOn9nCuSoaguRiF23ow+qany12dOU7p+osWvOTIcqxNz3vc
         fboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIBC6uZiK3qw8zipA5+LmK5bPUNLM9r4EQ+nUCy7/lw=;
        b=CPFojPSYz5LtxdG3UzWjHJ8BfTV/qQOJMPNuw/mwHxiE1nVFyoJWuyAot5kOHyC3aA
         9RUUIGdQsvsE3Ag6a9IO/osfIjwx6UH4VtxiGRgQvqMOK8DYfOSC7YnzR7QnrTA/d6hA
         SgEoPyxpHfisJSXD7Qf/TDnwNqWY32PUySVuJ8AebvDtiPV91d2ahycQcj0L20996KZt
         5rfz7Fl2VNwVaH8mEzHRFTfrQJYoplypy6de0/e2ZDjk5o9sEutD8iZPLQg2i8+SOlp9
         mb0aQKWMcSTxczwFF9gEunN3WogZMZl3FcIFA2HbgCCcMxwWSYAyV7L66rXpjeWQ6ExC
         EQhw==
X-Gm-Message-State: AOAM532c9LFZJburVgdbgl4hM9RmF209IcwyNCjlqub6cnaMy9zN9Ig5
        uIZBV46QSY5vKZHN8IvgYOveL++uj6C3j9Z1r4C30007zIY=
X-Google-Smtp-Source: ABdhPJxQCtZ33FUXaFDtaku5StVr7BWXLnYl6zjud+9nZ/VlZL4qwxyr7DiBkwVXyvwGbAcwzOLBk6e4yGawn8E9nBM=
X-Received: by 2002:a05:6e02:1605:: with SMTP id t5mr38923380ilu.233.1638824895522;
 Mon, 06 Dec 2021 13:08:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638308023.git.andreyknvl@google.com> <f405e36b20bd5d79dffef3f70b523885dcc6b163.1638308023.git.andreyknvl@google.com>
 <YajVYNBDOyI3hTx1@elver.google.com>
In-Reply-To: <YajVYNBDOyI3hTx1@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 6 Dec 2021 22:08:04 +0100
Message-ID: <CA+fCnZfuH6GNRQ7m-HU=MSrroe9BMounEuoFTSGJUGGk8=vKzQ@mail.gmail.com>
Subject: Re: [PATCH 20/31] kasan, vmalloc: reset tags in vmalloc functions
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 3:17 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > In preparation for adding vmalloc support to SW/HW_TAGS KASAN,
> > reset pointer tags in functions that use pointer values in
> > range checks.
> >
> > vread() is a special case here. Resetting the pointer tag in its
> > prologue could technically lead to missing bad accesses to virtual
> > mappings in its implementation. However, vread() doesn't access the
> > virtual mappings cirectly. Instead, it recovers the physical address
>
> s/cirectly/directly/
>
> But this paragraph is a little confusing, because first you point out
> that vread() might miss bad accesses, but then say that it does checked
> accesses. I think to avoid confusing the reader, maybe just say that
> vread() is checked, but hypothetically, should its implementation change
> to directly access addr, invalid accesses might be missed.
>
> Did I get this right? Or am I still confused?

No, you got it right. Will reword in v2.

Thanks!
