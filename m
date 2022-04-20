Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDC508490
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377154AbiDTJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352496AbiDTJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:13:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51402A279
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:10:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c6so1415581edn.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vruQdAbvoY8ZySkcCUSNHeiK4H5qxI2mjKPpZSKwKDA=;
        b=yYwFz4NEyjadwjRS4cd/eX6TuVsxTaOfJlXZ49MZEt7JvTQUALcLz6s1VZJrRRF+Sr
         gY1K0+7B6zXZ0j2ePrEFV+cVvH3naZdxZKZ87KzFeNZUReyskNWlP+1HLb9EJFp42h5u
         s87FLS8CQazebIgpT77o4+1UeDJ090Sgp8cdelxlGWpxh/od0w9tnr39FVz3FWGbUOcY
         /cWU+bh+QmOWlZ8aH7cUgvX8vcxydX+gB6/w6O3DTz5G2hiAFtqMsfiJeJTwcEmU9u6H
         ekL1+sLDoRF6zsDU8qcqoDwCmin8ujt0tSk9AHjj9Knihfdb7ivGWLMl1ZLsJMDEQYYi
         pLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vruQdAbvoY8ZySkcCUSNHeiK4H5qxI2mjKPpZSKwKDA=;
        b=LzYOpGoYLHyzK6b+C45CScDQXdIGyirTtfPti43mckjZwv+As8tMqjIhX+f4qDsPg5
         PppXw8CexUBQ244F4X2vH8yRFL/UqLVvIbRA2ClBjnd6p8M+GCfYLAToR1dUPihIurpm
         spYLkQJcjxJsFTP4LqZYjyBdqk31bJu4geN2wjWlQhoif6PF5xhpIvYudqSCFm224jbo
         wsDJJbpMyWt49tJKjn1xR8I7vKtyLG8PFHbV3C3uM7qv1dB5YXfaWiH7Tz7nGpmpWpyE
         7p7WWeX/1lYbJWR00/wLPYut2dds0QVbO7C6ryqO+jQZjUkDJmDWxojtoBuVBci117VT
         Y12g==
X-Gm-Message-State: AOAM5315cYgelziczdmmvAM1Y9yCGlMDwBNACBNihKz4Py/ErlSBOSs/
        SU3MqMjFjz1qs345ZhTrBJ5FJV17hy9Esw==
X-Google-Smtp-Source: ABdhPJzTsINDR3tEsSc+TCkrZrEKXI3qyvehRWfIM6LtMomWGJf4kqpv7c6PsY7r6gmqVB2vuUW6aw==
X-Received: by 2002:a05:6402:1f15:b0:41d:8bc2:6f09 with SMTP id b21-20020a0564021f1500b0041d8bc26f09mr22006255edb.143.1650445828254;
        Wed, 20 Apr 2022 02:10:28 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7d583000000b00420a8b66566sm9727057edq.97.2022.04.20.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:10:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>, openbmc@lists.ozlabs.org,
        Avi Fishman <avifishman70@gmail.com>
Subject: Re: [PATCH] ARM: dts: nuvoton: align SPI NOR node name with dtschema
Date:   Wed, 20 Apr 2022 11:10:16 +0200
Message-Id: <165044570802.75184.11931023841263750887.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407143127.295008-1-krzysztof.kozlowski@linaro.org>
References: <20220407143127.295008-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 16:31:27 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> 

Looks like no one wants to take this, so let me take care of it.

Applied, thanks!

[1/1] ARM: dts: nuvoton: align SPI NOR node name with dtschema
      commit: 967ef85d3e1de07f30e74c8454850c3c6fcd5ffd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
