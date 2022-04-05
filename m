Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35284F511D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1844795AbiDFBwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381349AbiDEMy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45E4C29C92
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649159848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yZyeehLgo43vPEC1Sp1n3r3jpBNtdCjtLwgkplLP3v4=;
        b=Gh1urVgDOeB9+9TxPEQeRkhcqCncaFa8w1U9aVXPwWd9+BzvwtLgauDuT5npxZ7ZsYGpEy
        +2cLGfjg87/sbCwjZPmJfPObdYuRuPoNUmNfjDY/szAPb3aPdw9c1mV+t+FVj9LCzmEPm1
        ma0vA+nyG5qidYPD19KL428n3aY96z4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-KIqRJy3MMeaGuU1ZouRE6w-1; Tue, 05 Apr 2022 07:57:27 -0400
X-MC-Unique: KIqRJy3MMeaGuU1ZouRE6w-1
Received: by mail-wm1-f70.google.com with SMTP id c19-20020a05600c4a1300b0038e6b4a104cso1219216wmp.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 04:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZyeehLgo43vPEC1Sp1n3r3jpBNtdCjtLwgkplLP3v4=;
        b=38l5yMxt+/9Smcu7hpV6skp/yyRD7O0FxJPsbRpLa0pc55JOPeCAtkjUoNlm41vw1k
         /1AaRIGdxbgr+Rj2s7uphTh0fWFq3fnIMJqmtMwNQGfaCizTGHpAt35RkJsb6twusilq
         HXn/7oI0FNWuEYE0FRFP5hbZufSVKdliF6DUAR1M/imlds1s7QTWuRRn5TFvKSRAsln7
         YbDXUa7xkMgxB9J88n9IGrxo/o+12ShfVUKjGbbJf5wi0PbCoyUfmTTx6TEswsDo0xyE
         B2dJ1I4s9xLJfRxXzIEkj5ELdhgvm14e4fU2XGaZWdS5lkuWMRKya/pr2VR3AnOxRi0Y
         6SiQ==
X-Gm-Message-State: AOAM533w5BGZUB9bNH8VCne+HXDZhm/ItIwTvahPH5pKKntYYxvOcjBY
        B/R22Sp+6rp4UM9NndPrWbYMXacw3al4CYvIqcueEExjrYgwTKb0hvqZfgSaUYTpNdFr0yXNvUQ
        ICq0fw/HHS9zuRC6jnBxURmPK
X-Received: by 2002:a05:6000:184a:b0:203:f8f0:3407 with SMTP id c10-20020a056000184a00b00203f8f03407mr2604222wri.190.1649159846182;
        Tue, 05 Apr 2022 04:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypIKxQBes9FfmGLsTQSI+o8ZS7lLWmQJBmsfPcPeNLWB/aoHg6W8W0oB4kBqUTKA7V4gN8eQ==
X-Received: by 2002:a05:6000:184a:b0:203:f8f0:3407 with SMTP id c10-20020a056000184a00b00203f8f03407mr2604202wri.190.1649159845981;
        Tue, 05 Apr 2022 04:57:25 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a7bcb84000000b00389efb7a5b4sm1883255wmi.17.2022.04.05.04.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:57:25 -0700 (PDT)
Date:   Tue, 5 Apr 2022 07:57:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization list <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405075627-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
 <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 08:29:36AM +0200, Arnd Bergmann wrote:
> On Tue, Apr 5, 2022 at 7:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Apr 04, 2022 at 10:04:02AM +0200, Arnd Bergmann wrote:
> > > The header is shared between kernel and other projects using virtio, such as
> > > qemu and any boot loaders booting from virtio devices. It's not technically a
> > > /kernel/ ABI, but it is an ABI and for practical reasons the kernel version is
> > > maintained as the master copy if I understand it correctly.
> >
> > Besides that fact that as you correctly states these are not a UAPI at
> > all, qemu and bootloades are not specific to Linux and can't require a
> > specific kernel version.  So the same thing we do for file system
> > formats or network protocols applies here:  just copy the damn header.
> > And as stated above any reasonably portable userspace needs to have a
> > copy anyway.
> 
> I think the users all have their own copies, at least the ones I could
> find on codesearch.debian.org.

kvmtool does not seem to have its own copy, just grep vring_init.

> However, there are 27 virtio_*.h
> files in include/uapi/linux that probably should stay together for
> the purpose of defining the virtio protocol, and some others might
> be uapi relevant.
> 
> I see that at least include/uapi/linux/vhost.h has ioctl() definitions
> in it, and includes the virtio_ring.h header indirectly.
> 
> Adding the virtio maintainers to Cc to see if they can provide
> more background on this.
> 
> > If it is just as a "master copy" it can live in drivers/virtio/, just
> > like we do for other formats.
> 
> It has to be in include/linux/ at least because it's used by a number
> of drivers outside of drivers/virtio/.
> 
>         Arnd
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

