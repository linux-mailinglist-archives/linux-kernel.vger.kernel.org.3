Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D7B58CC9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiHHRT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237846AbiHHRTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:19:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2D15FEF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:19:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v2so4997662lfi.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=KbpI7aX4OJn+9ta7EZh2prJEXa1vTXGHPmj5GWJjFZo=;
        b=zlnytlGmuMZ+psy1MdlUiNxuXSiE8ZCQ3Gv5Frvlh8cCNKqt2vz3RyTbRK256z5CKX
         ZiuNuhAA8KA12Bt3I+BbNroQ91a8BPiMqx26a8cX96K41jkiGVK44WiqKCvPLcROB+9h
         RMY9cVTGaADY3Uew5DmA0cBp4ZUot3wxoLoTqCOQpZLlYII++6Brua3pyU1+ydwOM6IJ
         BUIgerP4Y+W2XoSWVc4fw9+o932Bj9skOfT3gBECuXD55/9/WtQgc5G5Avryql3RS6ZX
         KJKJOgYLQ3PSDLNrWyUjEk0LQY6DhY4+0EDzjqUJLHD/X7Z4ysu2yu2jnnBvISNlVRJd
         fEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=KbpI7aX4OJn+9ta7EZh2prJEXa1vTXGHPmj5GWJjFZo=;
        b=42qchAxvDf2/FZ1XfJDy9bPRLrQi7Ve6vKdK9pnDZG563xNNB5jFVxFjeBg6HmLko/
         wUK1Dg0qxp1wArS1EZZDtnqCbdOfjWU11K4ZRPpa4b00EJ6lLFOjSikfzPN1Ge8QAJk/
         fu8QLcRiT/09B36vmE+uJXCL9jJG15xNJw2PtrR/4AzdztAqdazmFjkgbhVFmmf6yO/q
         dVPxJkNRZjURw9ihLHXTzB4zoNmFVHlQx7vc2l0QmmG7qQlszcEvQrQs/gL4OEgEagVW
         ZKxIuLbNnDZTz6vg/jsks3MJgeG2dxrv/sISx1t3umU9ko/xyC1A4cTj1Ubcds9j9Mv8
         vcew==
X-Gm-Message-State: ACgBeo1X9oKCEFTGVMJ0N3UtuCgKpDoBFgjf5YLDudqnhtrFGbZI35gx
        c0Y5Ph/O//34prpDcowQuvmkogMATQfDHL3gGO20kA==
X-Google-Smtp-Source: AA6agR60RUwt3/4FZq6vv68Rd14ohShJ+6I1vuQ8pNpdWDWPZ27+sATnt0BnfGxwaXqeGnKcTp+CfCCKh4dFy7ZrKgQ=
X-Received: by 2002:a05:6512:2306:b0:48b:26f3:91b1 with SMTP id
 o6-20020a056512230600b0048b26f391b1mr6621555lfu.11.1659979150181; Mon, 08 Aug
 2022 10:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
In-Reply-To: <20220726200739.30017-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 8 Aug 2022 20:18:58 +0300
Message-ID: <CAPLW+4kG9V03edHFXWJumuK+tmWiiwF5B7d2O6+Mb_XmfBY5Jw@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/exynos: Add fault handling on SysMMU v7
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 23:07, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Exynos IOMMU driver implements fault handling for SysMMU v1..v5. But the
> abstraction currently used is not suited for SysMMU v7, as it has quite
> different fault related register set.
>
> This patch series reworks the mentioned fault handling abstraction and
> adds fault handling support for SysMMU v7.
>
> Sam Protsenko (2):
>   iommu/exynos: Abstract getting the fault info
>   iommu/exynos: Implement fault handling on SysMMU v7
>
>  drivers/iommu/exynos-iommu.c | 208 ++++++++++++++++++++++++-----------
>  1 file changed, 143 insertions(+), 65 deletions(-)
>
> --
> 2.30.2
>

Hi Marek,

Can you please review and test this series? I only have my E850 (which
has VM-capable SysMMU register layout). So it would be nice to check
if it works fine with non-VM SysMMU v7 and older versions.

Thanks!
