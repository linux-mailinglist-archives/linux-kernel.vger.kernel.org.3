Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A67C4D4364
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbiCJJXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbiCJJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:23:35 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10AD1AF23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:22:30 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF62E3F336
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646904149;
        bh=urZkMj1CVFHDmDBVJ94HruqSmh7h0kdRAgFJ0/wcFrI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=eC0pWIRIZ3ZKVY0UP6TqSKe5v0RkHI4hjZmxHw7J7rBYxa8hATx9s0qA5E4TmDOqy
         IQ7XMp5CtkIzqXpYMMWT920y4UkPSVtcjbp1xS/XoBhwwe0lX+TnmOdMpO6E8R91jH
         BS+F1xmAt3PLs/VtKp6pFk/7tHugbcA3aQDAYQFW0pVq6ozBbRJO2920VyYPxglCal
         0VJkeJCzl5+CLy2Wf9LQ2WRtdQSdNgDIa2z20v9mkzxaaCS3pL/IL8YHukbRPYRfnC
         ai9jl43Pl2JJzKyW12oLofuwhhkJ+3XE70C+0PkBGHlliuC+R71nUBhkc3St38SzQR
         Y+4CeAykp/ZDw==
Received: by mail-ej1-f71.google.com with SMTP id 13-20020a170906328d00b006982d0888a4so2764297ejw.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=urZkMj1CVFHDmDBVJ94HruqSmh7h0kdRAgFJ0/wcFrI=;
        b=P/YzO+Q29Dz8q4Vf8BVkxS8Jt2WydTJgSEGIRCy3wXM5t9yUg2Tr7jYdwDwM7ww0kB
         tJnWIdEJuGfQjFFOkmQTx3n0rBTxknl4CBZywCShrpa5uenSqtGbbkoJteCxbRVtXjXm
         R7gvEptREP14ZVpbfCs464uZXu1xbQNCyLP3T8G1+g+3rCcFsobkelQs7Tf9AKpH8A11
         71SA1FugQpipN8iDCSfdrbrG+EfOyl7i4Q0f3gShhS2Sc7NegJOI6zW4hjHTEu32oY+G
         f4GcRsJTy/iTBdFoRS2WnIkI7RlyIkDO3bJla4k0IjeWAyZguNgxXXT62wKjXXndQeDO
         8sKA==
X-Gm-Message-State: AOAM5323ewl7Z1l781sIFdVbZsm7UGSN60l531SjGDgXw+PFps8rshYk
        T/EfnC2i+1xiFF1YgqGiEfjLlW/5jkdZ6/cqRV84gED44VxCa095CnOeEf2x5Ip2jP/XDWyGnRg
        NLdmWav5yzmGCMPrHhB14QzdREPq0hK3L6mQAwvzNqQ==
X-Received: by 2002:a05:6402:5255:b0:416:6089:b23f with SMTP id t21-20020a056402525500b004166089b23fmr3275295edd.87.1646904148954;
        Thu, 10 Mar 2022 01:22:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8GzTU6l3uc5oXfjJxqxMo0SlXcIWmtaWXAFmIM5inJcUnvOtC5zOyN2yO3KsVjUmD5zVvMA==
X-Received: by 2002:a05:6402:5255:b0:416:6089:b23f with SMTP id t21-20020a056402525500b004166089b23fmr3275277edd.87.1646904148803;
        Thu, 10 Mar 2022 01:22:28 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402354600b004167d09f418sm1744200edd.55.2022.03.10.01.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 01:22:28 -0800 (PST)
Message-ID: <cb6f313d-7e02-2341-c1b2-f4dba8ad981d@canonical.com>
Date:   Thu, 10 Mar 2022 10:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 02/10] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>, robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de, stefan.wahren@i2se.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1646892810.git.qinjian@cqplus1.com>
 <7b9357809c002f6dd76c6fdd738a4ea8af62cb26.1646892810.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <7b9357809c002f6dd76c6fdd738a4ea8af62cb26.1646892810.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 07:28, Qin Jian wrote:
> This introduces bindings for boards based Sunplus SP7021 SoC.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Add SoC compatible: "sunplus,sp7021"
> ---
>  .../bindings/arm/sunplus,sp7021.yaml          | 28 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
