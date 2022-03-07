Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3B4D03A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbiCGQFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiCGQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:05:33 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF590CF4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:04:37 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z66so12267557qke.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OjzcdCTb99taAtaL6GPlFbWqi+FhjWVkGB4/e556R4U=;
        b=ox6tPta8YwL2Xk8xDu6PuHGwEzuqo1lzn0J4GWisxTzmj43LGUC6tUivThWgTSSSB8
         5/+hWpvh+oULOA21bIx2EGLbrTePahI5laqCzObnIeBq7JGkjhIE5B7ikWHw/+lZsGjg
         GaGVc9HICE+7+FHzmgw3/2IFgvM31rp+4urN5sQUolgLvUWhHyo2dkD4yOe+s71DJuF1
         tjTKJGEflPBfHN7ouI5TwhCBzPaiqCiWn7fGbJOS+peNt6bVpW1VZWfmZj8HTkwGf07n
         MjLhPtQ1s9MV0HirqdbCuYkXqdfcuJdx7fXKyWYzYavA4LHYcf2lSf0i4AZw7Vdcat9D
         9TrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OjzcdCTb99taAtaL6GPlFbWqi+FhjWVkGB4/e556R4U=;
        b=CjTaZ3TAa99cZvU8WzEJX4Quf8kBMrYfhnrAJFIuPgJi5zgRUQTVrIrZ0ATkl8XG8t
         tPOQ+6wTXhxO6fFcfodqYefpQ3/7jnuHEyZNJME8CopKl7RI2NOnb6TkE1b+xNE/Fzwr
         rP8AME1AoOpiWATWLTT5OAzUAVheJ2TbzCuPTirej+K+YqFwDkpF6aqArsQV2opyz2TW
         zXR12p0tXsgySlUfhQBxC23xweFjhLYLBE8hl7RyVcrCey/vTrJyPE6UkxeDjJVqlqHA
         cOTiruCGBvp8HkCCGsswrPd1oe9puIA2y1nF8NtZOkdLWvhqmA7BqXlv5l2jZiW9dAM/
         LAEA==
X-Gm-Message-State: AOAM530tvm8fUjxgmQuMr6pLOLYOdjMhyZ8eua6oKPP8gz+UKvXBhGS1
        DVtA1fbWToP+fyiZPE7zZc+T/EBJ/SU=
X-Google-Smtp-Source: ABdhPJzoJOkWoY4V58wJCr9j+N3yxEAXmoI6vyCNgqZCZ8KZ+c1JQzvLoHqq0iK3s6znaLXJAFcBkw==
X-Received: by 2002:a37:a845:0:b0:63b:b65c:ad11 with SMTP id r66-20020a37a845000000b0063bb65cad11mr7124568qke.574.1646669075871;
        Mon, 07 Mar 2022 08:04:35 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm462989qkg.60.2022.03.07.08.04.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:04:35 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2dc0364d2ceso169718407b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:04:34 -0800 (PST)
X-Received: by 2002:a0d:e288:0:b0:2db:f50a:9d10 with SMTP id
 l130-20020a0de288000000b002dbf50a9d10mr8936379ywe.419.1646669074230; Mon, 07
 Mar 2022 08:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20220301144453.snstwdjy3kmpi4zf@begin> <CA+FuTSfi1aXiBr-fOQ+8XJPjCCTnqTicW2A3OUVfNHurfDL3jA@mail.gmail.com>
 <20220301150028.romzjw2b4aczl7kf@begin> <CA+FuTSeZw228fsDj+YoSpu5sLaXsp+uR+N+qHrzZ4e3yMWhPKw@mail.gmail.com>
 <20220301152017.jkx7amcbfqkoojin@begin> <CA+FuTSfVBVr_q6p+HcBL4NAX4z2BS0ZNaSfFF0yxO3QqeNX75Q@mail.gmail.com>
 <20220306192238.fbvp2t32fsemqssf@begin>
In-Reply-To: <20220306192238.fbvp2t32fsemqssf@begin>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 7 Mar 2022 11:03:56 -0500
X-Gmail-Original-Message-ID: <CA+FuTSf9UoEC0aZOXzh8jdhxXMXftxv8icdns5auObAJiB+jzw@mail.gmail.com>
Message-ID: <CA+FuTSf9UoEC0aZOXzh8jdhxXMXftxv8icdns5auObAJiB+jzw@mail.gmail.com>
Subject: Re: [PATCH] SO_ZEROCOPY should rather return -ENOPROTOOPT
To:     Samuel Thibault <samuel.thibault@labri.fr>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        willemb@google.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 2:22 PM Samuel Thibault <samuel.thibault@labri.fr> wrote:
>
> Hello,
>
> Willem de Bruijn, le mar. 01 mars 2022 10:21:41 -0500, a ecrit:
> > > > > > > @@ -1377,9 +1377,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
> > > > > > >                         if (!(sk_is_tcp(sk) ||
> > > > > > >                               (sk->sk_type == SOCK_DGRAM &&
> > > > > > >                                sk->sk_protocol == IPPROTO_UDP)))
> > > > > > > -                               ret = -ENOTSUPP;
> > > > > > > +                               ret = -ENOPROTOOPT;
> > > > > > >                 } else if (sk->sk_family != PF_RDS) {
> > > > > > > -                       ret = -ENOTSUPP;
> > > > > > > +                       ret = -ENOPROTOOPT;
> > > > > > >                 }
> > > > > > >                 if (!ret) {
> > > > > > >                         if (val < 0 || val > 1)
> > > > > >
> > > > > > That should have been a public error code. Perhaps rather EOPNOTSUPP.
> > > > > >
> > > > > > The problem with a change now is that it will confuse existing
> > > > > > applications that check for -524 (ENOTSUPP).
> > > > >
> > > > > They were not supposed to hardcord -524...
> > > > >
> > > > > Actually, they already had to check against EOPNOTSUPP to support older
> > > > > kernels, so EOPNOTSUPP is not supposed to pose a problem.
> > > >
> > > > Which older kernels returned EOPNOTSUPP on SO_ZEROCOPY?
> > >
> > > Sorry, bad copy/paste, I meant ENOPROTOOPT.
> >
> > Same point though, right? These are not legacy concerns, but specific
> > to applications written to SO_ZEROCOPY.
> >
> > I expect that most will just ignore the exact error code and will work
> > with either.
>
> Ok, so, is this an Acked-by: you? :)

I did not touch this code on purpose, due to the small risk of legacy
users that expect 524.

If you think the benefit outweighs the risk --the same conclusion
reached in the commits I mentioned, 2230a7ef5198 ("drop_monitor: Use
correct
error code") and commit 4a5cdc604b9c ("net/tls: Fix return values to
avoid ENOTSUPP")-- then I can support that.

But like those, I think the correct error code then is EOPNOTSUPP. And
the commit message would be stronger by explicitly referencing that
prior art, and the fact that those changes did not seem to cause problems.
