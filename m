Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A9E4BA387
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbiBQOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:48:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242060AbiBQOsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:48:39 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D415FCA9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:48:23 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i11so3467009lfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0qkqahd0/p8FvMJz9YcyualPcbc2ZoH0R2SSF/QpRI=;
        b=yP0OgBV5rLu/uNXcRUhS8k1WmSl9KAnmwvv+bRInzq0GnIgKbLqGYRXHXLJfj8LBpv
         z0iJbEgB96kJ5lYHe15d78gQfKJjpPRtYEQROuwKp7AtbvGx0AzBI0HAIj2gzbGI0+1A
         1LO4Hxfh2NErovKRen1xEBYm6rCkeamjQq5VIaavjNCC10IXLZ7bP/K71gsonI3TkFcM
         lOeZbw3AjpZugD7u5a8O75KgLh1VzGPkIqXOTPESInyfODmqMskse+nRRQUVs3SsopFa
         D0pDGk7eEyg551Fy9aMfGiY+AjbJgUjWgiYA/NmPQinE6uvqvgYnSQSsxUjrAG+g2CZ/
         ZJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0qkqahd0/p8FvMJz9YcyualPcbc2ZoH0R2SSF/QpRI=;
        b=vHJLfbr1U+E3sKBCxGNIvi9ngJIY4jIBf0uqrV0fv9T0hoBVf9Z34/KLUbKuHQP289
         Ke5j6xbXVA/lQXzZCir5z2KckLRXFHrLqNyg6gyBJuq1fe9JabIGsHAqsDniC0g97crw
         yiEgutWvjSOCV02aRnnYqVATo5yigFhtsXtIY5PBECHAxGNafrvHH8R5/f5nJTZqLhTN
         gMXTNseOyj8/2w6WzVBV0Sg3FC+knhFZkgGe0ONsR2Ikp4059PziWJKK9aO4fW0aKv11
         qdkRKYYVZWhA3Bg2MD0+PusYwKUdHU1/+m/KDTYrjR7QoCxcNJx7EyfHEdx11xxccPMc
         k4rw==
X-Gm-Message-State: AOAM533cqGGq9amgHS3yvkVW4YFCwx20aWhOZfvZomcMNPYVaDUYIhYI
        xvRQWaQDN8X0VuaAcOInTR1N7YFVHoenb/NFIr0X8Q==
X-Google-Smtp-Source: ABdhPJy28JJUJGeljs6z7H1ghvQOOOdMlLSmN003wNureuUOeYRdwTYw3DraXaoYEWq0tOcWCsdLz3x1txNKD5fRSHw=
X-Received: by 2002:a05:6512:2241:b0:441:ce2b:18ef with SMTP id
 i1-20020a056512224100b00441ce2b18efmr2285745lfu.167.1645109301857; Thu, 17
 Feb 2022 06:48:21 -0800 (PST)
MIME-Version: 1.0
References: <3beef2c6ae4878eb31fdb16988a1fcedc7ee143c.camel@dd-wrt.com> <CAPDyKFo5SLtcVWPuMOvhWFFYGEX8Q3PUvX-U_waX4TVjm=fEoA@mail.gmail.com>
In-Reply-To: <CAPDyKFo5SLtcVWPuMOvhWFFYGEX8Q3PUvX-U_waX4TVjm=fEoA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 15:47:45 +0100
Message-ID: <CAPDyKFrGctjqu1fW09-np0NOO6Rgoi_yTtu6SD56qhBEQ-wqEw@mail.gmail.com>
Subject: Re: Shutdown hang on Cavium thunderX eMMC
To:     Daniel Danzberger <daniel@dd-wrt.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        Kevin Hao <haokexin@gmail.com>,
        Robert Richter <rric@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alcooperx@gmail.com, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 + Jan Glauber,  Kevin Hao, Robert Richter

Looping some of the Cavium developers/maintainers too, let's see if
they have an idea of what goes wrong.

