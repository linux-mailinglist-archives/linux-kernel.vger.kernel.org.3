Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CB6557533
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiFWIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiFWIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:15:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF24830E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:15:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g26so17989968ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=P+XcOEy9p1h3Fxh8Fy1822xcwZda9M13RTFNQq3+31k=;
        b=rwI24HMje9XFQhcuonhk1e2/rCsylPS/S5Wc1sPYxyasnuPz/ZfpDr9lYgAe9j3E5R
         fw9A+hD+RXuikn2sI2YQzHUot+5vcElzYFprvHJb1rs4W2kOFQWDqIWbKr422o6KeBcB
         eiSVLkWYNRM31fU6zpGlSmPMpHN31WqaMWDZe9HMhmotizbJNycTUoHu+aZx/iPWQ4Vk
         GteN5RtBYWN1SY9BDy0NUy6/yaRqINJwN+Y6s3unycel+TO3pRcaaMXDi90YpRy8+TRT
         E+CEW3pIwkVm7hlRHAn+k0SZCH66HEjrksZcrmnbHC4ULW7904wDyONWWY3IYM9YkN04
         Ys/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P+XcOEy9p1h3Fxh8Fy1822xcwZda9M13RTFNQq3+31k=;
        b=2Ho+FJlFiB9VFEj/Xe5kN5QaGIwJK3gn5ZcW9vvoWo2+KR181dTDSqz8PDwk4hZ2K9
         hvHXJ7vUDdi+H4imeDRPm5dJ1pV4zO5sdj437AKAOyfxDN/lsSaW399v965cDQSse3Oh
         kN3VigsZMez2FBCmdrJNg20g21nN5yEpc68XDerZp8+WY1oM6RaParkXeaYSLarE6XdJ
         lDBWiMrbccFArfCYgUOjXMO2Gbukltcd+w2ZxzfyLO30ulqpoaR4GY0rTotUTxVQxWIv
         4GuL735NURFnXkGfufXxc5/xvMx1k0hWUIm2IxcRzENMOCNYdu9xfuqUr2u4fQQHwEzd
         xsDw==
X-Gm-Message-State: AJIora8RXWml5mdY/h26RdFtMizbIMXZZcH4lK8xH3H3WaYXw3YWsPxP
        PJg/5wVcRlaguW3qfFBs6x8D2A==
X-Google-Smtp-Source: AGRyM1sJsRRh7W2dyDuAB4R0FUYB9AuoqmYRDtX8CqitjM7Y8647bAZjIJiUGwsOUhaWiT1RF355LQ==
X-Received: by 2002:a17:906:6a1c:b0:70a:fd95:ee6a with SMTP id qw28-20020a1709066a1c00b0070afd95ee6amr7050360ejc.36.1655972134214;
        Thu, 23 Jun 2022 01:15:34 -0700 (PDT)
Received: from [192.168.0.226] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x16-20020aa7cd90000000b0042fb3badd48sm16552125edv.9.2022.06.23.01.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 01:15:33 -0700 (PDT)
Message-ID: <050a390d-1ede-04ee-3870-9434ffd671b8@linaro.org>
Date:   Thu, 23 Jun 2022 10:15:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Content-Language: en-US
To:     Hangyu Hua <hbh25y@gmail.com>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220623073605.27386-1-hbh25y@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220623073605.27386-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2022 09:36, Hangyu Hua wrote:
> [1] commit 1680939e9ecf ("rpmsg: virtio: Fix possible double free in
> rpmsg_virtio_add_ctrl_dev()")
> [2] commit c2eecefec5df ("rpmsg: virtio: Fix possible double free in
> rpmsg_probe()")
> [3] commit bb17d110cbf2 ("rpmsg: Fix calling device_lock() on
> non-initialized device")

I think only the last [3] introduced it, because it's the commit missing
put_device in first error path.

> 
> The above three patches merged at the same time introduced a new bug.
> [1] and [2] make rpmsg_ns_register_device and rpmsg_ctrldev_register_device
> need to call the callback function internally to free vch when it fails.
> [3] has an error return path not handled vch.
> 
> Fix this by adding a put_device() to the error path.
> 
> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
