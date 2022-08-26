Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997D25A275A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbiHZMEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiHZMEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:04:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D226C2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:04:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso4298588wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=lMuxh+u8ZPUuuV+VRYCxHMNst2wA1aZBaMHjBXf1Wb0=;
        b=NrIlwDogoVusrYeDER/Y5XzVSP4Pyy5GaReZjXsbBM2a/WBgohQZDG/pTrfMNVS/9/
         zqtgJMl867mtXkfUTf0I9Uyk4aIBvLoGVj1U4rhUwkgECfq6XpxqAAv1408SJb58WhOn
         b377kg7MetcN4dta8H9PB4kfFDFnrI96fB/610X6BfZQj3f77Sg0ohGDlczirT5r7Vtz
         UTJaf6K7pG7Quah6fX1CBvJKuR8X6Y1TAxo0xz8JgR9iEkhWWyDgsQomfAb+vFURw1sb
         pQ2Vj9AhXkysV0J1J0Ld64Z0YJDb4GUFZIc65shH/o9q3rW8Wh+7D9Ax/eYqU4d85yml
         nkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=lMuxh+u8ZPUuuV+VRYCxHMNst2wA1aZBaMHjBXf1Wb0=;
        b=KCMIlrKlSVwAgapMGaOWkD+pBCMv2HQU2aVDr0W1KeEbpnWukrZkzPe8r58nwYASoG
         lZDcMiXJ//KVPH+sikesD8qeDdJmDLoQ1oYpPShghwhgNFwByP+cwt/aF/yXM3egl3YN
         DtyJY07U5VkvwrjJvzVMKd7icdpf1HXz2/dfjfCaG/EY9HrIx6qSfHennTJjJ6vQN2zZ
         K47pcIbNHyJiKdzF5yW7D0rLIGgtPFZeb96zdknXHPmrbbRW7a1jkrP0plDw5hNrPT5b
         BLXGgDTiGT6YYZgZMIvGcQQB17rlB8pOT2AXNnJPpEtisCyKqbX4gzIJilFkKlVbcYyD
         MWJQ==
X-Gm-Message-State: ACgBeo2TDLzE6qAIjHO97oD31LNRvnxzN/FywWaJ9nzym615vNHyO+ZF
        L3LrqTtA+6VFCGQTcCYR/QmG+A==
X-Google-Smtp-Source: AA6agR5qfYBnZ9sYPzunh5Co458jPKXXzym9qls5FamksX7v+4s/g+oCqH9kYnmDPnjxUZ4rHPfVmQ==
X-Received: by 2002:a7b:c391:0:b0:3a5:de98:f559 with SMTP id s17-20020a7bc391000000b003a5de98f559mr5078641wmj.157.1661515488133;
        Fri, 26 Aug 2022 05:04:48 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id j18-20020a05600c191200b003a5c1e916c8sm16903433wmq.1.2022.08.26.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:04:47 -0700 (PDT)
Date:   Fri, 26 Aug 2022 14:04:45 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 07/19] crypto: gemin: Fix error check for dma_map_sg
Message-ID: <Ywi23cKqPcJEWxHB@Red>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
 <20220819060801.10443-8-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819060801.10443-8-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Aug 19, 2022 at 08:07:49AM +0200, Jack Wang a écrit :
> dma_map_sg return 0 on error.
> 
> Cc: Corentin Labbe <clabbe@baylibre.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/crypto/gemini/sl3516-ce-cipher.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Hello

There is a typo in subject gemin -> gemini.

Acked-by: Corentin Labbe <clabbe@baylibre.com>
Tested-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
Regards
