Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC17486F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344483AbiAGAtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbiAGAtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:49:46 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F3C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:49:45 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x6so5161717iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJcSInqpfPU6bE6yiy9usTY1S88S5qox1awnErqC6mA=;
        b=J+sn/Rt5tV/i7W+5GNQyDfgnvURa3oaDBPDYDx6r16CTCV2ZnbDiyWKKFTVm8sM3uS
         iILM1H1DJUvw9MuRVWtDnRthXmEyF505xWjHMjbHwcoek2o1YXmCA9mzF0Z+GXKSWOYL
         t6rffkhd6DVbti1WN0s6crULf1f0kCww2JZDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJcSInqpfPU6bE6yiy9usTY1S88S5qox1awnErqC6mA=;
        b=3YkFburqHRVKuh9iMLrNe7hnZR5RFEJKGHJfl+LYM+d14ORVLSHzgjVihvOqRmKBBf
         kkqukzMCNfVRsckqRcfNRgHbqdK7XZaeCnmYAVoHdXWYMmoZ0+pfn9fHHnTSY5/BKl+Z
         bBPEUlK9li0vGUMIdqu7tKrgo3mFi5nrqvaCummyVX3cM+8zjolJksD5AMq7XClyajfV
         Zh7uJJZC2UoBpZnf1SqHyQC5dtp++EZHSqJIH/XqSjeROz/I2Y7mwHgRmQ1huME0Q9sW
         9O3YOFzt5B6jjpiW/RS5gnjJxge1aBluAkMa6YrJH+XptLWYB9ZNfAqmaXe5sQfDRAiG
         VPYg==
X-Gm-Message-State: AOAM530Rg0PCD2QdlCTiOydU3uQHz0k0SnWzeQHhaBajbmbWlEaU/cp5
        IcROLViQd7xpnZ7uVN+0UKkYHtv2SQQpSA==
X-Google-Smtp-Source: ABdhPJyu7DEbBbEXH5EgjKDe5l6OqCbPmlFOpBPk6zDKdQ2t5yWrQHDxv5FA1tSIH4Mr5hsov1JmwQ==
X-Received: by 2002:a02:c819:: with SMTP id p25mr27754595jao.8.1641516585122;
        Thu, 06 Jan 2022 16:49:45 -0800 (PST)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id e14sm2042176iov.2.2022.01.06.16.49.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 16:49:44 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id x15so3420446ilc.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:49:44 -0800 (PST)
X-Received: by 2002:a05:6e02:20e6:: with SMTP id q6mr29686099ilv.180.1641516584417;
 Thu, 06 Jan 2022 16:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20211216044529.733652-1-swboyd@chromium.org>
In-Reply-To: <20211216044529.733652-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jan 2022 16:49:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X4a5oRQSpg2fp-++EEpK_d0UfybJTdEq9DbpeWkd+3zQ@mail.gmail.com>
Message-ID: <CAD=FV=X4a5oRQSpg2fp-++EEpK_d0UfybJTdEq9DbpeWkd+3zQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sc7180: Add board regulators for MIPI
 camera trogdor boards
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 15, 2021 at 8:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some trogdor boards have on-board regulators for the MIPI camera
> components. Add nodes describing these regulators so boards with these
> supplies can consume them.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1 (https://lore.kernel.org/r/20211215003639.386460-1-swboyd@chromium.org):
>  * Swapped order of regulators
>
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  16 +++
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  16 +++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 122 ++++++++++++++++++
>  3 files changed, 154 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
