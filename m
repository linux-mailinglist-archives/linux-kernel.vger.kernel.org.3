Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB894F11DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353399AbiDDJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiDDJUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:20:06 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40163B3D4;
        Mon,  4 Apr 2022 02:18:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k25so10437532iok.8;
        Mon, 04 Apr 2022 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnaFhwCYQRKWSH+CeXac4WqG9Xl8JMA4f5GGyBthARA=;
        b=OM0XkGIma7ffY2S1PmsiiXE0UWKkPQn0DhxmwB2NRmkgKaS2XttPCAefGJvp2SBMHr
         YCoCGmQ8DUMxaZqFE1R/3bjLIokY0sgVIPjAlx2bi3ZUqZNzsi3mVRPqlsza78d6zowO
         s3YiXPP0cTu/ZbVFgnF/vuEuVyOx35G46rmKOKqA7aHYaEg7rdgJKD+yDCukc6UYNn6m
         8P6fmXonD5Wb1bP/RZ42tvytZiRetlCfu1275s0rzuB3FQvzMyyG10aFgCvi0O5/p4zh
         R22LXf8qpGTNzR8i3lOD9+y9eCuE9g3vITwNNePGgInZ3yeda+62vtd9paQl9sOxltAM
         vmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnaFhwCYQRKWSH+CeXac4WqG9Xl8JMA4f5GGyBthARA=;
        b=esjHaJf9s+4EYUc22TSO7xd1cUwDpYGf0VKmxOf250dSjcp8UhsbIWZYFvvFO+0Ryx
         v2a180WTr7xLpQlqSrN/fDxxmbNIuzsMbtpcmTtwoD3gCvq66TChiDSyRbwEwS7C9SOo
         GocHmd+nsL66ASWBgfkxzSz1+M6z88PL53JoZJHBJL+LFrrfO3/WrXjqjrBn8r36RFwA
         aqF02GOYvAuHElTgdEsO/sxjONmdXAZkkIyFFkqkLPa4xijy+BvO3cpP+6ODOSx4/KFX
         +QUpC67hGbTyWo+hs0Cg07M4GDfCXFCuazFObeWxjnsJeCBGMVCTvnM1WFmoN5Hcr01j
         8Quw==
X-Gm-Message-State: AOAM5317cowa+nybl5hkNZ8MImP0Xpcl4gEM6/gMMbyIxORh+mg7ULAX
        S5gmUVmTlATrxShknflmMMoklH6k9rj+uXDxqGV4XANrNAKlt9blDNoUUQ==
X-Google-Smtp-Source: ABdhPJwk1obp4MUEJ6Ns1yJyfhGQSi+qsYFyZKkkGsHXlVIW1zk9zcdQAeQYY7sPN3ShTR1WQ3jghmwju5nGv2ueg5g=
X-Received: by 2002:a05:6638:438e:b0:323:8ec2:e177 with SMTP id
 bo14-20020a056638438e00b003238ec2e177mr11404567jab.164.1649063890353; Mon, 04
 Apr 2022 02:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220404040153.1509966-1-gch981213@gmail.com> <20220404040153.1509966-3-gch981213@gmail.com>
 <20220404095937.20089db7@xps13> <CAJsYDVK6ya7FR90CtAjbpbF-_+c0GVnsKsN=1wYaoBFx=ysUtQ@mail.gmail.com>
In-Reply-To: <CAJsYDVK6ya7FR90CtAjbpbF-_+c0GVnsKsN=1wYaoBFx=ysUtQ@mail.gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 4 Apr 2022 17:17:59 +0800
Message-ID: <CAJsYDVLaaGhD6wRvoQokPUQYBvSpN2kZ1kMMw4Z0fCZnHOVYWw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] spi: add driver for MTK SPI NAND Flash Interface
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Apr 4, 2022 at 5:13 PM Chuanhong Guo <gch981213@gmail.com> wrote:
> [...]
> I can implement the following:
> 1. select the minimum capability exceeding ecc.user_conf
> 2. If that doesn't exist, use the calculated one and warn
>    if it doesn't meet ecc.requirements

I mean If there is no ecc.user_conf in the 2nd case :)

> Is this OK?

-- 
Regards,
Chuanhong Guo
