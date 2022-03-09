Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE214D2C30
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiCIJgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCIJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:36:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A789A6519
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:35:37 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDA5F3F1FC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646818535;
        bh=vZNj5AOQLPTuv9G9otKx/fIrGoW3MMRzM1nMje3Rtek=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Zo01VIQ9JO2uFZDHCKLby/yT3BJGb/t16uEaH4pYB/urGn1Fp49gLVI/X2DZTsbEo
         5AKfIE2MJJAUhJOMuUyUH7z7lGvvD0l4DKCf+tCp1j5cV0hT5Otx2pzx4BgovEpcoz
         GocvWy8ySa8mOc+Oa+CDGDMHXh+h5jp6mbL29zk9BylXm8fXQ7MsIPrUvoGZ/qy9un
         5YXPkghy/zl40Mm6GtIhVvB0GbIAJ0PPPf2rX1IslMOmwldfyizX2/kMz/BWttNsOU
         vhwcNeDwMvZhU37/QCO7sMcqAnJ61eJIfxDtm/xqdfC4ipOq7xY5xBOHL4+zU5d0Qe
         xDue8wH2HHmvw==
Received: by mail-ej1-f70.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so987987ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vZNj5AOQLPTuv9G9otKx/fIrGoW3MMRzM1nMje3Rtek=;
        b=HCVlpVFCUhhiKH/lazBF+tl/uIuBJes5e5eXjTJ8fKzaNKChu1yJXfqhnb61rsJbdH
         MnMdSnsR9yHY2wfyYBwDSNUXGRQB7SHi48sHDK9DEY3SfubjSJnI2JO3gfaMOXIaxIQG
         03Q8jCF46c5hSM9qdVmfy6HmELmRJA3qpkAOcATNPM0TGQXM48MvUG9GNnyNKJhC7dtn
         ziek+Rsa7Ku4BtdYCrg1gSkEa4AM9V6hPvtsctu3Qi6nTmYNVqTXsHRuJ+AvCC7omlEc
         fqJDU/BB0gR4BXSJpLp8BU1R2+PVZxY+WoYEiXJHxl5tE38/cVsNB4Zl0QvFjx3ON+3S
         t49g==
X-Gm-Message-State: AOAM530ouQgKZOVjuGyVe19z7pCkxpMA+mzgDDcd9WKZ+O/P0uBcFEyM
        cQKLmr66aawfOJ3SWSDRkwYhr9OoNqYL1kjCTEXVEritPVIxAVGk/EIa/0aWTiai/fcvB/qNPJX
        Wl1aSatLU/T5uxr0U6+jxKt8u0hqPt53uxguS99F6pg==
X-Received: by 2002:a05:6402:7cb:b0:415:f059:c817 with SMTP id u11-20020a05640207cb00b00415f059c817mr20177215edy.364.1646818535452;
        Wed, 09 Mar 2022 01:35:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXuptgodm9OL5uPUDYx9cNzg0ceJIG4EMX1apioKtXckPfC/v1b6SG5RCfGXrS472kMiCZlw==
X-Received: by 2002:a05:6402:7cb:b0:415:f059:c817 with SMTP id u11-20020a05640207cb00b00415f059c817mr20177199edy.364.1646818535293;
        Wed, 09 Mar 2022 01:35:35 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906161900b006d43be5b95fsm510405ejd.118.2022.03.09.01.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 01:35:34 -0800 (PST)
Message-ID: <caf415f2-7b85-1653-7db1-623048a23b3e@canonical.com>
Date:   Wed, 9 Mar 2022 10:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: thermal: rzg2l-thermal: Document RZ/V2L
 bindings
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220308212315.4551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220308212315.4551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 22:23, Lad Prabhakar wrote:
> Document RZ/V2L TSU bindings. The TSU block on RZ/V2L is identical to one
> found on RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rzg2l-tsu" will be used as a fallback.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
