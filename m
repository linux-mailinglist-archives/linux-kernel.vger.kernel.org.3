Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376204E64B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350286AbiCXOJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbiCXOJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:09:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78F4BFDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:08:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u22so4060454pfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=93vcdK/xA2d3gDff/dGSRlMj0tuRWV7ZnM79a900KCA=;
        b=aKaURfUNMFCp6cu9fJB91q5Ui3Eo6etz7SRrY9zGxm61qngeQOZmhkjrmT9E08wCiP
         vlm6/uY+83hWF+qhqvwbK6BqcreN583/zJ97ICfUcI3l4BG4wXLKnjKvo4fSVDFGZROB
         MCf7Ag+aX8rBBRnWCP/iGbVGxbIokTttCitk+QCZR22MoiwpLwCHdA6hwwakhmWgBGcL
         DBTkl2W3ovnPdYqppO1XKXM+PsJcnfDQhpZ4Cd03sfiuB/09t3PqXR1DG/mYP49NV5QO
         9Q7tGP/aNrO1s2nd/VHZCl3l3e714ZbNNQ+fQ9LLT6tmVruzZI0/u/0a3SQCqvcY9rW3
         5RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=93vcdK/xA2d3gDff/dGSRlMj0tuRWV7ZnM79a900KCA=;
        b=6DWav2rQSEknawWxXrnbVPm3MpWIWSYFiVrmMRqdct8FEeGFekdnpxxwtrHP/5R+7y
         Ba+nRbmRr0n+CN0bqOk9NEAK3DVkf/ew3cGDBKinN6gllSAqvUSu9aK8QqKrz65gHXh0
         /5pJ0WWwz/j9YWdv4nUdC2NMwnQdmhpeDDAGi0YE1PMQXgnbNN8qmJF0oV/j+0yCsI9t
         X2q6Q/z9ULMpwhOS16X1K8P9reLRXvakzL0+A8Fv3gh08jXKKEPi8yzBX4fUyU96vp52
         vJKLdW6ssmOs6/Uy6o+izopt4oS+H6LVkNy/dtlJ5WEClBC2jy6v6xsrU2R6bsJcVS20
         zjyg==
X-Gm-Message-State: AOAM533YNlosmFumKP6aXiQM2+7TmIIOKcvsFgmH9mg/oL1Y08Zo4GVe
        a+vr50xtd+vrs2wtmAMX2k8a
X-Google-Smtp-Source: ABdhPJxjNH1ojTh0rmiF8uZ2gnlb/AVtEx8oYA2jDrVBOdB0Sis3oEqfp6h9EDbm/e0f3OM2YGJMKA==
X-Received: by 2002:a63:2003:0:b0:381:2dd3:ab4b with SMTP id g3-20020a632003000000b003812dd3ab4bmr4304586pgg.517.1648130892419;
        Thu, 24 Mar 2022 07:08:12 -0700 (PDT)
Received: from thinkpad ([220.158.158.107])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004faba67f9d4sm3864954pfu.197.2022.03.24.07.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:08:11 -0700 (PDT)
Date:   Thu, 24 Mar 2022 19:38:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] dmaengine: Fix dma_slave_config.dst_addr
 description
Message-ID: <20220324140806.GN2854@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-5-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:15AM +0300, Serge Semin wrote:
> Most likely due to a copy-paste mistake the dst_addr member of the
> dma_slave_config structure has been marked as ignored if the !source!
> address belong to the memory. That is relevant to the src_addr field of
> the structure while the dst_addr field as containing a destination device
> address is supposed to be ignored if the destination is the CPU memory.
> Let's fix the field description accordingly.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One suggestion below.

> ---
>  include/linux/dmaengine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 842d4f7ca752..f204ea16ac1c 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -395,7 +395,7 @@ enum dma_slave_buswidth {
>   * should be read (RX), if the source is memory this argument is
>   * ignored.
>   * @dst_addr: this is the physical address where DMA slave data
> - * should be written (TX), if the source is memory this argument
> + * should be written (TX), if the destination is memory this argument

Should we rename "memory" to "local memory" or something similar?

Thanks,
Mani

>   * is ignored.
>   * @src_addr_width: this is the width in bytes of the source (RX)
>   * register where DMA data shall be read. If the source
> -- 
> 2.35.1
> 
