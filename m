Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C8582683
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiG0MaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiG0M36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1A66186D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658924996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AxBuSirLSlmCaBjX7uKmZi3DKKvsk0CPMisH3i3PiEM=;
        b=Lkakvun1qpweTuNHK6RPZOedtFYlgl2IV45eNeBnQqFXsfVq9IU/QpUSxF4M3XY3YM4dDo
        iqafHn4v+M6J9MpPZmSbKhI+ohgfOi25ViY73of4brZaoPRKigzTln5Zy1zkSuIp/O9Tyj
        /bCDBWMrYGI2JMeq/AXM9yZLua7iTnM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-Gs0BWKgoPECZnUTrjkGjXg-1; Wed, 27 Jul 2022 08:29:55 -0400
X-MC-Unique: Gs0BWKgoPECZnUTrjkGjXg-1
Received: by mail-lj1-f198.google.com with SMTP id k2-20020a2ea282000000b0025dea602f7cso3722762lja.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxBuSirLSlmCaBjX7uKmZi3DKKvsk0CPMisH3i3PiEM=;
        b=515Ig2EJSZL793dizb4a+AQoiGtFFaSeEJt8ragjDKkEa9HkhtpsFJDVYBZ1GDSGW5
         GRqFJcB3TbpbkXyHY8CRzThRKKln7zkxuAuk3bYcjcwGUIx3CPKoZVRbyyJ1oWcJLUue
         L6qj47X4mkWfW7uAXXSEWmhot7A2w4xY8F41ukDx65YQWQ9TNnM/rQvaKRfzVgGgzlOT
         HsjE8XHvEMBL9A8sC9Z1JIys90fn8WvYKQDf0yQy0dRAOLv/Xv3kDWVv7L1xcm2U5Eqx
         fCPOaBhbw8C4D+Ho45tdu+2RACIDsrqT92+C9pMzK2A1Cn5kv4i0iHYeZccNYpnc5v1e
         mQGA==
X-Gm-Message-State: AJIora9W7AffdecOGYhus52geB62Rq0P3sOPVFV35vGyNaj/UnKmPtLT
        TZesKlTKjXKZ4J9h36e9fzokQJf+mev3js1OYwgICGgoBxwMIivpZnJDhQ4efWg6kjX/6w8i2k3
        KFRXU2BcbVVLAt0SDGe3IZrWpIeEbNitiFXtLjxZK
X-Received: by 2002:a05:6512:31ca:b0:48a:2e3:db41 with SMTP id j10-20020a05651231ca00b0048a02e3db41mr7946394lfe.285.1658924994159;
        Wed, 27 Jul 2022 05:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1usleWIBkFGXVgg8pf87FeBHyq3CnAy0dTxHgebzQtlLd72pXddpA1ORMMZjBTZ4Ut4Od8ZGxlwfL8cz5Y/fek=
X-Received: by 2002:a05:6512:31ca:b0:48a:2e3:db41 with SMTP id
 j10-20020a05651231ca00b0048a02e3db41mr7946372lfe.285.1658924993965; Wed, 27
 Jul 2022 05:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
 <355f4bb6-82e7-2400-83e9-c704a7ef92f3@sberdevices.ru> <20220727122241.mrafnepbelcboo5i@sgarzare-redhat>
In-Reply-To: <20220727122241.mrafnepbelcboo5i@sgarzare-redhat>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Wed, 27 Jul 2022 14:29:42 +0200
Message-ID: <CAGxU2F7uw8fo4bn7t+3L2-irvxtCY+KchzPSXayimZZjdM1sdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/9] vmci/vsock: use 'target' in notify_poll_in, callback
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Bryan Tan <bryantan@vmware.com>,
        Rajesh Jalisatgi <rjalisatgi@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 2:22 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> @Jorgen can you take a look at this series, especially this patch?

Jorgen's email bounced back, so I'm CCing VMCI maintainers.

Bryan, Rajesh, Vishnu, can you take a look?

Thanks,
Stefano

>
> Maybe we need to update the comments in the else branch, something like
> s/there is nothing/there is not enough data
>
> Thanks,
> Stefano
>
> On Mon, Jul 25, 2022 at 08:01:01AM +0000, Arseniy Krasnov wrote:
> >This callback controls setting of POLLIN,POLLRDNORM output bits of poll()
> >syscall,but in some cases,it is incorrectly to set it, when socket has
> >at least 1 bytes of available data. Use 'target' which is already exists
> >and equal to sk_rcvlowat in this case.
> >
> >Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >---
> > net/vmw_vsock/vmci_transport_notify.c        | 2 +-
> > net/vmw_vsock/vmci_transport_notify_qstate.c | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/vmw_vsock/vmci_transport_notify.c b/net/vmw_vsock/vmci_transport_notify.c
> >index d69fc4b595ad..1684b85b0660 100644
> >--- a/net/vmw_vsock/vmci_transport_notify.c
> >+++ b/net/vmw_vsock/vmci_transport_notify.c
> >@@ -340,7 +340,7 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> > {
> >       struct vsock_sock *vsk = vsock_sk(sk);
> >
> >-      if (vsock_stream_has_data(vsk)) {
> >+      if (vsock_stream_has_data(vsk) >= target) {
> >               *data_ready_now = true;
> >       } else {
> >               /* We can't read right now because there is nothing in the
> >diff --git a/net/vmw_vsock/vmci_transport_notify_qstate.c b/net/vmw_vsock/vmci_transport_notify_qstate.c
> >index 0f36d7c45db3..a40407872b53 100644
> >--- a/net/vmw_vsock/vmci_transport_notify_qstate.c
> >+++ b/net/vmw_vsock/vmci_transport_notify_qstate.c
> >@@ -161,7 +161,7 @@ vmci_transport_notify_pkt_poll_in(struct sock *sk,
> > {
> >       struct vsock_sock *vsk = vsock_sk(sk);
> >
> >-      if (vsock_stream_has_data(vsk)) {
> >+      if (vsock_stream_has_data(vsk) >= target) {
> >               *data_ready_now = true;
> >       } else {
> >               /* We can't read right now because there is nothing in the
> >--
> >2.25.1

