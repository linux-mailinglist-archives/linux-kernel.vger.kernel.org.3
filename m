Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2193587B21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiHBK4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiHBK4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:56:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBCD102F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:56:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so21418814lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UbN6jiKFBX9si3SM5c3nDEeyT8d+xQL8LB23OeItQGs=;
        b=xGP8ARuEcU/pGrYXAMuXogjETiQGvO6LKtq16P/CdKEcY6FoGmH3tv9kefy6omFARl
         Yq76O/j+MXKsX2obVJhcuEfq57hTDeS2zDAK8lr1aXuG5MU6121yTJcp2bsaRkHLLZac
         HxpY905FngmUUKYMunpgBqNrniDs5UdFZ6J4nKYZrM0474o2idHohgcDAtFlyI7PQXoO
         PteJ7gTmx7fBrTVEtoBBzRaGeCT3TVZ1oT3oxhi8842MiKFKUHMw9hFeXWkP9YYVOcAc
         TbCB0Z3N4ScJaAzgLwllpWiPz0CxHdT0naeaYYAv8THzP3kE8IeaCzQgZF3/OL3BB2SJ
         RjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UbN6jiKFBX9si3SM5c3nDEeyT8d+xQL8LB23OeItQGs=;
        b=PsiFvo1LfA2aczLVVSJKeHDL0INwuY2zs+WVDva741ttfOaHCymh9O63SQ1GYysPVI
         lagdFKF6AotTseFncA4tSwKpH9XVjXSaLkfPUVyVmCegRVMsnwJUW/zusqWWbCBu2wCI
         +Q8HI0Zg8QdRI7MQZvtWr4aMnV6tN7ekhTXcTdb0c3Dd8o1eLDSK31TQIn5EQUxnspSX
         DhlC0XT8vZLFptwfrWz/H7tV9xw24qTB4vb32742gaHybC7tEmAoZ3a4ArRFaFAHOd16
         1IsaJoXLbSDD9nGQQpvieHQXxkg55nFdxmDUfmBC1LjjMKumP7H549fJKlFZTlqn/mqh
         GxCQ==
X-Gm-Message-State: AJIora9v9BNC5SM7dTUzvTEw2yjE56PkHZT7HVWbBrGirjxnPJ3Moz37
        q5GSaJsmsKZeusqKvkMvC8jcIA==
X-Google-Smtp-Source: AGRyM1sWQfz7Q7J81YoNB/znHMkITwL3mvZMFE/OwPlVKv9SK3yBIdl3TOSQM+vKPVLLwcKEOWYldA==
X-Received: by 2002:a05:6512:e90:b0:489:cd56:4610 with SMTP id bi16-20020a0565120e9000b00489cd564610mr7590188lfb.483.1659437776794;
        Tue, 02 Aug 2022 03:56:16 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id c7-20020a056512238700b0048af47aefecsm959582lfv.290.2022.08.02.03.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:56:16 -0700 (PDT)
Message-ID: <7b0d5f68-491e-ace4-5970-92ef795ec5a7@linaro.org>
Date:   Tue, 2 Aug 2022 12:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] drivers: bus: simple-pm-bus: Use clocks
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
References: <20220802071310.2650864-1-victor.liu@nxp.com>
 <20220802071310.2650864-3-victor.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802071310.2650864-3-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 09:13, Liu Ying wrote:
> Simple Power-Managed bus controller may need functional clock(s)
> to be enabled before child devices connected to the bus can be
> accessed.  Get the clock(s) as a bulk and enable/disable the
> clock(s) when the bus is being power managed.
> 
> One example is that Freescale i.MX8qxp pixel link MSI bus controller
> needs MSI clock and AHB clock to be enabled before accessing child
> devices.

No, because it is not simple bus anymore.


Best regards,
Krzysztof
