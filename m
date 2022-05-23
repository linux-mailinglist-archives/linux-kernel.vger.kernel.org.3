Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE695313AE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbiEWNxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiEWNxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:53:08 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4056752
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:53:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso6648160wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hYz+BGWmdKPcnajoQYArJm62UyMaXPsdRMfrhJq1psg=;
        b=YHWVWVvTrjJlS/kCzbJkwZfqPbFhI23KaAikwdc2cAfIssHJUcX8HfqnvAPb0skTwH
         0wkPgPhWSLIaGVA+vrHKRuys1yrRizf9qw68An1EGBr70llgRdTMpvf510+uyYPVR4pR
         VbGVFZf+/l9e30Jtyt7nZ3VDWnA+qDM7CxMli3AS3JBlRaYULrd82shS32pqtG4ZSRuG
         KxbKm1YZ5ZawNnKUz/RTZrLk5OgopSa4ss2hfU2o4Qe08ZLSJppcPGGhFid5q8fIzPKK
         Sw6aGvE5p4nB57itLGsIogu38WlSUrFx8yZqZq1SpHFZC6mQJCD2Uw7yZBNH6cFck3aK
         ycKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hYz+BGWmdKPcnajoQYArJm62UyMaXPsdRMfrhJq1psg=;
        b=ONr8695lptfot3Hju1CcLdW+Qq/OnfloSNy1jyji3FfFeAcNRzKoZddb/gp1G+J7xs
         6r91exr8TB1hZ8VDgZ6n0Qq/oTPkV3EkZoTrru34neNsybpe3Sra1RHDTQqQFZwytCex
         IJcn5JIJaG5JqU1T+9bq6EfH061g1KtW0A4kXtLZhIZwpDzum4KHOEdFSy/tDhulxNJ9
         HLGCtC2p6HpWJTo/gFa7AjRxKUeE0WQik/5MLJuERF7JKpKL0swYMsi6N8dWfr8AjW2Y
         CQuu6ap1zag8Tzyu9ciBr6lu1Lo3ZDEl35lP/MkqBGjc6OgskGGNkvh1W6y7hnNfgF42
         QfbQ==
X-Gm-Message-State: AOAM531MYo+7Y7V2mnkX5usciV12rHlEMwDwYZJSbbwRId0F+HA1xqvS
        Nw4CSaxa5+a10gMZ6OxsB0YJ7g==
X-Google-Smtp-Source: ABdhPJz1ByRSz/VJ/174YCvc5HRXuSowBluHCuR0oYWDuH3FJuftk1qpJfPNvlyg/XneRRkeVBvtLw==
X-Received: by 2002:a05:600c:acf:b0:397:345f:fe10 with SMTP id c15-20020a05600c0acf00b00397345ffe10mr16998619wmr.15.1653313985846;
        Mon, 23 May 2022 06:53:05 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b0020c6a524fd5sm11881482wrb.99.2022.05.23.06.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:53:05 -0700 (PDT)
Date:   Mon, 23 May 2022 14:53:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, nsekhar@ti.com, arnd@arndb.de
Subject: Re: [PATCH] mfd: davinci_voicecodec: fix possible null-ptr-deref
 davinci_vc_probe()
Message-ID: <YouRvxARt4ZWaKIp@google.com>
References: <20220426030857.3539336-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426030857.3539336-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022, Yang Yingliang wrote:

> It will cause null-ptr-deref when using 'res', if platform_get_resource()
> returns NULL, so move using 'res' after devm_ioremap_resource() that
> will check it to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
> 
> Fixes: b5e29aa880be ("mfd: davinci_voicecodec: Remove pointless #include")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/mfd/davinci_voicecodec.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
