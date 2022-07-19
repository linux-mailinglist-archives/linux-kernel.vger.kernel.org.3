Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4F5796F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiGSJ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiGSJs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:48:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2118345
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:48:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j1so16296121wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fxEunbvtjJ+LxZ4a2xf3X+bjabR6TCFGCAVV3qvZxYI=;
        b=e2bGRpQFZspL1e4wfu1On2MIo32EZkBifr9wMDjcH9QsQsAKC2+nvQoTLVBvLaCtVY
         n/KHbAPBvZRLSuWOqQEd+xcrAfLxD2fEIt1xP6Zc5ONjUTSf+WszbGs0UDiYSEGLC3H4
         F7ii/EHm2WfMF16GSG1P2rZc2wRsUCfIzA71El3LvLLYsJz/7ZNOOSvnCbLvXQcPWyTI
         PB/inVyz46uEwGjD74vhFoyNgC0oQJCv1NzNjkl3b9PhD+6Z6G3adpeKO5Nr8pXybNhn
         +NJKVvkaZKf/F2CBSUbs7oCSAU+Jo8O/C+6Vss7hz56w+KW/oS5muOUqWWQFALqIh5G4
         L/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fxEunbvtjJ+LxZ4a2xf3X+bjabR6TCFGCAVV3qvZxYI=;
        b=VJNZ8rpyQLlbx4eRPtENsRigP5GtJJj+8srGcuoL2viD0C6eKR45fL1raZsQckiA7R
         hvaGzePoBfHfqvpREhNpnuhJbu4ujYFM4dVlv3d4++tHeXpGE/J/b/k5Y919rJQIgxDj
         4TPnI5afgVo6lRDTTUuHvqzOSwELha/w64eAc3EnFBBf0PqHEa+UUXww7JEnJFYHbWll
         HXK3+Zq1VOI104kRy2gLZrCtfgR1vH9hQEABwuDPY/7wCb3JSF+N9DGmeaEPOmSY6ssI
         WFLhlM/mZ/NZclOEHtLYqTY5+wdBtIekolMcvsFc+AVWmXkZddzX+mXcym8jRyiEkHe4
         2KxQ==
X-Gm-Message-State: AJIora/GV06kMPYr8JsCkSnuGj7akaU5jkIzBtwHoYo7uSvLj4Od9uxi
        2/Yl6kzHOZy98XMy9G4N5SWoABMLerLZqA==
X-Google-Smtp-Source: AGRyM1s6iPtvnh0aEGTaAjjVj2dy9p20OhX63pqYiWQZchukcqmx9kVaXZ8Ag5a8woK2d0QDNYhzgw==
X-Received: by 2002:adf:d1cf:0:b0:21d:a2cd:522d with SMTP id b15-20020adfd1cf000000b0021da2cd522dmr25689643wrd.383.1658224104917;
        Tue, 19 Jul 2022 02:48:24 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c2e4700b003a03be171b1sm16965779wmf.43.2022.07.19.02.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:48:24 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:48:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: mfd: syscon: Update Lee Jones' email
 address
Message-ID: <YtZ95oTuXNfjjIGo@google.com>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-8-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714112533.539910-8-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022, Lee Jones wrote:

> Going forward, I'll be using my kernel.org for upstream work.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
