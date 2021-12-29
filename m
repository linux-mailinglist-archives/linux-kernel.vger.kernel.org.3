Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E2481695
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhL2UNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhL2UNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:13:14 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF868C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:13:13 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id p1so17084928uap.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyxetgwqqKVP5IBUu91uGQzQ3aCB5FMpJM913xOnqWg=;
        b=q6fg+eZmemAfY5nfS4cwNak5iYVJxdYE6g8Kq7IUg09Ndp9YdB6oXUDGbNt42Jk+Q8
         eqn574MEz6dmFeD+aGXkJjmw6S+96iWugotRIy+UIi6c8w6ZqUqmKaiBjl80DUVAogH6
         +lEIXglRbGWd9NesZzK86M4Q8j6QiE4jJ6KO5t0pHRM5iVYCVVoZLcT93+GkRWLcHlZh
         3OQGCIUSPQVl7eAnH1BvxttLboUrUng5h5rnUubgWwYi/xkQJXGIeJpqmXgXkmTXib3g
         DRtmhtYqnBaOwyHa24u5ppKXHaiZHF6U1tyNXz3i4gNLIPcU71ZAZ/nhWr+drnPYw2SN
         CvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyxetgwqqKVP5IBUu91uGQzQ3aCB5FMpJM913xOnqWg=;
        b=VCkb/ON0ovLYUECOU49TlXfsZ6WVa+JjcefFhN5DxNm925q1I0ItplVYldIObiqBBx
         o33b1yniGNvq7PWihapNWhX5iSTipFd2Y26NuMSpV6ZGkbFJUCefjgNakKkdmNJwfVW1
         +Yz8d12i0wWhP0nFrnE+bqRisnLwt3zAJV8JRripH6Qg9FX8HutfIl0AR8BJKdVnEIry
         UI1zCy6z/YPGXlfHGFSQ/fkfACC84Gg5pz/bRoeXKH1ioyrQntEwSK1fAkKlp+i2JRVu
         1sLwfxz9LrZm7dXMu0Ft3CsEDAREoeSKpGxgKQ2t0uZHxaSbX9GsWvszSZIyDDJgtoZx
         A0SA==
X-Gm-Message-State: AOAM532bjkYvVbqIUVKpMZ6Kwj9zG87xSBqaOKxJkfzBOfS3cAiBaLGi
        J+w8D/robH1SYpNwqIn+D3xgW3OAKzs=
X-Google-Smtp-Source: ABdhPJw2xDuNdCgvP9L/RvqKqmJR0cteGh769bPChOZCUpJzb95y6py3rFpJ0hteDB1NiyBYWpYOyQ==
X-Received: by 2002:a67:f486:: with SMTP id o6mr8210735vsn.41.1640808793038;
        Wed, 29 Dec 2021 12:13:13 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id u33sm3743948uau.7.2021.12.29.12.13.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 12:13:12 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id o63so39167124uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:13:12 -0800 (PST)
X-Received: by 2002:a05:6102:31b3:: with SMTP id d19mr8249328vsh.79.1640808792198;
 Wed, 29 Dec 2021 12:13:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-ks9kd6wWi1S8GSCf1f=vJER=_35BGZzLnXwz36xDQPacyRw@mail.gmail.com>
 <CAJ-ks9=41PuzGkXmi0-aZPEWicWJ5s2gW2zL+jSHuDjaJ5Lhsg@mail.gmail.com>
 <20211228155433.3b1c71e5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <CA+FuTSeDTJxbPvN6hkXFMaBspVHwL+crOxzC2ukWRzxvKma9bA@mail.gmail.com>
 <CAJ-ks9=3o+rVJd5ztYbkgpcYiWjV+3qajCgOmM7AfjhoZvuOHw@mail.gmail.com>
 <CA+FuTSe0yPhca+2ZdyJD4FZumLPd85sChGhZPpXhu=ADuwtYrQ@mail.gmail.com> <20211229115708.53ec5f8e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20211229115708.53ec5f8e@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 29 Dec 2021 15:12:36 -0500
X-Gmail-Original-Message-ID: <CA+FuTScUxCfg9PX224YTJnJoSfq2QP88kKqU31QnOR9=TMo3GQ@mail.gmail.com>
Message-ID: <CA+FuTScUxCfg9PX224YTJnJoSfq2QP88kKqU31QnOR9=TMo3GQ@mail.gmail.com>
Subject: Re: [PATCH] net: check passed optlen before reading
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Tamir Duberstein <tamird@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 2:58 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 29 Dec 2021 14:53:10 -0500 Willem de Bruijn wrote:
> > On Wed, Dec 29, 2021 at 2:50 PM Tamir Duberstein <tamird@gmail.com> wrote:
> > >
> > > I'm having some trouble sending this using git send-email because of
> > > the firewall I'm behind.
> > >
> > > Please pull from
> > >   git://github.com/tamird/linux raw-check-optlen
> > > to get these changes:
> > >   280c5742aab2 ipv6: raw: check passed optlen before reading
> > >
> > > If this is not acceptable, I'll send the patch again when I'm outside
> > > the firewall. Apologies.
> >
> > I can send it on your behalf, Tamir.
>
> Or we can use this opportunity to try out the infra Konstantin had been
> working on:
>
> https://lore.kernel.org/all/20211217183942.npvkb3ajnx6p5cbp@meerkat.local/
>
> b4 submit --send seems to support sending via some web thing?
>
> Dunno if anyone tried it, yet.

I haven't tried b4 at all. Just sent it the traditional way for now.
Will take a look and maybe give it a spin next time.
