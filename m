Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF5A48438A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbiADOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiADOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:40:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497D6C061761;
        Tue,  4 Jan 2022 06:40:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id k21so82250723lfu.0;
        Tue, 04 Jan 2022 06:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ab0QEwSG8BDrjyDLCDXwNE8BTCoNpJU2Z1rDY4OSSxE=;
        b=e+q02a2rXSOjPnMB0dV8zMxim3mBRFx1VQtORwuBbjRX2FAvV5pEuHPkatffBdMmgo
         4sMS5cE/tc5DGUz02Q3QjXAysthquwNijVOyQwePvqzEvhixdibVjDDasIDPjOvfZ6Rs
         KwDX+Gah7qTNOxCiv/zm1jhXHMVr2NARXpG9mfVbXN5k97rKv6tVQs8uOwQRZryDigG3
         +Y/EAFGKCPggBp0pwHDbHq3Kwoj01DlhXa7LCKUrvUq1lGk2upcXhN82Jt1PgpPqP3mJ
         m89rcQAkSS/GRQno0rFSxKMfcqYnFxHZw39+sUy+7eiwiOrtbp8tptmTck/v9xsTF5GL
         s34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ab0QEwSG8BDrjyDLCDXwNE8BTCoNpJU2Z1rDY4OSSxE=;
        b=pNZKgHb9pcOc8LLeD4dM0zHAN716qWXzBbdKp3BGe5nXTz9Z9n3vY0iQHP0CSBLTHO
         YthquJvvdDD+Nunxa+UPGASi/kmgfd7Nlm/OEDRYxiHws7gc9mAZnReKv2fLB374vKMF
         HJ4dRhb9kgY627pemdIluy1SA6HBbSjQX2reXWkzBXO79w28t4r1n/A9bD6oz2Ir3KS+
         WfRCe7Hy4LoXY8DV63KXbjv9Xxo+RlAasueW6Vt0wl6iYfpIXoU63+wWX9KsG57t+pxN
         9KxgAHL4Yn4KWdo+jjUQBoParA4dazBaqsEHzPQVOb7q9I+EBLBQ3K4NDdi3FS9pK/Tn
         DUUA==
X-Gm-Message-State: AOAM533GVfTpsHKIYmAglDhGk/gINA5OAYDxlfIlXsOHUfD56XzhcvLo
        dTfJV3oMdDzdaRPvVpNgtSjorAWzL4pprX1iBOE=
X-Google-Smtp-Source: ABdhPJzaYz/XADZmxyEUH6OZK0zIxPj18T6xcN8ral7c+XVMFRFcmIezdaSIlqj/SyFxJicBnFbgV9ui4amstJ8bF8w=
X-Received: by 2002:a05:6512:2249:: with SMTP id i9mr44883667lfu.100.1641307228600;
 Tue, 04 Jan 2022 06:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20220104135328.604-1-yuehaibing@huawei.com>
In-Reply-To: <20220104135328.604-1-yuehaibing@huawei.com>
From:   Aleksandr Mezin <mezin.alexander@gmail.com>
Date:   Tue, 4 Jan 2022 20:40:17 +0600
Message-ID: <CADnvcf+xszorFKv72wf0AMnNwr0r7O+2-KQWSt6tqaGzNKcUpg@mail.gmail.com>
Subject: Re: [PATCH -next] hwmon: (nzxt-smart2) Fix build with CONFIG_PM=n
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 7:54 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/hwmon/nzxt-smart2.c:707:12: error: 'nzxt_smart2_hid_reset_resume' defined but not used [-Werror=unused-function]
>   707 | static int nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
>       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Move it into #ifdef block to fix this.
>
> Fixes: 0e43f31ee52f ("hwmon: add driver for NZXT RGB&Fan Controller/Smart Device v2.")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/hwmon/nzxt-smart2.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
> index 534d39b8908e..4963d630394a 100644
> --- a/drivers/hwmon/nzxt-smart2.c
> +++ b/drivers/hwmon/nzxt-smart2.c
> @@ -704,6 +704,7 @@ static int nzxt_smart2_hid_raw_event(struct hid_device *hdev,
>         return 0;
>  }
>
> +#ifdef CONFIG_PM
>  static int nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
>  {
>         struct drvdata *drvdata = hid_get_drvdata(hdev);
> @@ -720,6 +721,7 @@ static int nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
>
>         return init_device(drvdata, drvdata->update_interval);
>  }
> +#endif
>
>  static int nzxt_smart2_hid_probe(struct hid_device *hdev,
>                                  const struct hid_device_id *id)
> --
> 2.17.1
>

Hi.

It's already fixed:
https://lore.kernel.org/all/20211228014813.832491-1-mezin.alexander@gmail.com/
(and already in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/hwmon/nzxt-smart2.c?id=f103b2e5a6197586effb0b9a1b72c30b5d65b0cd
)
