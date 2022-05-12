Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66BB52506A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355494AbiELOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355561AbiELOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:41:22 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7D62105
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:41:20 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id n10so4468709qvi.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5glS7uZd76ZDuYG8T+JyK/h9FeySdt8lV4erqmgs1dI=;
        b=Fnj14Ih1flSLaJf3Sb3wiw3Kx6b3Gmqup6F21OFYa/PjkOlL7ZZbdPlb+oWbYQLp0a
         K39QgjVzXoTAgSTmWzLdlEbrPjzJi5pnzNYL0cziZZiCCI50wgWgcPqVVydJAEku6oMx
         ixd1J+9LhzTJB+515dm0poCh7iiPWFE1Ua9G5S8qrqgVHIOWiJdkgfnvcRScplAeSO3X
         KxlZbjo9WAvJd4SYVHHM2nSPgywSncOj89zIdenammpW8s+HKzS9fbnz4Vz0TOYetpg2
         AauxoGnagnwAq94V3ofsT7fzGlR5TPPmUC1G46qjxbl3JMoJRaE3tsLphQwpceloOSqY
         eR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5glS7uZd76ZDuYG8T+JyK/h9FeySdt8lV4erqmgs1dI=;
        b=KqDWfDrRZpqn7S+/vnuBkDDJ7s7c5+du4rkUsO2/REG77UEnEj2N9ENHKINOBsD5lR
         9cYPmFkW6b1yJmVX10ov/3a0bwjZAv75ZcvLTnK8oFZ3XHirRfp8NcAHnK99rZh/78YL
         y7/lBlkL/hUqCIOKxxUTS7v75ViMdYfrrSoOjfLK6Lm6MxURhDnI9v4sljan9g5IwKny
         SOeik6I97NNbESTKCGZNnagDRhifHjcDf+HZWTSrL5vHYRtq1Nb18Ram1uaIdQUUN0Ky
         qi0xaHD4ZRWjRj/r6eQfON2dWvHrlVcTGqj+bjt7892ZjjXQ7Zmf3mCRas11IDmCOuiR
         N50w==
X-Gm-Message-State: AOAM532ebLpcVGjzsFA8rEI9lVB+1mVSAwg4Aw9NMWOJNxVFE6d9Btag
        gXvSXahStkBu83ExXB+5Gxs=
X-Google-Smtp-Source: ABdhPJxTOrWLUEqkRknLwLE7F3yYQ5+iQTsGI/rPnaW0KEt7l46C4L3hxqMRuw+Z7czCdxVnwTmQEg==
X-Received: by 2002:a05:6214:5292:b0:45a:80bc:c642 with SMTP id kj18-20020a056214529200b0045a80bcc642mr57015qvb.30.1652366479314;
        Thu, 12 May 2022 07:41:19 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id t4-20020ae9df04000000b006a09faf5c1asm3082820qkf.30.2022.05.12.07.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:41:18 -0700 (PDT)
Date:   Thu, 12 May 2022 10:41:17 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: ti: omap-usb2: Fix refcount leak in omap_usb2_probe
Message-ID: <Yn0cjaaqfr5wphh3@shaak>
References: <20220512043238.63252-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512043238.63252-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:32:33AM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/phy/ti/phy-omap-usb2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
> index 31a775877f6e..98133e5fc9de 100644
> --- a/drivers/phy/ti/phy-omap-usb2.c
> +++ b/drivers/phy/ti/phy-omap-usb2.c
> @@ -421,6 +421,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  		}
>  
>  		control_pdev = of_find_device_by_node(control_node);
> +		of_node_put(control_node);
>  		if (!control_pdev) {
>  			dev_err(&pdev->dev, "Failed to get control device\n");
>  			return -EINVAL;
> -- 
> 2.25.1
> 

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

Thanks!
