Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0778B519A53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346601AbiEDIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243930AbiEDIv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:51:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBDC24BE0
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:47:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y3so1511451ejo.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=6f1dDCVmeyq91xhXZCZayQyn+IZwU2L4aZ+Foq78eA4=;
        b=tmFZC8fD0Q56/y2iWBYOsKJY0o2MUehHpKVtve/rmhYh5x/7PbwoBdgaC8XLZgD+hE
         fMIBNqBYry6FkCKA2vZ6qAWwRS+vbfplUyvchQSYAsde/5N11REnwbkj65150Xb0BXtv
         TnGOSSDu23VUScaUMx1vIkmabyrZ2WkecZCbrnD/vZzxTGLZQsMvU9AvSMYl38kJGrah
         1a/DEMKlgKYFNaj+cCJXxz5lQ6cBLS0KPH8HTbIWcgpUHm4VeHd2m5wbku6XTNtNL2II
         myyFcR6JGjr14fVtveiWgC3sjCnDHRwtPI/Byf7m58lM8jJHJP70qrYXIo5gis2hWngm
         w+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6f1dDCVmeyq91xhXZCZayQyn+IZwU2L4aZ+Foq78eA4=;
        b=zej6jRUXCM78mMPWazon+eMr5HMOlxVW8bDp/2Yin+4Mty7VoNMTwq+z4zFtU5dQ+t
         HHwp3IHZTJuAY9WC5huBytaiz9bbwbelvmjyzy73qpuSGIRnuQY2cMvBrNfa3MYOTJx/
         KiPUNs4CxFVW6QGouT5q9U6CYhvnZBtk2vo7DiNGfAnkB0gnOTGtzWH5ZypCQOUgaUTx
         zIfE6gPDUzEuEpA8BRfHCq8Uo3XLSXZ9Wxe3RFlSkt8UhoY5yfkwDg98fZ+QhuL/zF8r
         hbtnRbqHns4c37dVpb+39T9y1fssv/2/CVufjh7q+09CFZE6ML7Dhg9eE2qyCz6Q8BYW
         5tcQ==
X-Gm-Message-State: AOAM533VpZfb4JGFN6Un2Yi6SFNuz1WgUDzAXIJEHphhBx/Nf9dM+Hzh
        DrqvHc6I69Xc/RZQp5snz7SroyCcqkF8pw==
X-Google-Smtp-Source: ABdhPJzTuUXZBXabjBTqCkCCerSU7CeFyLjRBzDtRGc7Ho1xl58OdSJcNj30Fj6JPJEt2c2wsY2Wvw==
X-Received: by 2002:a17:906:c110:b0:6e0:dc2a:3393 with SMTP id do16-20020a170906c11000b006e0dc2a3393mr19274768ejc.512.1651654071403;
        Wed, 04 May 2022 01:47:51 -0700 (PDT)
Received: from [192.168.0.210] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv3-20020a1709072bc300b006f3ef214db7sm5542893ejc.29.2022.05.04.01.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 01:47:50 -0700 (PDT)
Message-ID: <0793b555-b734-7a45-ba1e-c525c9a95d41@linaro.org>
Date:   Wed, 4 May 2022 10:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PM: Domains: Extend dev_pm_domain_detach() doc
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401084950.118998-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401084950.118998-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2022 10:49, Krzysztof Kozlowski wrote:
> Mention all domain attach menthods which dev_pm_domain_detach()
> reverses.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Any comments on this patch?

Best regards,
Krzysztof
