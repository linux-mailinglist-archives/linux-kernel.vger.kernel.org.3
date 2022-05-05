Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7811951B754
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243184AbiEEFHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 01:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiEEFHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 01:07:43 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 22:04:04 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 856D211A01
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651727043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzUleSxK9nl8YlNcYVSjvCKZ2tNHw3I29yrW6MqQSZs=;
        b=M2q9tnv2iErdPywBIGHQLsDyGyLEqRC5dKWJ95urQPLu2oxWxV6SXj+wZxoIDv+cC4+ttt
        AwnoxlFwniQMigdcHUIFr2I5Val2efqRXj758G26tN+/mVi5bnhzCwiz8/Dw8ukMJy9Zmb
        VNcyIeEc+HmiN36fwTsAc/gUwaIIW8Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-yvZhvujkO8e6wL7PHQFcZw-1; Thu, 05 May 2022 00:57:55 -0400
X-MC-Unique: yvZhvujkO8e6wL7PHQFcZw-1
Received: by mail-ed1-f71.google.com with SMTP id l24-20020a056402231800b00410f19a3103so1727113eda.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 21:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rzUleSxK9nl8YlNcYVSjvCKZ2tNHw3I29yrW6MqQSZs=;
        b=KBoZ9f9K/OOYQaFYTf78jUdcQ9OoGINT/0VrJgUT/cwt8CX9+bRdBDtWu1CmMJ2WIT
         ETsnI7Tcc3QGE5r+jzmm5JdMICdmQUkw1VS0blRhV3VdixoqO2J9i9A6SyGrO17o0GLO
         uQpeRGFwqcBGDRueJz6A8FYpqGBND+weVKuSYsljIqMT8zbxaBUy8/q8qEISSDNr0+ic
         BTSBGsu+YfVVMVN3GOw3G9BF10eRFgAmm6UFgcsH3qxTZFy0gboqj9mRpZB3jfVlEdFo
         8SbBBGm3DVnTwuVyDuGAwhE/r5jMeGO+tDl7hZu+07JiWNs9PtXeSLmj+g/Zj7JVf7KY
         bYAQ==
X-Gm-Message-State: AOAM530vWUWuFlQhQxc9u3eCXxz8W/P0Se9ejo+XjsyQFisQw1M6CQLS
        FnnUI1yRqTy5goIUM/7O2xzHHz+asdxr09hztcvYog6/hMUFfstMvvanHcAqzxtQuCpaBjlMfrD
        LNi6LsTjL8Am/nnDB4U84uUMR
X-Received: by 2002:a17:906:4fcd:b0:6f4:b5c0:aa44 with SMTP id i13-20020a1709064fcd00b006f4b5c0aa44mr7687134ejw.445.1651726674813;
        Wed, 04 May 2022 21:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbX4SoVGMOKvRO7Omo/n5jSKXm67g9e9YispmVFqRKvn39kXm8wsjujTpuSP3Yg3lt2T129Q==
X-Received: by 2002:a17:906:4fcd:b0:6f4:b5c0:aa44 with SMTP id i13-20020a1709064fcd00b006f4b5c0aa44mr7687117ejw.445.1651726674576;
        Wed, 04 May 2022 21:57:54 -0700 (PDT)
Received: from redhat.com ([2.53.134.204])
        by smtp.gmail.com with ESMTPSA id q10-20020a1709064cca00b006f3ef214dd7sm311969ejt.61.2022.05.04.21.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 21:57:53 -0700 (PDT)
Date:   Thu, 5 May 2022 00:57:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Message-ID: <20220505005607-mutt-send-email-mst@kernel.org>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
 <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
 <7f7ab8ae46174ed6b0888b5fbeb5849b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f7ab8ae46174ed6b0888b5fbeb5849b@huawei.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 03:14:40AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> > Sent: Thursday, May 5, 2022 10:35 AM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com;
> > jasowang@redhat.com
> > Cc: herbert@gondor.apana.org.au; linux-kernel@vger.kernel.org;
> > virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org;
> > helei.sig11@bytedance.com; davem@davemloft.net
> > Subject: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
> > 
> > Hi, Lei
> > 
> > Jason replied in another patch:
> > Still hundreds of lines of changes, I'd leave this change to other maintainers to
> > decide.
> > 
> > Quite frankly, the virtio crypto driver changed only a few in the past, and the
> > performance of control queue is not good enough. I am in doubt about that this
> > driver is not used widely. So I'd like to rework a lot, it would be best to complete
> > this work in 5.18 window.
> > 
> > This gets different point with Jason. I would appreciate it if you could give me
> > any hint.
> > 
> 
> This is already in my todo list.
> 
> Regards,
> -Gonglei

It's been out a month though, not really acceptable latency for review.
So I would apply this for next,  but you need to address Dan Captenter's
comment, and look for simular patterns elesewhere in your patch.


> > On 4/24/22 18:41, zhenwei pi wrote:
> > > Hi, Lei
> > > I'd like to move helper and callback functions(Eg, virtcrypto_clear_request
> > >   and virtcrypto_ctrlq_callback) from xx_core.c to xx_common.c, then
> > > the xx_core.c supports:
> > >    - probe/remove/irq affinity seting for a virtio device
> > >    - basic virtio related operations
> > >
> > > xx_common.c supports:
> > >    - common helpers/functions for algos
> > >
> > > Do you have any suggestion about this?
> > >
> > > v3 -> v4:
> > >   - Don't create new file virtio_common.c, the new functions are added
> > >     into virtio_crypto_core.c
> > >   - Split the first patch into two parts:
> > >       1, change code style,
> > >       2, use private buffer instead of shared buffer
> > >   - Remove relevant change.
> > >   - Other minor changes.
> > >
> > > v2 -> v3:
> > >   - Jason suggested that spliting the first patch into two part:
> > >       1, using private buffer
> > >       2, remove the busy polling
> > >     Rework as Jason's suggestion, this makes the smaller change in
> > >     each one and clear.
> > >
> > > v1 -> v2:
> > >   - Use kfree instead of kfree_sensitive for insensitive buffer.
> > >   - Several coding style fix.
> > >   - Use memory from current node, instead of memory close to device
> > >   - Add more message in commit, also explain why removing per-device
> > >     request buffer.
> > >   - Add necessary comment in code to explain why using kzalloc to
> > >     allocate struct virtio_crypto_ctrl_request.
> > >
> > > v1:
> > > The main point of this series is to improve the performance for virtio
> > > crypto:
> > > - Use wait mechanism instead of busy polling for ctrl queue, this
> > >    reduces CPU and lock racing, it's possiable to create/destroy session
> > >    parallelly, QPS increases from ~40K/s to ~200K/s.
> > > - Enable retry on crypto engine to improve performance for data queue,
> > >    this allows the larger depth instead of 1.
> > > - Fix dst data length in akcipher service.
> > > - Other style fix.
> > >
> > > lei he (2):
> > >    virtio-crypto: adjust dst_len at ops callback
> > >    virtio-crypto: enable retry for virtio-crypto-dev
> > >
> > > zhenwei pi (3):
> > >    virtio-crypto: change code style
> > >    virtio-crypto: use private buffer for control request
> > >    virtio-crypto: wait ctrl queue instead of busy polling
> > >
> > >   .../virtio/virtio_crypto_akcipher_algs.c      |  83 ++++++-----
> > >   drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
> > >   drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
> > >   .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
> > >   4 files changed, 180 insertions(+), 119 deletions(-)
> > >
> > 
> > --
> > zhenwei pi

