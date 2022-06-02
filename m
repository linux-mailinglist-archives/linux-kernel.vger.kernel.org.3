Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC4253BA8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiFBORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiFBORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:17:37 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF051FCE3;
        Thu,  2 Jun 2022 07:17:35 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id e11-20020a9d6e0b000000b0060afcbafa80so3493389otr.3;
        Thu, 02 Jun 2022 07:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TCCwJv6EhxWlaEc1Brd2505WQxC3GVxol8XUS0Q3iIQ=;
        b=wWBsC8NfMMU90Yfiz8XoiaUJdjZMiwT8uBBGAL4WTaEKCbR925MzdKexvE+IxJWq+c
         TDVsmpWbF4PmvNrWmH3Qf6eRugQG57ii6Dpi//ZcBERJLgzYS71eHQwh6OFq8QasNM7y
         oJvlhtYJvl4O4XqXWnul46D4c+6iXc9257GbrAEAnj0Q2u4urzPfqBiN47HmGMGICseX
         pblx51aBVEgd/zESfqjJvH/4QS+WH48OQb+/n8tYCb4juWDbgE8y8T3MdHb87INmMQFK
         Eu4Ivy2Q+cZPthPMZcXnZNgHSn6w/cfV5Uo/83m/Y1A8sW+9QnvWtwjWoeAPpsaJt3Ws
         vyWA==
X-Gm-Message-State: AOAM531xWE8xeAOK/li3YAvuepbtGBfhLYgnXyHa4eflOV958FU7WyOh
        qoElMkS8a81aDVb0EGxQwy7XebfbzA==
X-Google-Smtp-Source: ABdhPJxYVbALGE594K0AOIrngTP0BTDjw28b1fwlQJNHJriJPoZ+rLecoT8+hiuf2AyA7nCY83K4nA==
X-Received: by 2002:a9d:5f16:0:b0:60b:4fbb:ac5a with SMTP id f22-20020a9d5f16000000b0060b4fbbac5amr2120193oti.189.1654179454963;
        Thu, 02 Jun 2022 07:17:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gu23-20020a056870ab1700b000f5d765bc02sm2098115oab.8.2022.06.02.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:17:34 -0700 (PDT)
Received: (nullmailer pid 2234679 invoked by uid 1000);
        Thu, 02 Jun 2022 14:17:33 -0000
Date:   Thu, 2 Jun 2022 09:17:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iommu/qcom: Add support for AArch64 IOMMU pagetables
Message-ID: <20220602141733.GA2227595-robh@kernel.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-5-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-5-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:28:59PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Some IOMMUs associated with some TZ firmwares may support switching
> to the AArch64 pagetable format by sending a "set pagetable format"
> scm command indicating the IOMMU secure ID and the context number
> to switch.
> 
> Add a DT property "qcom,use-aarch64-pagetables" for this driver to
> send this command to the secure world and to switch the pagetable
> format to benefit of the ARM64 IOMMU pagetables, where possible.
> 
> Note that, even though the command should be valid to switch each
> context, the property is made global because:
> 1. It doesn't make too much sense to switch only one or two
>    context(s) to AA64 instead of just the entire thing
> 2. Some IOMMUs will go crazy and produce spectacular results when
>    trying to mix up the pagetables on a per-context basis.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.txt  |  2 +

Bindings should be separate patch.

As you are making multiple changes, please convert this to DT schema 
first.

>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 54 +++++++++++++++----
>  2 files changed, 47 insertions(+), 9 deletions(-)
