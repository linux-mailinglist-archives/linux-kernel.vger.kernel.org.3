Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC84F4EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582501AbiDEXrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456662AbiDEQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:01:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B592DFCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:24:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o20so5452818pla.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gaL4daNNx5XyRwsMGVTXgsIpDqFV20lGzvAcOxT5Pxc=;
        b=XR1rWqooB4cSqOX8klL6QQ5bXML0D9I+c8LZZPvcQC5WHjNtDpu6uiH3xRMe9SG3EM
         7SxO+lji/FWVuTuv5VEz7GvwQNKIHrtlZzJKLLFIU6+HJJXyqhF1jSbfitjAk4mU56UD
         2670KEMuz0XBfTmwuShwUTicuUBYggSdXdEA6JObiHzPIlQ+rQqnHR6g0BwxTVNDAz4A
         Yd18Z3C5x9IfXlytxfT+s4nlS3OnFhYLfdGYV9cLG886o3mC6RQM4O93eH0GJH9LgwRJ
         +4KocmB/vX4MTyF46d7tbLOyctLs5r7+tSLD2R532rtJddPEojgDZGRVpqBJ44vDBg5i
         z3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gaL4daNNx5XyRwsMGVTXgsIpDqFV20lGzvAcOxT5Pxc=;
        b=P7qLuRiS0BoK/EgrP74gVOKUR8ALKST48GBAX+zBDnhxHGxlS5vxyBwkwI509v7sE6
         kmaFoProhMrXTHUs7BR/10FvdF7//DrX47SbzgDZqGKCg3yDZRkx2xEiiNXm2LcVjvxl
         sCWKWjAjS+I8GlhcKYEOLD29C45g2RbqZGoCPvMWI2zPd7ivZ0If93Jvef4UKsGEIGZw
         8sFJJazjMceod9DNzEZ6N6vEPUxUkpd243sQhO+819KdzByjqigtqqM54u8hSh3GpTnk
         9tgK+xIauDJIfejKN4GJbQIJQaVo3f/R8AczfJCh+y3WxXIaGAWKI1Gj3UdxqPPteYpe
         fnOA==
X-Gm-Message-State: AOAM531YvKdNWaZ5trKkUZP/jOsHq7xMUghHV2zVKGc02oq19lv15BmK
        ju39vn7mnW3DeHq/ggIvg5Hh9w==
X-Google-Smtp-Source: ABdhPJyIKhb+o+uPOTXcPrUrIAiRm/siuew4fl4U5FXEjG2l5owGW5KhZ9LBJ1W3hSxv+OVRouj7aQ==
X-Received: by 2002:a17:90a:1941:b0:1ca:a28b:6744 with SMTP id 1-20020a17090a194100b001caa28b6744mr4858515pjh.50.1649172245357;
        Tue, 05 Apr 2022 08:24:05 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090a550400b001ca38abb248sm2770940pji.53.2022.04.05.08.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:24:04 -0700 (PDT)
Date:   Tue, 5 Apr 2022 09:24:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2] arm: configs: Configs that had RPMSG_CHAR now get
 RPMSG_CTRL
Message-ID: <20220405152402.GA4147585@p14s>
References: <20220405115236.1019955-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405115236.1019955-1-arnaud.pouliquen@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 01:52:36PM +0200, Arnaud Pouliquen wrote:
> In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
> from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
> By default give everyone who had the old driver enabled the rpmsg_ctrl
> driver too.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> 
> This patch is extracted from the series [1] that has been partially
> integrated in the Linux Kernel 5.18-rc1.
> 
> Update vs previous version:
> - remove "Fixes:" tag in commit, requested by Mathieu Poirier in [2]
> 
> [1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
> [2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
> ---
>  arch/arm/configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index 9981566f2096..2e7e9a4f31f6 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -241,6 +241,7 @@ CONFIG_QCOM_Q6V5_PAS=y
>  CONFIG_QCOM_Q6V5_PIL=y
>  CONFIG_QCOM_WCNSS_PIL=y
>  CONFIG_RPMSG_CHAR=y
> +CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_QCOM_GLINK_SMEM=y
>  CONFIG_RPMSG_QCOM_SMD=y
>  CONFIG_QCOM_COMMAND_DB=y

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.25.1
> 
