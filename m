Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A9E590B62
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 06:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiHLE6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 00:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiHLE5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 00:57:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC01979DC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:57:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i14so99755ejg.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=esCwiaYMyxPm/0WM1CWCnpWQTYpwGXFmhJ7X2Uu3/Yw=;
        b=JONVOUJyQDPrSdFLQKezRHZn0cp7/xVwESrOSFkwCyzegHoJlMH9SrHVAAyyVAOnMF
         E7mLuuSB1vKmcfJNNcFSxEZuTAo6BghXLL/OpaDMscy9y4LE4INDNTVcTT8BISaWhSm8
         yXU0nbrZTVOTL70bcgHgJOIUxBHXtXqAHwyOl0hF28kSfGin/QdbXOASmgE0b9rrhOWQ
         RlF8bs2/vL08Qkvu9DQuWJ9Q83eLHUSG/ZYA3xb7guXdbvHGGIo0fm/MBwU48lxCKFID
         1m60ntbTzGAor8NagR1I/WzxPqBKhFVNf6bwrimZ21eJTyG4z4YNIku66YO0s1yi/+UM
         OYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=esCwiaYMyxPm/0WM1CWCnpWQTYpwGXFmhJ7X2Uu3/Yw=;
        b=khgJZx4wQJBoOTdNz0r8HxTQPbZKyyIdfhi9mO68YQ11R30iywHUwqudRoVrRYl5g+
         oYQ5RxJIVQ4RT0Bzcgf6GuQaj4fKjKlZOhPaYXNcfLrlFqTjVPSpLqj3AA7WvLF6j0SD
         cohhv9oljPwhnmUoiQbiDpVTXwLHKYlr9h4lkUWdafaqnA7QcVWhmh37Z9vVOii3uLt3
         y4iUxnMHFyaFPGuf9PZiN/jy4SDHE+tLNjLp0g3ZTMBmXIn21vKxlDUKmMzddkq0JwA8
         5cVKGYoDXESZ6S2boWKGMTiqxC5a2eZ5S8N+YTQLcnx/6UjcDcVcit2VsOutBPs3S+T6
         qlTA==
X-Gm-Message-State: ACgBeo2I7iQzS7fknK5gH/4Fdia0i7lUG7WogxPfHWLhCTUwhfiq5Iy4
        KOtkHG1b0XfkvMM1mgXp4VIgaIQs5Eqh13kmZlQh6g==
X-Google-Smtp-Source: AA6agR470OyVHzqds4bFdjKNCgWVMFNHfGSWvdl3gh6dNrGtXRPkPR8GBoj2tyRgsTBlmUFU9ZBQM9KdU0GWgNHJz7E=
X-Received: by 2002:a17:906:d0d0:b0:730:9352:7484 with SMTP id
 bq16-20020a170906d0d000b0073093527484mr1546202ejb.70.1660280266721; Thu, 11
 Aug 2022 21:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1658489049-232850-1-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 12 Aug 2022 06:57:35 +0200
Message-ID: <CAMGffEky_UeLbEBKWEMjuJ6B6QFuj08uOuUMZK9Qwt+1Gxxqug@mail.gmail.com>
Subject: Re: [PATCH 0/6] libsas and drivers: NCQ error handling
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@ionos.com, damien.lemoal@opensource.wdc.com,
        yangxingui@huawei.com, chenxiang66@hisilicon.com, hare@suse.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 1:30 PM John Garry <john.garry@huawei.com> wrote:
>
> As reported in [0], the pm8001 driver NCQ error handling more or less
> duplicates what libata does in link error handling, as follows:
> - abort all commands
> - do autopsy with read log ext 10 command
> - reset the target to recover
>
> Indeed for the hisi_sas driver we want to add similar handling for NCQ
> errors.
>
> This series add a new libsas API - sas_ata_link_abort() - to handle host
> NCQ errors, and fixes up pm8001 and hisi_sas drivers to use it. As
> mentioned in the pm8001 changeover patch, I would prefer a better place to
> locate the SATA ABORT command (rather that nexus reset callback).
>
> I would appreciate some testing of the pm8001 change as the read log ext10
> command mostly hangs on my arm64 machine - these arm64 hangs are a known
> issue.
>
> Finally with these changes we can make the libsas task alloc/free APIs
> private, which they should always have been.
>
> Based on v5.19-rc6
>
> [0] https://lore.kernel.org/linux-scsi/8fb3b093-55f0-1fab-81f4-e8519810a978@huawei.com/
>
> John Garry (5):
>   scsi: pm8001: Modify task abort handling for SATA task
>   scsi: libsas: Add sas_ata_link_abort()
>   scsi: pm8001: Use sas_ata_link_abort() to handle NCQ errors
>   scsi: hisi_sas: Don't issue ATA softreset in hisi_sas_abort_task()
>   scsi: libsas: Make sas_{alloc, alloc_slow, free}_task() private
>
> Xingui Yang (1):
>   scsi: hisi_sas: Add SATA_DISK_ERR bit handling for v3 hw
>
>  drivers/scsi/hisi_sas/hisi_sas_main.c  |   5 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  22 ++-
>  drivers/scsi/libsas/sas_ata.c          |  10 ++
>  drivers/scsi/libsas/sas_init.c         |   3 -
>  drivers/scsi/libsas/sas_internal.h     |   4 +
>  drivers/scsi/pm8001/pm8001_hwi.c       | 194 +++++++------------------
>  drivers/scsi/pm8001/pm8001_sas.c       |  13 ++
>  drivers/scsi/pm8001/pm8001_sas.h       |   8 +-
>  drivers/scsi/pm8001/pm80xx_hwi.c       | 177 ++--------------------
>  include/scsi/libsas.h                  |   4 -
>  include/scsi/sas_ata.h                 |   5 +
>  11 files changed, 132 insertions(+), 313 deletions(-)

Thank! John and Damien,
for pm80xx.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> --
> 2.35.3
>
