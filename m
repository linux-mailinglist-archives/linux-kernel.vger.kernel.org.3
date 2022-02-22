Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4754BF62B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiBVKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiBVKiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8717214890A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645526259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csm4Rnx60b16vcU3nmJniQbFgaJFFX1itS4JIor18LU=;
        b=PPpDxZuhQ5ZbNs0Zf/r0iXp5RnMAWLjydK2GhtbtzwLxe7t6JzPx+G9cohHrcDwk5eZ1Q/
        Vly+uWI8A2AbifpdK48xLAItuzVyxxAEMfC/J/ADS+BBjzXLLbpDhOL5lhnGTtC7gqRwaq
        46ahFEYSJyU+Tl+hE0tYvEMjEoccOXQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-D4H6tq2IPXmXpRsfRC91HQ-1; Tue, 22 Feb 2022 05:37:37 -0500
X-MC-Unique: D4H6tq2IPXmXpRsfRC91HQ-1
Received: by mail-wm1-f71.google.com with SMTP id r188-20020a1c44c5000000b00380e36c6d34so106613wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=csm4Rnx60b16vcU3nmJniQbFgaJFFX1itS4JIor18LU=;
        b=3UADzNwnhkh1mXKKgeIwuZl0AOXqFoBGzqxicwFC6jTZzIy6XR5cJy9Y2GY/MDDbDl
         xL75JQsIBU5kFDQm5uCs9UErtUWQXpueaHQqu04PFjJPvbWyXAF+rn94j58rU4u7QPmK
         7yzDzgxgKjQLwKXvbJCMkbFeRqGvkv3FcCt/ZEOV36eYemoc7NtfsYcmi6Z3uKCgNeXj
         FKO13W4aUyIVLb3+oZQX5GT0+384Mp0NXFjbGyZ84/OPHmv0+lBkpQ4ZFt4Yzg6ySGBq
         TQA1TJd5Cc2YJR+2UQ6XwdUJU74CCojLUTGFCJf/zIPVQ7FIxp8HTZR5bvYyXJqrCVS7
         a2hg==
X-Gm-Message-State: AOAM5337lrVF/ErDcln1qcu1wG38VXcISg5nwN2Z4dOh3119OtORlcsz
        T9it11rIbUj1lAT6FFxphh8TabX264RsH7P2zLQC4ksQX30Bblu4fK7k1DmxGgCR97blwOmRX5w
        whjhpPoWMGSxijfdJjUjfo4gT
X-Received: by 2002:a5d:5701:0:b0:1e4:ab98:74c5 with SMTP id a1-20020a5d5701000000b001e4ab9874c5mr18581535wrv.704.1645526255905;
        Tue, 22 Feb 2022 02:37:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynOqagLClzBanNQxFaYlttCBRGTkjATujUK6V6Eo/pTENlCy/fOJARsWnldY9s58mjWTkIuQ==
X-Received: by 2002:a5d:5701:0:b0:1e4:ab98:74c5 with SMTP id a1-20020a5d5701000000b001e4ab9874c5mr18581513wrv.704.1645526255645;
        Tue, 22 Feb 2022 02:37:35 -0800 (PST)
Received: from debian.home (2a01cb058d3818005c1e4a7b0f47339f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d38:1800:5c1e:4a7b:f47:339f])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c2c4b00b0037c0522c727sm1963775wmg.21.2022.02.22.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 02:37:35 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:37:33 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: vlan: allow vlan device MTU change follow real
 device from smaller to bigger
Message-ID: <20220222103733.GA3203@debian.home>
References: <20220221124644.1146105-1-william.xuanziyang@huawei.com>
 <CANn89iKyWWCbAdv8W26HwGpM9q5+6rrk9E-Lbd2aujFkD3GMaQ@mail.gmail.com>
 <YhQ1KrtpEr3TgCwA@gondor.apana.org.au>
 <8248d662-8ea5-7937-6e34-5f1f8e19190f@huawei.com>
 <CANn89iLf2ira4XponYV91cbvcdK76ekU7fDW93fmuJ3iytFHcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iLf2ira4XponYV91cbvcdK76ekU7fDW93fmuJ3iytFHcw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 06:27:46PM -0800, Eric Dumazet wrote:
> On Mon, Feb 21, 2022 at 6:06 PM Ziyang Xuan (William)
> <william.xuanziyang@huawei.com> wrote:
> >
> > > On Mon, Feb 21, 2022 at 07:43:18AM -0800, Eric Dumazet wrote:
> > >>
> > >> Herbert, do you recall why only a decrease was taken into consideration ?
> > >
> > > Because we shouldn't override administrative settings of the MTU
> > > on the vlan device, unless we have to because of an MTU reduction
> > > on the underlying device.
> > >
> > > Yes this is not perfect if the admin never set an MTU to start with
> > > but as we don't have a way of telling whether the admin has or has
> > > not changed the MTU setting, the safest course of action is to do
> > > nothing in that case.
> > If the admin has changed the vlan device MTU smaller than the underlying
> > device MTU firstly, then changed the underlying device MTU smaller than
> > the vlan device MTU secondly. The admin's configuration has been overridden.
> > Can we consider that the admin's configuration for the vlan device MTU has
> > been invalid and disappeared after the second change? I think so.
> 
> The answer is no.
> 
> Herbert is saying:
> 
> ip link add link eth1 dev eth1.100 type vlan id 100
> ...
> ip link set eth1.100 mtu 800
> ..
> ip link set eth1 mtu 256
> ip link set eth1 mtu 1500
> 
> -> we do not want eth1.100 mtu being set back to 1500, this might
> break applications, depending on old kernel feature.
>  Eventually, setting back to 800 seems ok.
> 
> If you want this new feature, we need to record in eth1.100 device
> that no admin ever changed the mtu,
> as Herbert suggested.
> 
> Then, it is okay to upgrade the vlan mtu (but still is a behavioral
> change that _could_ break some scripts)

What about an explicit option:

  ip link add link eth1 dev eth1.100 type vlan id 100 follow-parent-mtu


Or for something more future proof, an option that can accept several
policies:

  mtu-update <reduce-only,follow,...>

      reduce-only (default):
        update vlan's MTU only if the new MTU is smaller than the
        current one (current behaviour).

      follow:
        always follow the MTU of the parent device.

Then if anyone wants more complex policies:

      follow-if-not-modified:
        follow the MTU of the parent device as long as the VLAN's MTU
        was not manually changed. Otherwise only adjust the VLAN's MTU
        when the parent's one is set to a smaller value.

      follow-if-not-modified-but-not-quite:
        like follow-if-not-modified but revert back to the VLAN's
        last manually modified MTU, if any, whenever possible (that is,
        when the parent device's MTU is set back to a higher value).
        That probably requires the possibility to dump the last
        modified MTU, so the administrator can anticipate the
        consequences of modifying the parent device.

     yet-another-policy (because people have a lot of imagination):
       for example, keep the MTU 4 bytes lower than the parent device,
       to account for VLAN overhead.

Of course feel free to suggest better names and policies :).

This way, we can keep the current behaviour and avoid unexpected
heuristics that are difficult to explain (and even more difficult for
network admins to figure out on their own).

> Thank you.
> 

