Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931FB48A186
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbiAJVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343841AbiAJVJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:09:11 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C0C06175B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:09:11 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 45-20020a9d0a30000000b0058f1a6df088so16467200otg.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 13:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=cDctbp+YOya5jGA+rOSFfKCN+J39OyPEzkxeXxqBwNk=;
        b=awJW0G/jVWzMgXNutS151ClYNBgMkJBoS5pW+MMG/IDjJ4yTfQnAu7TBpwlaqTSPa6
         Gy4e0NrCHQpfNLKEnMkzWIH2tja9iFrMv96wHB8HxPMksG4N/429hKU2FuH22tZqPlD1
         HgcUEiEM6gDpj7LKWTUIJIJoLmcQ3UhrP2/Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=cDctbp+YOya5jGA+rOSFfKCN+J39OyPEzkxeXxqBwNk=;
        b=i03e78aNckqybR14wNOFqerZw9pLjAW75cwmvg74K9Vgk7x7hobtw3mvP3+4gzHOHp
         MP7Glvt7HvF56UiJxDNkbia1zRGByYgjBBfuIYdZAqYbSZg3jhv9v/B8rkdABFXgytof
         XtXc0/LoAXj/Iuto9e/Ia+N4emHCz08Xcs7/O109XRP+lo+ceo3MsbGhrSUeNV3lAVlF
         l0X9/hNjvbN44FkFoUjqntVg9g1pkaQ/EZJ36SXauoYqayCV7oHM5eTAt69rwyiivcwM
         LY6Bd52iHL5Vwk1CB8pcKaDKLRkMtHZq9U7/0a5fiVowVIpoR1+o61I1Plp4rGZ6dLc5
         ynbQ==
X-Gm-Message-State: AOAM533unPslvTWH+BfiIhirzrtqgUZ3yYKjoL5U8NwzYOAOZfUW2MtE
        9sZ6mPid7wJzIMLD4cRKeMvM7lNaSa8T/n+MVwOK0Q==
X-Google-Smtp-Source: ABdhPJxPswUxmMrwoKb5prg8DsO0sy13UwsRzzE5jYlxPu3It4QbCrVj2vhKFBTqByGFth1kdHDtBOolX+KagCnRbjA=
X-Received: by 2002:a9d:2243:: with SMTP id o61mr1248968ota.126.1641848950355;
 Mon, 10 Jan 2022 13:09:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Jan 2022 13:09:09 -0800
MIME-Version: 1.0
In-Reply-To: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
References: <20220110104706.v6.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 10 Jan 2022 13:09:09 -0800
Message-ID: <CAE-0n51jie8FsYmU-6uf4EU1oqVQv4siT9dWFu2E-6dw_BHUCw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rpmsg: char: Fix race between the release of
 rpmsg_ctrldev and cdev
To:     Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-01-10 10:47:36)
> From: Sujit Kautkar <sujitka@chromium.org>
>
> struct rpmsg_ctrldev contains a struct cdev. The current code frees
> the rpmsg_ctrldev struct in rpmsg_ctrldev_release_device(), but the
> cdev is a managed object, therefore its release is not predictable
> and the rpmsg_ctrldev could be freed before the cdev is entirely
> released, as in the backtrace below.
>
> [   93.625603] ODEBUG: free active (active state 0) object type: timer_li=
st hint: delayed_work_timer_fn+0x0/0x7c
> [   93.636115] WARNING: CPU: 0 PID: 12 at lib/debugobjects.c:488 debug_pr=
int_object+0x13c/0x1b0
> [   93.644799] Modules linked in: veth xt_cgroup xt_MASQUERADE rfcomm alg=
if_hash algif_skcipher af_alg uinput ip6table_nat fuse uvcvideo videobuf2_v=
malloc venus_enc venus_dec videobuf2_dma_contig hci_uart btandroid btqca sn=
d_soc_rt5682_i2c bluetooth qcom_spmi_temp_alarm snd_soc_rt5682v
> [   93.715175] CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G    B          =
   5.4.163-lockdep #26
> [   93.723855] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
> [   93.730055] Workqueue: events kobject_delayed_cleanup
> [   93.735271] pstate: 60c00009 (nZCv daif +PAN +UAO)
> [   93.740216] pc : debug_print_object+0x13c/0x1b0
> [   93.744890] lr : debug_print_object+0x13c/0x1b0
> [   93.749555] sp : ffffffacf5bc7940
> [   93.752978] x29: ffffffacf5bc7940 x28: dfffffd000000000
> [   93.758448] x27: ffffffacdb11a800 x26: dfffffd000000000
> [   93.763916] x25: ffffffd0734f856c x24: dfffffd000000000
> [   93.769389] x23: 0000000000000000 x22: ffffffd0733c35b0
> [   93.774860] x21: ffffffd0751994a0 x20: ffffffd075ec27c0
> [   93.780338] x19: ffffffd075199100 x18: 00000000000276e0
> [   93.785814] x17: 0000000000000000 x16: dfffffd000000000
> [   93.791291] x15: ffffffffffffffff x14: 6e6968207473696c
> [   93.796768] x13: 0000000000000000 x12: ffffffd075e2b000
> [   93.802244] x11: 0000000000000001 x10: 0000000000000000
> [   93.807723] x9 : d13400dff1921900 x8 : d13400dff1921900
> [   93.813200] x7 : 0000000000000000 x6 : 0000000000000000
> [   93.818676] x5 : 0000000000000080 x4 : 0000000000000000
> [   93.824152] x3 : ffffffd0732a0fa4 x2 : 0000000000000001
> [   93.829628] x1 : ffffffacf5bc7580 x0 : 0000000000000061
> [   93.835104] Call trace:
> [   93.837644]  debug_print_object+0x13c/0x1b0
> [   93.841963]  __debug_check_no_obj_freed+0x25c/0x3c0
> [   93.846987]  debug_check_no_obj_freed+0x18/0x20
> [   93.851669]  slab_free_freelist_hook+0xbc/0x1e4
> [   93.856346]  kfree+0xfc/0x2f4
> [   93.859416]  rpmsg_ctrldev_release_device+0x78/0xb8
> [   93.864445]  device_release+0x84/0x168
> [   93.868310]  kobject_cleanup+0x12c/0x298
> [   93.872356]  kobject_delayed_cleanup+0x10/0x18
> [   93.876948]  process_one_work+0x578/0x92c
> [   93.881086]  worker_thread+0x804/0xcf8
> [   93.884963]  kthread+0x2a8/0x314
> [   93.888303]  ret_from_fork+0x10/0x18
>
> The cdev_device_add/del() API was created to address this issue
> (see commit 233ed09d7fda), use it instead of cdev add/del().
>
> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
