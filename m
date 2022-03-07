Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57A4D0B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 23:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbiCGWkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 17:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243209AbiCGWkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 17:40:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89BB14665B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 14:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646692795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJJnjNEDLDCxgTnNZiuLduAW9RdSuGCDd7yDQswPSHQ=;
        b=XjYpj5w0WyYp59YoxpO90KpD2P4RXY749mo/qsLlPgajXgarGewhuTmLV1JEmXh0VAFJl4
        VORHKlaLQ6i/6P0xTYCi6O3UjP475+kRXTxTcN6K/ALlK118xx0ypCjY6YMr4UKbNFSwTd
        +OiXSHHUxkQZMsTrYT2ON6oCAQlkdRc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-NbtEaR6AMFaYtskT0OYjsA-1; Mon, 07 Mar 2022 17:39:54 -0500
X-MC-Unique: NbtEaR6AMFaYtskT0OYjsA-1
Received: by mail-ed1-f70.google.com with SMTP id r9-20020a05640251c900b00412d54ea618so9395771edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 14:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJJnjNEDLDCxgTnNZiuLduAW9RdSuGCDd7yDQswPSHQ=;
        b=bOZtHkJfXPbvkc3h2JlF6AEPazBRTikm2dvu0qZbI/cZ9bG78RlHt8zPo32D0OAHyh
         yvfCWZX5zEUuxXc6E2Xa6z4ixc8eeNfX8eDalGLGC49B0ANYysndIjOmVU3RonkFCckg
         cI6aPmEPXYv00Esqc48t6WUjFkXLveJUb5toB9ykgJFg8kwj/UbsjzBCkHnMm5a7ZLP0
         84TtV68g/iA5Uz1kD4vWq3jFo8w0el1iDfn0jHiG3nVXqgRoWirHqPoRUQVj2kd9jIiH
         edZVkjYWxDKFE5Cf0n2aOA/qws2ufLoHpgFH4fI4aCcxc97D/wv0pBXhbLvGwJv5BU4i
         lcyQ==
X-Gm-Message-State: AOAM533Svbuva7CE4LItJ4XdSHiCgsiaNun3+xOlBvvaOIfI7z2tlibA
        uE2Relookbn0eg7c68B3VWX0efcC9Z/vo0VT27CloXffjL4V7lGgsiMf83lIhXmAwc83H6uojAR
        oDYLYPU6RfJIucTnfv/DDVOZO
X-Received: by 2002:a50:f68b:0:b0:415:a36c:5c0b with SMTP id d11-20020a50f68b000000b00415a36c5c0bmr13019185edn.272.1646692791965;
        Mon, 07 Mar 2022 14:39:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHmg2BC0xk8nWy9xaqU2GCk4lH6furT6guufXi8TPI/KI61k1O7Q5pN2MxtI0peMXSX0VM9Q==
X-Received: by 2002:a50:f68b:0:b0:415:a36c:5c0b with SMTP id d11-20020a50f68b000000b00415a36c5c0bmr13019168edn.272.1646692791770;
        Mon, 07 Mar 2022 14:39:51 -0800 (PST)
Received: from redhat.com ([2.55.138.228])
        by smtp.gmail.com with ESMTPSA id gf17-20020a170906e21100b006da960ce78dsm4913346ejb.59.2022.03.07.14.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:39:51 -0800 (PST)
Date:   Mon, 7 Mar 2022 17:39:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220307173807-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiZeB7l49KC2Y5Gz@kroah.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:33:27PM +0100, Greg KH wrote:
> On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > during virtqueue clean-up and we mitigate the reported issues.
> > 
> > Also WARN() as a precautionary measure.  The purpose of this is to
> > capture possible future race conditions which may pop up over time.
> > 
> > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > 
> > Cc: <stable@vger.kernel.org>
> > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/vhost/vhost.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 59edb5a1ffe28..ef7e371e3e649 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> >  	int i;
> >  
> >  	for (i = 0; i < dev->nvqs; ++i) {
> > +		/* No workers should run here by design. However, races have
> > +		 * previously occurred where drivers have been unable to flush
> > +		 * all work properly prior to clean-up.  Without a successful
> > +		 * flush the guest will malfunction, but avoiding host memory
> > +		 * corruption in those cases does seem preferable.
> > +		 */
> > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> 
> So you are trading one syzbot triggered issue for another one in the
> future?  :)
> 
> If this ever can happen, handle it, but don't log it with a WARN_ON() as
> that will trigger the panic-on-warn boxes, as well as syzbot.  Unless
> you want that to happen?
> 
> And what happens if the mutex is locked _RIGHT_ after you checked it?
> You still have a race...
> 
> thanks,
> 
> greg k-h

Well it's a symptom of a kernel bug. I guess people with panic on
warn are not worried about DOS and more worried about integrity
and security ... am I right?

-- 
MST

