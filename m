Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7BF4C4DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiBYSZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiBYSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F6C22510E9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645813518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wJUmzL6cjzVUtVOWwFY0p71jUm6NF80QB8+jDDkstEI=;
        b=b59F5P6eYGL/Sh3TLCN91IxJWaoZCwT634APnpQM0z2ACSum3WkeivmP5MdlDH1swvv9Em
        AF+EnkZvkV4dKq82o3sB5O5Kwp3VdtetFYB3KsCssiazLTJY7oZYV+KZ61eXtTKjPDUT/U
        hV1IqkmLp+6ecDbbRudU30iuNi5LiiQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-9S7npBaAOZi_0o0BSkFYJw-1; Fri, 25 Feb 2022 13:25:17 -0500
X-MC-Unique: 9S7npBaAOZi_0o0BSkFYJw-1
Received: by mail-wm1-f70.google.com with SMTP id f189-20020a1c38c6000000b0037d1bee4847so1921941wma.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJUmzL6cjzVUtVOWwFY0p71jUm6NF80QB8+jDDkstEI=;
        b=7uohvpU93aO1WvgjK/BzfXTQsBB5qV3rWl7QrxNMnSiGUXgAaoG4SGCvY02uSKtyZj
         6RH0wqVJcwMrYPfsl+ggWaLcvxV9M8eJCHd8RdjDqWNxIcGXMsGLBOxZqAEd/I/kwS9a
         AJF3MdgeSH3eia/UL3ExcPRzAD49gAI+ZAwvAyWepNOG8eHgaXRncQi5g3H6ICCf9Ux7
         sYmnI57yJoaRlyHNtQazcPq4XJMwzubJgsgJvegOBW81LxVkuqsl24OjToBqb2HUCt2P
         yVtMVRmA2fJx3JmuSdYM5JqGUAJfSnw5ToRhRxrHrf7UeiXNPIzojWNYAc6vrAR5QH5j
         3nWg==
X-Gm-Message-State: AOAM5339YpiHzJg7s0iqQrO2kyrxz6xz9EmEdWaPu3UXbzGUVyfAh1Rq
        aSGK/S0K2xb0Yez5BX0DWP7mxylpClQf3MagM0YHueOoO7hAHLENqfQVdtjDYUPyCn47ZUKDAlM
        Z1V7EBMCCBTlEbTx+m63fRWDs
X-Received: by 2002:a05:600c:3590:b0:34a:5f6:9e6 with SMTP id p16-20020a05600c359000b0034a05f609e6mr3862271wmq.182.1645813516074;
        Fri, 25 Feb 2022 10:25:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDrC8FSsPSLgMPhm8mD/DAjo9CntPreULCTyAAKeyXsCdkoIz/+sBHnr1REDXKrhrLZbdWng==
X-Received: by 2002:a05:600c:3590:b0:34a:5f6:9e6 with SMTP id p16-20020a05600c359000b0034a05f609e6mr3862258wmq.182.1645813515794;
        Fri, 25 Feb 2022 10:25:15 -0800 (PST)
Received: from redhat.com ([2.55.165.55])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b0038100c9a593sm8104653wml.45.2022.02.25.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:25:15 -0800 (PST)
Date:   Fri, 25 Feb 2022 13:25:12 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220225132505-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
 <20220222013121-mutt-send-email-mst@kernel.org>
 <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
 <YhVvOsI0+xVAKHdr@casper.infradead.org>
 <Yhj6ap3uEl2xFE8G@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhj6ap3uEl2xFE8G@casper.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 03:48:58PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 22, 2022 at 11:18:18PM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 22, 2022 at 07:58:33AM +0000, David Woodhouse wrote:
> > > On Tue, 2022-02-22 at 01:31 -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Feb 21, 2022 at 05:18:48PM +0000, David Woodhouse wrote:
> > > > > 
> > > > > [dwoodhou@i7 virtio]$ sudo ~/virtio_test
> > > > > Detected virtual address range 0x1000-0x7ffffffff000
> > > > > spurious wakeups: 0x0 started=0x100000 completed=0x100000
> > > > > 
> > > > > Although in some circumstances I also see a different build failure:
> > > > > 
> > > > > cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h   -c -o vringh_test.o vringh_test.c
> > 
> > Trying to test this myself ...
> > 
> > $ cd tools/virtio/
> > $ make
> > ...
> > cc -lpthread  virtio_test.o virtio_ring.o   -o virtio_test
> > /usr/bin/ld: virtio_ring.o: in function `spin_lock':
> > /home/willy/kernel/folio/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
> > 
> > So this is not the only problem here?
> > 
> > > > > In file included from ./linux/uio.h:3,
> > > > >                  from ./linux/../../../include/linux/vringh.h:15,
> > > > >                  from ./linux/vringh.h:1,
> > > > >                  from vringh_test.c:9:
> > > > > ./linux/../../../include/linux/uio.h:10:10: fatal error: linux/mm_types.h: No such file or directory
> > > > >    10 | #include <linux/mm_types.h>
> > > > >       |          ^~~~~~~~~~~~~~~~~~
> > > > > compilation terminated.
> > > > > make: *** [<builtin>: vringh_test.o] Error 1
> > > > 
> > > > Which tree has this build failure? In mine linux/uio.h does not
> > > > include linux/mm_types.h.
> > > 
> > > Strictly it's
> > > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/xen-evtchn-kernel
> > > but I'm sure my part isn't relevant; it's just v5.17-rc5.
> > > 
> > >  $ git blame include/linux/uio.h | grep mm_types.h
> > > d9c19d32d86fa (Matthew Wilcox (Oracle) 2021-10-18 10:39:06 -0400  10) #include <linux/mm_types.h>
> > >  $ git describe --tags d9c19d32d86fa
> > > v5.16-rc4-37-gd9c19d32d86f
> > 
> > grr.  Originally, I had this doing a typebusting cast, but hch objected,
> > so I had to include mm_types.h.  This should fix it ...
> 
> ping?  Just noticed this one crop up in a "list of problems".  Should
> I submit it myself?

Pls do.

> > $ git diff
> > diff --git a/tools/virtio/linux/mm_types.h b/tools/virtio/linux/mm_types.h
> > new file mode 100644
> > index 000000000000..3b0fc9bc5b8f
> > --- /dev/null
> > +++ b/tools/virtio/linux/mm_types.h
> > @@ -0,0 +1,3 @@
> > +struct folio {
> > +       struct page page;
> > +};
> > 
> > At least, it makes it compile for me.

