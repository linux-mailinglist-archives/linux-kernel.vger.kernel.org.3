Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA7535E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350890AbiE0KTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344254AbiE0KTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34D761269A8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653646771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0t2zU9MXz4VT6MECWOHvsoDoBu3fXaqhY69+YDYTXFs=;
        b=iSthZXA6Zjt4uw3ofPtU05aaQc3w4+6gIUKWFHjL4dD4szFfcY2YYAwVrS5IaLlp9tta5A
        ck67FDaIwDVHR+p6u0lw9uPcpBoKuMCqYbzEK5BhffZTtRZZUTtnJnxX7yiL/OJGO5cWpl
        EC5d0mIVZs4v/GElmTTcHMTzm5AMnb8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-5f_1_2BJPguX-mG0K7Qsog-1; Fri, 27 May 2022 06:19:29 -0400
X-MC-Unique: 5f_1_2BJPguX-mG0K7Qsog-1
Received: by mail-ej1-f72.google.com with SMTP id sd17-20020a170906ce3100b006ff12a1b982so2169853ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0t2zU9MXz4VT6MECWOHvsoDoBu3fXaqhY69+YDYTXFs=;
        b=geCGbMwlNavM/IeqawnDAVMQEXsv8DYDnOtbQwEYFRBav9zWrbjhVq+bjUaMYOOU6M
         Nzjvh+tylgoq3EMhsR82T3Vg+RryNur6+3xB203UMOwe+T/GNrOlVY8+SLmjtCHkHpbd
         T3YSoedVt+EXidE6A4lOVk+3rqBWDAfkuUSCj7vz9rioEkQLU44ZMWQ7I/fLSHZLy1rq
         oEPhzlxoR72IOoKtG9C5mykwVP0LRsIge3ny2ru4dpPQ5qAZT5q0j1z8da49MYeQf0h0
         m1BWes6UMo5/t7nm9X5qdCwHGDe+dI2aAZJ4SNEqv668NjInY2bXwpCn0z7ZKH3TRsbc
         rjUA==
X-Gm-Message-State: AOAM532arFMXmxnVHZZDKhQJnUNVBZKwWWVD4O2550X/JOaFwPnVbMNl
        5atoRgMmVlvow4PDFLEA/nY4YyIqSu0WnuemJGOGycysDSHnnecNU/eMCtzQM1CZmzcynVpM0kN
        U5w2prvY4d7fTFbriEEWMqHu1
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id q1-20020aa7cc01000000b0042a402bb983mr44184445edt.257.1653646768543;
        Fri, 27 May 2022 03:19:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2w1aOFqWoL18Qhgq6ACsfKPjRn/tewWbSjC97sWOBqBfI9rnw+ZKnDTyxZqb0tSdLhb6XOg==
X-Received: by 2002:aa7:cc01:0:b0:42a:402b:b983 with SMTP id q1-20020aa7cc01000000b0042a402bb983mr44184423edt.257.1653646768272;
        Fri, 27 May 2022 03:19:28 -0700 (PDT)
Received: from redhat.com ([2.55.130.213])
        by smtp.gmail.com with ESMTPSA id s23-20020a1709064d9700b006fe8b3d8cb6sm1338752eju.62.2022.05.27.03.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:19:27 -0700 (PDT)
Date:   Fri, 27 May 2022 06:19:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kch@nvidia.com, jasowang@redhat.com, linux-block@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        keliu <liuke94@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] virtio-blk: remove deprecated ida_simple_XXX()
Message-ID: <20220527061845-mutt-send-email-mst@kernel.org>
References: <fa54e172-ef9d-fba5-ad37-72a6698c7cb8@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa54e172-ef9d-fba5-ad37-72a6698c7cb8@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 10:04:46AM +0200, Christophe JAILLET wrote:
> (Resend, my email client sent it as HTML. So sorry for the duplicate)
> 
> 
> Hi,
> 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 74c3a48cd1e5..e05748337dd1 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -720,8 +720,8 @@ static int virtblk_probe(struct virtio_device *vdev)
> > 		return -EINVAL;
> > 	}
> >
> >-	err = ida_simple_get(&vd_index_ida, 0, minor_to_index(1 << MINORBITS),
> >-			     GFP_KERNEL);
> >+	err = ida_alloc_max(&vd_index_ida, minor_to_index(1 << MINORBITS),
> >+			    GFP_KERNEL);
> > 	if (err < 0)
> > 		goto out;
> > 	index = err;
> 
> 
> this patch, already applied to -next, is wrong.
> 
> 
> The upper bound of ida_simple_get() is exlcusive, while the one of
> ida_alloc_max() is inclusive.
> 
> So, 'minor_to_index(1 << MINORBITS)' should be 'minor_to_index(1 <<
> MINORBITS) - 1' here.
> 
> 
> (adding keliu in cc: because he is proposing the same kind of patches, so he
> will see how to to these changes that are slighly tricky)
> 
> 
> CJ

I will drop this for now, please resend with either
a corrected version or a comment explaining why it's correct.

Thanks!

-- 
MST

