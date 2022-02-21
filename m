Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8294B4BDC39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377192AbiBUOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:00:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377182AbiBUOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DDBF1A3B0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645451977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSVIW7WKSNU5PqfuEaIi9kuilnpf4QQg552O4p0c0vg=;
        b=Vokr/A4fohDcKbA6ZR0nwGtofkFZt+UdAxvewAbmPgr7KnQUK+eBVNj/l+nLxvtj9Hf0X+
        8o/vSAYnOHMb8P73LsckGMivAk3jiEPsrGWBC7OYMiGsCsPyiRRz55W2dnQZkMAKaOl5Up
        sw/AxxIgkslViqRai2fxVEC+utoqSNE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-HBE7iRrqPcOroyBRk2T91w-1; Mon, 21 Feb 2022 08:59:36 -0500
X-MC-Unique: HBE7iRrqPcOroyBRk2T91w-1
Received: by mail-wm1-f69.google.com with SMTP id p13-20020a05600c204d00b0037ea24db798so2439560wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSVIW7WKSNU5PqfuEaIi9kuilnpf4QQg552O4p0c0vg=;
        b=UlYPS/EMUybE34Ho+PM61cLv1GvIQR8RBUDleOF9S6uENCsiADF2HZ7j4kNB+WNWRc
         JiQ5ao8VA4XndHcvA0Dosi5QhJq88oFUqcDaXp6ojfkT79fkH7iifwjIGIVuAmMxfn7r
         3/g+mobAVaHCGl+rfznpErPOtIjKxNuiqP/poqFnrrui9AvkPCLNGpJ42zctr5e5FEAl
         eSNrl/98rKJRPrXhbnZN2mUFC7q+FLxwDKppJC/2JZq6aMF3WIUrpZ4cLzwxoBhDJfwO
         sx7aw0y6rGrPbhPi7rSArxtYoFr+nCKMylqpHSaJhxaN9WJIo7eDsWuivpGeegJOcj/r
         6y8A==
X-Gm-Message-State: AOAM531m8c4014v5YEQ88lJSVktuXv/gtzduwp3ODFL0iH9zE5wJpKv0
        Tkd/qOR+fhv9vlm6Zf+S2luICEiye0YCkLxkMqIoo3jVrKyHMTJvo3ilmlLqVske5OC/ec8to9Q
        BRqJhm/dSaK5m9o/tKVrB7on+
X-Received: by 2002:adf:9f4a:0:b0:1e3:1c28:c298 with SMTP id f10-20020adf9f4a000000b001e31c28c298mr15464349wrg.233.1645451975137;
        Mon, 21 Feb 2022 05:59:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxFnMEd+AorTKgUxxWlJ80t1TpsoeHG7oT0Zc9X8kQornxrzt1FVqy8lGYBIKPsefgfErXU1w==
X-Received: by 2002:adf:9f4a:0:b0:1e3:1c28:c298 with SMTP id f10-20020adf9f4a000000b001e31c28c298mr15464328wrg.233.1645451974972;
        Mon, 21 Feb 2022 05:59:34 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it. [95.248.229.156])
        by smtp.gmail.com with ESMTPSA id i13sm13512139wrp.87.2022.02.21.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:59:34 -0800 (PST)
Date:   Mon, 21 Feb 2022 14:59:30 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Mike Christie <michael.christie@oracle.com>,
        Jason Wang <jasowang@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        kvm <kvm@vger.kernel.org>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] vhost/vsock: don't check owner in vhost_vsock_stop()
 while releasing
Message-ID: <CAGxU2F6aMqTaNaeO7xChtf=veDJYtBjDRayRRYkZ_FOq4CYJWQ@mail.gmail.com>
References: <20220221114916.107045-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221114916.107045-1-sgarzare@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 12:49 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> vhost_vsock_stop() calls vhost_dev_check_owner() to check the device
> ownership. It expects current->mm to be valid.
>
> vhost_vsock_stop() is also called by vhost_vsock_dev_release() when
> the user has not done close(), so when we are in do_exit(). In this
> case current->mm is invalid and we're releasing the device, so we
> should clean it anyway.
>
> Let's check the owner only when vhost_vsock_stop() is called
> by an ioctl.
>
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+1e3ea63db39f2b4440e0@syzkaller.appspotmail.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vhost/vsock.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com

