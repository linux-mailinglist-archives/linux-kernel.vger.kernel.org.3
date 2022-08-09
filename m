Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5A58D252
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbiHIDRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHIDRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9D7F1D0D8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660015029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hku1ARqVHLsqVqdvmF+LjymmoxAfWd7fJEwt8euY7i0=;
        b=dzogAuqIOjhp2nZiWKpVzEkrOAnB/z5amt1E5vW4qzFw+cPYVFCM76N3Fk6ysqkOcyv9pd
        6aixA/crDZ5Gli8liQzpcavnuIUKz4W7Zqdy8Z8KZ+RJVMB3/HoHKs3JOqbQ0TxprfF3dI
        TR4i1z2cZ796Dj3R0sgEKOLj2UY0qHI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-Mw0adrrOMbKP-1UAEDisBA-1; Mon, 08 Aug 2022 23:17:07 -0400
X-MC-Unique: Mw0adrrOMbKP-1UAEDisBA-1
Received: by mail-lj1-f200.google.com with SMTP id w21-20020a2e9595000000b0025ec9280923so1764355ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 20:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hku1ARqVHLsqVqdvmF+LjymmoxAfWd7fJEwt8euY7i0=;
        b=1Du690Gu3h7WZKvc5RdRkf/EKqaDuBmltNHuYpIgvZiTbHsECAATz7ghDU79AaoyZ2
         etDM4cT04+TuHUaa3NeO0PEqHEbia2tZCRh68tngvNB1EXh2JH7AKECx7kVUnEgqTAAF
         ulLOWqutAJxjw0YLq+R+JZLeZfJ2Yq2iPDAWzK4qbbcgkCDOuE63xidugnFQjyAwQKqK
         zkwHr2KedTIWMNeBa66DfwKncAm/EafY353p+tSM6xgGx8mi0reYFaXXwI8isV2IxHU9
         fl4NHRP7dY6fR0e3ayOrfyOt52eJ37XjmcnXg1iHYzzSWYLO9QDyeTljxne5kSwmPNlt
         Wemw==
X-Gm-Message-State: ACgBeo2qZ0/kzyx9JySdDt0yxoA0Y5PchhpYALKmghGI4u3D9yGzHLUT
        xqPA1J1oVxUdDZS2IeIBiIVJZa9gditzBS8RWRAeOSDASny/F1gwgnIoxiOXl2cAui98vrkR9v5
        MdH0PyPBnXNr4TDflPGKVwSd5+et08GU/kuzUUFvX
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id t16-20020ac243b0000000b0048b01ebd1e5mr7802367lfl.641.1660015025960;
        Mon, 08 Aug 2022 20:17:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7IIJpQH67XtqBk2btElSlMlkfd1jKVQZZDaJZRMuF0mI0fTAKzJBNGyrFKYdgj7FYSxj45QVLxamo/Nzjw/oE=
X-Received: by 2002:ac2:43b0:0:b0:48b:1eb:d1e5 with SMTP id
 t16-20020ac243b0000000b0048b01ebd1e5mr7802355lfl.641.1660015025739; Mon, 08
 Aug 2022 20:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220805181105.GA29848@willie-the-truck> <20220807042408-mutt-send-email-mst@kernel.org>
 <20220808101850.GA31984@willie-the-truck> <20220808083958-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220808083958-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 9 Aug 2022 11:16:54 +0800
Message-ID: <CACGkMEv2vij4bSOwxajXan=+b_aQ_=Y3Ttjj3H9R_Q5fhEFxtg@mail.gmail.com>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ascull@google.com, Marc Zyngier <maz@kernel.org>,
        Keir Fraser <keirf@google.com>, jiyong@google.com,
        kernel-team@android.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>, crosvm-dev@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 8:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 08, 2022 at 11:18:50AM +0100, Will Deacon wrote:
