Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB73754D3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347718AbiFOVoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiFOVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:44:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432DA31931
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:44:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso3245448pja.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gZ3udpFK2SaT9vmCeYN/wpvWhWsIcBFwQfLTZsfUbnc=;
        b=C3ad6DKQHGNJK4jz3m6jxUEqWb680HAOKQA466+BxsDOB1m0gXHK5Vx6KI2rYILqMa
         upDdvO0Qc4ZWYw9C/78Vg6pJFI/djX6YJpJRyYQHOjokBwIWUERWWDDGjUptbm1dw91Z
         vriyGs9Mzp891tyKVDuMfVKFX3d9LEGVg0yw2NMrQJcXfwfaZMyiCXIlyVd0x80b+03P
         hd5RNg5ZyEeN1hr2ixSV3Nl2lA2QMjDIR4ACuoVzuc2iGz4vixcDbTLhkJat+Zp7c3MJ
         3rHiFF78Kdm1l+OKUr6krR9jtshunqBVgr0ydrygYJ0bikFwDzJmA9r861lpYfBWF3sn
         bIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gZ3udpFK2SaT9vmCeYN/wpvWhWsIcBFwQfLTZsfUbnc=;
        b=eAjNRWCjBf3YwkY19G6MgCQlZKvV2o4nqe251IcWlbV/7xncMnMUs5YHQlFvIg7a1T
         NM0cRvaga25H+XGoHctFWzmjJD1M7ocIqbcPBqYLQ8G/Lk5mB8fbg9i4RU4lxpwRQ+J0
         5KF9R0hGtLsY6P5tjfvLW2yhgVc1qaPrS074jjFzqjG71Ewisyo8GAqAd9923XC9L+ob
         0q0Zc3grsor/6Lqzsg80notpPlHZcXqUCjfzi+GcP9XOytJyfxf6QCndmZND8E48luZU
         84jMRqz6mYzBGYvlRLqH3zAXsgyOVpBzSRHHV9bCPCj5eL7wFyT5XaD9F9/ZwRlNqRYi
         hkNw==
X-Gm-Message-State: AJIora8vvIwL1V03EiOOJMYBDWG3bAWPjMMdwDHw1V8rQtZ4UN3Gf1mw
        s44H4lge9pe9IsRfFA852Ts1Dw==
X-Google-Smtp-Source: AGRyM1ssuxbEJkVMFnpbyqduhBRlE67GpHDcR94vAKkxGGt1An8/zFE12jM3dTNF/3KStbYKvU4yog==
X-Received: by 2002:a17:90a:5ae1:b0:1db:d0a4:30a4 with SMTP id n88-20020a17090a5ae100b001dbd0a430a4mr1554816pji.128.1655329447759;
        Wed, 15 Jun 2022 14:44:07 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id i66-20020a62c145000000b00518950bfc82sm134050pfg.10.2022.06.15.14.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:44:07 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:44:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Mallikarjun Kasoju <mkasoju@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Fix refcount leak in
 max77620_initialise_fps
Message-ID: <YqpSpYUg4BIiy2B7@google.com>
References: <20220601043222.64441-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601043222.64441-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2022, Miaoqian Lin wrote:

> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> Fixes: 327156c59360 ("mfd: max77620: Add core driver for MAX77620/MAX20024")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/mfd/max77620.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
