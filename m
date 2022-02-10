Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF154B06E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiBJHXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:23:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBJHXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:23:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA620254
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644477828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ceq+h6pyLcJE8lDQD7/Uv89e7ZbHt+Awtz79f2IG+wA=;
        b=EFzGOpweFAYm3D/PDthofmGf6Y1dIiTZ2gl40UZAVq3p0Q4cZRSZgips8Ruj6cS93EUPEd
        vShIEXzETchtInL3VAO+JEnO21NHF5rY6gF0UzTomwXQZgePVvF+SU2Q71GFqQSgBVlQzm
        YLG4o+lk07M54ZrY82cwzUDpxThuKPs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-SDRvnHAdPi-S-JAOWpRSbA-1; Thu, 10 Feb 2022 02:23:47 -0500
X-MC-Unique: SDRvnHAdPi-S-JAOWpRSbA-1
Received: by mail-ej1-f72.google.com with SMTP id o4-20020a170906768400b006a981625756so2317768ejm.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 23:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ceq+h6pyLcJE8lDQD7/Uv89e7ZbHt+Awtz79f2IG+wA=;
        b=uCtPZPGeQQQjpYZhC1DD43RtIihlyHLi1PX4PoKKLiox/gb3nXP9YC3uE2Qd0Nlf5M
         zM3tClAH33qCPUl0MMpDMiZ187ciF638KBq45MejHhCNhP7UzL6mb8HuJVHcCiKHPcBQ
         nvzIt75tKQzeS5AVCKAssWb+YM8FSFFqyr7+z4a+3i8Lzg5KMmUimNQackIDlMIeYFcR
         wdV6b1/oZvPlxWRuIOD2gmvanjwXE4dIcpSrfkVAi5f2qEGAtUrJVhHJDa2QQy9aZZXT
         MvEALDLgAa4K0jjcoHCmRE2GhrC7fGOdtOR8ZqEMwMxtuDDohuxHMgAEGpRGkkxKGPhT
         Ldeg==
X-Gm-Message-State: AOAM531CO4GmVo7EgBULEVcVAG7lYmLfkBbEeC7XR6Fh4UuNHR1ZAs4n
        X55hycP0b8J+TT8jWzkLQtnu/fI+Q5bkkmT+jbN37pEnU7BqHuOetmeOtEqoXC9tQQbSFg8XoXq
        +lIfZ0umxMGN79tMUJJoIywWu
X-Received: by 2002:a05:6402:b1c:: with SMTP id bm28mr6857034edb.299.1644477826394;
        Wed, 09 Feb 2022 23:23:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyM9Av3U8CMtb+HUyYhDNUnlTEKQRuxt6w5X3ri0rXAfJGknuvg3b7lxz4SCGRkGFPZ++zLiA==
X-Received: by 2002:a05:6402:b1c:: with SMTP id bm28mr6857028edb.299.1644477826241;
        Wed, 09 Feb 2022 23:23:46 -0800 (PST)
Received: from redhat.com ([2.55.139.162])
        by smtp.gmail.com with ESMTPSA id ck9sm3667076edb.61.2022.02.09.23.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 23:23:45 -0800 (PST)
Date:   Thu, 10 Feb 2022 02:23:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helei.sig11@bytedance.com
Subject: Re: PING: [PATCH 0/3] Introduce akcipher service for virtio-crypto
Message-ID: <20220210022221-mutt-send-email-mst@kernel.org>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
 <9d07cc9d-b3f1-6fc9-eca1-6124f7baf7e0@bytedance.com>
 <CACGkMEsxnFU5TnPGxU3TjFG6MWZhtCyu93f2qzeAq08ce6VJ_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsxnFU5TnPGxU3TjFG6MWZhtCyu93f2qzeAq08ce6VJ_g@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 03:17:38PM +0800, Jason Wang wrote:
> On Thu, Feb 10, 2022 at 2:58 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
> >
> > PING!
> 
> I think it would be helpful to get ack/reviewing from crypto gurus.

For sure, but with the robot warning some people might just assume
there's a problem and wait for the next version to review.
Just post v2, don't forget the changelog.

> Maybe Herbert?
> 
> Thanks
> 
> >
> > PS: Please ignore the warning from kernel test robot, I'll fix it in
> > next version.
> >
> > On 1/21/22 10:24 AM, zhenwei pi wrote:
> > > Introduce akcipher service, implement RSA algorithm, and a minor fix.
> > >
> > > zhenwei pi (3):
> > >    virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
> > >    virtio-crypto: introduce akcipher service
> > >    virtio-crypto: implement RSA algorithm
> > >
> > >   drivers/crypto/virtio/Makefile                |   1 +
> > >   .../virtio/virtio_crypto_akcipher_algo.c      | 584 ++++++++++++++++++
> > >   drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
> > >   drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
> > >   drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
> > >   include/uapi/linux/virtio_crypto.h            |  98 ++-
> > >   6 files changed, 693 insertions(+), 10 deletions(-)
> > >   create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
> > >
> >
> > --
> > zhenwei pi
> >

