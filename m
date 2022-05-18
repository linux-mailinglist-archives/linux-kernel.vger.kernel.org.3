Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065FB52B123
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiEREKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiEREKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2990D163291
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652847015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+NOVFFIZd9DRh/qXC8inU5DUoXa1hR/cvg4Nz0WouAs=;
        b=DeBVfZoUmOC7BLSv+daLVjIMW3AXrI++NZl4FfVl18Gn9Y9l0XhK0RzOZsyOTfIZfODoV0
        eug8bRgrsm+As6nnqtpbioI2dEnzmkeDUYXMN7tmjkJExRvo17ub6UB3xxRhdZlhlknUXs
        2960qj5wob6V5YXaRr27/md5f/Ezpp8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-KMLBO9wgNAOWnmTsImET2w-1; Wed, 18 May 2022 00:10:14 -0400
X-MC-Unique: KMLBO9wgNAOWnmTsImET2w-1
Received: by mail-lf1-f70.google.com with SMTP id p5-20020ac246c5000000b0047257761087so500415lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NOVFFIZd9DRh/qXC8inU5DUoXa1hR/cvg4Nz0WouAs=;
        b=BCL6qILpxe7+7m2d1e6Ei7geuMm/88p9wINFSOFE3gMjcpKpYusu2ITmT57UXFVoKq
         BgiXrejbPpcUXQEr7lnITuKGuDSAYQ5gaAhE/dKwelBvWxAfYjqRjtBkDtWnVeDCjpXu
         9LkGzPUDRFZVnccW2iyuEkUk7/e1pveA4kw3vSBDH40Hyx3J4OG/4P07FWM19nmERoUl
         ON5ExKpgZVg3oq0vM/lQdzgzp+lyBoz+BDhhfZQVlBdZD0k6ZrWFcrAxsmsCIhUej1qg
         XzYAS99GwBX1oEppxh0/+3R1VveZH4hbmyy44fR3SHt/3OvB/Y26tU7gDQBLhlE7vTpp
         ZD4g==
X-Gm-Message-State: AOAM5319RiP1rajblBD6FR3V+ezNK8rWqot/XPWy4m+djXfEdOoWY2+V
        n3o0Th9FincwIlLmVOWjyczain3065d9Ns/HP9LQb3m9J9SSAAzTDlUM+wHWxrG4JCpKugQrCnM
        p5zZ7rMtFOp+7kleyD/o0lcpV328i14kWMo13HFMq
X-Received: by 2002:a05:6512:3e0a:b0:477:b256:56b with SMTP id i10-20020a0565123e0a00b00477b256056bmr2426675lfv.587.1652847012602;
        Tue, 17 May 2022 21:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo7LnwP2KhWd3cqQbJhDB1nD2XDUYc/xI2VSj4Lg3fzncr5rIBmRwqIBBPDJGhkob+9Xm5o+qCmV9M+3IXOIU=
X-Received: by 2002:a05:6512:3e0a:b0:477:b256:56b with SMTP id
 i10-20020a0565123e0a00b00477b256056bmr2426663lfv.587.1652847012356; Tue, 17
 May 2022 21:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220516084213.26854-1-jasowang@redhat.com> <20220516044400-mutt-send-email-mst@kernel.org>
 <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
In-Reply-To: <YoQa4wzy9jSwDY7E@zeniv-ca.linux.org.uk>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 18 May 2022 12:10:01 +0800
Message-ID: <CACGkMEvu8eVQ5Sy0675xjhukyPRoCKnTF+t0tpXw6dsexe3v1A@mail.gmail.com>
Subject: Re: [PATCH] vhost_net: fix double fget()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        davem <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 6:00 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, May 16, 2022 at 04:44:19AM -0400, Michael S. Tsirkin wrote:
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > and this is stable material I guess.
>
> It is, except that commit message ought to be cleaned up.  Something
> along the lines of
>
> ----
> Fix double fget() in vhost_net_set_backend()
>
> Descriptor table is a shared resource; two fget() on the same descriptor
> may return different struct file references.  get_tap_ptr_ring() is
> called after we'd found (and pinned) the socket we'll be using and it
> tries to find the private tun/tap data structures associated with it.
> Redoing the lookup by the same file descriptor we'd used to get the
> socket is racy - we need to same struct file.
>
> Thanks to Jason for spotting a braino in the original variant of patch -
> I'd missed the use of fd == -1 for disabling backend, and in that case
> we can end up with sock == NULL and sock != oldsock.
> ----
>
> Does the above sound sane for commit message?

Yes.

> And which tree would you
> prefer it to go through?  I can take it in vfs.git#fixes, or you could
> take it into your tree...
>

Consider Michael gave an ack, it would be fine if you want to take via
your tree.

Thanks

