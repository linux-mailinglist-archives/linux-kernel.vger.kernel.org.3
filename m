Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101A4B24A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbiBKLol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiBKLoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:44:39 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18BEA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:44:39 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0576A3F1B4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644579878;
        bh=ecHVwDlq+AQYKeIGcf4CvkI7mMqME8Svegbv9eL0bmA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IXlLL6OtfmBNivpUQXvoQnsXfGg/xds0/6qPxL9Rcg9KV00mIceMRzOgBggycQOjk
         cVpZeURair+Lb3f7VrgYdDSrms0SVrT75BMmnbxIJV69JZIUyUyqId8D+jsWNRgnZo
         Sz92XcVZ4MjhgmuKnnT+/dM9pLbOhnqEPoUskJfga/bK/5UDtOAgA9uU2Io5ZXsDpb
         SkL8rX9INOTOCFJh9Yg4VmpTwLskgPCNrZtiuIo2RrMeL/Pejb72kLAhpfTd7NvHz4
         LylNYwyaIEvmO8gpjP5yji7kwPfTLk3exsC12f/t5BShX2SjR2RkopCZhduCB9bhXV
         IAzMaX7OsmTNQ==
Received: by mail-ej1-f72.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso3972827eje.20
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ecHVwDlq+AQYKeIGcf4CvkI7mMqME8Svegbv9eL0bmA=;
        b=faXVgQql/rU09VS6VZQ3Y6FcQWw7cEPdqjPVVMucQG/te3LcYV0mIKZlyIfJRW0KJr
         PbygLvMop/EfcPvdqKT3/x/0q8tNg1fozpAl+T1Gk0T4vVgai4Mxqv6cmRjhYABX+ROC
         EV60vY88aSuKOWIr80Z61hIbWIca0LWR2aku+uQiigZbe8Hy6fcygaOM/8NNuyie6Nh8
         o74zfoN2x1F2ZlJlPl6+ZP2urMLEyHXznMNKS4RYYqs6McwbwTLotfcB6LprSXISp94z
         mU6jCTsI4LKN0vLc1sONdTW+M/GpdXmkmgeTnYpQSthY9dnYyXdDx/TjzVkUaRPYzt1E
         RxPw==
X-Gm-Message-State: AOAM532q75pxhPQxOoKMj9aBJFd9lWHB6qzBiy7AP8z9fpL0Dv1KOgdu
        wYwdlV3oNG+SU27RoiJNgHF2xKUkbfuSqVCdHid82y4VSbMXRJUgmrGNd6WDLm6aV+LIatNgjEG
        qN1Fg6knqA5e21leeJukRwpMINysVRBWNmeL9upG36A==
X-Received: by 2002:a17:907:c26:: with SMTP id ga38mr1032321ejc.626.1644579877733;
        Fri, 11 Feb 2022 03:44:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznqvvnq5wXIqGOsU+p8aV3YUjGCSFQ0QQ2p8CHvwjdn3oe9wCw8FEpPx+8TbAPH99rTQcjyA==
X-Received: by 2002:a17:907:c26:: with SMTP id ga38mr1032314ejc.626.1644579877581;
        Fri, 11 Feb 2022 03:44:37 -0800 (PST)
Received: from [192.168.0.99] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v28sm10808602edw.95.2022.02.11.03.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:44:37 -0800 (PST)
Message-ID: <bed10d2e-a3eb-ddcb-8b84-9b5ba7f138f1@canonical.com>
Date:   Fri, 11 Feb 2022 12:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/6] dt-bindings: spi: Add compatible for Mediatek IPM IP
 with quad mode
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220209111938.16137-1-leilk.liu@mediatek.com>
 <20220209111938.16137-4-leilk.liu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220209111938.16137-4-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2022 12:19, Leilk Liu wrote:
> This commit adds dt-binding documentation for
> Mediatek SPI IPM IP with quad mode.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>  1 file changed, 1 insertion(+)

Same comments as for patch 1 apply.


Best regards,
Krzysztof
