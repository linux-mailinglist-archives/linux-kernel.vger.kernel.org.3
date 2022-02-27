Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070074C5A83
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiB0Ksb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiB0Ksa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:48:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1BDF06;
        Sun, 27 Feb 2022 02:47:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD97560DF6;
        Sun, 27 Feb 2022 10:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B266C340E9;
        Sun, 27 Feb 2022 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645958871;
        bh=JrHWJq89JDuxIYmnAtbEFGgKSH6szwmPhzsxmyxcnQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W727a7RzCiUJrXwPw3CKpLIDObN2aC9YtBvB3PvLp0tIAQGLC9mzFen5gXBU9lx8n
         e0EJXI2YiChIafT9elxTaR2sjjx0kre11LP5p6aduuihB0uIKA/uZ1l43u8qg/ym91
         n8KDJd04FfdHMwCNL7Kf89Ry/1ZuJjZlJFYFRG4EMvqLyxQIDjEZmfsDujG02umWvv
         D87wMs863G+JH54UlM/pK/M4eAYRjJj4gtpET43DByb5n5EmkfbE9EBpsl3FNm5vxS
         SYMLivDbW3qKLBPqYleD3pA48LuO68nmcbReNhWpAtcSQt38tamkjJx6Wm24G9tdck
         GNaIciIecl3Gw==
Received: by mail-yb1-f175.google.com with SMTP id p19so14816330ybc.6;
        Sun, 27 Feb 2022 02:47:51 -0800 (PST)
X-Gm-Message-State: AOAM53359t882v5ryV0hpbUyNs6rSnBNaozYa/N8g/uga2reRjcH75b8
        TOM/+ida8bKlPZJK0+aphQkdGX5Vr9EK5Yeje8A=
X-Google-Smtp-Source: ABdhPJzEZKppi44Pt6B7Hu8NOD6gq9Ewfe340HmuOXkpkf6KGcbLgM0ggYClfB6SynaBtKRmwD6nnypCZgE41692rJ4=
X-Received: by 2002:a25:9d81:0:b0:622:7df3:ff6c with SMTP id
 v1-20020a259d81000000b006227df3ff6cmr14336869ybp.617.1645958870297; Sun, 27
 Feb 2022 02:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20220226220639.1173594-1-Jason@zx2c4.com> <20220226220639.1173594-3-Jason@zx2c4.com>
 <CAMj1kXGRjdjbedQTU8ab+Q4jJPnN7nxc8_4QNiG3R7JE=zk-wA@mail.gmail.com>
 <CAHmME9rPd8Nu8Q0+R6B4Bz-caKpq5SSvLaiKdwXcyNHY8Ebfqg@mail.gmail.com> <CAMj1kXEwsyPcoTvK6PZyA5L3q9u_dd_wXUiyHw7TtPM5LecP7g@mail.gmail.com>
In-Reply-To: <CAMj1kXEwsyPcoTvK6PZyA5L3q9u_dd_wXUiyHw7TtPM5LecP7g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 27 Feb 2022 11:47:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHAeqrPjMZi_VD6fYWXatV5UUy5N3ZbtZf=SaDpN3GPVQ@mail.gmail.com>
Message-ID: <CAMj1kXHAeqrPjMZi_VD6fYWXatV5UUy5N3ZbtZf=SaDpN3GPVQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 at 11:30, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 27 Feb 2022 at 11:03, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On 2/27/22, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > On Sat, 26 Feb 2022 at 23:07, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >>
> > >> From: Alexander Graf <graf@amazon.com>
> > >>
> > >
> > > Please don't invent patch authors like that. Alex's patch that started
> > > this discussion was completely different.
> >
> > Considering the investigative side ("why won't the _CID match?") and
> > most the commit message were Alex's, and that those things comprise
> > 95% of what this patch is, and that the code change itself isn't even
> > part of anything Turing complete, I most certainly did not feel
> > comfortable stripping Alex's authorship. Instead I added myself as a
> > co-author at the bottom. When in doubt, err on the side of crediting
> > others. Alex also took a look at this patch, I am under the impression
> > of at least, before it went out. Let's minimize the paperwork
> > policing, okay? I think it'd make for a much more pleasant space here.
>
...
>
> Please stop with the ad hominems in response to criticism on factual
> aspects of your code. Putting someone else's authorship on code they
> did not write is not cool, and pointing that out is *not* what is
> making this space unpleasant.
> And 'paperwork policing' is sadly an important aspect of a high
> profile open source project such as Linux.
>

I typed this before reading your message on IRC, which reads:

"Alex looked at that patch before i sent it out and did not object to
me keeping his authorship. I wouldn't have sent it out otherwise."

and so I stand corrected if this is true. But please, next time,
please be more clear about these things.

-- 
Ard.
