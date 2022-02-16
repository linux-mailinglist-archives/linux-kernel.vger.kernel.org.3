Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03564B9260
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiBPUeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:34:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiBPUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:34:11 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E52A39E8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:33:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x11so2872202pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iwe6dEk//R9IuP/djM6G40dVnul034jHIp8QF8r0XR0=;
        b=BrGmYaDzFVlZCLvN5Oth2ItnzMAlHs1DOQ822SesSK2Oh5jI6qS4aqNad+42EY2kKb
         Ia8+hSaZ4mqQi9XOqxajxbt2sLo9H9by+N/WHQcxUA1yFiFYk9ATeu2f1uttgqFYOcpr
         x1RktQZKgCy5KR+NplaKdMWCDgeigYmlySNcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iwe6dEk//R9IuP/djM6G40dVnul034jHIp8QF8r0XR0=;
        b=vXbvHK09BU4eK4YY6eyEjLqXnADdxVKweHPiA7BUeUOCaIkpJNFETyM0gwv4jbLiSf
         63RM66QB2mu0J4AZ0DnyfB5JKCIqS3s5YChwQmhFNMx081FndxqHZWQhsc4nDP6Bh2Zo
         YwrYGF4v/Eo0p+qUABP9bVGLHnvWJAJ+kHEvsDOnqutCT2O3TfwNXHuOR/QiG3BFl8DH
         BqQkoIWRU2l+kPTS97ADmm6VlBLiM9W1PlYBrkrSA5qFFrQS6LQ8or8boLwsK2ZOI4sR
         IXJLYfmfpwIVcTUME9+mVl6nZdRremPh4nV+kK2CG/FS08y1NRTYh1k+Fm/VXR4L3GAC
         +hPQ==
X-Gm-Message-State: AOAM531oYxZtd4kw+JUMOPoQoaCeyPAq/qRmttUsT0MD9bAWLFHOsmfk
        uNogu+PzhKL9Sp02lOLcRdo89Q==
X-Google-Smtp-Source: ABdhPJwsH0zVt+LsoY8rw3hePDyetrBIK4AyokHSO8tVCiAs2LgBt0S1V97Mw3awlO8FX1zTwc/+nA==
X-Received: by 2002:a17:902:db05:b0:14d:743f:5162 with SMTP id m5-20020a170902db0500b0014d743f5162mr603116plx.12.1645043638779;
        Wed, 16 Feb 2022 12:33:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m21sm6259992pgh.69.2022.02.16.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:33:58 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:33:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath10k: Replace zero-length array with
 flexible-array member
Message-ID: <202202161233.805BB2B7A@keescook>
References: <20220216194807.GA904008@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194807.GA904008@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:48:07PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
