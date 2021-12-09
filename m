Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BDE46DFFB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbhLIBJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbhLIBJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:09:03 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18BC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:05:31 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id v19-20020a4a2453000000b002bb88bfb594so1341232oov.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4CUp87I5GNiNew7OOv6cyVpbjEOafAh1l4vvlgTFXCY=;
        b=LsmRREmI5Vlld4dzaCdKlMjCawQe3tyy91FA/dNZAAQkpzy3WWUef+uYQ5sZ4ZOKo8
         nWUU+7YLLYU9OeSFPcDJe/MrKBNPCnqLTIM8xEtBVCYvaGyHwt0Fy+aZLka2AC9JBHk4
         CtshMt5G2Bbqt04SkYx/pQEa7QtBIa/IrKwA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4CUp87I5GNiNew7OOv6cyVpbjEOafAh1l4vvlgTFXCY=;
        b=yJiUl1sFktngikcT5zUeM6c1Llo9mtetUmmW96dwP+VQMsSCaQiNCxEhcqGQNb8mgD
         n4lNTCiSMmHGnFn0j1/nBffG5mpQ2M8CWPccMtQdx39ERO/XFc6J6X/RQdPuIoykp7k/
         ewRanLs8HsfE9Vie494plx/UB+YIoRLH3bg58sLKULAPaAgKcc0hmG+dqvHebGQZKlXO
         svmOoPCzcTGoFIv6EnTeKDTSkE6GYovt0pKvl8x97lJhcdkRlyOWFUgL1092LSxCS3Yz
         hETGQ+CefWts0iYtGlbkPMGExjA3S8JAKbKIaMckAiEV0lMjP1yld7POnLWEGlRy6hXP
         TZxQ==
X-Gm-Message-State: AOAM530deY8m4nynltnO/V7A8HsH1iRilV5CWidD+apRECDKQh/jSEM8
        melrFDfRiYMKPkZDD/pmCPC4pRyfDSM26BDkCzV3qw==
X-Google-Smtp-Source: ABdhPJz/ih15ZqfgzvL6/17bIOqh8cUOESC7F+asCapMlzb3x+BLxiHwcIcwuhTZRTSayUwHGRj338p6oVxPi46o/5o=
X-Received: by 2002:a4a:dbd3:: with SMTP id t19mr2075617oou.8.1639011930369;
 Wed, 08 Dec 2021 17:05:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Dec 2021 17:05:29 -0800
MIME-Version: 1.0
In-Reply-To: <20211208125220.v4.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
References: <20211208125220.v4.1.Iaac908f3e3149a89190ce006ba166e2d3fd247a3@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 8 Dec 2021 17:05:29 -0800
Message-ID: <CAE-0n53JAzTAPsWS6c5wmYoWgAwxQgzTqEP65JnFT6AeMu0rbQ@mail.gmail.com>
Subject: Re: [PATCH v4] rpmsg: char: Fix race between the release of
 rpmsg_ctrldev and cdev
To:     Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Sujit Kautkar <sujitka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-12-08 12:52:28)
> From: Sujit Kautkar <sujitka@chromium.org>
>
> From: Sujit Kautkar <sujitka@chromium.org>

This is here twice. Remove one?

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
> Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
