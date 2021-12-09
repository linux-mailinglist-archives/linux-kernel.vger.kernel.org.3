Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3846E020
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbhLIBS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhLIBSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:18:54 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED0C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:15:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v19so2737276plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fTuKJ3P+xVUZHZiPNMT79c9PB4INWnm2mSlE2zu6oE=;
        b=gLCSr/zv40+cUkjcBh1KVNmlTpLXoJrovealTSPTGHLdnjl1WwQgm8A9fvK3hHzEuD
         6BOE/bjIsiGww4cvfQd8l5fSjj7CnmAKM8V+QX4hi1Ds5mtkY4gGzbWsfdaLmY83VWVU
         S62SWXIAPuqP53RpzJIASjJxIpMs/AdsSDnUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fTuKJ3P+xVUZHZiPNMT79c9PB4INWnm2mSlE2zu6oE=;
        b=SCYvwHtkfMJsUype+NxOY/qcoPWdlGzcz8AQOj71vPnHk4hXPVfzU0TdCOKbF+TuRa
         zNz3U87cBOQv0SDVUh+pYiBPgspiaZLz/2GISpKKb6Rq97ROT80ad8rEHO1fr4BZZqxR
         QsY6bifMGJ8ee0KYBtvG23973lVQun/nws2lORy+w0f0A7dchj7Jxri4zYTOvnD/uDLi
         ry/hi1Ht6QBPHuvmw59umnbzzKtjIQJljFSpJtqnh2BlekRurk0vQz6kFQdHPGOTC5gU
         /AlGP2SOHwmthSn80ZKJPUXbv1ntquuXML7y7xjBve3MAUUciwrr9C4vkDoOZPX5DrFZ
         HkuQ==
X-Gm-Message-State: AOAM533n3CnLFz5loh89ow80Q5pcnEJy5Cnn4JQPPIpu9DMnhxWxg71A
        /U5ABT4vlrOMBUOxKIbk13vj7w==
X-Google-Smtp-Source: ABdhPJwpUfOvXT9F9OtHYkdrzBYDc8nLhyE8eWzdk3xbao6BqMhEtC5btU4zpCYV0tr7K0BKXBc8mg==
X-Received: by 2002:a17:90a:c506:: with SMTP id k6mr11785498pjt.74.1639012521491;
        Wed, 08 Dec 2021 17:15:21 -0800 (PST)
Received: from localhost ([2620:15c:202:201:e328:454f:88d0:4ad1])
        by smtp.gmail.com with UTF8SMTPSA id l186sm3415570pga.24.2021.12.08.17.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 17:15:21 -0800 (PST)
Date:   Wed, 8 Dec 2021 17:15:19 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v4] rpmsg: char: Fix race between the release of
 rpmsg_ctrldev and cdev
Message-ID: <YbFYp71DhBNW7trt@google.com>
References: <20211208125220.v4.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
 <CAE-0n53JAzTAPsWS6c5wmYoWgAwxQgzTqEP65JnFT6AeMu0rbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-0n53JAzTAPsWS6c5wmYoWgAwxQgzTqEP65JnFT6AeMu0rbQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:05:29PM -0800, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2021-12-08 12:52:28)
> > From: Sujit Kautkar <sujitka@chromium.org>
> >
> > From: Sujit Kautkar <sujitka@chromium.org>
> 
> This is here twice. Remove one?

Ah, forgot that tools add that automatically and added a manual entry.

Ohad/Bjorn/Mathieu: assuming there are no other comments, do you want me
to resend this patch or can you remove the extra tag when applying it?

> > struct rpmsg_ctrldev contains a struct cdev. The current code frees
> > the rpmsg_ctrldev struct in rpmsg_ctrldev_release_device(), but the
> > cdev is a managed object, therefore its release is not predictable
> > and the rpmsg_ctrldev could be freed before the cdev is entirely
> > released, as in the backtrace below.
> >
> > [   93.625603] ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x7c
> > [   93.636115] WARNING: CPU: 0 PID: 12 at lib/debugobjects.c:488 debug_print_object+0x13c/0x1b0
> > [   93.644799] Modules linked in: veth xt_cgroup xt_MASQUERADE rfcomm algif_hash algif_skcipher af_alg uinput ip6table_nat fuse uvcvideo videobuf2_vmalloc venus_enc venus_dec videobuf2_dma_contig hci_uart btandroid btqca snd_soc_rt5682_i2c bluetooth qcom_spmi_temp_alarm snd_soc_rt5682v
> > [   93.715175] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G    B             5.4.163-lockdep #26
> > [   93.723855] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> > [   93.730055] Workqueue: events kobject_delayed_cleanup
> > [   93.735271] pstate: 60c00009 (nZCv daif +PAN +UAO)
> > [   93.740216] pc : debug_print_object+0x13c/0x1b0
> > [   93.744890] lr : debug_print_object+0x13c/0x1b0
> > [   93.749555] sp : ffffffacf5bc7940
> > [   93.752978] x29: ffffffacf5bc7940 x28: dfffffd000000000
> > [   93.758448] x27: ffffffacdb11a800 x26: dfffffd000000000
> > [   93.763916] x25: ffffffd0734f856c x24: dfffffd000000000
> > [   93.769389] x23: 0000000000000000 x22: ffffffd0733c35b0
> > [   93.774860] x21: ffffffd0751994a0 x20: ffffffd075ec27c0
> > [   93.780338] x19: ffffffd075199100 x18: 00000000000276e0
> > [   93.785814] x17: 0000000000000000 x16: dfffffd000000000
> > [   93.791291] x15: ffffffffffffffff x14: 6e6968207473696c
> > [   93.796768] x13: 0000000000000000 x12: ffffffd075e2b000
> > [   93.802244] x11: 0000000000000001 x10: 0000000000000000
> > [   93.807723] x9 : d13400dff1921900 x8 : d13400dff1921900
> > [   93.813200] x7 : 0000000000000000 x6 : 0000000000000000
> > [   93.818676] x5 : 0000000000000080 x4 : 0000000000000000
> > [   93.824152] x3 : ffffffd0732a0fa4 x2 : 0000000000000001
> > [   93.829628] x1 : ffffffacf5bc7580 x0 : 0000000000000061
> > [   93.835104] Call trace:
> > [   93.837644]  debug_print_object+0x13c/0x1b0
> > [   93.841963]  __debug_check_no_obj_freed+0x25c/0x3c0
> > [   93.846987]  debug_check_no_obj_freed+0x18/0x20
> > [   93.851669]  slab_free_freelist_hook+0xbc/0x1e4
> > [   93.856346]  kfree+0xfc/0x2f4
> > [   93.859416]  rpmsg_ctrldev_release_device+0x78/0xb8
> > [   93.864445]  device_release+0x84/0x168
> > [   93.868310]  kobject_cleanup+0x12c/0x298
> > [   93.872356]  kobject_delayed_cleanup+0x10/0x18
> > [   93.876948]  process_one_work+0x578/0x92c
> > [   93.881086]  worker_thread+0x804/0xcf8
> > [   93.884963]  kthread+0x2a8/0x314
> > [   93.888303]  ret_from_fork+0x10/0x18
> >
> > The cdev_device_add/del() API was created to address this issue
> > (see commit 233ed09d7fda), use it instead of cdev add/del().
> >
> > Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks!
