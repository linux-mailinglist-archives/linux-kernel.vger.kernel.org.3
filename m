Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B685B23C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiIHQky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiIHQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F17F4103
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662655247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pkfsc+Qd/gwYAug2VWPkSKKYrJX5Z5R+zOqDD2izm4g=;
        b=CN0WctdZCN9KIa1PXewYuTDwMMsEkFiaB/EB3ScffMXiFnO2B06FL51uCSc1hWaVUl8Y7l
        KHThGe/JcBdUW8qOkB/TBVWIQG+IPPaN+meojzfCZ8QVpKwkrVfqD7UuLBYajZt9pVPczh
        JQNBoNW7o1uuJyR89krM7QKUMGP4EL8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-78-4PFuv_ygNOmAEtWP-_M-Gg-1; Thu, 08 Sep 2022 12:40:46 -0400
X-MC-Unique: 4PFuv_ygNOmAEtWP-_M-Gg-1
Received: by mail-qk1-f197.google.com with SMTP id de43-20020a05620a372b00b006bc3aa1908dso1076826qkb.15
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 09:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pkfsc+Qd/gwYAug2VWPkSKKYrJX5Z5R+zOqDD2izm4g=;
        b=2ZFKKQbt+XDI2HrL8izxR96vDzoyguOol9acgSfm1noRPvbRnP3Ce6G5bbQIDGMMrC
         X8PiaOPNRlwoPLMg+K66N+CnZ25Mi2e9jhocH4oMrRQ4oalox2qXlPI6ZDUVhMH34WP1
         I2DCpS4jLusDQLuHDeKJxgL2DU2/tI5HSai+B0EqOuxP/I19X/YvJiOQbhMPOpsZvOkR
         kKR4yHU5OCBnX99yBYC9K70YCKQIHeCnsu7+cneqKPQnWqtxbDjUCU741Z5ItLCX6LwG
         HrCaUtauh4L10gAuHUNXPxPIpcjfXo9U0RZxORVIygRlA9+jUEVYUpMGzf1RMfYQbnxR
         h6Jg==
X-Gm-Message-State: ACgBeo3AYPGnh9QsYM+31MDQiIQKw3gEKGNVL+8/cihFMSGGeeoczyLL
        bilCjXNJdFCZMULYfFMPY51Fy9o+mJrzUKQAHS5iTuP8s1sATZdMILAdMmN+2gO5pMkm7nBSGJ4
        IPbQNhuthr20ugdxSyI52aHjU
X-Received: by 2002:a05:620a:14aa:b0:6cb:e3a2:311b with SMTP id x10-20020a05620a14aa00b006cbe3a2311bmr904222qkj.266.1662655245504;
        Thu, 08 Sep 2022 09:40:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR53cNBgQZY4hEhzYVT/VkqEs1YXNR9ifPFn0pnI+C10iK7Hb4Aw/802twYiNtloEdpZjdtoJg==
X-Received: by 2002:a05:620a:14aa:b0:6cb:e3a2:311b with SMTP id x10-20020a05620a14aa00b006cbe3a2311bmr904197qkj.266.1662655245128;
        Thu, 08 Sep 2022 09:40:45 -0700 (PDT)
Received: from redhat.com ([45.144.113.243])
        by smtp.gmail.com with ESMTPSA id v38-20020a05622a18a600b0035a7070e909sm701989qtc.38.2022.09.08.09.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:40:44 -0700 (PDT)
Date:   Thu, 8 Sep 2022 12:40:35 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Igor Skalkin <igor.skalkin@opensynergy.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        mgo@opensynergy.com
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220908123911-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org>
 <20220811035817-mutt-send-email-mst@kernel.org>
 <CABBYNZKZGxbt=jdpBL77x1mCeTPdDE-p-Pt8JjZN+KoRgR3Ohw@mail.gmail.com>
 <20220830094441-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830094441-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:45:02AM -0400, Michael S. Tsirkin wrote:
> On Thu, Aug 11, 2022 at 10:02:31AM -0700, Luiz Augusto von Dentz wrote:
> > Hi Michael,
> > 
> > On Thu, Aug 11, 2022 at 1:00 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > > > > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > > > >
> > > > >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > > > >
> > > > >         According to specification [1], "For the device-specific configuration
> > > > >         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> > > > >         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> > > > >         and aligned accesses for 32 and 64 bit wide fields.".
> > > > >
> > > > >         Current version of the configuration structure:
> > > > >
> > > > >             struct virtio_bt_config {
> > > > >                 __u8  type;
> > > > >                 __u16 vendor;
> > > > >                 __u16 msft_opcode;
> > > > >             } __attribute__((packed));
> > > > >
> > > > >         has both 16bit fields non-aligned.
> > > > >
> > > > >         This commit fixes it.
> > > > >
> > > > >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> > > > >
> > > > >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > > > >
> > > > >     This is all true enough, but the problem is
> > > > >     1. changing uapi like this can't be done, will break userspace
> > > > >     2. the driver has more issues and no one seems to want to
> > > > >        maintain it.
> > > > >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> > > > >     to merge it for this release.
> > > > >
> > > > > This is very sad. We already use this driver in our projects.
> > > >
> > > > Really?  Can you step up to maintain it? Then we can fix the issues
> > > > and it won't be broken.
> > >
> > > Just a reminder that I'm waiting for a response on that.
> > > I just don't know enough about bluetooth.
> > 
> > Just a heads up that Marcel is on vacation, he did mention that he had
> > done some work to update virtio_bt thus why I didn't apply any of the
> > changes yet.
> 
> Any update? when does Marcel return?


Annnnnnd ... this is falling between the chairs again?
Guys if anyone wants to use this driver it needs a maintainer.

> > > --
> > > MST
> > >
> > 
> > 
> > -- 
> > Luiz Augusto von Dentz

