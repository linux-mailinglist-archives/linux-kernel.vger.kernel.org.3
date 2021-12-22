Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D076F47D695
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbhLVSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLVSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:24:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D93C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:24:08 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j6so11873408edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwjI5WjqEJvXlWln5tWrz9upl+oWAudEOUBRkDGZ7gU=;
        b=TXPykGi2OP0H6utAQ0R8nox06p1oQC+UBAoRrExluzPVBPTKvWYsOPj8SAB7lLrzlE
         ORahfhEW9AgYTAay27a8eA1QDJZB5oEAw6aTNzqAuhalceNYQ7837B32O5PAU0Cer0Sf
         6OujhYp6u5HY35w6fQkmvjj8swqa3BcqfbTT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwjI5WjqEJvXlWln5tWrz9upl+oWAudEOUBRkDGZ7gU=;
        b=AfKYHvh0vs5CaxBAAyhpxA56O2J4h4oOseACf1pKIOVnL8mWwwf970RGedz5xVmpRA
         E4PlXYm4c/kmyNv7FyFHMx+mivjSiddDfjtnWwq3sucA9eemNOOFJZ+o8Qz6v3oVmwLT
         wlTm1rxZnPBT95hTedsVS8WPVCLb3ZnnKppurGUMK1QaUihWs1MCgb8zSgyFQ+/qG9TI
         TbfiMOgJfNuWvdiZ99/EUi66gZnpKJeVijBceYQV3tQN05o28EpGF5nDDngD5JWNGObD
         fJnDDzYUsyK7eIDDgoG8sfoUy7h9lJxk5DAKdY9qKoysJ+Up94wGTeQHpnMKsdp+OOK/
         g0wA==
X-Gm-Message-State: AOAM5328b8rAS0RSlVWIiIBtyAfeD8fBseSrXFm0tAWHeUUe0PcDOuyV
        ecTzSSWHiCX89Su+qp8/BH47n4hKGp+Sk//k730=
X-Google-Smtp-Source: ABdhPJz+aQH65KVmwJxZdafnQ5ZLqJF2Nv6y877wUHk8pxRIlUS3gJGD9HRQ03dGSzV3sel7JGzcXw==
X-Received: by 2002:a17:907:96a6:: with SMTP id hd38mr3412193ejc.479.1640197446401;
        Wed, 22 Dec 2021 10:24:06 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id i9sm979581ejw.170.2021.12.22.10.24.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 10:24:06 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id g132so2177176wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 10:24:05 -0800 (PST)
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr1737462wmj.155.1640197445468;
 Wed, 22 Dec 2021 10:24:05 -0800 (PST)
MIME-Version: 1.0
References: <YcNltr7TxsAe+fzP@kernel.org>
In-Reply-To: <YcNltr7TxsAe+fzP@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Dec 2021 10:23:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg+Dv9XwquznVFN7Sw5x=DZ1EuZP3tqSS6KmSEQ8Hpnzg@mail.gmail.com>
Message-ID: <CAHk-=wg+Dv9XwquznVFN7Sw5x=DZ1EuZP3tqSS6KmSEQ8Hpnzg@mail.gmail.com>
Subject: Re: [GIT PULL] memblock: fix memblock_phys_alloc() section mismatch error
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jackie Liu <liu.yun@linux.dev>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 9:52 AM Mike Rapoport <rppt@kernel.org> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock fixes-2021-12-22

No such thing.

I see the 'fixes' branch that contains that commit, but not the tag
you're pointing to. Forgot to push out?

          Linus
