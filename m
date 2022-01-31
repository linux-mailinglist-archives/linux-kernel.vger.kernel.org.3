Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2068B4A4B78
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380172AbiAaQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380103AbiAaQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:09:57 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B0C061401
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:09:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s18so26362808wrv.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dc+7Q1INlJwR7rIgdQoQe7YoefArPg5VFkbjq7Cmcuc=;
        b=j8BOTkGpRWv1wL66VnXXlpgNpGXuQr42S0fttYeTRo2S2/M3KHGbbtZeyNsCHyEuwG
         vg30zpfbpOcHQOtZfrDq04Lj86AwsjKy6qaOBPW7v7P3W2MWW0DcG+kCbt2hO/asIg74
         p/TaIeGuD+Be/d0wsT35i/T2eVtn2J1JHMndJt0QtmiLwfbgNHQcRe1OjFX73yy896lc
         upvziCDRdVa1izfH/tp1pcvuxrkcrrj0E6/PqiJdkV/CxjhMIsphnzUYUcpMu2IzukwA
         IswqWK5RPPqGM7AwQBuE81es76dNdGShEYeQFHXZkQvO7FnVezrbDxovWxQmhB5qFHt0
         XI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dc+7Q1INlJwR7rIgdQoQe7YoefArPg5VFkbjq7Cmcuc=;
        b=4CCKTgl5rd3vOl8H25G0Uc7HKcc3fb7YriD9pgSbNXH8CaKgHZsclPuWEQppEuu6Sj
         SvmJZLEfn8j87ox6z1V8xV+kk1d1/MGQgNgYAooju3Oeb5I+I6MMbPLsvKndt07XhNwz
         DZmMova5DUXIxuKomv2u30+Anuz3DH903dufaUXpBi8d7fBeUYYIdJirVK1S6m5/iwZA
         CaB6cg19w2lRRDhzzPu9tLVzsroANsdIWJFROqQ/i36qvF0M3aOQyJFv48xikKJahpmJ
         nfiAFoCS1v3BrL9TFt+wS1N8YPNADggcEk+J6rmyXyXSYUo4RxuiBwgjxQhFFMqVUbUL
         CObA==
X-Gm-Message-State: AOAM5307z2U8TvXKH02fxNBc8POwD6ZkB3Wkxo3PXmCHpgzSlLU7AxDh
        KSMTzSNv0fskuEZ6E7yzaN6S5uf1JanVHQ==
X-Google-Smtp-Source: ABdhPJxccQ3PG+gEEP9CdZz98SccUJB3wmWGuFG/qiEwEXSkE3mkvFLtJhk5fTt3lshIixzMmINueQ==
X-Received: by 2002:a05:6000:16c5:: with SMTP id h5mr17862565wrf.364.1643645366379;
        Mon, 31 Jan 2022 08:09:26 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id j28sm6184185wms.14.2022.01.31.08.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:09:25 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:09:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: intel-lpss: Check for error irq
Message-ID: <YfgJtEnqriDqLjcV@google.com>
References: <20211224023352.1494463-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211224023352.1494463-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021, Jiasheng Jiang wrote:

> For the possible failure of the platform_get_irq(), the returned irq
> could be error number and will finally cause the failure of the
> request_irq().
> Consider that platform_get_irq() can now in certain cases return
> -EPROBE_DEFER, and the consequences of letting request_irq() effectively
> convert that into -EINVAL, even at probe time rather than later on.
> So it might be better to check just now.
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/mfd/intel-lpss-acpi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

This patch no longer seems to apply.

Please rebase it and resubmit with this applied:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
