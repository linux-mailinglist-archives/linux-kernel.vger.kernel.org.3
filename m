Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4546F5D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhLIV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231853AbhLIV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639084981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vgwc1magvMzj/8M1W9pAQzQB7+9j3HSAE2K13KoLOiQ=;
        b=ODf9xrA3tYfA7hfrO88tpNFd6mGiPR+0CSsvT5ca4ef/+hXX0HvUYmdtIe8jdk1AIB3c3L
        VJEw81gMuSylNMm4PtyUYm3r/4hG9w+kddYsX/YUv8/1B3xaiirI5wgXrUjiYcDUcXeuSG
        oo5fZ58bl121fc4c2fHWliJnSKkhWE8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-yUjKbxIOOZ2bbG4R2h2TZQ-1; Thu, 09 Dec 2021 16:22:59 -0500
X-MC-Unique: yUjKbxIOOZ2bbG4R2h2TZQ-1
Received: by mail-wm1-f69.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so2885845wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vgwc1magvMzj/8M1W9pAQzQB7+9j3HSAE2K13KoLOiQ=;
        b=HQRSBGa2gIhsUl2xLjBifjUnXlfARDvD0Y2EtHmiYMwk+d8n773GItX1HxpjKi2YRD
         eLrXTeoNaNzLbQeJJcELCWS/8ZjWKED/0H6MhbQTKQsusQPmp14fPR8gPXxLnaBtrqM0
         d/JQtZ0gXdx7Q9b6/nhwsAExhPNEzOAIGUFtlsqtDYfrwpgPw2IFTxcjb6xAwc91bleP
         wult6sNR4d74GajwC40uO+qLm1HIkHLgkwMkMwjXPps1xN8EUAliBxFfvoqYeB9LvwOk
         nGuTZEjTJfppp6a4hksmPxE+/o80YUsufILruJRe0KdU8/PYe4Qccpct92Dv7DZdSlzy
         ulwA==
X-Gm-Message-State: AOAM531i5NuMq16U0FqZkbMJ+ZlAD5CalepfcdlwDOJDPQL3FW38yqRt
        MYa7gWDoa6AjGLoqA9uzp6HiFgwVdc9EUt6hTRi2AJl7uXXNtbOVKEtIlSIlxqUna6xEOQMOWvB
        PLdsOTQgtXSuVCwnp+07ovcpR
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr9190181wru.393.1639084978458;
        Thu, 09 Dec 2021 13:22:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEhH9zXTTqyJyrSWANNFF5+2UsCUnbJ3IhG7hh2poI6YaxLYQDArU+ddIxOhcq+6xvoWFlHQ==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr9190171wru.393.1639084978284;
        Thu, 09 Dec 2021 13:22:58 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
        by smtp.gmail.com with ESMTPSA id g13sm1214316wrd.57.2021.12.09.13.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:22:56 -0800 (PST)
Date:   Thu, 9 Dec 2021 16:22:52 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211209162149-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:02:01PM +0100, Marcel Holtmann wrote:
> Hi Michael,
> 
> > Device removal is clearly out of virtio spec: it attempts to remove
> > unused buffers from a VQ before invoking device reset. To fix, make
> > open/close NOPs and do all cleanup/setup in probe/remove.
> 
> so the virtbt_{open,close} as NOP is not really what a driver is suppose
> to be doing. These are transport enable/disable callbacks from the BT
> Core towards the driver. It maps to a device being enabled/disabled by
> something like bluetoothd for example. So if disabled, I expect that no
> resources/queues are in use.
> 
> Maybe I misunderstand the virtio spec in that regard, but I would like
> to keep this fundamental concept of a Bluetooth driver. It does work
> with all other transports like USB, SDIO, UART etc.
> 
> > The cost here is a single skb wasted on an unused bt device - which
> > seems modest.
> 
> There should be no buffer used if the device is powered off. We also don’t
> have any USB URBs in-flight if the transport is not active.
> 
> > NB: with this fix in place driver still suffers from a race condition if
> > an interrupt triggers while device is being reset. Work on a fix for
> > that issue is in progress.
> 
> In the virtbt_close() callback we should deactivate all interrupts.
> 
> Regards
> 
> Marcel

So Marcel, do I read it right that you are working on a fix
and I can drop this patch for now?

-- 
MST

