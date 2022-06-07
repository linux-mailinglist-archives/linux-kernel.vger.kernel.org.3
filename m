Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5280B53FF23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbiFGMmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiFGMml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:42:41 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F077B1C12E;
        Tue,  7 Jun 2022 05:42:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id y69so9902168oia.7;
        Tue, 07 Jun 2022 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGvCXSf2boVHG+SEDmAeJar4xtU6VDDoEHp+oz+UrKY=;
        b=MD/oW6+ucoiKHpSVEyT14TPkSJozC33M7hmnsLn72ym3u6xreo+iVBPGBn1FCoiCf8
         73FNykdBW953El5hU/NYefe2C/NtZuMo3sXu+5Z7l6P7Cr8h68dYQyJQAV6lSRUhAicb
         HrWPtaAJRKa4u1Pzox/WvZCMJ94PgYuZjX7poAM9Vv9dDdxtayArqiHNF6gmrGpEEBjh
         ZdI3mqk4fF8WOmOiH709OyibQTJuWzVHU1QL4RconJg+Dl9oJfHLK4iqbZW5WQtUIUzQ
         yQh4ttFxQBk5Bz+OLZU+56Dbu8OuVndadjmPwjYX8R08IRmDUoKBnCMnf0DzX0Pk4SIc
         5Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wGvCXSf2boVHG+SEDmAeJar4xtU6VDDoEHp+oz+UrKY=;
        b=qqnEb+1gwox8OuatJsTThPtPw7y15UZ8VT649f7RU2wxdPGrMAKfLgiMvgIkoER4ff
         I62zSePp50jDVbeLPjgkYvg+8GmPs/ulfNp753spu5byoE7YoqaHL3zVmnmlJk6sQfv6
         BaPu2NeXVBe8nFVCebWpObgzPJ5/1LM4pQN9blb2CSQtkHV+vrO06Cz2v7uBQk5EtPvf
         eOC6MKGlCmc81Lk+DSlfkOkxTNdRGOZPU46OoK70ga2GPHhGpgMLvl2ZOiLuX/L3cVTt
         efhr89HqeyduxtcNj4065VG+7VVBXuhZzzwaBKW4rcLd9gh//XRUODqPvWfoW6ZzTFDk
         2NJw==
X-Gm-Message-State: AOAM5302IIiihshn/sp6v1bC71T1xQqTrMQpti8xw0mJg1llfPOg8waF
        +m8TEICPF5m1vLt2xvBdpZI=
X-Google-Smtp-Source: ABdhPJzxYfj1j+c7qg6iUV3UNtndtgMcW7lNLS4xxHJSTNY2BsFxiVnfrsba/LEb7KD4ncZJJAmBrw==
X-Received: by 2002:a05:6808:1453:b0:32b:84a4:5a49 with SMTP id x19-20020a056808145300b0032b84a45a49mr34004235oiv.105.1654605757894;
        Tue, 07 Jun 2022 05:42:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13-20020aca240d000000b00326d2cba5d3sm9592935oic.8.2022.06.07.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 05:42:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Jun 2022 05:42:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Camel Guo <camel.guo@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: ti,tmp401: Drop 'items' from
 'ti,n-factor' property
Message-ID: <20220607124236.GA1786135@roeck-us.net>
References: <20220606212223.1360395-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606212223.1360395-1-robh@kernel.org>
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

On Mon, Jun 06, 2022 at 04:22:22PM -0500, Rob Herring wrote:
> 'ti,n-factor' is a scalar type, so 'items' should not be used as that is
> for arrays/matrix.
> 
> A pending meta-schema change will catch future cases.
> 
> Fixes: bd90c5b93950 ("dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x")
> Signed-off-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> index fe0ac08faa1a..0e8ddf0ad789 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp401.yaml
> @@ -40,9 +40,8 @@ properties:
>        value to be used for converting remote channel measurements to
>        temperature.
>      $ref: /schemas/types.yaml#/definitions/int32
> -    items:
> -      minimum: -128
> -      maximum: 127
> +    minimum: -128
> +    maximum: 127
>  
>    ti,beta-compensation:
>      description:
