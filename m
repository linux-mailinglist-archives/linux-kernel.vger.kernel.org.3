Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB755DF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiF0Nt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiF0Ntx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:49:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91CEA1AF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:49:50 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so5663517wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yMnxEKpvmFxR2GNeUIkzTabL3UvC0Sa91WFWMjfUKHs=;
        b=uzMij9J2nJgMYCxwFHT0Rs5usnbl+5VnHMEgcf8WsH5/Mxg8TuOvdImD2WHu/xbppU
         YZARXM36QRCvHnxYkJ/TY4f4u/0lqzWCYVatrdhm8IjaWKWwnDFLq7ady/SMJ1H0eMD5
         IzYS7cwlYYOJY9Hb/dlQuRK4gBho8M2Vs0dFv5ipu4KdRcCiteFNLwxsb0tYixnaPD8n
         +Bl4D5Q6jtL+oLMrKDCOurA4ja2pY303dPXaw0i44efbrDc5adrwkgWX6DviLpA4lXuv
         hIlsqPcxoXZDTFoKgNy8f4b8+kd1ybybJIyphnONpwZo04rtUombakv1sT2jlbIZUK2p
         rVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yMnxEKpvmFxR2GNeUIkzTabL3UvC0Sa91WFWMjfUKHs=;
        b=NKXnr+2x3+BqsKjrn6p1K+Wl+glOy+24FH2kcy33pY0O4BBXzmcMbEx5pKwrGl+Hve
         cRtYw9aXiWm1vCjrfygwsRLCrqwNW4izUeVCm/+XQBN4MdpD70G/m3ji2Z6sv9cuD/d/
         queY2jdIFwdvtQTIJ3CuDGsnJ6Z7UaXkWeSTCQ/X7KCwmFl1W3vGP63GfojwC3jC69Na
         nNUPhbbxq+p3Y7LaETDY4kXd8jm2cIHKSlgzvsEhApzZnu/5QCdw8p3ZWT/cFtjrYZC2
         G0atBm/g5sCsG/tPJCsyrRx5WRGPbkvk7LqxB3UAdBNVVld6FVaoJqK8PmAMW+L6XgAL
         8nxQ==
X-Gm-Message-State: AJIora+5+7k8S3/HsLSiH8s4+AU8XBNJ8lG617IFNLreV+II0CBW+4Zv
        GSCrbSiEh/YpkOkH7iWwNk4ZJQ==
X-Google-Smtp-Source: AGRyM1uh0glNyLsANMQNLVLq8huGqKWmR0mR/1/tQU/4tUCnILOrg3qd6LHKJq2QM+JFqMl8YzKOhg==
X-Received: by 2002:a05:600c:4e53:b0:39e:e5c4:fe9b with SMTP id e19-20020a05600c4e5300b0039ee5c4fe9bmr19610124wmq.109.1656337789473;
        Mon, 27 Jun 2022 06:49:49 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b0020c5253d8fcsm12540474wrx.72.2022.06.27.06.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:49:48 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:49:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     yilun.xu@intel.com, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        russell.h.weight@intel.com, matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v2 1/4] mfd: intel-m10-bmc: rename the local variables
Message-ID: <Yrm1e+kC/lo8PwDS@google.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
 <20220617020405.128352-2-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220617020405.128352-2-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Tianfei Zhang wrote:

> It had better use ddata for local variables which
> directly interacts with dev_get_drvdata()/dev_set_drvdata().
> 
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/mfd/intel-m10-bmc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
