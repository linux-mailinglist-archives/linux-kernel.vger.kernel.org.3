Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDBE4ACD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbiBHBIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiBHAS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:18:57 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C1BC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:18:56 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id h7so19156189iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vScBC3jkunPuKV71bwmpHxOhrGxKlBbuYe/cqBu7qF8=;
        b=TV/KEXy0SdalYrBG9vcyQo4ANXKRqQZpfsevkQCRvDDS3QkNqsAVFK3CiXgrn7BhEC
         lQZP1zue6xcSxErPJDsPnbnJ7NzZaPCUltMJoeN9SGtNIMM3tb2qVUWD6hCx2/5gvyQb
         4WVzprlonmdeJ8JUjSQiAOvjj5o67UrS7+Dfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vScBC3jkunPuKV71bwmpHxOhrGxKlBbuYe/cqBu7qF8=;
        b=KIgpeQsoiG9qgIgfLjL01zo1uBCzCoN8syQQ1boEa+lFz+YSu6lU7QS/mNZDSpZdlP
         YLk7dqz0TPSg8qWAgBgi8c9o6XmUuQv2p8GcZ4Ke3uOvNVnAcU5ClCTjJO/DF4xHyiQa
         D+pbvxYbDc9SS7SeRhPocKp50P2I3BJyXOdeh143zAOAjNcbbzonGj4V+lC8ie+Or33D
         /dbK6m1waZoJ+YNNUfXKnWG9OXv9yJJUqHry1PjylfNSvKmuCbFgovomd2GFJBHbylyA
         fWj9kCw5YntrM0TeNXWhzJDy+TAXZpclz7hNL0yhb2yQzJpJvs+2cwl54g1dPMirTugm
         m5Kw==
X-Gm-Message-State: AOAM532qPV485FoC/GCkWs9LBT7VadQhXgo8wq6FMsKWeNwyW1l/ueSt
        XPxRHGAWADZX6ET8kBR8JrV8Mu0o6PVE2g==
X-Google-Smtp-Source: ABdhPJynvvnCw6C3BBnpWlHgOnKRayUI93h2fc4k9wcZU9iNvQl0j9cysrP5tFPGOq9fUKU6dQnUkQ==
X-Received: by 2002:a6b:ef06:: with SMTP id k6mr915591ioh.70.1644279535910;
        Mon, 07 Feb 2022 16:18:55 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id l12sm6932654iow.48.2022.02.07.16.18.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 16:18:54 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id d188so19147847iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:18:54 -0800 (PST)
X-Received: by 2002:a05:6638:168d:: with SMTP id f13mr980261jat.44.1644279533953;
 Mon, 07 Feb 2022 16:18:53 -0800 (PST)
MIME-Version: 1.0
References: <1637046458-20607-1-git-send-email-quic_sbillaka@quicinc.com> <CAE-0n50sONq+URcWwvDH=UPshgy6+XZEB3sK_4n+5jNktHsEhg@mail.gmail.com>
In-Reply-To: <CAE-0n50sONq+URcWwvDH=UPshgy6+XZEB3sK_4n+5jNktHsEhg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Feb 2022 16:18:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VwrO9fpOtpjrsbjkmucvL6NbHMc3jLtjsiRJD6aG0Hkg@mail.gmail.com>
Message-ID: <CAD=FV=VwrO9fpOtpjrsbjkmucvL6NbHMc3jLtjsiRJD6aG0Hkg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add support for eDP PHY on SC7280 platform
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>, quic_kalyant@quicinc.com,
        quic_abhinavk@quicinc.com, quic_khsieh@quicinc.com,
        quic_mkrishn@quicinc.com, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 2, 2022 at 1:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Sankeerth Billakanti (2021-11-15 23:07:35)
> > This series adds support for the eDP PHY on Qualcomm SC7280 platform.
> > The changes are dependent on v4 of the new eDP PHY driver introduced by Bjorn:
> > https://patchwork.kernel.org/project/linux-arm-msm/list/?series=575135
> >
> > Sankeerth Billakanti (3):
> >   dt-bindings: phy: Add eDP PHY compatible for sc7280
> >   phy: qcom: Add support for eDP PHY on sc7280
> >   phy: qcom: Program SSC only if supported by sink
>
> This series was sent to the wrong maintainers. It's in the phy
> framework, not the drm framework. Please use scripts/get_maintainers.pl
> to find the right email addresses and send this series again.

To help out, I've re-posted this myself, hopefully getting all the
correct maintainers.

https://lore.kernel.org/r/20220208001704.367069-1-dianders@chromium.org
