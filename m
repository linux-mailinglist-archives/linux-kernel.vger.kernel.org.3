Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70FF4D41A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 08:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239755AbiCJHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 02:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiCJHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 02:15:54 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB78ACEA1F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 23:14:53 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 136A63F32D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646896490;
        bh=3lq+YZlfctpY1z6cHd0Yn3IlZgGEVfZmuX5LYYiOwRA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=UVVSfnbsGfW/D0mambzX7tsNEW4Sc21CqvOn8JTdvUg/p7mvQPULL77VBjU0oOweH
         lxRmq+zp5LYlay66JYQp3GLZJsVO8kpkc9XUZmVEFBgIFjtSL50JoW0oWmg+Z4VSHR
         pPviFgxnv6dgB85/Hooup7IsBynm206X17XJ6AmHFgfk5c1XM1QBVoSYDgqI4lSaCO
         eQTIf3V7uKsj6rvhHxHpCzzguU0g8FMSNP5krdAzpIpzvrtafg3ILBVl7shBc4uYbu
         bTwjsgPOFfUHkTpBQkY17hkP81wp+ZTu/z5w5/Mhe5KwGCmLmtLnGTIkOecpzwhk3q
         gu5OKi4CKp0FA==
Received: by mail-ej1-f71.google.com with SMTP id le4-20020a170907170400b006dab546bc40so2600015ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 23:14:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3lq+YZlfctpY1z6cHd0Yn3IlZgGEVfZmuX5LYYiOwRA=;
        b=sA9vMMmOu96IFTELTIfyhGGpLP2G9NExmd0SEoI1AhSLsd9LR+YP7uDtB7AHzhDlXf
         6RDWROxkOmW+qFKr61c3xPEvdBro4D6a2LjBB9fI7TS/2cZtiv0QR44uS4e7+uQBoWjC
         qgbz8NzI0W4E2c2jDjJrRuKhpcTkrhFFMbcw6jVIou70yxvcBSqcRYcTg9/YmZec7t5L
         Mdyv0ELJdOsMRADDfV2knzMQoglMVJwe45Rjd7GrGOUBAxwPXI23hFODTOQhgK9DD4Bo
         /RU8r3EBfFiNckpS67b5uPLC+iLsONFmOWXTDyImf3fccrFCyUjfaN4FhpKZAIvlpSH2
         wDTQ==
X-Gm-Message-State: AOAM532Y/pu+2faW13JcEjQj7hwKPlRWWOGdeEZcntAY7jCxUoSPBmyt
        SfDmI2hQDN36GoXVy0nk4s5wFHRcbthVm4mqgcwsU/Plb0R6pPL9ILZp1YqdVosjJROUvGEJt34
        kAwffmsJxH7SdBFe33dHYLbpZuWVSNi1Qcw+WXX03zA==
X-Received: by 2002:a17:907:6d1d:b0:6cf:3fa:4d80 with SMTP id sa29-20020a1709076d1d00b006cf03fa4d80mr2904077ejc.544.1646896489025;
        Wed, 09 Mar 2022 23:14:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnwsw6g5oiyOOkT6oGQB0u27Xh3SNk1CQGJAFJtCdISidk+n7aFZeumpAEYylkhSZcU/i4kQ==
X-Received: by 2002:a17:907:6d1d:b0:6cf:3fa:4d80 with SMTP id sa29-20020a1709076d1d00b006cf03fa4d80mr2904065ejc.544.1646896488861;
        Wed, 09 Mar 2022 23:14:48 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906261800b006da94c9ccc9sm1479713ejc.129.2022.03.09.23.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 23:14:48 -0800 (PST)
Message-ID: <12c31919-c393-8c54-7618-ea767c82470b@canonical.com>
Date:   Thu, 10 Mar 2022 08:14:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add artpec8 compatible string
 for exynos-thermal
Content-Language: en-US
To:     hypmean.kim@samsung.com, "bzolnier@gmail.com" <bzolnier@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220310013129epcas3p1110cbdfbd3d72ade45b8d98433ca0aac@epcms2p8>
 <20220310015655epcms2p843397a4c9e6707f1e862b2d00751d8f6@epcms2p8>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220310015655epcms2p843397a4c9e6707f1e862b2d00751d8f6@epcms2p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2022 02:56, Sang Min Kim wrote:
>  
> Extend the exynos-thermal dt bindings document to include compatible
> string supporting artpec8 SoC.

Your formatting is wrong, but at least this is not HTML...

s/compatible string supporting artpec8/compatible for Artpec-8 SoC/


Best regards,
Krzysztof
