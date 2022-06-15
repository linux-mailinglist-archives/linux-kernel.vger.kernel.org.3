Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464E54C94C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbiFOM6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbiFOM6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A01D1BEB9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655297881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSDv3pB77XuzeUNZezPJm4SyZkEnyUHPf0B4cMPJ4cY=;
        b=MOR1nMTiKFcBNQsmD+SdiunXIzLy756HuoD08CUoAiVo0I+k1jt6O/m6+hKlh27/Jz1brs
        xZAKkmhc9FC9+ZSITqkrHNPMOTMR3HVpWxwUzoh0sTJnTl/UMayEhsfhY6LQMWY9slirEy
        lLrvjqNeLyMwPyGGXNp/G9V0TxAsauo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-K5Qw2Al3Nzu4Wzl17xx88w-1; Wed, 15 Jun 2022 08:57:59 -0400
X-MC-Unique: K5Qw2Al3Nzu4Wzl17xx88w-1
Received: by mail-qv1-f69.google.com with SMTP id x17-20020a0cfe11000000b004645917e45cso8140562qvr.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSDv3pB77XuzeUNZezPJm4SyZkEnyUHPf0B4cMPJ4cY=;
        b=GpD1d28jR3qoaN70xuvy4u007Xni6lhSyYHW/9ebckgVKVdBWlGhTu4L6ZT/jv1l8e
         pZ7C8bdGmTqf0zTyRscSqMOmkxCChlm7Cvd6tshO98Pmo9WYCceDa7rGGcTsSU/RgSWq
         ZOpVk59JTRbgoBPavx/nk2mWJE+C0AxbQ+kl40ICZh8L1zvpKxIrR5rthnhzlmaEztaF
         NuYFsxxdo5YgR8T9K0N7vKw/a9W9plYFkHdcajj1SxShkLU4aL933qHcxBCM36Mea0ni
         EUtZBOTW87QGgY46aIZU5dvFjjW3JUSaoxLT6QfEOqN/utdJxDKPV8+0qrK1O/pEAklN
         tvHw==
X-Gm-Message-State: AJIora/jT4DEUGVhUTjNVayM/AJqWD8TtpDi9FlZCmwKtQHAjJnGrheV
        ji9Met0CBMkcEy4MAMblVxcqCNUa9YuMzAHcXPAPd0hi12YDn8N8k/1nnPjTdWlZ/uAuSnLseaP
        BswQBGPXe+Tq/DGnXKaWPOexN
X-Received: by 2002:ac8:5805:0:b0:306:7772:286f with SMTP id g5-20020ac85805000000b003067772286fmr99496qtg.402.1655297878610;
        Wed, 15 Jun 2022 05:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCeCN28ZKU6d+OG8D7NjHn3G2vBu6R1QHB/HUCDHsoF3WNAM7jk+5+GNqy/PBi6xXTshARZQ==
X-Received: by 2002:ac8:5805:0:b0:306:7772:286f with SMTP id g5-20020ac85805000000b003067772286fmr99485qtg.402.1655297878383;
        Wed, 15 Jun 2022 05:57:58 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b006a77e6df09asm10746678qko.24.2022.06.15.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:57:58 -0700 (PDT)
Date:   Wed, 15 Jun 2022 08:57:56 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <YqnXVMtBkS2nbx70@bfoster>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
 <Yqm+jmkDA+um2+hd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqm+jmkDA+um2+hd@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 04:12:14AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 02:09:47PM -0400, Brian Foster wrote:
> > The IDR tree has hardcoded tag propagation logic to handle the
> > internal IDR_FREE tag and ignore all others. Fix up the hardcoded
> > logic to support additional tags.
> > 
> > This is specifically to support a new internal IDR_TGID radix tree
> > tag used to improve search efficiency of pids with associated
> > PIDTYPE_TGID tasks within a pid namespace.
> 
> Wouldn't it make sense to switch over to an xarray here rather
> then adding new features to the radix tree?
> 

The xarray question crossed my mind when I first waded into this code
and realized the idr tree seems to be some sort of offshoot or custom
mode of the core radix tree. I eventually realized that the problem wrt
to normal radix tree tags in the idr variant was that the tag
propagation logic in the idr variant simply didn't care to handle
traditional tags, presumably because they were unused in that mode. So
this patch doesn't really add a feature to the radix-tree, it just fixes
up some of the grotty idr tree logic to handle both forms of tags.

I assume it makes sense for this to move towards xarray in general, but
I don't have enough context on either side to know what the sticking
points are. In particular, does xarray support something analogous to
IDR_FREE or otherwise solve whatever problem idr currently depends on it
for (i.e. efficient id allocation)? I think Willy has done work in this
area so I'm hoping he can chime in on some of that if he's put any
thought into the idr thing specifically..

WRT to this series, I really don't think it makes much sense to put a
broad rework of the idr code in front of what is otherwise an
incremental performance improvement based on using a mechanism that
radix-tree pretty much already supports (i.e. tags). Is there some
fundamental problem you see with this patch that apparently depends on
xarray for some reason, or are you just calling it out as apparent
technical debt in this area of code? If the latter, then I think it
makes more sense to consider that as a followup effort.

Brian

