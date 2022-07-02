Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F212D5642F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGBVs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGBVsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:48:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9EDEB9
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:48:54 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a11so6625482ljb.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwhpF2WN1J6S5lDXRAv+Kjl/+1IwILg/3g/jg+Rhz9c=;
        b=oCpQEhUQFqNhRyRxjTjg2S5HdHN/+rGO/9TGX6J3EXmBo7rnTdLvPgvWrtCYw2J9UL
         wPu+VXgoiZTIjlLx8ApyAAFpKJYDCFzUjD+6WIbD9w2kENrTihBt45XO8XYjeSnU93NS
         krbAIogLcjd8c8Hl+HuDng2dDRSr96aWR3ZV8g8//QDnIuXXK552X9Zyvv13uHm9LwGT
         Qg2/7MLD3xII8a4IFaufxcAVcoUOcYwp49Xo4IqzHP2n5rUaXUo3LyC/py01oAEAukQp
         tovSlF37pVHf7oPsn77gzJU3rv/MI1477WsxbQ52/qO1KKeng3K1lsh93mSnr2STndqD
         2RJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwhpF2WN1J6S5lDXRAv+Kjl/+1IwILg/3g/jg+Rhz9c=;
        b=uZYR28mC9CSr9zJo3cgeizj0zDpLcdkZ/skXXNmaDb+kzfDoQ/sAAjG8/TiNa/AJtZ
         b6YygnoYG0ClHP9t0gyNxkm71/iHAou96ez75CT7QP1G+FpsOdEB6/K+HBGkKRfytrxu
         pZ4WyZYHHVlSLdh6UkLs6sRMeW5TXY8w5epO7HgevYWz7XjmjTWBt5VTPpymLRYXubuc
         J4nkkWm01mhNxRooWquBMFFjIef5q5amnDZey6YjLAXpbDqxP51eNL2OtEK8FubV3cfH
         +OvDUS/KAObhtpJfzIARlC80MIIU1d0wQFsghoc6hL2QGUkMy3SpUbCtWEzYYtfeiI19
         WNuA==
X-Gm-Message-State: AJIora+ilcrw1IhQhq0y+pwwoFfLFMaNkS6732e7du+lV0+x+38S0Wo0
        si8PLOJR6GDyrjunszhnLsn+tMMQrAmKYkuxqGc12w==
X-Google-Smtp-Source: AGRyM1vFoFHz8ksTCP0i6tWzC5kgSiz3ScxWxfJFYqE/7vLPww6uI//LFWqdzMMDeGA2eY9gG4si//g3WtmRof3kUm0=
X-Received: by 2002:a2e:8ec9:0:b0:25a:754d:db39 with SMTP id
 e9-20020a2e8ec9000000b0025a754ddb39mr12010480ljl.4.1656798532393; Sat, 02 Jul
 2022 14:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Sun, 3 Jul 2022 00:48:41 +0300
Message-ID: <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 at 00:37, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Existing exynos-iommu driver only supports SysMMU versions up to v5. But
> it's pretty much ready for basic usage with SysMMU v7, only small
> changes have to be done. As SysMMU version is tested dynamically (by
> reading the corresponding register), there is no need to introduce new
> compatible string.
>
> One major change is that SysMMU v7 can have different register layouts:
>   - with Virtual Machine support
>   - without Virtual Machine support
>
> That can be checked by reading the capability registers. In case the
> SysMMU IP-core is VM-capable, the VM registers have to be used, and some
> additional initialization is needed. That is the case on E850-96 board,
> which non-secure SysMMU (v7.4) implements VM-capable register set.
>
> The patch series was tested on E850-96 board. Because at the moment
> there are no SysMMU users for that board, the testing was done using so
> called "Emulated Translation" registers available on SysMMU v7. That
> allows one to initiate the translation from CPU, by writing to those
> registers, and then reading the corresponding TLB registers to find out
> the translation result. The testing driver can be found in [1] tree.
>
> [1] https://github.com/joe-skb7/linux/tree/e850-96-mainline-iommu
>
> Sam Protsenko (4):
>   iommu/exynos: Set correct dma mask for SysMMU v5+
>   iommu/exynos: Check if SysMMU v7 has VM registers
>   iommu/exynos: Use lookup based approach to access v7 registers
>   iommu/exynos: Add minimal support for SysMMU v7 with VM registers
>
>  drivers/iommu/exynos-iommu.c | 112 ++++++++++++++++++++++++++++++++---
>  1 file changed, 104 insertions(+), 8 deletions(-)
>
> --
> 2.30.2
>

Hi Marek,

As I understand, you have some board with SysMMU v7, which is not VM
capable (judging from the patches you shared earlier). Could you
please somehow verify if this series works fine for you? For example,
this testing driver [1] can be helpful.

Thanks!

[1] https://github.com/joe-skb7/linux/commit/bbadd46fa525fe1fef2ccbdfff81f7d29caf0506
