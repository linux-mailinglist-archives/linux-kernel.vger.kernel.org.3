Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9E4D7AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiCNGYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiCNGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:24:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABB43982B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:23:31 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h13so18305607ede.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Jw71v1lLwDJM+l8JN9sD5/vA4iR4lt2UCNDb4uQzVc=;
        b=WZT+/+m0NkrhPaRSyC+2YZ0CP5+FcKRuzZOcMVKuTGEZxTYyf12qmWGa9cKEBhnIE/
         tnFcWCw+ENoV4jIfZRp59cf2PsYZ8cQm8x3jN9uTzjYej3/Wh/GCaE0yL/Yy5xwSbUb5
         VdKDtseNlba0boGi+RL00+2/fFcleLhYG+caevUpA4LZEvm4GvIK8ekL9YMMHdiVfp69
         TfSY/uWlKdSg0/NvoGQF/fZVgOTWI1UZFDeHHc4RNwh7YEP92RPhOTyFZBKFegY0oJ6W
         BkHWqTfR7IsfTWL1CwMtwDkVmn1aAxsbeNDZlKorByVqQ//0bzwsgGIYGlQY4bvgdiXJ
         X0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Jw71v1lLwDJM+l8JN9sD5/vA4iR4lt2UCNDb4uQzVc=;
        b=J1ZjFUA+qdR8uHAEOEKO2niZ+wVq1/sfAr91hm/i5ENJSDyeDTnKmfiyMe4ZKUsvEH
         tRm24QquZnoD3IAjJFIRHnFVpu7MmaUozilUFaTpHqxDLrIwly1m9+NXQ+db996tAMFg
         4lB9hkCDxtRBFbHu5AOHQyPF+7GKXWCu2ST76O5WwM6LjLiwV2zj56CRXN3QjrkS5MTl
         wc796Oq+zczB4DseLNSVHvPnwdEpQLE4Jb9LrOluZxaZnecTuivYO6hS9z9GNvOjwnnW
         S3nX11stW8ju3TzTkYh0l2rduYEnDgUkJCGtU1ssWhw1LgJMpg7mdHrqGNAT5uap7BVy
         MEGQ==
X-Gm-Message-State: AOAM531Jcw85Ph1E1xqBK0NI/xFmb6F9MboZhb3U3iAfMqHdp+1YjyZU
        k5l6bm1Xt0vOyXVBMScWWKxZhdA17YfhPliOWtqxWw==
X-Google-Smtp-Source: ABdhPJxXgmau1hSwokdy/BYxjKCJbJ1abbQn8y06rySaR5WV5kg4Hr7F86JwARyc/jZCpRiqModdgvBV7u8aawm4OC8=
X-Received: by 2002:a05:6402:c12:b0:415:c5cb:f06c with SMTP id
 co18-20020a0564020c1200b00415c5cbf06cmr18975851edb.92.1647239010078; Sun, 13
 Mar 2022 23:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1647001432-239276-1-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 14 Mar 2022 07:23:19 +0100
Message-ID: <CAMGffE=jBKnPa4egHBUApHo2=SpyRyZk98eS-rX8SbN_VCNdPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] scsi: libsas and users: Factor out internal abort code
To:     John Garry <john.garry@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@ionos.com, damien.lemoal@opensource.wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajish.Koshy@microchip.com, linuxarm@huawei.com,
        Viswas.G@microchip.com, hch@lst.de, liuqi115@huawei.com,
        chenxiang66@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 1:29 PM John Garry <john.garry@huawei.com> wrote:
>
> This is a follow-on from the series to factor out the TMF code shared
> between libsas LLDDs.
>
> The hisi_sas and pm8001 have an internal abort feature to abort pending
> commands in the host controller, prior to being sent to the target. The
> driver support implementation is naturally quite similar, so factor it
> out.
>
> Again, testing and review would be appreciated.
>
> This is based on mkp-scsi 5.18 staging queue @ commit 2bd3b6b75946
>
> Changes since v1:
> - fixup small coding issues (Damien)
> - Add Tested-by tags (thanks!)
>
> John Garry (4):
>   scsi: libsas: Add sas_execute_internal_abort_single()
>   scsi: libsas: Add sas_execute_internal_abort_dev()
>   scsi: pm8001: Use libsas internal abort support
>   scsi: hisi_sas: Use libsas internal abort support
Looks good to me!
Acked-by: Jack Wang <jinpu.wang@ionos.com>

Thanks John for doing it!
>
>  drivers/scsi/hisi_sas/hisi_sas.h       |   8 +-
>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 453 +++++++++----------------
>  drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  11 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  18 +-
>  drivers/scsi/libsas/sas_scsi_host.c    |  89 +++++
>  drivers/scsi/pm8001/pm8001_hwi.c       |  27 +-
>  drivers/scsi/pm8001/pm8001_hwi.h       |   5 -
>  drivers/scsi/pm8001/pm8001_sas.c       | 178 +++-------
>  drivers/scsi/pm8001/pm8001_sas.h       |   6 +-
>  drivers/scsi/pm8001/pm80xx_hwi.h       |   5 -
>  include/scsi/libsas.h                  |  24 ++
>  include/scsi/sas.h                     |   2 +
>  12 files changed, 360 insertions(+), 466 deletions(-)
>
> --
> 2.26.2
>
