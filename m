Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA874AF50A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiBIPUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiBIPUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F1EC0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644420024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWJxSwYp7jtZ92shaLhTfEcqyJ4FcqxLKxSHScXMFmA=;
        b=PyuTenbJ41dM5debF7w6Co+TKiLJfVBr8cyhYPUt4fu3dF08QvMM59PBa3YU3t17p2HsxK
        vFbAgD2o6GVPyf86BefZ69if5ZvtmMZtWxa+4YzYM7zZJ2bIKSBLAgApQUAnrwC0eJKzGU
        BY9JrygxUlbsn/uIpnzLeMZNAbu1B18=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-zb1mVJcgP2uMAOLwj5qykg-1; Wed, 09 Feb 2022 10:20:22 -0500
X-MC-Unique: zb1mVJcgP2uMAOLwj5qykg-1
Received: by mail-wm1-f72.google.com with SMTP id 125-20020a1c0283000000b0037bf720e6a8so448511wmc.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWJxSwYp7jtZ92shaLhTfEcqyJ4FcqxLKxSHScXMFmA=;
        b=4P4BH9eRJtFeYXCSpn9AuwgRh3gAykRAmn32BUECZHZnyyAav0JR6JjEqh0zG44JNs
         BDImuSVIO2y6c27vFIrBOhMCufUw0zZ1xIki1shMgcSliuoh3UJM9qoXs/zPCTNOaziL
         nBuj9q4eDJEnl0Kc7HKFh3LqBqDDuKypDnewkd5slHeTkM/OOhKm17EdQ4/5v1zzYS1a
         0d7YhqLwHdZjWqPIvBELxjyNj0gdyDWI9UkhBaHhbxkyciFjCFyYdWKSmDvvyqgaBHLz
         XANqHjkVmWlmvxvWA+Oiy+ol2nv253raapiC1FM1Rw2mrpZjuL5WLyOm/6UgaY4Xo6nJ
         gMDw==
X-Gm-Message-State: AOAM533XsEBugy/ZwfBMVlwUb/SH1zlDpk9PJiNbJoGL4+Ti6pi6Af8m
        0B98Q/irGts0Y+0YbnPtaRpn1otTkQi0T6gM2ADuqEj4CZMP5tjx1qmZ0wR9ggZ/7oFI8IvODIq
        xoTzjRqnfojNQSh/Lm1D7veF+LJSeRDRI8g6virIQ
X-Received: by 2002:a1c:2942:: with SMTP id p63mr2494643wmp.75.1644420021706;
        Wed, 09 Feb 2022 07:20:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBIOqCE7cDbpGvT5TmCSizl7rrPw18L3EY0Uy8onixaMONTzYS0XvUHUkxcZEdMAG886y96+4xK4BB/NuuR5w=
X-Received: by 2002:a1c:2942:: with SMTP id p63mr2494623wmp.75.1644420021540;
 Wed, 09 Feb 2022 07:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20220209085243.3136536-1-lee.jones@linaro.org> <20220209150904.GA22025@lst.de>
In-Reply-To: <20220209150904.GA22025@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 9 Feb 2022 16:20:10 +0100
Message-ID: <CAHc6FU5e4GaQTfh6Z2_2vhcgxY+dbwUBOgazrXB3XW4=DRpLHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "iomap: fall back to buffered writes for
 invalidation failures"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>,
        syzbot+0ed9f769264276638893@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 4:09 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Feb 09, 2022 at 08:52:43AM +0000, Lee Jones wrote:
> > This reverts commit 60263d5889e6dc5987dc51b801be4955ff2e4aa7.
> >
> > Reverting since this commit opens a potential avenue for abuse.
> >
> > The C-reproducer and more information can be found at the link below.

This reproducer seems to be working fine on gfs2, but the locking in
gfs2 differs hugely from that of other filesystems.

> > With this patch applied, I can no longer get the repro to trigger.
>
> Well, maybe you should actually debug and try to understand what is
> going on before blindly reverting random commits.

Andreas

