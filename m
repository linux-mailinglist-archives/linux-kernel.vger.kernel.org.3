Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED22473D64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhLNHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhLNHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:04:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:04:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z5so60376110edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 23:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9jxTk8Oq9Ml0Qe9k0yTl7QSoV5iDa8z2SU+R+w0fKE=;
        b=ZTQF0ERXsGbSr8qFOAK4z9gw37T0U2RZHHLhVGCEUSTJ+qDDyBypPbGcieVl4idF9V
         BY3SYNfsj4vItCyJHmxS2FF4iATeYnwI5E+dwXa2Ki2krmYZ7BVLremsNBmRqemwTAvZ
         X37dnZKbmmnXAm43ra0OkVUoZpMTblppfmEE5XkpBiuwtnrANXFbQZmDJj5L5lcjBsM+
         4iWQgc+YDlcztADcwHnNyYrgRRcgeASimHyAqt0gQBqbsINDVMM1Fg5mqNwIYrzbF7qg
         zH5pN/eZHtw3rR8Ztx8mME6T9IYTfurwUlWkD4MU64WRn0x1mKzeF5hXgK5QUU1iy6Ti
         3pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9jxTk8Oq9Ml0Qe9k0yTl7QSoV5iDa8z2SU+R+w0fKE=;
        b=bzWOjDdwQvAMWRmCuV66CGfm4dFSsYl2mrKi6Lnir4tyHrWmbQ9RIcCt+qi4dwmZer
         BzR18FV6b910MbttMQ7W7Tv8lMQwcZp9HbDDk2/QknbTnaBL9/2NOMBiJMFJU1z0PU9/
         L74A1ONNnN/uDvEwtVY+yR9AyA9yrkReguY1QcQ+ig/u1G4cyeXQI9/DuKkhzBCcJvFE
         gPBipfodWVud7spoxSNAIO7ii9sFagyRp3nSTKiHyb/pglAGFkMJSW8/TPU6x+ty7z1I
         P+tbjIGxvVOFOfmxTUmhF2bCL7e3Z2s8xMZPECcmJgHaHcO8mjgSKvzVMpMpmw+vuJ8M
         +dRA==
X-Gm-Message-State: AOAM533Iv/ypxNpvtnV4UzXbd9CMvGVjLUuH/Ij5hUrn8jZlTGAB2Y2g
        DkYXlEwOHsz1NyfCqYG1BUwVWaChJOvW1aUstf2F5A==
X-Google-Smtp-Source: ABdhPJyH2we1BAqKPlIszha4Yp8d9EPCWmgxYenyH8yHdpKgWJEM4xZxThghjTN644G+udyKStYikz4xSJpflrf6gBA=
X-Received: by 2002:a17:907:9607:: with SMTP id gb7mr3800574ejc.441.1639465457820;
 Mon, 13 Dec 2021 23:04:17 -0800 (PST)
MIME-Version: 1.0
References: <1639390248-213603-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1639390248-213603-1-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 14 Dec 2021 08:04:07 +0100
Message-ID: <CAMGffEmp1KbJ0v-wwOYMUbCx4pqXrvr-2rerUw=8NpwBCQsyKQ@mail.gmail.com>
Subject: Re: [PATCH v3] scsi: pm8001: Fix phys_to_virt() usage on dma_addr_t
To:     John Garry <john.garry@huawei.com>
Cc:     jinpu.wang@ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Viswas.G@microchip.com,
        Ajish.Koshy@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, damien.lemoal@opensource.wdc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:16 AM John Garry <john.garry@huawei.com> wrote:
>
> The driver supports a "direct" mode of operation, where the SMP req frame
> is directly copied into the command payload (and vice-versa for the SMP
> resp).
>
> To get at the SMP req frame data in the scatterlist the driver uses
> phys_to_virt() on the DMA mapped memory dma_addr_t . This is broken,
> and subsequently crashes as follows when an IOMMU is enabled:
>
>  Unable to handle kernel paging request at virtual address
> ffff0000fcebfb00
>         ...
>  pc : pm80xx_chip_smp_req+0x2d0/0x3d0
>  lr : pm80xx_chip_smp_req+0xac/0x3d0
>  pm80xx_chip_smp_req+0x2d0/0x3d0
>  pm8001_task_exec.constprop.0+0x368/0x520
>  pm8001_queue_command+0x1c/0x30
>  smp_execute_task_sg+0xdc/0x204
>  sas_discover_expander.part.0+0xac/0x6cc
>  sas_discover_root_expander+0x8c/0x150
>  sas_discover_domain+0x3ac/0x6a0
>  process_one_work+0x1d0/0x354
>  worker_thread+0x13c/0x470
>  kthread+0x17c/0x190
>  ret_from_fork+0x10/0x20
>  Code: 371806e1 910006d6 6b16033f 54000249 (38766b05)
>  ---[ end trace b91d59aaee98ea2d ]---
> note: kworker/u192:0[7] exited with preempt_count 1
>
> Instead use kmap_atomic().
>
> Signed-off-by: John Garry <john.garry@huawei.com>
Thanks for the fix.
looks good to me too.

Acked-by: Jack Wang <jinpu.wang@ionos.com>

