Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D464CB999
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiCCIwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiCCIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:51:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4DA175877
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:51:12 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6DB573F610
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646297471;
        bh=oNR1xncvu3qu9e99bCBj3dwVF0BkMGGG1dhnvvFNoac=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JZbYmzw/W8OKA8jYGTdQI3I39Zdu0GFCx1/Gdy6lgg+B7W62pZkaIRna/nLUNp/tY
         zpdcOcEzehOvIU2C5t0HGi1u5gxHt1EAETNbr/O0v/qw7EGqz63CbvyC4fP8uy72li
         6jmvps47AjA7TqDLwvfqFjiRqzNodUkOb7BRENcoUJPvzNfkzOcj/duEFOYq8nc0Ql
         hEoK1FHsAnzURF1eLjdXVaMT6Lq43X+JlyJZUurL12CS8S/og7ULGzMjj2gEyfoyz8
         RecNqIfMgXbRDAe+KHeSnRn0hEyUBNavcRGDYg3rMGN3pNeFcDl1zvOxUDj/KhJlHK
         JmuX494E3BiHw==
Received: by mail-wr1-f70.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so1752681wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oNR1xncvu3qu9e99bCBj3dwVF0BkMGGG1dhnvvFNoac=;
        b=wMWLewIx0SYuRffTbMQ2XPdUzaayVOobMXtZ1vx/u6jeCKZ9lrZ409/LfAf2qR8n8q
         mzQ1teQH7h1hB/GiQMINsK0GPTaq4OTHhXwUzil40qQu34DKd6afp8Bn5TeOaBkeZqKy
         kgl/GgxHPZIjO9CNEGRNRkWgBuZGhLZ8soO02rxFzlhlN9Delf/q0OMjj/J5+nt9w3XM
         uQzRhceCwg1WryeR9CdD/9tiVu+sUtWFek4mIxn1AvLn+yvXJ0sT18fQgHRiLnKsIb7T
         djbic0a3HFXtDVQcDFRKScL9zU2vQxPWObB90PkMufKTfI15hfjF2RjrG37w3m9YlMTL
         p9RA==
X-Gm-Message-State: AOAM531pNqpi36Nbbk2pWzkPO0IUb9v75Q03s9eO+PEyhvdvcjtB0CYr
        nKTjLrGPxpjSQvRPUHy9FacgHEwRnN7sqjchB6lO9uTe2nqKq2m/LCxXx15RgLcPY4yrHCQruQ5
        6W2abfXiLDoyXUocLqfqN4+KUcWEndYHW2/kL473Vmw==
X-Received: by 2002:adf:bc09:0:b0:1f0:2483:48b with SMTP id s9-20020adfbc09000000b001f02483048bmr6268546wrg.118.1646297468108;
        Thu, 03 Mar 2022 00:51:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwA4DWyqvBE/19fVpLvop30/yN6VpcN05Y2xu45Wxe3oLMpDg0yQrlkrZEwCwPDWIh6S2wwjw==
X-Received: by 2002:adf:bc09:0:b0:1f0:2483:48b with SMTP id s9-20020adfbc09000000b001f02483048bmr6268536wrg.118.1646297467942;
        Thu, 03 Mar 2022 00:51:07 -0800 (PST)
Received: from [192.168.0.137] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b001efd62a840dsm1483242wri.111.2022.03.03.00.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:51:07 -0800 (PST)
Message-ID: <2674d7af-56cd-b2fc-74d9-ade32ada7bf9@canonical.com>
Date:   Thu, 3 Mar 2022 09:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: kbuild: Support partial matches with
 DT_SCHEMA_FILES
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220228201006.1484903-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220228201006.1484903-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2022 21:10, Rob Herring wrote:
> DT_SCHEMA_FILES is currently restricted to a list of exact files with
> the full source tree path (i.e. Documentation/devicetree/bindings/...).
> Loosen this requirement and let DT_SCHEMA_FILES be a partial match.
> 
> With this, checking all schema files in a directory is possible:
> 
> $ make DT_SCHEMA_FILES=/gpio/ dt_binding_check
> 
> Or all schema files with 'qcom' in the path or filename:
> 
> $ make DT_SCHEMA_FILES=qcom dt_binding_check
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile        | 15 +++++----------
>  .../devicetree/bindings/writing-schema.rst        |  9 +++++----
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
