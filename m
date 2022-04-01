Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3C4EFBF3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352689AbiDAVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbiDAVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:02:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D321B254A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:00:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f6-20020a1c3806000000b0038e4a0fc5easo2191593wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Nfe9G6FAXY/E/AbmQAdSvRU9IORQQkMBI1TaVXtl0I=;
        b=ehFx1CZeNauNPlFJDPhsoGXqJb3EGKznWsNWXmYtJm2Na6JRkBguhTA52xhCey8Ejx
         CUvRZmh9SWpsgjDc3W0Y/ZBS79AbiCQvaq+2UHKJuudI3ZnZstW5wGzAI+qPtEe5XD07
         drxVG8g1aUPzVzzSPdP6+Ve+glSHGap368kgnS5tW3VYzFiF3PG555f4nfT1Tu91P2jx
         vs9p24XHMfSd7lAUvzqqOFK9Zh6WCBNciTwnR6sZvTv2xVHwJrXS/96HvBN/ku8Nknkw
         iRriKxEMXLdWFKmnL5Nc9QVS5bCTovfNobAt5dVkY9epn/pEzxZUGlD2n3GLA4BS5vp/
         ZZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Nfe9G6FAXY/E/AbmQAdSvRU9IORQQkMBI1TaVXtl0I=;
        b=Lba/EnuJ735rIyoetkdxMpmnUTKc/6R20hiboNV83Tpx/SrLWNpwMDavFYf6zB16ap
         JRFDqlsVTcRStb5okNcPfcPxSyROIIv5cGSUcvSaFfziKdc5z7X7AxV+e+C1EMr8Ntqp
         VkvVU+yo3HerPfeszPjQ4MEwftXHSmouiTbtGlCwsM42y9/CCJj0issmCCRCvg2+Z3YN
         dk19Iv7DYyeV6Z1wPxIgX6mfiPO6rMETD0fnt4DnRYJL9LSQfKVyj9MKXct3ZcnaXKLm
         khKB6z2UGsJCXNWaeS95DAypU2CrRb7vyXG28zzZ9OaP155ZlR8zcjjAJQ9HQBAESxhz
         eQ8A==
X-Gm-Message-State: AOAM532Re8GUzxvqwPkZLrGeTIQOtFDsFMQ9fz6IF16XIBeQjGe9MHQs
        fR5vRWQC8AtdQkRgy4pKRj5zaw==
X-Google-Smtp-Source: ABdhPJylXTtpK692bqz4KfNgI5xyVNjcHc+ugaJ2/3bPUryjXJPVzLcLU12s/iWShAy+/1hfqoWlbw==
X-Received: by 2002:a05:600c:5106:b0:38e:38f8:858 with SMTP id o6-20020a05600c510600b0038e38f80858mr10027515wms.109.1648846834887;
        Fri, 01 Apr 2022 14:00:34 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d6c6f000000b002040552e88esm3479405wrz.29.2022.04.01.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:00:34 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     lienze@kylinos.cn
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] cdrom: remove unused variable
Date:   Fri,  1 Apr 2022 22:00:33 +0100
Message-Id: <20220401210033.2078426-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401032623.293666-1-lienze@kylinos.cn>
References: <20220401032623.293666-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The clang static analyzer reports the following warning,
>
> File: drivers/cdrom/cdrom.c
> Warning: line 1380, column 7
> 	 Although the value stored to 'status' is used in enclosing
> 	 expression, the value is never actually read from 'status'
> 
> Remove the unused variable to eliminate the warning.
> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  drivers/cdrom/cdrom.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

Looks good to me, thanks for the patch, will send on for inclusion in
5.18.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
