Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07348EC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbiANPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiANPC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:02:27 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B66C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:02:27 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w7so7481626ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qXmWJM7AitTzyfPdJ7f2a2IELs5fKAyQOT62zGNQEA=;
        b=KEzLL5otmJNDuAGXX487uGO0DfjH0nOBNmeYp2V6fswnSiKmL+hH/P+MyN+0virk7Y
         /kTk1+e/V5jj+E4TUZS+Y0rhtPCTVQEMemEaTGCqhKSr67KCem7D9vwXBWnijISaFUyD
         jm3TGUxQkXR9v45xAbZPrMF0IieBo2LyItOL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qXmWJM7AitTzyfPdJ7f2a2IELs5fKAyQOT62zGNQEA=;
        b=emr0KF0Q/CAFRNtnyYU3k68hZRKl0zSHaktrrew+Onlma9tvbqmFsSZypawGNr8BEx
         V03qJL+GGJdLymr7CwP0IYo1bYRWJbY9By3owK187eUp9M3qkDvgwmb5Lshx01g5kQIH
         E+qpVa7N8g18tkwRCa+F+3TpPSmOHaCjK8hTF+Z6YYr/1oAztkGwhjs721ZNyHwqy3+d
         IZgWFZFjNUCC3CvMe/hfc7DjIGFOdqkRMzqfr4PqMbJaR8TCU3WOtENX/gfB7s89P0y8
         7jlsRH0cGoCvjfCTwCgtu3qA3R8SGlS1ikJirrmWuMlPpoDX7/4mTt/i6PvQ5p/Ir94o
         rmvQ==
X-Gm-Message-State: AOAM530xtdAZQkOVCqETkFzPkewiVksqTwFTdrHYb+gbfIzSF7nUbDmy
        KW534Gut7XL46lWKnoTSx2mxCDRwkAGjzA==
X-Google-Smtp-Source: ABdhPJyfDezmKeXKWVsmy0ZNvDz7pLpnfHp8DejGkSD4MX74puV2HOoJUKo2Xm+4sKptMoZa0YxAhw==
X-Received: by 2002:a05:6638:338c:: with SMTP id h12mr4480797jav.34.1642172546239;
        Fri, 14 Jan 2022 07:02:26 -0800 (PST)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id w19sm5270264iov.12.2022.01.14.07.02.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 07:02:25 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id d3so8547511ilr.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:02:25 -0800 (PST)
X-Received: by 2002:a05:6e02:20e6:: with SMTP id q6mr5046887ilv.180.1642172544974;
 Fri, 14 Jan 2022 07:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20220114004303.905808-1-dianders@chromium.org>
 <20220113164233.1.I19f60014e9be4b9dda4d66b5d56ef3d9600b6e10@changeid> <CAE-0n50N=vFC3wpPh7O6eqWMNyT8n-Q0ssU+CkgJH2DY7T6SoQ@mail.gmail.com>
In-Reply-To: <CAE-0n50N=vFC3wpPh7O6eqWMNyT8n-Q0ssU+CkgJH2DY7T6SoQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Jan 2022 07:02:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+-fdM6M586HhnHiK9Ls-t4GxxmsbCPU0gX85bZeRG_Q@mail.gmail.com>
Message-ID: <CAD=FV=V+-fdM6M586HhnHiK9Ls-t4GxxmsbCPU0gX85bZeRG_Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7280: Fix gmu unit address
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        quic_rjendra@quicinc.com, Sibi Sankar <sibis@codeaurora.org>,
        kgodara1@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 13, 2022 at 10:08 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2022-01-13 16:43:00)
> > When processing sc7280 device trees, I can see:
> >
> >   Warning (simple_bus_reg): /soc@0/gmu@3d69000:
> >     simple-bus unit address format error, expected "3d6a000"
> >
> > There's a clear typo in the node name. Fix it.
> >
> > Fixes: 96c471970b7b ("arm64: dts: qcom: sc7280: Add gpu support")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Thanks for all the reviews!


> BTW, gmu isn't a "standard" node name so might be worth replacing that
> with something else but I have no idea what. Maybe "firmware" or
> "power-controller"?

"gmu" matches what's in the "example" in
Documentation/devicetree/bindings/display/msm/gmu.yaml. That was
blessed by Rob Herring. If you think it should be something different,
perhaps post a patch changing the example in the bindings?

-Doug
