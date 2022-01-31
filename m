Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5E64A5123
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351170AbiAaVKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379468AbiAaVJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:09:36 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02A4C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:09:36 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e21-20020a9d0195000000b005a3cd7c1e09so7583729ote.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R2J1Ic99L4kJYedsJXrEgCrliQJoVvf0Uyk+RpIbJhY=;
        b=x3JUyezWAlIg+y5F+JzfMKEzkgG3ebuawRWuQqyDJKI8eF2tGaaqd8ju+tuF/rPdpZ
         c9k0eO42P3gj3+kUhBqopEeXOHZGc8qKBL4iL7645Wx3W7bxVfwDA549n+r/y0sDHAsy
         9xzNLpaRgDMEN81zZ3PgBpq1HeJssyD6sHp+54a8ubAtWcP6jcS5bz6hvO1kNDyXHgwi
         C1k+7z8Qp3ZFYNIWL87uu7J5rnGcl5r8rb01gmr6Jj8MHZDNf+AMZqzGgSazo98GJClT
         8lXZ7okU/H48WqrIYQS5br+Zdf/OeZKVHPJRweb31j+ZpVdyGw1N0LnweTAbsgXcTsHj
         NL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R2J1Ic99L4kJYedsJXrEgCrliQJoVvf0Uyk+RpIbJhY=;
        b=tByNFkywcq5prgP1bnZ7JwEZ6G+AtlxCFbsoVgi1WPLyhpjj9wPxolB88sMUF5rLg3
         YytUU71/ffC8BoJqgycPjXPQ5EBKJMN0YUvSNjshF+dTvFDJYyf252gMfYQia8fqrN45
         OAvWLV4wjMGTQH2leDaz98d+HyOQz5YGK5FAEsbCb/vb6Q2C/JYD94jtLC3f9DsLMxzH
         ZzpHskj1T9nC2+UDVzXrEySLGSi5LD0+iTFlOg8hgQtRC5I0REqwZPgAlybCcSE7YjsD
         wo88uS+akrxvZdRRphqelWWuOk4p57MmArQNcIluRRsVrUzOutW3GDICf5/YXUfKu3Jz
         096Q==
X-Gm-Message-State: AOAM533HYTihgXXMDYLkh+ansFaD39dE800Qx1c1ZpKSVhLzpiB4aykd
        azLJCs7cyc1X1Z6ek7wLdZLdsg==
X-Google-Smtp-Source: ABdhPJyVFD8oHW/uorkeLcojJx2NTLLfghdS2U03XJEiCrDFgMRXuzVtD7N2LRvDzdV4fP/NIBAhBA==
X-Received: by 2002:a9d:4d08:: with SMTP id n8mr12338398otf.16.1643663375866;
        Mon, 31 Jan 2022 13:09:35 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id d7sm8815529otf.66.2022.01.31.13.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:09:35 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:09:55 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, rjliao@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        saluvala@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        hbandi@codeaurora.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        hemantg@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on
 SC7280 IDP boards
Message-ID: <YfhQIyzBhvl6C0H+@ripper>
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
 <164036941060.3935440.13095761506560620701.b4-ty@linaro.org>
 <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
 <CABmPvSGOLRKX20WO21P_qvtvDo812QGDr4nYOWE04pjoSGDGcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABmPvSGOLRKX20WO21P_qvtvDo812QGDr4nYOWE04pjoSGDGcw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24 Jan 20:49 PST 2022, Miao-chen Chou wrote:

> Hi,
> 
> Following up on this patch, this patch didn't seem to land anywhere,
> what is the plan to land this?
> 

I picked it up after sending my 5.17 pull request, so it had to wait for
the merge window to close. So it's part of the 5.18 branch and hence
linux-next now. But please double check.


Note that the thank-you email included the commit hash before I rebased
the 5.18 tree onto v5.17-rc1, so the correct hash seems to be:

1ff6797c326b ("arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards")

Regards,
Bjorn

> Thanks,
> Miao
> 
> On Thu, Jan 13, 2022 at 3:59 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Dec 24, 2021 at 10:10 AM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Wed, 15 Dec 2021 22:36:03 +0530, Balakrishna Godavarthi wrote:
> > > > Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> > > >
> > > >
> > >
> > > Applied, thanks!
> > >
> > > [1/1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
> > >       commit: 3a89ff3087c03c2295250c07234efa75873c7b51
> >
> > Just to confirm, this later got dropped, right? I don't see it in the
> > Qualcomm git tree, so presumably it'll land once the merge window
> > closes.
> >
> > -Doug
