Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FE50C962
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiDWKxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiDWKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:53:41 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E31F8DB9;
        Sat, 23 Apr 2022 03:50:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f6so100186wma.0;
        Sat, 23 Apr 2022 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SCwRS2IZSctZE0rauI3WxmX9NRINEUqAAu3EKI6iWX8=;
        b=e/0d3hetA2x+tfxMeCxEPmJy5Cm4E94IJ8Ou5Us6keC9FpRQBjvm1HjxMJxoQGOosU
         d5JZ/MEq4iRD5Bk5MgBfiFJoSj/wpWpFHOkEABSAsal1PKGUhcqshJLRH1JeZ9W6696Y
         +ZhL0qyKoFDwhFebGpNKPBR6LkE/Zfd1vD9kzi6MnifctCj6RFUycJ063VPI48yNHy7D
         HxR+gBUvBWyiv2reIzaheMC7FEIBrzBtHOMt8R0enul2h5i+5Dy/xZy83EDLd6HwTDmj
         bjPgmDiBYUFFITot1ob5d0TodQaSTWTMy+y+ZPs68WwrBLvktWxuKGjfU9AorQ780aRP
         qUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SCwRS2IZSctZE0rauI3WxmX9NRINEUqAAu3EKI6iWX8=;
        b=SHmoPxVxeRSOZbRBa5GoZPsHLLMVcer3komLFgfCxVs2dnMuukJU12RUYQUJ/RzsNk
         Vr1EZ+FmI/vUhV8V9lpG3wWJtKVfmitag+2NrPRfwrEbbD3PifM4HdLd1+1p6DPb4gvB
         qlLF+tPrk6LRGzvyLkOAojqIQWONPtZvS1FlxrlO9QrrQO6auwfltVHbPZp4jhj9UOUf
         nEIfeqgCswA5m7kwTJbeDKHxHBjSLlZc+5tXRRU57Y1FslTGNNdZUJc1oLN6O8oamB5v
         MldH92PolIKbvQUVIXlRNgjOiH/btfW0RB6nzu7SnabaAke7XAFmuZ3RPOdGQ+pPOJEo
         qMvQ==
X-Gm-Message-State: AOAM530tmidQFureYlmghj7lUPrWmKlTBYTu79Ekqx+HapbQI7ULSWua
        Hz3AyHr/9nvFT9EYhcumKsw=
X-Google-Smtp-Source: ABdhPJwu4IKR06vKshXnmlBQEP5JWyFFpahFDrio3RAgTCbcTJuLwvGu1XPbRWXl3XBCKFf0lbsFvQ==
X-Received: by 2002:a05:600c:3541:b0:38f:5f3:3f4c with SMTP id i1-20020a05600c354100b0038f05f33f4cmr18110508wmq.158.1650711034419;
        Sat, 23 Apr 2022 03:50:34 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id t18-20020a05600c199200b0039291537cfesm6682792wmq.21.2022.04.23.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 03:50:34 -0700 (PDT)
Date:   Sat, 23 Apr 2022 12:50:31 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     cgel.zte@gmail.com
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] crypto: sun8i-ce: using pm_runtime_resume_and_get
 instead of pm_runtime_get_sync
Message-ID: <YmPZ91MQEVTn+DrY@Red>
References: <20220420030218.2575565-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420030218.2575565-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 20, 2022 at 03:02:18AM +0000, cgel.zte@gmail.com a écrit :
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Thanks for your patch

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Regards
