Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C83E4CA29E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbiCBLA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiCBLAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:00:48 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4146D85C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:00:04 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 808023F5F7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646218800;
        bh=fYiIm7cAYvvcwgs5d23+mNowBlqk+U3OOhYGtWE4nhQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YLHxUnq8Pxh85hLX6lQhCJzzIB9+00Q5mCtP0UVUXZ3TgExTptykYTeqvES8IlOkt
         2FdYyxnU14uwOx6TwwJYXCvUfFGy/HVwFDeQ6+JEd0AuDWehut7308tm62lIh6wL9U
         xEj284NqESLWBawV4R2ct19lVf89D5IAKhLoz/I/mB7mW09tIOvax5CScMn0bwg7LO
         2QCiX787NUSp0Lozv8qPsBEnxz0ZYm4BsocJFI2JKEU2tUrs1kGWCWuMnCymtC1sxY
         gJ+3bvqn6OBp9W+zseKrazY4QH2E6MKAXNJu035e2G8YvJ56C/UR9Emq8D5kdCZCe+
         O8TJOGNcIbySg==
Received: by mail-ej1-f70.google.com with SMTP id j6-20020a170906830600b006d6e2eb61f7so792679ejx.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fYiIm7cAYvvcwgs5d23+mNowBlqk+U3OOhYGtWE4nhQ=;
        b=WRV9HSn95O2OEkfZpFyYzl8G9Z1ME49Up8ldg2dnQ0hvJxzTvmR7yIx31qAXq8ywFG
         KBJLtsUrzYoXIJ34cZa1ZRNlb/GW7E+H5kAzjRgwqc8PDegrUbre5/q9NHYq7C6tSrUG
         NBs5qyCBXTC7ECECkXJ2u470gt07oGn2A3+0RavmCJeUD+kCOaJjzzoWp0BD8B6PkZVi
         1cTlOrwVD5JkbPHpjEWuwEBJNvC5PLfx0uY5eSe8VDeQJKZa7rmdMQxsuQG/mh9PQjLl
         eQAH3BuI7fivCXA9e6ypzl9GXp1vsy99d6iUg0OTyKbB3uHnvrdh33AY8OYr5NutaZ7b
         lvWQ==
X-Gm-Message-State: AOAM531PSV7JaO93+DL3OEbUByuL40Bwt72Uf++kS8ImIRSW4EyY8Rgi
        PnRUROiZCucetGktRSYZ7EAVqYCFO1EDdAEsD8t+kax7fxOOf/YBX86hncp3iW+gGR+L/H9viDq
        kpK9CG0dWpKZNSBPzBYxMbLqSv0+1sszqBVZ3mgu5uA==
X-Received: by 2002:a17:906:af79:b0:6cf:6b3f:5b3b with SMTP id os25-20020a170906af7900b006cf6b3f5b3bmr22477701ejb.14.1646218800089;
        Wed, 02 Mar 2022 03:00:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwERV6fTesKj9iO1fvVCbS8f7t6+HOQi7nNSbBRmJKjBddmSjWjb4ufnflgk2FauT1UX0gr+w==
X-Received: by 2002:a17:906:af79:b0:6cf:6b3f:5b3b with SMTP id os25-20020a170906af7900b006cf6b3f5b3bmr22477682ejb.14.1646218799941;
        Wed, 02 Mar 2022 02:59:59 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id ey10-20020a1709070b8a00b006d1cb2eb221sm6274372ejc.170.2022.03.02.02.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 02:59:59 -0800 (PST)
Message-ID: <468d1c64-b954-dcdf-6660-74f51e29807c@canonical.com>
Date:   Wed, 2 Mar 2022 11:59:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Aw: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT
 bindings to yaml
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-2-linux@fw-web.de>
 <6dae47c3-6083-782e-ecab-7be3f0bca0e1@canonical.com>
 <trinity-80a229fb-42dd-4705-9c55-fe6f3a381a40-1646217098213@3c-app-gmx-bap21>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <trinity-80a229fb-42dd-4705-9c55-fe6f3a381a40-1646217098213@3c-app-gmx-bap21>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2022 11:31, Frank Wunderlich wrote:
> 
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/clock/berlin2q.h>
>>> +    sata@f7e90000 {
>>> +            compatible = "marvell,berlin2q-ahci", "generic-ahci";
>>> +            reg = <0xe90000 0x1000>;
>>
>> You still have wrong address.
> 
> only took the example from the txt, but i guess reg should be <0xf7e90000 0x1000>; ?
> 

Yes.


Best regards,
Krzysztof