> --
> Difference to v1:
> - use kmap_atomic() in both locations
> Difference to  v2:
> - add whitespace around arithmetic (Damien)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index b9f6d83ff380..2101fc5761c3 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3053,7 +3053,6 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>         struct smp_completion_resp *psmpPayload;
>         struct task_status_struct *ts;
>         struct pm8001_device *pm8001_dev;
> -       char *pdma_respaddr = NULL;
>
>         psmpPayload = (struct smp_completion_resp *)(piomb + 4);
>         status = le32_to_cpu(psmpPayload->status);
> @@ -3080,19 +3079,23 @@ mpi_smp_completion(struct pm8001_hba_info *pm8001_ha, void *piomb)
>                 if (pm8001_dev)
>                         atomic_dec(&pm8001_dev->running_req);
>                 if (pm8001_ha->smp_exp_mode == SMP_DIRECT) {
> +                       struct scatterlist *sg_resp = &t->smp_task.smp_resp;
> +                       u8 *payload;
> +                       void *to;
> +
>                         pm8001_dbg(pm8001_ha, IO,
>                                    "DIRECT RESPONSE Length:%d\n",
>                                    param);
> -                       pdma_respaddr = (char *)(phys_to_virt(cpu_to_le64
> -                                               ((u64)sg_dma_address
> -                                               (&t->smp_task.smp_resp))));
> +                       to = kmap_atomic(sg_page(sg_resp));
> +                       payload = to + sg_resp->offset;
>                         for (i = 0; i < param; i++) {
> -                               *(pdma_respaddr+i) = psmpPayload->_r_a[i];
> +                               *(payload + i) = psmpPayload->_r_a[i];
>                                 pm8001_dbg(pm8001_ha, IO,
>                                            "SMP Byte%d DMA data 0x%x psmp 0x%x\n",
> -                                          i, *(pdma_respaddr + i),
> +                                          i, *(payload + i),
>                                            psmpPayload->_r_a[i]);
>                         }
> +                       kunmap_atomic(to);
>                 }
>                 break;
>         case IO_ABORTED:
> @@ -4236,14 +4239,14 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>         struct sas_task *task = ccb->task;
>         struct domain_device *dev = task->dev;
>         struct pm8001_device *pm8001_dev = dev->lldd_dev;
> -       struct scatterlist *sg_req, *sg_resp;
> +       struct scatterlist *sg_req, *sg_resp, *smp_req;
>         u32 req_len, resp_len;
>         struct smp_req smp_cmd;
>         u32 opc;
>         struct inbound_queue_table *circularQ;
> -       char *preq_dma_addr = NULL;
> -       __le64 tmp_addr;
>         u32 i, length;
> +       u8 *payload;
> +       u8 *to;
>
>         memset(&smp_cmd, 0, sizeof(smp_cmd));
>         /*
> @@ -4280,8 +4283,9 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>                 pm8001_ha->smp_exp_mode = SMP_INDIRECT;
>
>
> -       tmp_addr = cpu_to_le64((u64)sg_dma_address(&task->smp_task.smp_req));
> -       preq_dma_addr = (char *)phys_to_virt(tmp_addr);
> +       smp_req = &task->smp_task.smp_req;
> +       to = kmap_atomic(sg_page(smp_req));
> +       payload = to + smp_req->offset;
>
>         /* INDIRECT MODE command settings. Use DMA */
>         if (pm8001_ha->smp_exp_mode == SMP_INDIRECT) {
> @@ -4289,7 +4293,7 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>                 /* for SPCv indirect mode. Place the top 4 bytes of
>                  * SMP Request header here. */
>                 for (i = 0; i < 4; i++)
> -                       smp_cmd.smp_req16[i] = *(preq_dma_addr + i);
> +                       smp_cmd.smp_req16[i] = *(payload + i);
>                 /* exclude top 4 bytes for SMP req header */
>                 smp_cmd.long_smp_req.long_req_addr =
>                         cpu_to_le64((u64)sg_dma_address
> @@ -4320,20 +4324,20 @@ static int pm80xx_chip_smp_req(struct pm8001_hba_info *pm8001_ha,
>                 pm8001_dbg(pm8001_ha, IO, "SMP REQUEST DIRECT MODE\n");
>                 for (i = 0; i < length; i++)
>                         if (i < 16) {
> -                               smp_cmd.smp_req16[i] = *(preq_dma_addr+i);
> +                               smp_cmd.smp_req16[i] = *(payload + i);
>                                 pm8001_dbg(pm8001_ha, IO,
>                                            "Byte[%d]:%x (DMA data:%x)\n",
>                                            i, smp_cmd.smp_req16[i],
> -                                          *(preq_dma_addr));
> +                                          *(payload));
>                         } else {
> -                               smp_cmd.smp_req[i] = *(preq_dma_addr+i);
> +                               smp_cmd.smp_req[i] = *(payload + i);
>                                 pm8001_dbg(pm8001_ha, IO,
>                                            "Byte[%d]:%x (DMA data:%x)\n",
>                                            i, smp_cmd.smp_req[i],
> -                                          *(preq_dma_addr));
> +                                          *(payload));
>                         }
>         }
> -
> +       kunmap_atomic(to);
>         build_smp_cmd(pm8001_dev->device_id, smp_cmd.tag,
>                                 &smp_cmd, pm8001_ha->smp_exp_mode, length);
>         rc = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &smp_cmd,
> --
> 2.26.2
>
