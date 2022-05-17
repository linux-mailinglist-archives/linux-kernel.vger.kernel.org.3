Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64D529E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiEQJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245256AbiEQJnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:43:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57264666E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:42:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id en5so7524918edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siNpk3iy/2AiI/CebguH+obcJ5iL3RxgB8kelVAB/A0=;
        b=flcjJKUCXVDcDKfZLAcf2dTd/cE3yhkSrMqpLMEF4zqyodwEXUgqoRvuiKCZ+Dbdou
         7QJVvCa6zEiBzarwRA+ZZzLhQ8RDLmCnqWXyL+r9hGEUstMGB6k6LX4l6/cemQnxgNf/
         cVPJIXcyu814uTKjvXTRGR+kI4MOoOSWZk+PfZ2LRucLvoAYm1LakeYeJ1lSyvSkFeR4
         6EIJUdmQicJInp5VQZF8kX7XQBRg2InnYnVTarcPFAv3/H03PE+uqmZLPgSIaUwYS5OX
         7mYHqZm71VMB9ta16A87RyzplT+snNiJHs07Yc7INs+yu2Gv+Aaq/Y8GuDlNXbCR9U0l
         S1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siNpk3iy/2AiI/CebguH+obcJ5iL3RxgB8kelVAB/A0=;
        b=TT8CJoyBRgwq2FlK1qWZZVlFIuNoJjnE8DiHCc03NZ5rGHRYGi+jA62L3ltcfxkF0G
         WuY6OuNUCifYmop8gkWURphYjbJOPEq2EbmV5mipPTFOv65QTkbBDtnuy9Lu1cTD2mHl
         77LyiHvJf9UcHzDJ+Fuu0fqQ78q5Qp2vdUqtiP+DPsJCVhkklhyeZnguNiLafrJs/RrP
         1YuPUQDKSpvpB+D1qup7ddbwIB+DnPwXhE7nUS93SUayky1/6rWG44DQBDpR1xrMVQM2
         2MGg3xnLEty4NAMMKRuDI1QIhPrtV5HoP9odKlwuuiczpik5UuFD3hr+3Ky8lXLa6ctS
         23zQ==
X-Gm-Message-State: AOAM5314zFVK4dxE2+29kSAZBkMTL98FKGnU1Gx6duCo16d/rknLbSV2
        qYJ74w+r5t3TA3ip9W05+lP9vxi79T4Z43gD3/XTZw==
X-Google-Smtp-Source: ABdhPJyQwTl6/5xSRooPjamNgZDctgSI/lL5Ultsn4da+PPMTic/fwusW8sjtz1w8bZjOtUGY7FX64a+XwYtJqlE908=
X-Received: by 2002:a05:6402:509:b0:42a:b6c9:eac with SMTP id
 m9-20020a056402050900b0042ab6c90eacmr7750279edv.225.1652780527711; Tue, 17
 May 2022 02:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220323034405.976643-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220323034405.976643-1-peng.fan@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 17 May 2022 10:41:56 +0100
Message-ID: <CANLsYkx089h16omSwAuteQz4RX9BMgT4_gWg9OqggqXk6m2-rw@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] remoteproc: support self recovery
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com
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

On Wed, 23 Mar 2022 at 03:42, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V4:
>   Based on Bjorn's comments on V2-2
>   Move the rproc_has_feature/rproc_set_feature to remoteproc_internal.h and
>  Keep rproc_features still in remoteproc.h, because we use
>  RPROC_MAX_FEATURES to declare bitmap.
>   Update commit log for patch 2/2, and add comments

I have received your patches but there is a significant backlog to go
through before I can take a look at them.

Thanks,
Mathieu

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
>
> Peng Fan (2):
>   remoteproc: introduce rproc features
>   remoteproc: support attach recovery after rproc crash
>
>  drivers/remoteproc/remoteproc_core.c     | 67 +++++++++++++++++-------
>  drivers/remoteproc/remoteproc_internal.h | 10 ++++
>  include/linux/remoteproc.h               |  7 +++
>  3 files changed, 65 insertions(+), 19 deletions(-)
>
> --
> 2.25.1
>
