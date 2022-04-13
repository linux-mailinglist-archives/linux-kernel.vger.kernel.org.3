Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9CD4FF8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiDMOKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiDMOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:10:07 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5647A60DA9;
        Wed, 13 Apr 2022 07:07:43 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-dacc470e03so2112806fac.5;
        Wed, 13 Apr 2022 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UKzLfLfCt+WEluwz1wwvwPHsxgQjyqwG3A6e5VnilNk=;
        b=PzIgDBSNpY29BfEn2Jt4AehRJWAUZfDVzo+fLXfH2nSMZxu7hfHmmMIjqjAX5KaaZO
         5oexS3cHLB2gDecnzlgzwSRZwjYQxxH5MKxAytuUUes3K4RXa/O468cuMyhT/Jk3yNpg
         IzbG0dn61J7zETQDEg9Fv+YlqnSWWEyKBR19jNpbiLeQlD1WajGNKgaQ0siH91qQEkAO
         Goe1tFMvjggDJ0Tch1V7uVVlYHJkytt48rtg3BzCea96EY/9UTwfhWTYnO/QNBvajSM1
         lcsa0FiFLiJC5zq/IykfknRJChdCSbRhSH2Z6+KJTQYJD/vnv/j+ReyTcnqn5JNKK6wU
         evIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UKzLfLfCt+WEluwz1wwvwPHsxgQjyqwG3A6e5VnilNk=;
        b=7poaNks1TT9az5hRtrznR8sEKFuZBz0JusGpIbdgi+DoFLIthTh1AjmeSPMpq4AoQh
         rgdb/OrAo00sIipffabrI567yiTJ/nXsgt3QoIKcZFp90bOBQtLDECnbAPqEAipK45G3
         lYQ9Ek1lgIQY/m6CSWL61ttPhDB36hNcWO2XZEudwp0lIfAP1WbcZxYLpf7OaoXUq679
         J5WZKkm84Pmgf/KXyou6PoQXnKX4wz8Uo3e0xzZvL48GiYOl9B/KPSM9paUhhYY7QQQq
         t7v4o/IpLwwScNYqKUaQP1z/fFTiZ0tSRgcXbztaVObjQMACWQPe2OnlxSJVEvh//uMB
         fcxQ==
X-Gm-Message-State: AOAM533fMiPvqRYsxLuOC6FZqEB8SG1+GuLEN8L64YTvI3vf9bcb+Exg
        ZojyfO17+t7yf7QqzTWMFa7+kdn5vV8=
X-Google-Smtp-Source: ABdhPJw9FFIkkq+nUj4Pexdf0R6SMNRw5hbJ+xmfidoUdIkE07z7l/MQKwoHPp025QPIDVns1PkQYQ==
X-Received: by 2002:a05:6870:f713:b0:d2:8adb:aaeb with SMTP id ej19-20020a056870f71300b000d28adbaaebmr4343119oab.111.1649858862709;
        Wed, 13 Apr 2022 07:07:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g105-20020a9d12f2000000b005c961f9e119sm14583006otg.35.2022.04.13.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:07:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Apr 2022 07:07:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: ti,tmp421: Fix type for 'ti,n-factor'
Message-ID: <20220413140740.GA2398442@roeck-us.net>
References: <20220413134729.3112190-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413134729.3112190-1-robh@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:47:29AM -0500, Rob Herring wrote:
> 'ti,n-factor' is read as a 32-bit signed value, so the type and constraints
> are wrong. The same property is also defined for ti,tmp464 and is correct.
> 
> The constraints should also not be under 'items' as this property is not an
> array.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml
> index 36f649938fb7..a6f1fa75a67c 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp421.yaml
> @@ -58,10 +58,9 @@ patternProperties:
>          description: |
>            The value (two's complement) to be programmed in the channel specific N correction register.
>            For remote channels only.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        items:
> -          minimum: 0
> -          maximum: 255
> +        $ref: /schemas/types.yaml#/definitions/int32
> +        minimum: -128
> +        maximum: 127
>  
>      required:
>        - reg
