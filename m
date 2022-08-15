Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AEB592AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241312AbiHOHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbiHOHnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 599C718E24
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660549397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yDB6Dng4odX19UxgKFSAsHyj7giMURZ2eqldW4V8gPs=;
        b=hUYEKdKZ9HIkIGBmwBtkwMz1Cy+YnmFelNd+Ztr7tQg9DbOIUIm9G/xPD9osk92MRNHQnF
        tk5X4Edp5eO6RaKsAmEghk614U3Runga7ykL2vE2e8NWNBNxO3gfr916onJnt1VMkSPpPC
        IlwNJYWb/xPMYc2lMI3siFLqXCLZqn0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-lC9QUwlrOIWStMNGh4tvAw-1; Mon, 15 Aug 2022 03:43:16 -0400
X-MC-Unique: lC9QUwlrOIWStMNGh4tvAw-1
Received: by mail-ed1-f69.google.com with SMTP id o2-20020a056402438200b0043d552deb2aso4282680edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yDB6Dng4odX19UxgKFSAsHyj7giMURZ2eqldW4V8gPs=;
        b=WgC3Ytop4VMd/vN+Ge7DXL21O5BntqIBzCEhP4suE9H7LupXpHK2bc6mB+gUYLPunW
         5I54vHugD+fBYXRHk67IZRiWnYIaYjlyhzQpMu9MGPYVcFkVnjcGk7Iksm2HK6fXkC44
         nPZEVUtAnzdtY6RNsQeTN6QWTvbcpZKOAHv98LeVzos3GoFUVkp6EDHf6hPXexTLYOj/
         k7JIM3WGbEEh3AT7vlcF0e2RtjiTCIxD9H1zS7SnzRPnHA79Rlr2EKSEbTrlgByFnljM
         y36ZhWHoWOUvgNni+TSEFwFOSc2tVF6hPxPPE3917hao2aGj88hJo+JdgiX1FNhgc8yb
         yB3g==
X-Gm-Message-State: ACgBeo2JkRVYdCe/i6tS0nOAXryYnd3f81sQLdp2zjGnTL/G2FDvmxOl
        KJ1DYmhBQrATDEziJSrktFcS1oJrDhJgEF30jfs6jdBoXWcjt0RN/cmSgn1Ym+bmWWuMgkjRgFm
        ZU0DqfueqHxkRgn/qSk3AWAgp
X-Received: by 2002:a05:6402:3514:b0:440:5538:3a97 with SMTP id b20-20020a056402351400b0044055383a97mr13689614edd.165.1660549394757;
        Mon, 15 Aug 2022 00:43:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR52mfAhSTqnZj95HxvlqpvDfImskCbvWzlHKJ6rnWIZQixS47ES0gaMSYIq/FDh8FTxrHiIbg==
X-Received: by 2002:a05:6402:3514:b0:440:5538:3a97 with SMTP id b20-20020a056402351400b0044055383a97mr13689603edd.165.1660549394589;
        Mon, 15 Aug 2022 00:43:14 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id u5-20020a056402110500b0043bc19efc15sm6086720edv.28.2022.08.15.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:43:14 -0700 (PDT)
Date:   Mon, 15 Aug 2022 03:43:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815033955-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <20220815022711-mutt-send-email-mst@kernel.org>
 <D887C3E7-4C2A-4576-8F63-4CFFF8479069@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D887C3E7-4C2A-4576-8F63-4CFFF8479069@anarazel.de>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:17:44AM -0700, Andres Freund wrote:
> Hi, 
> 
> On August 14, 2022 11:36:55 PM PDT, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >On Sun, Aug 14, 2022 at 06:36:51PM -0700, Andres Freund wrote:
> >> Hi,
> >> 
> >> On 2022-08-14 19:04:22 -0600, Jens Axboe wrote:
> >> > I took a quick look and added more SCSI bits to my vm images, but
> >> > haven't been able to hit it.
> >> 
> >> Didn't immediately hit anything locally in a vm either...
> >> 
> >> 
> >> > Sounds like Andres is already bisecting this, so I guess we'll be wiser
> >> > soon enough.
> >> 
> >> I started bisecting the network issue, as it occurred first, and who knows
> >> what else it could affect. Will bisect the other range after.
> >> 
> >> Due to the serial console issue mentioned upthread it's pretty slow
> >> going. Each iteration I create a new gcp snapshot and vm. Adds like ~10min.
> >> Doesn't help if intermediary steps don't boot with different symptoms and
> >> another doesn't immediately build...
> >
> >Just so we can stop pestering everyone, could you try
> >
> >git revert --no-edit 0b6fd46ec5f5..a335b33f4f35 ?
> >
> >Equivalently I pushed it here:
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git test
> 
> Saw this too late - I assume you don't need this anymore now that I pinpointed the one commit?
> 
> Andres

Right, at least not yet - could you clarify the folliwing please:

So IIUC you see several issues, right?

With 762faee5a2678559d3dc09d95f8f2c54cd0466a7 you see networking issues.

With ebcce492636506443e4361db6587e6acd1a624f9 you see crashes.

I just want to make sure the issue is virtio specific and then we can drop
Linus et al and move this to the virtio ML.

Thanks!

-- 
MST

