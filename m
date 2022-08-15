Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFDB594B08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352556AbiHPAJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355562AbiHPAAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACB794AD4F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660594920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rm2wKHLo3eIkvMoJ4hWHfr10tTEqNp9fs5ikAVIvZnA=;
        b=iTFOV2zgxYI5uGizZwS3h2ZaLFKvaGkSRGBThc0ESfPTxByQIcuykx5QuN5iahqyZlJgWz
        NqGulhz08WX7CAJHHh6Hwk+dL9s6qUeD/NwB86UN/ELoogLYkRAmHAT7ELZKnTrwEB2LlT
        t6h+OHj/3FYD3ZZI2HvqUtjY1Il8Tas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-KEDLugHUNj6GKTrSh8J2ww-1; Mon, 15 Aug 2022 16:21:59 -0400
X-MC-Unique: KEDLugHUNj6GKTrSh8J2ww-1
Received: by mail-wm1-f72.google.com with SMTP id f18-20020a05600c4e9200b003a5f81299caso845831wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Rm2wKHLo3eIkvMoJ4hWHfr10tTEqNp9fs5ikAVIvZnA=;
        b=kMe6DgAfWeOmjgnzy5vlToO26ynW9pjy1GkdZz6In+YK5w+iFW5AoqWnP5/A2F9WqH
         KphEZ2+zc08al5oFICfVH9vYXBqUrcjW0jlabnkVKLLRES2i+ilK8/8nQ0fArzYvj8cn
         qAz1fdQ+8oMxrfIZlOswCuyWGxdpL3YNTIAQ4bH4++KSI+y3fk+hJApC1sCwq0Bp8aXp
         j2aI+j6AxnPElgtAwnd5LkqVTbo839BO2ysfCG9WChnEAdyiLoeo4eShwC/5q6ZHFbLV
         +r283qxyACR+M/PsZymnKgcdtaMpA6xL4EsATpyUyLxsh4ExP7xpCuip61wPb0YkGxPM
         3xyw==
X-Gm-Message-State: ACgBeo39gX2U7FMxcs4w7CMGudL6Q9qtZj2x4AzxiTE68eGI0n49XPOK
        3au5RKn6oyKxiIllShg5VgCCpqav9o0iV4tVkYNNQYErAGMjGGQxnWpzcGKBolJG7GVRLRfW713
        NulSjuk/c/bE5p0pv5JPXsRhz
X-Received: by 2002:a7b:cb0e:0:b0:3a5:afff:d520 with SMTP id u14-20020a7bcb0e000000b003a5afffd520mr16521531wmj.3.1660594918310;
        Mon, 15 Aug 2022 13:21:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6afLEHm3zW7k4Gxy/c/Vt6rsCXaxSClRUlE4+wMWQqwu2WwHKMucdlqtxtUbqpr2PcXXxaHg==
X-Received: by 2002:a7b:cb0e:0:b0:3a5:afff:d520 with SMTP id u14-20020a7bcb0e000000b003a5afffd520mr16521507wmj.3.1660594918038;
        Mon, 15 Aug 2022 13:21:58 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id e14-20020a05600c4e4e00b003a31ca9dfb6sm13620139wmq.32.2022.08.15.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 13:21:56 -0700 (PDT)
Date:   Mon, 15 Aug 2022 16:21:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        c@redhat.com
Subject: Re: upstream kernel crashes
Message-ID: <20220815161423-mutt-send-email-mst@kernel.org>
References: <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
 <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:46:17AM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 12:50:52 -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 09:45:03AM -0700, Andres Freund wrote:
> > > Hi,
> > > 
> > > On 2022-08-15 11:40:59 -0400, Michael S. Tsirkin wrote:
> > > > OK so this gives us a quick revert as a solution for now.
> > > > Next, I would appreciate it if you just try this simple hack.
> > > > If it crashes we either have a long standing problem in virtio
> > > > code or more likely a gcp bug where it can't handle smaller
> > > > rings than what device requestes.
> > > > Thanks!
> > > 
> > > I applied the below and the problem persists.
> > > 
> > > [...]
> >
> > Okay!
> 
> Just checking - I applied and tested this atop 6.0-rc1, correct? Or did you
> want me to test it with the 762faee5a267 reverted? I guess what you're trying
> to test if a smaller queue than what's requested you'd want to do so without
> the problematic patch applied...
> 
> 
> > And just to be 100% sure, can you try the following on top of 5.19:
> 
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 623906b4996c..6f4e54a618bc 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -208,6 +208,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >  		return ERR_PTR(-EINVAL);
> >  	}
> >  
> > +	if (num > 1024)
> > +		num = 1024;
> > +
> >  	info->msix_vector = msix_vec;
> >  
> >  	/* create the vring */
> > 
> > -- 
> 
> Either way, I did this, and there are no issues that I could observe. No
> oopses, no broken networking. But:
> 
> To make sure it does something I added a debugging printk - which doesn't show
> up. I assume this is at a point at least earlyprintk should work (which I see
> getting enabled via serial)?
> 
> Greetings,
> 
> Andres Freund


Sorry if I was unclear.  I wanted to know whether the change somehow
exposes a driver bug or a GCP bug. So what I wanted to do is to test
this patch on top of *5.19*, not on top of the revert.
The idea is if we reduce the size and it starts crashing then
we know it's GCP fault, if not then GCP can handle smaller sizes
and it's one of the driver changes.

It will apply on top of the revert but won't do much.

Yes I think printk should work here.

-- 
MST

