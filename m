Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42057565C1E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiGDQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiGDQaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:30:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4F26E5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:30:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fw3so17559602ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qa+D4dQqiBNUy+is+Q6bf3LQA+gxHqJGFG1OJEKL5bs=;
        b=z0EQ+27kM9xc0j0LImY4X+pRFKgSnisohyhBDU8Rq83T6Y87tCIzwknamSJh88V1Nj
         VrlRGqFcKs074+VLAkLVUyDY9BKAJ5wSjrbIrlZBysGt4BdBQRinSrwWmIx7YAaCrO8A
         xr9xih6bUdGOjPbAvOKb7BBvu8QRtgSvOv6GE0fzK/FTNtDES/OKwQt/50OeKCapGJw/
         bK7y+PkTGoZbBz12BOrXoKW48xQkScMzHHH6YZ6LWbTP7CXxquy8Jp7L0BbCz9AdXwVG
         z2INJJs2z0252YebDihETK9EMtVN5CCCTtMQX7JZBhEC1dFClw0n/JmvJRvNP3phoTyp
         iwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qa+D4dQqiBNUy+is+Q6bf3LQA+gxHqJGFG1OJEKL5bs=;
        b=Gjw5Q8q9IS1YuMhVYjGrGRX7lQrHDo7YQ/KgBhRki/8GyfZqWN9wtU6u06lo4/2KU+
         vWw3NLWcyhzSxnQ0/N8utKPVbeRNMPKqfhw1vkuL2ypiv3wIldBM7UkJ2VxQ8n3c+8Sq
         02uLWTwMD+4434shvGp76yQxlPlQgrzl1u6UMSxwX65OW6dt1qFu3AjORRxQVgo6WDuS
         ID22zbB9RireBJEALLxfZ7rl8SjJQ6mOPgSN3e7MyI1y9v7gJnANqp5W76AG1sbfJsrt
         GI/GZHZNixevLegxV3u1dvUI3Kt/jztYdadE+BPjC05q754uniJBeIqdWgPpiYSh+58u
         5BHA==
X-Gm-Message-State: AJIora+DMjW/JW0AF3a17GRh+H15KoEDvIuqmlMevC0repfkx8EYpQne
        mH8tQM63U5g/8NNjwiKORwMpsUsgwI4eC7whhI2FGQ==
X-Google-Smtp-Source: AGRyM1tAvL9Q82zGIZW1hD00z0B2wNatH7drzCU8LGzRu6ig6mbuRx4O5Um+W8hO0Yo7sZwIQTJMgNI59Y2Qqw1ZJ6U=
X-Received: by 2002:a17:907:a088:b0:726:dbb1:6aed with SMTP id
 hu8-20020a170907a08800b00726dbb16aedmr29386042ejc.407.1656952211401; Mon, 04
 Jul 2022 09:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220701093702.265249-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220701093702.265249-1-peng.fan@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 4 Jul 2022 10:30:00 -0600
Message-ID: <CANLsYkyo304DWjNEv3GT4RJTA+HzZnS_tg0kci35X53E70pTjg@mail.gmail.com>
Subject: Re: [PATCH V6 0/2] remoteproc: support self recovery
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
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

On Fri, 1 Jul 2022 at 03:35, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V6:
>  Rename rproc_firmware_recovery to rproc_boot_recovery
>  Drop the unlock/lock when do reproc_attach_recovery

Dropped.

>
> V5:
>  Rename RPROC_FEAT_ATTACH_RECOVERY to RPROC_FEAT_ATTACH_ON_RECOVERY
>  Add kerneldoc for rproc features
>  Change rproc_set_feature to return int type and add a max feature check
>  Use __rproc_detach and __rproc_attach when do attach recovery
>  https://patchwork.kernel.org/project/linux-remoteproc/cover/20220615032048.465486-1-peng.fan@oss.nxp.com/
>
> V4:
>   Based on Bjorn's comments on V2-2
>   Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h and
>  Keep rproc_features still in remoteproc.h, because we use
>  RPROC_MAX_FEATURES to declare bitmap.
>   Update commit log for patch 2/2, and add comments
>
>   https://patchwork.kernel.org/project/linux-remoteproc/cover/20220323034405.976643-1-peng.fan@oss.nxp.com/
>
> V3:
>  Resend the wrong labeled patchset
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
>
>  Write a cover-letter
>  To i.MX8QM/QXP, they have a M4 core self-recovery capability without
>  Linux loading firmware. The self recovery is done by
>  SCU(System Control Unit). Current remoteproc framework only support Linux
>  help recovery remote processor(stop, loading firmware, start). This
>  patchset is support remote processor self recovery(attach recovery).
>
>  In order to avoid introducing a new variable(bool support_self_recovery),
>  patch 1 introduce a new function, rproc_has_feature to make code easy to
>  extend, cleaner, such as we could move "bool has_iommu" to
>  rproc_has_feature(rproc, RPROC_FEAT_IOMMU).
>
>  Patch 2 is introduce a new function rproc_attach_recovery for
>  self recovery, the original logic move to rproc_firmware_recovery meaning
>  needs linux to help recovery.
>
>  V2-version 2:
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
>  Introduce rproc_has_feature
>
>  V2-version 1:
>  https://patchwork.kernel.org/project/linux-remoteproc/patch/20220126085120.3397450-1-peng.fan@oss.nxp.com/
>  Nothing change in V2.
>  Only move this patch out from
>  https://patchwork.kernel.org/project/linux-remoteproc/list/?series=604364
>
>
> Peng Fan (2):
>   remoteproc: introduce rproc features
>   remoteproc: support attach recovery after rproc crash
>
>  drivers/remoteproc/remoteproc_core.c     | 62 ++++++++++++++++--------
>  drivers/remoteproc/remoteproc_internal.h | 15 ++++++
>  include/linux/remoteproc.h               | 15 ++++++
>  3 files changed, 73 insertions(+), 19 deletions(-)
>
> --
> 2.25.1
>
