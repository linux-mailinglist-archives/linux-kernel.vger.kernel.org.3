Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772804C4987
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbiBYPti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237967AbiBYPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:49:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F396BDD7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 07:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L8L89r0l8PrFsV/eyc4s6aWGL88ctKd06KB+sGThLfQ=; b=klb52YbyG7gTLcYbbwq6x/kM+C
        l8AGsuEwRgk/tjTuDy8rSKrfURHU1o2DxjlcsU3CkoigdR8hPOMyfF7ep5NAjI6FeocqoVDcBH3Lw
        axrQrQHwyREzqpTK8WxhQeqmE6Q973pUnN0vLrbr3wEJmVvMQhYdQvNUzM3j69qZSuP8XzwlmsxpK
        T2dDVFWpeUDg0RUCtG17qeNNUuswgTdmUn5BX1OqABnQQQjamRosJ5xpECJA2smxAhYCPBVOrIWHd
        QAY3RzQyup9dzgycyDgBbI58SB3CqH7Hr/X1pe2ZAHfBKXqAR7ioGjMwbVxfrhrV3jPph0siCIs2c
        O01mOvtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNcq2-005uK8-Eo; Fri, 25 Feb 2022 15:48:58 +0000
Date:   Fri, 25 Feb 2022 15:48:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <Yhj6ap3uEl2xFE8G@casper.infradead.org>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
> 
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

ping?  Just noticed this one crop up in a "list of problems".  Should
I submit it myself?

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
