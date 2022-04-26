Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5F5104BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353561AbiDZRAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242761AbiDZRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:00:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B956D187
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:57:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b12so16014654plg.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DTPMRMeWBAzanCmBx6cBcukiqX2leSLOdPLeBw+/mc4=;
        b=kOgwKw2JD0gfI0he7V3lrFfb/ewU0fph/RfUDZAE5UZgmOw59W9UZVTDHcF5OtPDnU
         3Ek/n41/pC7tY/P2oF0XPaNdkxfsDElNuiCvLaQRNzjDEVFhTWKTjGAFvj0NktS0cWYW
         8QbryrEBzZytP6eS/ePMzqSsm7l3TmwsbGlvHkavrnG8xyeUn2HNGKDkQlTIc8vberJD
         LNm5aWrZUL2Ji8sV8vswlGKowjXOoLGcL0OSsUguwBkO8xD0DTUA9htAL4nKaIPwOeHY
         UjV5GuaN+j1REKUhm0cEY0lYzyYkpNc0QNiYEQny5d6LJZwkWJXu6LH5AAjiuRWwwk3C
         Bsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DTPMRMeWBAzanCmBx6cBcukiqX2leSLOdPLeBw+/mc4=;
        b=Je2wooRp+Z+DE6xdEzczV5zCt/AZdkyzDMpbmDOzCpsIBsZaEh4VSO/s4CE/XpLiR9
         SWlMl4mgvSD8jqhPtS14DuY4Z5WpdGrJ8cPCvlQiqRNYCjdJnjMdqbpBUkgnLjW+L3zV
         ACd9aL+cbNdCfPnRY/XYBixs48XlUuiSLCdwixH5v9Gd/fbxC2Kg+GO6a2hwyLoj37gc
         QC6mwgGXxgUD//VKyEdYWVLh73CKPc2QurdQRIn+tbdjfQR7c1NsldcFoDPrq+bZg5zT
         sAnAvoOjF2ZBncMOTQzm9x9PgY0IFOhCKc9TqRADA2IGqPEm27d/Lz/QMLi2qy/t1NQp
         YOcw==
X-Gm-Message-State: AOAM530VWQqt4JRiM2O7W+fkeWCFuAUnKn09RFNvgEhACNW8XxJxQfKZ
        LBgyJqd8+i/zCnv7A3+x0vheew==
X-Google-Smtp-Source: ABdhPJwak3kS8aqfMggQA5aK6zxJOCtJWtrUoPhsxApZzL252nhjxcJxzOc/Ln00Y20h5uCULPrk4Q==
X-Received: by 2002:a17:90b:1b03:b0:1d2:a577:d52 with SMTP id nu3-20020a17090b1b0300b001d2a5770d52mr27494002pjb.58.1650992231904;
        Tue, 26 Apr 2022 09:57:11 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id i127-20020a62c185000000b0050d4869918csm6461120pfg.216.2022.04.26.09.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 09:57:10 -0700 (PDT)
Date:   Tue, 26 Apr 2022 10:57:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 0/2] remoteproc: mediatek: allow different SCP
 firmware names
Message-ID: <20220426165708.GB2007637@p14s>
References: <20220419123331.14377-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419123331.14377-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 08:33:29PM +0800, Allen-KH Cheng wrote:
> The SCP needs firmware which differs between platforms and SoCs. Add a new
> property "firmware-name" to allow the DT to specify the platform/board specific
> path to this firmware file.
> 
> The firmware-name property is optional and the code falls back to the
> old filename if the property isn't present.
> 
> Base on remoteproc/linux.git, rproc-next (58b7c856519f)
> 
> changes since v2:$
> - use rproc_of_parse_firmware instead of of_property_read_string
> changes since v1:
> - fix a misspelled word in commit title
> 
> Allen-KH Cheng (2):
>   dt-bindings: remoteproc: mediatek: add firmware-name property
>   remoteproc: mediatek: allow reading firmware-name from DT
> 
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 7 +++++++
>  drivers/remoteproc/mtk_scp.c                              | 6 +++++-

I have applied this set.

Thanks,
Mathieu

>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> -- 
> 2.18.0
> 
