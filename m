Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52C24AF33C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiBINsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiBINsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:48:19 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1312C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:48:22 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 63F853F19C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644414501;
        bh=Mu0uUPwtfbOpUWUMXTkPYrv76xELhcCbylOZUsI3OCI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ED8qzN5wQJe8CW1zwjnYc70jHmpFlOcj4eBgoqs8fbTwOUBntsjfNurTu57QVW4y2
         G9U76HX+cP8AEqctHbBEkWwNdN1575wAkwK0Pkc6sN23gAEPaPkAET8nYgSmX1DngG
         pOaSa2ogIGVFjRfY5tNs+Yp7f7ImzBaj0lcQ6xQTbKfVcKCNsa0+zSII8u6uTjE1mm
         vNFX1IKeoIP3nnqNoh5x7l0rbbxALhIA6uh5bTtq3WSB8z9s3wdOHJrC1BVbgl4P+m
         pC2mNVOgWMP6AJ6XexI4QdOvaYMwMoNbbaJWO1HQFRiaejVOSC0jY2YFQxHMTgPXFT
         MJWziB60ly6xQ==
Received: by mail-ej1-f72.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so1225264ejf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 05:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mu0uUPwtfbOpUWUMXTkPYrv76xELhcCbylOZUsI3OCI=;
        b=aJAoUH73CbrIRGPwdO41z1YJuWlKr4bzXJglc4bZ4/FTC+Phc0zNphydHsUjF+8cy4
         Sh2nK2xQVh8/n3XGPuV5F7CcnN0/pvDGwGJn6A+2zO31Dip22s4EgEn5rfUObEO3Z01t
         dRP8FkYrRwb2GHxVQ7DsDeG8fM4+4yWwojAJWqWYh5+R5EzQAl6uhwUYp41//WoCLsYP
         xBp7loKvwBuMxeNSem7jRLSqaB/dn6pnURKehuNRXsiCszSwXweGGiL6U5KNjKccB04h
         Vuo/tvzTPO+n/L5aohQdJOpJ6qfuJvww3QhhG+CRk0NZMxO0Cfg424f5qHECETiFy971
         E4rQ==
X-Gm-Message-State: AOAM531UPR4yuijPwiBhCMJPtC3TNQ/8zetbjXz42Pw70hq5mx9nRDC7
        9L5QEpGLH+oHRhbX55eYTyQoF8P8JpIsW00j0AgcK5r64aXSnUkVDd5goEg3fQH8htvnSzk7kO9
        NKWIgwx+ao2bvCaCPuQjVsrfipZW+4owVNf48bLmwQQ==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr2567133edp.229.1644414499419;
        Wed, 09 Feb 2022 05:48:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPJOczPsAbt78jg/uzyq90VVRYehbGtYxsyn5ZriTBP42R4TMVIvVzbcHG+m7PNorhEN3EBQ==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr2567116edp.229.1644414499248;
        Wed, 09 Feb 2022 05:48:19 -0800 (PST)
Received: from [192.168.0.94] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id j1sm2650879ejx.123.2022.02.09.05.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:48:18 -0800 (PST)
Message-ID: <081b64b0-3cf7-c318-20b4-07e65951fd32@canonical.com>
Date:   Wed, 9 Feb 2022 14:48:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 4/4] mailbox: imx: support i.MX93 S401 MU
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peng Fan <peng.fan@nxp.com>
References: <20220208063046.2265537-1-peng.fan@oss.nxp.com>
 <20220208063046.2265537-5-peng.fan@oss.nxp.com>
 <CAEnQRZA15UabGMSd_GjAdLXhidbVupz68Jh8CqVSYw-n+_4+=Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <CAEnQRZA15UabGMSd_GjAdLXhidbVupz68Jh8CqVSYw-n+_4+=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2022 13:46, Daniel Baluta wrote:
> Peng,
> 
> This patch is doing 3 things in one patch.
> 
> Please split this with one patch per functional change.

The third task - updating author - I just asked to squash with previous
patch because it really does not have sense on its own. Authorship and
copyright update are direct effect of new code. Therefore they are
usually squashed with the actual change.

> 
> On Wed, Feb 9, 2022 at 1:20 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> i.MX93 S401 MU support two interrupts: tx empty and rx full.
>>
>>  - Introduce a new flag IMX_MU_V2_IRQ for the dual interrupt case
>>  - Add i.MX93 S401 MU cfg
>>  - Update author and Copyright

Best regards,
Krzysztof
