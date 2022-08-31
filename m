Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C755A80FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiHaPMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiHaPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A0AD75A2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661958756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKP8dj8WuZemTKuRl66zdjz4lCSZEv7hTLOVxotDaj0=;
        b=jNwP5YyPQrlipAgcux1/zOGZ2+KzphsIWJ1RByarvLXGNPcYHcGCs5Ny0KoJ6yBnRKHJ1T
        yIJixOObedhi4GPlHUXFYFsDAlpfEdyMW6JPXJjgLmXTQPzk5rIJpXs+jgWgNLCjDW4VGr
        u17D5pHiz1H/zlV3WdlWGmovfSsGLf4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-319-hCHeyPH5O_WwrxexS-dUtA-1; Wed, 31 Aug 2022 11:12:35 -0400
X-MC-Unique: hCHeyPH5O_WwrxexS-dUtA-1
Received: by mail-wm1-f71.google.com with SMTP id p19-20020a05600c1d9300b003a5c3141365so11828601wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 08:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JKP8dj8WuZemTKuRl66zdjz4lCSZEv7hTLOVxotDaj0=;
        b=4x2Iu8UJc3rlQZMhTi3KZ4zmUg8qdMjhB2L9SzyPptrn8fq6BhEs34f09kNds68j+N
         jv/Msc3ap49frCrDcFRu3y5O0/noreb6qGeNGbbKGkLPYjBfp4iQtQk/8gALuNpeYkl3
         HtlrVPBFUfMlrMYDvF0AXfckNQuyY8/Vtsktv9UiYy23LPR8kbbAs0MvWVf3v/bM3ca2
         1xuHy4crXJivEfTOxtvlsEjSH1IVzVZo/rXttuxxNAX++RQc1ROnspClCaMwWFfuQwsE
         T/nI7x6TkaAUgyyqK8t0V/H/eIj984FqezEiVG1w9vWKolWqvS1Ch19jVDzwQ2gBUCzW
         uCNQ==
X-Gm-Message-State: ACgBeo3MYLSPPnnX81N6Or87B0PvORqEThpz0iutKpp8puNSwdCSf4y+
        Sqb4QiisPIamIGxMDe1HTmDCKvMGp0/4BEb71840Fpc+cpE9Ec+icjAktDxYJUeHqCFvVd2Y8Dc
        2YGQyXRB8pVN7NkJSYtrucutf
X-Received: by 2002:adf:fac1:0:b0:226:d790:7644 with SMTP id a1-20020adffac1000000b00226d7907644mr9387378wrs.471.1661958753947;
        Wed, 31 Aug 2022 08:12:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5PJFVzXSpBCAXnH3mX+ZSWG4afgD21FAy1UQUdZOBZlILIOyvF5zouIz/cz3kS0Aab8WIhyg==
X-Received: by 2002:adf:fac1:0:b0:226:d790:7644 with SMTP id a1-20020adffac1000000b00226d7907644mr9387364wrs.471.1661958753736;
        Wed, 31 Aug 2022 08:12:33 -0700 (PDT)
Received: from redhat.com ([2.55.191.225])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c42c500b003a54fffa809sm2233442wme.17.2022.08.31.08.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 08:12:32 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:12:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     jasowang@redhat.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, elic@nvidia.com,
        guanjun@linux.alibaba.com, parav@nvidia.com,
        gautam.dawar@xilinx.com, dan.carpenter@oracle.com,
        xieyongji@bytedance.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Message-ID: <20220831111220-mutt-send-email-mst@kernel.org>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
 <YwxvXFiuRqGxRgZH@kroah.com>
 <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 05:01:11PM +0200, Maxime Coquelin wrote:
> On 8/29/22 09:48, Greg KH wrote:
> > On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
> > > If the VDUSE application provides a smaller config space
> > > than the driver expects, the driver may use uninitialized
> > > memory from the stack.
> > > 
> > > This patch prevents it by initializing the buffer passed by
> > > the driver to store the config value.
> > > 
> > > This fix addresses CVE-2022-2308.
> > > 
> > > Cc: xieyongji@bytedance.com
> > > Cc: stable@vger.kernel.org # v5.15+
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > 
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > 
> > Please no blank line above the Acked-by: line here if possible.
> 
> Sure.
> 
> Jason, do you prefer I post a new revision with this single change or
> you will handle it while applying? Either way is fine to me.
> 
> Thanks,
> Maxime

Repost pls, easier.

> > thanks,
> > 
> > greg k-h
> > 

