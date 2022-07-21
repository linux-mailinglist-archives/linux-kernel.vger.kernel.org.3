Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552DA57C69D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiGUIk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiGUIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:40:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA2357C3;
        Thu, 21 Jul 2022 01:40:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B895E66019C1;
        Thu, 21 Jul 2022 09:40:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658392834;
        bh=UkS0m/M5DvbbQ/GObPG5/kXK7jhZdM3ZkXjeCEHoCvo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Wnmud/HyoKxCMwupH5qw3uy/zD/ZJAYNNJeOIQLkvpFaLe3dFhwrg+J9cpDkqFtrc
         9/OGMoi7tmIR3zySfl6CrGRHaPeYRYi+3cKgTtKYy9/PBQM2IgagXmSrAG6gIejYth
         nmZMNyE4wSKs++BntTw0XBni+hZdexLJNKMK/M/ImDkWod+EpOqOsy5lS3q98HMGv9
         sqbJphzqjZ2tB5yZX7X85InhUyXxg6OrUsyPKk57h95EB62sXwpGLHx9bSfmKYZH1c
         IFXDk7zmNRC6odyxyZVp3M6O/jgbuofnF/3rDPK499SCRcmBnFDjrl5gq5eVIu87RF
         1QEJrnzzjgH2w==
Message-ID: <c5e94d12-4f52-2e75-3b45-735afa0e987b@collabora.com>
Date:   Thu, 21 Jul 2022 10:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/6] dt-bindings: mediatek,mt6779-keypad: add
 mediatek,double-keys
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-3-ef9fc29dbff4@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220720-mt8183-keypad-v1-3-ef9fc29dbff4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/22 16:48, Mattijs Korpershoek ha scritto:
> MediaTek keypad has 2 modes of detecting key events:
> - single key: each (row, column) can detect one key
> - double key: each (row, column) is a group of 2 keys
> 
> Currently, only single key detection is supported (by default)
> Add an optional property, mediatek,double-keys to support double
> key detection.
> 
> Double key support exists to minimize cost, since it reduces the number
> of pins required for physical keys.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> diff --git a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> index ca8ae40a73f7..03c9555849e5 100644
> --- a/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> +++ b/Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> @@ -49,6 +49,12 @@ properties:
>       maximum: 256
>       default: 16
>   
> +  mediatek,double-keys:
> +    description: |
> +      use double key matrix instead of single key
> +      when set, each (row,column) is a group that can detect 2 keys

We can make it shorter and (imo) easier to understand, like:

   mediatek,double-keys:

     description: Each (row, column) group has two keys

...also because, if we say that the group "can detect" two keys, it may be
creating a misunderstandment such as "if I press one key, it gives me two
different input events for two different keys.", which is something that
wouldn't make a lot of sense, would it? :-)

> +    type: boolean
> +
>   required:
>     - compatible
>     - reg

