Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C5B4E1B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiCTLFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiCTLFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A0344830B
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647774233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hFzoF0hHDOlcsVq7gujqkCRBLubjXsP/Roy3iuwOSII=;
        b=Ctk/kkVHy/4bBCwUafn+kN/3gUHcCx2YGUkD2dpeT04jA+Lm5kxdTNuP/dobd6q5g0BQSG
        VDfHMYN+wyu7qy9RmGh9qJuFqTtRemy3Q5gtIRU17qKmT9qGXjT+Eep6q3cNDmQmrKzy6U
        /38GokP1xAbv1iCcuVpbIN5DsEES6wc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-71jkyQlPOli4e9pqJHQiiw-1; Sun, 20 Mar 2022 07:03:51 -0400
X-MC-Unique: 71jkyQlPOli4e9pqJHQiiw-1
Received: by mail-ej1-f69.google.com with SMTP id jx2-20020a170907760200b006dfc374c502so1982019ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 04:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFzoF0hHDOlcsVq7gujqkCRBLubjXsP/Roy3iuwOSII=;
        b=g2NXDoX3fdlscz9vDDk9h5PGj3TIPBPBKjXreSPvNPVXoaGLy7mbgendFbG1f1kT04
         oe5Iz8558M1OarmR87qXLI4qRF9QHZEoNNLtR+4SV3KYKbZDaH7RD350YshSoDlUUQrO
         X4UVBrAZgTeYhkkTBG7vTNaZRMg0MaFQ8VOSUr2popC+yZmX25eCVvRvaVnSIahuG/3U
         /e4cV5l5iw6Ck0c58Tj5V3wsYblNq+32RPKZxfAJ+Vet9UYcRtZa22miG90o/TIZT3OF
         04gkzf+dM9n54FOIHhmgt2s58gI+4/ygxncw4AotMqrbVsmmWhKSrfCBbHAUpP01V6KK
         Exmg==
X-Gm-Message-State: AOAM533lzUOMh/0s1ZUhOP0ERppHnLcPTzNu8dYWw5ENoQr0v+dA8MvJ
        a6wFfSG51D+enA+n5Tr0RqxuXJePeCZbfxi21MjcwDkqOMfy/+cfHxcX/DgG8ZtKok1r/buyAw5
        Km7qlAONgyLvHIi66Clg9dgoX
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id f15-20020a50bf0f000000b00410c512cb6fmr18241296edk.262.1647774230356;
        Sun, 20 Mar 2022 04:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjjAtm3/nvXUKsceBT8RN+aLhHOJTRyYxPZll7mzodeHfVLEMC07NKkUsLeu6jNKkhDa9glA==
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id f15-20020a50bf0f000000b00410c512cb6fmr18241282edk.262.1647774230126;
        Sun, 20 Mar 2022 04:03:50 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm5743141ejm.103.2022.03.20.04.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 04:03:49 -0700 (PDT)
Date:   Sun, 20 Mar 2022 07:03:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220320070309-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
 <20220222013121-mutt-send-email-mst@kernel.org>
 <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
 <YhVvOsI0+xVAKHdr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhVvOsI0+xVAKHdr@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 11:18:18PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 22, 2022 at 07:58:33AM +0000, David Woodhouse wrote:
> > On Tue, 2022-02-22 at 01:31 -0500, Michael S. Tsirkin wrote:
> > > On Mon, Feb 21, 2022 at 05:18:48PM +0000, David Woodhouse wrote:
> > > > 
> > > > [dwoodhou@i7 virtio]$ sudo ~/virtio_test
> > > > Detected virtual address range 0x1000-0x7ffffffff000
> > > > spurious wakeups: 0x0 started=0x100000 completed=0x100000
> > > > 
> > > > Although in some circumstances I also see a different build failure:
> > > > 
> > > > cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h   -c -o vringh_test.o vringh_test.c
> 
> Trying to test this myself ...
> 
> $ cd tools/virtio/
> $ make
> ...
> cc -lpthread  virtio_test.o virtio_ring.o   -o virtio_test
> /usr/bin/ld: virtio_ring.o: in function `spin_lock':
> /home/willy/kernel/folio/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
> 
> So this is not the only problem here?

Could you let me know which system and gcc version have this problem, for inclusion
in the commit log?

> > > > In file included from ./linux/uio.h:3,
> > > >                  from ./linux/../../../include/linux/vringh.h:15,
> > > >                  from ./linux/vringh.h:1,
> > > >                  from vringh_test.c:9:
> > > > ./linux/../../../include/linux/uio.h:10:10: fatal error: linux/mm_types.h: No such file or directory
> > > >    10 | #include <linux/mm_types.h>
> > > >       |          ^~~~~~~~~~~~~~~~~~
> > > > compilation terminated.
> > > > make: *** [<builtin>: vringh_test.o] Error 1
> > > 
> > > Which tree has this build failure? In mine linux/uio.h does not
> > > include linux/mm_types.h.
> > 
> > Strictly it's
> > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/xen-evtchn-kernel
> > but I'm sure my part isn't relevant; it's just v5.17-rc5.
> > 
> >  $ git blame include/linux/uio.h | grep mm_types.h
> > d9c19d32d86fa (Matthew Wilcox (Oracle) 2021-10-18 10:39:06 -0400  10) #include <linux/mm_types.h>
> >  $ git describe --tags d9c19d32d86fa
> > v5.16-rc4-37-gd9c19d32d86f
> 
> grr.  Originally, I had this doing a typebusting cast, but hch objected,
> so I had to include mm_types.h.  This should fix it ...
> 
> $ git diff
> diff --git a/tools/virtio/linux/mm_types.h b/tools/virtio/linux/mm_types.h
> new file mode 100644
> index 000000000000..3b0fc9bc5b8f
> --- /dev/null
> +++ b/tools/virtio/linux/mm_types.h
> @@ -0,0 +1,3 @@
> +struct folio {
> +       struct page page;
> +};
> 
> At least, it makes it compile for me.

