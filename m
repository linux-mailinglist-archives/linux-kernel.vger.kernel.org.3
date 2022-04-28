Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E26D513075
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiD1KAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiD1J7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:59:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65213A66E3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:47:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so8433232ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=wWR0SKL64pnLD+2RxbQHe5x2swIM4L4QdrFCGmGjULw=;
        b=EdxD+YkbyRfIBBatIq1RZQMAfdzNFEx6lUYzVLMwcYkVGQQLi9LRqWdvlrpjOqRB7U
         cQ9kqTs38/XtJ2Kc8tbUnL2na8IA/ypvLgKK69LfWdCkSNhaIOwLHJKmtRmQXPHsjFLe
         BK5TP4gEoFOK0Ifc4Pb94CPDYEyOcZEiN9nrT4mH32ytZa5lO84tnw6k3jihSZ8ecIFV
         pxG0hVP/atAlzbxX+ILItYGFr2cIHeMlqqnIJvIJkri4O4Mfjx4t6TFj8ZKXpIRBg4kP
         p3eg8qu49Y5UPdJpdODj+eSauov1PrnXFLDwpaUAYRKUnKM/9g/DLWcOijW9wh1uTsPS
         3sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wWR0SKL64pnLD+2RxbQHe5x2swIM4L4QdrFCGmGjULw=;
        b=5khNoebNP1GF11DxItBFPz170DicUe5CjiqO99xznM/0bnsoxbnt3szSFaCxvqM0bJ
         bOaosy5oqqQQzMTYiQb+Tpl61xA8OwYOMfUEviDb99VHAADP23CdZm2r+5SNAjyCGqsG
         sN7yBhmxBk2xqDPKSsWHvc+sc9NBD9rFkAKeoQWzaE6owUi/626aN+WIEXpdxaCYjO8p
         uIHCW011ClS2P0wGfnlqcs5jT6Srb5ndBlO1pmLut8GhUpKIZRo6HBjx/gRnzEm4Pl06
         Q+M83pYW9ZQd9uHRgp1CGeyNyXuanxhkTEM2ZysqXdzJ9w5OdMbpztVjsxofhxJ3qJCl
         U+Lg==
X-Gm-Message-State: AOAM5324KGi863PlqhL7Gwr3YPl6bsiOHtVbGKfnmhrWfJbQXSy/i/sN
        siTDb1L/rQJ/7eekUtmv12VlUw==
X-Google-Smtp-Source: ABdhPJzAV1lVi1Qj3A837ST82rK8dtlvg3nSijyuX7w+cVeLMIEfPtmGM61KSFI2SrT0WVvTNB5VTw==
X-Received: by 2002:a17:907:8a03:b0:6f3:c842:f018 with SMTP id sc3-20020a1709078a0300b006f3c842f018mr7254999ejc.277.1651139240902;
        Thu, 28 Apr 2022 02:47:20 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090666c700b006e8688d5fcbsm8113791ejp.135.2022.04.28.02.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:47:20 -0700 (PDT)
Message-ID: <dc088719-d8d6-2405-961a-1975b7f62d57@linaro.org>
Date:   Thu, 28 Apr 2022 11:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] rpmsg: qcom_smd: Fix returning 0 if
 irq_of_parse_and_map() fails
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220423093932.32136-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220423093932.32136-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2022 11:39, Krzysztof Kozlowski wrote:
> irq_of_parse_and_map() returns 0 on failure, so this should not be
> passed further as error return code.
> 
> Fixes: 1a358d350664 ("rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> A fix for: https://lore.kernel.org/all/20220422105326.78713-1-krzysztof.kozlowski@linaro.org/
> Commit sha from Bjorn's email, so might not be stable/correct.
> 

Bjorn,

Can you pick up this one? It's for an issue in your tree, introduced
with my previous patch.

Best regards,
Krzysztof
