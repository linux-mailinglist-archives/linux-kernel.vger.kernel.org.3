Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6BC4ECB52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349783AbiC3SIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349730AbiC3SIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 329823D1F1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648663589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uWSt8FFFTI4rhck3dPnwbJuLsSit8PUXxQiArFyosm8=;
        b=eBKx5+f30tdjBYoCS/BQzanPjFpaoXbo+QOB3HwShKPw+ttS9ERiQ3uX60wcsS3DCfp3OF
        1tuQu7MLZGiCmfCUTdGtkpNVxgwDFL9lHk6FnD56mmB4AcL5Vt+h+RWwAMY4XiIKELFClq
        O8jYA7bh8MNIHi9q2S2jscPbNriTtJI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-pMYzyt_6O6a3XfcsnFThnA-1; Wed, 30 Mar 2022 14:06:27 -0400
X-MC-Unique: pMYzyt_6O6a3XfcsnFThnA-1
Received: by mail-qt1-f198.google.com with SMTP id y23-20020ac85257000000b002e06697f2ebso17995167qtn.16
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWSt8FFFTI4rhck3dPnwbJuLsSit8PUXxQiArFyosm8=;
        b=QUUKEni+ffCkyve73yvO+yDRuLgESrBleNJdacoaIDUgD/3FUlve1gF3M8ufYjfYHS
         lhMfAuUYzAIh4Fww50KkBGM4bGgEoTLVaFAWqlr1nRPcqB4zSh7Ro5tHtiGxloZeGm9u
         fmOLLaAD6smoTm/YLFhqDYp35yjjRRf21eGrr0lwQivvwoxxyO1PgOYpJvlGWhg2Mrhz
         2zxR8bXDEKLkfgIdXz3IcHlk6E9d8XuUwgeGPypeacdZ1fF0gIu/rhaQ9HBQ3A+//NyX
         hRroZguH74NFLQgtilfY6US0RmtfKAYN8sgjh3oFcNQdos2mmmYB02E4FvVeQsA4s/Fy
         pXkw==
X-Gm-Message-State: AOAM530oGwuPq3/etp6RC1xaTjqCu+zJX+MT1dABgmmKDT7mIkTVpAqI
        PBinT+KaY1RHriIlKd3ibU0YxffhWXadcnoU/SsmxUiaN2gtqvtHmFa4HXgelVmiZVQsFOJb/W5
        /Q/vH96n6yuZHeEeRubkDj/8=
X-Received: by 2002:ad4:5be3:0:b0:441:7bd1:29bd with SMTP id k3-20020ad45be3000000b004417bd129bdmr733375qvc.14.1648663586921;
        Wed, 30 Mar 2022 11:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkima55vXfIXB4/YhL8vxRAGITI8NXaa0gII7X9gZDBJaWlIZfDnbZH36cgG+Ixq8NEncA6A==
X-Received: by 2002:ad4:5be3:0:b0:441:7bd1:29bd with SMTP id k3-20020ad45be3000000b004417bd129bdmr733356qvc.14.1648663586730;
        Wed, 30 Mar 2022 11:06:26 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u20-20020a05620a455400b0067ec0628661sm12639056qkp.110.2022.03.30.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 11:06:26 -0700 (PDT)
Date:   Wed, 30 Mar 2022 14:06:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: state of drbd in mainline
Message-ID: <YkScIas+/Ev0trcZ@redhat.com>
References: <20220329070618.GA20396@lst.de>
 <CADGDV=UgjZAbmAN-2bO1nyDvA=XCC9Lf2dxWHZ0BwxF12nnztQ@mail.gmail.com>
 <20220329073254.GA20691@lst.de>
 <CADGDV=U5jwe0CZ12174cMahfD_h-GsBswWaA1VOJbHaC1nsrUw@mail.gmail.com>
 <f9d89282-3a67-ad97-149f-52325e23607c@kernel.dk>
 <CADGDV=WN2TFR6dO7ZdiQ2ijPjs+7HSsvk0ZCHsHj6ZG5t-oEdA@mail.gmail.com>
 <3c42b1ed-7c03-64e6-409e-e92247288cac@kernel.dk>
 <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGDV=WcTSSC70yG61dazo-WyoLOzp3r+nOk-Eg2x_Ncx=3nRg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30 2022 at 11:23P -0400,
Philipp Reisner <philipp.reisner@linbit.com> wrote:

> > > Jens, my intention is to keep it in-tree, and at some point update it.
> > > Regarding your questions:
> >
> > That'd be great, but it's been years since there was any significant
> > updates to the in-kernel drbd... I would strongly suggest that the
> > in-kernel be brought closer to what people are mostly running, as it
> > stands it's basically unmaintained.
> 
> The changes we worked on over many Years in the more recent drbd-9.x
> branches are just too fundamental to do them in small chunks, we could
> upstream bit by bit.  We need to get that reviewed in a big series.  If I
> started to dump them on linux-block right away, nobody would look at it
> seriously, since it would be too much.  I intend to get people from red
> hat/suse assigned to do such a review. Then we will do that on linux-block,
> so that everyone who cares sees what happens.

Why do you think Red Hat, SUSE or any other distro vendor's engineers
should be made to review what amounts to be a massive dump of changes
you developed over years?

Presummably you have heard of "upstream first"!?  Why do you think it
doesn't apply to drbd?

It'd be one thing if drbd never went upstream but _it did_.  As is
your development model is completely wrong.

Mike

