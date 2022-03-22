Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C7E4E4629
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiCVSmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiCVSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:42:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9E67E089
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:41:06 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u3so25281448ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hTMbyYeigRQeN9QMQvqrXsCNDpWwIiaSK6s7Jke5nc=;
        b=CaHFN2rKysBv+YFPDeAFoLOQngE5Gp0VZxxBT90z5DiJiOEkx38lbvNAdq2/lbVB7j
         kdVL1/S5eao5imxibMgio72pVYq4O3PSUZ2m90JZ6XUxs0TUfHSTcpsbUSu/J4T+A3EO
         dagc1fuIVmItQKgNEjj6BcgvbsHF5EymzQxq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hTMbyYeigRQeN9QMQvqrXsCNDpWwIiaSK6s7Jke5nc=;
        b=6zgM4ivFVNKuKdRyS1pFyaw610pWBsg2VbzLys0CSsWS7qAsAIUitvAsvcQNik/YcH
         puGSQn0JlfqXxQ7Wk9lLrg93qBWsP0IaO6KeusWErEaB6nkx/jY6xwqoUHTpnp2W8SZA
         8wRfFt7cUh4i47wEwPQXjFxJX6Ghqd8Ytwb6kEYChuUTvA//zFNNQiBD6lMghhXqeUPO
         qY/eOuCN+DmZbKahXExJ9LVyEjcWmTkmO9B+tXxnCY6XFlZ4OYRbRU5ipcOHzZiRzAHv
         3onrkrEENS8MF/i5husu0fHZfKU64nWWVP3ffrNmUGAAK85VFe6KO/KaYixZKoWYssO9
         J+Aw==
X-Gm-Message-State: AOAM531e0nBoJ6J5jR2oXB7C6UVCuEhWjUrKYkscmYMcTnNtgfLXHAJT
        TWcdqTV6qgS0QZ7p1CXj1Hz3UtxNM1z+A4PMvX4=
X-Google-Smtp-Source: ABdhPJxxqmaJfXKAJwWDQMRnrWbrLrHi5bdvdqWUqk1BQJBQN4Hkm3VkMYWe7lLri2z7pYZkl0oVRg==
X-Received: by 2002:a2e:8610:0:b0:249:7bc4:bbb8 with SMTP id a16-20020a2e8610000000b002497bc4bbb8mr12215540lji.370.1647974464533;
        Tue, 22 Mar 2022 11:41:04 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z13-20020a195e4d000000b0044a49605b88sm46593lfi.50.2022.03.22.11.41.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:41:04 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id u3so25281363ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:41:03 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr20230108lja.443.1647974463703; Tue, 22
 Mar 2022 11:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220322164655.83229-1-Jason@zx2c4.com>
In-Reply-To: <20220322164655.83229-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 11:40:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnK3eG6+=Q7MgcLEKAny1Eqdc9XKyq5W49Dz6x1bHAqw@mail.gmail.com>
Message-ID: <CAHk-=whnK3eG6+=Q7MgcLEKAny1Eqdc9XKyq5W49Dz6x1bHAqw@mail.gmail.com>
Subject: Re: [PATCH] random: go back to not blocking in /dev/urandom
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 22, 2022 at 9:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This reverts commit 6f98a4bfee72 ("random: block in /dev/urandom").

Just a note that by the time I saw this, I already had my own revert
in the tree.

It's pushed out now, as commit 0313bc278dac.

                   Linus
