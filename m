Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B114CC938
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiCCWjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiCCWjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:39:02 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607F11201BE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:38:16 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so13760132ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ST9Fc76g6pvjQi4fhR+noZ4Seq3datbHBQS0X9jUxZ8=;
        b=FrOz5ub3zWjEQK22ZLwg3u+vEvcmxk5pcWahe3+zoJFfvsvs0UQBjv/AElEkUlyAw9
         EePN55pYYRl4RbnXJxniWi54yJRwLRFnUpNNgmipiWdmEHy76MIi5bA6dIIROOGw5+9j
         DlrsvRRt7Ab5hlgGMIvKwZMS89rVmz14yqa6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ST9Fc76g6pvjQi4fhR+noZ4Seq3datbHBQS0X9jUxZ8=;
        b=qTF6IfdOKAkhZ5xQBUtMShgNrV4FstiJIY9dri0WizYV0403vqcSHGpdhlbGYicQqj
         S4jHKqTyaQGHwzLRM1gZXyLrSStI8MAnm5mB2gEL12MlbOXhjhmR6iIhdenL1p3KxDBp
         h1NRnJpRFklJfe0JxkNBFyH1yxrbugIcKLeCMq5TWTCyU+yBXnurw6j5zkCh+yn+c7qv
         68PwT7vvJJFaoESTgNePHp9I8QozgozMlGVFppfO5THSRBX25nx6wpEAH7SiNgGBhbV8
         WzwG6s6Q7FSaPm8DI8j/qhFqF7LiGwC+FDeR1YA28K6mXrQYUH/kzzrY/NbGYYCJVlK0
         YbNQ==
X-Gm-Message-State: AOAM533MUZrzQC5oOJiVdhnBr4ni/P/+8sMHg1lVME4n0AXR4DgQtkcK
        xy1fE+Zm8ryIXxPPmVDTY9jLGZ2RURJnew==
X-Google-Smtp-Source: ABdhPJzi1kDeuCaXSsZr+KRZYxEUgC9NoeyIe1bEQjxdXw5xbz4Us0wzeJF5XpApUrcU0kluezYkaw==
X-Received: by 2002:a17:906:52c7:b0:6ce:a880:50a3 with SMTP id w7-20020a17090652c700b006cea88050a3mr28407702ejn.437.1646347094495;
        Thu, 03 Mar 2022 14:38:14 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b00415a1f9a4dasm1370944edv.91.2022.03.03.14.38.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 14:38:13 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso4109323wmr.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:38:13 -0800 (PST)
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id
 s1-20020a7bc381000000b0037be01fc1c0mr5453850wmj.98.1646347092922; Thu, 03 Mar
 2022 14:38:12 -0800 (PST)
MIME-Version: 1.0
References: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com> <1646300401-9063-2-git-send-email-quic_vpolimer@quicinc.com>
In-Reply-To: <1646300401-9063-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Mar 2022 14:38:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VHBn0H6Oz0F3vHrXZzSSo8y+QbLc-xn+CVVSQkommsHw@mail.gmail.com>
Message-ID: <CAD=FV=VHBn0H6Oz0F3vHrXZzSSo8y+QbLc-xn+CVVSQkommsHw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] arm64/dts/qcom/sc7280: remove assigned-clock-rate
 property for mdp clk
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 3, 2022 at 1:40 AM Vinod Polimera <quic_vpolimer@quicinc.com> wrote:
>
> Kernel clock driver assumes that initial rate is the
> max rate for that clock and was not allowing it to scale
> beyond the assigned clock value.
>
> Drop the assigned clock rate property and vote on the mdp clock as per
> calculated value during the usecase.

I see the "Drop the assigned clock rate property" part, but where is
the "and vote on the mdp clock" part? Did it already land or
something? I definitely see that commit 5752c921d267 ("drm/msm/dpu:
simplify clocks handling") changed a bunch of this but it looks like
dpu_core_perf_init() still sets "max_core_clk_rate" to whatever the
clock was at bootup. I assume you need to modify that function to call
into the OPP layer to find the max frequency?


> Changes in v2:
> - Remove assigned-clock-rate property and set mdp clk during resume sequence.
> - Add fixes tag.
>
> Changes in v3:
> - Remove extra line after fixes tag.(Stephen Boyd)
>
> Fixes: 62fbdce91("arm64: dts: qcom: sc7280: add display dt nodes")

Having a "Fixes" is good, but presumably you need a code change along
with this, right? Otherwise if someone picks this back to stable then
they'll end up breaking, right? We need to tag / note that _somehow_.
