Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C221D4DDDAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiCRQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiCRQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:06:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340A31AA4AB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:04:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p15so4078407lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h9XApkTh3yQbDDhq/6o67U0IGlirspPaXa+h4Gwx90c=;
        b=Vor22BPyexcx+h6sp1SlZ+tF3gOqx4KPkyueUA1s4+LW7NL1ZhDA4oQHD7/xctnbG+
         ybJwiISlYTdrlsvreHvZxugizERaCpLfbEM6D+CDGPt4A0IBPy9FkrJlRd+HLvG9gwr6
         enw1Hc21PozvR4LftkA5Wx8DA7Yj7/rcSq3M09tejc5PPBw+Af3wX1AFVfgxFxmAMEko
         fbvB1OMSz5HW8MYt39LuhR0D2qRb+9ZTg8s3LmMXTuyivSJgbMfdDrkVOCCM98nK5dWC
         bxAd+2nvu22ZljSzouMGSiZ2d8xjzi+/57hZ5C0s9PBlZ0Ed3HsiqsG3HMXczfEsOcSx
         YM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h9XApkTh3yQbDDhq/6o67U0IGlirspPaXa+h4Gwx90c=;
        b=BxBv59L+ppsIGmJurzIpltGMEnBUF7n0ZQSrpAzeoVU8buRjjrxd0Op3wRnVrIIS3a
         PdvExZApPVYOvwL2VIGVyucAuiwjC/k/Fy9Pe4Sx1X0ox4E9WBpfVyZeOjqXHE0Nx31k
         MmstyJvT2+hZOTKpId1TWguHOvV8u9ltPyLCjE1xTF/WUhhXJNKj0d27BDSpgsx1x9Lt
         GkLTh9Iayf+Bkqw+LwZ+ztFW5yizN0sQwfMgWFDIPAHan0IeoVUYA1XXfTRadOCVrTkL
         X/ZxeAEJ6/mmagIBUtx/qPuSUwRzCsUCcI6MEAYu6Tsp6qYzIo6vRa40f4IQAr9pOy3B
         tFWQ==
X-Gm-Message-State: AOAM532vrGFuD9Aj0V3RrAmrnGqZW2E3RHkv1xzzz7ayfYd93g5RMWlR
        O8g/t/oN1TPU/w4GPqynG1lnocHso0N40ezLvuuO9Q==
X-Google-Smtp-Source: ABdhPJwxiK2YtfW7+H8OsuaWT5qsZaqMMTiHG2hIzD78hqXDB+ih4mNtdsQeWAtRPQqaL0H8y5tmvEsK28wLNs0jF/s=
X-Received: by 2002:a05:6512:690:b0:449:fb6b:cf74 with SMTP id
 t16-20020a056512069000b00449fb6bcf74mr4698589lfe.209.1647619441897; Fri, 18
 Mar 2022 09:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220318141441.32329-1-pali@kernel.org> <20220318161744.5814b7d7@dellmb>
In-Reply-To: <20220318161744.5814b7d7@dellmb>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 18 Mar 2022 17:03:50 +0100
Message-ID: <CAPv3WKcrbDpcLkft2ybhMo336DmvFkoAOOQRa81-htHSZBKOfg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: fix annoying 1.8V regulator warning"
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Konstantin Porotchkin <kostap@marvell.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pt., 18 mar 2022 o 16:17 Marek Beh=C3=BAn <kabel@kernel.org> napisa=C5=82(a=
):
>
> On Fri, 18 Mar 2022 15:14:41 +0100
> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> > This reverts commit bb32e1987bc55ce1db400faf47d85891da3c9b9f.
> >
> > Commit 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v regulator stabilizatio=
n")
> > contains proper fix for the issue described in commit bb32e1987bc5 ("mm=
c:
> > sdhci-xenon: fix annoying 1.8V regulator warning").
> >
> > Fixes: 8d876bf472db ("mmc: sdhci-xenon: wait 5ms after set 1.8V signal =
enable")
> > Cc: stable@vger.kernel.org # 1a3ed0dc3594 ("mmc: sdhci-xenon: fix 1.8v =
regulator stabilization")
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

I tested the patch in my setup, so you can add my:
Reviewed-by: Marcin Wojtas <mw@semihalf.com>

Thanks,
Marcin
