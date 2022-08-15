Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B405951E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiHPFWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiHPFVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D01DD2AC6F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660600069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwXJio4p0RALiK5hRjEtrlFD6Yn2dwN8viKDJN8w4cg=;
        b=D6EdbU4GqWThU1qVnLGVmsQQLvium1hS2ERuZeZVD7Orx/lqTZUvSdnTZIcA4ZdKueS2bA
        Jw2k59aJAAkGYpi2TGrQbLRlhjWqTGOavk4txqcV7y1NQtUf0RwJNe00BozfiwWNojNgLj
        5YsoJQ7oMsYcNgtiaj+kdIrAVemBzlk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-342-kZI_hcnxM2u83EJdm_D_ew-1; Mon, 15 Aug 2022 17:47:48 -0400
X-MC-Unique: kZI_hcnxM2u83EJdm_D_ew-1
Received: by mail-wm1-f71.google.com with SMTP id b4-20020a05600c4e0400b003a5a96f1756so9260022wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=pwXJio4p0RALiK5hRjEtrlFD6Yn2dwN8viKDJN8w4cg=;
        b=SnRhzoh/szWqo7EI7Mzi9WqZ3WTGISdEfNzGOWEsA1g0cPfoJONhN3yCF7R91R1+J8
         m2dswRxtj/uLZSHGIF2EQNsykwoqA90ubbBD7mVqjbdC42yBSVWOMiY4Bz6q7YI7lL2t
         FvOMuVR3J5qU9goVlOaEqtH1NoCp0kAHUjXWqU2bg6eDcu8qO1CnfQCIQmjBI5uqOZL3
         6bb5VwjKRANuUuSaiiRm0y5l10z4iOS91+wH6kmdfFDklsSu36Mgg2+Ub00tau5A/zSn
         a6NM8tA6U7GtKFwOxeUmq5HVvOQjDdfze2WYY2gQWeZD0l7DaeRNt3rgQtAqGXthCstq
         1j3g==
X-Gm-Message-State: ACgBeo3WsK5koXjd4BnQpLDUm1zVQybS4GNeeNc0a08p0Un2dtiizNwn
        Y6PcFKShd6dz5/CU60EI4Xv/3Us1sza7UcUxPWKTOzmrOpmxOtZF7oBcmk7aVFFPD3Cexsezwea
        XHiGtIfLdKZIpwjkErNq8YIbl
X-Received: by 2002:a05:600c:20a:b0:3a5:a700:17d with SMTP id 10-20020a05600c020a00b003a5a700017dmr11264425wmi.148.1660600067260;
        Mon, 15 Aug 2022 14:47:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6HEO33wTMDod+4BRmHsyVipe5ttcq3PUtK52S+GrjNTcVgMog3ddScg1I78q3Vl9wVp4kBQw==
X-Received: by 2002:a05:600c:20a:b0:3a5:a700:17d with SMTP id 10-20020a05600c020a00b003a5a700017dmr11264408wmi.148.1660600067077;
        Mon, 15 Aug 2022 14:47:47 -0700 (PDT)
Received: from redhat.com ([2.55.43.215])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4f08495b7sm11295641wmq.34.2022.08.15.14.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:47:46 -0700 (PDT)
Date:   Mon, 15 Aug 2022 17:47:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, c@redhat.com
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815174655-mutt-send-email-mst@kernel.org>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
 <20220815165608-mutt-send-email-mst@kernel.org>
 <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
 <20220815173256-mutt-send-email-mst@kernel.org>
 <20220815214604.x7g342h3oadruxx2@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815214604.x7g342h3oadruxx2@awork3.anarazel.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 02:46:04PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 17:39:08 -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 02:28:39PM -0700, Andres Freund wrote:
> > > On 2022-08-15 17:04:10 -0400, Michael S. Tsirkin wrote:
> > > > So virtio has a queue_size register. When read, it will give you
> > > > originally the maximum queue size. Normally we just read it and
> > > > use it as queue size.
> > > > 
> > > > However, when queue memory allocation fails, and unconditionally with a
> > > > network device with the problematic patch, driver is asking the
> > > > hypervisor to make the ring smaller by writing a smaller value into this
> > > > register.
> > > > 
> > > > I suspect that what happens is hypervisor still uses the original value
> > > > somewhere.
> > > 
> > > It looks more like the host is never told about the changed size for legacy
> > > devices...
> > > 
> > > Indeed, adding a vp_legacy_set_queue_size() & call to it to setup_vq(), makes
> > > 5.19 + restricting queue sizes to 1024 boot again.
> > 
> > Interesting, the register is RO in the legacy interface.
> > And to be frank I can't find where is vp_legacy_set_queue_size
> > even implemented. It's midnight here too ...
> 
> Yea, I meant that added both vp_legacy_set_queue_size() and a call to it. I
> was just quickly experimenting around.

interesting that it's writeable on GCP. It's RO on QEMU.

> 
> > Yes I figured this out too. And I was able to reproduce on qemu now.
> 
> Cool.
> 
> 
> > I'm posting a new patchset reverting all the handing of resize
> > restrictions, I think we should rethink it for the next release.
> 
> Makes sense.
> 
> Greetings,
> 
> Andres Freund

