Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E445A27F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbiHZMql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbiHZMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:46:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78EBC0E7C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:46:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso784399wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=K5ruSlY1jCvxqbhtszXYEzO5axSbMBdWGm1jX5xAIDI=;
        b=YDhK5SvJSWefqjsU2WPYj++ObRCDvVYTmwFRnA9yR2lyyCR/tnH5aDqVujU6uS9zMX
         m1qcVILMZ8TblSKP0hyA1JtbrsrYTDSiBDgAB+03OxNYGbKOB6vknSaDxKmoJYo+y2Hk
         kpoqO3qwq4EgS09hnQpN38xfu3gFTSWN36g0IIjZ+xTwjw/OufrYn+NWqzg0GXErZpNd
         jpi0BqbNCvTEvyMD0zA0+kc3Dp0wKrkpqOPEO53z6tdwdb9Ye15gXk/MMB8rPnIb8FHY
         ioOE6r+ywIRMauqPNdeG7rokoPe8SdXkGsFYRZ/QBF2powrJpXM5o+51PGzFQ4+MhrGN
         jyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=K5ruSlY1jCvxqbhtszXYEzO5axSbMBdWGm1jX5xAIDI=;
        b=2TcvI9TZpLICCY9MbOnlcsYU4F8G/BZeipPbYaiDzUV0ZFpPZtpsuzxJLxu6oU+oGp
         eCwpzOlocctNNYBLrkMc0qMJYX/rSoFfEe3K80nb4V2EBebpwboTsUDAjNuIFvvD58Ku
         rxmsiJJWh03w/yKY2mcmJd0950LgFV6UfjecWr82MBw1lXcYNIQlLAqFHDHtS3QPN+04
         jeOmdMfsUOOid/w/ijVt5j8cfxmCvc7P5NDalOcRxaqEOEQ/a+rgWgdTXF1j/B+yZ9zg
         xlfgyMwEoYCgfbZvYuwV+JkyLuK2cyKL9xqSO+AWjQKeiujyLEmhBlC9DVMAaxsnCW+l
         eiWg==
X-Gm-Message-State: ACgBeo0SmhepWeSC7Ik3xUmBKEa1WiwH5/t2WpsP8QqDY5piP02Ao+c9
        XUfrsdKi2MLRAtQo0vcfqj/r/w==
X-Google-Smtp-Source: AA6agR47p7+yUpwUH50t0SfB9kxiuFa+blrP6f9OaGblbuFJRK+GbTrAG/eZi4Vsn8YmOBmdlLEnKA==
X-Received: by 2002:a05:600c:22c8:b0:3a5:c134:1f50 with SMTP id 8-20020a05600c22c800b003a5c1341f50mr11466896wmg.55.1661517992442;
        Fri, 26 Aug 2022 05:46:32 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id b3-20020a5d4d83000000b0020fff0ea0a3sm1768406wru.116.2022.08.26.05.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:46:31 -0700 (PDT)
Date:   Fri, 26 Aug 2022 14:46:30 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v1 10/19] crypto: amlogic: Fix dma_map_sg error check
Message-ID: <YwjApjRZis69PI0S@Red>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
 <20220819060801.10443-11-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819060801.10443-11-jinpu.wang@ionos.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Aug 19, 2022 at 08:07:52AM +0200, Jack Wang a écrit :
> dma_map_sg return 0 on error.
> 
> Cc: Corentin Labbe <clabbe@baylibre.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-cipher.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 


Hello

Tested-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
Regards
