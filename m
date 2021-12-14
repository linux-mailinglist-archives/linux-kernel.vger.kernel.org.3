Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D83E473C39
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhLNEzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLNEzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:55:53 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD414C061574;
        Mon, 13 Dec 2021 20:55:52 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id h16so16812272ila.4;
        Mon, 13 Dec 2021 20:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsBIaAHTm+Ce33MAqe66+oomMTkEdHoRvuk0H6tZ+NE=;
        b=cD+W6ePgo75qRGasOjN9FhQ4FCFCH19enVfosGXH94vAoDJ/G17yaDdfWfUTMdXZAj
         MC2BYkY4Sg1cBEfCyN6B4z9zu4KasJALpaw3SldVPb3SQdJdXXhuTSpp6XMlLEOWZP7e
         N1rJOr05XMIEL65cvKFGzMv0wuKL2atJMOSr0V08HY3m4DWAB42SBSOLIYTU0Y0C/pbz
         JKE8Wip2Uem8W+prRGuoRo/orCmP3U2RkcS/REfkKGvE3N3CJVUI7LFKvqNPfieTBfsu
         CT+kO0A18hEokyKp+lgaDn6uijPqxq+E7yCkQQt1Tv1cmGHmAzMgViqrB5kZbtpu9Exu
         faVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsBIaAHTm+Ce33MAqe66+oomMTkEdHoRvuk0H6tZ+NE=;
        b=mGoGbyg2UVYyz7oVccdpFMUidCJl4izDi6CHFi8Yz5mo8natu+2Q265SOSeJqUfam8
         5g/IS7eJmMw3hnE85GG8eCmgJyToWAzs6GoV4QmdBV5i38oAEOuGh4AogxFAmtrC1ThC
         z4IXLDhv341k+rMTeBVSUBa0WdWn9R7giL3Qcow1XX8qWfj2FFgt6Jd6tyAkK1fpgB84
         gYfeZWVEAhIkDHmy5MPZ8dZtSgHF0MLowiek/zC4kqk575yFoMorOyzUCFKHHHYgnqCO
         hMEWEj1wxN4aJqd26MqE1TPCzro3dfk+JKaNVBtxau4PXqp0PJVQ0qot0SDvEpNhIFKL
         tjzQ==
X-Gm-Message-State: AOAM532aWzGnrnTl0Z+fKt0SUq243W1wdvw2xU4rZmG7cfpD3HpnKhv6
        3MlqBwHwy9uAhfdf3zskJJXZQnT1oruFXE8QSE0=
X-Google-Smtp-Source: ABdhPJwN0GwUrv+tFszZzEtRYNAsVMZvAO4GU0eSGkyt7eALSk/ZyZYwc7teP8wcDzkxuPP+ftM9vmA8tAQhEXblMRY=
X-Received: by 2002:a92:c56c:: with SMTP id b12mr2005122ilj.237.1639457751563;
 Mon, 13 Dec 2021 20:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20211213230045.492994-1-huobean@gmail.com> <101fa5ba-6d74-6c51-aaa2-e6c6d98f6bc7@acm.org>
In-Reply-To: <101fa5ba-6d74-6c51-aaa2-e6c6d98f6bc7@acm.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 13 Dec 2021 20:55:39 -0800
Message-ID: <CANcMJZCDe5fL0qYjgmDWJeHWjNYY0pzZ6TcNJ_nzdzR1VKjCug@mail.gmail.com>
Subject: Re: [PATCH v1] scsi: ufs: Fix deadlock issue in ufshcd_wait_for_doorbell_clr()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bean Huo <huobean@gmail.com>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 8:15 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/13/21 3:00 PM, Bean Huo wrote:
> > Call shost_for_each_device() with host->host_lock is held will cause
> > a deadlock situation, which will cause the system to stall (the log
> > as follow). Fix this issue by narrowing the scope of the lock.
>
> Hi Bean,
>
> As you probably know I do not have access to a test setup that supports clock
> scaling. Has the following patch been considered?
>
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 6d692aae67ce..244eddf0caf8 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1084,7 +1084,9 @@ static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
>         struct scsi_device *sdev;
>         u32 pending = 0;
>
> -       shost_for_each_device(sdev, hba->host)
> +       lockdep_assert_held(hba->host->host_lock);
> +
> +       __shost_for_each_device(sdev, hba->host)
>                 pending += sbitmap_weight(&sdev->budget_map);

We hit the same issue today as well, and this solution works on db845c.

Reported-by: YongQin Liu <yongqin.liu@linaro.org>
Reported-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
