Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB84D1FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiCHSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243517AbiCHSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:06:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6D56413
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:05:49 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC6833F4C2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646762747;
        bh=fxacC+X8vGcG34HtZ40W460Prid6yVdnSvuBB2MttQg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=vMIhkQP5Qn6su+kC1hOKGlYY/ynMTm+GOGtDB/LCmtv3dAAcLx2OfiPo/XcCd0uLt
         3R12LTGxnqaz/IJdBzC219oS8Q83joHhuTPBqfhX4TEbOGeLLCZYmaDhEFnzlVRVtz
         nTatU5v/IqnHl/H7YT1MwwQlvyxkkfSUPJbuD7sV7iGj77b3zjilUr+NwPU5sszlmH
         2aLFRWw/X1TSsIHD3jZZIoVIl6oZ/HrQMWI6RwfuzoVKyop2tzIQ232yAN7zMHMsZW
         MMQwydrMlrITtDBpWNQ7NvHvraV6r85l4jAPBQ44Z7kQA7cs1KjjKwaOogUHjqjjf4
         Ml4+GLC/Ia22A==
Received: by mail-ed1-f69.google.com with SMTP id co2-20020a0564020c0200b00415f9fa6ca8so7585837edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fxacC+X8vGcG34HtZ40W460Prid6yVdnSvuBB2MttQg=;
        b=5VxivpF8Rto/FDGoxMMgzhWUGGeBny/cqLk5sLcm7CIl6G9OhkuOR9m23l7Xz4i3BI
         TGqtPV5HfHuTid0OTI7fv7EJTnISGMvR3VbOlMzDl8P143UQqQ/Ex1GmT+DtCy6qTnnd
         cQKnFIe9TtnucqWjS/pcHa54sRE6rQ0bUmQRRop7eil0Xrr2D4Vyg+Px7c7aYqyWRpuu
         akVngqcVFQtvTDqeaSLHajdrjOLIOuCUBvd43CgdSyAfIO76ZMwqFsLs/4RCCloJP8MQ
         o9MhUcCN9qZBohHvgYEFfwn92GAJLG60sRgWeex1FL4uWRlUgN5a7IJ1Z3NoMLF9WNPH
         zfzA==
X-Gm-Message-State: AOAM531KMp7rby1PGDEoadnetyVdqP0xO4zcNhI2FpoW1ObdARiDQmdd
        26TMimMCaE/X6vMlBs3LZDL3NuGfn5zPYNDlCFTYM0UXTWywO/qgmn8XJTBXqqJ1U57wgMCOVi7
        6pQPHrhXVb55PpZ7u7ozbIjirI1M734kq4U4vb6959Q==
X-Received: by 2002:a05:6402:27c9:b0:416:70e5:d655 with SMTP id c9-20020a05640227c900b0041670e5d655mr3923395ede.410.1646762747300;
        Tue, 08 Mar 2022 10:05:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5d/d+xm6Ot6fJtpnZgQ+JM9cB5VCZXtwrRwiowWcRB4VNvhr/RyYIAAt3oB9t0PwptC3WOw==
X-Received: by 2002:a05:6402:27c9:b0:416:70e5:d655 with SMTP id c9-20020a05640227c900b0041670e5d655mr3923256ede.410.1646762745914;
        Tue, 08 Mar 2022 10:05:45 -0800 (PST)
Received: from [192.168.0.144] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id n13-20020a1709062bcd00b006cf71d46a1csm6092052ejg.136.2022.03.08.10.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:05:45 -0800 (PST)
Message-ID: <c767eeb0-07d1-f6d5-4c63-969105194455@canonical.com>
Date:   Tue, 8 Mar 2022 19:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 03/15] dt-bindings: devfreq: rk3399_dmc: Fix Hz units
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lin Huang <hl@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20220308000945.706701-1-briannorris@chromium.org>
 <20220307160918.v3.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307160918.v3.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
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

On 08/03/2022 01:09, Brian Norris wrote:
> The driver and all downstream device trees [1] are using Hz units, but
> the document claims MHz. DRAM frequency for these systems can't possibly
> exceed 2^32-1 Hz, so the choice of unit doesn't really matter than much.
> 
> Rather than add unnecessary risk in getting the units wrong, let's just
> go with the unofficial convention and make the docs match reality.
> 
> A sub-1MHz frequency is extremely unlikely, so include a minimum in the
> schema, to help catch anybody who might have believed this was MHz.
> 
> [1] And notably, also those trying to upstream them:
> https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> 
> Changes in v3:
>  * Add Reviewed-by, Acked-by
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
