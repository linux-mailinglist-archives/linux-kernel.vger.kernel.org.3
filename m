Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064165642B7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiGBU3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 16:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 16:29:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98BFBF5D;
        Sat,  2 Jul 2022 13:29:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e40so6885426eda.2;
        Sat, 02 Jul 2022 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OV+VH3ejxTOPhJCvTbtM9lAhiNsNlXfTZrLr2VYv0q0=;
        b=p6yaS1FSKTSFFsBMibD0IXB/DFpLrMLuxJoB/xOJqUUETATFYdIeuvRIPb6scPfoYG
         bSBoGR+QqhIYT3TWBWtAm0QuiVPumg+J6McmYxRjmBTl1k/1U61sqpCL1fGgnaUPjf80
         1YOYE4aw5YmfMDeRal07dHj0VObpCtPjQKAAkDWblzmqLGeE7myuyhoz9aMMvKljTqmF
         iShG3lBuPgvyrC9sC+jbLGpDnAZYc3QvtXMskZEPP/07Rx5yrT4VKILdlW0/NRj6m0Pj
         F6ZCY1pzkZ7VZf5UtMz/EvUIw25vP5aljBf7xdxxw1RQQhrgN6gtshZ9yimNcG13SH5a
         lmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OV+VH3ejxTOPhJCvTbtM9lAhiNsNlXfTZrLr2VYv0q0=;
        b=BpMLl41tXDFjMqWiIMfGEmwQr/jIA6C7gATQD6HHqyOgtb/VCTy2dRRPQnq6DvDbd6
         +1iB55AP8k8GACSJ7CXo1vwyjWS26c5AzLPQZ/9PMtXcWgu47KurXn4r1SFp7dT9gdco
         wGIxgjas6H7NWg/QpcJRw1d0QGNNOykpRaAH3lH4DOt6ZxVBHu+9GK86ZDok2Z+q1JEE
         aaih5F9I5OdD+a8GasAjDuuLn+uxIYSi89czZRQi710FHOFHnWGoSDRw+c8bzHu2WzT2
         juxtSrGtNXuxntJNrhj3s49pU4B9h3lBYVGipf+xxhSrAWmHfZGtH3ascSjY9ExZlAah
         FaIw==
X-Gm-Message-State: AJIora9ZHOeFllNQ+oMhJ8N9pjplWxkh2ApBeljOo0wWJyeP1lcocId5
        wUsPwr/DVXuMz/IqQMZXUJE=
X-Google-Smtp-Source: AGRyM1uKvqc3mvz9z8LqDdfV/Fy8cu02zPY3BhLSn/f525LA7ITVIhC/aHi3rQLrgIafrQHlFTnG6Q==
X-Received: by 2002:a50:fd16:0:b0:435:9170:8e2c with SMTP id i22-20020a50fd16000000b0043591708e2cmr27500981eds.216.1656793777413;
        Sat, 02 Jul 2022 13:29:37 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id g20-20020a50d5d4000000b0042617ba63c2sm17553929edj.76.2022.07.02.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 13:29:36 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/6] pinctrl: sunxi: Refactor register/offset calculation
Date:   Sat, 02 Jul 2022 22:29:35 +0200
Message-ID: <2116734.Icojqenx9y@jernej-laptop>
In-Reply-To: <20220626021148.56740-5-samuel@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org> <20220626021148.56740-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 26. junij 2022 ob 04:11:45 CEST je Samuel Holland napisal(a):
> Starting with the D1/D1s/T113 SoC, Allwinner changed the layout of the
> pinctrl registers. This new layout widens the drive level field, which
> affects the pull register offset and the overall bank size.
> 
> As a first step to support this, combine the register and offset
> calculation functions, and refactor the math to depend on one constant
> for field widths instead of three. This minimizes the code size impact
> of making some of the factors dynamic.
> 
> While rewriting these functions, move them to the implementation file,
> since that is the only file where they are used. And make the comment
> more generic, without mentioning specific offsets/sizes.
> 
> The callers are updated to expect a shifted mask, and to use consistent
> terminology (reg/shift/mask/val).
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Nice cleanup.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


