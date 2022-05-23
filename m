Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676D531322
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiEWOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiEWOIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:08:21 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA8A424B7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:08:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z17so1991402wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kSCKDXwEEunLOsamUA7LNSGFHLKFqgNb3gX19KhjkC8=;
        b=iu+mFkYp5zBqhcUjMzVm8Tpj9X9vSwLz3IJalNLWsIvwu43zWGujLqGvAxraMdw+Sv
         Wdmmc3lcjdWjGWrHh46HrzNEubOy4olomrSlWU+Iu79BCXCoM12Svsciijh1ivtb1A3W
         xievkWFOPlr2DQE6nHLmK8nJMwxGVmd0hoJnZCfUK1CowlZi83u6dNjwhnMgjb+jIN2Y
         gdv3Y+H/PvOqDSxtyrOy8zFduH0Ri3kiRLIerg8bJmvLFJ08Gg1WgrdIz/iZ/O5pvMRZ
         KbQD+VbD5faOby66iuVU+sMyu3DImPy/TxUVupCZuNfejxQneAk62RHGdYLKTQ/Y99VA
         Wqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kSCKDXwEEunLOsamUA7LNSGFHLKFqgNb3gX19KhjkC8=;
        b=ZenW+akavojsKjptuQLFgyckJ281Ul+pqJW177PauTax91GU6NTV6AvlklbaeNQulK
         hJyu4P+VgCtjgTOXhUpnbSiHyMWVK+CV+9cYnNkotc6layDBRHF2aJk5t9auCv1TE3tn
         ldw5Um8JDRABbA/WClInEiQxrpCr3vGcV7sWWVyNoRDeRPrVHpc+pTNDe73JyxfUHG3R
         vano2UCgRSbXEuH9FFHORSUC0KCXbCDyo4gJjeQbao2KTUvizAunhp3u8hwrfHQn8Bvv
         4S6GkFWNVoRKx7iGNnMTirDAsrWRmuRRsh9Pq+tFKfKEREd5EjpOCbkT36EeE2mT8UF+
         ksMQ==
X-Gm-Message-State: AOAM530Sq3gMLMtxHiXXWzD4V1UnCmU08937ghZ+8wvvzHr7obU4t7Sx
        4am98Q46xW+m+VwL9LsBVhTOVw==
X-Google-Smtp-Source: ABdhPJzOhn5A+SiWzdh+V/J9geib1g73WqHWDbVTgfRYJXw628Nf783GozEqC+kmjp1j+fHhz/BDcw==
X-Received: by 2002:a1c:f717:0:b0:396:f89f:897c with SMTP id v23-20020a1cf717000000b00396f89f897cmr19724234wmh.165.1653314898749;
        Mon, 23 May 2022 07:08:18 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bd15-20020a05600c1f0f00b00397393419e3sm8578160wmb.28.2022.05.23.07.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:08:18 -0700 (PDT)
Date:   Mon, 23 May 2022 15:08:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] mfd: rt4831: Improve error reporting for problems during
 .remove()
Message-ID: <YouVUAsimQj79pyK@google.com>
References: <20220502191012.53259-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502191012.53259-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 May 2022, Uwe Kleine-König wrote:

> Returning an error value in an i2c remove callback results in a generic
> error message being emitted by the i2c core, but otherwise it doesn't make
> a difference. The device goes away anyhow and the devm cleanups are
> called.
> 
> So instead of triggering the generic i2c error message, emit a more helpful
> message if a problem occurs and return 0 to suppress the generic message.
> 
> This patch is a preparation for making i2c remove callbacks return void.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/rt4831.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
