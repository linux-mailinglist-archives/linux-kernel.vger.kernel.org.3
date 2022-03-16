Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CA4DB386
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbiCPOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356823AbiCPOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:42:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E695F259
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mnSO3jwZIKFFjKjFx5j5kAOPBQTRdap/N5ghBYEr3fY=; b=TnHog5Ux5kAxiI3lydGG2Rk/Mm
        419S4Dp+DS2Kwy/CDndSx0s8dcnGTeQ8oVuAsJJjh0orBDTu3umeQEMWg33GsrJE0nhEWm9uPwwOO
        dlvba/NJpvWcrGDLdtXNU7ASJoyTpHTxsEU+YAY/DwsB/J9y9EPJQh+OKzLFAJOMLBe6Z8j/M3wM7
        LKYecXmq6IzQcQ4JbWHv6sd70BXe4dIC3kboKDuOtZFrDOILHYuHkWVXPZ+9cHAy9ZKfAKZfhMGqv
        THIuPivVfj7i28g3i5ORBEGnCz7lHjh+WcVAL78lsGlaRVXK8MCb69qATocRKP9qKQ4CPiC7blRLX
        cn7eE1Og==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUUqF-0063sf-MV; Wed, 16 Mar 2022 14:41:35 +0000
Date:   Wed, 16 Mar 2022 14:41:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <YjH3H9KvTFAayTPY@casper.infradead.org>
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

FYI, this fixes it for me:

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 0d7bbe49359d..83b6a522d0d2 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -5,7 +5,7 @@ virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o

 CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
-LDFLAGS += -lpthread
+LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
        ${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}

