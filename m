Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8EC4CFFE8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiCGNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbiCGNZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:25:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60337DA81
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:24:23 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 277F63F222
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646659462;
        bh=TWixiBTEz7rcA6T3mO7kCyQ+X/3c1epPubayeGIJFlY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KhT2SXIg4hEZshD0ROWwDjCI37gNHAbw2WMQVMvMtuzA0nGe0puZlGxAdflf8uHq6
         0VaxoruV1JX5vR6H26G6nZ+YQ/4KMxZFnqx06dYSMFbF+io+Ekftt0sGuSR15tIMRu
         LtZ07KjyIkGbuN1rynr4K+B+LkGsE+IKrA/P+ah+Bzntqk7oojdMioqh7yicHD9qkd
         1ggj8Z6QNJxv3FrXWbu6Gz067qg+Q3mGS23YbP4MBtP17/QiIaGX1Y0f2pxe2Ac1bs
         fM4JdknGhTghCnhuedbvOrBuu7BFYr1Odk2gaAFTZnaAEWgSwqHLMeNbR/9/JcesM0
         201E5kjM/0F+A==
Received: by mail-ed1-f70.google.com with SMTP id cm27-20020a0564020c9b00b004137effc24bso8625288edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TWixiBTEz7rcA6T3mO7kCyQ+X/3c1epPubayeGIJFlY=;
        b=vgg5MMdapn5pxYAqeALCTu4FLCd7Kwwx2sf3cy+oCp9qXCxSNwiZvwnTKDBbiPmp0D
         qnesmgdkwLL0NJhkh+8FQFgA3aNrOsCE+VkA/un2hvvGSpa1bzgMjx3Tx/XoVlCBcXrp
         rBu25HzWBKLQJjt/sNxRjmor9O/igaZ/juei6khXbGekMynEWlgvOIZafrTCiuOAznKP
         g5Cc15/BftCtNXUIRUWhyk9xOOd3aBqWAe5JfeYnv+qeNGtuoNCsfHqOD0HyVfAujul4
         /95nAxbxNjAH0Nrc5bV6IJ6ZHd1PntfQWHKJPOY3svP7PaIbWdkxBdf7mGx19fuu+y2p
         ADug==
X-Gm-Message-State: AOAM532fcFDBBrAc9u/kANuLoOQsncQ4L1erdKFUByqp/t+lnaFpeQW1
        yviIQ4n7Jk+Pbr3YwUonmoR/gRaQOEl0kwzHJvSSduXHMS4vPcEcATxrYT+UCbZsOLWijoYf+aq
        yTONMpOws434R/ZRpoeMtQ4pkcjNf8HqBoRBhD7KlBQ==
X-Received: by 2002:a17:907:72c3:b0:6da:b4d1:415a with SMTP id du3-20020a17090772c300b006dab4d1415amr8875401ejc.709.1646659461910;
        Mon, 07 Mar 2022 05:24:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXFDqly0FiEeOHc3R4bhal9n6ckTpaeqOa1nkibv9p5B+fqdjoW3nuQz7GB8OTn482i+rCng==
X-Received: by 2002:a17:907:72c3:b0:6da:b4d1:415a with SMTP id du3-20020a17090772c300b006dab4d1415amr8875391ejc.709.1646659461759;
        Mon, 07 Mar 2022 05:24:21 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h17-20020a05640250d100b004162ee0a7aesm2787166edb.38.2022.03.07.05.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:24:20 -0800 (PST)
Message-ID: <a0b62141-0d5a-6b66-3238-eb5ba429644c@canonical.com>
Date:   Mon, 7 Mar 2022 14:24:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] dt-bindings: pwm: at91: Add SAMA7G5 compatible
 strings list
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        claudiu.beznea@microchip.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307130307.106102-1-sergiu.moga@microchip.com>
 <20220307130307.106102-3-sergiu.moga@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307130307.106102-3-sergiu.moga@microchip.com>
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

On 07/03/2022 14:03, Sergiu Moga wrote:
> Add compatible strings list for SAMA7G5.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  .../devicetree/bindings/pwm/atmel-pwm.yaml        | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
