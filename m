Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9382253EE30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiFFSxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiFFSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:53:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAFB23B701;
        Mon,  6 Jun 2022 11:53:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z9so1343319wmf.3;
        Mon, 06 Jun 2022 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l14UJVr8JeVd46Rnv0c3uT4zyDvuy4FY/KAjhGmnJ50=;
        b=Yzg9qn8BVYX07x33D0xN2x3wMGeNiLAKY0KZ81O9Vp9EQ+lLdNC5tENc1i6Mkt2TwD
         EDyQZotpqPwB2o6EQB3wiJSiSOsKxQ5nPTx6IXQcw6LyqbyriJdGvNC9CtEvnGss99Np
         ZyHfarMUzLQRQbzQSPIbylJL3QAvnw7ENg1Vahe87NBVMzgi1is8u8ioHwMg1KVmR9B/
         M6apwX5DSZs7LVzZ60odfiKmgBXC74H7++1/zLeD+/z6YIwxH/cU2wSLgbxvZt/uxpcl
         WZIHQ7pNDSUJkei7Jl5vMXzxOhLu5mZc6ue/N3tJFH+qY+27pGzeqc3oe9f43PcnP1GD
         j26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l14UJVr8JeVd46Rnv0c3uT4zyDvuy4FY/KAjhGmnJ50=;
        b=ULgCWF2gxC/A55vGKyMiAkbLsdhlp3UFHz5wPrBExVLn1XrogOKzHzCMkUMwAr7CQ7
         t72xQOSCXyQHOe9+hUlsXgTmi+vzwobq1mXFMUH+hSstokeCjSOTUFXhnSCEOi+YAN35
         eucA11X04U3l4MwST+IT/POBHKmMALig5dc37B/sDxGeqqftjATNGEjgE0FbUGzPiTTS
         5Mb+EFm15PaonrSjWiY61Yspf5djSIWBnsN60ajppJEmn6RpN2MvQs8ZbfptpidO3AYi
         y4L8z/yFwd8Pn4yEzUR5sNj0x0ol8/YYoaDg8Tojw5wYj0RB6kdhmSqWop5yqb+tdnae
         aJVw==
X-Gm-Message-State: AOAM533xNg/+4h12K//Mv+74qv23zEkn1YLX/osi0PlXxRHS263pUx9d
        /uhDKHiyLxQDdaFntGIj1eQ=
X-Google-Smtp-Source: ABdhPJywM3ZNrCCkFpfyK/jOUf7GfgVU2XbbjA36GrCrLfe1KwYeezpbsCRyMkYwa1ALsVcO7yjrmw==
X-Received: by 2002:a7b:c841:0:b0:394:890e:9195 with SMTP id c1-20020a7bc841000000b00394890e9195mr53972744wml.59.1654541598908;
        Mon, 06 Jun 2022 11:53:18 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id m4-20020a1c2604000000b0039c506de087sm3426516wmm.6.2022.06.06.11.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 11:53:18 -0700 (PDT)
Date:   Mon, 6 Jun 2022 20:53:13 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH -next] crypto: sun8i-ss - fix error return code in
 allocate_flows()
Message-ID: <Yp5NGVspV9dz1cxQ@Red>
References: <20220606134815.4103024-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606134815.4103024-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Jun 06, 2022 at 09:48:15PM +0800, Yang Yingliang a écrit :
> If devm_kmalloc() fails, it should return error code in allocate_flows()
> 
> Fixes: 8eec4563f152 ("crypto: sun8i-ss - do not allocate memory when handling hash requests")
> Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Hello

I am sorry, but Dan already send the same fix days ago.
https://lore.kernel.org/all/YpIc+FtQIOdm9Ub+@Red/T/

Regards
