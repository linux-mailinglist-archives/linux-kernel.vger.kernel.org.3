Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A1D58B2BA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241608AbiHEXVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiHEXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:21:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE241D0F2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 16:21:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m4so7448799ejr.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iJnXDkhY3WibcgHqNJ/apiNs6qhmQXpZMLsKos5BMCQ=;
        b=eFUwGAvhoJ8EEYaGa/arj7adR8QlkncfXKcdX7iXgroj9yZ+Gm7dJ7Ts8/p6/xX1J5
         x2r64ctbmyaFhx/lwup2rv3LDgDyHASHgKfhjxJiW6vrzdpSBUQpTRk11nT06VQg+LMi
         l9uKIxCdZxEdhmLdSRr30emGV+zBPUQDQ3YRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iJnXDkhY3WibcgHqNJ/apiNs6qhmQXpZMLsKos5BMCQ=;
        b=E3WcEbEzVEOy8WjUP0hK/P4xqn4/DWkoYPruQEg+JEvzm/8yw/mxzy/hf36lk9G183
         gzGkwHRVSkB42yfegSvmuRcj9L1811oCOSurUEQJ3wKC/44zsmg7/SB9g5QdgSZJ2Cp9
         vBv5gkZHtgeeH1QlDMdMRURT38VFECqLiof1fp8pI0MMX5HhAmdoOcYTnjOKtIP0XJf2
         GQ3eQiBtSm5KoBZnVQuriVD7fFmBBNr1+rqBNB7mQfvlopPbV6G2WGbrPr95ZxEdEaKL
         2WN/07zTJJ4b+UZebcK8Ua2L1RgIfrSDuSaMgWVsJoSOWT0yrD0O/9q0B6FBY4sopOpQ
         z7KQ==
X-Gm-Message-State: ACgBeo0RWaF7Vl/sWEWHmlphdM3YLcjMu7Mlow5kC+B6/+Nnz2h619WT
        dnwLzWCzTCyvjgkCk4cuYYfWuVxAUHghF+5k
X-Google-Smtp-Source: AA6agR75d0gH/FGh6g4hAyW3MAD2UBwlM4m71fCYL3m3wU3Kg9oC4EcUmoM0hCMLC0UFtkZlJQGN1A==
X-Received: by 2002:a17:907:7292:b0:72f:d76:b243 with SMTP id dt18-20020a170907729200b0072f0d76b243mr6781374ejc.230.1659741662242;
        Fri, 05 Aug 2022 16:21:02 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b00730223dc5c0sm2054168ejh.206.2022.08.05.16.21.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 16:21:01 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id v5so2056243wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 16:21:01 -0700 (PDT)
X-Received: by 2002:a1c:f603:0:b0:3a5:23ca:3e7c with SMTP id
 w3-20020a1cf603000000b003a523ca3e7cmr1634050wmc.38.1659741660817; Fri, 05 Aug
 2022 16:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
In-Reply-To: <20220803133541.18b82ec9344ed0e8b975fe5b@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Aug 2022 16:20:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheFdrnTLNhw6+2ekT_AuJHXHTWEKVQyJrA864mmjFKtQ@mail.gmail.com>
Message-ID: <CAHk-=wheFdrnTLNhw6+2ekT_AuJHXHTWEKVQyJrA864mmjFKtQ@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 5.20-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 3, 2022 at 1:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> There are 6-7 conflicts with your tree here.  All very minor, mainly
> related to the rename of Documentation/vm to Documentation/mm.

What? No. Yeah, the doc conflicts were annoying enough, with the
Chinese translations having incorrect pointers to the original sources
both before and after the move in the MM tree.

But that xfs conflict was positively nasty and definitely not minor.
Had to look up Darrick Wong's "here's how to do it" message from the
linux-next days.

So I think I got it all right, but "very minor" it wasn't.

              Linus
