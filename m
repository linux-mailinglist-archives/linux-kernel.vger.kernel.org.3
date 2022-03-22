Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C52B4E398F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiCVH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiCVH2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:28:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA79B48E6C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:26:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id q20so9804735wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1ebdiBMBE49ulpNNpKaiXB7dt6wLbc0VTq7GL//3XJ8=;
        b=XiP0TuYRMwiK5fc/j7mhZxReC+ATSMW0nX67r+NRFxZ3OzK03jyuKjwX5Xdt3QRJUt
         gA5j+j76DLTpL0hCnv/kLBxTnAXRtDq/X+6WnAvnvvp+6k/RZchmDpjUWDMYhg0Rf7IY
         QwoTHGyMCFu3I6jYAVAphUHzuhzcvkWy7BBj9QIDS+Jzlj73FgDK5841N04IJwb1F9WJ
         EMy2FG97HFb5wOEZ+Hwn8MXaVHkNz2j9MSxZiL50g9y4DnwYrZYWD6jJogn2YXgTEYSw
         CT6gUD3QUkshUk3ALkKsJRaLtUkiGJGFccPvm0qzuXt3Duc2IxkutyqlqqQ+wuDYFH2w
         VuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1ebdiBMBE49ulpNNpKaiXB7dt6wLbc0VTq7GL//3XJ8=;
        b=b+ZrlD8qmzgHpGnFcmE2dXIFJkm25wfIuvl04YkqmgfE566DDNJy+BR5/RJ3FiAQBr
         hJ/tZ/Cx/fx4gSqFBqvYmYjOAkB+s4oNbvJu7Pnm32tWCltCuA7TUjIE8IAFEvruk8Ac
         SClP/7LypYE6aA17Xqh1x8ZB1ZajngivO7VWlsEyRRkatp1HlxqsNUAF0B//2Uhrl6Y0
         G9UlSbxz2JCI4GUGZ71+rYHJTBrIsRyUgPzgA93lFR8bXPPmiSpE3urP68xXVQuN+f+L
         GnFa8JKO08QFznyEyknxZfQbsAeXxAXJbYNqOyw2AMZ/dxJo8Ws0664yZ1paKCLgf9qg
         h2pw==
X-Gm-Message-State: AOAM533/7zSqtCcHqlPRbaIME9Y/TiWMPdWEfVPH0gzux6GPnIENUzbS
        sDY55faeMSPqMIuWmYJ6zI+aTg==
X-Google-Smtp-Source: ABdhPJyC/73lv8Erlea0JHSb98XavB/OtlrxxHlezh1m5hzJDvCG9A9XcDT90mpK23W1dLn5RFtapg==
X-Received: by 2002:a05:600c:1f14:b0:38c:946f:6812 with SMTP id bd20-20020a05600c1f1400b0038c946f6812mr2386550wmb.192.1647934007326;
        Tue, 22 Mar 2022 00:26:47 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o9-20020a1c4d09000000b0038ca75056e2sm1829110wmh.45.2022.03.22.00.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:26:46 -0700 (PDT)
Date:   Tue, 22 Mar 2022 07:26:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     cgel.zte@gmail.com
Cc:     linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mfd: Use platform_get_irq() to get the interrupt
Message-ID: <Yjl6NdLIjRbwGgFa@google.com>
References: <20220309035607.2080884-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309035607.2080884-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2022, cgel.zte@gmail.com wrote:

> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
> for requesting IRQ's resources any more, as they can be not ready yet in
> case of DT-booting.
> 
> platform_get_irq() instead is a recommended way for getting IRQ even if
> it was not retrieved earlier.
> 
> It also makes code simpler because we're getting "int" value right away
> and no conversion from resource to int is required.
> 
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/mfd/ab8500-core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
