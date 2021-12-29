Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B952481677
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhL2Txu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhL2Txt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:53:49 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA6FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:53:48 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id g65so12583111vkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z1QQXB5NMfTnekeDLJGGA6zJ11Nn8nyuGQX8tb9YWGw=;
        b=YtDaC6Shnz7T/74O0ipqKBpmYPowLS9vCnSjiWvoHYN/1RFLCCZFzUkT26TXW19bA3
         1gjIfzUceXFgVCQAQTnFs263Fq0RxEctD5VI6Yco62HSq/RHhtAzDsCJxP06hBesLNZV
         em4s08aQY4gNeQ7zzBaV5NtjUEyhRdnWySLtZXnZoqd1ZZvfJ7RTSjt3kHPWd0+MZbBI
         VFjc1z/Acxcpv9ZbH7ICejTvJQlzCw92EiHFtlmk2apoop6hwYG9oRHEFYOewflalVVJ
         5A9heDO+dj/H7irHedJ++5G4CyDI5rUc0TbjaBWy6kfsN8bfrtZfHQkae8YZ1ekJ9EPm
         9uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z1QQXB5NMfTnekeDLJGGA6zJ11Nn8nyuGQX8tb9YWGw=;
        b=dT0oYrmBFq7fQX2JnrtXJOJLOL+o5OdDSSyhsPtHJpiSiMP4GG3fZWdEAaysCrOT9h
         Lwu38ZDME3jl0flCAvf9PEVmGgU7H5pripTNcOyul3BcTThubcV4SPlA8r08osFo1oVQ
         DhGnk2l+Bq0JeWKN41z1Z5H1wlw6m2l5X/iWfkG2Ffl+WWBrKg4JEHpKbP4hcscRdpL4
         +QtCRblTAIrfFg/d9BcN/7wlMtATGWNMSrvhlZtx6EKh3rVXuJu34cxiS++sj/cTiqwC
         +BN+IWGJVXPXeb4kN1G2a3O7NqU5h+9buAje6o3P1XvCz2bIKrdv9v6jx7rs0NZclem4
         RRMg==
X-Gm-Message-State: AOAM531EoHLdu1t9ezwyvSSsO+WVV3G0KOp/CVzSaC5vLyzRv13RWUSO
        1xW2RK/IRUdgxw/2mzNPrS9Qg+WVOMo=
X-Google-Smtp-Source: ABdhPJyteO0j6UTfVQ9JBJ2T9HLgxTMCEQSx6ZaGurLNSjuUCgx28RakAyBAcV1RRDzf3uLLinmFdQ==
X-Received: by 2002:a05:6122:221c:: with SMTP id bb28mr8661602vkb.27.1640807627964;
        Wed, 29 Dec 2021 11:53:47 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id f1sm1116869uae.5.2021.12.29.11.53.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 11:53:47 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id r15so39129241uao.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:53:47 -0800 (PST)
X-Received: by 2002:a05:6102:31b3:: with SMTP id d19mr8227138vsh.79.1640807626985;
 Wed, 29 Dec 2021 11:53:46 -0800 (PST)
MIME-Version: 1.0
References: <CAJ-ks9kd6wWi1S8GSCf1f=vJER=_35BGZzLnXwz36xDQPacyRw@mail.gmail.com>
 <CAJ-ks9=41PuzGkXmi0-aZPEWicWJ5s2gW2zL+jSHuDjaJ5Lhsg@mail.gmail.com>
 <20211228155433.3b1c71e5@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <CA+FuTSeDTJxbPvN6hkXFMaBspVHwL+crOxzC2ukWRzxvKma9bA@mail.gmail.com> <CAJ-ks9=3o+rVJd5ztYbkgpcYiWjV+3qajCgOmM7AfjhoZvuOHw@mail.gmail.com>
In-Reply-To: <CAJ-ks9=3o+rVJd5ztYbkgpcYiWjV+3qajCgOmM7AfjhoZvuOHw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 29 Dec 2021 14:53:10 -0500
X-Gmail-Original-Message-ID: <CA+FuTSe0yPhca+2ZdyJD4FZumLPd85sChGhZPpXhu=ADuwtYrQ@mail.gmail.com>
Message-ID: <CA+FuTSe0yPhca+2ZdyJD4FZumLPd85sChGhZPpXhu=ADuwtYrQ@mail.gmail.com>
Subject: Re: [PATCH] net: check passed optlen before reading
To:     Tamir Duberstein <tamird@gmail.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 2:50 PM Tamir Duberstein <tamird@gmail.com> wrote:
>
> I'm having some trouble sending this using git send-email because of
> the firewall I'm behind.
>
> Please pull from
>   git://github.com/tamird/linux raw-check-optlen
> to get these changes:
>   280c5742aab2 ipv6: raw: check passed optlen before reading
>
> If this is not acceptable, I'll send the patch again when I'm outside
> the firewall. Apologies.

I can send it on your behalf, Tamir.
