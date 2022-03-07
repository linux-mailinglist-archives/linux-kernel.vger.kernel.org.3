Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2974CF48C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiCGJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCGJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:18:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6DAD12AD2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646644668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vY49Vru0HbWgozAtnq2rdM5U4yg34ErGp0VSnFqyc8o=;
        b=NFJgl3uKSpKlozD0G9O9qXwUO9xzy3BnCXDP5qx4B5Ex7KirB/qM2VXM+wRQJkBiOoaWvN
        fx9AIUDRE15GqFfVHwRfqXT/NxOuRiBlR40S7CBhdBgPfxIErqp15yuhdPLGWXJAfr+3/T
        GF/0O0sbfqsSZ+yqPpbA/x4UdDQXkZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-Pb65lv85POye5uFYDy4MvA-1; Mon, 07 Mar 2022 04:17:45 -0500
X-MC-Unique: Pb65lv85POye5uFYDy4MvA-1
Received: by mail-wm1-f70.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so7620656wmz.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vY49Vru0HbWgozAtnq2rdM5U4yg34ErGp0VSnFqyc8o=;
        b=Q56lhwV7vR5+hAw4IqfYVuWVxRQtAehC+YBgIn1KswE+oPRh9Ebb1o87v53X/EAy27
         EwHZb0sfzcugAAIBUB3EVS0nOsDb4Hs5MVxe5xw54nuVPv4EkyhGtXGHOVUbR7A8DHzR
         QhJuDBM4zbVULe7ocRPY3Usc6xuET1U6yfHit2ilN9Qc8sIhpCgxYugRNWPQ8EpexgoZ
         /JOAFx/jHzOIIOZgYlKp9lU2RpOlgKx6a46Dfjl55UxyqUxoLFA5k5iMzaitk7QW87fq
         CS8KpDWhP6PNt1v695YZEMoNsR0Uk38szqRbpooFomVZ4HvmI5PdhfuSej78qa+UlMNg
         ARDQ==
X-Gm-Message-State: AOAM530RvgZUe//RMz5SyiKi1xfzmKcXG6ET1gWmj08kQxx0sNU+6krO
        HnXPKV7nDlZqVFAKtR3amrpVrbQl2UkYWH6mDFIBCe8OPylGjjSzXLE3JZPG0tETiStYHDHt3k8
        PURuvcyKvEwuV8uCejGWezyr5
X-Received: by 2002:adf:ed0c:0:b0:1f0:63a5:36aa with SMTP id a12-20020adfed0c000000b001f063a536aamr7530782wro.588.1646644663583;
        Mon, 07 Mar 2022 01:17:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjkWlShZGdROoRzC2vb1bnJXyVtMmyUyisUPAVsDRB9TbIj7DBhNlXmZcTW0F6SbGUsfnUKg==
X-Received: by 2002:adf:ed0c:0:b0:1f0:63a5:36aa with SMTP id a12-20020adfed0c000000b001f063a536aamr7530774wro.588.1646644663374;
        Mon, 07 Mar 2022 01:17:43 -0800 (PST)
Received: from redhat.com ([2.55.138.228])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm11268952wrg.62.2022.03.07.01.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:17:42 -0800 (PST)
Date:   Mon, 7 Mar 2022 04:17:39 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vhost tree
Message-ID: <20220307040734-mutt-send-email-mst@kernel.org>
References: <20220307154011.6d456f28@canb.auug.org.au>
 <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646635600.9436276-1-xuanzhuo@linux.alibaba.com>
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

On Mon, Mar 07, 2022 at 02:46:40PM +0800, Xuan Zhuo wrote:
> On Mon, 7 Mar 2022 15:40:11 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > After merging the vhost tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >
> > drivers/net/virtio_net.c: In function 'virtnet_rx_vq_reset':
> > drivers/net/virtio_net.c:1823:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
> >  1823 |                    "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> >       |                                                             ~~^
> >       |                                                               |
> >       |                                                               long int
> >       |                                                             %d
> >  1824 |                    rq - vi->rq, err);
> >       |                    ~~~~~~~~~~~
> >       |                       |
> >       |                       int
> > drivers/net/virtio_net.c: In function 'virtnet_tx_vq_reset':
> > drivers/net/virtio_net.c:1873:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
> >  1873 |                    "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> >       |                                                             ~~^
> >       |                                                               |
> >       |                                                               long int
> >       |                                                             %d
> >  1874 |                    sq - vi->sq, err);
> >       |                    ~~~~~~~~~~~
> >       |                       |
> >       |                       int
> >
> > Introduced by commit
> >
> >   920ee0c540a2 ("virtio_net: support rx/tx queue reset")
> >
> 
> 
> Can you help me test this patch? I don't have an arm environment around me.
> 
> Thanks


You should at least use
https://mirrors.edge.kernel.org/pub/tools/crosstool/
to test-build + test on x86.

> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1fa2d632a994..4d629d1ea894 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info *vi,
> 
>  err:
>         netdev_err(vi->dev,
> -                  "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> +                  "reset rx reset vq fail: rx queue index: %td err: %d\n",
>                    rq - vi->rq, err);
>         virtnet_napi_enable(rq->vq, &rq->napi);
>         return err;
> @@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info *vi,
> 
>  err:
>         netdev_err(vi->dev,
> -                  "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> +                  "reset tx reset vq fail: tx queue index: %td err: %d\n",
>                    sq - vi->sq, err);
>         virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
>         return err;
> 
> > --
> > Cheers,
> > Stephen Rothwell
> >

