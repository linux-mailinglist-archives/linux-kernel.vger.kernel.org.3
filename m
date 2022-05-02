Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E420517866
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381665AbiEBUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiEBUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:45:58 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9BEB6F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:42:28 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-e9027efe6aso15382241fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ESpzyDqu8mnBm9LDtK8B5iICXfFMCWHMbvYXNK4D6ws=;
        b=CHoiCdCU1i8vWiRKm0fwWD99JiWNrErUMwha0a5VBppTDfBnUn2/opeuaRT1wE2RaS
         rSm/E1G6cgHlFacYHPjeuMbR5jcDr6+0jG1f2Dct3f1cS5/6TuefgaMl5w8Nt2XOSyye
         u+AsxKM/XZ9HWjJWyBEFDuWz8i/KQC2Pf44XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ESpzyDqu8mnBm9LDtK8B5iICXfFMCWHMbvYXNK4D6ws=;
        b=xi53IKkm/PuXiugiH1hO/zYWyVFgkrCbI3hB5NSSoeeXWNTCbwkGbyOS8jd8WjXA17
         dLnp8D5yBZEFEPGIpN4dkYsl6qhCJFEdU5XNCYc/JLQ+6BxfiqQigXpiuSs44YYUNAyr
         MVNgYwfNQcOzYdn5pFILyRHmYm/tjw4Qzk2ugy+q2P2Z5a/CKlbu0GZcrfnZ6ja1vY7k
         cItvS1De0CRkhEodH0LoBaua/zOJRDg6iB8163kUURtCmEQjLG4rTMXORwwmH6f9s8Zt
         yo+fbPlnH9PdxYwNK88Qux++YbasKqIeKHariPYFt0SsN9P02xoN32+0SO+rw04hrnVk
         lqiw==
X-Gm-Message-State: AOAM5326wJXILAjl9oJZcrwW0xrjQ95RkLOBRLZxNxBzlKJr3EP4vpa4
        cD+t55euGAj9v1+U8pQ7Z6vcg4zfD62vbSbm6WzeQA==
X-Google-Smtp-Source: ABdhPJyfSz0qIavKIY7/72y/6OLLmP5StcipFMQ6UuHm8uHovKIYZYl28pB2+rrNQkm8Rj+XIbcgGj4UB8blHvbLc3w=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr441978oao.63.1651524148228; Mon, 02 May
 2022 13:42:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 May 2022 13:42:27 -0700
MIME-Version: 1.0
In-Reply-To: <1651509846-4842-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1651509846-4842-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 2 May 2022 13:42:27 -0700
Message-ID: <CAE-0n517_5ZxGXMYrW7xGTOdKBhEnhEc9U1SN=cZP7CKCrdVhA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/disp/dpu1: avoid clearing hw interrupts if
 hw_intr is null during drm uninit
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org
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

Quoting Vinod Polimera (2022-05-02 09:44:06)
> If edp modeset init is failed due to panel being not ready and
> probe defers during drm bind, avoid clearing irqs and derefernce

s/derefernce/dereference/

> hw_intr when hw_intr is null.
>
> BUG: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>
> Call trace:
>  dpu_core_irq_uninstall+0x50/0xb0
>  dpu_irq_uninstall+0x18/0x24
>  msm_drm_uninit+0xd8/0x16c
>  msm_drm_bind+0x580/0x5fc
>  try_to_bring_up_master+0x168/0x1c0
>  __component_add+0xb4/0x178
>  component_add+0x1c/0x28
>  dp_display_probe+0x38c/0x400
>  platform_probe+0xb0/0xd0
>  really_probe+0xcc/0x2c8
>  __driver_probe_device+0xbc/0xe8
>  driver_probe_device+0x48/0xf0
>  __device_attach_driver+0xa0/0xc8
>  bus_for_each_drv+0x8c/0xd8
>  __device_attach+0xc4/0x150
>  device_initial_probe+0x1c/0x28
>
> Changes in V2:
> - Update commit message and coreect fixes tag.
>
> Fixes: f25f656608e3 ("drm/msm/dpu: merge struct dpu_irq into struct dpu_hw_intr")
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