> > Hi Michael,
> >
> > On Sun, Aug 07, 2022 at 09:14:43AM -0400, Michael S. Tsirkin wrote:
> > > Will, thanks very much for the analysis and the writeup!
> >
> > No problem, and thanks for following up.
> >
> > > On Fri, Aug 05, 2022 at 07:11:06PM +0100, Will Deacon wrote:
> > > > So how should we fix this? One possibility is for us to hack crosvm to
> > > > clear the VIRTIO_F_ACCESS_PLATFORM flag when setting the vhost features,
> > > > but others here have reasonably pointed out that they didn't expect a
> > > > kernel change to break userspace. On the flip side, the offending commit
> > > > in the kernel isn't exactly new (it's from the end of 2020!) and so it's
> > > > likely that others (e.g. QEMU) are using this feature.
> > >
> > > Exactly, that's the problem.
> > >
> > > vhost is reusing the virtio bits and it's only natural that
> > > what you are doing would happen.
> > >
> > > To be precise, this is what we expected people to do (and what QEMU does):
> > >
> > >
> > > #define QEMU_VHOST_FEATURES ((1 << VIRTIO_F_VERSION_1) |
> > >                          (1 << VIRTIO_NET_F_RX_MRG) | .... )
> > >
> > > VHOST_GET_FEATURES(... &host_features);
> > > host_features &= QEMU_VHOST_FEATURES
> > > VHOST_SET_FEATURES(host_features & guest_features)
> > >
> > >
> > > Here QEMU_VHOST_FEATURES are the bits userspace knows about.
> > >
> > > Our assumption was that whatever userspace enables, it
> > > knows what the effect on vhost is going to be.
> > >
> > > But yes, I understand absolutely how someone would instead just use the
> > > guest features. It is unfortunate that we did not catch this in time.
> > >
> > >
> > > In hindsight, we should have just created vhost level macros
> > > instead of reusing virtio ones. Would address the concern
> > > about naming: PLATFORM_ACCESS makes sense for the
> > > guest since there it means "whatever access rules platform has",
> > > but for vhost a better name would be VHOST_F_IOTLB.
> > > We should have also taken greater pains to document what
> > > we expect userspace to do. I remember now how I thought about something
> > > like this but after coding this up in QEMU I forgot to document this :(
> > > Also, I suspect given the history the GET/SET features ioctl and burned
> > > wrt extending it and we have to use a new when we add new features.
> > > All this we can do going forward.
> >
> > Makes sense. The crosvm developers are also pretty friendly in my
> > experience, so I'm sure they wouldn't mind being involved in discussions
> > around any future ABI extensions. Just be aware that they _very_ recently
> > moved their mailing lists, so I think it lives here now:
> >
> > https://groups.google.com/a/chromium.org/g/crosvm-dev
> >
> > > But what can we do about the specific issue?
> > > I am not 100% sure since as Will points out, QEMU and other
> > > userspace already rely on the current behaviour.
> > >
> > > Looking at QEMU specifically, it always sends some translations at
> > > startup, this in order to handle device rings.
> > >
> > > So, *maybe* we can get away with assuming that if no IOTLB ioctl was
> > > ever invoked then this userspace does not know about IOTLB and
> > > translation should ignore IOTLB completely.
> >
> > There was a similar suggestion from Stefano:
> >
> > https://lore.kernel.org/r/20220806105225.crkui6nw53kbm5ge@sgarzare-redhat
> >
> > about spotting the backend ioctl for IOTLB and using that to enable
> > the negotiation of F_ACCESS_PLATFORM. Would that work for qemu?
>
> Hmm I would worry that this disables the feature for old QEMU :(
>
>
> > > I am a bit nervous about breaking some *other* userspace which actually
> > > wants device to be blocked from accessing memory until IOTLB
> > > has been setup. If we get it wrong we are making guest
> > > and possibly even host vulnerable.
> > > And of course just revering is not an option either since there
> > > are now whole stacks depending on the feature.
> >
> > Absolutely, I'm not seriously suggesting the revert. I just did it locally
> > to confirm the issue I was seeing.
> >
> > > Will I'd like your input on whether you feel a hack in the kernel
> > > is justified here.
> >
> > If we can come up with something that we have confidence in and won't be a
> > pig to maintain, then I think we should do it, but otherwise we can go ahead
> > and change crosvm to mask out this feature flag on the vhost side for now.
> > We mainly wanted to raise the issue to illustrate that this flag continues
> > to attract problems in the hope that it might inform further usage and/or
> > spec work in this area.
> >
> > In any case, I'm happy to test any kernel patches with our setup if you
> > want to give it a shot.
>
> Thanks!
> I'm a bit concerned that the trick I proposed changes the configuration
> where iotlb was not set up from "access to memory not allowed" to
> "access to all memory allowed". This just might have security
> implications if some application assumed the former.
> And the one Stefano proposed disables IOTLB for old QEMU versions.

Yes, if there is no choice, having some known cases that are broken is
better than silently breaking unknown setups.

Thanks

>
>
>
> > > Also yes, I think it's a good idea to change crosvm anyway.  While the
> > > work around I describe might make sense upstream I don't think it's a
> > > reasonable thing to do in stable kernels.
> > > I think I'll prepare a patch documenting the legal vhost features
> > > as a 1st step even though crosvm is rust so it's not importing
> > > the header directly, right?
> >
> > Documentation is a good idea regardless, so thanks for that. Even though
> > crosvm has its own bindings for the vhost ioctl()s, the documentation
> > can be reference or duplicated once it's available in the kernel headers.
> >
> > Will
>
> So for crosvm change, I will post the documentation change and
> you guys can discuss?
>
> --
> MST
>

