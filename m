Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2C4D4D42
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiCJP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiCJP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:29:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 783AABD3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646926090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OxmhgsYDn7lN+Q9MYhLi71z6xn1cSXOJwJ0aQe2hQ+o=;
        b=T5RyIYcFqN48CN7CIalc12XykVE/70e3LRyIRYZH7VqmxpfTd6d6E9d1xhP3I03p8aQZCM
        ctm/Ovc3j7rnehpeb+PsJMtDfFobEsQ2C2jb6ktrd4mcbcqt9U2owR5M0H3JDUEFzkPsit
        HA3KoEyeA+iA6vdLo4XICJ1NSa9NV3k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-OYrXhFR6NOGT-QssaWz7Hw-1; Thu, 10 Mar 2022 10:28:09 -0500
X-MC-Unique: OYrXhFR6NOGT-QssaWz7Hw-1
Received: by mail-wr1-f69.google.com with SMTP id l10-20020a05600012ca00b001f1e4669c98so1798450wrx.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OxmhgsYDn7lN+Q9MYhLi71z6xn1cSXOJwJ0aQe2hQ+o=;
        b=gBluLZOVkpkDe/KVEMXxfT+n/w8QvZkbL0mu8w4vClxyVYDUpYCzm3eOh51Lwu7KLw
         yjw93uyxt02zCW2AdfPIzYoPUEsfFwcJg5jD8VW5D7gYkSBhwFXqRLgIt8BDfrJTS3dI
         erOLBQjprBwz5lnYgk3wdlMVa9QIyN5h/1+hu4RfcnvQ3/1+qMvqrd/B/CWKZS5V71VY
         0D9cvKAQI64IHbkLfE6ftgLzSDSszcrmuMlclDkpHrrr4UxxjioMH5x0eyIN5Bxpxjv1
         qG7vOCitI/d0OXnfKbxL+Y1hlQwqbHpuCt/eZYdD6t1Zyl2BoRf2xDsXwi4UAhOLdJLK
         R8+w==
X-Gm-Message-State: AOAM531BYHuhhIxyjfikiGQZKiQsmGUyi/98Hfn4ONukov5LUIsWZS2e
        p4A59sWwBN5z7ZkN8TVukkgETg9uy7ln05FYWf1uMpZiwjv1wtWzKRanwCgcgXIZZxhFdVfKwJG
        d3hu5bDxAZxKrX9DwefXic4/k
X-Received: by 2002:adf:d1c2:0:b0:1f1:f89a:24ba with SMTP id b2-20020adfd1c2000000b001f1f89a24bamr4024602wrd.515.1646926087874;
        Thu, 10 Mar 2022 07:28:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvVyRWRHj93/hZgey9ZXI65IZxEXwz2fuNHtQ5iBMjN5xH2pI0mLBomxlME5TCxbw4FP1ESQ==
X-Received: by 2002:adf:d1c2:0:b0:1f1:f89a:24ba with SMTP id b2-20020adfd1c2000000b001f1f89a24bamr4024578wrd.515.1646926087550;
        Thu, 10 Mar 2022 07:28:07 -0800 (PST)
Received: from redhat.com ([2.53.27.107])
        by smtp.gmail.com with ESMTPSA id x14-20020adfffce000000b001f1dfee4867sm5998858wrs.99.2022.03.10.07.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:28:06 -0800 (PST)
Date:   Thu, 10 Mar 2022 10:28:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Jiyong Park <jiyong@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, adelva@google.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vsock: each transport cycles only on its own sockets
Message-ID: <20220310102636-mutt-send-email-mst@kernel.org>
References: <20220310135012.175219-1-jiyong@google.com>
 <20220310141420.lsdchdfcybzmdhnz@sgarzare-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310141420.lsdchdfcybzmdhnz@sgarzare-redhat>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 03:14:20PM +0100, Stefano Garzarella wrote:
> On Thu, Mar 10, 2022 at 10:50:11PM +0900, Jiyong Park wrote:
> > When iterating over sockets using vsock_for_each_connected_socket, make
> > sure that a transport filters out sockets that don't belong to the
> > transport.
> > 
> > There actually was an issue caused by this; in a nested VM
> > configuration, destroying the nested VM (which often involves the
> > closing of /dev/vhost-vsock if there was h2g connections to the nested
> > VM) kills not only the h2g connections, but also all existing g2h
> > connections to the (outmost) host which are totally unrelated.
> > 
> > Tested: Executed the following steps on Cuttlefish (Android running on a
> > VM) [1]: (1) Enter into an `adb shell` session - to have a g2h
> > connection inside the VM, (2) open and then close /dev/vhost-vsock by
> > `exec 3< /dev/vhost-vsock && exec 3<&-`, (3) observe that the adb
> > session is not reset.
> > 
> > [1] https://android.googlesource.com/device/google/cuttlefish/
> > 
> > Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > Signed-off-by: Jiyong Park <jiyong@google.com>
> > ---
> > Changes in v3:
> >  - Fixed the build error in vmci_transport.c
> > Changes in v2:
> >  - Squashed into a single patch
> > 
> > drivers/vhost/vsock.c            | 3 ++-
> > include/net/af_vsock.h           | 3 ++-
> > net/vmw_vsock/af_vsock.c         | 9 +++++++--
> > net/vmw_vsock/virtio_transport.c | 7 +++++--
> > net/vmw_vsock/vmci_transport.c   | 5 ++++-
> > 5 files changed, 20 insertions(+), 7 deletions(-)
> 
> It seems okay now, I ran my test suite and everything seems to be fine:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefanoc

Thanks!
Acked-by: Michael S. Tsirkin <mst@redhat.com>

Not a new regression so I think we should take this in the next cycle,
let's be careful here especially since previous version was not even
build-tested by the contributor.

-- 
MST

