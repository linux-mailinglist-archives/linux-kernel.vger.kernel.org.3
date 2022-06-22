Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A6555536
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376964AbiFVUGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357409AbiFVUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:06:08 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4F53192F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:06:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-fe023ab520so23817939fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PdIR578qkfbKEcvQNXC0L2iYidYBiONlxgchRJAPFVg=;
        b=CWfpOsAP3+yAGVgEg7CaAGl7nTfhoFTeMo6tQpVxiVQcz+025TJlBQirRqTIKqM1+C
         awM/prI+3VNBTa4Hkd5qPpoaT7E/YfE25xzSpPRlw9JxiNRNa4uxk2qh9W25tGTj93UI
         AbRim75fKPiT3V43uX5d1ITQwVxlPHL2LuPuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PdIR578qkfbKEcvQNXC0L2iYidYBiONlxgchRJAPFVg=;
        b=iyGn9stvr8o0Rpc0A2G3EvtMv0G6R1clDlYyt1xPIyj+hqLiPviN1wpKpZChIJYUft
         u5QBVv6b7hssI6XpJYs5cRh2pcWD9D2f169XXwXRHuQY+jQQ7osBXWJGhtCbCUeMtVno
         RalHsZlMeTB1xs5c2an1k2vEzSbtfTmmrX7gMO1YblpqNh2g9VJ4/vBaP/A27G6YdoRM
         9RePTqGy97vZYZixU4H4KY6md5xoISHbUUkAUmb91/ojAmru/quHmjTV51AVOwvUVEl3
         FqnzTZQVyAecvHXqEHph03ekstwZZWY/tD3Qxb7osL0CC4k0OMZZmq5L+sunnm8lESJT
         KnpQ==
X-Gm-Message-State: AJIora96lzRlxVv090CpvkqVnJIwp9uUTAYm92l6bJ/Y0wGE3zSSPfHV
        LbUHtfBPARsnp/hy/36pJs2HQ1GTWzRHGy0kofDUvA==
X-Google-Smtp-Source: AGRyM1t44NdWATjICNmPxtuR1+UpcCvkiOmc6pskgeLN9hxebiN1yqBMmXk2WwhGES/Sa+F/HtJydS6rBvsU8+Ut28Y=
X-Received: by 2002:a05:6870:b381:b0:fe:2004:b3b5 with SMTP id
 w1-20020a056870b38100b000fe2004b3b5mr54701oap.63.1655928363679; Wed, 22 Jun
 2022 13:06:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jun 2022 16:06:03 -0400
MIME-Version: 1.0
In-Reply-To: <1655927731-22396-1-git-send-email-quic_khsieh@quicinc.com>
References: <1655927731-22396-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 22 Jun 2022 16:06:03 -0400
Message-ID: <CAE-0n51jSuSyuw7RQqco6nEhhJHND5_9e4kNggJDnQAq8CoPug@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: reset drm_dev to NULL at dp_display_unbind()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-06-22 12:55:31)
> During msm initialize phase, dp_display_unbind() will be called to undo
> initializations had been done by dp_display_bind() previously if there is
> error happen at msm_drm_bind. Under this kind of circumstance, drm_device
> may not be populated completed which causes system crash at drm_dev_dbg().
> This patch reset drm_dev to NULL so that following drm_dev_dbg() will not
> refer to any internal fields of drm_device to prevent system from crashing.
> Below are panic stack trace,
>
> [   53.584904] Unable to handle kernel paging request at virtual address 0000000070018001
> .
> [   53.702212] Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
> [   53.710445] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   53.717596] pc : string_nocheck+0x1c/0x64
> [   53.721738] lr : string+0x54/0x60
> [   53.725162] sp : ffffffc013d6b650
> [   53.728590] pmr_save: 000000e0
> [   53.731743] x29: ffffffc013d6b650 x28: 0000000000000002 x27: 0000000000ffffff
> [   53.739083] x26: ffffffc013d6b710 x25: ffffffd07a066ae0 x24: ffffffd07a419f97
> [   53.746420] x23: ffffffd07a419f99 x22: ffffff81fef360d4 x21: ffffff81fef364d4
> [   53.753760] x20: ffffffc013d6b6f8 x19: ffffffd07a06683c x18: 0000000000000000
> [   53.761093] x17: 4020386678302f30 x16: 00000000000000b0 x15: ffffffd0797523c8
> [   53.768429] x14: 0000000000000004 x13: ffff0000ffffff00 x12: ffffffd07a066b2c
> [   53.775780] x11: 0000000000000000 x10: 000000000000013c x9 : 0000000000000000
> [   53.783117] x8 : ffffff81fef364d4 x7 : 0000000000000000 x6 : 0000000000000000
> [   53.790445] x5 : 0000000000000000 x4 : ffff0a00ffffff04 x3 : ffff0a00ffffff04
> [   53.797783] x2 : 0000000070018001 x1 : ffffffffffffffff x0 : ffffff81fef360d4
> [   53.805136] Call trace:
> [   53.807667]  string_nocheck+0x1c/0x64
> [   53.811439]  string+0x54/0x60
> [   53.814498]  vsnprintf+0x374/0x53c
> [   53.818009]  pointer+0x3dc/0x40c
> [   53.821340]  vsnprintf+0x398/0x53c
> [   53.824854]  vscnprintf+0x3c/0x88
> [   53.828274]  __trace_array_vprintk+0xcc/0x2d4
> [   53.832768]  trace_array_printk+0x8c/0xb4
> [   53.836900]  drm_trace_printf+0x74/0x9c
> [   53.840875]  drm_dev_dbg+0xfc/0x1b8
> [   53.844480]  dp_pm_suspend+0x70/0xf8
> [   53.848164]  dpm_run_callback+0x60/0x1a0
> [   53.852222]  __device_suspend+0x304/0x3f4
> [   53.856363]  dpm_suspend+0xf8/0x3a8
> [   53.859959]  dpm_suspend_start+0x8c/0xc0
>
> Fixes: a65c95ff88f2 ("drm/msm/dp: stop event kernel thread when DP unbind")

Commit doesn't exist. I guess it's

Fixes: 570d3e5d28db ("drm/msm/dp: stop event kernel thread when DP unbind")
