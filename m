Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4164C3717
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiBXUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiBXUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:54:42 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088CD1C6ED8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:12 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id j24so4888532oii.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1gjMFPbNgKd1Fc+yJ2WMlD8bStAd2QRyxEWecc3LYdo=;
        b=Y/Wvt/7a4Am55JzXa9HoEyDMYICHiIr9PkWows4PdIGunA+iguZ1KgUzNB0B5E9Wj6
         XXnQQoa5gB1Fgc84RwOs4WWy0l8SfCu5fU0lHxh6pU00e8nxwTAH/IuXN4XwmNMcB3Zw
         lPPWFXEd7KgBw8vPaE5j925HxxDCPVh24B/18Hq05zCfIYN70sNTnfn65vghO63krnNP
         DOaPNTi2nwOhfCIxeIoUx+/uI2w8nTimLgvnpp2xX8gX/mAYV3bC053g5pDayn5F22wO
         bvKbIxKoUkv8FBD0tsNrpMi3Y86J7HA9GbixQ1QqXU/jb90g2GCaPebzFzq6OGOwZPtt
         l8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gjMFPbNgKd1Fc+yJ2WMlD8bStAd2QRyxEWecc3LYdo=;
        b=KOD5jXN5pl/HI115YlAwOtG/Fjr2iThM9G7DWsTezPZOS0RNMqknJcmotEon5vwIsa
         Haz32A1H2dCPOPWvgt9Aeehzmjldwl6h90pFlTs/o1ZPAj6G9lERrCQ1OL2Z/O880mfP
         GKCmbAicnbSciJI9r35u8WRUrhlkZh3OGiQPE/HUIQjg6tr1qG6XPj4K0R0gKM128LUp
         gb4sju8jDsNDsJKS3psSuVnY6EmGKxclzN5JZD+PT/ky+lhR2C35XXo1ytfAHb4bWNNC
         TPNsw+Jc/rBFK+4RrUC//I48tYBNhazyQeE1SFS7wOjrA6b3Yxkn3GiPkmGt7fBvkm1z
         FwwQ==
X-Gm-Message-State: AOAM532Ds5uQWPcst1h7HIc/KYe7tmCYDI0ZQ92bIeqSOSABw3C/weS+
        z5L52NECsFZAuTHCMZS3lhHtDg==
X-Google-Smtp-Source: ABdhPJwyZw5i5quvytzLgQRMkFwcPhdAZHq7eSXE0uyLKb2AFLds0r6jS7vN7MYNsoo1mggWoWd9qw==
X-Received: by 2002:a05:6870:7994:b0:d2:cc3f:5e7 with SMTP id he20-20020a056870799400b000d2cc3f05e7mr7221024oab.77.1645736051447;
        Thu, 24 Feb 2022 12:54:11 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:10 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH] soc: qcom: mdt_loader: Fix split-firmware condition
Date:   Thu, 24 Feb 2022 14:53:58 -0600
Message-Id: <164573604161.1471031.13709791424620348092.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215034819.1209367-1-bjorn.andersson@linaro.org>
References: <20220215034819.1209367-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 19:48:19 -0800, Bjorn Andersson wrote:
> The updated condition checking if a segment can be found in the loaded
> firmware blob, or need to be loaded from a separate file, incorrectly
> classifies segments that ends at the end of the loaded blob. The result
> is that the mdt loader attempts to load the segment from a separate
> file.
> 
> Correct the conditional to use the loaded segment instead.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: mdt_loader: Fix split-firmware condition
      commit: a1b019872693c74d919db4e267f451fc7af9a21c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
