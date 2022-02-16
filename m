Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5024B8280
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiBPIFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:05:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBPIFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:05:32 -0500
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3F2225D02
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:05:20 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id w4so1576974vsq.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypJwYqHXPE7+OZ6ZFQc5ZOyLgQjz7Ks3XYn9nG1mEao=;
        b=UReJ6SGYWYpZUql1yK8+8nVaMvWKX7ZTRWiAGoNTgAwUZHvuWr+Gkd2zcQDJJFGc0X
         efJOanfzZpFobjSsxRzDaHGtg0o26t91vT621VH9c3v73g3qEJOa1U0u4bCHAqcH7G5M
         VgYx2JxwN8OaORfWz1gAfi2ETnpWfsFSkTFqKuBKf92chmmji5wd0i4z/aUVkCA5LvZ9
         qp6t1KeUy4LCkm1Fa4LOh+oD0P23d8Vq9QJv1k6HeQ+VbJKj06khjRNePop7Qnl0900R
         97gZAjcvPT7P1bqtcqzNWsA9+8aWy4NjUXxPig5C8ECvhm1XxVCQY04dPFOeOsTd7bAR
         4HeQ==
X-Gm-Message-State: AOAM5311b8f0hRiPECACbr+lhlYOqpzTvEL4m869NH9ASHFDV2SwS1Dv
        +Pna6wefKIgs3Y6RbTVyyCpN5LHOjUTfBg==
X-Google-Smtp-Source: ABdhPJxCyiuumZOW0oTthtvZUfbjwYG5YFpiwyP8RdZVKk2Z+16C6Btm9qeQ5M4Da4RqsRrUJVrxxw==
X-Received: by 2002:a05:6102:358d:b0:31b:c683:305e with SMTP id h13-20020a056102358d00b0031bc683305emr233618vsu.30.1644998719438;
        Wed, 16 Feb 2022 00:05:19 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id l5sm1521111vsj.17.2022.02.16.00.05.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 00:05:19 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id f12so828570vkl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:05:19 -0800 (PST)
X-Received: by 2002:a05:6122:8c7:b0:32d:7e3:96c8 with SMTP id
 7-20020a05612208c700b0032d07e396c8mr642579vkg.7.1644998718873; Wed, 16 Feb
 2022 00:05:18 -0800 (PST)
MIME-Version: 1.0
References: <20220214093704.1773948-1-geert@linux-m68k.org> <6f4af4c2-3ac0-a4d0-96c7-7164417cb8d7@infradead.org>
In-Reply-To: <6f4af4c2-3ac0-a4d0-96c7-7164417cb8d7@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Feb 2022 09:05:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9Po1V5yH+gHzUJGx8NLcoCUyBa4FF41eH9vDbQWBW8w@mail.gmail.com>
Message-ID: <CAMuHMdW9Po1V5yH+gHzUJGx8NLcoCUyBa4FF41eH9vDbQWBW8w@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.17-rc4
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Feb 15, 2022 at 10:14 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/14/22 01:37, Geert Uytterhoeven wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.17-rc4[1] compared to v5.16[2].
> >
> > Summarized:
> >   - build errors: +14/-2
> >   - build warnings: +23/-25

> > 23 warning regressions:
> >   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14410): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>
> This is a little confusing. Was there a problem with qed and qede network drivers?
> Is it still a problem?

Yes there is.

> Many of the lines above and below are very similar.

Sorry, my script to filter out errors/warnings that just moved does
not handle modpost output yet.

> If there is still a problem, what $ARCH and config(s) cause it?
> I can't reproduce it on 11 $ARCH tries.
> Or maybe it is compiler-specific also.

xtensa-gcc11/xtensa-allmodconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/14697521/
I don't know why it doesn't show up in the other gcc11 builds.

I had a look at the problem before, but fixing it is non-trivial:
the driver uses a non-init table of structures that contains pointers
to init data (only used early) and non-init data (used later, too).
Sprinkling __ref over the code may help, but won't protect against
introducing new bugs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
