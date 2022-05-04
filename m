Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5247A51AD27
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377092AbiEDSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355283AbiEDSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:47:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42410659E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 11:44:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r8so2072268oib.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Krvi/HpwBHAesm89MfsfOEIVsDIyjC5WrgT/4s6KRVQ=;
        b=Oao9pys9XD8VYE1VlkOYBz1163LoVqK0zQTXLcgwltnMASr9kfj9/M4WPVNS3hAy7A
         X01TWIvf5m/gbtLzupZrqcJ7u1D7aKzJ2VgI4+xF1TS+ioPlz0/Be3OZU5VRk4tIzZN8
         lj+SykAlqKoIZtcW8FCGRyjQK8KNyIQujQAuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Krvi/HpwBHAesm89MfsfOEIVsDIyjC5WrgT/4s6KRVQ=;
        b=ZNuZRemExuWSV5TSVr6zS/vg3d2Fur9ko5DHSVa2KpIW3KTVzn0sbx33r6DFb1vZj4
         M6WZ4efNwJ4ng3uifcPqsPvzqRtdfMhtZ+wjaAoEeov0y5qFErIWnrke8AOxy2ljFU5z
         vW1fHGdqRvsVke14/eAUyDqRqv6HY3NJWzXNLZUWTZV0VEOr0DevP2SMCQXrBa6S/XKU
         pEMQT/SEBIkS8bcY/EGr51Qi0xruHxVnQcskBWTEL93AonCfk595Qzw2rDEi/qqPT18a
         RjFk7qCJl0GvUXlh7FP0IP5sc2M41/kJoKVShOTDp5irYrbskjDiowpRZHsFPuOUvkIm
         fv4Q==
X-Gm-Message-State: AOAM533nOn6HqTiYsADcPkI3rzRtSsRLNlf+j0iDFXeLRwBvWivbPvlZ
        sAaYVLNkX3Dl1ucFJ7R0UtLxB1oKtgcA3RBzC/oV3w==
X-Google-Smtp-Source: ABdhPJzN6Wlws2ejvXzwfKhDTAuq/vO3u/Y7SEw5cpP2kVU87jhPZQDlvf6Baumo+WHVMuuIUelVblPIYt8pNdViXkE=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr440284oif.63.1651689852377; Wed, 04 May
 2022 11:44:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 May 2022 14:44:11 -0400
MIME-Version: 1.0
In-Reply-To: <1651595136-24312-1-git-send-email-quic_khsieh@quicinc.com>
References: <1651595136-24312-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 4 May 2022 14:44:11 -0400
Message-ID: <CAE-0n50P4G1gwKmdzKR-ezHwmN3_BfBC5eWTC852oww75Zen6g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: fix event thread stuck in wait_event after kthread_stop()
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

Quoting Kuogee Hsieh (2022-05-03 09:25:36)
> Event thread supposed to exit from its while loop after kthread_stop().
> However there may has possibility that event thread is pending in the
> middle of wait_event due to condition checking never become true.
> To make sure event thread exit its loop after kthread_stop(), this
> patch OR kthread_should_stop() into wait_event's condition checking
> so that event thread will exit its loop after kernal_stop().
>
> Changes in v2:
> --  correct spelling error at commit title
>
> Changes in v3:
> -- remove unnecessary parenthesis
> -- while(1) to replace while (!kthread_should_stop())
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 570d3e5d28db ("drm/msm/dp: stop event kernel thread when DP unbind")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
