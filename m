Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80D04E3A36
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiCVILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiCVILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:11:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD471A801
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:10:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bi12so34551079ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXb3smoMBvhttrnsQRq5L6nwxrUqkBCEz6UXeK2LsH8=;
        b=4tHROM5eCxSqEH+0gGrEnQdJzb3byz4cfatE08GCqso2U3NWO33XyHCsHGRAAGtbKb
         t0efUnAewq8+OrK/I02DP8+aliGeDn/7Km2OaIUVZMy2f9DpgJysKEIUAyYjddfPipvN
         puMJrcdYUcuPoFZPWnzDHsxq63L5tYZ+3mHGLKQz83yUofsP+oD1R2hWtJ5uwSGef/rc
         9l4vj24A8/wEqvnAGDttH5GhAmknGrb9cjKm2Zi74KqBSmQUEwDm2b2aNXCPaTirTsAu
         +P+7mZafsecyY22vSVQml7i+bhCjkwkzmDhwnqObhFslS4D1a80RgoZXET2PWNqozcnL
         Of0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXb3smoMBvhttrnsQRq5L6nwxrUqkBCEz6UXeK2LsH8=;
        b=1rc+4uS3cMUYv3iOk2O01XA73Bs0CZsOZsIhVTWofm0AvIsd/1IK55UQAnK9Vu3jfv
         Y9KvrJfKELcxSTpZTvp6t13Ldx8QizR9i+gT4e5k3vcXBz1iTBnp1YqIUel9LPrIs2D1
         OaE4JJ9MRhyv45BEdSZ5OdIPu+5dhibug+V4aJCagcrw75f9idxrNo564mjr15yf2pWQ
         8wMVMZ6khAMlLUS7ljkkprgu322F8pEDYvRHC9l9jHNrPIVQNt07AHwtVsX3fGkjlitE
         H96sHpuisORa4ppF1TgDs4HlkrU0rhKcg4UkSr8tkt0fotp8sHA5VihjUx5lNY7ChxHc
         C9bg==
X-Gm-Message-State: AOAM533yd2gxZmXIGRkW7jMCPHW/eTyMNCMSsr4zKYpBQt2HzDEVPUIB
        gJtUl9fvY6yJAMU+V6WiAh4tbl9H2fl/g0WP77hr
X-Google-Smtp-Source: ABdhPJxMV3tMgyliq/Nq7i+1MdGsQiG9PVmkXa91IJJOjIjnkC5OCFpSR+1s6Ks+jhBd8B3xg8jK6elJTPVqMNbZ+O4=
X-Received: by 2002:a17:907:a422:b0:6e0:238c:4f44 with SMTP id
 sg34-20020a170907a42200b006e0238c4f44mr5927362ejc.257.1647936600722; Tue, 22
 Mar 2022 01:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
 <YdMgCS1RMcb5V2RJ@localhost.localdomain> <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
 <YdSMqKXv0PUkAwfl@localhost.localdomain> <CACycT3tPZOSkCXPz-oYCXRJ_EOBs3dC0+Juv=FYsa6qRS0GVCw@mail.gmail.com>
 <CACycT3tTKBpS_B5vVJ8MZ1iuaF2bf-01=9+tAdxUddziF2DQ-g@mail.gmail.com>
 <CACycT3thVwb466u2JR-oDRHLY5j_uxAx5uXXGmaoCZL5vs__mQ@mail.gmail.com>
 <Yg+5Wytvc2eG8uLD@localhost.localdomain> <CACycT3umMYfwVZRXinEBM=Kh+kQPYH5GBN6eKrt9unZSM8W0qw@mail.gmail.com>
In-Reply-To: <CACycT3umMYfwVZRXinEBM=Kh+kQPYH5GBN6eKrt9unZSM8W0qw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 22 Mar 2022 16:10:01 +0800
Message-ID: <CACycT3t7=uXfu62WhahwaZpA15WbL42qB_dicB9kb2DS5-R9Qw@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

Hi Josef, any other comments for this approach.

On Sat, Feb 19, 2022 at 9:04 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Feb 18, 2022 at 11:21 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 09:17:37PM +0800, Yongji Xie wrote:
> > > Ping again.
> > >
> > > Hi Josef, could you take a look?
> >
> > Sorry Yongji this got lost.  Again in the reconnect case we're still setting up
> > a long running thread, so it's not like it'll happen during a normal reclaim
> > path thing, it'll be acted upon by userspace.  Thanks,
> >
>
> During creating this long running thread, we might trigger memory
> reclaim since workqueue will use GFP_KERNEL allocation for it. Then a
> deadlock can occur if the memory reclaim happens to hit the page cache
> on this reconnecting nbd device.
>
> Thanks,
> Yongji
