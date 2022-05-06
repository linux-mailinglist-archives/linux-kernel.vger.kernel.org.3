Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0351D6B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391384AbiEFLhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391381AbiEFLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:37:32 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A070F61604
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651836813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ucCpzTQkF8XhUkvL7+8cXDWEm9SjV8gZcvK7m79UBU=;
        b=iwQlSqppV8VrifkdFeUlpdDrJO8ITcuW1FkIRqj7JDhKxuvQOCEKysExFcZvv716u950vN
        TZi+f8HSfRE6NEE5SIlwtJRrdgX1QC67FTuO1BS3G8AUksDQg1sypUCOX5+sXaAhVyEz5h
        JJv7ssgzvh0OPTqMj3GA/vVPoZtaZIs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-A4BTPGmvO2G4ezxyM-ut9Q-1; Fri, 06 May 2022 07:33:32 -0400
X-MC-Unique: A4BTPGmvO2G4ezxyM-ut9Q-1
Received: by mail-ed1-f71.google.com with SMTP id b65-20020a509f47000000b00427b34634d3so3844939edf.20
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ucCpzTQkF8XhUkvL7+8cXDWEm9SjV8gZcvK7m79UBU=;
        b=vsq+3Y+l+ilklhhNYZJ6Acyn0nVTIQ1M/NiCrmt+CQaPdaUBmCftqi3AmUaeSEaIYv
         fW1HBeUcFtGPgXYt+6DjXD+z+Gha5DT/6tnhzJwnFe+rpDU3BljLEGlTtDwi+pmsNNEN
         IcN6NcLttpgpDoGk7K0Kzk3IDBzLH+BIcU+C4UcGkhhI1kvoMRFQoqdH1n9QXfL9Hw80
         /hzONCOyiw7l5aWKTkicSYPSQMs+D5GOPRWaI0jdNRI4JlZgJO3k+SNJdnu04ZBSIH8M
         MfeZbIgODIXsuyK3ac3aTEIzicR7VcH0UAXYSd45EGGFy8DEV3bsXkbifIyKgsQT3Iom
         OCjA==
X-Gm-Message-State: AOAM531vdjEENRDdHEQ+gl4jrRVwnt7LpKf8heRRsVFNtmeTx4v+oCod
        L069aGQgQvvq/0SQVdn1VNGPl1WVd+u3EI7AWHqR1zhW27xJjpROTEUURTDlENVVHXOI18wr0Cp
        p8r9EZCMeQd++5haqn3WexyW3
X-Received: by 2002:a17:906:148a:b0:6f3:833d:5a0f with SMTP id x10-20020a170906148a00b006f3833d5a0fmr2560120ejc.49.1651836811510;
        Fri, 06 May 2022 04:33:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWqNhgRcK629dCnuKAST3WbCl+p9Mce05cC+BHLm/aKmxrKARyEIXE+pvxtLSGIpCklwFmrA==
X-Received: by 2002:a17:906:148a:b0:6f3:833d:5a0f with SMTP id x10-20020a170906148a00b006f3833d5a0fmr2560103ejc.49.1651836811295;
        Fri, 06 May 2022 04:33:31 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:107e:a6f7:2ba7:16e9:af89:1a95])
        by smtp.gmail.com with ESMTPSA id hy5-20020a1709068a6500b006f3ef214ddcsm1808167ejc.66.2022.05.06.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 04:33:30 -0700 (PDT)
Date:   Fri, 6 May 2022 07:33:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: RE: [PATCH v5 5/5] virtio-crypto: enable retry for
 virtio-crypto-dev
Message-ID: <20220506073316-mutt-send-email-mst@kernel.org>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
 <20220505092408.53692-6-pizhenwei@bytedance.com>
 <ad61b1ae4bd145eaa18fc28696e9502a@huawei.com>
 <48c9b073-0b03-5769-633b-5b668cea6fa4@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c9b073-0b03-5769-633b-5b668cea6fa4@bytedance.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 05:55:33PM +0800, zhenwei pi wrote:
> On 5/6/22 17:34, Gonglei (Arei) wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> > > Sent: Thursday, May 5, 2022 5:24 PM
> > > To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
> > > Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
> > > linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> > > linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
> > > pizhenwei@bytedance.com; davem@davemloft.net
> > > Subject: [PATCH v5 5/5] virtio-crypto: enable retry for virtio-crypto-dev
> > > 
> > > From: lei he <helei.sig11@bytedance.com>
> > > 
> > > Enable retry for virtio-crypto-dev, so that crypto-engine can process
> > > cipher-requests parallelly.
> > > 
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Gonglei <arei.gonglei@huawei.com>
> > > Signed-off-by: lei he <helei.sig11@bytedance.com>
> > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > ---
> > >   drivers/crypto/virtio/virtio_crypto_core.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> > > b/drivers/crypto/virtio/virtio_crypto_core.c
> > > index 60490ffa3df1..f67e0d4c1b0c 100644
> > > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > > @@ -144,7 +144,8 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
> > >   		spin_lock_init(&vi->data_vq[i].lock);
> > >   		vi->data_vq[i].vq = vqs[i];
> > >   		/* Initialize crypto engine */
> > > -		vi->data_vq[i].engine = crypto_engine_alloc_init(dev, 1);
> > > +		vi->data_vq[i].engine = crypto_engine_alloc_init_and_set(dev, true,
> > > NULL, 1,
> > > +						virtqueue_get_vring_size(vqs[i]));
> > 
> > Here the '1' can be 'true' too.
> > 
> > Sure, you can add
> > 
> > Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> > 
> > Regards,
> > -Gonglei
> > 
> > >   		if (!vi->data_vq[i].engine) {
> > >   			ret = -ENOMEM;
> > >   			goto err_engine;
> > > --
> > > 2.20.1
> > 
> 
> Thanks to Lei!
> 
> Hi, Michael
> I would appreciate it if you could apply this minor change, or I send the v6
> series, which one do you prefer?
> 
> -- 


send v6 with acks and change pls

