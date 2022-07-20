Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2454E57B151
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiGTHAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTHAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19B1665545
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658300401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRLM3otrmE4GIymRIerp3u+bT993AETRwpgpngLar7s=;
        b=fxle8lvpPav2Vv2Fv+DrR8bVnike3jdYFqk7Wv35caDV1jg1FvzHGur27mUQDLt6ZoWjmB
        xtNYWeK2ktQFiz6URetQGDeWmLdYbtR/kK8IthQg0hrgfoO+y7crbj7SRZIxjGlRCt4idl
        QnKDWlGjTO6Vb3tzgQVONfr4JPlsV+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-EWcvP5ByO6OlsjgLrrBsLw-1; Wed, 20 Jul 2022 02:59:59 -0400
X-MC-Unique: EWcvP5ByO6OlsjgLrrBsLw-1
Received: by mail-wm1-f71.google.com with SMTP id bh18-20020a05600c3d1200b003a32044cc9fso2922495wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HRLM3otrmE4GIymRIerp3u+bT993AETRwpgpngLar7s=;
        b=PWpldfJUEDUSEvvsZePX65LLdnM3vnaUnXvSsNLo1TlPXdKHmnHKbbgWHVf716/8i8
         DNPdoHx/aKe279P6pxZe0PDes9zFO2jAt8sYgxtsftAgljNlFNt8snzu+IZX1uVzuccc
         KxMaa4puaOun1S1cnWNX0cnknDteHJeQf1hxiQPAfcosPbneeMPFc3ggD9GkgL0cMvcL
         9TaTTZc6pImBUU9lcEZXsU0W3vXKP7UmVZrv85hP2GqZ4BTEg19aWROlspvPpX/iJ4KB
         K2vfQRg1UNbaN9yXSX/bR2+SKsz/uJRHnCjo1NpHCpozpAy4VJQ8dhfc1mQQ8DR6unaU
         5Wsw==
X-Gm-Message-State: AJIora9AgJyN0d672Aq7xgo8eLbDvB/hOGVPTL1YFtDfAE+PO3dgn0b6
        6p5CG8GVfer6khjCF4FJoIkITNuE7I3S0wkkmxuCQ/lfd5WnzAbxgdmTbjJq2YXdxw3E0A6o90e
        PrJA7KqVbW4ywb8+g72pd+niP
X-Received: by 2002:a5d:6d8b:0:b0:21d:a6ac:b34b with SMTP id l11-20020a5d6d8b000000b0021da6acb34bmr29835067wrs.35.1658300397994;
        Tue, 19 Jul 2022 23:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t58h1XiqLZzpVmt8FSkHa/kkkDQfr5n1b3uEEv7XFX0KTmylaQzbuExz7aQ6ttvtdtJ0w0kg==
X-Received: by 2002:a5d:6d8b:0:b0:21d:a6ac:b34b with SMTP id l11-20020a5d6d8b000000b0021da6acb34bmr29835052wrs.35.1658300397740;
        Tue, 19 Jul 2022 23:59:57 -0700 (PDT)
Received: from redhat.com ([2.55.47.4])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0560001f8300b0021d70a871cbsm14632970wrb.32.2022.07.19.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 23:59:57 -0700 (PDT)
Date:   Wed, 20 Jul 2022 02:59:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Keir Fraser <keirf@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220720024756-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
 <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org>
 <YtbXxl8STUtQkacb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbXxl8STUtQkacb@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 04:11:50PM +0000, Keir Fraser wrote:
> On Tue, Jul 19, 2022 at 08:51:54AM -0700, Christoph Hellwig wrote:
> > On Tue, Jul 19, 2022 at 03:46:08PM +0000, Keir Fraser wrote:
> > > However, if the general idea at least is acceptable, would the
> > > implementation be acceptable if I add an explicit API for this to the
> > > DMA subsystem, and hide the detail there?
> > 
> > I don't think so.  The right thing to key off is
> > VIRTIO_F_ACCESS_PLATFORM, which really should be set in any modern
> > virtio device after all the problems we had with the lack of it.
> 
> Ok. Certainly the flag description in virtio spec fits the bill.

Maybe. But balloon really isn't a normal device. Yes the rings kind of
operate more or less normally. However consider for example free page
hinting. We stick a page address in ring for purposes of telling host it
can blow it away at any later time unless we write something into the
page.  Free page reporting is similar.
Sending gigabytes of memory through swiotlb is at minimum not
a good idea.

Conversely, is it even okay security wise that host can blow away any
guest page?  Because with balloon GFNs do not go through bounce
buffering.



> > > Or a completely different approach would be to revert the patch
> > > e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
> > > driver. MST: That's back in your court, as it's your patch!
> > 
> > Which also means this needs to be addresses, but I don't think a
> > simple revert is enough.
> 
> Well here are two possible approaches:
> 
> 1. Revert e41b1355508d outright. I'm not even sure what it would mean
> for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
> is no longer IOMMU-specific anyway.
> 
> 2. Continue to clear the flag during virtio_balloon negotiation, but
> remember that it was offered, and test for that in vring_use_dma_api()
> as well as, or instead of, virtio_has_dma_quirk().
> 
> Do either of those appeal?

I think the use case needs to be documented better.


-- 
MST

