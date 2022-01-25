Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED8749B3A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382772AbiAYMPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444435AbiAYMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:10:55 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D80C061747
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:08:44 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id d10so30328160eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 04:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnTeOdUZ1f18AewsYNZJ5wSThzHFTuycY7IVqVPOkq4=;
        b=ZvHEkk5xUxPuGXPnF5qSuvyzgrOJuihK9Y7jz5RAAisK5c7Llx+i3W5Cim8Es9HwKQ
         KeR7WV4260zLaoLr9S7z5ZjLj6L0PiqoTCS+AaxkLgx63ttkPdzm1qZaLEuVgTlw3SY4
         +TkggyDT1NjuTNf4ubfR+Hi77GRyFzO6PGoKcAAbp3bwQpcPov13FdXRmDc5er8IYhQa
         7U3WamVIW5u0uoCphTZzxwiCUsanHATz6flPKGpHH5M4fXs0DUYxoQ7soSiu2vbQLfyM
         xhM9OYRvxgwI0BwQeIl69WroDpTU3u+6NiYm6qikHVDqAKXPFdctOQQSZzIQINkai3md
         a7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnTeOdUZ1f18AewsYNZJ5wSThzHFTuycY7IVqVPOkq4=;
        b=2B50uuNrZDRKJX8h3wIW4KjnEXSz1GkxB+7FLqbMTUWEaYXzk8H8aBWmok90c188od
         Io00m+M287pbWCXrx/HS0/FDkL7Z1Mt3lL6G2JY1ETU19v5JH3CFhBaZ+Ba8LaWcd6Tm
         PILP4YMpwH8eJSZY9PTkiq2XMWStAfn9B4BaRONI+zNaktz1i7ak3O1VO12Y16jr3Xgb
         m4X1g+mOlKWfheZ9o0T2zJteXdy0Iry/WIkULqZk6CZibpBTvbU8x8wnxzL4My3N7PJq
         JrtWnU3BwHOhFapbLqjflgxICnZP4seNjkm2kNCIGAlayKIGnUv1JDb7XcGhB7HvuPE0
         3EwQ==
X-Gm-Message-State: AOAM5316+7KP00KAlepNcs/3lYtGGO/qDUoZQ0r+NuatOqS4bIRS1Qw5
        0nBhf6QBDMJWkvSH7ghxJrrMyu7MuPJICq+NXshN8A==
X-Google-Smtp-Source: ABdhPJz2+mIM5zA6wUdvIdNw7dCbU7p6GO73rgF0MZ2UBLSc7rUHX6MYpPx/oW8XBB/mbeH2j2BN4/3E3HfcMDU6OGs=
X-Received: by 2002:a17:907:3f84:: with SMTP id hr4mr16347608ejc.443.1643112522894;
 Tue, 25 Jan 2022 04:08:42 -0800 (PST)
MIME-Version: 1.0
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com> <1643110372-85470-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1643110372-85470-2-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 25 Jan 2022 13:08:31 +0100
Message-ID: <CAMGffEn1mCb=EmspNnRw_H0es5ZfBWMrZj9G8J7y=_YH3PdF6Q@mail.gmail.com>
Subject: Re: [PATCH 01/16] scsi: libsas: Use enum for response frame DATAPRES field
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        artur.paszkiewicz@intel.com, jinpu.wang@ionos.com,
        chenxiang66@hisilicon.com, Ajish.Koshy@microchip.com,
        yanaijie@huawei.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com, Viswas.G@microchip.com,
        damien.lemoal@opensource.wdc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:38 PM John Garry <john.garry@huawei.com> wrote:
>
> As defined in table 126 of the SAS spec 1.1, use an enum for the DATAPRES
> field, which makes reading the code easier.
>
> Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/scsi/libsas/sas_task.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/scsi/libsas/sas_task.c b/drivers/scsi/libsas/sas_task.c
> index 2966ead1d421..7240fd22b154 100644
> --- a/drivers/scsi/libsas/sas_task.c
> +++ b/drivers/scsi/libsas/sas_task.c
> @@ -7,6 +7,12 @@
>  #include <scsi/sas.h>
>  #include <scsi/libsas.h>
>
> +enum {
> +       NO_DATA = 0,
> +       RESPONSE_DATA = 1,
> +       SENSE_DATA = 2,
> +};
> +
>  /* fill task_status_struct based on SSP response frame */
>  void sas_ssp_task_response(struct device *dev, struct sas_task *task,
>                            struct ssp_response_iu *iu)
> @@ -15,11 +21,11 @@ void sas_ssp_task_response(struct device *dev, struct sas_task *task,
>
>         tstat->resp = SAS_TASK_COMPLETE;
>
> -       if (iu->datapres == 0)
> +       if (iu->datapres == NO_DATA)
>                 tstat->stat = iu->status;
> -       else if (iu->datapres == 1)
> +       else if (iu->datapres == RESPONSE_DATA)
>                 tstat->stat = iu->resp_data[3];
> -       else if (iu->datapres == 2) {
> +       else if (iu->datapres == SENSE_DATA) {
>                 tstat->stat = SAS_SAM_STAT_CHECK_CONDITION;
>                 tstat->buf_valid_size =
>                         min_t(int, SAS_STATUS_BUF_SIZE,
> --
> 2.26.2
>
