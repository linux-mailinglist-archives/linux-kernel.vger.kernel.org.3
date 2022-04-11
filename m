Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6B4FB1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbiDKCyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDKCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:53:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3BD55A6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:51:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o5so1380303pjr.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXMHDZ/wjPIXvL9nqfsrxMZkzmm8UuxVAONDINflarg=;
        b=AE76w0buips1IavXt8IqZhb/mkmazdyXyCp/cggM8TOunNklvkgT4lSsRzujLmLdE3
         476Yi8o85rpPXFHnov+x/BLI3qBaqVaaP6I4k4iLECAwuzFym8qZNIZbEP/WaSKDg6Zg
         Q3gO1XTRhmNyxHLz71bDze79BuvYZ4M53fsVYrBMjvPRw4FZhhWJB6p04pI8WUQU1wUF
         VS6JxUiB5uS9NezIa01SRAz5HYjTn9xC4rSa4gCrxokcMgDrVexzZAX9iJXsx6xLW0TK
         CSo+qBkDUpOfw17IEGKJH3+MaferjZI/1prH9OTR0qLrgBsw9ADJ367gVGLHIl088MBE
         6bVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXMHDZ/wjPIXvL9nqfsrxMZkzmm8UuxVAONDINflarg=;
        b=GNCNUKICiDsmm1BTvp2Idf2M67+SHe8npVlbcztKlio+ywdeIYEVxYs43Hp2BUWpRm
         HVb89Xf+l7LbFVOOHuNwOVrNj3nTWWWry1ykSKvI/aUEikiqtMZy/PxMrNUlTbaZ9J20
         PnIPrUm2HuC9tkRXVVPtPlqpSWkxodHuL1kZtraFgKcrxBmNnLQzlE/9bQAByZxzMwXJ
         zKgoHiyg2GqdFmAtO+VtlMNevC7foD6npSRV/l60M7Ruk998mEs0ZadRXAbTq3VOAuji
         R9qLQ0nk7biMFPoGKrsDT07vNtR5hAx/suUTuSzfRWSCgifI1bNpbBa6iLZ5xJ9PXPTy
         4ocg==
X-Gm-Message-State: AOAM5302kLs0bXkhYla+dZ8O3bkAeXnw7AQ/HbRIp17snBjmQ8gE6M/r
        nDZT5apDzEzW5HyOJMwgHqXtag==
X-Google-Smtp-Source: ABdhPJzGVKQR6w8pMxMmb2S23wGUZsQuhLLg7iNaBj4HpD8z37EDF1Ky46L9XugLcAZWFBAiFvYfIA==
X-Received: by 2002:a17:90b:4a4e:b0:1ca:c996:20dc with SMTP id lb14-20020a17090b4a4e00b001cac99620dcmr35062125pjb.98.1649645505104;
        Sun, 10 Apr 2022 19:51:45 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm9440536pfo.211.2022.04.10.19.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 19:51:44 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:21:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ARM: dts: align SPI NOR node name with dtschema
Message-ID: <20220411025142.uhdllnknn232h26f@vireshk-i7>
References: <20220407143027.294678-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407143027.294678-1-krzysztof.kozlowski@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-04-22, 16:30, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/spear1310-evb.dts              | 2 +-
>  arch/arm/boot/dts/spear1340-evb.dts              | 2 +-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
