Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E89510045
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351553AbiDZOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiDZOWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:22:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D671245AD6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:19:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x18so25749131wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=QS3yKNM0q2pZDAHA1IFWy/K8h6RY8QsWB8BvPEu/8J8=;
        b=hs8cD1vdRbGuUkUUDGWzBPd9FczxSWGXeA1xWmjjUAtpoizXH2ALAV++G3+yJzLgAO
         rfISoueXGrD1jFeIAhNyayqRQDISTsgBsufDc7XLL5pj8Opxkm0+0hQ/rSiiS4MFw6cp
         gq+M98jsTo9TR+j+oYPxX4Qvo1TfZyD90upEgVlwdTA1vqTZf6BMMwhjUAs0D4y4YXce
         XfUe5XnCcOFElrdDsIhYqZEW6Hns6Pnbeas+h9/4LttctEIxkJEZ5YoXthGLdzhhwhHl
         dmFSPwgf5X53q1Y1/pZY77HbOSxkI+BnWxVu397XEesiuG0BlJpVtg2w3oRz2d6Smt5V
         /a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=QS3yKNM0q2pZDAHA1IFWy/K8h6RY8QsWB8BvPEu/8J8=;
        b=lDFoC4Jg5EseXhwhYa3IBZU54ry2CYeU0hTL3NtTtwxt7PvuZrwNLHBgmiAdmq/7Vl
         3NiGEkAx/kcKrmYcRqpKkxnbxGvZFSCKhov/KHJbVcA6KASTZvLjk2+MLUh/Htop8i1s
         7yGAIp1E9v0Go3e1NQ8vCpSE9dpsHdNehDv8OkYlAKAlyv3/2DRvp9EOFlo+F1ikc6Em
         knrMY8NDL6LDMJRcivg10W6BjxVXEtB23zeQeS1xPIZe9hwG5hLhQjSLfG3ltwt+0s0N
         5PKEA0LrrxrqPcNUygXY0okz4EOOG1SiwP43ifsQmHRNsXc5sp2DARXA4uH8JYGWj1Ku
         RcIQ==
X-Gm-Message-State: AOAM531K9QGmr6eOhaZKfvGqttYBVlUHWx2TL+GGUmhJ4nQeq8qCHFjC
        PYADSM7dFFsCbFs1sUgoXKk0gQ==
X-Google-Smtp-Source: ABdhPJxUgN7DLQYxCIIGBi53Jg9tpP9jWKFpfG7stGDElrwVpEw0+ekD5kQwtkL9ceflCvkm8ZwRqg==
X-Received: by 2002:adf:db11:0:b0:20a:bfd2:8557 with SMTP id s17-20020adfdb11000000b0020abfd28557mr18597013wri.485.1650982779415;
        Tue, 26 Apr 2022 07:19:39 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b00393ea3bab42sm6412842wmq.19.2022.04.26.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:19:39 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:19:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Only register PCHG device if present
Message-ID: <Ymf/ecKnqfkE5OOE@google.com>
References: <20220419000408.3202635-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419000408.3202635-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2022, Stephen Boyd wrote:

> Don't create a device for the peripheral charger (PCHG) if there aren't
> any peripheral charger ports. This removes a device on most ChromeOS
> systems, because the peripheral charger functionality isn't always
> present.
> 
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Daisuke Nojiri <dnojiri@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <chrome-platform@lists.linux.dev>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1 (https://lore.kernel.org/r/20220415003253.1973106-1-swboyd@chromium.org):
>  * Use cros_ec_command()
>  * Drop the other patches that aren't needed anymore
> 
>  drivers/mfd/cros_ec_dev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
