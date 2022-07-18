Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B18578489
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiGRN5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiGRN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:57:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3096E27FCD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:57:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id os14so21409625ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Q3uEtxXQH+8HtIo3iz32RrKcwyWRkxKSodo4gn5GDw=;
        b=Av8ODcnkmXm4r101+J5vII1aGyhOURJvXyyESQGrOE3uQ3ClZ/GZLd3In42FgfADLu
         r/IBatqVMR7kL2Z09tWfnrVGueOJRs56mC5MgGUXjq4HvIhSdFfKkThql0hYO7c4MZLb
         5hQAaoqW+iWISgMMTLHeh3Ca/2Gy06lQ9QjoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Q3uEtxXQH+8HtIo3iz32RrKcwyWRkxKSodo4gn5GDw=;
        b=pfDwN6Ko/BrSh0NC+DmoRusCTYZ/Aqp/aJa+03ZOURWN7HmemFmfZ2I9pRF33wjiU3
         pkxtYCHGkWpJVnq+UeWbNJZclHS3m6Qg6s9JANXKb2aHC3vbEumjGKVO+ScDMFlOaBPY
         UJjK3+mUlLDi6Vu6GZ+nPPJD/3PZSXoa/LOiogFoN01u+GDOklco2dYEyUb1D1FBUBUw
         vxkKczA5lVJSbGVbm4FSqQTmrS4faNI+XJHRC46hD2c2UhqpNM4HMJ3XEyMdBW2rGsq9
         gaswBwRsgY7okoppDOhwC2h4yJ33zMP4BwXf5VCwuLhEun85oFtxyeGHeP+18EP2oNX6
         j0IA==
X-Gm-Message-State: AJIora+hcq2oxtXkxZlgSaNm6bHLbylHyg8y5OuhRUMuqFIg9QLR9oaM
        9cSi0UmHCZM7GPiBpq5RE5WydVWKz4cKUH1vtIsdf6tcqR013Q==
X-Google-Smtp-Source: AGRyM1vs94xT5B5/wJUC8zscwbb9Bwm1tb4laNz7t+iuGAhiIIrztL5x2TPsz8NzEhW+my6SFW++4DHP/PxoCjfN0lc=
X-Received: by 2002:a17:907:75f1:b0:72b:9e40:c1a9 with SMTP id
 jz17-20020a17090775f100b0072b9e40c1a9mr23951238ejc.523.1658152648785; Mon, 18
 Jul 2022 06:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <490be4e0b984e146c93586507442de3dad8694bb.camel@mediatek.com> <20220705085308.32518-1-ed.tsai@mediatek.com>
In-Reply-To: <20220705085308.32518-1-ed.tsai@mediatek.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 15:57:17 +0200
Message-ID: <CAJfpegvez_DodKK+CJc1a7EHLDB+4wCSB2ay5NZWUCyoq1_ANw@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: add fuse_d_iput to postponed the iput
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        chenguanyou <chenguanyou9338@gmail.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WW9uZy14dWFuIFdhbmcgKOeOi+ipoOiQsSk=?= 
        <Yong-xuan.Wang@mediatek.com>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 at 10:53, Ed Tsai <ed.tsai@mediatek.com> wrote:
>
> When all the references of an inode are dropped, and write of its dirty
> pages is serving in Daemon, reclaim may deadlock on a regular allocation
> in Daemon.
>
> Add fuse_dentry_iput and some FI_* flags to postponed the iput for the
> inodes be using in fuse_write_inode.

I don't understand.

The inode must have a positive refcount during fuse_write_inode(), so
how would delaying an iput() change anything?

Thanks,
Miklos
