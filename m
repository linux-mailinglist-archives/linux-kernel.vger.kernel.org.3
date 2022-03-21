Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67C4E2296
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344247AbiCUI5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345482AbiCUI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:57:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44F57485
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:55:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m30so9836848wrb.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cO7AjDjeJIy5Qpw0zFf/SmS51/Q6KU0hyMEE6k8MFjw=;
        b=OfbaYY90jqR7DZF9ctMaTAQhlRWGusytHu/XNiNObeiYtmHyF40LM79m3mobnIWzkX
         7IaRCKvT5utAMqKrDRB8T46NX85oH4k6klPz6aGfQRsYVhOMLLtxHNGc0V19PgrW0ae8
         Pboo5lIrHEMt3tsiVJ7uz7Wc8ttkL8UlHJ6Ol+wCOHPRJZLv5uCAa0xDEzNgV+qhJq8a
         k17NOHYSoeL9QQhc0qwItq4tKcqUXiILGTSmQDT5lZb6ktmgqda0JhkN2ZBD+EEHzcDu
         IwDx5ZeRHpUoLXssdAyhyIv2m1o/LihvJRQiP/3HF0uTkPkkFd4SEs4ulyy6wLKulwFI
         5sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cO7AjDjeJIy5Qpw0zFf/SmS51/Q6KU0hyMEE6k8MFjw=;
        b=kgSttI09kAeD4h2ZNmvqmtoseBmydZdEyZdtJdhh4oSMsGyIgpe+xbiIvXcREvFnEh
         ZsHbDAkN8w+Ne9q364vyu73upXegcvwN+wsJ9n4ZPXz3EyJHcyOm0v5aSy0hHyqFb71y
         Ctyz6KifxQzGN7VEW4ROnts2G0O1QY2S7rti9VqALEEMkm+nNi21u6xIVkuw4/cujD5Z
         LcTb054to5AbF8RYPHxU8wkLrx/RkUaPOCAukYxwrMpvjc9IN0InTJ69bxD3swjwQSRR
         SkA0blVDNodY/Iscw/xavwpkCccoPMz3UQcrMx+S0xgjlCMy21Dg3vwNWHjsHPJsZT8F
         7YWg==
X-Gm-Message-State: AOAM531TnORXajXhODCuNbrZ/MyY+yX8JrRiPRkkf+c8yKwrsk2+KvKL
        HFjGsK/lWQ2EWW1oTG7apmHTXjAlrv/hAw==
X-Google-Smtp-Source: ABdhPJzykKwMAclLaI4xDjTMsM+VxRcLKm2a+AU9zzxH+ICQUL/AelSy/MKJtNlPh8FvgENXUUQ3OA==
X-Received: by 2002:a5d:5148:0:b0:203:d72f:cea2 with SMTP id u8-20020a5d5148000000b00203d72fcea2mr17118105wrt.306.1647852945334;
        Mon, 21 Mar 2022 01:55:45 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm14563408wms.25.2022.03.21.01.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 01:55:44 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:55:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: asic3: Add missing iounmap() on error
 asic3_mfd_probe
Message-ID: <Yjg9jzeHl6W6JFeZ@google.com>
References: <20220307072947.5369-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307072947.5369-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Mar 2022, Miaoqian Lin wrote:

> Add the missing iounmap() before return from asic3_mfd_probe
> in the error handling case.
> 
> Fixes: 64e8867ba809 ("mfd: tmio_mmc hardware abstraction for CNF area")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/mfd/asic3.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