On Thu, 17 Feb 2022 at 15:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 15 Feb 2022 at 10:52, Daniel Danzberger <daniel@dd-wrt.com> wrote:
> >
> > Hi,
> >
> > the below commit causes a shutodown hang on my octeontx platforms
> > (aarch64) with Cavium ThunderX eMMC
> >
> > --
> > commit 66c915d09b942fb3b2b0cb2f56562180901fba17
> > Author: Ulf Hansson <ulf.hansson@linaro.org>
> > Date:   Fri Dec 3 15:15:54 2021 +0100
> >
> >     mmc: core: Disable card detect during shutdown
> > --
> >
> > On shutdown, the __mmc_stop_host() call blocks by waiting for
> > mmc_detect() to complete, but it never does.
> > The second stack trace below shows it's been waiting forever for an
> > mmc_send_status() request to complete.
>
> Looks like the root to the problem is that the mmc_send_status()
> request is hanging the cavium mmc host driver.
>
> Is that instance of the mmc host driver functional at all? I mean, it
> looks like the host driver is hanging already before the system is
> being shutdown, right?
>
> Kind regards
> Uffe
>
> >
> >
> > [  394.251271] INFO: task procd:2715 blocked for more than 153 seconds.
> > [  394.257635]       Not tainted 5.10.96 #0
> > [  394.261552] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  394.269389] task:procd           state:D stack:    0 pid: 2715 ppid:
> > 1 flags:0x00000000
> > [  394.277749] dump_backtrace(regs = 0000000000000000 tsk =
> > 000000003cc20742)
> > [  394.284625] Call trace:
> > [  394.287069]  __switch_to+0x80/0xc0
> > [  394.290467]  __schedule+0x1f8/0x530
> > [  394.293961]  schedule+0x48/0xd0
> > [  394.297099]  schedule_timeout+0x98/0xd0
> > [  394.300931]  __wait_for_common+0xc4/0x1c4
> > [  394.304956]  wait_for_completion+0x20/0x2c
> > [  394.309050]  __flush_work.isra.0+0x184/0x31c
> > [  394.313329]  __cancel_work_timer+0xfc/0x170
> > [  394.317510]  cancel_delayed_work_sync+0x14/0x20
> > [  394.322038]  __mmc_stop_host+0x3c/0x50
> > [  394.325799]  mmc_host_classdev_shutdown+0x14/0x24
> > [  394.330500]  device_shutdown+0x120/0x250
> > [  394.334430]  __do_sys_reboot+0x1ec/0x290
> > [  394.338350]  __arm64_sys_reboot+0x24/0x30
> > [  394.342356]  do_el0_svc+0x74/0x120
> > [  394.345765]  el0_svc+0x14/0x20
> > [  394.348817]  el0_sync_handler+0xa4/0x140
> > [  394.352736]  el0_sync+0x164/0x180
> >
> >
> > [  735.262749] INFO: task kworker/0:0:5 blocked for more than 614
> > seconds.
> > [  735.269363]       Not tainted 5.10.96 #0
> > [  735.273296] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [  735.281121] task:kworker/0:0     state:D stack:    0 pid:    5 ppid:
> > 2 flags:0x00000028
> > [  735.289490] Workqueue: events_freezable mmc_rescan
> > [  735.294288] Call trace:
> > [  735.296732]  __switch_to+0x80/0xc0
> > [  735.300131]  __schedule+0x1f8/0x530
> > [  735.303623]  schedule+0x48/0xd0
> > [  735.306761]  schedule_timeout+0x98/0xd0
> > [  735.310593]  __wait_for_common+0xc4/0x1c4
> > [  735.314606]  wait_for_completion+0x20/0x2c
> > [  735.318699]  mmc_wait_for_req_done+0x2c/0x100
> > [  735.323065]  mmc_wait_for_req+0xb0/0x100
> > [  735.326984]  mmc_wait_for_cmd+0x54/0x7c
> > [  735.330818]  mmc_send_status+0x5c/0x80
> > [  735.334573]  mmc_alive+0x18/0x24
> > [  735.337798]  _mmc_detect_card_removed+0x34/0x150
> > [  735.342412]  mmc_detect+0x28/0x90
> > [  735.345732]  mmc_rescan+0xd8/0x348
> > [  735.349132]  process_one_work+0x1d4/0x374
> > [  735.353147]  worker_thread+0x17c/0x4ec
> > [  735.356892]  kthread+0x124/0x12c
> > [  735.360117]  ret_from_fork+0x10/0x34
> >
> >
> >
> > I only could test this with 5.10.96 for now.
> >
> >
> > --
> > Regards
> >
> > Daniel Danzberger
> > embeDD GmbH, Alter Postplatz 2, CH-6370 Stans
