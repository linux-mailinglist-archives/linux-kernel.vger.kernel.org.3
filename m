Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD11495253
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377000AbiATQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346917AbiATQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:26:49 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69762C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:26:49 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v17so5439398ilg.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiyQLWG80mstT5YpAPWl94SZ6aP1HBrogLLQBpAX1RY=;
        b=TCpLRXFBUmF+X5S4H5np0qUSumViPSruH+u/jcLvA+9VpSmaQT1bY+QQ1G3XbbFOoy
         QH6BFyaIfmIcUyMifW2b/+3pNNsJ98S1jtrqA1tzveG5wwpAmPAthLkHg8O1E2TkKem+
         PTz6c7hAangKEg6AQ8dFTi0kbbjkF6pnKSV3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiyQLWG80mstT5YpAPWl94SZ6aP1HBrogLLQBpAX1RY=;
        b=lD05vj99W7BmJpScX7CZh71HPXLp2E+jfCpEall9iuvfPhB0uWujcHVusArk6/5mhE
         iLbWRfxdefVCF+vjgmNoRLkMS2FNYYIJWjYZCc6S2Qfb6h85h+fL8b9LBjkTWYu8p7vX
         AtunDkWmaKCq1tMacmwIGvijCPK2v4B+KTk6CjKH/zPm2UunxQG9ZeS5LWx9wr9KI2bo
         TcIH5N+I4fsZ2qbgM793IPewy3l0B02oP+RxXiy4zGM0Gcoghg/qpNc8mErT5v5y7VYU
         WvHIao19pYd6QWLAiMBCHbmeQhZ2YwbmqfDGVCy3XMfUGLJ84wT1t/nADuHI/FB2dVsR
         4Ocg==
X-Gm-Message-State: AOAM532BsaJcTleTwyoSHJb0VI4foyrCWEEwdGpEHF8ztSTUdr3s66Mk
        zdu/sogZmoTbdtmZc8Q/BU1aa6MI4W3QqA==
X-Google-Smtp-Source: ABdhPJzs3EQrylhs0x4WFbNdY3Jjb9zkklq5rNiTU8cdHkX3ekcChXrHT1/16gnOQ7rxlEFpUC9ccQ==
X-Received: by 2002:a92:c9c8:: with SMTP id k8mr12324361ilq.2.1642696008773;
        Thu, 20 Jan 2022 08:26:48 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id l6sm1534309iln.16.2022.01.20.08.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:26:46 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id e79so7518080iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:26:46 -0800 (PST)
X-Received: by 2002:a6b:7314:: with SMTP id e20mr13900347ioh.177.1642696005981;
 Thu, 20 Jan 2022 08:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20220120064457.1.I337b8db7efaba8eb9c0ffd4da0d8c8133faf6f19@changeid>
In-Reply-To: <20220120064457.1.I337b8db7efaba8eb9c0ffd4da0d8c8133faf6f19@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Jan 2022 08:26:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VEes8afsYDFT2z=AGeEPGqm93VzqK03aojePe=phH1BA@mail.gmail.com>
Message-ID: <CAD=FV=VEes8afsYDFT2z=AGeEPGqm93VzqK03aojePe=phH1BA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: panel-edp: Add panels planned for sc7180-trogdor-pazquel
To:     Grace Mi <grace.mi@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 19, 2022 at 10:45 PM Grace Mi
<grace.mi@ecs.corp-partner.google.com> wrote:
>
> From: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
>
> We have added corresponding information:
>     [BOE]NV116WHM-N45 use delay_200_500_e50
>     [KDB]116N29-30NK-C007 use delay_200_500_e80_d50
>     [STA]2081116HHD028001-51D use delay_100_500_e200
> Add 3 panels & 2 delay.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> Signed-off-by: Grace Mi <grace.mi@ecs.corp-partner.google.com>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

This looks good to me. I'll plan on landing it in drm-misc-next
sometime next week unless there are objections.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
