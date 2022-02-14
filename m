Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DB4B5334
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355081AbiBNOXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:23:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiBNOXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:23:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E0AA18D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:23:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so11786260wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vdZPhzMc8OOpbl2UuEs2+SUCoZTK13ldzN1cjH3Gy1w=;
        b=RHdXdgJ2LBE2w7jY+8RfeUnahKmQDX0wrZL3zQcT8VazOJXtScZE9D+jdPlLAAwMcD
         4c3Nu4EuzuFca3UyVr1fZNAIFrDRsnSiFX1QnpZO7SR3V15BPsdLbM95gm3NbENp+6o1
         /lAO9MQBWVVZ/mtr/3x8bf5SCPORJjb5uh7GPT1Ou7jTpft2Vm6fT/+9HmuUB816xXh3
         9n2te1iIrB8kZkuCOr7o9d3xCuZALY4r7B+p4cu/WdTJp/ONaWSQwyHAccxgW5Pe5Gso
         N8wuzD4WFeL8kdGesEefaEMILjY56iSc0FB4K8B49YtyYlBZeQRmDq97O+C0ngyUKOQq
         WM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vdZPhzMc8OOpbl2UuEs2+SUCoZTK13ldzN1cjH3Gy1w=;
        b=SG3Qv85IQuhDcRCOcoNRT3+hweFBmegAvzVjwOnR0Yn1GgsJR2d5TIbizYy0DSH9Ue
         B43J/KPnAHK9dbbzU6XyuS9dHhZEZeZzPDTh4MtIIU/tqTKUhyWDVOp9KP/ZiKVHf96a
         +cJNImCHrk7J259aS021RF3VxMFURxRYJPlV5NHIbwY6/kIVPRF8o8Alfy63tI2RdiOi
         u9y86PTS5FX1ha3bmfRNfG28MSpbZ1N0AOr5r54aS9d0rYfC8ixzLJblc53nWV2Y+eUR
         5eN1fkqKNqYA0xVKOSdbwMJY5VAg1sa6uh09JIe81VFVv0wOSW1cWWMM4fHBfHUiBpig
         bEtg==
X-Gm-Message-State: AOAM53008Q3Ye8Al9l+7mvYlXfRHhCEZT7nbbQa8TpKxojO3A5M3BOjH
        OGfsthBZvk9GAz85K+qost3vPw==
X-Google-Smtp-Source: ABdhPJz1ZB2k7y7XczgS1kVpyE+TpVQk6pZ5jgDQ1a3FTos5TRkuSJzEvca4MVay0vYYHF1YKF60aw==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr11388048wmi.33.1644848581602;
        Mon, 14 Feb 2022 06:23:01 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u12sm27154831wrs.2.2022.02.14.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:23:01 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:22:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mfd: rk808: add reboot support to rk808.c
Message-ID: <Ygplw6AbXptTLETT@google.com>
References: <20220208194023.929720-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208194023.929720-1-pgwipeout@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Feb 2022, Peter Geis wrote:

> This adds reboot support to the rk808 pmic driver and enables it for
> the rk809 and rk817 devices.
> This only enables if the rockchip,system-power-controller flag is set.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-for-mfd-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changelog:
> V5:
> - Fix length of error print.
> 
> V4:
> - reorder rk808_restart_notify (Thanks Dmitry)
> - drop of_property_read_bool before unregister (Good catch Frank)
> 
> V3: Thanks Dmitry!
> - Adjust priority to be in line with other pmic drivers
> - Move ret handling to case switch
> - Make default registration debug
> - Add unregister function on removal
> 
> V2:
> - Squash the patch from Frank Wunderlich for rk809 support.
> - Remove support for the rk805, rk808, and rk818 devices.
> - Only register the reset handler for supported devices.
> - Remove unnecessary dev_err and dev_warn statements.
> - Register the reset handler directly
>  drivers/mfd/rk808.c       | 44 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/rk808.h |  1 +
>  2 files changed, 45 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
