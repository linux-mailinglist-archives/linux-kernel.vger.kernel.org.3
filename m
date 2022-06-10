Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236B4546F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350849AbiFJVMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350848AbiFJVMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:12:34 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0549B5A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:12:32 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-fe15832ce5so727052fac.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=eUw90MQM5SVuieh3UI6r6+Ffszit+OiITVtSMahiOlI=;
        b=PxZoMFPohd1GKquX3Z0yebjsbyodzL6Sc1YYSADroQz8Hm2TevBoKncjyGg2shlJqe
         Kt2jvBqIz83qvGPjgsU19YaG+D6Qom/vhBlROqhNcOjp5nqnRXCUN8z8ysEHYUNHZvP4
         ZY+0oNzWQLIQsNhMs6YyFQqnji2XBG4+NKb/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=eUw90MQM5SVuieh3UI6r6+Ffszit+OiITVtSMahiOlI=;
        b=1vJQStNXWdJE4I0QRn29KQ1waPJ7d8hZhvTkbfZI2XRMtoOZCweBPpuumEub91N+y8
         xGtKik1arzfHAFO4lnbMXbi9kJwge7wJgvMrueKn3FDhx9p1pFNSIjkdeFXXMtDK01sC
         mSZeq01v8yKNeGncxZju/C1zR6hsNFsCyNxDIpWQdgiDDPaDkWsFRP4Gl2r8QBkJBMLq
         ZE3ZGUc/wwYQyRvv6p09hK1Vuku859k0iWJ0WoJ/MRqG3NWsBoTc0NsUczh0h8S7CeqY
         Zq1g9xnW3YYL/zpwW9apMqXvedKzNjXzUxE8tDRBTeGU+FdKOyhAZPMUlDkt5wPMMhxK
         qKvg==
X-Gm-Message-State: AOAM533KrxvW2FyPZJUOlZkJCCVejtjieKaQPh0Uj8AjRTiGq0xQEaUt
        Vfmik+VpuYM8TyviblS7XSgWpmB3RiIQQH1BpKj//w==
X-Google-Smtp-Source: ABdhPJxFZZJBT4zmQa9rbL6oi07IG1L075UxWAqyTprFlgGRMHH3fCtuJiv9mMe6loLyhtjcJqcBOdO2wSQrhVr5se8=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr895829oap.193.1654895551998; Fri, 10
 Jun 2022 14:12:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jun 2022 14:12:31 -0700
MIME-Version: 1.0
In-Reply-To: <1654538139-7450-1-git-send-email-quic_khsieh@quicinc.com>
References: <1654538139-7450-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 10 Jun 2022 14:12:31 -0700
Message-ID: <CAE-0n51hjNTcy5xpPknrtP3897qZkVqf9ksObxRF4v0Ej0=qag@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: check core_initialized before disable
 interrupts at dp_display_unbind()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-06-06 10:55:39)
> During msm initialize phase, dp_display_unbind() will be called to undo
> initializations had been done by dp_display_bind() previously if there is
> error happen at msm_drm_bind. In this case, core_initialized flag had to
> be check to make sure clocks is on before update DP controller register
> to disable HPD interrupts. Otherwise system will crash due to below NOC
> fatal error.
>
> QTISECLIB [01f01a7ad]CNOC2 ERROR: ERRLOG0_LOW = 0x00061007
> QTISECLIB [01f01a7ad]GEM_NOC ERROR: ERRLOG0_LOW = 0x00001007
> QTISECLIB [01f0371a0]CNOC2 ERROR: ERRLOG0_HIGH = 0x00000003
> QTISECLIB [01f055297]GEM_NOC ERROR: ERRLOG0_HIGH = 0x00000003
> QTISECLIB [01f072beb]CNOC2 ERROR: ERRLOG1_LOW = 0x00000024
> QTISECLIB [01f0914b8]GEM_NOC ERROR: ERRLOG1_LOW = 0x00000042
> QTISECLIB [01f0ae639]CNOC2 ERROR: ERRLOG1_HIGH = 0x00004002
> QTISECLIB [01f0cc73f]GEM_NOC ERROR: ERRLOG1_HIGH = 0x00004002
> QTISECLIB [01f0ea092]CNOC2 ERROR: ERRLOG2_LOW = 0x0009020c
> QTISECLIB [01f10895f]GEM_NOC ERROR: ERRLOG2_LOW = 0x0ae9020c
> QTISECLIB [01f125ae1]CNOC2 ERROR: ERRLOG2_HIGH = 0x00000000
> QTISECLIB [01f143be7]GEM_NOC ERROR: ERRLOG2_HIGH = 0x00000000
> QTISECLIB [01f16153a]CNOC2 ERROR: ERRLOG3_LOW = 0x00000000
> QTISECLIB [01f17fe07]GEM_NOC ERROR: ERRLOG3_LOW = 0x00000000
> QTISECLIB [01f19cf89]CNOC2 ERROR: ERRLOG3_HIGH = 0x00000000
> QTISECLIB [01f1bb08e]GEM_NOC ERROR: ERRLOG3_HIGH = 0x00000000
> QTISECLIB [01f1d8a31]CNOC2 ERROR: SBM1 FAULTINSTATUS0_LOW = 0x00000002
> QTISECLIB [01f1f72a4]GEM_NOC ERROR: SBM0 FAULTINSTATUS0_LOW = 0x00000001
> QTISECLIB [01f21a217]CNOC3 ERROR: ERRLOG0_LOW = 0x00000006
> QTISECLIB [01f23dfd3]NOC error fatal

Don't think this pile of lines really helps anyone, but OK.

>
> changes in v2:
> -- drop the first patch (drm/msm: enable msm irq after all initializations are done successfully at msm_drm_init()) since the problem had been fixed by other patch
>
> Fixes: a65c95ff88f2 ("drm/msm/dp: stop event kernel thread when DP unbind")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
