Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E49B57C9CC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiGULhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiGULg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:36:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5A56B93
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:36:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m17so1558420wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3dGL++LPAmS2eym62mLHBoZzYDfysbltWj55S2SeBfY=;
        b=OHDVersEmMfP4wtrsESwOSLR0aXXXw6yByDlyUpqK4xliNb3B7DOAzxYpfWP2/eeOd
         FwQhuWP/+lA8XforgHtSjTZswnB5XirsvXBoHyLx/KQDRYyM0PwywNGlhp7U5gPIbdtT
         Ew5EFum/cqwspvE8JKTDPDmYYPeS7kMdkG2b5MaB1zyrdW6Y8Pu4iK6hMS5NaGEPaG7c
         q3DqmtqYJbb1NHptUKaKSkzlUfjaNYcLayRBwgGPUhPsZhN9VPegQWrfe1zmsBT7FT9f
         bVwJ5nheZYjKGhAnvcLyZXAdreOVxU08zCrQ32KargN2WtmgUzm3lPn0oepQ4+cNyCqX
         uybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3dGL++LPAmS2eym62mLHBoZzYDfysbltWj55S2SeBfY=;
        b=upvUKH+DlBfMEMrm50YjfO9RZDCKkWELb+CJ711NMM2X+Ibdmkk1tI019vGcbHq9Jz
         6eVXRNpcUl7X3u5M/A0be9yN8Ky102lvSBkjLLtVoGhAAghAkpAJW2Dt1vr2uw/tevOf
         BsoCxobhFzr9qjsvAi+4qWFWVeMAf4tkqn986CIo8/Cqhux38neAxjyAQT8VL4QEUwa8
         8VjiPaTsL4qqY0SB71CMTaFBfZzlm5dMiDTjXQQtXDGvfN+FGf+LtW2pSQDx2cpYqRAm
         CyPwesi/lCCpZJBxViE7sM4x9E5PyFwp4K8bF0esA1a78JxcsD0ios/DNnyqACMWQu2B
         JPYQ==
X-Gm-Message-State: AJIora9vvVrT3iiRz2jBrbjxQKRt+g5Gn3X7xjnB/HOW5IDQpC3M7LuI
        xIOIvltHHif+MVk+X0L3A7wncA==
X-Google-Smtp-Source: AGRyM1viD12dLSWjZcRDX0xi2VY77xaUB6/V11P01gxqkWTXqVJej7u3/DmQVUgKdZEduGu4KbPfHw==
X-Received: by 2002:a5d:45c5:0:b0:21e:5755:d443 with SMTP id b5-20020a5d45c5000000b0021e5755d443mr1440971wrs.45.1658403414416;
        Thu, 21 Jul 2022 04:36:54 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003a2c7bf0497sm1685064wmo.16.2022.07.21.04.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 04:36:53 -0700 (PDT)
Date:   Thu, 21 Jul 2022 12:36:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <Ytk6U4fncRJOaAq3@google.com>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-7-tinghan.shen@mediatek.com>
 <YtgDu70Lpl/uPOkf@google.com>
 <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022, Krzysztof Kozlowski wrote:

> On 20/07/2022 15:31, Lee Jones wrote:
> > On Wed, 20 Jul 2022, Tinghan Shen wrote:
> > 
> >> The System Control Processor System (SCPSYS) has several power
> >> management related tasks in the system. Add the bindings for it.
> >>
> >> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > 
> > Why have you ignored my review comments from v2?
> 
> If you refer whether the binding is needed at all, then the answer is
> yes, because this is not simple syscons but a device with children,
> which we want to parse/match.

This part is fine.

> Anyway Tinghan should respond to you about way how he proceeds...

This would be nice, yes.

I was referring to the submit line, which nearly made me miss it, again.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
