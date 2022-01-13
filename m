Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EA848E157
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbiAMX7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiAMX7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:59:22 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE522C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:59:21 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e8so7057506ilm.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swIc/YWTqbGW2vcyyUIZkfdZFHgU9akpO8dYNy7F6xA=;
        b=EjkzCDcgo7ZyV4PO+uVAMn4JDhGaueEGmMc0OYkIWH9ILkxltTpF196jvdmKTwXb23
         zPjjQSH4wOpZI+g7y9bFKClM7qYSMvCWUjTpWBvOQC1nL1yR3g/W4TE6JfpBNqjHilgH
         /X/v4HdHgMmjH310RdfzAadJNFuKbntDv2xP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swIc/YWTqbGW2vcyyUIZkfdZFHgU9akpO8dYNy7F6xA=;
        b=NDjUpjmsibVG95crLFQmNxpvMThSqUsa/GMbUqfvolKhf8vCPoyFtbckxZW5N0ZXh6
         AhNEZh10/tNynBR3DLc6rgPYT9SdxEy06IVTRBuUTu+GhSqE0v6lM/+tEo6R7cMRK6E8
         NpFTBAddVjeP9EgBHvOcOkLqkvC/FnDUpHdwwJg70G94brujNeR5KpnFco8xDsWq9Cps
         9tsPa5DPQINMFxAFthW+9SznSJMdyfaUb6le+TsGiaFYiEQ5JISiu4J0v/RrcXN6QdPz
         k74cGiU9t3yqAyu564KANzNQ5HKWqRYzcZtfHyPA9QSawONbZP4pYLCplnLju8lZbIXW
         VQ2g==
X-Gm-Message-State: AOAM531W6ojyi/Fm1ETJihiTUKXDgAieGrjBymWYLjzz+XkFI3E4DX3R
        sipJIQJqQNpz6DREdaVkvUuyVxOAUbIBiQ==
X-Google-Smtp-Source: ABdhPJzDHLOSyOax1GhTgStxhLju0caF9rP0jVEniJyFKNs9csqCfSRTcFC7gIlTIxTjgf5RFBVa1A==
X-Received: by 2002:a05:6e02:1809:: with SMTP id a9mr3558019ilv.102.1642118361191;
        Thu, 13 Jan 2022 15:59:21 -0800 (PST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id e10sm3704557ilu.36.2022.01.13.15.59.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 15:59:19 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id z17so5065396ilm.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 15:59:17 -0800 (PST)
X-Received: by 2002:a92:c202:: with SMTP id j2mr3338009ilo.165.1642118357532;
 Thu, 13 Jan 2022 15:59:17 -0800 (PST)
MIME-Version: 1.0
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org> <164036941060.3935440.13095761506560620701.b4-ty@linaro.org>
In-Reply-To: <164036941060.3935440.13095761506560620701.b4-ty@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Jan 2022 15:59:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
Message-ID: <CAD=FV=Vdjw-6GytO=Rpt==OYbnrNon3pYQnrZtUT4vX11S6ykw@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
 IDP boards
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, rjliao@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        saluvala@codeaurora.org, LKML <linux-kernel@vger.kernel.org>,
        hbandi@codeaurora.org, BlueZ <linux-bluetooth@vger.kernel.org>,
        mcchou@chromium.org, hemantg@codeaurora.org,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 24, 2021 at 10:10 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed, 15 Dec 2021 22:36:03 +0530, Balakrishna Godavarthi wrote:
> > Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
> >
> >
>
> Applied, thanks!
>
> [1/1] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
>       commit: 3a89ff3087c03c2295250c07234efa75873c7b51

Just to confirm, this later got dropped, right? I don't see it in the
Qualcomm git tree, so presumably it'll land once the merge window
closes.

-Doug
