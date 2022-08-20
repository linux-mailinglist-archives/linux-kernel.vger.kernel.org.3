Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABB959AD5E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345506AbiHTK5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbiHTK52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:57:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3369AB4CA;
        Sat, 20 Aug 2022 03:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EDF0B8013A;
        Sat, 20 Aug 2022 10:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA53FC433D6;
        Sat, 20 Aug 2022 10:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660993045;
        bh=t9TrnVLg82eOpnDHYS5OXuXu5i5KySThSf4t2UHKIAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJpB4b0+VZQaUhaYR+3cSFfCPCD2bjVONnEz3/ju12D2q/SUNFhSxD8EIMlgHZ781
         KB7KgS2FLMDOfKdPrfSdzEML9ZUaPal/YvxVHaUF83QTY7Ftq4PQrUIiU01/z1sawX
         UU/PqR+rCSoNnU2pycRaNGqG3TgBlHP7L0b8Crj9LUF7i0vB3zshTOS3Nxzm0SLOmf
         LfIDESKn/bx1bTuH2V8bOLYqhjBgw4Lr/nz70k7eF1m+QoKzkhVXu2CM1qkfA92LgH
         E6xXiVE0bQgY+OU/PYaQUobm/MjkRxjw4WELAk5ONMNNu8SMQts0wPRtcMapO3s/RH
         QsEGSKF8lihCw==
Date:   Sat, 20 Aug 2022 12:08:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
Message-ID: <20220820120800.519b5eb5@jic23-huawei>
In-Reply-To: <CAHp75VebQfdHrfYTmF0w9M556ZV8fG5jJ2rAN5a3mrB1mbvOQw@mail.gmail.com>
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
        <CAHp75VebQfdHrfYTmF0w9M556ZV8fG5jJ2rAN5a3mrB1mbvOQw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 11:03:55 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Aug 16, 2022 at 1:30 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > If an IIO driver uses callbacks from another IIO driver and calls
> > iio_channel_start_all_cb() from one of its buffer setup ops, then
> > lockdep complains due to the lock nesting, as in the below example with
> > lmp91000.  Since the locks are being taken on different IIO devices,
> > there is no actual deadlock, so add lock nesting annotation to silence
> > the spurious warning.
> >
> >  ============================================
> >  WARNING: possible recursive locking detected
> >  6.0.0-rc1+ #10 Not tainted
> >  --------------------------------------------
> >  python3/23 is trying to acquire lock:
> >  0000000064c944c0 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers+0x62/0x180
> >
> >  but task is already holding lock:
> >  00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
> >
> >  other info that might help us debug this:
> >   Possible unsafe locking scenario:
> >
> >         CPU0
> >         ----
> >    lock(&indio_dev->mlock);
> >    lock(&indio_dev->mlock);
> >
> >   *** DEADLOCK ***
> >
> >   May be due to missing lock nesting notation
> >
> >  5 locks held by python3/23:
> >   #0: 00000000636b5420 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x67/0x100
> >   #1: 0000000064c19280 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x13a/0x270
> >   #2: 0000000064c3d9e0 (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x149/0x270
> >   #3: 00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
> >   #4: 0000000064c945c8 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers+0x4f/0x180
> >
> >  stack backtrace:
> >  CPU: 0 PID: 23 Comm: python3 Not tainted 6.0.0-rc1+ #10
> >  Call Trace:
> >   dump_stack+0x1a/0x1c
> >   __lock_acquire.cold+0x407/0x42d
> >   lock_acquire+0x1ed/0x310
> >   __mutex_lock+0x72/0xde0
> >   mutex_lock_nested+0x1d/0x20
> >   iio_update_buffers+0x62/0x180
> >   iio_channel_start_all_cb+0x1c/0x20 [industrialio_buffer_cb]
> >   lmp91000_buffer_postenable+0x1b/0x20 [lmp91000]
> >   __iio_update_buffers+0x50b/0xd80
> >   enable_store+0x81/0x100
> >   dev_attr_store+0xf/0x20
> >   sysfs_kf_write+0x4c/0x70
> >   kernfs_fop_write_iter+0x179/0x270
> >   new_sync_write+0x99/0x120
> >   vfs_write+0x2c1/0x470
> >   ksys_write+0x67/0x100
> >   sys_write+0x10/0x20  
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-mesages
> 
> On top of that, Fixes tag?
It's going to be tricky to identify - the interface predates usecases that were IIO
drivers by a long way.  I guess introduction of first IIO driver that used
a callback buffer? No idea which one that was :(

> 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>  
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

