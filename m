Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16884BF220
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 07:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiBVGce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 01:32:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiBVGcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E96F625E8C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645511526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/oig1Hr2Zgb+hiYEUeq6XCTE+b6757ivsb+f39hvIQ=;
        b=Hv+pSslPyLBGa3ssfs8uSeUC1lxnHD+vfXql+j6+NPx8QP15Id1asC9UNm+bi1+x8JtJYR
        L2RmxU/bE4xpaPXX92Z8wJjbq1o7EG8hllBBVzhrPuau6M+WNFpmaqQMrdm4fyWFu9Hmwg
        EhTuh1YcQiz0bH5VrCv2IYgU9xlOs+U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-5xp3rFJSOS29TZYmTdonyw-1; Tue, 22 Feb 2022 01:32:02 -0500
X-MC-Unique: 5xp3rFJSOS29TZYmTdonyw-1
Received: by mail-wm1-f71.google.com with SMTP id p24-20020a05600c1d9800b0037be98d03a1so427716wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/oig1Hr2Zgb+hiYEUeq6XCTE+b6757ivsb+f39hvIQ=;
        b=YzJ0TBkvxWld8MgB8e6vywhJI0SxCLipDcQlcCmVYnYOidEkvi02B3/RVQOoLVdlnJ
         EGq5pYLAH3N41iLFjTOMCes3/fGvFaCH3eKPAlL2qr+N0tttor7dG+GMC44Fk4fei6oQ
         FA3MWvNx68wOqHGkPsn95PNS0TFFjFBj39H0XB08uUT2OoX+YzPGTAmLzxvVmghXuOh9
         AeY3Dtd6+86JAGYbeXJdoXt+7yNmSK+H44d1rFogvOoK2iI/aYMgMujyWqf1bb4AY4yE
         2xnrY34hF9HdsfNfohzKJW1KRZ88k9992b6DuYZGESYo6+PQi1TrP10y8xMcnzWHok4L
         lupA==
X-Gm-Message-State: AOAM531jSwg4WZtMU2zlZ+PWORXGx+VrLEeEvJQp4gn3GfRUlDFhBEB0
        f4lF9CHyy7fkQPa24UvWEW+33D470TH9BqRjCvCsEfK13ad1tzaSTLKY2a1IyNy9JfIVDUdIFwF
        wE9pX+SIDnJ+nX8LLlyQ0DVq6
X-Received: by 2002:a5d:53c4:0:b0:1e6:5b69:a25a with SMTP id a4-20020a5d53c4000000b001e65b69a25amr18421845wrw.341.1645511520893;
        Mon, 21 Feb 2022 22:32:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYOJh4GkMGTE2m37wnxk7zYf2DWYlSZDrFaNNuT8tW+F1P7wnt9uGo2yUs52mYcbnryj1Uhg==
X-Received: by 2002:a5d:53c4:0:b0:1e6:5b69:a25a with SMTP id a4-20020a5d53c4000000b001e65b69a25amr18421834wrw.341.1645511520686;
        Mon, 21 Feb 2022 22:32:00 -0800 (PST)
Received: from redhat.com ([2.55.129.240])
        by smtp.gmail.com with ESMTPSA id u7sm40984521wrm.15.2022.02.21.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 22:31:58 -0800 (PST)
Date:   Tue, 22 Feb 2022 01:31:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220222013121-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 05:18:48PM +0000, David Woodhouse wrote:
> On Mon, 2022-02-21 at 18:02 +0100, Stefano Garzarella wrote:
> > On Mon, Feb 21, 2022 at 04:15:22PM +0000, David Woodhouse wrote:
> > > As things stand, an application which wants to use vhost with a trivial
> > > 1:1 mapping of its virtual address space is forced to jump through hoops
> > > to detect what the address range might be. The VHOST_SET_MEM_TABLE ioctl
> > > helpfully doesn't fail immediately; you only get a failure *later* when
> > > you attempt to set the backend, if the table *could* map to an address
> > > which is out of range, even if no out-of-range address is actually
> > > being referenced.
> > > 
> > > Since userspace is growing workarounds for this lovely kernel API, let's
> > > ensure that we have a regression test that does things basically the same
> > > way as 
> > > https://gitlab.com/openconnect/openconnect/-/commit/443edd9d8826
> > > 
> > > does.
> > > 
> > > This is untested as I can't actually get virtio_test to work at all; it
> > > just seems to deadlock on a spinlock. But it's getting the right answer
> > > for the virtio range on x86_64 at least.
> > 
> > I had a similar issue with virtio_test and this simple patch [1] should 
> > fix the deadlock.
> > 
> > [1] 
> > https://lore.kernel.org/lkml/20220118150631.167015-1-sgarzare@redhat.com/=
> 
> Thanks.
> 
> [dwoodhou@i7 virtio]$ sudo ~/virtio_test
> Detected virtual address range 0x1000-0x7ffffffff000
> spurious wakeups: 0x0 started=0x100000 completed=0x100000
> 
> Although in some circumstances I also see a different build failure:
> 
> cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h   -c -o vringh_test.o vringh_test.c
> In file included from ./linux/uio.h:3,
>                  from ./linux/../../../include/linux/vringh.h:15,
>                  from ./linux/vringh.h:1,
>                  from vringh_test.c:9:
> ./linux/../../../include/linux/uio.h:10:10: fatal error: linux/mm_types.h: No such file or directory
>    10 | #include <linux/mm_types.h>
>       |          ^~~~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [<builtin>: vringh_test.o] Error 1

Which tree has this build failure? In mine linux/uio.h does not
include linux/mm_types.h.

-- 
MST

