Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6085D4E1B3B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 12:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiCTLDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 07:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244292AbiCTLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 07:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 583F446658
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647774085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=70n8djccLGvTwEN3SXJpGKJYJ4sRqN4FFre0FvejuPA=;
        b=P7iB13VbBDhg3XpHaGk4H3g8PLTrkbcUTlgnx6pvs1Y16E5xhmIoTrbH6lzJgTN7P+usbN
        D+FcRirUlCadfSpCFiZ92TtNLO1ghq6rYrQMyRaLVOKcF9S7w+28+s+HUvnf8fZba+6kXq
        63F/i4CitxjzulNGC2w6kDnwo2fvfig=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-OJp3mviXPG6U3yMt3ThEig-1; Sun, 20 Mar 2022 07:01:24 -0400
X-MC-Unique: OJp3mviXPG6U3yMt3ThEig-1
Received: by mail-ej1-f69.google.com with SMTP id m12-20020a1709062acc00b006cfc98179e2so5956200eje.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 04:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=70n8djccLGvTwEN3SXJpGKJYJ4sRqN4FFre0FvejuPA=;
        b=IfSFkuFoPA7p75MSTvFtPJzeFD4sLmM7Ark5WBkrvQzUPy66ZHe1NmDRNQqzZxwK4D
         lhJXsqvwAnyAJaizEcdQZmKvBLnTksDQyZrV7Ee+SvLrl/63DwLuM9Ht9X8Lgy1eyN9Z
         +v9HDl31cSwF23rCXDTWnz56C3ZXigE/QTsMwXMhm+LuCb2v9QIX82eFNddXDmsK2NNH
         N5f6nGjDAFxrYgwO/QKYDbnNudLS3wLKz6Lkq9w1Y8y/1xuwVvpwoyE+VIhveqIOl7Zz
         bzrtaqqjSZe2SRcGzRJaOKOMSbxwEr4FH6JBItEEgGevKq/Lmr8p+fWVjKeCuE40TMfm
         zs+A==
X-Gm-Message-State: AOAM531eWrcqNiTJqElDIMMWKaXe1m0389uETp9+j2k5BfaLQIU6XEro
        mVXmIJS0HwqL8nkjohGHUgR9DV0R6u8Z9n6iUAR01rA6mKS8UkEzGkpE1doYoikFw11JCXgwL6D
        Cv6q/qinR7vBYC8Vzt2uhvbYz
X-Received: by 2002:a17:907:728b:b0:6df:8f3b:28ae with SMTP id dt11-20020a170907728b00b006df8f3b28aemr15008464ejc.336.1647774083262;
        Sun, 20 Mar 2022 04:01:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy07Ub9HgPan/haxPXZAmsmftl771vhR4MLzcj9Pv2RUOJsuF09d0skyISjV6IqXosGrJIhQ==
X-Received: by 2002:a17:907:728b:b0:6df:8f3b:28ae with SMTP id dt11-20020a170907728b00b006df8f3b28aemr15008448ejc.336.1647774083039;
        Sun, 20 Mar 2022 04:01:23 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090608c700b006cef23cf158sm5731563eje.175.2022.03.20.04.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 04:01:22 -0700 (PDT)
Date:   Sun, 20 Mar 2022 07:01:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220320065640-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
 <20220222013121-mutt-send-email-mst@kernel.org>
 <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
 <YhVvOsI0+xVAKHdr@casper.infradead.org>
 <YjH3H9KvTFAayTPY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjH3H9KvTFAayTPY@casper.infradead.org>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 02:41:35PM +0000, Matthew Wilcox wrote:
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
> 
> FYI, this fixes it for me:
> 
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 0d7bbe49359d..83b6a522d0d2 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -5,7 +5,7 @@ virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
> 
>  CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
> -LDFLAGS += -lpthread
> +LDFLAGS += -pthread
>  vpath %.c ../../drivers/virtio ../../drivers/vhost
>  mod:
>         ${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}

gcc documentation seems to say this is neeed in cflags too:

       -pthread
           Define additional macros required for using the POSIX threads library.  You should use this option consistently for both
           compilation and linking.  This option is supported on GNU/Linux targets, most other Unix derivatives, and also on x86
           Cygwin and MinGW targets.

right?

-- 
MST

