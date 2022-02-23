Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320E4C09DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiBWDDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiBWDDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26A404DF7B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645585384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnCDqCPu5W0nS2hNz/cxEej5P/bK9uYNkG/dZB6UyI0=;
        b=YffVIX1/6IVVir16NC/ONar2Wa3weKEZkOLNvd8kUKk6Jg66wapGmXfz+DcZgRGiWmKUAm
        QE9JMyDiyjLZdxkN/xiYStJcmlOTABLVFf360BcPZV8GvThG22LENO7hdEYzhtTbsaXMe+
        p05P1Nk05ettfqhc5mDO45haoSqESC8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-5vdnGZjDNs-aFeUcSsvGiA-1; Tue, 22 Feb 2022 22:03:02 -0500
X-MC-Unique: 5vdnGZjDNs-aFeUcSsvGiA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-2d07ae11467so161028077b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnCDqCPu5W0nS2hNz/cxEej5P/bK9uYNkG/dZB6UyI0=;
        b=Q2wHuXXmm+P4+az+7/FG/aF4fkftkg/mdkqtJC4DeI5gZUdy1YfeIZJk0q2OTROpYH
         oT/xb9BmEYT4rgoB1wrHe1hZcG1YiTbzYZYjR4JXkLHej8MfY0lnjXB2Wqyc+eo+69tS
         VWyMw0xyYxNkaorcRVzjMioHNWZizfarRX9NN5lhlBdEQ9lCcJRFFR2g7qqqxHAsdLGR
         yC5tMYnoQ0S3v1yw34WH3h2VF29Q0q1bJAj78qtybsG3iwbN/RViXb9omvMF6MRgjplZ
         H7HQ9pmu/kAuD08ZZ9zQJlU3MjxRcvV+TUyWZld7p2xuU7vVeBIEBGJOuP58AnSG0jN9
         aqTA==
X-Gm-Message-State: AOAM5311/mrAVnsX8RAqMJqzZRZLKOrFgF2ONpJybZ6UP2DkwJueaeP6
        8uyhXLpMAP4adQ8w3pnh5GEwNtgvlGIxFNSTw3RE2BfmOj7AaZ1TDXpz/C4Cro58aHKfyRPmo4b
        3e1emf8Kq3uq5LDjal01iXkATyAgcuk/yhWSeiDY=
X-Received: by 2002:a0d:fa43:0:b0:2d1:8d8f:c269 with SMTP id k64-20020a0dfa43000000b002d18d8fc269mr27001636ywf.339.1645585382379;
        Tue, 22 Feb 2022 19:03:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwj++PjFVV0e3k8Op/BtxxBb6FKBeMdRJEFc7pr6Ga0zPM8zbz70fzZ/wC/g+9TFN6DjPgpZJZvDmn1UAi0+Ls=
X-Received: by 2002:a0d:fa43:0:b0:2d1:8d8f:c269 with SMTP id
 k64-20020a0dfa43000000b002d18d8fc269mr27001622ywf.339.1645585382182; Tue, 22
 Feb 2022 19:03:02 -0800 (PST)
MIME-Version: 1.0
References: <c64d2143-284e-7621-440c-971e3405b4d8@virtuozzo.com>
 <d209a0b1-2514-79a0-257a-22bcb372785a@virtuozzo.com> <1d287c7e-8aff-beea-1bd6-4b2226f9f3db@opensource.wdc.com>
In-Reply-To: <1d287c7e-8aff-beea-1bd6-4b2226f9f3db@opensource.wdc.com>
From:   Mike Snitzer <snitzer@redhat.com>
Date:   Tue, 22 Feb 2022 22:02:51 -0500
Message-ID: <CAH6w=ayrR0yRCumgjtyB+mt_+33S6PHxBQDcwYVcuQ79ECYd7A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] dm: Fix use-after-free in dm_cleanup_zoned_dev()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 5:49 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2/17/22 19:13, Kirill Tkhai wrote:
> >
> > dm_cleanup_zoned_dev() uses queue, so it must be called
> > before blk_cleanup_disk() starts its killing:
> >
> > blk_cleanup_disk->blk_cleanup_queue()->kobject_put()->blk_release_queue()->
> > ->...RCU...->blk_free_queue_rcu()->kmem_cache_free()
> >
> > Otherwise, RCU callback may be executed first,
> > and dm_cleanup_zoned_dev() touches freed memory:
>
> Mike,
>
> Can you queue this please ?

I queued it earlier today, please see:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.18&id=588b7f5df0cb64f281290c7672470c006abe7160

Thanks,
Mike

